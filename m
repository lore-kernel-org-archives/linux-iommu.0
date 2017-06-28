From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 19:28:23 +0000
Message-ID: <BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
	<CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
	<20170505112706.7785948c@t450s.home>
	<CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
	<545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
	<CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
	<5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com>,
	<20170628130855.76c2b700@w520.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6742588826127363777=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628130855.76c2b700-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
Content-Language: en-CA
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6742588826127363777==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1348B4850D77192356D960E9E8DD0BN6PR12MB1348namp_"

--_000_BN6PR12MB1348B4850D77192356D960E9E8DD0BN6PR12MB1348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sent: June 28, 2017 3:08 PM
To: Suthikulpanit, Suravee
Cc: Steven Walter; Nick Sarnie; Paolo Bonzini; iommu-cunTk1MwBs9QetFLy7KEmy65B3kUBaIG@public.gmane.org=
.org; Matthias Ehrenfeuchter; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bridgman, John
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue

On Thu, 29 Jun 2017 01:53:57 +0700
Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:

> On 6/29/17 00:26, Steven Walter wrote:
> >> So, I'm trying to reproduce this issue on the Ryzen system w/ the foll=
owing
> >> setup:
> >>
> >>   * Host kernel v4.11 (with this patch https://lkml.org/lkml/2017/6/23=
/295)
> >>
> >>   * guest VM RHEL7.3
> >>
> >>   * guest graphic driver =3D radeon
> >>
> >>   * qemu-system-x86_64 --version
> >>     QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
> >>
> >>   * kvm-amd npt=3D1
> >>
> >>   * dGPU is 08:00.0 VGA compatible controller: Advanced Micro Devices,=
 Inc.
> >> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
> >>
> >>   * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host -bi=
os
> >> /usr/share/qemu/bios.bin -device
> >> ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,chassis=
=3D1,id=3Droot.1
> >> -drive file=3D/sandbox/vm-images/rhel7.3.qcow2,if=3Dvirtio,id=3Ddisk0 =
-net none
> >> -vga none -nodefaults -device
> >> vfio-pci,host=3D08:00.0,x-vga=3Don,addr=3D0.0,multifunction=3Don,bus=
=3Droot.1,romfile=3D/sandbox/vm-images/vbios.rom
> >> -usb -device usb-host,hostbus=3D3,hostport=3D1 -device
> >> usb-host,hostbus=3D3,hostport=3D3 -device vfio-pci,host=3D0000:08:00.1=
 -device
> >> vfio-pci,host=3D0000:09:00.0
> >>
> >> With this setup, I am able to pass-through the dGPU and run the follow=
ing
> >> test:
> >>   * Starting up the guest w/ full GNOME GUI on the attached monitor.
> >>   * glxgears (running @ 60 FPS)
> >>   * Playing 1080p HD video on Youtube
> >>
> >> I am not noticing issues here. What kind of test are you running in th=
e
> >> guest VM?
> > Try running the open source game "torcs" inside the VM.  I think
> > you'll find that there's a very noticeable performance different
> > between npt=3D1 and npt=3D0
>
> Hm.. actually torcs seems to be running fine w/ npt=3D1 setup. Although I=
 think my
> driving skill is ~20% worse :(

>A clarification on the issue, it's not that these games/benchmarks
>don't work or aren't playable, it's that they run slower (as measured by
>framerate) with npt=3D1 vs npt=3D0.  A virtualized guest on AMD hardware i=
s
>hindered either by lower graphics performance (npt=3D1) or higher CPU
>virtualization overhead (npt=3D0) for high intensity games or graphics
>workloads.  Intel's equivalent ept feature does not have this issue.  I
>would encourage looking at the framerate for one mode vs the other
>before drawing any conclusions on whether it's working well.  Thanks,
>Alex

One more data point - Nick did some testing with Xen enabling/disabling npt=
 and
found that (a) performance was not affected much whether npt was on or off,=
 and
(b) performance with npt on was pretty close to KVM performance with npt of=
f.

This suggests something specific to KVM that doesn't play well with npt, al=
though
I have no idea what that might be. I was going to talk to our folks to see =
if they had
any suggestions re: ways to narrow down where the performance impact is com=
ing
from, but I ended up going off sick instead.

Haven't gone through the whole thread here yet so apologies if this has alr=
eady been
mentioned.

--_000_BN6PR12MB1348B4850D77192356D960E9E8DD0BN6PR12MB1348namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Alex Williamson &lt=
;alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> June 28, 2017 3:08 PM<br>
<b>To:</b> Suthikulpanit, Suravee<br>
<b>Cc:</b> Steven Walter; Nick Sarnie; Paolo Bonzini; iommu-cunTk1MwBs8Y1L9dC3jwTg@public.gmane.org=
ndation.org; Matthias Ehrenfeuchter; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bridgman, John<br=
>
<b>Subject:</b> Re: AMD Ryzen KVM/NPT/IOMMU issue</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Thu, 29 Jun 2017 01:53:57 &#43;0700<br>
Suravee Suthikulpanit &lt;Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
<br>
&gt; On 6/29/17 00:26, Steven Walter wrote:<br>
&gt; &gt;&gt; So, I'm trying to reproduce this issue on the Ryzen system w/=
 the following<br>
&gt; &gt;&gt; setup:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * Host kernel v4.11 (with this patch <a href=3D"h=
ttps://lkml.org/lkml/2017/6/23/295">
https://lkml.org/lkml/2017/6/23/295</a>)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * guest VM RHEL7.3<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * guest graphic driver =3D radeon<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * qemu-system-x86_64 --version<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; QEMU emulator version 2.9.50 (v2.9.0-=
1659-g577caa2-dirty)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * kvm-amd npt=3D1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * dGPU is 08:00.0 VGA compatible controller: Adva=
nced Micro Devices, Inc.<br>
&gt; &gt;&gt; [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)<br=
>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp; * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m=
 4096 -cpu host -bios<br>
&gt; &gt;&gt; /usr/share/qemu/bios.bin -device<br>
&gt; &gt;&gt; ioh3420,bus=3Dpcie.0,addr=3D1c.0,multifunction=3Don,port=3D1,=
chassis=3D1,id=3Droot.1<br>
&gt; &gt;&gt; -drive file=3D/sandbox/vm-images/rhel7.3.qcow2,if=3Dvirtio,id=
=3Ddisk0 -net none<br>
&gt; &gt;&gt; -vga none -nodefaults -device<br>
&gt; &gt;&gt; vfio-pci,host=3D08:00.0,x-vga=3Don,addr=3D0.0,multifunction=
=3Don,bus=3Droot.1,romfile=3D/sandbox/vm-images/vbios.rom<br>
&gt; &gt;&gt; -usb -device usb-host,hostbus=3D3,hostport=3D1 -device<br>
&gt; &gt;&gt; usb-host,hostbus=3D3,hostport=3D3 -device vfio-pci,host=3D000=
0:08:00.1 -device<br>
&gt; &gt;&gt; vfio-pci,host=3D0000:09:00.0<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; With this setup, I am able to pass-through the dGPU and run t=
he following<br>
&gt; &gt;&gt; test:<br>
&gt; &gt;&gt;&nbsp;&nbsp; * Starting up the guest w/ full GNOME GUI on the =
attached monitor.<br>
&gt; &gt;&gt;&nbsp;&nbsp; * glxgears (running @ 60 FPS)<br>
&gt; &gt;&gt;&nbsp;&nbsp; * Playing 1080p HD video on Youtube<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am not noticing issues here. What kind of test are you runn=
ing in the<br>
&gt; &gt;&gt; guest VM?&nbsp; <br>
&gt; &gt; Try running the open source game &quot;torcs&quot; inside the VM.=
&nbsp; I think<br>
&gt; &gt; you'll find that there's a very noticeable performance different<=
br>
&gt; &gt; between npt=3D1 and npt=3D0&nbsp; <br>
&gt; <br>
&gt; Hm.. actually torcs seems to be running fine w/ npt=3D1 setup. Althoug=
h I think my
<br>
&gt; driving skill is ~20% worse :(<br>
<br>
&gt;A clarification on the issue, it's not that these games/benchmarks<br>
&gt;don't work or aren't playable, it's that they run slower (as measured b=
y<br>
&gt;framerate) with npt=3D1 vs npt=3D0.&nbsp; A virtualized guest on AMD ha=
rdware is<br>
&gt;hindered either by lower graphics performance (npt=3D1) or higher CPU<b=
r>
&gt;virtualization overhead (npt=3D0) for high intensity games or graphics<=
br>
&gt;workloads.&nbsp; Intel's equivalent ept feature does not have this issu=
e.&nbsp; I<br>
&gt;would encourage looking at the framerate for one mode vs the other<br>
&gt;before drawing any conclusions on whether it's working well.&nbsp; Than=
ks,<br>
&gt;Alex<br>
<br>
One more data point - Nick did some testing with Xen enabling/disabling npt=
 and <br>
found that (a) performance was not affected much whether npt was on or off,=
 and<br>
(b) performance with npt on was pretty close to KVM performance with npt of=
f. <br>
<br>
This suggests something specific to KVM that doesn't play well with npt, al=
though<br>
I have no idea what that might be. I was going to talk to our folks to see =
if they had<br>
any suggestions re: ways to narrow down where the performance impact is com=
ing<br>
from, but I ended up going off sick instead. <br>
<br>
Haven't gone through the whole thread here yet so apologies if this has alr=
eady been<br>
mentioned. <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1348B4850D77192356D960E9E8DD0BN6PR12MB1348namp_--

--===============6742588826127363777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6742588826127363777==--
