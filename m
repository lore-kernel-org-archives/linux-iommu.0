Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7125A0E1
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981676; cv=none; b=RyXfkN5fgOAnVWPEjmYZQoknDofRHT6aXu0GxgLjYD3oa0uJtw9vNY3trmmzVFE7LKus3hHu1bwculd9CxNnF+wDTno1gqCZGjIfSoR+771VIWbMvXANsfzIKb/Oboa5Hz3uhuBRiysQEC2My8V/HIBFhuFmgctpDKdGVSe+j08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981676; c=relaxed/simple;
	bh=Wio6F/YmrR4vHwWpPbIwBqoIK98HhkujpX2cSl6mgx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WExB+nLYN6kVOx7KiCOGZRQJBfuNN//1IeJaTr6clYVhN/lObhJ83iWAkt7F+VI1hLDqI5U2dKW8bCih2zVp+2bMtdJTm2GJk7Mvj9teGzLm3+UHDgdhTptTGsNQBjQLagIMIsjyXOH11NGLPNeGbBnV+V5uIMsIctQ4TXQCQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlU6GlBM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlU6GlBM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f45104ef0so1673526e87.3
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714981673; x=1715586473; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9z1KGjtSCofC1Qn668FsPqAYxwkoX9IV+hB8APKITQ=;
        b=BlU6GlBMRPj7ejonctx8wBBoxfeUSxdp2WvEWWMYKLswvmVM9y9yg8z0D2INX46F66
         1uHysIqhnuXn8URiJHH49EovKLvRNu6avsICGMeR6hl2tlE4j7ocm4CTAlKKAXvqCZBw
         O1C5tz/eO8bkJsocXaMOigN9ykqIIa4OXrn56QM7+/6r4VI3q/lzgKhmuGpCed2WPFrQ
         PdH7K3hCwt3jtReicIjRvdY1MFSun0M7x5ptjqjIkNiXjx0buTYJfyrIO1jN6FnKQMBY
         LipNFuKKsVJBMzf4Yv8mz/M6F+FhKv76uz0Yc869B+k/REqsL2DPa1Exx9t2liiLDHEO
         4ntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714981673; x=1715586473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9z1KGjtSCofC1Qn668FsPqAYxwkoX9IV+hB8APKITQ=;
        b=cfBG3mXiD0cq1sEqjUI4SaUofTMXl5xebDszfJj74wIeyH6L/rocJCa20jrGmUbCSS
         x6VkG8Oq9E43/af9PvR4hV8I7/B4/5yQKV8yR2WgIxA0/+1oQLLb7QVLueO71eRlz2FP
         GI5BsPAW1bSTyTOtaIS77pr7mUCQ9wK4algSxAAKFOLsOxDGVFY2ogHriJmDkoJjw9YV
         PEvv/6n8Bjho0pItzi+mVyo2xI8e4BMw3rtJh//KjLLgQiZBoancSI45p1VwvzUV/SP0
         UcVbKMZeo/l39tz1ntqsizyqSh53USh2ZHKrKIw+nep/3kTlBLStLNCqhoRR6rmlNIb5
         BerA==
X-Forwarded-Encrypted: i=1; AJvYcCVjdWU8BzcEtZ2TQ2PqYmZLqifPuqHhvpUAh3Cyd5HwdQFazq6yD0yuwyHUy/Zqxu5fQrzKu35ThXYUkYJFj0LkZNxmS0A=
X-Gm-Message-State: AOJu0Yy/jk1AFrht9jcb173cbuQUYzLh1tC+su3ROJrsLvWFlr/AQ74x
	ZIveVFiFFxJsfRyXaoJTF8uhl3Ki0RoIfW5FX9FBUkQxPdjuFTTV
X-Google-Smtp-Source: AGHT+IF550fcLhXMftt3ugdZ1vjI7DRzOJDdu0OvXkiureQq0Ge5CAC5bewseI4ze1VtRp6gitVU9Q==
X-Received: by 2002:ac2:53b3:0:b0:51a:df97:cc8e with SMTP id j19-20020ac253b3000000b0051adf97cc8emr6310268lfh.4.1714981672388;
        Mon, 06 May 2024 00:47:52 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b00515bad4cd0asm1524209lfm.155.2024.05.06.00.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 00:47:51 -0700 (PDT)
Message-ID: <2a0d574d-6a3b-4344-9571-840eee569ae1@gmail.com>
Date: Mon, 6 May 2024 09:47:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if domain
 is SVA capable
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
 <3488f733-c920-4e2a-86f7-05dc1779685e@amd.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <3488f733-c920-4e2a-86f7-05dc1779685e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-06 09:31, Vasant Hegde wrote:
> Hi Klara,
> 

> Thanks for the report.
> 
> Looking into the attached dmesg :
> 
> 2024-04-29T10:35:05+02:00 soda.int.kasm.eu kernel: AMD-Vi: Using global IVHD
> EFR:0x0, EFR2:0x0
> 
> --> This means BIOS didn't setup the EFR flags in ACPI IVRS table (its BIOS issue).
> 
> Commit 8e0179733172 (iommu/amd: Enable Guest Translation before registering
> devices) changed GT feature enablement in control register.
> 
> Now it tries to enable CONTROL[GT] flag before reading IOMMU feature register
> (late_iommu_features_init()).
> 
> In attach device path, it assumed GT is supported (based on IOMMU EFR register
> value) and enabled DTE[GV]. Hence we hit ILLEGAL_DEV_TABLE_ENTRY error.
> 
> 
> Can you please try below fix?
> 
> 
> -Vasant
> 
> ---
> 
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index fd3e76e43699..b292181995b7 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2046,6 +2046,8 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>   			amd_iommu_max_glx_val = glxval;
>   		else
>   			amd_iommu_max_glx_val = min(amd_iommu_max_glx_val, glxval);
> +
> +		iommu_enable_gt(iommu);
>   	}
> 
>   	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
> @@ -2732,7 +2734,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>   	iommu_enable_command_buffer(iommu);
>   	iommu_enable_event_buffer(iommu);
>   	iommu_set_exclusion_range(iommu);
> -	iommu_enable_gt(iommu);
>   	iommu_enable_ga(iommu);
>   	iommu_enable_xt(iommu);
>   	iommu_enable_irtcachedis(iommu);
> @@ -2789,7 +2790,6 @@ static void early_enable_iommus(void)
>   			iommu_disable_irtcachedis(iommu);
>   			iommu_enable_command_buffer(iommu);
>   			iommu_enable_event_buffer(iommu);
> -			iommu_enable_gt(iommu);
>   			iommu_enable_ga(iommu);
>   			iommu_enable_xt(iommu);
>   			iommu_enable_irtcachedis(iommu);

This fixes the issue for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>
