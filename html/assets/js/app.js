var settings = {
    [1]: true,
    [2]: true,
    [3]: true,
    [4]: true,
    [5]: true,
    [6]: true,
    [7]: true,
    [8]: true,
    [9]: true,
    [10]: true,
    [11]: false,
}
var _timeOut;
$(() => {
    window.addEventListener('message', (e) => {
        var i = e.data
        switch (i.a) {
            case 'sSN':
                $('#server_name_1').text(i.name_1)
                $('#server_name_2').text(i.name_2)
                $('#server_logo, .announce_iwas_logo').attr('src', i.path)
                break
            case 'aOn':
                if (settings[10]) {
                    $('.weapon__container').fadeIn(300)
                    $('#weapon').text(i.weapon)
                    $('#ammo').html(`${i.clip}<font>/${i.max}</font>`)
                }
                break
            case 'aOff':
                if (settings[10]) $('.weapon__container').fadeOut(300)
                break
            case 'mC':
                var msg;
                if (i.t == 'plus') msg = '+$' + i.m
                else msg = '-$' + i.m
                $(`.${i.c} #change`).removeClass().fadeIn().addClass(i.t).text(msg)
                setTimeout(() => {
                    $(`.${i.c} #change`).fadeOut(300)
                }, 1500);
                break
            case 'h':
                $('#bank').text(`${i.b.toLocaleString('de-DE')}$`)
                $('#money').text(`${i.m.toLocaleString('de-DE')}$`)
                $('#job').text(i.j)
                $('#grade').text('RANG:' + i.g)
                $('#player_id').text(`#${i.i}`)
                break
            case 'p':
                $('.playerCount grey').text(i.p)
                $('.playerCount span').text(i.mp)
                break
            case 't':
                if (i.t) {
                    $('.right .voice_range p svg path').css('fill', '#00ff00')
                } else {
                    $('.right .voice_range p svg path').css('fill', '#fff')
                }
                break
            case 'vc':
                for (let v = 1; v <= i.r; v++) {
                    $('.circle_container').append(`<div id="v_${v}" class="circle"></div>`)
                }
                $(`.circle_container #v_1, #v_2`).addClass('active')
                break
            case 'v':
                $(`.circle_container .circle`).removeClass('active')
                for (let v = 1; v <= i.r; v++) {
                    $(`.circle_container #v_${v}`).addClass('active')
                }
                break
            case 'r':
                if (i.e) {
                    $('.right .radio .circle').addClass('active')
                } else {
                    $('.right .radio .circle').removeClass('active')
                }
                break
            case 'n':
                if (settings[7]) {
                    const data = Array.from(document.querySelector('.notifications__container').children);
                    const datavalue = data.map(element => { return element; });
                    var id = datavalue.length + 1
                    var sound = new Audio('assets/audio/click.mp3'); sound.volume = 0.2; sound.play();
                    var $html = $(`<div class="notification ${i.type}">
                <div id="icon">
                    <img src="assets/svg/${i.type}.svg">                 
                </div>
                <div id="line">
                    <div id="inner" class="__${id}"></div>
                </div>
                <div id="text">
                    <h1>${i.title}</h1>
                    <span>${i.text}</span>
                </div>
            </div>`)
                    $(".notifications__container").append($html);
                    document.querySelector(`.__${id}`).animate([
                        { height: '0%' }, { height: '100%' }
                    ], {
                        duration: i.time,
                        iterations: Infinity
                    });
                    setTimeout(() => {
                        $html.fadeOut(300);
                    }, i.time - 300);
                }
                break
            case 'a':
                const dataAn = Array.from(document.querySelector('.announce__container').children);
                const datavalueAn = dataAn.map(element => { return element; });
                var id = datavalueAn.length + 1
                var sound = new Audio('assets/audio/click.mp3'); sound.volume = 0.2; sound.play();
                var $html = $(`<div class="announce">
            <div id="icon">
                <img class="announce_iwas_logo" src="assets/svg/logo.svg">
            </div>
            <div id="line">
                <div id="inner" class="_a${id}"></div>
            </div>
            <span>${i.text}</span>
        </div>`)
                $(".announce__container").append($html);
                document.querySelector(`._a${id}`).animate([
                    { height: '0%' }, { height: '100%' }
                ], {
                    duration: i.time,
                    iterations: Infinity
                });
                setTimeout(() => {
                    $html.fadeOut(300);
                }, i.time - 300);
                break
            case 'sE':
                $('.press_E__container').fadeIn()
                $('.press_E__container span').text(i.m)
                break
            case 'hE':
                $('.press_E__container').fadeOut()
                break
            case 'sS':
                if (settings[3]) {
                    $('.speedo__container').fadeIn(100)
                    $('#speed').text(i.s)
                    $('#gear').text(i.g)
                    changeSpeed(100 / (300 / i.s));
                    changeFuel(100 / (100 / i.p));
                    changeRPM(i.r);
                    if (i.g == 0) $('#gear_img').css('opacity', '.5');
                    else $('#gear_img').css('opacity', '1');
                    if (i.l == 1) $('#lights').css('opacity', '1');
                    else $('#lights').css('opacity', '.5');
                    if (i.e == 1) $('#engine').css('opacity', '1');
                    else $('#engine').css('opacity', '.5');
                    if (i.d == 1) $('#doors').css('opacity', '1');
                    else $('#doors').css('opacity', '.5');
                } else $('.speedo__container').fadeOut(100)
                break
            case 'hS':
                $('.speedo__container').fadeOut(100)
                break
            case 'sP':
                startProgressbar(i.time)
                $('.progressbar__container #text').text(i.text)
                break
            case 'hP':
                stopProgressbar()
                break
            case 'hudSettings':
                if (i.open) $('.hud__settings').fadeIn(100);
                for (const k in i.settings) {
                    var id = parseInt(k) + 1
                    settings[id] = i.settings[id - 1]
                    if ((id != 10) || (id != 3));
                    else {
                        if (settings[id] == true) $(`#${id}`).fadeIn()
                        else $(`#${id}`).fadeOut();
                    }
                    $(`#check_${id}`).prop('checked', settings[id])
                }
                break
        }
    })
    window.addEventListener('keydown', (e) => {
        if (e.keyCode == 27) {
            $('.hud__settings').fadeOut(100)
            $.post(`https://${GetParentResourceName()}/close`)
        }
    })
    loopTime()
})

function startProgressbar(_) {
    if (_timeOut) { clearInterval(_timeOut) }
    $(".progressbar__container").show();
    var start = new Date();
    var maxTime = _;
    var timeoutVal = Math.floor(maxTime / 100);
    _timeOut = setInterval(() => {
        var now = new Date();
        var timeDiff = now.getTime() - start.getTime();
        var perc = Math.round((timeDiff / maxTime) * 100);
        $("#percent").text(perc + '%');
        $("#inner_bar").css('width', perc + '%');
        if (perc >= 100) {
            $(".progressbar__container").hide()
            if (_timeOut) { clearInterval(_timeOut) }
        }
    }, timeoutVal);
}

function stopProgressbar() {
    if (_timeOut) {
        clearInterval(_timeOut)
        $(".progressbar__container").hide()
    }
}

function changeSpeed(percent) {
    offsetSpeed = 245.31 + (383 - percent / 100 * 383);
    if (offsetSpeed > 245.31) {
        $('#speed-prog').css('stroke-dashoffset', offsetSpeed).css('stroke', 'var(--main-color)');
        if (offsetSpeed > 628.31) $('#speed-prog').css('stroke-dashoffset', 628.31);
    } else $('#speed-prog').css('stroke-dashoffset', 245.31).css('stroke', 'red');
}

function changeFuel(percent) {
    offsetFuel = 500.31 + (249 - percent / 100 * 249);
    if (offsetFuel > 500.31) {
        document.querySelector('#fuel-prog').style.strokeDashoffset = offsetFuel;
        if (offsetFuel > 750.31) document.querySelector('#fuel-prog').style.strokeDashoffset = 750.31;
    } else document.querySelector('#fuel-prog').style.strokeDashoffset = 500.31;
}

const setClasses = (int) => { for (let i = 1; i <= 20; i++) { $(`#rpm_${i}`).removeClass('active') }; for (let v = 1; v <= int; v++) { $(`#rpm_${v}`).addClass('active') } }
function changeRPM(rpm) {
    if (rpm > 0.1 && rpm < 5) { setClasses(1) } else if (rpm > 5 && rpm < 10) { setClasses(2) } else if (rpm > 10 && rpm < 15) { setClasses(3) } else if (rpm > 15 && rpm < 20) { setClasses(4) }
    else if (rpm > 20 && rpm < 25) { setClasses(5) } else if (rpm > 25 && rpm < 30) { setClasses(6) } else if (rpm > 30 && rpm < 35) { setClasses(7) } else if (rpm > 35 && rpm < 40) { setClasses(8) }
    else if (rpm > 40 && rpm < 45) { setClasses(9) } else if (rpm > 45 && rpm < 50) { setClasses(10) } else if (rpm > 50 && rpm < 55) { setClasses(11) } else if (rpm > 55 && rpm < 60) { setClasses(12) }
    else if (rpm > 60 && rpm < 65) { setClasses(13) } else if (rpm > 65 && rpm < 70) { setClasses(14) } else if (rpm > 70 && rpm < 75) { setClasses(15) } else if (rpm > 75 && rpm < 80) { setClasses(16) }
    else if (rpm > 80 && rpm < 85) { setClasses(17) } else if (rpm > 85 && rpm < 90) { setClasses(18) } else if (rpm > 90 && rpm < 95) { setClasses(19) } else if (rpm > 95) { setClasses(20) } else if (rpm < 0.1) setClasses(0)
    var percent = 320 / (100 / rpm)
    var unit = (92 + percent / 100 * 72)
    $('#arrow').css('rotate', `${unit}deg`)
}

const addZero = (i) => { if (i < 10) { i = "0" + i } return i }
function loopTime() {
    var d = new Date()
    $("#upper .date #time").text(`${addZero(d.getHours())}:${addZero(d.getMinutes())}`)
    $("#upper .date #date").text(`${addZero(d.getDate())}.${addZero((d.getMonth() + 1))}.${addZero(d.getFullYear())}`)
    setTimeout(() => { loopTime() }, 1000)
}

function hudSetting(id) {
    settings[id] = !settings[id]
    if ($(`#${id}`).css('display') == 'none' && settings[id]) $(`#${id}`).fadeIn();
    else $(`#${id}`).fadeOut();
    $.post(`https://${GetParentResourceName()}/hudSetting`, JSON.stringify({
        id: parseInt(id),
        bool: settings[id],
    }))
}