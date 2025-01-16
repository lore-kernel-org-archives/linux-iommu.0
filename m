Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB114F121
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996964; cv=none; b=QTjJiqENM9/Upu6gBoFMuFg+jsaivFa9nPezLToAOoIxgS9TJSbdAEWTB6aK3ms+jLrumO81jTBpdelkJ8gcF9nkq9OSof0rxlHWLYVLE9xhDG3tdIDXihl0AdcxTskFrjJ1hX6MO7wAcSupVcDHKauwNkmy6LfTwxYoMKJsQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996964; c=relaxed/simple;
	bh=YvT347LAFtvqLpCK4qt1Yi9x/NqEjZFWcuO80fdGZVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EThIzDa8TpZbPhwoSG+REhCW3o0iOIm7wHe/CFJZNa6VNbFKnWNglUf9nJ1nTVUTkXorP8l1wHju/UFGSf3ULbKn6+Qux620zPoHc6o64Lix+0sirSN4eXWlRkfkM4AtBdpj1TsjZK2gFjn6F+aRAJwvyk88kTGpdjDzt0LG7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2HKZgbV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2HKZgbV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215740b7fb8so73515ad.0
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736996962; x=1737601762; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0k2tjWflbKcVqC6zMuhNKy98nVj8U7DcPtvNyfmp/OM=;
        b=s2HKZgbVjwSJITFhOznr2xQHV6wmvvLfm5rlbzojkvWvLRPrp7Pj2ndTEDzGb4blYY
         QyyaT2jYgeIAn9aZc703FHDESmDZHqbTE52m8am19t37pJLG0WpZP0CIFfq9o+WgJ34h
         t9gbtfSPOWYCzksxiKywZcWBa/MsCTjexJPtfxo92EHphDStovETKbxRcl7LwbFOn2lA
         hZ0QaoSa4EtPUV9MguUn7WoRVXOz/qHENU8rHWSGNS+XrtjVwxs62cRlgts9uVdOg83K
         KYg4E6OWeRokq4Gal1rn/NzLFlKIbxg+nuea/YII4VZW4hHISxVVl3d8xDptj71rdlPx
         rEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736996962; x=1737601762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0k2tjWflbKcVqC6zMuhNKy98nVj8U7DcPtvNyfmp/OM=;
        b=MBRQc2Aw2mtHLzdOT0muf4lgAftwpq3qY+lb74R6HTvp4NbzAPLYMD8ngqlaXaHhDF
         cf9Es15knG2IdTxH/HRrnaN7c4m+/Wy1HcQaDWhOYGW7SWDRwOORAxOd5EqS3JAd/jJv
         A4eAG7PR8Y9iTJfVcQOIr+sZWDOg/C/Qy6NijHvF6A8o+vqSmFFghdlc83m9DoIghUYH
         UCsdI27cMH3x5WDzwynSeN67SXpaMmdrhGcwLzSHAwWCP1Y1dXlzxZ1KPPkMLCq19vDw
         RXMnZ5zUxdKrMXYMLcPNnzqbPHoA/bZw83KDH+61BsjN4n2QfNm9P8OYoIlcV5ZV5DVO
         uyDw==
X-Forwarded-Encrypted: i=1; AJvYcCVb5+g1b/vDb/O0UQXZQAVoVA44zE3dWIKaxXLUmTC3IOvh5oDg0x0DalY8UtQViQoWfzjkDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8C/7QY+7Ghu3x0DfEGcAtWR1mipEF501HRjimYcS1gk32mU5p
	vBFO5y+Ab7gPX7eEBjMMWOLonv+aSJZy5+Q0kfUFCfcLF28II5BBRuQK7vRFTA==
X-Gm-Gg: ASbGnctvko5kOq+JhCAwP8E1yc3h6E1iN/PpiPq/inTgvAkfkFdPgcIymglusbAhQJc
	UvW7aNCboFlju67OiOdWXWa66U71hpGJ2lIyzW3UWltBycmxcltuKZMIL8Z2ImkgE6LszuhlyHP
	tmMUYPt3aqm/QEpGzew4yPLaZ8x+c25FoaeIm1P1sb/zVAw5UQ5aetGaLuLKWo8//jXudLRijF7
	rS21Km6KiCvReIufvhxoxOivVOmWVPsyLk4MjnvfmW2Uh4S/1eyyUHSHJLQ5SlbuDXWCIbENOtE
	9bWMeYs17C/X
X-Google-Smtp-Source: AGHT+IHZcCbVA815LPJGb0bCjcocKzrwMS8Y8KUYeVaCrLeZOxiM8S63vOxnYqo99Qw0ZPV4r1BBuA==
X-Received: by 2002:a17:903:443:b0:21b:b3c4:7e0a with SMTP id d9443c01a7336-21c165a4395mr788135ad.13.1736996962080;
        Wed, 15 Jan 2025 19:09:22 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658b71sm9879160b3a.85.2025.01.15.19.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:09:21 -0800 (PST)
Date: Thu, 16 Jan 2025 03:09:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: add missing header
Message-ID: <Z4h4WePiB7G0BZj-@google.com>
References: <20250114160630.1122885-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114160630.1122885-1-robert.marko@sartura.hr>

On Tue, Jan 14, 2025 at 05:05:56PM +0100, Robert Marko wrote:
> str_read_write is currently undeclared and thus compilation will fail with:
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1911:25: error: implicit declaration of function ‘str_read_write’; did you mean ‘sb_end_write’? [-Wimplicit-function-declaration]
> 
> So include the missing linux/string_choices.h header to fix compilation.
> 
> Fixes: f2c77f6e41e6 ("iommu/arm-smmu-v3: Use str_read_write helper w/ logs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501111926.qOpnlK9J-lkp@intel.com/
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0e4cbb2c64d7..a0e395da8a88 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>

Hi Robert,

This fix has already been merged to the arm/smmu/updates branch [1]
which should appear in -next when Joerg next rebuilds the branch.

Thanks,
Praan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=arm/smmu/updates

>  
> -- 
> 2.47.1
> 
> 
