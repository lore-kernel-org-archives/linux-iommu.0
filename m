Return-Path: <SRS0=awBX=FE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D18CC63777
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 18:03:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D6A20705
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 18:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oig+K37a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 195D6872A7;
	Mon, 30 Nov 2020 18:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eL5DgO+ijfV; Mon, 30 Nov 2020 18:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6921287260;
	Mon, 30 Nov 2020 18:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47A9CC0859;
	Mon, 30 Nov 2020 18:03:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59870C0052
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 18:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3149B22EC9
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 18:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIhh5B3YdR2a for <iommu@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 18:03:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 419E92309D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606759391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IjO539zdN8HjiYFMjOQqvVcvUesK6209o4vdNV3SREM=;
 b=Oig+K37aA3eiKQtd69nveE8XlR0zM+xb0XXupDj2EiFIctKZSFjDhNK/4CJyJ8wEfzD0EL
 jlPoD+bureHT5LT2XZWng6qYg8dfUCDf+kX+Ni/jYl9GPxXp3Y6MJBjePQKjODc/7sD3dq
 nIYm8eQk8ehwjRX2QEZgCZsWhXUQBvo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-0gayhna7ODWzv_6pxG_h-Q-1; Mon, 30 Nov 2020 13:03:09 -0500
X-MC-Unique: 0gayhna7ODWzv_6pxG_h-Q-1
Received: by mail-qt1-f199.google.com with SMTP id v18so8876290qta.22
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=IjO539zdN8HjiYFMjOQqvVcvUesK6209o4vdNV3SREM=;
 b=Vq3qG0AVJsJaIq9jhqWkYQ1p9wlfGObQBPTIAMF1Uc9OYRKHctqS9qSmY96LsUcK7H
 Jd7m7jDX56aSNC+cgFR1KQdows8Hd/uxJku1Y4IqBozyduSv+6pyu1YmPd0baDWscnRz
 rRn8yCbGe/UO6ix5Nsl1f/BcgWll+LhdKnSZtRW2YrlAGhheoGvT3iso4a4+C27yceGd
 apFrTij6Ht8BFG7bYbiCM0WTxhB1Q283bxRgnZVlhFT4rAzTw1n6V83TZUEcdDkpifKR
 oOEnQSY1jrhwpTBu3upH2JVNClHjdOA9/F5gPPGHrpJp3HhpVEssHIqwOQ8gJnczPzcH
 R6HA==
X-Gm-Message-State: AOAM531iRehILTODMg9lG1oQOG8qXB4HmfTs2N9oTHJ3/WYAdogRS4dl
 Mm2qCoHUC4N6AzQ0T+QMl6KNN8WtJpJpQbICj+a7AmJTXpljbbLD9z8NCNDFZcfBXqpQlnNbW0P
 lBMspgTDg+ARyUMh7DUZvnTww0UOsmw==
X-Received: by 2002:ac8:7659:: with SMTP id i25mr22916976qtr.78.1606759389272; 
 Mon, 30 Nov 2020 10:03:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRJvxAhbTS9KL6Nff1yDaG0kUy/6s8MStlHfEYSeeNfjb5Uc4rTqChF+46Aq9yfnZLLoHrGQ==
X-Received: by 2002:ac8:7659:: with SMTP id i25mr22916958qtr.78.1606759389036; 
 Mon, 30 Nov 2020 10:03:09 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id o8sm16308773qtm.9.2020.11.30.10.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 10:03:08 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
 <87r1oaka46.fsf@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <87r1oaka46.fsf@redhat.com>
Date: Mon, 30 Nov 2020 11:03:06 -0700
Message-ID: <87o8jek9id.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: stable@kernel.vger.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


Jerry Snitselaar @ 2020-11-30 10:50 MST:

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
> From this bit in the spec about MGAW:
>
>     Guest addressability for a given DMA request is limited to the
>     minimum of the value reported through this field and the adjusted
>     guest address width of the corresponding page-table structure.
>     (Adjusted guest address widths supported by hardware are reported
>     through the SAGAW field).
>
> That does suggest it should be adjusted down to the sagaw value in this case, yes?
> Just want to make sure I'm understanding it correctly.

Or I guess that is really talking about if you had an mgaw lower than the the
sagaw, the dma request would be limited to that lower mgaw value.

>
>>> 
>>>>
>>>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>>>> determined based off what is reported for sagaw. I'm wondering if it
>>>>> can't instead do:
>>>>> ---
>>>>>    drivers/iommu/intel-iommu.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>>> b/drivers/iommu/intel-iommu.c
>>>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>>>> --- a/drivers/iommu/intel-iommu.c
>>>>> +++ b/drivers/iommu/intel-iommu.c
>>>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>>>    	domain_reserve_special_ranges(domain);
>>>>>    	/* calculate AGAW */
>>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>>> -	        guest_width = cap_mgaw(iommu->cap);
>>>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>>>    	domain->gaw = guest_width;
>>>>>    	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>>>    	agaw = width_to_agaw(adjust_width);
>>>>> --
>>>>> 2.27.0
>>>>>
>>>>> Thoughts? With the former code the ehci device for the ilo fails when
>>>>> trying to get a private domain.
>>>>> Thanks,
>>>>> Jerry
>>>>>
>>> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
