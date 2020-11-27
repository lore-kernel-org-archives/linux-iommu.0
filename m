Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F331FC63777
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 02:19:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CFF2222A
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 02:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CFF2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A3E6C2E2BB;
	Fri, 27 Nov 2020 02:19:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAKZO6TaIN5f; Fri, 27 Nov 2020 02:19:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C74FE2E2B2;
	Fri, 27 Nov 2020 02:19:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC9D8C163C;
	Fri, 27 Nov 2020 02:19:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C53D4C0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 02:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B2066879C2
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 02:19:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id To2jprEyGH-M for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 02:19:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5D10A879BF
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 02:19:38 +0000 (UTC)
IronPort-SDR: 58Yg3qZPhuUKvyM2YvLDEfp4u4CPO9e3+mnNPWmpGsIYcXBOW5zWpezq88+IgNldmFs6MCZ5hi
 KWOyA5t4UBOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="160114996"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="160114996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 18:19:37 -0800
IronPort-SDR: FodFk3QrbyI6BY9uQxnhwXY38q6hBzF/dolTaX28Cqh9/1CBQEKcVNVhbibbl5Hnd6FmorPjGt
 7r5AXsbcaVIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="433391800"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2020 18:19:35 -0800
Subject: Re: Question about domain_init (v5.3-v5.7)
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
Date: Fri, 27 Nov 2020 10:12:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, stable@kernel.vger.org,
 iommu@lists.linux-foundation.org
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

Hi Jerry,

On 11/27/20 5:35 AM, Jerry Snitselaar wrote:
> 
> Lu Baolu @ 2020-11-26 04:01 MST:
> 
>> Hi Jerry,
>>
>> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>>> Is there a reason we check the requested guest address width against
>>> the
>>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>>> I've run into a case with a new system where the mgaw reported is 57,
>>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>>> the highest supported agaw is 48 and the domain_init code fails here. In
>>
>> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
>> maybe have to add a platform specific quirk to set mgaw to the highest
>> supported agaw?
>>
>> Best regards,
>> baolu
> 
> Is there somewhere you can point me to that discusses how they should be
> setting the mgaw? I misunderstood when I previously asked you about
> whether the mgaw could be a value that was greater than any of sagaw.
> If it is a bios issue, then they should fix it there.

MGAW indicates the max gpa width supported by 2nd translation. The VT-d
spec requires that this value must be at least equal to the host
physical addressibility. According to this, BIOS is good, right?

For this failure case, domain_init() just wants to find a suitable agaw
for the private domain. I think it makes sense to check against
iommu->agaw instead of cap_mgaw.

Best regards,
baolu

> 
>>
>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>> determined based off what is reported for sagaw. I'm wondering if it
>>> can't instead do:
>>> ---
>>>    drivers/iommu/intel-iommu.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c
>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>    	domain_reserve_special_ranges(domain);
>>>    	/* calculate AGAW */
>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>> -	        guest_width = cap_mgaw(iommu->cap);
>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>    	domain->gaw = guest_width;
>>>    	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>    	agaw = width_to_agaw(adjust_width);
>>> --
>>> 2.27.0
>>>
>>> Thoughts? With the former code the ehci device for the ilo fails when
>>> trying to get a private domain.
>>> Thanks,
>>> Jerry
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
