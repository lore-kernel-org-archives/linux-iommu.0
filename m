Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA8438FE0
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917420; cv=none; b=Ke0ZgbumNZAT8FEK6gtRy0vUDZKBjNxqRm1fRqq7I0oF37pZoLbeDl/7oQut0rDx3nPrXgXZcKogolR9tSfJSGWxcPUaHraOOTwQWICkBhJWcVlNRl8y4g+NLsxFiY3fqnvKSfUMpH/7GydUNP+TnnZ/m/prnpWapbEdCDBvXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917420; c=relaxed/simple;
	bh=Oz2PS8PFD1LDmr8ymNaHAXqQ81E0n1daYb0OyeLdPfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn+cqPAng3OOEJ9rIeWVEzJAcxtsnhA1RxZ+DmfUHHTkET7OeYVL07A2pqEJBnpQYdLMwBfjCtTQTTcKZDulnJ2QKM5ToxdeLlSoZle6SUo66HleuSEDEfweK+SOPvYOgDTO7UASg09ZqYdlHRb0g4ZAkdYPpg/N/b3Xs9igoYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AVcMquIt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AVcMquIt"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso8093422a12.3
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768917417; x=1769522217; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PihClK+bT+Z9Jovg1xgOdZAfgKRFBVik/JXwiYidYiY=;
        b=AVcMquItnkvdAkd2S18k5iXxag/YgGHXBxnNS/osnRNhkBNs3tZrGZyCQK1P58VWM8
         5UfhGQTjEqgyYa9JjR31Xf2zpZYd4SUFOypj2kahs/gdZw0Tkq3iNiaTeXlgN+qlCiHK
         GkbYpt3Xm7tMv0t8cZhJSiHONtblO77Himils=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917417; x=1769522217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PihClK+bT+Z9Jovg1xgOdZAfgKRFBVik/JXwiYidYiY=;
        b=L5wIS4n3ysg9xAEnt0rrHYFy34kf3q8v1k2ZyDWGDMLdg7wcEz4GvMb6RO9TKEntqj
         S7hWJemsTmCrqmE2qKJS1qlqxmIY3p9eyjHk6vcMwuU9CQlCyUNC8a5F/ubh6Zsiz50S
         Ofy4hc93yxEAvPZm3Km01ylmjaPSB0eMwxIb+E8uusPOT27a2t5xrT+8p6kQ+mU0SAl4
         68wvDwnuHWIt5NK68erfHr3aPxQKb5f9Zm7mORHg++GOKoovk38ZCsrWeX3J76SvLSzz
         Ql+YMkXQumfmOng/+LL6zVxXuqxkjEvB9fv+XBnZCGkVExOjAD1uRKxCwVBcPksztySx
         bSeA==
X-Forwarded-Encrypted: i=1; AJvYcCXDj2IYXooxrDJ+hGcc7AlHQGDI7cERSLTWs/5qXi3EjFDuuHzqGRuRYB8wEjAXULB3GOt06g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbqcNiZ542yY9bcFX7kejr8x/jf8S3pZNfGPFDmSGL3XIC4nfh
	URgIceDpNNkZ1t8BhEDNQmAkHZ1McBVKtTXilRr2e/ngK2lznYxPD05VLprDPijGqQ==
X-Gm-Gg: AZuq6aKPUZ9WSsQhxmIh65v7MnIQwAGs+42tYsJLxpofZsXYf/o1HoX9svo/QLteBvB
	rj3sCGLgNel3vXYQjjwLNWwXsa0RmAk2Wurs1izV6I1s7Hl8Gp+up5at1FnsphI3XZK1u81myWa
	44N7OiF67uODn4DAX9n6Ucgr0cGS+itSl7tgJqjI3L/sXUcNQ4JM4v9y4ckXbp0QIcrFXNysJEW
	cIJhBJCXDm+z46VCK0msGkS29tFfL3L4zhnsOpEImuN/ybuHYAYuW6E9si/dfeceZiBgSd4mrcQ
	iOER1Nms4yOFoYdXF3rm4Yzd2elBzeaK+wVpmBOGvqH9N4QNaHiTIPNqMr0riuigxXcIMopP437
	Iko4IQ7yHYqVH28eJ0X9By9mOOTs1ppHF45LQ8zC/ztkSmJ3VU24PAj82O0eZQjSWty9NsbMwUl
	IMt9lEjiQb6EAvfYA=
X-Received: by 2002:a17:907:d7cb:b0:b86:eda4:f770 with SMTP id a640c23a62f3a-b8792e0cda9mr1441703466b.21.1768917417228;
        Tue, 20 Jan 2026 05:56:57 -0800 (PST)
Received: from google.com ([2a02:a31b:20c3:6680:e571:3179:cb1d:9314])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9f8dsm1393030166b.36.2026.01.20.05.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:56:56 -0800 (PST)
Date: Tue, 20 Jan 2026 14:56:53 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH v2 1/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Message-ID: <aW-JpXkqEpGTL7eq@google.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120061816.2132558-2-baolu.lu@linux.intel.com>

On Tue, Jan 20, 2026 at 02:18:12PM +0800, Lu Baolu wrote:
> The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
> bytes). When tearing down an entry, the current implementation zeros the
> entire 64-byte structure immediately using multiple 64-bit writes.
> 
> Since the IOMMU hardware may fetch these 64 bytes using multiple
> internal transactions (e.g., four 128-bit bursts), updating or zeroing
> the entire entry while it is active (P=1) risks a "torn" read. If a
> hardware fetch occurs simultaneously with the CPU zeroing the entry, the
> hardware could observe an inconsistent state, leading to unpredictable
> behavior or spurious faults.
> 
> Follow the "Guidance to Software for Invalidations" in the VT-d spec
> (Section 6.5.3.3) by implementing the recommended ownership handshake:
> 
> 1. Clear only the 'Present' (P) bit of the PASID entry.
> 2. Use a dma_wmb() to ensure the cleared bit is visible to hardware
>    before proceeding.
> 3. Execute the required invalidation sequence (PASID cache, IOTLB, and
>    Device-TLB flush) to ensure the hardware has released all cached
>    references.
> 4. Only after the flushes are complete, zero out the remaining fields
>    of the PASID entry.
> 
> Also, add a dma_wmb() in pasid_set_present() to ensure that all other
> fields of the PASID entry are visible to the hardware before the Present
> bit is set.
> 
> Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>

> ---
>  drivers/iommu/intel/pasid.h | 14 ++++++++++++++
>  drivers/iommu/intel/pasid.c |  6 +++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index b4c85242dc79..0b303bd0b0c1 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -234,9 +234,23 @@ static inline void pasid_set_wpe(struct pasid_entry *pe)
>   */
>  static inline void pasid_set_present(struct pasid_entry *pe)
>  {
> +	dma_wmb();
>  	pasid_set_bits(&pe->val[0], 1 << 0, 1);
>  }
>  
> +/*
> + * Clear the Present (P) bit (bit 0) of a scalable-mode PASID table entry.
> + * This initiates the transition of the entry's ownership from hardware
> + * to software. The caller is responsible for fulfilling the invalidation
> + * handshake recommended by the VT-d spec, Section 6.5.3.3 (Guidance to
> + * Software for Invalidations).
> + */
> +static inline void pasid_clear_present(struct pasid_entry *pe)
> +{
> +	pasid_set_bits(&pe->val[0], 1 << 0, 0);
> +	dma_wmb();
> +}
> +
>  /*
>   * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
>   * entry.
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3e2255057079..eb069aefa4fa 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -272,7 +272,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  
>  	did = pasid_get_domain_id(pte);
>  	pgtt = pasid_pte_get_pgtt(pte);
> -	intel_pasid_clear_entry(dev, pasid, fault_ignore);
> +	pasid_clear_present(pte);
>  	spin_unlock(&iommu->lock);
>  
>  	if (!ecap_coherent(iommu->ecap))
> @@ -286,6 +286,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>  
>  	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	intel_pasid_clear_entry(dev, pasid, fault_ignore);
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pte, sizeof(*pte));
> +
>  	if (!fault_ignore)
>  		intel_iommu_drain_pasid_prq(dev, pasid);
>  }
> -- 
> 2.43.0
