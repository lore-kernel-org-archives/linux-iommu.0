Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E81CC432C0
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 00:33:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249C520674
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 00:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249C520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04C1820402;
	Wed,  4 Dec 2019 00:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9iJH+8sp0QRf; Wed,  4 Dec 2019 00:32:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EF115203D1;
	Wed,  4 Dec 2019 00:32:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8E4CC18DC;
	Wed,  4 Dec 2019 00:32:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D27C4C1798
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BCD398822B
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKk81U5eepF2 for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 00:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 06EE8881BB
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 00:32:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 16:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; d="scan'208";a="223029646"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 03 Dec 2019 16:32:54 -0800
Subject: Re: [PATCH 0/5] iommu/vt-d: Consolidate various cache flush ops
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20191122030449.28892-1-baolu.lu@linux.intel.com>
 <20191202120252.45606c47@jacob-builder>
 <f703c267-c946-30cf-7e0e-4de16edcde18@linux.intel.com>
 <20191203085026.1785292b@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d6ff346e-6b6b-d9cd-c7c8-0e54614c1b37@linux.intel.com>
Date: Wed, 4 Dec 2019 08:32:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203085026.1785292b@jacob-builder>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 12/4/19 12:50 AM, Jacob Pan wrote:
> On Tue, 3 Dec 2019 10:44:45 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Jacob,
>>
>> On 12/3/19 4:02 AM, Jacob Pan wrote:
>>> On Fri, 22 Nov 2019 11:04:44 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> Intel VT-d 3.0 introduces more caches and interfaces for software
>>>> to flush when it runs in the scalable mode. Currently various
>>>> cache flush helpers are scattered around. This consolidates them
>>>> by putting them in the existing iommu_flush structure.
>>>>
>>>> /* struct iommu_flush - Intel IOMMU cache invalidation ops
>>>>    *
>>>>    * @cc_inv: invalidate context cache
>>>>    * @iotlb_inv: Invalidate IOTLB and paging structure caches when
>>>> software
>>>>    *             has changed second-level tables.
>>>>    * @p_iotlb_inv: Invalidate IOTLB and paging structure caches when
>>>> software
>>>>    *               has changed first-level tables.
>>>>    * @pc_inv: invalidate pasid cache
>>>>    * @dev_tlb_inv: invalidate cached mappings used by
>>>> requests-without-PASID
>>>>    *               from the Device-TLB on a endpoint device.
>>>>    * @p_dev_tlb_inv: invalidate cached mappings used by
>>>> requests-with-PASID
>>>>    *                 from the Device-TLB on an endpoint device
>>>>    */
>>>> struct iommu_flush {
>>>>           void (*cc_inv)(struct intel_iommu *iommu, u16 did,
>>>>                          u16 sid, u8 fm, u64 type);
>>>>           void (*iotlb_inv)(struct intel_iommu *iommu, u16 did, u64
>>>> addr, unsigned int size_order, u64 type);
>>>>           void (*p_iotlb_inv)(struct intel_iommu *iommu, u16 did,
>>>> u32 pasid, u64 addr, unsigned long npages, bool ih);
>>>>           void (*pc_inv)(struct intel_iommu *iommu, u16 did, u32
>>>> pasid, u64 granu);
>>>>           void (*dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
>>>> u16 pfsid, u16 qdep, u64 addr, unsigned int mask);
>>>>           void (*p_dev_tlb_inv)(struct intel_iommu *iommu, u16 sid,
>>>> u16 pfsid, u32 pasid, u16 qdep, u64 addr,
>>>>                                 unsigned long npages);
>>>> };
>>>>
>>>> The name of each cache flush ops is defined according to the spec
>>>> section 6.5 so that people are easy to look up them in the spec.
>>>>   
>>> Nice consolidation. For nested SVM, I also introduced cache flushed
>>> helpers as needed.
>>> https://lkml.org/lkml/2019/10/24/857
>>>
>>> Should I wait for yours to be merged or you want to extend the this
>>> consolidation after SVA/SVM cache flush? I expect to send my v8
>>> shortly.
>>
>> Please base your v8 patch on this series. So it could get more chances
>> for test.
>>
> Sounds good.

I am sorry I need to spend more time on this patch series. Please go
ahead without it.

Best regards,
baolu

> 
>> I will queue this patch series for internal test after 5.5-rc1 and if
>> everything goes well, I will forward it to Joerg around rc4 for linux-
>> next.
>>
>> Best regards,
>> baolu
> 
> [Jacob Pan]
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
