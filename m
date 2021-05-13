Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE2FC433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:11:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF93C61408
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF93C61408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93C63606C1;
	Thu, 13 May 2021 03:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WnoOQ5BkHlbh; Thu, 13 May 2021 03:11:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6710660685;
	Thu, 13 May 2021 03:11:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 497E6C000E;
	Thu, 13 May 2021 03:11:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69B78C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:11:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FE5F40F8A
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id An1lCRguK7BH for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 03:11:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6614540F82
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:11:14 +0000 (UTC)
IronPort-SDR: rAGQzfAiL/1lnJYN+gLS4paOyEfmbvcV6myBQOSikiyEHJk3XDwyVU5w2YgFruTxvCb007XR7y
 6WmneWSHoOYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="180120881"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="180120881"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 20:11:12 -0700
IronPort-SDR: rYgEoMOfzV+LgG65pLR0vcGBSB+6puHbSyeU7qACrWjxPvcwfOCr8KkY6Sx2peHCyH3k/0tf/P
 uuEpxSDxI9YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="623088032"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:11:09 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
 <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
 <2eb677d1-14d7-c1dc-6dd4-179c11c76b10@linux.intel.com>
 <BN6PR11MB187532A1AD69016E2AE0ECF38C519@BN6PR11MB1875.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e735211a-1afc-ab0e-aa8a-c43ef60d0e1b@linux.intel.com>
Date: Thu, 13 May 2021 11:10:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB187532A1AD69016E2AE0ECF38C519@BN6PR11MB1875.namprd11.prod.outlook.com>
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

On 5/13/21 10:26 AM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, May 12, 2021 7:31 PM
>>
>> Hi Kevin,
>>
>> On 5/12/21 4:30 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, May 12, 2021 3:04 PM
>>>>
>>>> Current VT-d implementation supports nested translation only if all
>>>> underlying IOMMUs support the nested capability. This is unnecessary
>>>> as the upper layer is allowed to create different containers and set
>>>> them with different type of iommu backend. The IOMMU driver needs to
>>>> guarantee that devices attached to a nested mode iommu_domain should
>>>> support nested capabilility.
>>> so the consistency check is now applied only to the IOMMUs that are
>>> spanned by a given iommu_domain?
>> Yes.
>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>>>>    1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index f1742da42478..1cd4840e6f9f 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -4755,6 +4755,13 @@ static int
>> prepare_domain_attach_device(struct
>>>> iommu_domain *domain,
>>>>    	if (!iommu)
>>>>    		return -ENODEV;
>>>>
>>>> +	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
>>>> +	    !ecap_nest(iommu->ecap)) {
>>>> +		dev_err(dev, "%s: iommu not support nested translation\n",
>>>> +			iommu->name);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>>    	/* check if this iommu agaw is sufficient for max mapped address */
>>>>    	addr_width = agaw_to_width(iommu->agaw);
>>>>    	if (addr_width > cap_mgaw(iommu->cap))
>>>> @@ -5451,11 +5458,21 @@ static int
>>>>    intel_iommu_enable_nesting(struct iommu_domain *domain)
>>>>    {
>>>>    	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>>> +	struct dmar_drhd_unit *drhd;
>>>> +	struct intel_iommu *iommu;
>>>> +	bool has_nesting = false;
>>>>    	unsigned long flags;
>>>> -	int ret = -ENODEV;
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	for_each_active_iommu(iommu, drhd)
>>>> +		if (ecap_nest(iommu->ecap))
>>>> +			has_nesting = true;
>>>> +
>>>> +	if (!has_nesting)
>>>> +		return -ENODEV;
>>> Isn't above still doing global consistency check?
>> The logic is if nested mode is globally unsupported, return false.
> why is this check required? anyway you already have the check when
> prepare device attachment, and only at that point you have accurate
> info for which iommu to be checked. This check looks meaningless
> as even if some IOMMUs support nesting it doesn't mean the IOMMU
> relevant to this domain support it.
> 

Get you. It's really unnecessary. I will drop this check in the new
version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
