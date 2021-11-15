Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3541DC433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 17:54:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B327460C4A
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B327460C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A62540106;
	Mon, 15 Nov 2021 17:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96CIxcdk7ONI; Mon, 15 Nov 2021 17:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D54A1401BE;
	Mon, 15 Nov 2021 17:54:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E4EC002E;
	Mon, 15 Nov 2021 17:54:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEBCAC0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 17:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAF2E80CB1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 17:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 81DsEVVFsnEh for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 17:54:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F42680C2F
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 17:54:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C2E61FB;
 Mon, 15 Nov 2021 09:54:51 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F36763F70D;
 Mon, 15 Nov 2021 09:54:48 -0800 (PST)
Message-ID: <e9db18d3-dea3-187a-d58a-31a913d95211@arm.com>
Date: Mon, 15 Nov 2021 17:54:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/11] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-4-baolu.lu@linux.intel.com>
 <YZJe1jquP+osF+Wn@infradead.org> <20211115133107.GB2379906@nvidia.com>
 <495c65e4-bd97-5f29-d39b-43671acfec78@arm.com>
 <20211115161756.GP2105516@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211115161756.GP2105516@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-11-15 16:17, Jason Gunthorpe wrote:
> On Mon, Nov 15, 2021 at 03:14:49PM +0000, Robin Murphy wrote:
> 
>>> If userspace has control of device A and can cause A to issue DMA to
>>> arbitary DMA addresses then there are certain PCI topologies where A
>>> can now issue peer to peer DMA and manipulate the MMMIO registers in
>>> device B.
>>>
>>> A kernel driver on device B is thus subjected to concurrent
>>> manipulation of the device registers from userspace.
>>>
>>> So, a 'safe' kernel driver is one that can tolerate this, and an
>>> 'unsafe' driver is one where userspace can break kernel integrity.
>>
>> You mean in the case where the kernel driver is trying to use device B in a
>> purely PIO mode, such that userspace might potentially be able to interfere
>> with data being transferred in and out of the kernel?
> 
> s/PIO/MMIO, but yes basically. And not just data trasnfer but
> userspace can interfere with the device state as well.

Sure, but unexpected changes in device state could happen for any number 
of reasons - uncorrected ECC error, surprise removal, etc. - so if that 
can affect "kernel integrity" I'm considering it an independent problem.

>> Perhaps it's not so clear to put that under a notion of "DMA
>> ownership", since device B's DMA is irrelevant and it's really much
>> more equivalent to /dev/mem access or mmaping BARs to userspace
>> while a driver is bound.
> 
> It is DMA ownership because device A's DMA is what is relevant
> here. device A's DMA compromises device B. So device A asserts it has
> USER ownership for DMA.
> 
> Any device in a group with USER ownership is incompatible with a
> kernel driver.

I can see the argument from that angle, but you can equally look at it 
another way and say that a device with kernel ownership is incompatible 
with a kernel driver, if userspace can call write() on 
"/sys/devices/B/resource0" such that device A's kernel driver DMAs all 
over it. Maybe that particular example lands firmly under "just don't do 
that", but I'd like to figure out where exactly we should draw the line 
between "DMA" and "ability to mess with a device".

>>> The second issue is DMA - because there is only one iommu_domain
>>> underlying many devices if we give that iommu_domain to userspace it
>>> means the kernel DMA API on other devices no longer works.
>>
>> Actually, the DMA API itself via iommu-dma will "work" just fine in the
>> sense that it will still successfully perform all its operations in the
>> unattached default domain, it's just that if the driver then programs the
>> device to access the returned DMA address, the device is likely to get a
>> nasty surprise.
> 
> A DMA API that returns an dma_ddr_t that does not result in data
> transfer to the specified buffers is not working, in my book - it
> breaks the API contract.
> 
>>> So no kernel driver doing DMA can work at all, under any PCI topology,
>>> if userspace owns the IO page table.
>>
>> This isn't really about userspace at all - it's true of any case where a
>> kernel driver wants to attach a grouped device to its own unmanaged
>> domain.
> 
> This is true for the dma api issue in isolation.

No, it's definitely a general IOMMU-API-level thing; you could just as 
well have two drivers both trying to attach to their own unmanaged 
domains without DMA API involvement. What I think it boils down to is 
that if multiple devices in a group are bound (or want to bind) to 
different drivers, we want to enforce some kind of consensus between 
those drivers over IOMMU API usage.

> I think if we have a user someday it would make sense to add another
> API DMA_OWNER_DRIVER_DOMAIN that captures how the dma API doesn't work
> but DMA MMIO attacks are not possible.
> 
>> The fact that the VFIO kernel driver uses its unmanaged domains to map user
>> pages upon user requests is merely a VFIO detail, and VFIO happens to be the
>> only common case where unmanaged domains and non-singleton groups intersect.
>> I'd say that, logically, if you want to put policy on mutual driver/usage
>> compatibility anywhere it should be in iommu_attach_group().
> 
> It would make sense for iommu_attach_group() to require that the
> DMA_OWNERSHIP is USER or DRIVER_DOMAIN.
> 
> That has a nice symmetry with iommu_attach_device() already requiring
> that the group has a single device. For a driver to use these APIs it
> must ensure security, one way or another.

iommu_attach_device() is supposed to be deprecated and eventually going 
away; I wouldn't look at it too much.

> That is a good idea, but requires understanding what tegra is
> doing. Maybe tegra is that DMA_OWNER_DRIVER_DOMAIN user?
> 
> I wouldn't want to see iommu_attach_group() change the DMA_OWNERSHIP,
> I think ownership is cleaner as a dedicated API. Adding a file * and
> probably the enum to iommu_attach_group() feels weird.

Indeed I wasn't imagining it changing any ownership, just preventing a 
group from being attached to a non-default domain if it contains devices 
bound to different incompatible drivers. Basically just taking the 
existing check that VFIO tries to enforce and formalising it into the 
core API. It's not too far off what we already have around changing the 
default domain type, so there seems to be room for it to all fit 
together quite nicely.

There would still need to be separate enforcement elsewhere to prevent 
new drivers binding *after* a group *has* been attached to an unmanaged 
domain, but again it can still be in those simplest terms. Tying it in 
to userspace and FDs just muddies the water far more than necessary.

Robin.

> We need the dedicated API for the dma_configure op, and keeping
> ownership split from the current domain makes more sense with the
> design in the iommfd RFC.
> 
> Thanks,
> Jason
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
