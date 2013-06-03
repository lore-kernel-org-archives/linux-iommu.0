From: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
Date: Mon, 3 Jun 2013 21:29:59 +0200
Message-ID: <20130603192958.GB31044@irqsave.net>
References: <20130601121320.GC5157@irqsave.net>
 <51ACE340.1030406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51ACE340.1030406@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Canet <benoit.canet@irqsave.net>, linux-pci@vger.kernel.org, qemu-devel@nongnu.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

> >to a guest will the consequences of a PF FLR be handled fine by QEMU=
 and the
> >guest ?
> >
> the reset occurs long before the device is passed to the guest.

I was asking this because the PF driver should reset the PF while the V=
=46 are
used by VFIO/QEMU when the PF doesn't respond anymore.

> The PF driver doesn't do the config space restore -- it's done in PCI=
 core code.
> >files used by QEMU disappear and reappear messing the QEMU VFIO pass=
through or
> As stated above, the devices don't disappear from the device tree, so=
 they don't
> get removed/added to the /sys(/bus/pci/...) files.
>=20
> >will it goes smoothly ?
> >
> it goes smoothly today.... :-/

Happy to read that thanks for the answer.

Best regards

Beno=EEt Canet
