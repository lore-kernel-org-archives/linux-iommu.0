Return-Path: <SRS0=awBX=FE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40904C64E7B
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 17:50:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4B92074A
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 17:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tys5SdwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4B92074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52BB786937;
	Mon, 30 Nov 2020 17:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZRr5fsgVjOo; Mon, 30 Nov 2020 17:50:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E5298686D;
	Mon, 30 Nov 2020 17:50:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30814C0859;
	Mon, 30 Nov 2020 17:50:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDC11C0052
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 17:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BBA238728B
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 17:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xcVmBTSGEEbJ for <iommu@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:50:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CF3DE8727F
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606758607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSCV7T+Nrw6Gul8hhY06LNx7QhAZMZ6fOF3OCzdbisE=;
 b=Tys5SdwTaNUH+aui1dhaTifh5z1MLFeU7jFI+ynRCvJ3L4IjFXLxJSoLWOhVDQp8T6lWe0
 zfxYYq8f30MHy2IiUyEuPdFu3k/JKhuPVV4JjzgnyufKw/T/K0eL5tvsX5Rsih39W1FJiZ
 UtDUIbJhRxUaZAsX3qCdavruAHU7SEo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-6MdylWrkMNSI3C8CdRoeUg-1; Mon, 30 Nov 2020 12:50:04 -0500
X-MC-Unique: 6MdylWrkMNSI3C8CdRoeUg-1
Received: by mail-qt1-f200.google.com with SMTP id d9so8894143qtr.5
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 09:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=HSCV7T+Nrw6Gul8hhY06LNx7QhAZMZ6fOF3OCzdbisE=;
 b=N4kk7wu+UGbc4fd+sSVsb955wRQQHQT9t9+QR4RVTDL05rkqLuL/uz6ekHJQZHzYnc
 5NelKjrSgRR843qk7irRR5gzU/ObGPnjhEjLknbJaKkr7YylnGyi/Fn+EgjR3z2TpnN6
 ESTBcv39ejvzAAxr7nuAwdaQUAhseWWOygV2jHVzZfvVUKiuZDNMA0DbzH44a8h4yYyT
 Bhyzpv8vyk9zVry4AjUc8OKIrvyoJJIgjC/NxtOWNj2kur8kBzmiToDtWISXAobginXe
 UIZPaW4kD6C3C2pokkw8uEQYy5ymjRrGR2X6mJHZC2CaY/BfzWM3CfPW5WdB0v7/fV1V
 fRng==
X-Gm-Message-State: AOAM533/GrQXQAYFCkbv/NYbTlU5NwLU5bj0kHR952L+P7WWaqWE4jbJ
 iCwJOxZ8q8HXTP0iZRHEvj2ev71YTQA5bSIcdBk6VZgIkcM2oFUlQ0yJh+MrqenK8z0iILHBjNE
 wlfaLFqWDdDJXJX8SBydMmyyhxkJ2Zg==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr22837101qta.375.1606758603656; 
 Mon, 30 Nov 2020 09:50:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeE1KMRYS8ZnehWgh0wHCpn3AyJ9/3hJkmwxezbbi5OKJ+2cW7RrT9y4YlUKC7CiuoaENtYA==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr22837070qta.375.1606758603403; 
 Mon, 30 Nov 2020 09:50:03 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id w65sm16073360qtd.94.2020.11.30.09.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 09:50:02 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
Date: Mon, 30 Nov 2020 10:50:01 -0700
Message-ID: <87r1oaka46.fsf@redhat.com>
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


Lu Baolu @ 2020-11-26 19:12 MST:

> Hi Jerry,
>
> On 11/27/20 5:35 AM, Jerry Snitselaar wrote:
>> Lu Baolu @ 2020-11-26 04:01 MST:
>> 
>>> Hi Jerry,
>>>
>>> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>>>> Is there a reason we check the requested guest address width against
>>>> the
>>>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>>>> I've run into a case with a new system where the mgaw reported is 57,
>>>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>>>> the highest supported agaw is 48 and the domain_init code fails here. In
>>>
>>> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
>>> maybe have to add a platform specific quirk to set mgaw to the highest
>>> supported agaw?
>>>
>>> Best regards,
>>> baolu
>> Is there somewhere you can point me to that discusses how they
>> should be
>> setting the mgaw? I misunderstood when I previously asked you about
>> whether the mgaw could be a value that was greater than any of sagaw.
>> If it is a bios issue, then they should fix it there.
>
> MGAW indicates the max gpa width supported by 2nd translation. The VT-d
> spec requires that this value must be at least equal to the host
> physical addressibility. According to this, BIOS is good, right?
>
> For this failure case, domain_init() just wants to find a suitable agaw
> for the private domain. I think it makes sense to check against
> iommu->agaw instead of cap_mgaw.
>
> Best regards,
> baolu
>

From this bit in the spec about MGAW:

    Guest addressability for a given DMA request is limited to the
    minimum of the value reported through this field and the adjusted
    guest address width of the corresponding page-table structure.
    (Adjusted guest address widths supported by hardware are reported
    through the SAGAW field).

That does suggest it should be adjusted down to the sagaw value in this case, yes?
Just want to make sure I'm understanding it correctly.

>> 
>>>
>>>> other places like prepare_domain_attach_device, the dmar domain agaw
>>>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>>>> determined based off what is reported for sagaw. I'm wondering if it
>>>> can't instead do:
>>>> ---
>>>>    drivers/iommu/intel-iommu.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>> diff --git a/drivers/iommu/intel-iommu.c
>>>> b/drivers/iommu/intel-iommu.c
>>>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>>    	domain_reserve_special_ranges(domain);
>>>>    	/* calculate AGAW */
>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>> -	        guest_width = cap_mgaw(iommu->cap);
>>>> +	if (guest_width > agaw_to_width(iommu->agaw))
>>>> +	        guest_width = agaw_to_width(iommu->agaw);
>>>>    	domain->gaw = guest_width;
>>>>    	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>>    	agaw = width_to_agaw(adjust_width);
>>>> --
>>>> 2.27.0
>>>>
>>>> Thoughts? With the former code the ehci device for the ilo fails when
>>>> trying to get a private domain.
>>>> Thanks,
>>>> Jerry
>>>>
>> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
