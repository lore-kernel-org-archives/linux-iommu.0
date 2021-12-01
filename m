Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA790C433FE
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 17:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89D1840173;
	Wed,  1 Dec 2021 17:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id szA3URleuVim; Wed,  1 Dec 2021 17:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C53BA40168;
	Wed,  1 Dec 2021 17:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5B09C000A;
	Wed,  1 Dec 2021 17:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5833FC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 392EC82AB6
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Pt+06zaI";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="MnhqyMiR"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ii-TVDPfYlTu for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D9D4828B3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 17:35:39 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638380135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wl46BdwZ1KGmv50G3jfsI0iPOejQIWMQSjLutgaOqHk=;
 b=Pt+06zaIN+XpTYcehYRys4HS6+cE2m00/PDyN9TVIqeywPk9TTKPncOzAFiuKRSxOoNPqI
 AIVc5kWzV7DZUepaLnecpQSpeilOo7HLcvABG0FHIM99zFsj6YzMuKoxBIMB2mIDHDvWPF
 WXoI8orNajSMfj/abMIouU/kReMZpmDjvA+dmGmp8L9lqueEILj0Y0HXBPxUo5O8RSP88C
 yr/AToa8X9keo82ZrPu4y700gVV5afLfh3oCl/0OThPa+UJI1XHydF4PfhiY5m57ipzz6W
 L1I8Kt9UNYWk+vEoTJzmxbnGYdcT0Zq7nFWc9XJ2N4OWIbexFvFzd88vDoSGrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638380135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wl46BdwZ1KGmv50G3jfsI0iPOejQIWMQSjLutgaOqHk=;
 b=MnhqyMiRcxE0SVcEGB/228XRCWh7TIQj1mDZaA2bSHkC/rEWlG373NhsYy4dvo0s23asR9
 YhsM2tmL5EKUQkBw==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211201130023.GH4670@nvidia.com>
References: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx> <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
Date: Wed, 01 Dec 2021 18:35:35 +0100
Message-ID: <87y2548byw.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-ntb@googlegroups.com, Logan Gunthorpe <logang@deltatee.com>,
 Megha Dey <megha.dey@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
>> Looking at the device slices as subdevices with their own struct device
>> makes a lot of sense from the conceptual level.
>
> Except IMS is not just for subdevices, it should be usable for any
> driver in any case as a general interrupt mechiansm, as you alluded to
> below about ethernet queues. ntb seems to be the current example of
> this need..

But NTB is operating through an abstraction layer and is not a direct
PCIe device driver.

> IDXD is not so much making device "slices", but virtualizing and
> sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
> described and the VFIO driver is simply allocating queues from a PCI
> device for specific usages and assigning them interrupts.

Right.

But what is the representation for that resulting device? Some VFIO
specific homebrewn muck or something which is based on struct device?

Right now with VF passthrough, I can see the interrupts which are
associated to the device.

How is that going to be with something which is just made up? Does that
expose it's own msi properties then somewhere hidden in the VFIO layer?

See below.

> There is already a char dev interface that equally allocates queues
> from the same IDXD device, why shouldn't it be able to access IMS
> interrupt pools too?

Why wouldn't it be able to do so?

> IMHO a well designed IDXD driver should put all the PCI MMIO, queue
> mangement, interrupts, etc in the PCI driver layer, and the VFIO
> driver layer should only deal with the MMIO trapping and VFIO
> interfacing.
>
> From this view it is conceptually wrong to have the VFIO driver
> directly talking to MMIO registers in the PCI device or owning the
> irq_chip.

The VFIO driver does not own the irq chip ever. The irq chip is of
course part of the underlying infrastructure. I never asked for that.

PCIe driver
     Owns the PCI/MSI[x] interrupts for the control block

     Has a control mechanism which handles queues or whatever the
     device is partitioned into, that's what I called slice.

     The irqdomain is part of that control mechanism and the irqchip
     implementation belongs to that as well. It has to because the
     message store is device specific.

     Whether the doamin and chip implementation is in a separate
     drivers/irqchip/foo.c file for sharing or directly built into the
     PCIe driver itself does not matter.

     When it allocates a slice for whatever usage then it also
     allocates the IMS interrupts (though the VFIO people want to
     have only one and do the allocations later on demand).

     That allocation cannot be part of the PCI/MSIx interrupt
     domain as we already agreed on.

We have several problems to solve. Let me look at it from both point of
views:

    1) Storage

       A) Having "subdevices" solves the storage problem nicely and
          makes everything just fall in place. Even for a purely
          physical multiqueue device one can argue that each queue is a
          "subdevice" of the physical device. The fact that we lump them
          all together today is not an argument against that.

       B) Requires extra storage in the PCIe device and extra storage
          per subdevice, queue to keep track of the interrupts which
          are associated to it.

    2) Exposure of VFIO interrupts via sysfs

       A) Just works

       B) Requires extra mechanisms to expose it

    3) On demand expansion of the vectors for VFIO

       A) Just works because the device has an irqdomain assigned.

       B) Requires extra indirections to do that

    4) IOMMU msi_desc::dev

       A) I think that's reasonably simple to address by having the
          relationship to the underlying PCIe device stored in struct
          device, which is not really adding any complexity to the IOMMU
          code.

          Quite the contrary it could be used to make the DMA aliasing a
          problem of device setup time and not a lookup per interrupt
          allocation in the IOMMU code.

       B) No change required.

    4) PASID

       While an Intel IDXD specific issue, it want's to be solved
       without any nasty hacks.

       A) Having a "subdevice" allows to associate the PASID with the
          underlying struct device which makes IOMMU integration trivial

       B) Needs some other custom hackery to get that solved

So both variants come with their ups and downs.

IMO A) is the right thing to do when looking at all the involved moving
pieces.

> It would be very odd for the PCI driver to allocate interrupts from
> some random external struct device when it is creating queues on the
> PCI device.

No. That's not what I want.

>> and then have a store index for each allocation domain. With the
>> proposed encapsulation of the xarray handling that's definitely
>> feasible. Whether that buys much is a different question. Let me think
>> about it some more.
>
> Any possibility that the 'IMS' xarray could be outside the struct
> device?

We could, but we really want to keep things tied to devices which is the
right thing to do.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
