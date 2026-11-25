Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627272;
	b=fm3PFdvGNllR9AuhUE8Xrd3vSv8FZd5r9AJO3TGfI/RD63rzunu1EB6MKzrqbYZNh3lQ
	 HHvEsyLgaq0gnT8EUH2QEB1fd4TdBMzu1C10SQsroABIkQn/l16sV5pG1NkKfbOmW0MbG
	 Mm250Q3UMOKYEwyB/jtKvbVoiDPjKgp2+4JF6iPdLwOmPBL4+3uJDWfkoP7a7+vXjMzOU
	 nusYqHEz+BCF5Ts1E9ph5hcvtThtZHkkAOfnA+n7y1ylubNmeshLKKWV+1HFmXxAam2IS
	 Vr+14ZVNBbzvEbPQ0YvOGM0JgQHOpzVq9q/+VE+Q/axyrLSJtM+u9m0bpDLuFwHMkWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627272;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=7b7m/DkpgEDQ+oJfz1rrmLJybl8GZzhKw2nRd5M9D9I=;
	b=RGF/+wIU7kjLUL5CspDRnLrbAvT0OaJfQKONluqmv/VhYilPJ+ms9QOFLzGHJ+zo7eu3
	 B9vH5UveHL9qPA1w3mPSE321zhVGQ/wwRK993l7supFXnZzi+ejD2GewwdEAlph2/DqWR
	 zLOuRVz3Dq8kNJX8imZb3/Dpcnw+iH/l9dq8tcl1FfeFGFgtN+B8JYr+vTNpprybpYK8E
	 IxwuTXfTSaPz74niqzu1/JO7Sc2IvtoKrAmDIP4AMuWNlQvpQ9T6sxMjBEUYI7gtoHwgX
	 z96a4vIPrm3bpQvEwFp5/w3B//uxzvYH9i1xQuH5i9SMhp2yQJc9T/crFhZkj+fBXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OEi1ZWWc;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A7606A32E
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 17:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288A7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OEi1ZWWc
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261125172109euoutp02f80dd1f4ad99dacbf10d8f74c3210720~rWXzbO1zp3239132391euoutp02g
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 17:21:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261125172109euoutp02f80dd1f4ad99dacbf10d8f74c3210720~rWXzbO1zp3239132391euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795627269;
	bh=7b7m/DkpgEDQ+oJfz1rrmLJybl8GZzhKw2nRd5M9D9I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OEi1ZWWcaRDpTvP7CQulCBO/V49BJJgF86ryhAJXC5TgpZw4nuounp1poXWbcq9gM
	 RaBAjfHKNacLXwS77OQipOMC8F/QJSM8DUNTWI0l0tXv3OEOR9J4XC8uYtAEdCb6OM
	 69YhLX8W6BEeRRwkbZKlthpnlLDrPbsFipJRiToE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261125172108eucas1p124b2bc0d3a1d4e2073e0f604d173d1df~rWXzGb1fk2718127181eucas1p1h;
	Wed, 25 Nov 2026 17:21:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261125172107eusmtip29e62e06ad679156e3763d3a649334c3f~rWXxmyPNQ0516905169eusmtip2u;
	Wed, 25 Nov 2026 17:21:07 +0000 (GMT)
Message-ID: <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
Date: Wed, 25 Nov 2026 18:21:06 +0100
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
Subject: Re: [PATCH] Revert
 "iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper"
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, honghuan@amd.com, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261125172108eucas1p124b2bc0d3a1d4e2073e0f604d173d1df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261125135138eucas1p141ba6b5e09623562e2033e290fba811c
X-EPHeader: CA
X-CMS-RootMailID: 20261125135138eucas1p141ba6b5e09623562e2033e290fba811c
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
	<20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>

On 25.11.2026 14:51, Sibi Sankar wrote:
> This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
>
> Before this commit, dma_iova_destroy() unmapped through
> __iommu_dma_iova_unlink(..., free_iova=true), which set
> iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
> and freed the IOVA with the queued gather, exactly like
> __iommu_dma_unmap(). After it, dma_iova_destroy() calls
> dma_iova_unlink() and then dma_iova_free():
>
>   - dma_iova_unlink() never marks its gather as queued and always calls
>     iommu_iotlb_sync() after iommu_unmap_fast().
>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>     the IOVA goes straight back to the allocator through
>     free_iova_fast() and never through queue_iova().
>
> DMA-FQ domains therefore get strict invalidation on this path. That
> includes the block layer's blk_rq_dma_map() path, which NVMe uses for
> all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
>
> hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
> 	       4K pages; NVMe SSD on PCIe Gen5 x4
>
> Fio sequential read/write numbers:
>   Domain                          seq write    seq read
>   DMA (strict)                    2694 MiB/s   2693 MiB/s
>   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
>     bypassed (this regression)
>   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
>     used by dma_iova_destroy()
>
> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>


The performance data clearly shows that the flush queue was there for
the reason. Together with this revert it would probably make sense to
apply the v1 of the reverted patch:

https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/

Leon, do You see any other option?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

