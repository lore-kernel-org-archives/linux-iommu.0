Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B91C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:43:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF4F60FDC
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 01:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBF4F60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C3F74018A;
	Mon, 27 Sep 2021 01:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ej0nv28_XpFc; Mon, 27 Sep 2021 01:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7BCF400EA;
	Mon, 27 Sep 2021 01:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C058C000F;
	Mon, 27 Sep 2021 01:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D83CFC000D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBA9480E87
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsdVD7RjVxUO for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 01:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E68B80E82
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 01:43:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224033814"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="224033814"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 18:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; d="scan'208";a="475750354"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 18:43:18 -0700
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5433AF7EE90A4A406E8B1D6E8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3237dbe8-089b-a159-2c40-4e6a04f0ae8d@linux.intel.com>
Date: Mon, 27 Sep 2021 09:39:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433AF7EE90A4A406E8B1D6E8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Raj,
 Ashok" <ashok.raj@intel.com>
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

On 9/27/21 9:33 AM, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Monday, September 27, 2021 9:30 AM
>>
>>> From: Tian, Kevin
>>> Sent: Monday, September 27, 2021 9:12 AM
>>>
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Sunday, September 26, 2021 7:46 PM
>>>>
>>>> An iommu domain could be allocated and mapped before it's attached to
>>>> any
>>>> device. This requires that in scalable mode, when the domain is allocated,
>>>> the format (FL or SL) of the page table must be determined. In order to
>>>> achieve this, the platform should support consistent SL or FL capabilities
>>>> on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
>>>> doesn't meet this requirement.
>>>
>>> Is this a must? Looks the requirement comes from how the current code
>>> is implemented. It sets DOMAIN_FLAG_USE_FIRST_LEVEL flag in
>>> alloc_domain. But actually the pgtable is not allocated until the 1st device
>>> is attached. If this understanding is correct, you can also postpone the flag
>>> setting until pgtable is actually allocated.
>>
>> Baolu explained to me that RMRR regions are mapped before device
>> attach. So this check is necessary
>>
>>>
>>> of course how to handle inconsistent IOMMU capabilities is another
>>> orthogonal problem. Addressing it should not be only applied to SL/FL
>>> difference. especially this patch doesn't check consistency. it just
>>> checks that an IOMMU must support either SL or FL which doesn't
>>> match the commit msg here.
>>
>> and the overall inconsistency check mechanism is already in place.
>> and the logic here just extends it to cover SL/FL. Given that,
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>
>>
>>>
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/cap_audit.h |  1 +
>>>>   drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
>>>>   2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/intel/cap_audit.h
>>>> b/drivers/iommu/intel/cap_audit.h
>>>> index 74cfccae0e81..d07b75938961 100644
>>>> --- a/drivers/iommu/intel/cap_audit.h
>>>> +++ b/drivers/iommu/intel/cap_audit.h
>>>> @@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
>>>>   bool intel_cap_pasid_sanity(void);
>>>>   bool intel_cap_nest_sanity(void);
>>>>   bool intel_cap_flts_sanity(void);
>>>> +bool intel_cap_slts_sanity(void);
>>>>
>>>>   static inline bool scalable_mode_support(void)
>>>>   {
>>>> diff --git a/drivers/iommu/intel/cap_audit.c
>>>> b/drivers/iommu/intel/cap_audit.c
>>>> index b12e421a2f1a..040e4ae0e42b 100644
>>>> --- a/drivers/iommu/intel/cap_audit.c
>>>> +++ b/drivers/iommu/intel/cap_audit.c
>>>> @@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu
>>>> *iommu, enum cap_audit_type type)
>>>>   			check_irq_capabilities(iommu, i);
>>>>   	}
>>>>
>>>> +	/*
>>>> +	 * If the system is sane to support scalable mode, either SL or FL
>>>> +	 * should be sane.
>>>> +	 */
>>>> +	if (intel_cap_smts_sanity() &&
>>>> +	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
>>>> +		return -EFAULT;
> 
> btw this should not be -EFAULT.

Agreed. I will change it to -ENOTSUPP.

Best regards,
baolu

> 
>>>> +
>>>>   out:
>>>>   	rcu_read_unlock();
>>>>   	return 0;
>>>> @@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
>>>>   {
>>>>   	return ecap_flts(intel_iommu_ecap_sanity);
>>>>   }
>>>> +
>>>> +bool intel_cap_slts_sanity(void)
>>>> +{
>>>> +	return ecap_slts(intel_iommu_ecap_sanity);
>>>> +}
>>>> --
>>>> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
