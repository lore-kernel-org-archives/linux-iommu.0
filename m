Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01B3E8C56
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921453; cv=none; b=sq4tElN6WekVnT8Ng/4/BylfGK7OLgZsLR13B9jFUjSD7Yr1aKFN24dvqIyEeulurCG59C35VgHrS3jxm+Ola+N3ltaPOu6Te6S/jFb/8faDq79IjpVnaUygbyvapTyxPXo7DpPf8CSQQoaIpqsKJEAKw8PzZkpXojvsRAAmZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921453; c=relaxed/simple;
	bh=yq0tR9Yube9b7CYNkxubagoJauADeRUs64fe+jfXpS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTomPrN4kTwrBJLYlzAeDBo8UM+YkIwn322uDiVLrCfnyCy5IAOcaTkcDVnFqU02amPmgifSBL74pHnyDbf9I5XUglf0vzRNkyFtZ5RQKWA2wYv5d7vmwYLGV8tXb3UYox+8oZGS4eIlCU8OcJZwOFo8m6+r57AEZcMKKhD7Dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNcbmLSP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNcbmLSP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso11755e9.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784921445; x=1785526245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qMYgbX2E5STWJ3B50MJvZqK+f3UjOUURTR7CU8KzNb4=;
        b=VNcbmLSPF8yptmIxGETvSmIzjXF/TgpXr0wkeBniLvX0qAvcO2BaBIcSsGcAWS/jmO
         xhHwue4ca4v9EpYyGyqq9u+xX23Hh1EvkLz/5nTvO0dcRBqpyyGHmolhBhjqH1/qrNos
         bdIK2jau4rIoPe9ivo9VkGzL0NrKD+fp8Gb0wCnGgJ0iZAhky4IefnYJ2JM3OSUs4UOH
         c/3KgqyAqByavoWDI2ks6BZ8/AEx/nloulPgt02QRVSsVvulP3L6nqP2zAGzSNmpu1Le
         h8QrFiRvj8ZlfLvH+WKJ0Mgue8a5UO2dYjIQ/aU6RkyZGoMR6Inmwu0gYW+MJ2N95iqv
         EfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921445; x=1785526245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qMYgbX2E5STWJ3B50MJvZqK+f3UjOUURTR7CU8KzNb4=;
        b=Rze+Hdy6NbF3LF4EGuh1bbbXAomyI1DqHbHTj8MMg0rJ1b2GhjQ7VCOenQx4AIJRDF
         CA50Gl9pFw8S7YR9LeqZ1Iud9PXywdTZ0WG6Dcb8ORYm80HdDDh7h4R+4acP3/4Q8ZJV
         5ow/rkcGqdprCUZbf1YjrCli4wg4d1haFkFI2D68zG4SFW7ku66k8zhJn+rFiby8+zQZ
         Km5wVaPB9CJZ1eay8Z89k1aQkK+NypVjvA1EaSjksVV9THjRNGVKkXpAfB78Unzr7jo8
         HmJjACVUYKcQn35tcOIfI10SttvHgRE73/9X0yV5g1JOI76NHgPznvSvdpBlsSlL1l9T
         YVnQ==
X-Gm-Message-State: AOJu0YwY3fK4NoWfbgQEauGtKaMYW+GBUxzpSx80IRGVcC/Y5ynLUTtd
	C0Indzytg6arU7xru3euayDpzwB+mg54UCt/zpxvZVHpM+E68asYli88RZCUAlYTyQ==
X-Gm-Gg: AR+sD10iHB2UMUPlSE9SvtZj6mgth2JsB4LvzX7Ug0HRQhus9MQe/TE6cjH9uogsxdm
	k1dlQRVgXGjOBdH9fo0ADXStEH7YjiztXfJsFudnUsbC2k7iC85TCqbb+x2NWPv39VDhPwhJVBm
	v4fG7dnAaXY66asM2c2vZ0P7yODFllohRRSZa1Dqe1cvqViCiTalMjizPifpyTUav9RSR2zddcu
	u9+BxaTyNCYoNJwH2uyVf6gooRwy6DF0tvTycNKuha9W16NoH8R3jUsvxQ7KybFDQ+VdW7qBECR
	Ywgz3twYyYlt1jGuefMEtzoPleFdQ9pHO/ArXp9nzBtV5S8naZJ6RBxWen88R1lbAZaYmdNkmQr
	HxzjTgxn5K8hOKQJF61ntJBFEZSDyHln2zQm0HsbPkSb4QxdwM56mJycj4VxBlN7pRv0I6FF4Qa
	0MlHLX2Q/zyzlvGePPCAKDH3tjOUJcs4FgmDZXlA==
X-Received: by 2002:a05:600c:8709:b0:493:be38:fa5a with SMTP id 5b1f17b1804b1-496b4d388e8mr268615e9.10.1784921444576;
        Fri, 24 Jul 2026 12:30:44 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85a2573csm25874209f8f.0.2026.07.24.12.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:30:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 19:30:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 6/7] iommu/arm-smmu-v3: Use the generic iommu page table
Message-ID: <amO9X2vBl3_jIttb@google.com>
References: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
 <6-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:29:12PM -0300, Jason Gunthorpe wrote:
> Switch to use the iommupt provided page table. This is fairly
> straightforward now since the page table construction and hwinfo are very
> similar to io-pgtable-arm.
> 
> The struct pt_iommu_armv8_hw_info is a direct replacement for 'tcr' and I
> have a kunit compare test validating that the fields have identical values
> for identical configurations.
> 
> Quirks are replaced by features
>  IO_PGTABLE_QUIRK_ARM_HD -> PT_FEAT_ARMV8_DBM
>  IO_PGTABLE_QUIRK_ARM_S2FWB -> PT_FEAT_ARMV8_S2FWB
> 
> SMMU features are mapped to iommupt features:
>  ARM_SMMU_FEAT_COHERENCY -> PT_FEAT_DMA_INCOHERENT
>  ARM_SMMU_FEAT_VAX -> PT_FEAT_ARMV8_LVA
>  ARM_SMMU_FEAT_S2FWB -> PT_FEAT_ARMV8_S2FWB
> 
> Remove the iommu_flush_ops entirely, iommupt only uses gathers for
> invalidation. Wire the tlbi directly to the gather.
> 
> Remove the trampoline for map/unmap/iova/read_and_clear_dirt. iommupt
> directly provides the domain ops. Domain initialization is largely moved
> into iommupt common code.
> 
> Change the kunit to fully create a page table to generate the tcr bits for
> testing.
> 
> Compared to io-pgtable-arm iommupt has a number of key differences:
>  - CONT support, including always using RIL to avoid errata 3673557
>  - Unmap yields a single gather which generates a single tlbi operation
>     * free_list is always used to free after invalidate
>     * walk cache and leaf invalidation are combined for non-RIL cases
>       instead of being duplicated
>     * non-RIL cut over to all-invalidate covers walk invalidation now too,
>       umap -> single gather -> single all invalidate.
>     * RIL flushes the walk cache and leafs together with a good TTL hint.
>     * RIL always generates one command from any gather.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/Kconfig                     |   4 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  45 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 256 ++++++------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  11 +-
>  4 files changed, 110 insertions(+), 206 deletions(-)
> 

[...]

> -
>  static bool arm_smmu_dbm_capable(struct arm_smmu_device *smmu)
>  {
>  	u32 features = (ARM_SMMU_FEAT_HD | ARM_SMMU_FEAT_COHERENCY);
> @@ -2831,7 +2785,6 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
>  		return arm_smmu_master_canwbs(master);
>  	case IOMMU_CAP_NOEXEC:
> -	case IOMMU_CAP_DEFERRED_FLUSH:

Why this is removed? That would drop support for FQ domains.

Thanks,
Mostafa

>  		return true;
>  	case IOMMU_CAP_DIRTY_TRACKING:
>  		return arm_smmu_dbm_capable(master->smmu);
