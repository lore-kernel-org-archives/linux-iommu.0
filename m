Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC2C2D0E4
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 07:48:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05FE2224A
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 07:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2jvkKlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FE2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 17C7187BF1;
	Fri, 27 Nov 2020 07:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqwtVgw9n3YN; Fri, 27 Nov 2020 07:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5091C87BEB;
	Fri, 27 Nov 2020 07:48:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26F9DC0891;
	Fri, 27 Nov 2020 07:48:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93077C0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 07:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 857148769E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 07:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2k6HwcZRE1x for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 07:48:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 09D568766A
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606463310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJsKVULyl1licVBjvw9GEXplfoS+3MJJrDnW+L+outs=;
 b=I2jvkKlqe8SzPCYrdIl/yAqt6IUbo+dy2Hcr7UdZZQ2MVPpZi+nIHX0wvX6c60faV+E2rR
 5VHUXIh1JFbcbM1YwSxBrzc59ksz02AwcwSJIh1KmDoo4G50VqWF8KVNfYZdK17fVE7oRK
 4olOvUpWGzNYWd05a1pFOt5OnF2XO44=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-SVgDNeVFO3y1jUkWmUBJvA-1; Fri, 27 Nov 2020 02:48:28 -0500
X-MC-Unique: SVgDNeVFO3y1jUkWmUBJvA-1
Received: by mail-pg1-f198.google.com with SMTP id c26so973928pgw.3
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 23:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=uJsKVULyl1licVBjvw9GEXplfoS+3MJJrDnW+L+outs=;
 b=Ep4tjaBIUwoEMgUqCTlGsG2s00ccgPoEGjjC0TyhVjfQ0oPcsQ39hP7MaBlNW+P1/V
 Y/Ot9JVRgCJYozaYARkpUW+yLLXcdts8taRCeH9lW3rKZHGVmi3Dup3EERayE511wNmk
 qUwow0lVb1dQk6Eh4dlncFPZvoKKhbbfVo+cnOIeVBmWCqLtPDFgtjVc2DlqEuNl8p7N
 shzpAeG4m2nm4u8r0ZAuY3zptyOJlIN0X4PB5D49KGiaLBOm4UA6H7tMCEPT8Vi56zmS
 HrFYNQ1axK82wx/+U6GaJACJY19HWBS9oxGaQHypvLgbvnVtzEVAIL1bploOWjjZlf2M
 Lllw==
X-Gm-Message-State: AOAM531nnNVGDctN6yvhAMJQxX9KCQs/rzXJRiPeWGv+2SiIkPXhI0DZ
 HE2M4bupLHbUZMjsny+BMYHVso+sVuIih8E89Mlx9jZtw4gtPizg6XfWW8xvUIk1wKZ1Vawo2GV
 R7FaZa+QQBNvH9NK6tCo/TmLM6Rk8/w==
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id
 p15-20020a62ab0f0000b0290197f771fe8emr6026847pff.65.1606463307723; 
 Thu, 26 Nov 2020 23:48:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGG48pY/5mk4xwZDkQuI9zFSfHVl0aycrAZ7jYEAuS/IBOHT3O3tmmGQmXvvIcOEVeSnyoAg==
X-Received: by 2002:a62:ab0f:0:b029:197:f771:fe8e with SMTP id
 p15-20020a62ab0f0000b0290197f771fe8emr6026827pff.65.1606463307401; 
 Thu, 26 Nov 2020 23:48:27 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id e2sm1632021pjt.2.2020.11.26.23.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 23:48:26 -0800 (PST)
References: <87h7pd6v2k.fsf@redhat.com>
 <bd1fd204-3596-b16c-5617-7e691ceac83b@linux.intel.com>
 <87a6v3hkd9.fsf@jsnitsel.users.ipa.redhat.com>
 <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Question about domain_init (v5.3-v5.7)
In-reply-to: <72a7b338-2481-8c0a-5641-6f448557f6ee@linux.intel.com>
Date: Fri, 27 Nov 2020 00:48:25 -0700
Message-ID: <877dq7grzq.fsf@jsnitsel.users.ipa.redhat.com>
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

Yes, the host address width is 46. MGAW reports 57 (56+1), and highest
sagaw bit is for 48.


> For this failure case, domain_init() just wants to find a suitable agaw
> for the private domain. I think it makes sense to check against
> iommu->agaw instead of cap_mgaw.
>
> Best regards,
> baolu
>
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
