Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114690;
	b=CiXO8ke/OL5XKH8OO1spneMM7qWtpkb7kWvCr/eMxhJZiZ0bonoV/25zGynjDAUsW6FM
	 2swh64QhrjgtcZiX3079JAPDwVxduppE+6ERrs87BqMVOfqYXX/RlTDNUUjQVaYafdS+g
	 6pMCSno5zm7U3QUbc5Khl4XacoPe7o4EZ4YATCerZR2jcG2FNVrZr/ZwONbQ6q+LKK+mM
	 MKKEDuK6lEarBkXx7OOVZfNm4CTbMCZyf1R4AMUpbBFLNQ8Dqi1R/tNgPC19asoowOp1Z
	 1H1o3Tw2YLcatrP51WWqoKjs2y2YQKhz9qiAhrrX3mHxqS4n0EZzNUl8pVmZdM4LEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114690;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=QEgh9eh5g6W6GXWQ1QQ3Xt0fKEwFk4G9JAyEdOnqR+M=;
	b=SXWzXjAJEDcLYwD8NUpuJGbhbpHgkuD+1EA+7CFkzrK/U4ymn7PTXAcjymKqVrRvc6qI
	 E7ZGOCLQ5aTGeZAKmeb9dexgF+Ll1nHpLljTvzweAbhgiddJaf+L7F2RsniOva1331j2K
	 oahVETy04cPD+qoXcZWWC9sPmaWGe3MMLr9VFxwaIDbn61sYaZob8NZnXQ4eXemR/BpB2
	 OYncyVl0uYiOC+0nUYMUElUAO6ji2CuVzB3BXjrybNpk1IlNphn7c7POIBsbY0Y2V8s+q
	 xsKqtov97uhAct3L0R/mPLnMvuVqVwa8WmCHzeTgYRqI0TEGTqE3l7YxpjCSfztsCbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rbq1uqyZ;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C6606A324
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E4C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=rbq1uqyZ
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261027152446euoutp02e44b65256b39a1bde49b1f04519f91ec~ibE6tbgdg2425024250euoutp02J
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 15:24:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261027152446euoutp02e44b65256b39a1bde49b1f04519f91ec~ibE6tbgdg2425024250euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793114686;
	bh=QEgh9eh5g6W6GXWQ1QQ3Xt0fKEwFk4G9JAyEdOnqR+M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=rbq1uqyZTdoGXCP7Mo0oUNeIs8LO+BRKIePBoOznJLcp6KC1T2OiviX2JIrR8ygnU
	 Trhgd5SRQSx4O3ejpiCIPINvr66WkWFTtbsSmvfcu6zJRq023NkYS6cuVQ2UgRIswj
	 YtobIFTCQG0+eb5wdZN1F67COhGj7VEBYOVf6wnc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261027152446eucas1p1f6f2fc77458a940b8f16a1cdccc472c7~ibE6W2W502838028380eucas1p1Q;
	Tue, 27 Oct 2026 15:24:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261027152445eusmtip12170894aa2434d3e5d5b03464e715d9a~ibE5bvapZ2424124241eusmtip1x;
	Tue, 27 Oct 2026 15:24:45 +0000 (GMT)
Message-ID: <008d1317-223e-4265-a5a4-4d2a602a2661@samsung.com>
Date: Tue, 27 Oct 2026 16:24:44 +0100
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
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-5-kuba@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261027152446eucas1p1f6f2fc77458a940b8f16a1cdccc472c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
X-EPHeader: CA
X-CMS-RootMailID: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p2ac05630160507ff3a887186416e98c30@eucas1p2.samsung.com>
	<20261027022528.633359-5-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> @@ -683,6 +699,14 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
>  	return cpu_addr;
>  }
> +EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
> +
> +void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t flag, unsigned long attrs)
> +{
> +	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
> +				    dev_to_node(dev));
> +}
>  EXPORT_SYMBOL(dma_alloc_attrs);

Do we really need two exported symbols for dma_alloc_attrs()? I would prefer
to make dma_alloc_attrs() a static inline calling dma_alloc_attrs_node().

Did I missed something obvious against that?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

