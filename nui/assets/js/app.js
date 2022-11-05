const hackerphone = Vue.createApp({
    data() {
        return {
            lang: UMHackerPhone.Lang,
            cams: UMHackerPhone.Cams,
            carlists: [],
            userlists: [],
            togglephone: false,
            togglelock: false,
            phoneanim: false,
            vbool: false,
            vpage: false,
            upage: false,
            ubool: false,
            cbool: false,
            cpage: false,
            cambool: true,
            campage: true,
            hackblackout: false,
            timer: UMHackerPhone.BlackoutSeconds,
            interval: null,
            timerready : false,
            error: false,
            title: "",
            erroricon : "",
            name: "",
        }
    },
    methods: {
        eventHandler: function(e) {
        const d = e.data
        switch(d.nuimessage) {
            case "open":
                this.pageReset()
                this.error = false
                this.phoneanim = true
                this.togglephone = true
                this.title = `~$ root@${d.name} welcome!`
                // this.textSpeech(`welcome ${d.name} how are you today?`)
                this.name = d.name
                break;
            case "userlists":
                this.error = false
                this.title = `~$ root@${this.name} Target Phone connected!`
                this.ubool = true
                this.upage = true               
                this.userlists.push({targetname: d.uinfo.targetname, targetlastname: d.uinfo.targetlastname, targetdob: d.uinfo.targetdob, targetphone: d.uinfo.targetphone, targetbank: Math.floor(d.uinfo.targetbank)});
              break;
            case "vbool":
                this.vbool = true
                this.carlists.push({trackerid: 'Tracker - ' + d.vehicleinfo.vehicle, vehicleinfoplate: d.vehicleinfo.plate, vehicleinfoname: d.vehicleinfo.vehname, vehicleinfoengine: d.vehicleinfo.vehengine, vehicle: d.vehicleinfo.vehicle});
              break;
            case "cbool":
                this.cbool = true
              break;
            case "error":
                this.error = true
                this.title = `~$ root@${this.name} 602 Target Phone not found`
                this.erroricon = "fa-mobile-screen"
                this.pageReset()
              break;
          }
        },
        postMessage: function(url,data) {
	   fetch(`https://${GetParentResourceName()}/${url}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            })
		},
        pageCheck: function(variable,tvariable,page,icon) {
            if (this[variable]) {
                this.error = false
                this.title = `~$ root@${this.name} ${page} connected!`
                this.pageReset(tvariable)
            } else {
                this.error = true
                this.title = `~$ root@${this.name} 602 ${page} not found`
                this.erroricon = icon
                this.pageReset(tvariable)
            }
        },
        generalButton: function(task,id) {
            const x = document.getElementById(id);
            if (task === "toggle") {
                if (x.style.display === "none") {
                        x.style.display = "block";
                } else {
                        x.style.display = "none";
                }
            }else if (task === "delete") {
                x.remove()
            }
        },
        blackoutButton: function(post) {
            this.hackblackout = true
            if (!this.timerready) {
                this.postMessage(post)
                this.timerready = true
            this.interval = setInterval(() => {
                if (this.timer === 0) {
                    this.hackblackout = false
                    this.timerready = false
                    this.postMessage(post)
                    this.timer = UMHackerPhone.BlackoutSeconds
                  clearInterval(this.interval)                
                } else {
                  this.timer--
                }             
              }, 1000)
            }
        },
        vehicleExplosion: function(post,key,id) {
            this.postMessage(post,key)
            this.generalButton('delete',id)
        },
        playSound: function(data) {
            const audio = new Audio(`assets/sounds/${data}.mp3`)
            audio.volume = 0.2;
            audio.play();
        },
        pageReset: function(vari) {
          this.vpage = false
          this.cpage = false
          this.campage = false
          this.upage = false
          this[vari] = true 
        },
        // textSpeech: function(text) {
        //     const message = new SpeechSynthesisUtterance(text);
        //     message.lang = "en-US";
        //     const voices = speechSynthesis.getVoices().filter(voice => voice.lang === "en-US");
        //     message.voice = voices[0];
        //     speechSynthesis.speak(message);
        // },
        keyupHandler: function(e) {
            if (e.key == UMHackerPhone.CloseKey) {
                this.phoneanim = false
                this.postMessage('um-hackerphone:nuicallback:escape')
                setTimeout(() => {
                    this.togglephone = false;
                  }, 500)
              }
        },
    },
    mounted(){
        window.addEventListener('message',this.eventHandler);
        document.addEventListener('keyup', this.keyupHandler);
    },
    beforeUnmount() {
        window.removeEventListener('message', this.eventHandler);
        document.removeEventListener('keyup', this.keyupHandler);
    },
}).mount('.main')