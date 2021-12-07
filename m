Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D796C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 11:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA6BA4044A;
	Tue,  7 Dec 2021 11:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZujdWJVMkmQ; Tue,  7 Dec 2021 11:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B53FB40439;
	Tue,  7 Dec 2021 11:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63451C001E;
	Tue,  7 Dec 2021 11:18:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4AC5C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B43C540285
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ufOdzpwKtLWV for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:18:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 069DB401CA
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:18:29 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 cq22-20020a17090af99600b001a9550a17a5so1672999pjb.2
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 03:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=XkJS/vk/AFCAw+MrKJZ0hWbQuGoDCAYXbs59fxjYT0Q=;
 b=YiRYLAImUdwYtDAM2dV92jtzYCI7H/oTaQpaYU9J3BTdl9mZzWQvXZstH079RAnzrO
 BKa0r12fG0lYvHIKhYcvZ5/oQiXQI7/ElY7ki15eMt2zl5xnYcm+WUhDAb1iJO8dgurD
 cuaqGlcHLKSI88ln4GStddlJ6GvQmebeg4h/Yrg6MVNZwkXhYpK4afH5hKuQviglzk7h
 QJ5RXCb+/wBTk4zWrQG/4SWebKyPujunw8RrM+sPLvF7Qa94YrwyUCTnzfD7DA2yj3N+
 dHWk0mByLS+4vEFJPA9DWEigJjcwc7D8z1Wn/WgwUnxFJH90qjt09MtlBbYIgUxkIXUR
 18Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XkJS/vk/AFCAw+MrKJZ0hWbQuGoDCAYXbs59fxjYT0Q=;
 b=IJkohFFvfBwD5n1D5d0DDYkx0Cvg/sv8z8VORMia7EHqrNh7EyqY1QLwsSzEVqEbVT
 xhON5we7XNw+dLYIGdNgRWqU4uIHeFx7YE487HFn5CcvIJeKB9MSRNsb9NCVo9KoAPfj
 qONauvRPQ5DQBMUwe1edT1AAq0DcldGxAwphqRvj/R0omndaWQA4S+h1pSbK+Uzdtvc3
 n30w0ZowGbiM6/DyYve7rIyy7CvJGQkETQWQVmSjWS/h/OIX8hro1HwKX2WFvDRaGv2u
 zF174XCM5IvBfVQDMeL6BZXhbVhzM8SP5OwcRRbmjJ5ci5+3/iJXIfv8zcR9o1xil/UG
 Gprg==
X-Gm-Message-State: AOAM53204yBCxyM3ZWUPrPTFgl8Odkqp8ASFFQwBTZJbdjwGVDV7oUgf
 mAykDkE84HZMDdFT/tZPhks=
X-Google-Smtp-Source: ABdhPJy6JQ2U2g/j2Cyw3PWOVycj1dWgdg4/1qcexVGVfrBnGzPoAXWo/lvzcA61q4EzMlW8PtSvNA==
X-Received: by 2002:a17:902:d34d:b0:143:c927:dc48 with SMTP id
 l13-20020a170902d34d00b00143c927dc48mr50676636plk.71.1638875909491; 
 Tue, 07 Dec 2021 03:18:29 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 m76sm8832389pfd.160.2021.12.07.03.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Dec 2021 03:18:29 -0800 (PST)
Message-ID: <1f967946-6634-9aeb-4840-1b52e30cecc5@gmail.com>
Date: Tue, 7 Dec 2021 19:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V6 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20211207075602.2452-1-ltykernel@gmail.com>
 <20211207075602.2452-3-ltykernel@gmail.com> <Ya8tlQZf7+Ec6Oyp@zn.tnic>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <Ya8tlQZf7+Ec6Oyp@zn.tnic>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, hch@lst.de, linux-arch@vger.kernel.org, hch@infradead.org,
 wei.liu@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, kuba@kernel.org, jejb@linux.ibm.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, tglx@linutronix.de,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

Hi Borislav:
	Thanks for your review.

On 12/7/2021 5:47 PM, Borislav Petkov wrote:
> On Tue, Dec 07, 2021 at 02:55:58AM -0500, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyper-V provides Isolation VM which has memory encrypt support. Add
>> hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
>> attribute.
> 
> You need to refresh on how to write commit messages - never say what the
> patch is doing - that's visible in the diff itself. Rather, you should
> talk about *why* it is doing what it is doing.

Sure. Will update.

> 
>>   bool cc_platform_has(enum cc_attr attr)
>>   {
>> +	if (hv_is_isolation_supported())
>> +		return hyperv_cc_platform_has(attr);
> 
> Is there any reason for the hv_is_.. check to come before...
> 

Do you mean to check hyper-v before sev? If yes, no special reason.


>> +
>>   	if (sme_me_mask)
>>   		return amd_cc_platform_has(attr);
> 
> ... the sme_me_mask check?
> 
> What's in sme_me_mask on hyperv?

sme_me_mask is unset in this case.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
