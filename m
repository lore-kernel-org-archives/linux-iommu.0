Return-Path: <SRS0=gCe8=2L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7FDC2D0C8
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 02:27:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54242070C
	for <iommu@archiver.kernel.org>; Sat, 21 Dec 2019 02:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54242070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99B0C8827C;
	Sat, 21 Dec 2019 02:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uO5bMk79uwdz; Sat, 21 Dec 2019 02:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63A408820A;
	Sat, 21 Dec 2019 02:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49549C1796;
	Sat, 21 Dec 2019 02:27:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4C13C077D
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BDD4F20519
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x5u0+S3h9FDA for <iommu@lists.linux-foundation.org>;
 Sat, 21 Dec 2019 02:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id B88572034C
 for <iommu@lists.linux-foundation.org>; Sat, 21 Dec 2019 02:27:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 18:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; d="scan'208";a="228779440"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 18:27:45 -0800
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Setup pasid entries for iova over
 first level
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
 <20191219031634.15168-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C25743A13A334@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <84fd6b9e-0226-cc5f-b51a-884f834d4556@linux.intel.com>
Date: Sat, 21 Dec 2019 10:26:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A13A334@SHSMSX104.ccr.corp.intel.com>
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

Hi Yi,

On 12/20/19 7:44 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, December 19, 2019 11:17 AM
>> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>;
>> Alex Williamson <alex.williamson@redhat.com>
>> Subject: [PATCH v4 4/7] iommu/vt-d: Setup pasid entries for iova over first level
>>
>> Intel VT-d in scalable mode supports two types of page tables for IOVA translation:
>> first level and second level. The IOMMU driver can choose one from both for IOVA
>> translation according to the use case. This sets up the pasid entry if a domain is
>> selected to use the first-level page table for iova translation.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++++--
>>   include/linux/intel-iommu.h | 16 ++++++++-----
>>   2 files changed, 56 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 2b5a47584baf..f0813997dea2 100644
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
>> +		prot |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
>>
>>   	if (!sg) {
>>   		sg_res = nr_pages;
>> @@ -2515,6 +2522,36 @@ dmar_search_domain_by_dev_info(int segment, int bus,
>> int devfn)
>>   	return NULL;
>>   }
>>
>> +static int domain_setup_first_level(struct intel_iommu *iommu,
>> +				    struct dmar_domain *domain,
>> +				    struct device *dev,
>> +				    int pasid)
>> +{
>> +	int flags = PASID_FLAG_SUPERVISOR_MODE;
> 
> Hi Baolu,
> 
> Could you explain a bit why PASID_FLAG_SUPERVISOR_MODE is
> required?
> 

This flag indicates a PASID which can be used for access to kernel
addresses (static 1:1 only). Otherwise, DMA requests requesting
supervisor level privilege level will be blocked.

> Regards,
> Yi Liu
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
