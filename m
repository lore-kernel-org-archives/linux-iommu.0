Return-Path: <SRS0=0Wzb=2E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E29C2D0C9
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 03:25:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D260424125
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D260424125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CC268869F;
	Sat, 14 Dec 2019 03:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhXtmSWyVmTy; Sat, 14 Dec 2019 03:25:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F10C7885CA;
	Sat, 14 Dec 2019 03:25:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5160C18DD;
	Sat, 14 Dec 2019 03:25:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E672C0881
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 47F7C885D9
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L59-rXiN5c9a for <iommu@lists.linux-foundation.org>;
 Sat, 14 Dec 2019 03:25:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 773ED885CA
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:25:04 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 19:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,312,1571727600"; d="scan'208";a="226478760"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 13 Dec 2019 19:24:59 -0800
Subject: Re: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova over
 first level
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-6-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A130C08@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f1e5cfea-8b11-6d72-8e57-65daea51c050@linux.intel.com>
Date: Sat, 14 Dec 2019 11:24:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A130C08@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

Hi Liu Yi,

On 12/13/19 7:42 PM, Liu, Yi L wrote:
>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Behalf
>> Of Lu Baolu
>> Sent: Wednesday, December 11, 2019 10:12 AM
>> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>;
>> Subject: [PATCH v3 5/6] iommu/vt-d: Flush PASID-based iotlb for iova over first level
>>
>> When software has changed first-level tables, it should invalidate
>> the affected IOTLB and the paging-structure-caches using the PASID-
>> based-IOTLB Invalidate Descriptor defined in spec 6.5.2.4.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/dmar.c        | 41 ++++++++++++++++++++++++++++++++++
>>   drivers/iommu/intel-iommu.c | 44 ++++++++++++++++++++++++-------------
>>   include/linux/intel-iommu.h |  2 ++
>>   3 files changed, 72 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>> index 3acfa6a25fa2..fb30d5053664 100644
>> --- a/drivers/iommu/dmar.c
>> +++ b/drivers/iommu/dmar.c
>> @@ -1371,6 +1371,47 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16
>> sid, u16 pfsid,
>>   	qi_submit_sync(&desc, iommu);
>>   }
>>
>> +/* PASID-based IOTLB invalidation */
>> +void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>> +		     unsigned long npages, bool ih)
>> +{
>> +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
>> +
>> +	/*
>> +	 * npages == -1 means a PASID-selective invalidation, otherwise,
>> +	 * a positive value for Page-selective-within-PASID invalidation.
>> +	 * 0 is not a valid input.
>> +	 */
>> +	if (WARN_ON(!npages)) {
>> +		pr_err("Invalid input npages = %ld\n", npages);
>> +		return;
>> +	}
>> +
>> +	if (npages == -1) {
>> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
>> +				QI_EIOTLB_DID(did) |
>> +				QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
>> +				QI_EIOTLB_TYPE;
>> +		desc.qw1 = 0;
>> +	} else {
>> +		int mask = ilog2(__roundup_pow_of_two(npages));
>> +		unsigned long align = (1ULL << (VTD_PAGE_SHIFT + mask));
>> +
>> +		if (WARN_ON_ONCE(!ALIGN(addr, align)))
>> +			addr &= ~(align - 1);
>> +
>> +		desc.qw0 = QI_EIOTLB_PASID(pasid) |
>> +				QI_EIOTLB_DID(did) |
>> +				QI_EIOTLB_GRAN(QI_GRAN_PSI_PASID) |
>> +				QI_EIOTLB_TYPE;
>> +		desc.qw1 = QI_EIOTLB_ADDR(addr) |
>> +				QI_EIOTLB_IH(ih) |
>> +				QI_EIOTLB_AM(mask);
>> +	}
>> +
>> +	qi_submit_sync(&desc, iommu);
>> +}
>> +
>>   /*
>>    * Disable Queued Invalidation interface.
>>    */
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 83a7abf0c4f0..e47f5fe37b59 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1520,18 +1520,24 @@ static void iommu_flush_iotlb_psi(struct intel_iommu
>> *iommu,
>>
>>   	if (ih)
>>   		ih = 1 << 6;
>> -	/*
>> -	 * Fallback to domain selective flush if no PSI support or the size is
>> -	 * too big.
>> -	 * PSI requires page size to be 2 ^ x, and the base address is naturally
>> -	 * aligned to the size
>> -	 */
>> -	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu-
>>> cap))
>> -		iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> -						DMA_TLB_DSI_FLUSH);
>> -	else
>> -		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
>> -						DMA_TLB_PSI_FLUSH);
>> +
>> +	if (domain_use_first_level(domain)) {
>> +		qi_flush_piotlb(iommu, did, domain->default_pasid,
>> +				addr, pages, ih);
> 
> I'm not sure if my understanding is correct. But let me tell a story.
> Assuming we assign a mdev and a PF/VF to a single VM, then there
> will be p_iotlb tagged with PASID_RID2PASID and p_iotlb tagged with
> default_pasid. We may want to flush both... If this operation is

I assume that SRIOV and SIOV are exclusive. You can't enable both SRIOV
and SIOV on a single device. So the mdev and PF/VF are from different
devices, right?

Or, in SRIOV case, you can wrap a PF or VF as a mediated device. But
this mdev still be backed with a pasid of RID2PASID.

> invoked per-device, then need to pass in a hint to indicate whether
> to use PASID_RID2PASID or default_pasid, or you may just issue two
> flush with the two PASID values. Thoughts?

This is per-domain and each domain has specific domain id and default
pasid (assume default domain is 0 in RID2PASID case).

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
