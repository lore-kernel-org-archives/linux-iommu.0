Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1CC433E1
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:50:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3155520771
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 01:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3155520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB31588ACF;
	Wed,  1 Jul 2020 01:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKunaYGsIyqd; Wed,  1 Jul 2020 01:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A00D88AD1;
	Wed,  1 Jul 2020 01:50:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 120ABC0865;
	Wed,  1 Jul 2020 01:50:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E3DC016E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A04D888C9C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdBm7mIoWNxg for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 01:50:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA0BB88C9A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 01:50:06 +0000 (UTC)
IronPort-SDR: Di1wD3ZVAKTmNOtuW1Paw/jT/Y1N2rBPZ90+dzqfTwZ9yrv9EuRRbWluHNbt8jTFOcJw5tsKmP
 BcmKmJ7clycg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146425631"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="146425631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 18:50:06 -0700
IronPort-SDR: P4q4STTHl8YHwzmESTyZkAcHTorHeACpmx8HN8RxpEoXVDCH+UGwm/Gnmgu6+NNvxTc3I6e5OM
 YRTDZXbcRj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="265268574"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:50:03 -0700
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
 <20200630103459.6c99c961@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f5a2ffda-a243-ed20-63e0-50d784d3af71@linux.intel.com>
Date: Wed, 1 Jul 2020 09:45:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630103459.6c99c961@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On 7/1/20 1:34 AM, Jacob Pan wrote:
> On Thu, 25 Jun 2020 18:10:43 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Hi,
>>
>> On 2020/6/23 23:43, Jacob Pan wrote:
>>> For guest requested IOTLB invalidation, address and mask are
>>> provided as part of the invalidation data. VT-d HW silently ignores
>>> any address bits below the mask. SW shall also allow such case but
>>> give warning if address does not align with the mask. This patch
>>> relax the fault handling from error to warning and proceed with
>>> invalidation request with the given mask.
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c
>>> b/drivers/iommu/intel/iommu.c index 5ea5732d5ec4..50fc62413a35
>>> 100644 --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
>>> iommu_domain *domain, struct device *dev,
>>>    		switch (BIT(cache_type)) {
>>>    		case IOMMU_CACHE_INV_TYPE_IOTLB:
>>> +			/* HW will ignore LSB bits based on
>>> address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
>>>    			    size &&
>>>    			    (inv_info->addr_info.addr &
>>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
>>> -				pr_err_ratelimited("Address out of
>>> range, 0x%llx, size order %llu\n",
>>> -
>>> inv_info->addr_info.addr, size);
>>> -				ret = -ERANGE;
>>> -				goto out_unlock;
>>> +				WARN_ONCE(1, "Address out of
>>> range, 0x%llx, size order %llu\n",
>>> +
>>> inv_info->addr_info.addr, size);
>> I don't think WARN_ONCE() is suitable here. It makes users think it's
>> a kernel bug. How about pr_warn_ratelimited()?
>>
> I think pr_warn_ratelimited might still be too chatty. There is no
> functional issues, we just don't to silently ignore it. Perhaps just
> say:
> WARN_ONCE(1, "User provided address not page aligned, alignment forced")
> ?
> 

WARN() is normally used for reporting a kernel bug. It dumps kernel
trace. And the users will report bug through bugzilla.kernel.org.

In this case, it's actually an unexpected user input, we shouldn't
treat it as a kernel bug and pr_err_ratelimited() is enough?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
