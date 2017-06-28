From: "Bridgman, John" <John.Bridgman@amd.com>
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
Date: Wed, 28 Jun 2017 19:29:56 +0000
Message-ID: <BN6PR12MB13481A39CD3EA714754FEE49E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <575f8fbc-0fdc-f336-e3da-53f27da4b2e1@markju.com>
        <CAOcCaLbdi9KZoXiV5htjShc_mYvZ5jK2B3Ot7NeM=3v_ZA39aA@mail.gmail.com>
        <20170505112706.7785948c@t450s.home>
        <CAOcCaLbAS0FkRrG8YZNM5rYUtCFeUGkdgdy=4o16Njufdy8Gag@mail.gmail.com>
        <545f19a3-4923-cdec-4ce9-2a4155a04f6a@amd.com>
        <CAK8d-aJ+XHi+5sr6bHj3D2BaG94v6Lyk1C_ZuA4erDVhEyp-uQ@mail.gmail.com>
        <5d2ea709-8f90-bfaa-975d-48aed39e75ad@amd.com>,<20170628130855.76c2b700@w520.home>,<BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <BN6PR12MB1348B4850D77192356D960E9E8DD0@BN6PR12MB1348.namprd12.prod.outlook.com>
Content-Language: en-CA
Sender: kvm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: Steven Walter <stevenrwalter@gmail.com>, Nick Sarnie <commendsarnex@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Matthias Ehrenfeuchter <efeu@markju.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



From: Alex Williamson <alex.williamson@redhat.com>
Sent: June 28, 2017 3:08 PM
To: Suthikulpanit, Suravee
Cc: Steven Walter; Nick Sarnie; Paolo Bonzini; iommu@lists.linux-foundation=
.org; Matthias Ehrenfeuchter; kvm@vger.kernel.org; Bridgman, John
Subject: Re: AMD Ryzen KVM/NPT/IOMMU issue
=A0  =20
On Thu, 29 Jun 2017 01:53:57 +0700
Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:

> On 6/29/17 00:26, Steven Walter wrote:
> >> So, I'm trying to reproduce this issue on the Ryzen system w/ the foll=
owing
> >> setup:
> >>
> >>=A0=A0 * Host kernel v4.11 (with this patch  https://lkml.org/lkml/2017=
/6/23/295)
> >>
> >>=A0=A0 * guest VM RHEL7.3
> >>
> >>=A0=A0 * guest graphic driver =3D radeon
> >>
> >>=A0=A0 * qemu-system-x86_64 --version
> >>=A0=A0=A0=A0 QEMU emulator version 2.9.50 (v2.9.0-1659-g577caa2-dirty)
> >>
> >>=A0=A0 * kvm-amd npt=3D1
> >>
> >>=A0=A0 * dGPU is 08:00.0 VGA compatible controller: Advanced Micro Devi=
ces, Inc.
> >> [AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
> >>
> >>=A0=A0 * qemu-system-x86_64 -smp 4 -enable-kvm -M q35 -m 4096 -cpu host=
 -bios
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
> >>=A0=A0 * Starting up the guest w/ full GNOME GUI on the attached monito=
r.
> >>=A0=A0 * glxgears (running @ 60 FPS)
> >>=A0=A0 * Playing 1080p HD video on Youtube
> >>
> >> I am not noticing issues here. What kind of test are you running in th=
e
> >> guest VM?=A0=20
> > Try running the open source game "torcs" inside the VM.=A0 I think
> > you'll find that there's a very noticeable performance different
> > between npt=3D1 and npt=3D0=A0=20
>=20
> Hm.. actually torcs seems to be running fine w/ npt=3D1 setup. Although I=
 think my
> driving skill is ~20% worse :(

>A clarification on the issue, it's not that these games/benchmarks
>don't work or aren't playable, it's that they run slower (as measured by
>framerate) with npt=3D1 vs npt=3D0.=A0 A virtualized guest on AMD hardware=
 is
>hindered either by lower graphics performance (npt=3D1) or higher CPU
>virtualization overhead (npt=3D0) for high intensity games or graphics
>workloads.=A0 Intel's equivalent ept feature does not have this issue.=A0 =
I
>would encourage looking at the framerate for one mode vs the other
>before drawing any conclusions on whether it's working well.=A0 Thanks,
>Alex

One more data point - Nick did some testing with Xen enabling/disabling npt=
 and=20
found that (a) performance was not affected much whether npt was on or off,=
 and
(b) performance with npt on was pretty close to KVM performance with npt of=
f.=20

This suggests something specific to KVM that doesn't play well with npt, al=
though
I have no idea what that might be. I was going to talk to our folks to see =
if they had
any suggestions re: ways to narrow down where the performance impact is com=
ing
from, but I ended up going off sick instead.=20

Haven't gone through the whole thread here yet so apologies if this has alr=
eady been
mentioned (and Nick sorry for the delay).=20
      =
