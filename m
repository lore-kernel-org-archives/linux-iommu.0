From: Graham Neville <grahamneville-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 19:52:27 +0000
Message-ID: <CAEk7i1-Ar0ES8ekmSGiRrrWzTz8gFb2RDTW6KsbuNdDubVerww@mail.gmail.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
	<CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
	<20170505112706.7785948c@t450s.home>
	<CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
	<545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
	<CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
	<5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com>
	<20170628130855.76c2b700@w520.home>
	<BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
	<BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363806235188740969=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <BN6PR12MB13481A39CD3EA714754FEE49E8DD0-/b2+HYfkarQX0pEhCR5T8QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Ehrenfeuchter <efeu-5Zrl/DuVEGLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3363806235188740969==
Content-Type: multipart/alternative; boundary="001a113cd1ec1d15df05530a863f"

--001a113cd1ec1d15df05530a863f
Content-Type: text/plain; charset="UTF-8"

Although not related to graphics card performance, there is definitely
another issue with regards to running KVM nested L2 guests when npt=1.

Thought I'd mention this in case it helps with identifying performance
issues with NPT.

I'm unable to start any L2 guests with KVM acceleration (--enable-kvm). As
soon as it attempts to bring up the L2 guest the L1 host crashes, L0 host
remains online. Nothing is printed in either L1 or L0's dmesg.

My L0 is running Arch with 4.11.0-rc6, with qemu 2.8.0. I've tried
different L1 hosts (Ubuntu,Arch) and different kernels right to 4.12-rc5
kernel, along with different qemu versions.

This used to work fine with my Intel i7-4770s setup.

With npt=0, L2 guests can start but performance is dier.

On Wed, Jun 28, 2017 at 7:29 PM, Bridgman, John <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
wrote:

>
>
> From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Sent: June 28, 2017 3:08 PM
> To: Suthikulpanit, Suravee
> Cc: Steven Walter; Nick Sarnie; Paolo Bonzini;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Matthias Ehrenfeuchter;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bridgman, John
> Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
>
> On Thu, 29 Jun 2017 01:53:57 +0700
> Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
>
> > On 6/29/17 00:26, Steven Walter wrote:
> > >> So, I'm trying to reproduce this issue on the Ryzen system w/ the
> following
> > >> setup:
> > >>
> > >>   * Host kernel v4.11 (with this patch  https://lkml.org/lkml/2017/6/
> 23/295)
> > >>
> > >>   * guest VM RHEL7.3
> > >>
> > >>   * guest graphic driver = radeon
> > >>
> > >>   * qemu-system-x86_64 --version
> > >>     QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
> > >>
> > >>   * kvm-amd npt=1
> > >>
> > >>   * dGPU is 08:00.0 VGA compatible controller: Advanced Micro
> Devices, Inc.
> > >> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
> > >>
> > >>   * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host
> -bios
> > >> /usr/share/qemu/bios.bin -device
> > >> ioh3420,bus=pcie.0,addr=1c.0,multifunction=on,port=1,
> chassis=1,id=root.1
> > >> -drive file=/sandbox/vm-images/rhel7.3.qcow2,if=virtio,id=disk0 -net
> none
> > >> -vga none -nodefaults -device
> > >> vfio-pci,host=08:00.0,x-vga=on,addr=0.0,multifunction=on,
> bus=root.1,romfile=/sandbox/vm-images/vbios.rom
> > >> -usb -device usb-host,hostbus=3,hostport=1 -device
> > >> usb-host,hostbus=3,hostport=3 -device vfio-pci,host=0000:08:00.1
> -device
> > >> vfio-pci,host=0000:09:00.0
> > >>
> > >> With this setup, I am able to pass-through the dGPU and run the
> following
> > >> test:
> > >>   * Starting up the guest w/ full GNOME GUI on the attached monitor.
> > >>   * glxgears (running @ 60 FPS)
> > >>   * Playing 1080p HD video on Youtube
> > >>
> > >> I am not noticing issues here. What kind of test are you running in
> the
> > >> guest VM?
> > > Try running the open source game "torcs" inside the VM.  I think
> > > you'll find that there's a very noticeable performance different
> > > between npt=1 and npt=0
> >
> > Hm.. actually torcs seems to be running fine w/ npt=1 setup. Although I
> think my
> > driving skill is ~20% worse :(
>
> >A clarification on the issue, it's not that these games/benchmarks
> >don't work or aren't playable, it's that they run slower (as measured by
> >framerate) with npt=1 vs npt=0.  A virtualized guest on AMD hardware is
> >hindered either by lower graphics performance (npt=1) or higher CPU
> >virtualization overhead (npt=0) for high intensity games or graphics
> >workloads.  Intel's equivalent ept feature does not have this issue.  I
> >would encourage looking at the framerate for one mode vs the other
> >before drawing any conclusions on whether it's working well.  Thanks,
> >Alex
>
> One more data point - Nick did some testing with Xen enabling/disabling
> npt and
> found that (a) performance was not affected much whether npt was on or
> off, and
> (b) performance with npt on was pretty close to KVM performance with npt
> off.
>
> This suggests something specific to KVM that doesn't play well with npt,
> although
> I have no idea what that might be. I was going to talk to our folks to see
> if they had
> any suggestions re: ways to narrow down where the performance impact is
> coming
> from, but I ended up going off sick instead.
>
> Haven't gone through the whole thread here yet so apologies if this has
> already been
> mentioned (and Nick sorry for the delay).
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--001a113cd1ec1d15df05530a863f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Although not related to graphics card performance, th=
ere is definitely another issue with regards to running KVM nested L2=C2=A0=
guests when npt=3D1.</div><div><br></div><div>Thought I&#39;d mention this =
in case it helps with identifying performance issues with NPT.</div><div><b=
r></div><div>I&#39;m unable to start any L2 guests with KVM acceleration (-=
-enable-kvm). As soon as=C2=A0it attempts to bring up the L2 guest the L1 h=
ost crashes, L0 host remains online. Nothing is printed in either L1 or L0&=
#39;s dmesg.</div><div><br></div><div>My L0 is running Arch with 4.11.0-rc6=
, with qemu 2.8.0.=C2=A0I&#39;ve tried different L1 hosts (Ubuntu,Arch) and=
 different kernels right to 4.12-rc5 kernel, along with different qemu vers=
ions.</div><div><br></div><div>This used to work fine with my Intel i7-4770=
s setup.</div><div><br></div><div>With npt=3D0, L2 guests can start but per=
formance is dier.</div></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Wed, Jun 28, 2017 at 7:29 PM, Bridgman, John <span dir=3D"lt=
r">&lt;<a href=3D"mailto:John.Bridgman-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">John.Brid=
gman-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div c=
lass=3D"HOEnZb"><div class=3D"h5"><br>
<br>
From: Alex Williamson &lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ale=
x.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
Sent: June 28, 2017 3:08 PM<br>
To: Suthikulpanit, Suravee<br>
Cc: Steven Walter; Nick Sarnie; Paolo Bonzini; <a href=3D"mailto:iommu@list=
s.linux-foundation.org">iommu-cunTk1MwBs9QetFLy7KEmxxBWXNxL4zz@public.gmane.org<wbr>org</a>; Matthias=
 Ehrenfeuchter; <a href=3D"mailto:kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<=
/a>; Bridgman, John<br>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue<br>
=C2=A0<br>
On Thu, 29 Jun 2017 01:53:57 +0700<br>
Suravee Suthikulpanit &lt;<a href=3D"mailto:Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org">=
Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org</a><wbr>&gt; wrote:<br>
<br>
&gt; On 6/29/17 00:26, Steven Walter wrote:<br>
&gt; &gt;&gt; So, I&#39;m trying to reproduce this issue on the Ryzen syste=
m w/ the following<br>
&gt; &gt;&gt; setup:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * Host kernel v4.11 (with this patch=C2=A0 <a hre=
f=3D"https://lkml.org/lkml/2017/6/23/295" target=3D"_blank" rel=3D"noreferr=
er">https://lkml.org/lkml/2017/6/<wbr>23/295</a>)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * guest VM RHEL7.3<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * guest graphic driver =3D radeon<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * qemu-system-x86_64 --version<br>
&gt; &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0 QEMU emulator version 2.9.50 (v2.9.0-=
1659-g577caa2-dirty)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * kvm-amd npt=3D1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * dGPU is 08:00.0 VGA compatible controller: Adva=
nced Micro Devices, Inc.<br>
&gt; &gt;&gt; [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)<br=
>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m=
 4096 -cpu host -bios<br>
&gt; &gt;&gt; /usr/share/qemu/bios.bin -device<br>
&gt; &gt;&gt; ioh3420,bus=3Dpcie.0,addr=3D1c.0,<wbr>multifunction=3Don,port=
=3D1,<wbr>chassis=3D1,id=3Droot.1<br>
&gt; &gt;&gt; -drive file=3D/sandbox/vm-images/rhel7.<wbr>3.qcow2,if=3Dvirt=
io,id=3Ddisk0 -net none<br>
&gt; &gt;&gt; -vga none -nodefaults -device<br>
&gt; &gt;&gt; vfio-pci,host=3D08:00.0,x-vga=3D<wbr>on,addr=3D0.0,multifunct=
ion=3Don,<wbr>bus=3Droot.1,romfile=3D/sandbox/<wbr>vm-images/vbios.rom<br>
&gt; &gt;&gt; -usb -device usb-host,hostbus=3D3,hostport=3D1 -device<br>
&gt; &gt;&gt; usb-host,hostbus=3D3,hostport=3D3 -device vfio-pci,host=3D000=
0:08:00.1 -device<br>
&gt; &gt;&gt; vfio-pci,host=3D0000:09:00.0<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; With this setup, I am able to pass-through the dGPU and run t=
he following<br>
&gt; &gt;&gt; test:<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * Starting up the guest w/ full GNOME GUI on the =
attached monitor.<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * glxgears (running @ 60 FPS)<br>
&gt; &gt;&gt;=C2=A0=C2=A0 * Playing 1080p HD video on Youtube<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I am not noticing issues here. What kind of test are you runn=
ing in the<br>
&gt; &gt;&gt; guest VM?=C2=A0<br>
&gt; &gt; Try running the open source game &quot;torcs&quot; inside the VM.=
=C2=A0 I think<br>
&gt; &gt; you&#39;ll find that there&#39;s a very noticeable performance di=
fferent<br>
&gt; &gt; between npt=3D1 and npt=3D0=C2=A0<br>
&gt;<br>
&gt; Hm.. actually torcs seems to be running fine w/ npt=3D1 setup. Althoug=
h I think my<br>
&gt; driving skill is ~20% worse :(<br>
<br>
&gt;A clarification on the issue, it&#39;s not that these games/benchmarks<=
br>
&gt;don&#39;t work or aren&#39;t playable, it&#39;s that they run slower (a=
s measured by<br>
&gt;framerate) with npt=3D1 vs npt=3D0.=C2=A0 A virtualized guest on AMD ha=
rdware is<br>
&gt;hindered either by lower graphics performance (npt=3D1) or higher CPU<b=
r>
&gt;virtualization overhead (npt=3D0) for high intensity games or graphics<=
br>
&gt;workloads.=C2=A0 Intel&#39;s equivalent ept feature does not have this =
issue.=C2=A0 I<br>
&gt;would encourage looking at the framerate for one mode vs the other<br>
&gt;before drawing any conclusions on whether it&#39;s working well.=C2=A0 =
Thanks,<br>
&gt;Alex<br>
<br>
One more data point - Nick did some testing with Xen enabling/disabling npt=
 and<br>
found that (a) performance was not affected much whether npt was on or off,=
 and<br>
(b) performance with npt on was pretty close to KVM performance with npt of=
f.<br>
<br>
This suggests something specific to KVM that doesn&#39;t play well with npt=
, although<br>
I have no idea what that might be. I was going to talk to our folks to see =
if they had<br>
any suggestions re: ways to narrow down where the performance impact is com=
ing<br>
from, but I ended up going off sick instead.<br>
<br>
Haven&#39;t gone through the whole thread here yet so apologies if this has=
 already been<br>
</div></div>mentioned (and Nick sorry for the delay).<br>
<br>
______________________________<wbr>_________________<br>
iommu mailing list<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.<wbr>org</a><br>
<a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" target=
=3D"_blank" rel=3D"noreferrer">https://lists.linuxfoundation.<wbr>org/mailm=
an/listinfo/iommu</a><br>
</blockquote></div><br></div>

--001a113cd1ec1d15df05530a863f--

--===============3363806235188740969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3363806235188740969==--
