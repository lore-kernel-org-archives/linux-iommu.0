From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Sun, 2 Jun 2013 17:13:20 +0200
Message-ID: <20130602151320.GB4095@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <1370182302.30975.279.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370182302.30975.279.camel@ul30vt.home>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: iommu@lists.linux-foundation.org


Thanks a lot for the answer.

Best regards

Beno=EEt

> Le Sunday 02 Jun 2013 =E0 08:11:42 (-0600), Alex Williamson a =E9crit=
 :
> On Sat, 2013-06-01 at 14:13 +0200, Beno=EEt Canet wrote:
> > Hello,
> >=20
> > I may have soon the PF driver of an SR-IOV card to code and make wo=
rk with
> > QEMU/KVM so I have the following questions.
> >=20
> > In an AMD64 setup where QEMU use VFIO to passthrough the VFs of an =
SR-IOV card
> > to a guest will the consequences of a PF FLR be handled fine by QEM=
U and the
> > guest ?
> >=20
> > I read that pci_reset_function would call pci_restore_state restori=
ng the SR-IOV
> > configuration after the reset of the PF.
> >=20
> > The ways the hardware work means that the VFs would disappear and r=
eappear in a
> > short lapse of time.
> >=20
> > Will these events be handled by the kernel pci hotplug code ?
> >=20
> > Given that the PF driver restore the PF config space after the rese=
t will /sys
> > files used by QEMU disappear and reappear messing the QEMU VFIO pas=
sthrough or
> > will it goes smoothly ?
>=20
> On an Intel 82576 SR-IOV NIC, a FLR of the PF does not cause the VFs =
to
> be removed.  It's not clear to me that they continue working across t=
he
> reset, but there is no hotplug.  If there was a hotplug, vfio-pci won=
't
> release the device while it's in use, so the hotplug would be blocked
> until the devices becomes unused, such as from the VM being shutdown.
> Thanks,
>=20
> Alex
>=20
>=20
