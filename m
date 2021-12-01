Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF65C433EF
	for <iommu@archiver.kernel.org>; Wed,  1 Dec 2021 20:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D7B740545;
	Wed,  1 Dec 2021 20:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inc1vk0DJVa9; Wed,  1 Dec 2021 20:21:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F3B540226;
	Wed,  1 Dec 2021 20:21:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BEF6C000A;
	Wed,  1 Dec 2021 20:21:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F173EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8C4D8299E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="sbuHX70H";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="8iqy66nC"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sBhyCttV4eMw for <iommu@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 20:21:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE51782980
 for <iommu@lists.linux-foundation.org>; Wed,  1 Dec 2021 20:21:33 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638390090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XT2wUHCzGqHpG3jIMlo/pIyGWM+MoMGI0fdIA1I0A8A=;
 b=sbuHX70HoTMCTvQEj76ryoHtY6DI/+vfWQUUTksXv5nW00dxNOLlfEf+NQCz6Pogx5cxON
 bhRF88wSNqWpcTNv9HaatLPgrCGX0FGWrQAnsen2OD3fyuFPACA0gZPfxirNBuQftKtmT5
 4Op58ZCeMmrKMz4Z8WoqOFXQ3cKyVtBKzlvGjlr/RhzK9Ahw34co+9UumRt/RTSkMs801E
 Cretx0BdbZEKZc1FLKEWd6L80nSP+2vCsRkRP1T0gS5MoDWFW6qmctB251f5A2HDydi5oa
 Tnfblrtx1T/f60OF/c5T2Fyb4vrRpmWhvShkmrMLsD5S2WagNLxTzanYcRPV4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638390090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XT2wUHCzGqHpG3jIMlo/pIyGWM+MoMGI0fdIA1I0A8A=;
 b=8iqy66nCBYTd+SSVovf1ktB8lPStcgQyxhheRTxqvNeAhaIQi+dceoXbFQtKXalHyXIYz5
 VLgGaC6YwmaKVnAA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211201181406.GM4670@nvidia.com>
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
Date: Wed, 01 Dec 2021 21:21:29 +0100
Message-ID: <87mtlk84ae.ffs@tglx>
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

Jason,

On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 06:35:35PM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
>> But NTB is operating through an abstraction layer and is not a direct
>> PCIe device driver.
>
> I'm not sure exactly how NTB seems to be split between switchtec and
> the ntb code, but since the ntbd code seems to be doing MMIO touches,
> it feels like part of a PCIe driver?

It's a maze of magic PCIe driver with callbacks left and right into the
underlying NTB hardware driver which itself does some stuff on its own
and also calls back into the underlying PCIe driver.

Decomposing that thing feels like being trapped in the Labyrinth of
Knossos. But let's ignore that for a moment.

>> The VFIO driver does not own the irq chip ever. The irq chip is of
>> course part of the underlying infrastructure. I never asked for that.
>
> That isn't quite what I ment.. I ment the PCIe driver cannot create
> the domain or make use of the irq_chip until the VFIO layer comes
> along and provides the struct device. To me this is backwards
> layering, the interrupts come from the PCIe layer and should exist
> independently from VFIO.

See below.

>>      When it allocates a slice for whatever usage then it also
>>      allocates the IMS interrupts (though the VFIO people want to
>>      have only one and do the allocations later on demand).
>> 
>>      That allocation cannot be part of the PCI/MSIx interrupt
>>      domain as we already agreed on.
>
> Yes, it is just an open question of where the new irq_domain need to
> reside

The irqdomain is created by and part of the physical device. But that
does not mean that the interrupts which are allocated from that irq
domain are stored in the physical device representation.

Going by that logic, the PCI/MSI domain would store all MSI[X]
interrupts which are allocated on some root bridge or wherever.

They are obviously stored per PCI device, but the irqdomain is owned
e.g. by the underlying IOMMU zone.

The irqdomain is managing and handing out resources. Like any other
resource manager does.

See?

>>     1) Storage
>> 
>>        A) Having "subdevices" solves the storage problem nicely and
>>           makes everything just fall in place. Even for a purely
>>           physical multiqueue device one can argue that each queue is a
>>           "subdevice" of the physical device. The fact that we lump them
>>           all together today is not an argument against that.
>
> I don't like the idea that queue is a device, that is trying to force
> a struct device centric world onto a queue which doesn't really want
> it..

Here we are at the point where we agree to disagree.

Of course a queue is a resource, but what prevents us to represent a
queue as a carved out subdevice of the physical device?

Look at it from the VF point of view. If VFs are disabled then all
resources belong to the physical device. If VFs are enabled then the
hardware/firmware splits the resources into separate subdevices which
have their own device representation, interrupt storage etc.

As VFs have a scalability limitation due to the underlying PCIe
restrictions the step we are talking about now is to split the queues up
in software which means nothing else than creating a software
representation of finer grained and more scalable subdevices.

So why would we want to pretend that these are not devices?

They are from a conceptual and topology view a subdevice of the physical
device. Just because they are named queues does not make it any
different.

Let's look at VFIO again. If VFIO passes a VF through then it builds a
wrapper around the VF device.

So if a queue is represented as a subdevice, then VFIO can just build
a wrapper around that subdevice.

But with your model, VFIO has to create a device, request a queue,
wrestle the interrupts in place, etc. Which is exactly the opposite of
how VFs are handled.

So again, why would we want to make software managed subdevices look
exactly the opposite way like hardware/firmware managed subdevices?

Let me also look at the cdev which is exposed by the phsyical device.

The cdev is nothing else than a software vehicle to create a /dev/
node. (ignore the switchtec case which (ab)uses the cdev to connect to
NTB). The cdev allows user space to allocate/release a resource.

Of course it can just allocate a queue and stick the necessary
interrupts into the physical device MSI descriptor storage.

But there is no reason why the queue allocation cannot allocate a
subdevice representing the queue.

That makes the VFIO and the cdev case just using the same underlying
representation which can expose it's properties via the underlying
device.

Which in turn is consistent all over the place and does not require any
special case for anything. Neither for interrupts nor for anything else.

Thanks,

        tglx



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
