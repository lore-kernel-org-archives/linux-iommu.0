Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700680;
	b=v4ESybahf/cirx+8E8fAU+SNdmmhb3whnMrKTekgT4EC5XemtPPLQSCLCWHqfjOtpTni
	 P7tJ1UN2MUZG828hMv/4lQkd4vKuK2Eo7LdSTR+Pn9fJvpjjQ57L07m+AxDpl4+whH2ih
	 awKFgvdVCLuCK4ZqJGEm6sbaAaDL/StQZpeKPkNCNg/DnjeU9eNUvL8EazbnnujAGKzeG
	 J5QbVDr0McbxcJQ/0NnYrfXnUin1sSMaLkluXbXi8vTDrzfgnuTEckQiAQOON3BcK0hkw
	 KRVcp+s2GNGlqdZaaVG50TWkUTDuVbhPUh4hritJb0ajZ8i6I6fJp5+z9nx4LnS3kPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700680;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=oEeAOkIMhm2brVx+57mg0HvmlruExTUNaN3KGm7ZRmQ=;
	b=B9clPI08yqzRWncUf1LAU7WhLOhxNnoKKzPfxTNBVXHKwk/NanXMpuz7HYmf6ktwV3nG
	 kl3otFgcDcFKJuju0qwQyFdYnj7cV6Y7R8Ehx9jMPfIvTUZDZBWpA6Y9IuXtuXOfj2j/v
	 5DF0moKRFVCyfLCQFp2H6paM2tXK7NWw4tKVraOZ1j51C6ZKNyd6ARGwtqzVTLKqZPzcK
	 MMZrgT41u/3qHXBWJNZXVre6mJTzghIfRrbeXDDpHD79kKEvsHB1A8FqiByaLiTA1CzOZ
	 PagueM1nG9WDVsq/kDBtWbXOPkLg/ExoRLJbed81CTjcVw1YuKXJzk3KSWohy3TQLJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W+HKkBv6;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED74606A332
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 10:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED74606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W+HKkBv6
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261103101116euoutp028ef9b82e5b9ee18dc7c534a4baf9a4ac~kgUMbxOR12903629036euoutp02z
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 10:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261103101116euoutp028ef9b82e5b9ee18dc7c534a4baf9a4ac~kgUMbxOR12903629036euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793700676;
	bh=oEeAOkIMhm2brVx+57mg0HvmlruExTUNaN3KGm7ZRmQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W+HKkBv6baZB/MFF4sW9EQIXMaH/WWcE0xLv30OQ1O3EWG5zu0LlDPyhpUo1rXQWO
	 wP3pGtKk8BL5a/qRQQdn56Eash1rX+aexjjU29CJDaiMoDlrErCvRkS0FO/wcf9yAm
	 I8vBGYoJwHVdGf4B7c7QwwC3yrse8D6SWUm4ERx8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103101116eucas1p1eadfbb1f322f96673fff2419c4cc5dac~kgUMEKwti2453024530eucas1p1v;
	Tue,  3 Nov 2026 10:11:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103101114eusmtip1ab1d1332cf288f23ef33eca39d491c32~kgUKcvhCg3212232122eusmtip1W;
	Tue,  3 Nov 2026 10:11:14 +0000 (GMT)
Message-ID: <373ea0e8-d0c4-4071-9546-8c4df5d09393@samsung.com>
Date: Tue, 3 Nov 2026 11:11:13 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 2/7] dma-mapping: Let a device declare that it
 reaches private memory
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	joro@8bytes.org, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, driver-core@lists.linux.dev, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	shameerali.kolothum.thodi@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <0697a7ab3e4c4b7703428644444fd13f8dbfccd9.1793676742.git.nicolinc@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103101116eucas1p1eadfbb1f322f96673fff2419c4cc5dac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103035021eucas1p17d005335232f75ad6f3b711b7c4b88d5
X-EPHeader: CA
X-CMS-RootMailID: 20261103035021eucas1p17d005335232f75ad6f3b711b7c4b88d5
References: <cover.1793676742.git.nicolinc@nvidia.com>
	<CGME20261103035021eucas1p17d005335232f75ad6f3b711b7c4b88d5@eucas1p1.samsung.com>
	<0697a7ab3e4c4b7703428644444fd13f8dbfccd9.1793676742.git.nicolinc@nvidia.com>

On 03.11.2026 04:49, Nicolin Chen wrote:
> DMA devices in a confidential guest can access only shared memory, or both
> private and shared memory. Some method outside the DMA API will confirm the
> device is able to access private memory through DMA.
>
> Add DEV_FLAG_DMA_CC_PRIVATE and dma_set_cc_private(dev, bool).
>
> The flag must be stable while any DMA mapping exists.
>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  include/linux/device.h      |  4 ++++
>  include/linux/dma-mapping.h |  4 ++++
>  kernel/dma/mapping.c        | 21 +++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 429e39f647cf9..01d7877d0b571 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -604,6 +604,8 @@ struct device_physical_location {
>   *		ancestor device.
>   * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
>   * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
> + * @DEV_FLAG_DMA_CC_PRIVATE: The device is able to access private (encrypted)
> + *		memory, no shared memory bouncing is required from the DMA API.
>   * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
>   */
>  enum struct_device_flags {
> @@ -617,6 +619,7 @@ enum struct_device_flags {
>  	DEV_FLAG_OF_NODE_REUSED = 7,
>  	DEV_FLAG_OFFLINE_DISABLED = 8,
>  	DEV_FLAG_OFFLINE = 9,
> +	DEV_FLAG_DMA_CC_PRIVATE = 10,
>  
>  	DEV_FLAG_COUNT
>  };
> @@ -834,6 +837,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
>  __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
>  __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
>  __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
> +__create_dev_flag_accessors(dma_cc_private, DEV_FLAG_DMA_CC_PRIVATE);
>  
>  #undef __create_dev_flag_accessors
>  
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index efde0e5a58dc2..3cc38db4a7490 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -218,6 +218,7 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
>  void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
>  int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
>  		size_t size, struct sg_table *sgt);
> +void dma_set_cc_private(struct device *dev, bool private);
>  #else /* CONFIG_HAS_DMA */
>  static inline dma_addr_t dma_map_page_attrs(struct device *dev,
>  		struct page *page, size_t offset, size_t size,
> @@ -357,6 +358,9 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
>  {
>  	return -EINVAL;
>  }
> +static inline void dma_set_cc_private(struct device *dev, bool private)
> +{
> +}
>  #endif /* CONFIG_HAS_DMA */
>  
>  #ifdef CONFIG_IOMMU_DMA
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 82e701648d604..ded585b39fb92 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -501,6 +501,27 @@ static void dma_setup_need_sync(struct device *dev)
>  static inline void dma_setup_need_sync(struct device *dev) { }
>  #endif /* !CONFIG_DMA_NEED_SYNC */
>  
> +/**
> + * dma_set_cc_private - Set whether @dev can DMA to private memory
> + * @dev: device whose confidential-computing DMA access is being updated
> + * @private: whether the device can DMA to private memory
> + *
> + * Called when a device is known to be able to DMA to private memory.
> + * For architected CPU integrated devices their kernel drivers will
> + * self-accept using a driver specific validation. Other devices will
> + * have a userspace managed process.
> + *
> + * DMA mapping must not be active when this flag is changed. For CPU
> + * integrated devices the driver should self accept early during probe
> + * after validation. Other devices have this flag set automatically
> + * before probing.
> + */
> +void dma_set_cc_private(struct device *dev, bool private)
> +{
> +	dev_assign_dma_cc_private(dev, private);
> +}
> +EXPORT_SYMBOL_GPL(dma_set_cc_private);
> +
>  /*
>   * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
>   * that the intention is to allow exporting memory allocated via the

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

