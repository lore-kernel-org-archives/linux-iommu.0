Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E2DC433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:37:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358106108B
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 16:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358106108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F097583D61;
	Fri,  9 Apr 2021 16:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_MIuUWBjZ06; Fri,  9 Apr 2021 16:37:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5DE483D59;
	Fri,  9 Apr 2021 16:37:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9960EC000B;
	Fri,  9 Apr 2021 16:37:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67EE6C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E1B7405EF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Xx7-rWCqB8h for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 16:37:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF871405EE
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 16:37:16 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id n140so6343480oig.9
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jt0mWpBq3sNUpgvlCnN+R/MTcVAEftEHqFK2IYG/XB4=;
 b=WOL4buhsRFkvMQViI453GGiCvUFNdZgc4ZJlJTdZ7MBQyuDpmrm4VqCDDcOyg3J4bK
 jFKEYRGmYDgV6SIwQ9TIRNLKaxuH0Fo04kDmI3mQ2FcPKLfykO+QwyF34tvceG8YcmQ3
 r0GvqBuUUfPxGGUjv9smdXWNIdyK7dK0Hb1AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jt0mWpBq3sNUpgvlCnN+R/MTcVAEftEHqFK2IYG/XB4=;
 b=QlyqiHnezSvhkSB19i7qv6H2wq4b3wBvxZKlRbVk7Dz1Bnu9ywLOIxclntmjYiNSiy
 NA6jg+DVLgns5nwoBsDzQZvYN0UmAXcnhKRPAMgED+97ouUgIyWKtssVJywCNPPMjgCs
 ZqhTwXxqWUErQT0tch1X10jG6Idr8cgLo4tqI+18YzhmxeJRZrJGOcKrnrKYXhU4arM9
 aKNXJ96srXG2Um3mHdNGmV17hF87Ea92tOQuQX7+oXlE3eBnsbdxtRvdGWXVQn0O+Xvf
 H2r5oAahN3Wa5r1velMc+M07arCWam3Oh+IbmZuyCQ5JZhZe+5ah0lBPmnbLy7WyfrNc
 R8Sg==
X-Gm-Message-State: AOAM5315htxhTJLakLe4XxzOvc9aAKF8PV4vRpEzkxBLgQdTAGD+Cofr
 pFLVzO1atoPvOrplYtaks6btNR0K
X-Google-Smtp-Source: ABdhPJzsQ95+MkAElEf4DTQwKSA8OxVjxEKU7dWZZwOzlYX2GRhaMaQ1f+vG+7hV2gl0mir70p7MEQ==
X-Received: by 2002:a05:6808:542:: with SMTP id
 i2mr4703717oig.84.1617986235763; 
 Fri, 09 Apr 2021 09:37:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id t144sm624807oih.26.2021.04.09.09.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 09:37:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6d53ded8-9ab8-7205-f17e-d0c315b770bd@linuxfoundation.org>
Date: Fri, 9 Apr 2021 10:37:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
> Performance Counter (PMC) support was first introduced in
> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
> resource management"), there was a HW bug where the counters could not
> be accessed. The result was reading of the counter always return zero.
> 
> At the time, the suggested workaround was to add a test logic prior
> to initializing the PMC feature to check if the counters can be programmed
> and read back the same value. This has been working fine until the more
> recent desktop/mobile platforms start enabling power gating for the PMC,
> which prevents access to the counters. This results in the PMC support
> being disabled unnecesarily.

unnecessarily

> 
> Unfortunatly, there is no documentation of since which generation

Unfortunately,

Rephrase suggestion:
Unfortunately, it is unclear when the PMC HW bug fixed.

> of hardware the original PMC HW bug was fixed. Although, it was fixed
> soon after the first introduction of the PMC. Base on this, we assume

Based

> that the buggy platforms are less likely to be in used, and it should

in use

> be relatively safe to remove this legacy logic.

> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/init.c | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 648cdfd03074..247cdda5d683 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1714,33 +1714,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
>   	return 0;
>   }
>   
> -static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
> -				u8 fxn, u64 *value, bool is_write);
> -
>   static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   {
> +	u64 val;
>   	struct pci_dev *pdev = iommu->dev;
> -	u64 val = 0xabcd, val2 = 0, save_reg = 0;
>   
>   	if (!iommu_feature(iommu, FEATURE_PC))
>   		return;
>   
>   	amd_iommu_pc_present = true;
>   
> -	/* save the value to restore, if writable */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
> -		goto pc_false;
> -
> -	/* Check if the performance counters can be written to */
> -	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
> -	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
> -	    (val != val2))
> -		goto pc_false;
> -
> -	/* restore */
> -	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
> -		goto pc_false;
> -
>   	pci_info(pdev, "IOMMU performance counters supported\n");
>   
>   	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
> @@ -1748,11 +1731,6 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
>   	iommu->max_counters = (u8) ((val >> 7) & 0xf);
>   
>   	return;
> -
> -pc_false:
> -	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
> -	amd_iommu_pc_present = false;
> -	return;
>   }
>   
>   static ssize_t amd_iommu_show_cap(struct device *dev,
> 

I will test this patch and the revert on my two AMD systems and update
you in a day or two.

thanks,
-- Shuah
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
