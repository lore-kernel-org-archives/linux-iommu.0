Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C7030595C
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332889; cv=none; b=WYThrjgirMtmjmsKo0PxmWOLY2IuDdfFyjnbVtLdZ//27DCFQKDzDFwEgorqEyMhE5GQqj46c329Ra7dz9tpYOdMazfAA4PMBQqAMFzGK80nmykzMqSbl6I4fR1L7/0JNWxzhxFiTLGV5rBLAXcf87uOYqZ7DfElg0Feo2wL6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332889; c=relaxed/simple;
	bh=KlvnGJmVUAuRCNjJatrlsIGeul4jeleUr/qqDEznPF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEE0l7cdAuiaqeC9tX4Y8/hf6o1YaL9YzojuWoANmHbxEuGeXK7BntG92Fj2hCAeh/J94lwsqlm/hm3Nex5EXAx7NHpKn5NQr4nY9xooLZ0CPK4uCf942ndYr3RArFcVo9AWFYyABGOe8K8bfidxzI/uqnrun8oycII19OdllGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UFG3B3Np; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UFG3B3Np"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d6f647e2so78979215ad.1
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768332887; x=1768937687; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bglf+ETe2dFzW1wKgNK7cEa94WSgxycGCijsqR/Jnss=;
        b=UFG3B3Nppry9bMeSeVL8P/iBRp2LN/xukaS/aqjlw6yGfgpCmpgg+VVrzdhmGC1lWi
         DVAlnY8WWsl5HHDnQVVSnqS5cd6/d8sGB3vTkabblToGCSt97P6NZUhZT1w7+tsSCAqK
         e28Zpt35nHr/cPGNwBj6l5M0ZWof5M6L6keLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332887; x=1768937687;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bglf+ETe2dFzW1wKgNK7cEa94WSgxycGCijsqR/Jnss=;
        b=jzilIc7TKVgsbGCGJXFEHyVjsAvSphwNOmBqRIvVLzOpa2JvACkH6+cGn6SP3KSzsg
         p6rueFBADnXa050F04Sr5eeDfV3pmvk6Si0L5H4QIxXrQu9Gz6DMMzMe2HdO6dwgNcuO
         6zTvGeDfQfxcozlBSet7aLzU3h07MfZsitKhzh01OlKIvhZ2Kdti9FBUHFQzIwxuSLGy
         NVhv1OUy1HkEGRKdWLEXD6Dx5sVnoKICyv0oT4NYorwou3sMPAt80lJOOEUowFTirDhp
         R9WNQft7yOGRP3VnuLhMKIYhz7jTwbAd/vyCKDTpiDTnl5tofzY38FZ4tb7v/Hm/2bqX
         un5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgjURVsJX/sOTBjETvrBkUSIvYgIQ6LI8UtoMUrW2TbqLXPesLMpwTo6w4IpI2kuIPcOhdwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyADQBaMw8eEYXnWpcNYySzyXf6D0uguB1G6fODyAFif4uOGGKr
	UiAltZ1RXlSTiAKX56CRiYm4jHm+Tywqem2SuKajEUSSsDEqByr3K+smnR1tDX/9YQ==
X-Gm-Gg: AY/fxX4BdKvhpPCSaQQbROvGzuvfrGksGkOvm3R0ojSLH9F9VJj4+OMRTWvVSvzwr1v
	TCxsvE2frSCDnlm/L/b8xBjuz0gtFTyFH+dba70Bq3QQ7QpzYTXQlqurgt++R6Gx8ov4UxgF+Ft
	KDnG6F2paxclyOOWxMqOgUygxXeCibLEV/pZTj+9bKMYV1qnNLexF0VQqkcffky/VbAjj4HnILc
	WaOuMVjKQgUxIs+xgdbozNHNVAm84UdAHRLAdQfTYfoOXYrwpGBu+KUxyyhF+aFDI/vW8JoKiLd
	cMCjL18s30lPHVJ6yEAbAIVHbJZ/6A65R4ZM7TSbLEcV/hEU+YUKS6hidVdrrbx/c+o1nPdVH5D
	2sD8KMOi6vLh1vBrdjpfz37iMaXXyuEd8UL1JYn+0zpHkQGedGSp1wW76lw77Po1hofyj3w==
X-Received: by 2002:a17:903:240c:b0:299:bda7:ae3c with SMTP id d9443c01a7336-2a599dba336mr1201375ad.14.1768332887081;
        Tue, 13 Jan 2026 11:34:47 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:e42d:53cb:2a0f:636a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-351067d39b4sm310155a91.0.2026.01.13.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:34:46 -0800 (PST)
Date: Tue, 13 Jan 2026 20:34:40 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Message-ID: <aWaeUJcAFQ_vbJtd@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113030052.977366-3-baolu.lu@linux.intel.com>

On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
> The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
> bytes). When tearing down an entry, the current implementation zeros the
> entire 64-byte structure immediately.
> 
> However, the IOMMU hardware may fetch these 64 bytes using multiple
> internal transactions (e.g., four 128-bit bursts). If a hardware fetch
> occurs simultaneously with the CPU zeroing the entry, the hardware could
> observe a "torn" entry — where some chunks are zeroed and others still
> contain old data — leading to unpredictable behavior or spurious faults.
> 
> Follow the "Guidance to Software for Invalidations" in the VT-d spec
> (Section 6.5.3.3) by implementing a proper ownership handshake:
> 
> 1. Clear only the 'Present' (P) bit of the PASID entry. This tells the
>    hardware that the entry is no longer valid.
> 2. Execute the required invalidation sequence (PASID cache, IOTLB, and
>    Device-TLB flush) to ensure the hardware has released all cached
>    references to the entry.
> 3. Only after the flushes are complete, zero out the remaining fields of
>    the PASID entry.
> 
> Additionally, add an explicit clflush in intel_pasid_clear_entry() to
> ensure that the cleared entry is visible to the IOMMU on systems where
> memory coherency (ecap_coherent) is not supported.
> 
> Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h | 12 ++++++++++++
>  drivers/iommu/intel/pasid.c |  9 +++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index b4c85242dc79..35de1d77355f 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -237,6 +237,18 @@ static inline void pasid_set_present(struct pasid_entry *pe)
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
> +}
> +
>  /*
>   * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
>   * entry.
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 298a39183996..4f36138448d8 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -178,7 +178,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>   * Interfaces for PASID table entry manipulation:
>   */
>  static void
> -intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
> +intel_pasid_clear_entry(struct intel_iommu *iommu, struct device *dev,
> +			u32 pasid, bool fault_ignore)
>  {
>  	struct pasid_entry *pe;
>  
> @@ -190,6 +191,9 @@ intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
>  		pasid_clear_entry_with_fpd(pe);
>  	else
>  		pasid_clear_entry(pe);
> +
> +	if (!ecap_coherent(iommu->ecap))
> +		clflush_cache_range(pe, sizeof(*pe));
>  }
>  
>  static void
> @@ -272,7 +276,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  
>  	did = pasid_get_domain_id(pte);
>  	pgtt = pasid_pte_get_pgtt(pte);
> -	intel_pasid_clear_entry(dev, pasid, fault_ignore);
> +	pasid_clear_present(pte);
>  	spin_unlock(&iommu->lock);
>  
>  	if (!ecap_coherent(iommu->ecap))
> @@ -286,6 +290,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>  		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>  
>  	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);

Is it safe to do this with iommu->lock already unlocked?

>  	if (!fault_ignore)
>  		intel_iommu_drain_pasid_prq(dev, pasid);
>  }
> -- 
> 2.43.0
> 
