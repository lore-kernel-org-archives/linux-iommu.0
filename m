Return-Path: <SRS0=0Wzb=2E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA59C2D0BF
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 03:04:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E484E2073D
	for <iommu@archiver.kernel.org>; Sat, 14 Dec 2019 03:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E484E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A956588543;
	Sat, 14 Dec 2019 03:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtv5EuDEweih; Sat, 14 Dec 2019 03:04:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E524F88534;
	Sat, 14 Dec 2019 03:04:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3CEDC1D7C;
	Sat, 14 Dec 2019 03:04:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91CEFC0881
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 784DC86CF4
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LxDw54kPQGXz for <iommu@lists.linux-foundation.org>;
 Sat, 14 Dec 2019 03:04:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 31684857A3
 for <iommu@lists.linux-foundation.org>; Sat, 14 Dec 2019 03:04:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2019 19:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,312,1571727600"; d="scan'208";a="226476032"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 13 Dec 2019 19:04:38 -0800
Subject: Re: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over
 first level
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191211021219.8997-1-baolu.lu@linux.intel.com>
 <20191211021219.8997-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A1309A9@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <acb93807-7a78-b81a-3b27-fde9ee4d7edb@linux.intel.com>
Date: Sat, 14 Dec 2019 11:03:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1309A9@SHSMSX104.ccr.corp.intel.com>
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

Thanks for reviewing my patch.

On 12/13/19 5:23 PM, Liu, Yi L wrote:
>> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Behalf
>> Of Lu Baolu
>> Sent: Wednesday, December 11, 2019 10:12 AM
>> Subject: [PATCH v3 4/6] iommu/vt-d: Setup pasid entries for iova over first level
>>
>> Intel VT-d in scalable mode supports two types of page tables for IOVA translation:
>> first level and second level. The IOMMU driver can choose one from both for IOVA
>> translation according to the use case. This sets up the pasid entry if a domain is
>> selected to use the first-level page table for iova translation.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++++--
>>   include/linux/intel-iommu.h | 10 ++++----
>>   2 files changed, 52 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 2b5a47584baf..83a7abf0c4f0 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -571,6 +571,11 @@ static inline int domain_type_is_si(struct dmar_domain
>> *domain)
>>   	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;  }
>>
>> +static inline bool domain_use_first_level(struct dmar_domain *domain) {
>> +	return domain->flags & DOMAIN_FLAG_USE_FIRST_LEVEL; }
>> +
>>   static inline int domain_pfn_supported(struct dmar_domain *domain,
>>   				       unsigned long pfn)
>>   {
>> @@ -2288,6 +2293,8 @@ static int __domain_mapping(struct dmar_domain
>> *domain, unsigned long iov_pfn,
>>   		return -EINVAL;
>>
>>   	prot &= DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP;
>> +	if (domain_use_first_level(domain))
>> +		prot |= DMA_FL_PTE_PRESENT;
> 
> For DMA_PTE_SNP bit, I think there needs some work. The bit 11 of prot
> should be cleared when FLPT is used for IOVA.

SNP (bit 11) is only for second level. This bit is ignored for first
level page table walk. We should clear this bit for first level anyway.

> 
> Also, we need to set bit 63 "XD" properly. e.g. If bit 11 of prot is set, it
> means snoop required, then "XD" bit is "0". If bit 11 of prot is "0", it means
> this domain is not snooping, so you may want to set "XD" bit as "1". With
> such enhancement, I think IOVA over FLPT would have as less difference
> with IOVA over SLPT.

XD (bit 63) is only for the first level, and SNP (bit 11) is only for
second level, right? I think we need to always set XD bit for IOVA over
FL case. thoughts?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
