Return-Path: <SRS0=HOXO=5O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85567C43331
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 07:21:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AF620748
	for <iommu@archiver.kernel.org>; Sun, 29 Mar 2020 07:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AF620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 17A268643D;
	Sun, 29 Mar 2020 07:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XHyjUSlsNjOX; Sun, 29 Mar 2020 07:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AB9986113;
	Sun, 29 Mar 2020 07:21:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74277C089E;
	Sun, 29 Mar 2020 07:21:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AACD4C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 07:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1A778643D
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 07:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OIiER9nCjX7P for <iommu@lists.linux-foundation.org>;
 Sun, 29 Mar 2020 07:21:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id ADB628638F
 for <iommu@lists.linux-foundation.org>; Sun, 29 Mar 2020 07:21:03 +0000 (UTC)
IronPort-SDR: ilfAC909UwqkxTS+Cyp/gQKYOP4sMNfeJJYvhChj3pmEOq6XutpkL3UsJWuAAOQ17zkPBLalow
 nXGAhvDTei/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 00:21:03 -0700
IronPort-SDR: fI3FpOsSUfHzysvV2GBzOrfDHcQOb/YpAAA/E6IWpi0ONKLiVq0oNBf4P1u6/2IfvMGwJc5YRf
 dniQjCgFZNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,319,1580803200"; d="scan'208";a="358882903"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.24])
 ([10.254.210.24])
 by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2020 00:20:56 -0700
Subject: Re: [PATCH V10 03/11] iommu/vt-d: Add a helper function to skip agaw
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d17053c3-9a40-837a-dffa-57492cded028@linux.intel.com>
Date: Sun, 29 Mar 2020 15:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED8FF@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

On 2020/3/27 19:53, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Saturday, March 21, 2020 7:28 AM
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> could you elaborate in which scenario this helper function is required?

I added below commit message:

     An Intel iommu domain uses 5-level page table by default. If the
     iommu that the domain tries to attach supports less page levels,
     the top level page tables should be skipped. Add a helper to do
     this so that it could be used in other places.

Best regards,
baolu

>   
>> ---
>>   drivers/iommu/intel-pasid.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 22b30f10b396..191508c7c03e 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -500,6 +500,28 @@ int intel_pasid_setup_first_level(struct intel_iommu
>> *iommu,
>>   }
>>
>>   /*
>> + * Skip top levels of page tables for iommu which has less agaw
>> + * than default. Unnecessary for PT mode.
>> + */
>> +static inline int iommu_skip_agaw(struct dmar_domain *domain,
>> +				  struct intel_iommu *iommu,
>> +				  struct dma_pte **pgd)
>> +{
>> +	int agaw;
>> +
>> +	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>> +		*pgd = phys_to_virt(dma_pte_addr(*pgd));
>> +		if (!dma_pte_present(*pgd)) {
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	pr_debug_ratelimited("%s: pgd: %llx, agaw %d d_agaw %d\n",
>> __func__, (u64)*pgd,
>> +		iommu->agaw, domain->agaw);
>> +
>> +	return agaw;
>> +}
>> +
>> +/*
>>    * Set up the scalable mode pasid entry for second only translation type.
>>    */
>>   int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>> --
>> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
