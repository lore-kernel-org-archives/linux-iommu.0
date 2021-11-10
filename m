Return-Path: <SRS0=V2Kg=P5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA4C433EF
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 06:33:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C4161179
	for <iommu@archiver.kernel.org>; Wed, 10 Nov 2021 06:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63C4161179
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFDA840403;
	Wed, 10 Nov 2021 06:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ymL9Btj6Ijm6; Wed, 10 Nov 2021 06:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6625E403FC;
	Wed, 10 Nov 2021 06:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3499EC0012;
	Wed, 10 Nov 2021 06:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E725C000E
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 06:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A1F540468
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 06:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gyp3qZRmIE9g for <iommu@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 06:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D21714042D
 for <iommu@lists.linux-foundation.org>; Wed, 10 Nov 2021 06:33:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="296052376"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; d="scan'208";a="296052376"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 22:33:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; d="scan'208";a="491978546"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.217])
 ([10.254.212.217])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 22:33:47 -0800
Message-ID: <de5880fc-50e2-6e35-5948-ad2fc4418342@linux.intel.com>
Date: Wed, 10 Nov 2021 14:33:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] iommu: intel: do deep dma-unmapping, to avoid
 kernel-flooding.
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
References: <20211012135653.3852-1-ajaygargnsit@gmail.com>
 <20211109165652.19d1b9f8.alex.williamson@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20211109165652.19d1b9f8.alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org
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

Hi Alex,

On 2021/11/10 7:56, Alex Williamson wrote:
> 
> Hi Baolu,
> 
> Have you looked into this?

I am looking at this.

> I'm able to reproduce by starting and
> destroying an assigned device VM several times.  It seems like it came
> in with Joerg's pull request for the v5.15 merge window.  Bisecting
> lands me on 3f34f1259776 where intel-iommu added map/unmap_pages
> support, but I'm not convinced that isn't an artifact that the regular
> map/unmap calls had been been simplified to only be used for single
> pages by that point.  If I mask the map/unmap_pages callbacks and use
> map/unmap with (pgsize * size) and restore the previous pgsize_bitmap,
> I can generate the same faults.  So maybe the root issue was introduced
> somewhere else, or perhaps it is a latent bug in clearing of pte ranges
> as Ajay proposes below.  In any case, I think there's a real issue
> here.  Thanks,

I am trying to reproduce this issue with my local setup. I will come
back again after I have more details.

Best regards,
baolu

> 
> Alex
> 
> On Tue, 12 Oct 2021 19:26:53 +0530
> Ajay Garg <ajaygargnsit@gmail.com> wrote:
> 
>> === Issue ===
>>
>> Kernel-flooding is seen, when an x86_64 L1 guest (Ubuntu-21) is booted in qemu/kvm
>> on a x86_64 host (Ubuntu-21), with a host-pci-device attached.
>>
>> Following kind of logs, along with the stacktraces, cause the flood :
>>
>> ......
>>   DMAR: ERROR: DMA PTE for vPFN 0x428ec already set (to 3f6ec003 not 3f6ec003)
>>   DMAR: ERROR: DMA PTE for vPFN 0x428ed already set (to 3f6ed003 not 3f6ed003)
>>   DMAR: ERROR: DMA PTE for vPFN 0x428ee already set (to 3f6ee003 not 3f6ee003)
>>   DMAR: ERROR: DMA PTE for vPFN 0x428ef already set (to 3f6ef003 not 3f6ef003)
>>   DMAR: ERROR: DMA PTE for vPFN 0x428f0 already set (to 3f6f0003 not 3f6f0003)
>> ......
>>
>>
>>
>> === Current Behaviour, leading to the issue ===
>>
>> Currently, when we do a dma-unmapping, we unmap/unlink the mappings, but
>> the pte-entries are not cleared.
>>
>> Thus, following sequencing would flood the kernel-logs :
>>
>> i)
>> A dma-unmapping makes the real/leaf-level pte-slot invalid, but the
>> pte-content itself is not cleared.
>>
>> ii)
>> Now, during some later dma-mapping procedure, as the pte-slot is about
>> to hold a new pte-value, the intel-iommu checks if a prior
>> pte-entry exists in the pte-slot. If it exists, it logs a kernel-error,
>> along with a corresponding stacktrace.
>>
>> iii)
>> Step ii) runs in abundance, and the kernel-logs run insane.
>>
>>
>>
>> === Fix ===
>>
>> We ensure that as part of a dma-unmapping, each (unmapped) pte-slot
>> is also cleared of its value/content (at the leaf-level, where the
>> real mapping from a iova => pfn mapping is stored).
>>
>> This completes a "deep" dma-unmapping.
>>
>>
>>
>> Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index d75f59ae28e6..485a8ea71394 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5090,6 +5090,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>>   	gather->freelist = domain_unmap(dmar_domain, start_pfn,
>>   					last_pfn, gather->freelist);
>>   
>> +	dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
>> +
>>   	if (dmar_domain->max_addr == iova + size)
>>   		dmar_domain->max_addr = iova;
>>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
