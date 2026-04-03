Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45DA346AC4
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183304; cv=none; b=fNN9SKxtbsqmoAhsc4KhJMR7d0XbArfWMibtUT0UkMdGuzhzyhcpfT8PxRjnUYBhgMZA84h527IqmBWUn06s42+9RmXPjf/ue4dWBhnGG5tXjzrxYbCKiMTDUMW7nTaiUKCXbLxZjv0ZWiGLiDiCkqodxl1VlbQhMni3VXHHpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183304; c=relaxed/simple;
	bh=AYdOen/ZkumBkvzxVN16QDwCr+cFHVnINwn0hlRF9/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQhU81Rm8+N7ZzCjMUpopZ3ZQ0EiU45s2CB9g/ODD/SWAg+vqn+0G96Uhj8/5QtYMF/5h9fi1t1d7bWDMS8sFKrAgRNRqUTP1YjvWojJ/zu7b6kqnLH0IVoigQTltNg1S85ZJyPcgt67xJjtuzFhZGPa0wPmhz7pMPODXWxHqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMKnMtAF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMKnMtAF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0c12be0ecso49355ad.0
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183303; x=1775788103; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9F4Hc1NxXYsYxfPtoZfVmSu26aBhFkkTpUXoCZNtth4=;
        b=PMKnMtAFBgwN+LCCC32GGkoqL0VrWb+lSw02cj18JA121rU0PKHEkAvSnMMG2Ao8i+
         Aiyc4yfAgfaOjkeoqpU1LmcVmRt41fBkhKe4HnLZxZh8yfB0UA1iTLFBNYG0zQFNhG2R
         eAfibvt9uezP7M2el7Uww+TlZS503qoJuIssw5w8I+I525VvYs0vTAPwd5smf8T874kb
         lQorcT1YHbxYZ+siwqD8RTbK1PsqRo7wJewjJ/GW4eHu4+iR91XJf9ex+dO4gg+hDNwF
         fM4QKtqLfO/AniB1ox6Vkgxvyc8Jl0IYtPfJw3Oy6zLCGXTeWbuENLLZ+TMJHJc5dUfC
         WQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183303; x=1775788103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F4Hc1NxXYsYxfPtoZfVmSu26aBhFkkTpUXoCZNtth4=;
        b=h9eYuwr3O29EsghB3MiUm4TohHbdDiNoBoXZt/m+UNiWqXQBJ0IfA2cBJqssBBAmmO
         18Dh2L5vyLI5hAeTFMc3Zgv6b1A/LgLBEiOTEWjQr1TmVQ+SljMJ6CbgyeNscbUH5WPE
         VAX9CtVeNuRyGdS9PriaUJUp2gPmaPPo0qtd4RBeJ+SrbnIeZCUUOXIEEJuX8IZcW39g
         EvYiFOoR+4OljBsNI7L9CqyfkGXxRIgBitFZxMeNNekAGH6Qf8SjTJ4E0G+b3oYA0L0u
         7y/dAQHmG2cMrWjb7auM1i9ICLKVYj3Kdzg7sjss9DbIFoTSmsVwpasN7ivjJJ2AAJQa
         Qokg==
X-Forwarded-Encrypted: i=1; AJvYcCU21dI5dk3zp8W7c81MBi32hbJ1FTiNVHDcYJMdLg9J6RtbjCWdUvalMA4aEstDb/Eg0acR9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO8hvAVcBn5wg7HK1vCPXJbKGWGh9xJp309gaeRJIAEl3ylG49
	SBLr4ee1N3ikAE7U0umCSAsvM5Rf3yfxzL2u5bJNlgesNRRu7mEtTxXbeZWh/uLDag==
X-Gm-Gg: AeBDieuPTz1LaOsiWp+bX0MulMeVM6IntcR/zZ6oQ7uf1+9nM7jD4+n5mJ1kYnDb8dy
	PIwi0SjMCi0hEi9JXCMegMCNFjH0TlhlQAs/AuCdxof7BDvi35sWqUXRHz7J2hZQ4kcH3Pwg5yx
	C19XLUFzXrtt+iudDNIMhNJbsWKFek/xQkD+/D7rHO3nd+hLksYLOjuxBsCpTv7Pi2CX+X98nOr
	uK6em0keZ5t5iFUHPlCXSK9gkPAHun129oTJ9TdmeP4sCt5zotsyfoMcjKhSchBSb3QtzRmsZsq
	bo8I64xj12+ndQFUVPM8UaRWV06YKpsKYHuQzTD5rzWlb5seStPM1s+YsZnB2E5vLl3x4/KqC4W
	QrSZwI5mTZqrld9SWiG4faM4YrTEraeXma47VOyVRvgG5BOu+kxOAqCoK0idkqH6rvVAu/hftb8
	FbpWWqZCc4638IshXDPhOA9Gxba4kUOA8KyMqb+LMReVAkEHPAKFCDES82Fw==
X-Received: by 2002:a17:903:46c4:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2b283f04ae8mr724965ad.1.1775183302570;
        Thu, 02 Apr 2026 19:28:22 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6475b56sm3991678a12.1.2026.04.02.19.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 19:28:22 -0700 (PDT)
Date: Fri, 3 Apr 2026 02:28:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nafees Ahmed Abdul <nafeabd@amazon.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: Default to lazy DMA mode on ARM64
Message-ID: <ac8lwTT0oQNT-JaL@google.com>
References: <20260402195913.32084-1-nafeabd@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402195913.32084-1-nafeabd@amazon.com>

Hi Nafees,

On Thu, Apr 02, 2026 at 07:59:13PM +0000, Nafees Ahmed Abdul wrote:
> ARM64 currently falls through to IOMMU_DEFAULT_DMA_STRICT, while
> X86 defaults to IOMMU_DEFAULT_DMA_LAZY. On ARM64 bare-metal
> systems with the ARM SMMU, strict mode causes synchronous TLBI
> + CMD_SYNC on every DMA unmap, resulting in significant
> throughput degradation for network-intensive workloads.
> 
> Benchmarked on an ARM64 bare-metal system (AWS m8g.metal-24xl)
> running Debian 13 with kernel 6.12.74, using iperf3:
> 
>   STRICT (default): 14.9 Gbps
>   LAZY:             39.8 Gbps
> 
> This is a 2.67x throughput improvement simply by switching the
> IOMMU default domain mode.
> 
> Distributions that do not explicitly override this Kconfig
> choice (e.g., Debian, SLES) silently get STRICT on ARM64,
> causing this regression on bare-metal systems. Changing the
> upstream default avoids the need for each distribution to
> independently carry this override.
> 

Thanks for the patch and the benchmarks.

However, I'm not sure why should we change the compile-time default for
all ARM64 systems? Currently, users can already achieve this behavior by
using the `iommu.strict=0` boot parameter.

Since IOMMU_DEFAULT_DMA_STRICT provides a higher security guarantee 
(preventing sub-page aliasing and potential "use-after-unmap" attacks),
keeping it as the default and allowing users to opt-in via the kernel cmd
line seems like the safer path, in my opinion. 

Additionally, distributions like Debian can also set this via their 
GRUB configurations for performance.

> Add ARM64 to the LAZY default to align with X86 behavior.
> 
> Signed-off-by: Nafees Ahmed Abdul <nafeabd@amazon.com>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f86262b11..2822aba75 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -96,7 +96,7 @@ config IOMMU_DEBUGFS
>  choice
>  	prompt "IOMMU default domain type"
>  	depends on IOMMU_API
> -	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390
> +	default IOMMU_DEFAULT_DMA_LAZY if X86 || S390 || ARM64
>  	default IOMMU_DEFAULT_DMA_STRICT
>  	help
>  	  Choose the type of IOMMU domain used to manage DMA API usage by
 
Thanks,
Praan
