Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A165C2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:55:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732FA206F1
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732FA206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D987A20441;
	Mon, 23 Nov 2020 13:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0detMOqsX5Qu; Mon, 23 Nov 2020 13:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9ABDD2049F;
	Mon, 23 Nov 2020 13:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63522C0891;
	Mon, 23 Nov 2020 13:54:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 540BFC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4D69185514
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aHmu4nRsd-NI for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 13:54:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6162C84DDC
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:54:56 +0000 (UTC)
IronPort-SDR: hfZM4B4vMewYcHldzw3jHn52zexfwZ14ByJVU515lBq7D8oFlkdrIllsyeMKrQ1BA5OMiXafI1
 DHss0HgVcyCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="170981846"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; d="scan'208";a="170981846"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2020 05:54:54 -0800
IronPort-SDR: ujcBQ6RvfszZYenJ8xid3jLrnvKfurOLfhNZE08oJqQlaw5VQnzKnrOUCgYi+g8M8VkawmKZFb
 jB9SXcg5o/dw==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; d="scan'208";a="546420754"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.240])
 ([10.254.210.240])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2020 05:54:51 -0800
Subject: Re: [PATCH v9 1/4] iommu: Move def_domain type check for untrusted
 device into core
To: Will Deacon <will@kernel.org>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
 <20201121135620.3496419-2-baolu.lu@linux.intel.com>
 <20201123120449.GB10233@willie-the-truck>
 <5f6f0d5e-0cfc-2274-b186-180f50b8b1df@linux.intel.com>
 <20201123130335.GD10233@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c75c2981-11bd-74c0-289b-c2eb198bb5ab@linux.intel.com>
Date: Mon, 23 Nov 2020 21:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123130335.GD10233@willie-the-truck>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Will,

On 2020/11/23 21:03, Will Deacon wrote:
> Hi Baolu,
> 
> On Mon, Nov 23, 2020 at 08:55:17PM +0800, Lu Baolu wrote:
>> On 2020/11/23 20:04, Will Deacon wrote:
>>> On Sat, Nov 21, 2020 at 09:56:17PM +0800, Lu Baolu wrote:
>>>> @@ -1645,13 +1655,10 @@ struct __group_domain_type {
>>>>    static int probe_get_default_domain_type(struct device *dev, void *data)
>>>>    {
>>>> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
>>>>    	struct __group_domain_type *gtype = data;
>>>>    	unsigned int type = 0;
>>>> -	if (ops->def_domain_type)
>>>> -		type = ops->def_domain_type(dev);
>>>> -
>>>> +	type = iommu_get_mandatory_def_domain_type(dev);
>>>
>>> afaict, this code is only called from probe_alloc_default_domain(), which
>>> has:
>>>
>>>           /* Ask for default domain requirements of all devices in the group */
>>>           __iommu_group_for_each_dev(group, &gtype,
>>>                                      probe_get_default_domain_type);
>>>
>>>           if (!gtype.type)
>>>                   gtype.type = iommu_def_domain_type;
>>>
>>> so is there actually a need to introduce the new
>>> iommu_get_mandatory_def_domain_type() function, given that a type of 0
>>> always ends up resolving to the default domain type?
>>
>> Another consumer of this helper is in the next patch:
>>
>> +	dev_def_dom = iommu_get_mandatory_def_domain_type(dev);
>> +
>> +	/* Check if user requested domain is supported by the device or not */
>> +	if (!type) {
>> +		/*
>> +		 * If the user hasn't requested any specific type of domain and
>> +		 * if the device supports both the domains, then default to the
>> +		 * domain the device was booted with
>> +		 */
>> +		type = iommu_get_def_domain_type(dev);
>> +	} else if (dev_def_dom && type != dev_def_dom) {
>> +		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
>> +				    iommu_domain_type_str(type));
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>>
>> I also added the untrusted device check in
>> iommu_get_mandatory_def_domain_type(), so that we don't need to care
>> about this in multiple places.
> 
> I see, but isn't this also setting the default domain type in the case that
> it gets back a type of 0? I think it would be nice to avoid having both
> iommu_get_mandatory_def_domain_type() and iommu_get_def_domain_type() of we
> can, as it's really not clear which one to use when and what is meant by
> "mandatory" imo.

Yes, agreed. I will remove iommu_get_mandatory_def_domain_type() and
keep iommu_get_def_domain_type() as the only helper in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
