Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D5428826
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918034; cv=none; b=m+rsCqTnTdaIeeoY1IHf7pOrSAwrpdsU4oxdMhbNsjiDuT4+jh02KOny1BW4IVzBhqiK0WyZMipNgAkybugjgLGkQ9XJcIsJapqhE4GtuiOjA7IMgW0tmnsycPYebdaIG045o37DQ3ZAM6Z7rcFRx0o2z0zCNwN/TPft9SHJZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918034; c=relaxed/simple;
	bh=H5SjFQ55Nrbz+wQa69yMJLdnVWF1p5wRy6GRjG6nUI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZDbSB7flX4JG+y2x2Gj5SVJPBrLE570/FipR7z9jueZdc3giNGiyQtAisy4h6e26Rn7TEbbiFzNkAjqRkvNZLO2bHAH8+jd4IOMk3JdtouDuKEmTw71ttv5YSVGg6vfJk0s6ctuI7NdM3wKAQFRKrwE6megC+AYtlo5gK3AIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZMd2Dmzo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZMd2Dmzo"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64dfb22c7e4so11278988a12.1
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768918029; x=1769522829; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5XJOUYy42/sptKbdOJ7wrgOiP608mSPN3Mi26FejI24=;
        b=ZMd2DmzoQY2DLj6Jk3LottNJkNEDrpyQkdKk4vtC/NML7i5i/erUtnUvvUhCHam6Ie
         lXkf5Fqw6y4jIp5YlYNoTanLXE4ijBxWx1N0xuc131lrKdw2pFdM74ACpK2DGRoHzZRF
         Vs7VQE3gcBWZyYOMQby6Uk8GfVHoDN6bbTujs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768918029; x=1769522829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XJOUYy42/sptKbdOJ7wrgOiP608mSPN3Mi26FejI24=;
        b=wyNysQuAc2Z9jB9YSekSjhFByf8+5YPoTGI1ep7Ziuuw2Iu+0FX2fUQcKfmzYnuwFs
         9fIa7Pczcunu2gEsks1iUMZp1QyW46fHtFG9a0MYUWdDhZHuljwu6mTM+OjdkR0AaOyb
         I/t71pbTygpF/AjwYO4l5Qyz1TP1mp930Fq+AVt1jL3BGgWAwPLKaMV2OoWonTBdxO3J
         ZO5tMM4NGJmEoC8HQy4CeZUcsiA1kyfKW2dH8ggEw2LXxnXzEtW6/D+EDsu9Y6/bAteK
         SNqIyxD9Z8ua7xQqhQbhCWsTREgoLJ0qqqifjztajHRCzUlFBVLKy0Y+UvkAPATeflTE
         e4dA==
X-Forwarded-Encrypted: i=1; AJvYcCXTOo/tQisywgAdHWxETTTR/TKiKTRcOmVCgVKSl5X9Y0f5v+QV7bIcN17JX77Web9LZCEZ+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPOFt6nD5lBz+rtDeLvWWh38yEDsoLaV+tKujIFJFZeps+hewg
	NzxLrSdrLW4f34XvQfuPUZ8q+Zn3FAGCHmbM2VMlz+6AmeRPT5Lb+QupjCsm+prUVg==
X-Gm-Gg: AY/fxX5N55dObOUgg5FkeSXP8sHV1FVQ7mZ9YL2t6Yw4L1iMz+nh1/e63wtELmTEqco
	+m9tO3DCUeRsmmI9LBMXsRX3Q4O/ZTZDs2Um0r0lpGA9W9JQgKXhiYnqjAY64Ls6L2SY2C17mtD
	VczVwbHG2mn8TZX5bat3PeUgjcqL54OtZjPPRTahwvnYfLRHsBAUaB1VRX7dQmr39B4bE627QKu
	zeXAg54st3fhLD2OcUZo2HfH3ipKkMFSxN0QWWTKnsdOzA8rgvSJ6EHhLoTQMAhCL3kNtf15SOE
	SzDdoUvSdoUhB2oDTP4UlaY1zskAhp9Ykm0Jq6ZbjraumVLkKxomjGTbbUwNNkYBVxI2wjcms/r
	u5eomnNbpu812qFyrnAFztG58oZX1Hvq/2r7BK5t8mds0f3dsvFlexKRyP6lXKCKsEJRp9qjXtD
	t/erjkV7qMlg13Yz0=
X-Received: by 2002:a17:906:6a1e:b0:b71:60a3:a8b9 with SMTP id a640c23a62f3a-b8793a5bf69mr1523608066b.29.1768918029060;
        Tue, 20 Jan 2026 06:07:09 -0800 (PST)
Received: from google.com ([2a02:a31b:20c3:6680:e571:3179:cb1d:9314])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbd23sm1405601566b.51.2026.01.20.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:07:08 -0800 (PST)
Date: Tue, 20 Jan 2026 15:07:01 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Clear Present bit before tearing down
 context entry
Message-ID: <aW-MBQg5q4SCivbk@google.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120061816.2132558-3-baolu.lu@linux.intel.com>

On Tue, Jan 20, 2026 at 02:18:13PM +0800, Lu Baolu wrote:
> When tearing down a context entry, the current implementation zeros the
> entire 128-bit entry using multiple 64-bit writes. This creates a window
> where the hardware can fetch a "torn" entry — where some fields are
> already zeroed while the 'Present' bit is still set — leading to
> unpredictable behavior or spurious faults.
> 
> While x86 provides strong write ordering, the compiler may reorder writes
> to the two 64-bit halves of the context entry. Even without compiler
> reordering, the hardware fetch is not guaranteed to be atomic with
> respect to multiple CPU writes.
> 
> Align with the "Guidance to Software for Invalidations" in the VT-d spec
> (Section 6.5.3.3) by implementing the recommended ownership handshake:
> 
> 1. Clear only the 'Present' (P) bit of the context entry first to
>    signal the transition of ownership from hardware to software.
> 2. Use dma_wmb() to ensure the cleared bit is visible to the IOMMU.
> 3. Perform the required cache and context-cache invalidation to ensure
>    hardware no longer has cached references to the entry.
> 4. Fully zero out the entry only after the invalidation is complete.
> 
> Also, add a dma_wmb() to context_set_present() to ensure the entry
> is fully initialized before the 'Present' bit becomes visible.
> 
> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
> Reported-by: Dmytro Maluka <dmaluka@chromium.org>
> Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 21 ++++++++++++++++++++-
>  drivers/iommu/intel/iommu.c |  4 +++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 25c5e22096d4..599913fb65d5 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -900,7 +900,26 @@ static inline int pfn_level_offset(u64 pfn, int level)
>  
>  static inline void context_set_present(struct context_entry *context)
>  {
> -	context->lo |= 1;
> +	u64 val;
> +
> +	dma_wmb();
> +	val = READ_ONCE(context->lo) | 1;

As IIRC Jason noted, READ_ONCE is not really necessary?

> +	WRITE_ONCE(context->lo, val);
> +}
> +
> +/*
> + * Clear the Present (P) bit (bit 0) of a context table entry. This initiates
> + * the transition of the entry's ownership from hardware to software. The
> + * caller is responsible for fulfilling the invalidation handshake recommended
> + * by the VT-d spec, Section 6.5.3.3 (Guidance to Software for Invalidations).
> + */
> +static inline void context_clear_present(struct context_entry *context)
> +{
> +	u64 val;
> +
> +	val = READ_ONCE(context->lo) & GENMASK_ULL(63, 1);

Maybe "& ~1ULL" would be a bit more readable? (and READ_ONCE not
necessary here either?)

Anyway,

Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>

> +	WRITE_ONCE(context->lo, val);
> +	dma_wmb();
>  }
>  
>  static inline void context_set_fault_enable(struct context_entry *context)
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 134302fbcd92..c66cc51f9e51 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1240,10 +1240,12 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  	}
>  
>  	did = context_domain_id(context);
> -	context_clear_entry(context);
> +	context_clear_present(context);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
>  	intel_context_flush_no_pasid(info, context, did);
> +	context_clear_entry(context);
> +	__iommu_flush_cache(iommu, context, sizeof(*context));
>  }
>  
>  int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
> -- 
> 2.43.0
> 
