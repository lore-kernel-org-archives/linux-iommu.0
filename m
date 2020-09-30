Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A81EC47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:59:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13A52076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fs3jS3d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13A52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 69B1D20381;
	Wed, 30 Sep 2020 09:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6i0REnlH2ukV; Wed, 30 Sep 2020 09:59:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F38D01FD7D;
	Wed, 30 Sep 2020 09:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D906CC0889;
	Wed, 30 Sep 2020 09:59:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E775C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03CD88719A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgwVnXwDxxaA for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5044986FC4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:59:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601459960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8DnijzxhXI/xRDwRFSJZzsrdBCsEQl6sE7zrZb1dP8=;
 b=fs3jS3d57jWSJ1iKZeofM+BkW+5ju/EJ8Ici6wzApBfNmg6kyxAYYPMR3++ik5Viy55k+6
 ULgqUuiJwQ7ReNatpVzKfPvhwc3FwVOZxinR0/ufezRUr0Ah75O/46wtgb3W1wFILiKNUL
 PTHcfewxEnYDrOdNsp/XV6gflseA3cU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-t1j6DdRAOjigaq6QF2tuaQ-1; Wed, 30 Sep 2020 05:59:17 -0400
X-MC-Unique: t1j6DdRAOjigaq6QF2tuaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18E1D1019626;
 Wed, 30 Sep 2020 09:59:15 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF8810013C0;
 Wed, 30 Sep 2020 09:59:08 +0000 (UTC)
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask and
 iommu aperture
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928164224.12350d84@w520.home>
 <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com>
 <20200929121849.455af184@w520.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <30bea49b-c3d4-3926-c8bf-5d6794fce185@redhat.com>
Date: Wed, 30 Sep 2020 11:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200929121849.455af184@w520.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org, eric.auger.pro@gmail.com
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

Hi Alex,

On 9/29/20 8:18 PM, Alex Williamson wrote:
> On Tue, 29 Sep 2020 09:18:22 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi all,
>>
>> [also correcting some outdated email addresses + adding Lorenzo in cc]
>>
>> On 9/29/20 12:42 AM, Alex Williamson wrote:
>>> On Mon, 28 Sep 2020 21:50:34 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> VFIO currently exposes the usable IOVA regions through the
>>>> VFIO_IOMMU_GET_INFO ioctl / VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
>>>> capability. However it fails to take into account the dma_mask
>>>> of the devices within the container. The top limit currently is
>>>> defined by the iommu aperture.  
>>>
>>> I think that dma_mask is traditionally a DMA API interface for a device
>>> driver to indicate to the DMA layer which mappings are accessible to the
>>> device.  On the other hand, vfio makes use of the IOMMU API where the
>>> driver is in userspace.  That userspace driver has full control of the
>>> IOVA range of the device, therefore dma_mask is mostly irrelevant to
>>> vfio.  I think the issue you're trying to tackle is that the IORT code
>>> is making use of the dma_mask to try to describe a DMA address
>>> limitation imposed by the PCI root bus, living between the endpoint
>>> device and the IOMMU.  Therefore, if the IORT code is exposing a
>>> topology or system imposed device limitation, this seems much more akin
>>> to something like an MSI reserved range, where it's not necessarily the
>>> device or the IOMMU with the limitation, but something that sits
>>> between them.  
>>
>> First I think I failed to explain the context. I worked on NVMe
>> passthrough on ARM. The QEMU NVMe backend uses VFIO to program the
>> physical device. The IOVA allocator there currently uses an IOVA range
>> within [0x10000, 1ULL << 39]. This IOVA layout rather is arbitrary if I
>> understand correctly.
> 
> 39 bits is the minimum available on some VT-d systems, so it was
> probably considered a reasonable minimum address width to consider.
OK
> 
>> I noticed we rapidly get some VFIO MAP DMA
>> failures because the allocated IOVA collide with the ARM MSI reserved
>> IOVA window [0x8000000, 0x8100000]. Since  9b77e5c79840 ("vfio/type1:
>> Check reserved region conflict and update iova list"), such VFIO MAP DMA
>> attempts to map IOVAs belonging to host reserved IOVA windows fail. So,
>> by using the VFIO_IOMMU_GET_INFO ioctl /
>> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE I can change the IOVA allocator to
>> avoid allocating within this range and others. While working on this, I
>> tried to automatically compute the min/max IOVAs and change the
>> arbitrary [0x10000, 1ULL << 39]. My SMMUv2 supports up to 48b so
>> naturally the max IOVA was computed as 1ULL << 48. The QEMU NVMe backend
>> allocates at the bottom and at the top of the range. I noticed the use
>> case was not working as soon as the top IOVA was more than 1ULL << 42.
>> And then we noticed the dma_mask was set to 42 by using
>> cat  /sys/bus/pci/devices/0005:01:00.0/dma_mask_bits. So my
>> interpretation is the dma_mask was somehow containing the info the
>> device couldn't handle IOVAs beyond a certain limit.
> 
> I see that there are both OF and ACPI hooks in pci_dma_configure() and
> both modify dev->dma_mask, which is what pci-sysfs is exposing here,
> but I'm not convinced this even does what it's intended to do.  The
> driver core calls this via the bus->dma_configure callback before
> probing a driver, but then what happens when the driver calls
> pci_set_dma_mask()?  This is just a wrapper for dma_set_mask() and I
> don't see anywhere that would take into account the existing
> dev->dma_mask.  It seems for example that pci_dma_configure() could
> produce a 42 bit mask as we have here, then the driver could override
> that with anything that the dma_ops.dma_supported() callback finds
> acceptable, and I don't see any instances where the current
> dev->dma_mask is considered.  Am I overlooking something? 

I don't see it either. So the dma_mask set by the driver would never be
checked against the dma_mask limited found when parsing OF/ACPI?
>  
>> In my case the 42b limit is computed in iort_dma_setup() by
>> acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>>
>> Referring to the comment, it does "Evaluate DMA regions and return
>> respectively DMA region start, offset and size in dma_addr, offset and
>> size on parsing success". This parses the ACPI table, looking for ACPI
>> companions with _DMA methods.
>>
>> But as Alex mentioned, the IORT also allows to define limits on "the
>> number of address bits, starting from the least significant bit that can
>> be generated by a device when it accesses memory". See Named component
>> node.Device Memory Address Size limit or PCI root complex node. Memory
>> address size limit.
>>
>>         ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
>>         if (ret == -ENODEV)
>>                 ret = dev_is_pci(dev) ? rc_dma_get_range(dev, &size)
>>                                       : nc_dma_get_range(dev, &size);
>>
>> So eventually those info collected from the ACPI tables which do impact
>> the usable IOVA range seem to be stored in the dma_mask, hence that
>> proposal.
> 
> As above, it's not clear to me that anyone other than the driver and
> the dma_supported() callback on dma_ops have any input on the value of
> dma_mask, so I'm a little baffled by the current operation.

me too
> 
>>>> So, for instance, if the IOMMU supports up to 48bits, it may give
>>>> the impression the max IOVA is 48b while a device may have a
>>>> dma_mask of 42b. So this API cannot really be used to compute
>>>> the max usable IOVA.
>>>>
>>>> This patch removes the IOVA region beyond the dma_mask's.  
>>>
>>> Rather it adds a reserved region accounting for the range above the
>>> device's dma_mask.  
>>
>> Yep. It adds new reserved regions in
>> /sys/kernel/iommu_groups/<n>/reserved_regions and remove those from the
>> usable regions exposed by VFIO GET_INFO.
>>
>>   I don't think the IOMMU API should be consuming
>>> dma_mask like this though.  For example, what happens in
>>> pci_dma_configure() when there are no OF or ACPI DMA restrictions?  
>> My guess was that the dma_mask was set to the max range but I did not
>> test it.
> 
> Still, we're making use of a driver configured property for the
> purposes of using the DMA API and consuming it in the IOMMU API,
> specifically to satisfy a userspace driver where the in-kernel meta-
> driver can't make any assumptions about the device DMA mask.  It's all
> rather convoluted.

I can't object here. Still we are missing missing consolidated info
about max IOVA range. I interpreted the dma_mask as the info missing to
get it consolidated but now we are not even sure it does the job and
even I would hijack its original goal.
>>   It
>>> appears to me that the dma_mask from whatever previous driver had the
>>> device carries over to the new driver.  That's generally ok for the DMA
>>> API because a driver is required to set the device's DMA mask.  It
>>> doesn't make sense however to blindly consume that dma_mask and export
>>> it via an IOMMU API.  For example I would expect to see different
>>> results depending on whether a host driver has been bound to a device.
>>> It seems the correct IOMMU API approach would be for the IORT code to
>>> specifically register reserved ranges for the device.  
>>
>> Is it only specific to IORT table? acpi_dma_get_range() in
>> drivers/acpi/scan.c is generic.
> 
> Yes, anything trying to implement similar restrictions.  It appears to
> me that platform code is stepping on a driver owned field used by
> dma_ops already here.  Maybe reserved regions should be consumed by
> dma_ops to understand restrictions between the device and the IOMMU.
> 
>>>> As we start to expose this reserved region in the sysfs file
>>>> /sys/kernel/iommu_groups/<n>/reserved_regions, we also need to
>>>> handle the IOVA range beyond the IOMMU aperture to handle the case
>>>> where the dma_mask would have a higher number of bits than the iommu
>>>> max input address.  
>>>
>>> Why?  The IOMMU geometry already describes this and vfio combines both
>>> the IOMMU geometry and the device reserved regions when generating the
>>> IOVA ranges?   
>> Yes VFIO layer does add the info about the topology but
>> /sys/kernel/iommu_groups/<n>/reserved_regions, generated by the IOMMU
>> code, does not. this latter only exposes reserved regions. Assume the
>> dma_mask is 48b and the IOMMU aperture is 42b (assuming it is possible),
>> if you only take into account the "dma_mask" limitation, the end-user
>> will interpret this as: I can use up to 48b.
> 
> What end user?
Anyone who reads /sys/kernel/iommu_groups/<n>/reserved_regions. A user
application could use that info. Anyway I think I indeed wants this file
to do more than it was originally meant for, enumerating *some* of the
reserved regions. That's a bit frustrating though (same for the VFIO ioctl).

  The DMA API is allocating within the address space of
> the IOMMU, so it will simply never encounter the issue.  Within the
> IOMMU API we can already query the geometry of the IOMMU to know its
> width.  It seems like reserved regions is trying to take on new
> responsibilities here.
>  
>>  Who is going to consume this information?  Additionally
>>> it appears that reserved regions will report different information
>>> depending on whether a device is attached to a domain.  
>> yes that's correct. Well at some point we decided to expose (some)
>> reserved regions through sysfs. Only printing a reduced set of those
>> also can be misleading, hence my attempt to be more comprehensive.
> 
> Seems it further blurs the lines of what reserved regions is intended
> to report.  Is it trying to replace the IOMMU API geometry interface?
> 
>>>> This is a change to the ABI as this reserved region was not yet
>>>> exposed in sysfs /sys/kernel/iommu_groups/<n>/reserved_regions or
>>>> through the VFIO ioctl. At VFIO level we increment the version of
>>>> the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE capability to advertise
>>>> that change.  
>>>
>>> Is this really an ABI change?  The original entry for reserved regions
>>> includes:
>>>
>>>   Not necessarily all reserved regions are listed. This is typically
>>>   used to output direct-mapped, MSI, non mappable regions.  
>>
>> I agree. That's not really a change in the ABI but I wanted to make
>> things clear about the induced changes for the end-user. On the other
>> end there will be a change in the number of reported resv regions.
>>>
>>> I imagine the intention here was non-mappable relative to the IOMMU,
>>> but non-mappable to the device is essentially what we're including
>>> here.
>>>
>>> I'm also concerned about bumping the vfio interface version for the
>>> IOVA range.  We're not changing the interface, we're modifying the
>>> result, and even then only for a fraction of users.  How many users are
>>> potentially broken by that change?  Are we going to bump the version
>>> for everyone any time the result changes on any platform?  Thanks,  
>>
>> The userspace needs to know if the GET_INFO is reliable to compute the
>> min/max IOVAs. If we do not change the version, it cannot know and must
>> assume it is not. Wasn't the version field meant for that somehow?
> 
> Our IOVA RANGE is correct to the best of our knowledge, but I don't
> think we can or should rev the version every time we find something
> incorrect.  For instance, we wouldn't do the same for a firmware
> induced range that was missing or incorrect.  I think the version field
> is for creating a new data structure to replace or expand the existing
> one, not to simply say the returned data might be different.  I
> understand the userspace dilemma, but this doesn't seem like the right
> solution.  Thanks,
understood

Thanks

Eric
> 
> Alex
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
