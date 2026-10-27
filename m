Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125790;
	b=fWn4nEdS9uUfdXD8qou09AdMcJcvJKti9hKvYqIIwtNY7xlKLl37KPdeElEQtM1MJqGK
	 li0J1JFTBf81lSw9Czvq7uGkgODtcRyQ//9asxxQyt71fVjk4yifYqdzw9CPVQJNHd+0Y
	 4ll35vlpRrZC5KGqdayIfxWFVqftEPufXhOwcycmwNto1dyWKyuxjruPf2GHQzayarEUe
	 W1YYY7esd2iALcK7hExW/ftwR5vppOZaxHGEdiaDwwGA+gtpVgZ86+KF7dBXlX7qP6rav
	 vcp4MmgD7fVHpd0kVflbIkoCfhANj9X4nfgb1FQDTGOtmo6L2BMrz8Xa3PU9FItK1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
	b=QOEqU72rkOTMiAr3+3VIP3gVWNlkRVOsIxaguUpJW/Dm8WC2x6Itpx2AaI72DZoI/xX3
	 o+Um6bg/t/7JoWpwaUGiDXTdb+D9aTfBCqmF8aSkGqv6VRouxCETSmS0Lr2BCiOl+uVjM
	 iXovwduca9g20t4eifFo+JjCqRj3BSb+G9OEJO68fsozplm0JMCvxjpHZUAOeOFHeZA/1
	 kLplizR+ancCNJMprJZ/ZOxa4d2L8lLHmn24QHofmLoD5N5ScgFdCtfnBaqzPsgYAaHLd
	 Tj/Zsxp7GH5usRPQj6i0weHasy0RjgrtSe4+HIE7en9t2adD2CkLti1zLIpO+DNCUyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jlUee0Vz;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85D606A31E
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 18:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F85D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=jlUee0Vz
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f20b304c0so6051285a.3
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793125789; x=1793730589; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
        b=jlUee0Vz787b6XmfWD5Z9o35z6fF61xf3rQe2oCe62CToRghIRz+wy61jiTiFLxYSP
         E/ZP5LU5HbZnCVW3cUyL1pEQuQC1Nmp0kdvNEz2cQttUloxzXzzyIlhktDPoZiwnqynD
         2jq+0szeoHHw2OIE0jXqY0Sey3Ky1D0glRRwADLLDH56nL4I6Ml7havXzOyJXKRvywL0
         wLeUYANCCS9mr+nYTCC+QaR5E91UnMeZtsmrQLkCsZFGKXoYSLiRHlX8A9DzyHh1GVt6
         pY0V5+F59jTr2/WqIxbihZZ0hFF8BkF9/EF/wB41z9oHZAUEwAeajOVqLp4j21XK0ctN
         IAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125789; x=1793730589;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=65AOdH+KgJ7resuIkk0VLKCd0Hg6dbezaVp42JhIP6w=;
        b=VBbDMIXPeuqJeuDh7JzyISav2ydvpQGnKJCrIRGdba+TMSKaGUuzaA01ksRmAL3OIh
         t4+K6F6dO9m6TsKQMqs17i1g/kTcwsOCyz7h5jxNUmToNswZ2ZrU+N7LM0T0Fvk/Jxkj
         sUFflgL/29xl1CsGFDIwG+lnnYg1AcIxxzCRlmGCYQoehlhj3gWigJqtCidtjGVrBDic
         V7cywBZRcdr81y/eeMTyGNm/PM3ETr5+wT2xxS0VlWVg3+JDuGp52NpH5thxfO26m4fx
         knIffWSiM/oTh4RjUDiDGU5Q/fOY8NsbotJ07BmENWG8AOfo6lEaiZ13G91rIzHvDrtu
         fYdQ==
X-Forwarded-Encrypted: i=1; AKwUvByVDw09q80xQlpfSlRmh4LFhrVrxXMp2NqUyAXb/B+SM7S7UvZTByLb7cm31GYqdpvOz4a8/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1xzlQuGMbqwvxZ5xvBUZg8TjW9h6EKmadirT5Rm7wRMO+e6sp
	LmnRiDbMPdDD+9BqDzCq6ITr/IKMzz1e0i7/PemklrBJ7YxeCWjYL1jBuagfIUXmeAM=
X-Gm-Gg: AYBFou1tQ4BIocPMeadd+JWlHKvr5g0t1NRBZ3cegkqW5PR/cBFxLSoMUaaG/1oU/8I
	AJI8/QjIg4WBBUHyfWiFa5y4YS3ooi3AeEwlZ4whC2Uvyzq1QkOi7nsae1S0rjct/SP11f/yKGP
	V2vZGnQBnY1rYYmNkOoM3Ygikyg0kZSHj2INJw7Zck+x5hY/PTeTFmvl8c0tpWU9lBn82pdGQzo
	8oiPIhcoy9LSKpa76lEprtcEVXuKd96zmhSbgUZXXgNgeLyaZMaUTo7IK8QtTI2Gl4A7A2nWBxv
	/o2EQ16kykGxe+rQxBWe4h1Z9rm8DNKs2r33r4sB/0jahxbHfXT5EZotN2kKGbQMnGOEhCoSYWP
	olUbW0wMBmxRMJEa2FAu/rB3zYkA9L+3CLA2xPIpEWHbo173Fi6jHwjme+g8GxRO/lEJn863v1T
	GDhiG4/grhdjgF/SGQlPseauPpSsD0mzzCfUisvOsb/caAERG6BE/QVaiVJ40bbVZ1KTorkShel
	3NVd63c/NR2BzrvL9ZCAodSHw67WOaT69B53w5ErvXeYDXfxuYZ0xx4gap6o3waLPBdFXcI/Jnv
	zOpigpIP/kLABmgPH6yrZcTNSgQha7A/cIySWw==
X-Received: by 2002:a05:620a:2a03:b0:93e:c12c:9dc6 with SMTP id af79cd13be357-940ef9c39f3mr1650841185a.70.1793125789315;
        Tue, 27 Oct 2026 11:29:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f06690c0sm1051945485a.11.2026.10.27.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:29:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xLlvf-0000000AgNQ-0B8b;
	Tue, 27 Oct 2026 15:29:47 -0300
Date: Tue, 27 Oct 2026 15:29:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v4 1/2] iommu: Add iommu_for_each_pci_mmio_window()
 iterator
Message-ID: <20261027182947.GI1685504@ziepe.ca>
References: <20261022193359.GF3381610@ziepe.ca>
 <20261025133000.205508-1-guanghuifeng@linux.alibaba.com>
 <20261025133000.205508-2-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025133000.205508-2-guanghuifeng@linux.alibaba.com>

On Sun, Oct 25, 2026 at 09:29:59PM +0800, Guanghui Feng wrote:
> Add a callback-based iterator that walks a PCI device's host bridge
> MMIO windows and invokes a caller-supplied function with each window's
> bus address range.  This consolidates the bridge window enumeration
> logic into a single shared algorithm in the IOMMU core.
> 
> Refactor iova_reserve_pci_windows() to use the new iterator, replacing
> its open-coded resource_list_for_each_entry loop.  The callback approach
> avoids intermediate allocations: the DMA path's callback directly calls
> reserve_iova() with the computed PFN range, maintaining the same
> zero-allocation overhead as the original open-coded loop.
> 
> Using a callback rather than returning a linked list of iommu_resv_region
> entries eliminates size_t truncation risk on 32-bit PAE systems (the
> callback receives phys_addr_t start/end directly) and removes the need
> for allocation failure cleanup paths.
> 
> Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
> intentionally keeps PCI window reservation out of the IOMMU group-level
> reserved region API.  This iterator respects that boundary: it does not
> inject windows into iommu_get_group_resv_regions().
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/dma-iommu.c  | 29 ++++++++++++++++------
>  drivers/iommu/iommu-priv.h | 25 +++++++++++++++++++
>  drivers/iommu/iommu.c      | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 8 deletions(-)

Seems OK enough

> @@ -504,6 +505,20 @@ static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
>  	return res_a->res->start > res_b->res->start;
>  }
>  
> +struct iova_pci_resv_data {
> +	struct iova_domain *iovad;
> +};

We don't need a struct to pass a single pointer

> +struct pci_dev;
> +
> +/**
> + * iommu_pci_mmio_window_fn_t - callback for host bridge MMIO window iteration
> + * @start: First PCI bus address of the window (inclusive)
> + * @end: Last PCI bus address of the window (inclusive)
> + * @data: Opaque pointer from iommu_for_each_pci_mmio_window() caller
> + *
> + * Return: 0 to continue iteration, negative errno to stop and propagate.
> + */
> +typedef int (*iommu_pci_mmio_window_fn_t)(phys_addr_t start, phys_addr_t end,
> +					  void *data);

Don't really need a comment here

> +#ifdef CONFIG_PCI
> +/**
> + * iommu_for_each_pci_mmio_window - iterate over PCI host bridge MMIO windows
> + * @dev: PCI device whose host bridge to scan
> + * @fn: callback invoked with each window's bus address range
> + * @data: opaque pointer passed to @fn
> + *
> + * Walks the MEM windows of @dev's PCI host bridge and invokes
> + * @fn(start, end, data) for each one, where start and end are PCI bus
> + * addresses (inclusive).  Iteration stops early if @fn returns non-zero,
> + * and that value is propagated to the caller.
> + *
> + * This provides a zero-allocation way for both the DMA IOVA layer and
> + * iommufd to enumerate the same host bridge window information using a
> + * shared algorithm.
> + *
> + * Note: commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
> + * intentionally keeps PCI window reservation out of the IOMMU group-level
> + * reserved region API.  This iterator respects that boundary: it does not
> + * inject windows into iommu_get_group_resv_regions().

The last two pargraphs are not very useful

> + *
> + * Return: 0 on success, negative errno on failure (including from @fn).
> + */
> +int iommu_for_each_pci_mmio_window(struct pci_dev *dev,
> +				   iommu_pci_mmio_window_fn_t fn, void *data)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct resource_entry *window;
> +
> +	if (!bridge)
> +		return -ENODEV;

Can it fail? The existing code doesn't check it so I guess not. Stick
a WARN_ON there if you want to keep it.

> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		phys_addr_t start, end;
> +		int ret;
> +
> +		if (resource_type(window->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		start = window->res->start - window->offset;
> +		end = window->res->end - window->offset;
> +
> +		ret = fn(start, end, data);

Don't think we need the start/end variable either

Jason
