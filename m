Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05D1BD9E4
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616725; cv=none; b=dWXMHlBKy/bAVMCXKrgSEWo/3FAmNUdUqB1xMxnMtGiQWUx70g1nUX0fbaM8YqlbMyv5SjVZux3Ix7RX9xBkDlUg64qT4v1cdjMRn2QuwsxD3W9DyNt9xG1rOGjr7gWGOj39YxT1h9NUhaQVfMkorjDL/57jWjGLyTf235jcKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616725; c=relaxed/simple;
	bh=c5WQGbXc09ojfJbmmBoM0eiNasmBvEdCsU9xwZ2cC08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyWptpFUe0ftExWPJj2/tnqCt6ocYQABMsBTD00/EcMhY6fqI90DjJV9featyEbKImLS0u5L4jlBvyKC2hfLI2Hn54rj3JQdlaHyGRfoYIGqECXRejTFCwROK1xJ44o5VHYGVcCcPZmEYMeaEd6du3Qjwhr8k6tTcwek/l6KuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpZfTod6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpZfTod6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-211eb2be4a8so102065ad.1
        for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 02:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732616724; x=1733221524; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCKMARhQYWsKgGAkxhFzHf3guajJ7wgrpib56nIQMSg=;
        b=vpZfTod6obCcFaT5bpi5u9Z5K9xVJa/myIzcIk3ZNekMpSiO/jvbwVyh9L8s2sPm5n
         Ato6KaYBTOAfuN/wxIzMtyWVHV+z2pGOeYeHnlp7yWG87DncU8ZFv+GWp5+TFLHvkFrE
         HWpWvKG8LxKNxnmYfCOy0mYlu+j7q1m6wmV9APXbzsssVFaMgEqqf7Qgbd6h8Cwu5tXL
         xyi3oHRr8WRQffqoliaVNeWzh8mJcSU6mPyji2SrF04vhbsZBhGmR7iyINc2+Zp2PDKq
         CiDw2y3j51MYtSEJQU+/B9e5VAc4ITB8/z7bj3EWDkCzGCpZser6Fcivce/ClwtD2m0W
         Y1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616724; x=1733221524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCKMARhQYWsKgGAkxhFzHf3guajJ7wgrpib56nIQMSg=;
        b=l82hBPOxXq7iWNE9aTv2wEJHwP6w+p5OuI0gj3SUlrXPs+oe5GX0+iEV2VBJ0Qq1Ol
         nhiZOps4t/j5WiuY4UXxAVPJos+aalrKYV8zNpSISdjuQqNlcJF21kU27iao7g7BGsf5
         CBYURxqCKyO/ukcTIMiClqmU8k9yO583L9zoaqJLwjnJ/6M03VSTaEf7okSwvsc6mCIo
         xgsfbOZp078ut9Zq6Gb1BT8cnqt78YvD1SlazvV13EDH2r9Jcv4kQVxtuLrYVi1cuBa+
         Atnsyy00vXPEEn4yJ+dacrRQTga9efqnxZHmdTgt/pJq/mC69Uq+xGp1WJvvtveRIzf8
         uraA==
X-Forwarded-Encrypted: i=1; AJvYcCVGO9PUi07fAkgx/sJrOlMW0HydAgAIUg+78PGrN5yBUNV40Yu8EtKJiNeDFh44qALoknZkhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdvaoPxNazwz4CD/gswTnK1wDsu8S12BvKYT2eMrePEXnA++1O
	PNSSzMESehdXg5EixTXlSkyZ9vbx1PEqCpEFak7aQEZSxI54k/a9pT3w4+HIaA==
X-Gm-Gg: ASbGncu2iJQcsVnbsqFJLkeTjQXxLkZ9sFBigQQo5SQTpWYK458wM2sK8/0xLHZpif+
	vvPSbR3BRF5GiSFyTAwR9nXGuCrcYoT7/qlZ9Njy61V5GGGyZHxq2zM4IZwqcDHKeVKgiGK41S5
	pLg81h/8Upg5jz6yY9H5+Nglh88fbib1ybAnUvgJh9l2ljDTkr/IOHdT5dDfuqTNHETjjXINoG3
	UgXoR6KkYllqZqkx6qwmeXYVdJONMV005wKQJi7PymnTv95zDxcpRMPa3dDa1n82K1i7BHB558E
	qzekeYbjyBM=
X-Google-Smtp-Source: AGHT+IFdyNymOjH7IAVwDcoqCSzqas3/yeL6ssOPSpkWSgBVG3GV2R/8dBaQMQXYYpTWjd1cvm1vGA==
X-Received: by 2002:a17:903:13c6:b0:1fc:548f:6533 with SMTP id d9443c01a7336-214ea7f3b0fmr1535985ad.3.1732616723561;
        Tue, 26 Nov 2024 02:25:23 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc40143esm8321660a12.80.2024.11.26.02.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:25:23 -0800 (PST)
Date: Tue, 26 Nov 2024 10:25:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu: Downgrade print level for iommu group information
Message-ID: <Z0WiC4lWxFdY-_JO@google.com>
References: <20241126072339.25714-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126072339.25714-1-lirongqing@baidu.com>

Hello,
On Tue, Nov 26, 2024 at 03:23:39PM +0800, Li RongQing wrote:
> This per device log is becoming longer with more and more PCI devices
> in system, which slows down the boot process due to the serializing
> nature of printk().
> 
> Downgrade dev_info() to dev_dbg() so it is still accessible for debug
> purposes.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e61..a16f944 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1193,7 +1193,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  
>  	trace_add_device_to_group(group->id, dev);
>  
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> +	dev_dbg(dev, "Adding to iommu group %d\n", group->id);

I'm not sure the original reason behind this `dev_info` but of late I've
seen people/scripts use this log to find the iommu_group for a device to
later set the default domain via /sys/kernel/iommu_groups/<grp_id>/type

That said with this change, those scripts should still be able to find
the iommu_group via /sys/bus/<bus_type>/devices/<device>/iommu_group
Maybe adding this info to the commit message will help them?

>  
>  	return device;
>  
> -- 
> 2.9.4
> 
> 

Thanks,
Praan
