Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49366C433B4
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:32:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD4D613CF
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD4D613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B259402ED;
	Wed, 12 May 2021 11:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j46CvG8ZD0eh; Wed, 12 May 2021 11:32:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B13B400C0;
	Wed, 12 May 2021 11:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD33BC000E;
	Wed, 12 May 2021 11:32:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC2DC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4D8E83F06
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naNV-uuLOq1y for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 11:32:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1673E83EF9
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:32:12 +0000 (UTC)
IronPort-SDR: w11mt1yQUG77fB2vBfl+spNOD1cGzBXAIaFeO2HcmXEaiO2iwRQlFrplWqSWV8mTLgT2boAUpl
 DjgWYD3nzBxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197704901"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="197704901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 04:32:11 -0700
IronPort-SDR: GM0y7i9w2gAupgR5Q0lhYEchbcbaaim1usJ+WvbY5KptixLGwgEioF21ntWT3v7XBDMdSfnAId
 uY8AH9uHx/0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="622371382"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 04:32:08 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
 <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2eb677d1-14d7-c1dc-6dd4-179c11c76b10@linux.intel.com>
Date: Wed, 12 May 2021 19:31:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

Hi Kevin,

On 5/12/21 4:30 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, May 12, 2021 3:04 PM
>>
>> Current VT-d implementation supports nested translation only if all
>> underlying IOMMUs support the nested capability. This is unnecessary
>> as the upper layer is allowed to create different containers and set
>> them with different type of iommu backend. The IOMMU driver needs to
>> guarantee that devices attached to a nested mode iommu_domain should
>> support nested capabilility.
> 
> so the consistency check is now applied only to the IOMMUs that are
> spanned by a given iommu_domain?

Yes.

> 
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index f1742da42478..1cd4840e6f9f 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4755,6 +4755,13 @@ static int prepare_domain_attach_device(struct
>> iommu_domain *domain,
>>   	if (!iommu)
>>   		return -ENODEV;
>>
>> +	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
>> +	    !ecap_nest(iommu->ecap)) {
>> +		dev_err(dev, "%s: iommu not support nested translation\n",
>> +			iommu->name);
>> +		return -EINVAL;
>> +	}
>> +
>>   	/* check if this iommu agaw is sufficient for max mapped address */
>>   	addr_width = agaw_to_width(iommu->agaw);
>>   	if (addr_width > cap_mgaw(iommu->cap))
>> @@ -5451,11 +5458,21 @@ static int
>>   intel_iommu_enable_nesting(struct iommu_domain *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct dmar_drhd_unit *drhd;
>> +	struct intel_iommu *iommu;
>> +	bool has_nesting = false;
>>   	unsigned long flags;
>> -	int ret = -ENODEV;
>> +	int ret = -EINVAL;
>> +
>> +	for_each_active_iommu(iommu, drhd)
>> +		if (ecap_nest(iommu->ecap))
>> +			has_nesting = true;
>> +
>> +	if (!has_nesting)
>> +		return -ENODEV;
> 
> Isn't above still doing global consistency check?

The logic is if nested mode is globally unsupported, return false.

> 
>>
>>   	spin_lock_irqsave(&device_domain_lock, flags);
>> -	if (nested_mode_support() && list_empty(&dmar_domain->devices))
>> {
>> +	if (list_empty(&dmar_domain->devices)) {
>>   		dmar_domain->flags |= DOMAIN_FLAG_NESTING_MODE;
>>   		dmar_domain->flags &= ~DOMAIN_FLAG_USE_FIRST_LEVEL;
>>   		ret = 0;
>> --
>> 2.25.1
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
