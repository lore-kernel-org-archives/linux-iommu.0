Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F031B85FA
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881732; cv=none; b=GFv9vXvtPQZVGHxp5O+7Vt2bse7XZELL3wNnIrj2gE397cT5yySXCowqnSibG6GapX5XiyonN1mfiVtaD06EyiIGOKcpXVPIluj3j0ud9BdZ4HpiF9CSkDq9qad7Ut8uOtbwMWGBpLWMzz1o3F/IgQinvdaAfKNtYSKpGUlEtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881732; c=relaxed/simple;
	bh=WXzIJ0bdCaeOzDQWfKoxB/Nv/Ie/cVikDTxK34EnSDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssO9cTMDGdl1OJH48/mBSw+V4U0aHCCmTC/o4nhJnpySrMosrgP09CVz3HcudNL83yYHt+g8KwSNhmmR8FySYNN1MmuTxUPbGmTXT1wTgjlT4hQvEMNEPB+BRmeu8+GF+yRGw32O2Jd5++wl/XykazEC/egAT7jy7Tlj07ekqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHwmRdMo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHwmRdMo"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso127267985ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 11:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736881730; x=1737486530; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1wluVr2KEmdL75RTkfvYUEaTzCJ1+TWXwMM3JOjwnE=;
        b=QHwmRdMo3UMtk4ISTi/8fuzoF4ohXyYmVZrNV6jxLsPLwmHXUS4Mso6G/Vq6rbzXuE
         e/l7iOGO0GAuYOrHuxOnTkItA0ZbMruL+i8mZUH3oA0EV32Qi5O3OrgY9L943Yf+n7CR
         KQfUS4PiWQcZ/Zh2Y9W13Em2UvUhNUHWHuduwbSXIUFExNxB9c9cipHnYpFbvDDhpgo0
         9aKg3I4IaGg38cSM7jpqBtOsxBNrmLXLpsV62mandlxjmwqeeW+9bVzEB4xrsIYN5joE
         RQMBDXkWlsvB4ad0YFrkerLR6fe1IqgTjxVsaY3KR+dxRQ/Z3vA04ChXIRb3B28LE9Td
         of3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881730; x=1737486530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1wluVr2KEmdL75RTkfvYUEaTzCJ1+TWXwMM3JOjwnE=;
        b=fBqcKF6HZkgr4wia5ycoI9bfY1pSa9Im55IVFl6KptoUYAnzO4Rnrw4u4kLUiglHev
         CK9zWkiFBZ9Ydm32GkMSs4ULzWRt2Ludl7pk0CD8GFoYfMLbN1ZCvNJrMODkcp/Nea/w
         VPDyL5q7/rWJ0MSwpB3esqvNMZaPViirF7TzfB3AL0mB6Ft5NxKJym3RsyoZhMsD5Y7q
         Gn4qe5MaWCsO86F3NEK44SonqzGglsVFHTMpYVTUVv7mykIfYAstgL2tjA3PiA/zYaFU
         3vDXMMuDvRFdZPekCRNIXJEZR6pbfPjyNSZJcF8AQ/X5hdTkfZlT5i7p7aOZp71vxc4w
         2/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXuvvWQbsYHehHoxsGktWsRDf98HNYM3y+Lgg3EXDfJm9R59sJ/Zzme1I2ZJrhY21dSFCuDIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJdY0rG+Z0hgpJWfD8yhlqQHgchZYV47dRSAcmlNysnZICVntM
	7lgGv/DQVyHZJdmYyQjtLRoWX7SzAv6oqwkPGWoRgb3BgAXzYNrC
X-Gm-Gg: ASbGncu7i1SlZQkeJc9ubYoj6JoCs2Yti7G16maOB7b7mdo15OhBtveI9pea3Xw6srQ
	2888NbEV2DaH2951uuO8oqvCQOSALkB7E+Ux5T68UnkV1AoTuMAlpFhrynPbKgv9G+SA+8z1oZ8
	B6Xn1Pa9vVRJRC1uOhnxOAA5PIWi3dfA04wICpiEGyG0a9SJmzaZth0CdkrsPp7SurXSEYqmDf6
	GGNbmV5zegusX5YwvNnPloU0L7q4qecaBMisAhXRQvbVCnNFlZw96afsRcU8xnlVFeShA==
X-Google-Smtp-Source: AGHT+IESyEmcGSE8oZhcJJMi/VSL4QrSheSi1FfqVPunOJTITgUtOEiVoEEjSBASraWp4h6f237DmQ==
X-Received: by 2002:a05:6a20:2594:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1e88d13b502mr44951960637.8.1736881729674;
        Tue, 14 Jan 2025 11:08:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f609sm7938702b3a.138.2025.01.14.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:08:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 Jan 2025 11:08:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
Message-ID: <617b98d2-b3f7-492d-bed2-5609c8f158d0@roeck-us.net>
References: <20250107165100.1093357-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107165100.1093357-1-praan@google.com>

On Tue, Jan 07, 2025 at 04:51:00PM +0000, Pranjal Shrivastava wrote:
> Adopt the `str_read_write` helper in event logging as highlighted [1].
> 
> [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

This may result in build errors such as:

Error log:
In file included from include/linux/device.h:15,
                 from include/linux/acpi.h:14,
                 from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:12:
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c: In function 'arm_smmu_dump_event':
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1910:25: error: implicit declaration of function 'str_read_write'; did you mean 'sb_end_write'?

since the necessary include file is not included directly.

Guenter

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 34b424c87be0..0e4cbb2c64d7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1907,7 +1907,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
>  		dev_err(smmu->dev, "%s %s %s %s \"%s\"%s%s stag: %#x",
>  			evt->privileged ? "priv" : "unpriv",
>  			evt->instruction ? "inst" : "data",
> -			evt->read ? "read" : "write",
> +			str_read_write(evt->read),
>  			evt->s2 ? "s2" : "s1", event_class_str[evt->class],
>  			evt->class_tt ? (evt->ttrnw ? " ttd_read" : " ttd_write") : "",
>  			evt->stall ? " stall" : "", evt->stag);
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
