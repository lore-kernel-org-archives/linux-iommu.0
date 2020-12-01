Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C730C64E90
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 02:45:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F2420809
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 02:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F2420809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B3D1B2D3FC;
	Tue,  1 Dec 2020 02:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLgACc7H8xwd; Tue,  1 Dec 2020 02:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8A513274D1;
	Tue,  1 Dec 2020 02:45:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 781EFC163C;
	Tue,  1 Dec 2020 02:45:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C02AAC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 02:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B9D0A8665E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 02:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKFTadJSZKG1 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 02:44:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D69086644
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 02:44:59 +0000 (UTC)
IronPort-SDR: lzVY5+tiq0P9ZZgPvLr01BqC28zDI/EN4tgyLIdipXi9WgmU9NyIPFMiNw49VPS6Up8zxEztj4
 xKzVcpVdQ0Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="160521360"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="160521360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 18:44:58 -0800
IronPort-SDR: pAVrtwovzBP9hzHfyu8zxU+R0f0gt2Iwi81AK+urnntZmSqxVsG+61j+NQpE0IY+jLyKpFypoc
 SXUNg8NkifOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="434495516"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 30 Nov 2020 18:44:56 -0800
Subject: Re: Question about domain_init (v5.3-v5.7)
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
 <87r1oaka46.fsf@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <da740dc6-0a03-afd5-b684-6f8109279d9b@linux.intel.com>
Date: Tue, 1 Dec 2020 10:37:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87r1oaka46.fsf@redhat.com>
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

On 12/1/20 1:50 AM, Jerry Snitselaar wrote:
> 
> Lu Baolu @ 2020-11-26 19:12 MST:
> 
>> Hi Jerry,
>>
>> On 11/27/20 5:35 AM, Jerry Snitselaar wrote:
>>> Lu Baolu @ 2020-11-26 04:01 MST:
>>>
>>>> Hi Jerry,
>>>>
>>>> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>>>>> Is there a reason we check the requested guest address width against
>>>>> the
>>>>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>>>>> I've run into a case with a new system where the mgaw reported is 57,
>>>>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>>>>> the highest supported agaw is 48 and the domain_init code fails here. In
>>>>
>>>> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
>>>> maybe have to add a platform specific quirk to set mgaw to the highest
>>>> supported agaw?
>>>>
>>>> Best regards,
>>>> baolu
>>> Is there somewhere you can point me to that discusses how they
>>> should be
>>> setting the mgaw? I misunderstood when I previously asked you about
>>> whether the mgaw could be a value that was greater than any of sagaw.
>>> If it is a bios issue, then they should fix it there.
>>
>> MGAW indicates the max gpa width supported by 2nd translation. The VT-d
>> spec requires that this value must be at least equal to the host
>> physical addressibility. According to this, BIOS is good, right?
>>
>> For this failure case, domain_init() just wants to find a suitable agaw
>> for the private domain. I think it makes sense to check against
>> iommu->agaw instead of cap_mgaw.
>>
>> Best regards,
>> baolu
>>
> 
>  From this bit in the spec about MGAW:
> 
>      Guest addressability for a given DMA request is limited to the
>      minimum of the value reported through this field and the adjusted
>      guest address width of the corresponding page-table structure.
>      (Adjusted guest address widths supported by hardware are reported
>      through the SAGAW field).
> 
> That does suggest it should be adjusted down to the sagaw value in this case, yes?
> Just want to make sure I'm understanding it correctly.

Yes. I think so.

Best regards,
baolu

> 
>>>
>>>>
>>>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>>>> determined based off what is reported for sagaw. I'm wondering if it
>>>>> can't instead do:
>>>>> ---
>>>>>     drivers/iommu/intel-iommu.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>>> b/drivers/iommu/intel-iommu.c
>>>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>>>     	domain_reserve_special_ranges(domain);
>>>>>     	/* calculate AGAW */
>>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>>> -	        guest_width = cap_mgaw(iommu->cap);
>>>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>>>     	domain->gaw = guest_width;
>>>>>     	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>>>     	agaw = width_to_agaw(adjust_width);
>>>>> --
>>>>> 2.27.0
>>>>>
>>>>> Thoughts? With the former code the ehci device for the ilo fails when
>>>>> trying to get a private domain.
>>>>> Thanks,
>>>>> Jerry
>>>>>
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
