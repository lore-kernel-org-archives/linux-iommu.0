Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A723E320;
	Tue, 24 Mar 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367187; cv=none; b=SVtAeTLyVHbWwUTSdqhhNc22xdOVxuj5FdoCBDe2Hz+u7wHewjMcLNw6wflOY/lH58rO9Zf45Mwzha8ORBR9gZkMy1sO1vDjFpzn5ETURhsumdVmWO0RIvCef2JKdZEYJxk802hfUzl0E6kHY8U5BXFxBYMu48TImgwG+N+PFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367187; c=relaxed/simple;
	bh=FYUbLS4x6Nc+I7HqaW/Crr9Gva6T47bDev7ITRWYHvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBphmh3JzIXroyOGftSBTLr+lXNqXfdkljPFrZ+dBUePggX17OKUp7vhoHpgl4V4Doiihva1YDHoZcjttht1A/W0pG08+ZAp92XQBhFkwm2fitJzZRmIlDfohgNRV3ncIemBxkANktZqqrmJjU80UI1YsSiX5OSaPduigpJiIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPJOwUL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPJOwUL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3123FC19424;
	Tue, 24 Mar 2026 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367187;
	bh=FYUbLS4x6Nc+I7HqaW/Crr9Gva6T47bDev7ITRWYHvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPJOwUL/O2nlpD5r3r3Wgk6C5YAnuJ0uxdQRtF4wYqnSZMGYFF7fC8JL7GG2oWXN0
	 ehBMJyrWX67MCLCBOBGh4cOw2PyJ8hxoikPIA0zex39PWC/jI6AQq7yjPd8AzlxlwG
	 TXlLEwA7KiV9vZB7xJ6sCjO60unz078JzHduvzahYYmuSMN1XPJcrVNJdPCYfaa+SB
	 p+wfDsg1PIM9AmYCdVHbnU5dBTXsoqxqyxAMR7iztZOI3uXGWLTtBO6RSZAXQKM9K1
	 WtvngY8dmI3P5TtK8lkos5o0xHfsUGO4QuptZ6Or3d1Gy/CTHLFnKOnMB4f4PY25Ig
	 V6sgthkh5OVIw==
Date: Tue, 24 Mar 2026 15:46:20 +0000
From: Will Deacon <will@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v13 3/6] iommu: Add verisilicon IOMMU driver
Message-ID: <acKxzGk1Z541yoZ4@willie-the-truck>
References: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
 <20260216095144.107356-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216095144.107356-4-benjamin.gaignard@collabora.com>

On Mon, Feb 16, 2026 at 10:51:35AM +0100, Benjamin Gaignard wrote:
> The Verisilicon IOMMU hardware block can be found in combination
> with Verisilicon hardware video codecs (encoders or decoders) on
> different SoCs.
> Enable it will allow us to use non contiguous memory allocators
> for Verisilicon video codecs.
> If both decoder and this iommu driver are compiled has modules
> there is undefined symboles issues so this iommu driver could
> only be compiled has built-in.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  MAINTAINERS               |   8 +
>  drivers/iommu/Kconfig     |  11 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/vsi-iommu.c | 794 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vsi-iommu.h |  21 +
>  5 files changed, 835 insertions(+)
>  create mode 100644 drivers/iommu/vsi-iommu.c
>  create mode 100644 include/linux/vsi-iommu.h

[...]

> +static size_t vsi_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
> +			      size_t size, size_t count, struct iommu_iotlb_gather *gather)
> +{
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
> +	unsigned long flags;
> +	phys_addr_t pt_phys;
> +	u32 dte;
> +	u32 *pte_addr;
> +	size_t unmap_size = 0;
> +
> +	spin_lock_irqsave(&vsi_domain->lock, flags);
> +
> +	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
> +	/* Just return 0 if iova is unmapped */
> +	if (!vsi_dte_is_pt_valid(dte))
> +		goto unlock;
> +
> +	pt_phys = vsi_dte_pt_address(dte);
> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + vsi_iova_pte_index(iova);
> +	pte_dma = pt_phys + vsi_iova_pte_index(iova) * sizeof(u32);
> +	unmap_size = vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma, size);
> +
> +unlock:
> +	spin_unlock_irqrestore(&vsi_domain->lock, flags);
> +
> +	return unmap_size;
> +}

I still think you need TLB invalidation here.

I looked at the downstream code that you linked to and it litters the
invalidation in the callers via mpp_iommu_flush_tlb(), which tend to
invalidate _before_ starting an operation. That's very likely buggy and
certainly not something we want upstream.

The unmap routine should do the invalidation so that, when it returns,
the pages really are unmapped from the device (assuming strict mode).

I know you said that you tried to add invalidation here and it "didn't
work", but that's not something I can really help you with.

Will
