Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF282149012
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442098; cv=none; b=Ns59iye+Uv+ai4g5W3pR2QTNIf9Jdzb/VrUz9ZI5Kv2M2391fkdpxrSlY6DPcNYVpxyWQVX3cMEQBJ0kj1mOydynqC2JCIzScr3Rjp8Gxf1r8mppmz8+VMiFSxvM4wK83hnvkKn/LU4mhzFD9vDV2NRliSfyk4lygnElwS3CkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442098; c=relaxed/simple;
	bh=OWFPyLk9qijbZylrTVEw9W4riew8091W+ugBuLpyJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVJoIbGiHQJ+1PhI+Jj7kAJDUoPuyWo+Df/DKfqRG9D1UHXEG/bssSjoIG5Sd5WdPB7Ou0hd9FkEtw20ZR9y82P6HELXoxmqLUotP92KuEKY883TS5UcI9dsuaJHwKEJfuRqInP4ljnDrpSxHfvyarqvMbx+v5/JxuvcSk9eV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JDwRQhJc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JDwRQhJc"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94478a4eso795739166b.1
        for <iommu@lists.linux.dev>; Sun, 11 Aug 2024 22:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723442094; x=1724046894; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=JDwRQhJcBIJZjJVlKgtkY6+qzSlU7sdAVLVoYIWCXxN3AP1WO6ZBKIOljGfWJ6KAjT
         l3vPkKjirEwbd/CyJKFCbIF8d9YfSVH+c/MdtLiIpY/o0mBBXQfrj2Fg3FBpnMWYNNxE
         dy1SY9iLBQ/gSb0On8lWi97Rs4OryErUdLEbRNthH4YXPfqkWZ3kVSbhJFRReFbPkZ5W
         wWCGDHJjdajt7aIeQ2D0IQQSHajGx504ycGwKAip9kOXaDnb54uCxvZfFS6DQf76eSTc
         RgrR79lcuQXDApyNEO+sVc8V819QWcCjkwyA8mR2eQkIN+kGD2DqQ7r2ZKvKywrWS0F7
         PyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723442094; x=1724046894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYo1INLOq156Qw62vGRe5A8jAlkKQVGuSnU9/QE+v7o=;
        b=UPPaMH2L4ydqadAzzf9+eyvCMyPa1K3RbitQE5H2X7kj9QjkLoHZstKPWbp4CxKEE7
         eVrdBOWTBFW+QvmWdl0RE4DD5/0OUQK+tscLHDgtfY8wElWD4gdSqQ9O7PFpyx8BBihg
         MGJRSM+4iTf1QukhGlQBElBnDPznzqiv0sD8RXTBSK8jVtzW6mAMrWeEdJ5ZCu1yijf6
         nXgAXhHYTC1UV8xF2/YV9BqxXeBAwRCYU3BZQZ7sza00KLFT/by3kI78YT8YMMVQqyBJ
         VUz7Reb2gGrLcXelkkujY23ZGL6Fvd/pJD23ng3IMmYEVJW1t9byC1PdbjGxxAKMKtAK
         o2lw==
X-Forwarded-Encrypted: i=1; AJvYcCXlo3S3fAALBPbA42T0atFplh5kc2zY1w7nSvX4NYCxUyXZ+yoIq3G5u4bC0Fo/x60LxR1Qt+Chjt3nZNbOjwXCTs/u6U8=
X-Gm-Message-State: AOJu0Yw1HwBQRLwJADQFNtgs8kO6KuI7tlUpGCotBfKSzq2+nmBFgi3w
	LJVeYNgE2/FPo5xs0WTDFJRxgZYCbGjPGczh24BYVcrHNWCtPbyA7gOdnqOn1Ibk7j4Ip68izmh
	EmgI=
X-Google-Smtp-Source: AGHT+IEWJlWulwINR2mvPDA0F+GzST96BiyVI1VBUqXaw2VqDuwlnso7Bu+sdLf7W/E58YfrQZmfvQ==
X-Received: by 2002:a17:906:478a:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a80ab75a8d2mr689304566b.6.1723442094028;
        Sun, 11 Aug 2024 22:54:54 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb243d78sm198422366b.224.2024.08.11.22.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:54:53 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:54:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>, Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v6 RESED 2/2] arm64: support DMA zone above 4GB
Message-ID: <20240812075452.4ef3eef5@mordecai.tesarici.cz>
In-Reply-To: <70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
References: <cover.1723359916.git.baruch@tkos.co.il>
	<70d2c447b6dbf472b8e7fec5804deddc12692aab.1723359916.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 10:09:36 +0300
Baruch Siach <baruch@tkos.co.il> wrote:

> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the
> max_zone_phys() calculation") made arm64 DMA/DMA32 zones span the entire
> RAM when RAM starts above 32-bits. This breaks hardware with DMA area
> that start above 32-bits. But the commit log says that "we haven't
> noticed any such hardware". It turns out that such hardware does exist.
> 
> One such platform has RAM starting at 32GB with an internal bus that has
> the following DMA limits:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00 0xc0000000 0x08 0x00000000 0x00 0x40000000>;
> 
> That is, devices under this bus see 1GB of DMA range between 3GB-4GB in
> their address space. This range is mapped to CPU memory at 32GB-33GB.
> With current code DMA allocations for devices under this bus are not
> limited to DMA area, leading to run-time allocation failure.
> 
> This commit reinstates DMA zone at the bottom of RAM. The result is DMA
> zone that properly reflects the hardware constraints as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> [baruch: split off the original patch]
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Note that I'm not an Arm64 maintainer, so the value of my review is
limited, but AFAICS this change should work as intended.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  arch/arm64/mm/init.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c45e2152ca9e..bfb10969cbf0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -114,20 +114,8 @@ static void __init arch_reserve_crashkernel(void)
>  				    low_size, high);
>  }
>  
> -/*
> - * Return the maximum physical address for a zone given its limit.
> - * If DRAM starts above 32-bit, expand the zone to the maximum
> - * available memory, otherwise cap it at 32-bit.
> - */
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> -	phys_addr_t phys_start = memblock_start_of_DRAM();
> -
> -	if (phys_start > U32_MAX)
> -		zone_limit = PHYS_ADDR_MAX;
> -	else if (phys_start > zone_limit)
> -		zone_limit = U32_MAX;
> -
>  	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }
>  

