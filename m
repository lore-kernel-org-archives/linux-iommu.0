Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3FCC63777
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 21:35:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC37520872
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 21:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haJwrw/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC37520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2E5FB2E25D;
	Thu, 26 Nov 2020 21:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7aP41iQVkar2; Thu, 26 Nov 2020 21:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0FD220494;
	Thu, 26 Nov 2020 21:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77B74C0891;
	Thu, 26 Nov 2020 21:35:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E3BC0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 21:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA631878ED
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 21:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MuxXVB3G1FU for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 21:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A6F4F878DF
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606426536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z982jnqmuXNIrAhimGtzkblqKSt24Z3qnI8EZ/1iDQY=;
 b=haJwrw/lHDJi6u7357ieuFEuzotNvbt9IjFVV8S88ui+F2R+1v+GgPSW6B8LB0IIIsrwwW
 hmZOwVQEIWbT9UIukwqGiZtT7YiFhWTqpH/zCqDjuQxBtPFV87xvr1cMUsuSNQgHkWmmeb
 FvCKeOsNUsabPDIRrOph1io96SqbY9M=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-zCnYnPmwPbCGvb3vE5Nrwg-1; Thu, 26 Nov 2020 16:35:34 -0500
X-MC-Unique: zCnYnPmwPbCGvb3vE5Nrwg-1
Received: by mail-pf1-f197.google.com with SMTP id 9so2384073pfn.5
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 13:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=z982jnqmuXNIrAhimGtzkblqKSt24Z3qnI8EZ/1iDQY=;
 b=bcE2M6niNFOJDs6xBcCRVJDta58Sg1S6te1NqnTmJp4a6RyeQ/KwH21mpQ7C1FANun
 QYQmc1rmKvlR8HpInZZW18I7z8e7ZqwK04qp4jUyxOSdsvZcr4w5eki46NdnIe+t+rvw
 4Tnzw6LHs5UohbfelRL7i637kWkfG2mqjPI00lYUmIN6F7SeTqm19xFI7LhmqU6Q+klt
 BfLGE8TgqJNisu4BMxh6EklF8AERSj2gyfAi8SvnLD1MXcBJs0tWq4auHi/ni2TolujV
 42ot0bxde0mcaX54wQbkCKb2LVcrqI3KDn9idpjd8GmskUFIxysSzssCdX8cMxXjJcOS
 Sleg==
X-Gm-Message-State: AOAM53395ByIPElwiFWvJY3bdct+iAF6vRhQxf6Fytkoy6yCrVcVoWGf
 FCkCy/q/t6B+XcW48Y/y28SdvCDvGkUMg5mWeG5kGqbhTV+9/DnFkgXvL9tfNkAIoQ8KzSStV5y
 ySoaDwyd9K9mNYKeT+9xr95WhOza1Gw==
X-Received: by 2002:a17:90a:de86:: with SMTP id
 n6mr5636641pjv.214.1606426533156; 
 Thu, 26 Nov 2020 13:35:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAlUToijww7RFSIadHfTUIsFRgP0jROP7USN5shf1kH7HUlqvESAgcIckwBz8UQwmCwAYwNw==
X-Received: by 2002:a17:90a:de86:: with SMTP id
 n6mr5636628pjv.214.1606426532884; 
 Thu, 26 Nov 2020 13:35:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id z126sm5587671pfz.120.2020.11.26.13.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 13:35:31 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
Date: Thu, 26 Nov 2020 14:35:30 -0700
Message-ID: <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
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


Lu Baolu @ 2020-11-26 04:01 MST:

> Hi Jerry,
>
> On 2020/11/26 4:27, Jerry Snitselaar wrote:
>> Is there a reason we check the requested guest address width against
>> the
>> iommu's mgaw, instead of the agaw that we already know for the iommu?
>> I've run into a case with a new system where the mgaw reported is 57,
>> but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
>> the highest supported agaw is 48 and the domain_init code fails here. In
>
> Isn't this a platform bug? If it's too late to fix it in the BIOS, you
> maybe have to add a platform specific quirk to set mgaw to the highest
> supported agaw?
>
> Best regards,
> baolu

Is there somewhere you can point me to that discusses how they should be
setting the mgaw? I misunderstood when I previously asked you about
whether the mgaw could be a value that was greater than any of sagaw.
If it is a bios issue, then they should fix it there.

>
>> other places like prepare_domain_attach_device, the dmar domain agaw
>> gets adjusted down to the iommu agaw. The agaw of the iommu gets
>> determined based off what is reported for sagaw. I'm wondering if it
>> can't instead do:
>> ---
>>   drivers/iommu/intel-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/iommu/intel-iommu.c
>> b/drivers/iommu/intel-iommu.c
>> index 6ca5c92ef2e5..a8e41ec36d9e 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>   	domain_reserve_special_ranges(domain);
>>   	/* calculate AGAW */
>> -	if (guest_width > cap_mgaw(iommu->cap))
>> -	        guest_width = cap_mgaw(iommu->cap);
>> +	if (guest_width > agaw_to_width(iommu->agaw))
>> +	        guest_width = agaw_to_width(iommu->agaw);
>>   	domain->gaw = guest_width;
>>   	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>   	agaw = width_to_agaw(adjust_width);
>> --
>> 2.27.0
>> 
>> Thoughts? With the former code the ehci device for the ilo fails when
>> trying to get a private domain.
>> Thanks,
>> Jerry
>> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
