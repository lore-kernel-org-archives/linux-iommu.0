Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025838F951
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928027; cv=none; b=r+K3thhLWrOYqi7p5z7PouEenBTfPXT5Mc0u7h0vSmvh+Cde8IRqHGytpaFuwA0jwJrTlyFekci//kDjtol3ZsrtDLJzykpLgKZ4nB9/1rRws69S4Y/Y8+i1Zzh7ZQges+fOWm+crx5d/F3KxqoD9HCRzmdCPWrxSTbHH7pNdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928027; c=relaxed/simple;
	bh=SRtVRbjWYNNRDyRiYZpH0W/rD+O17i2Yez6W9J7PHOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JJcTc15qBKbzii3aYQJwhBZs+QBCGirubEP+ep88fz3gFu9yY6K69DgIL4sZy+rNGmd0X83v9b8CunMZbkuTQzusnC13hS168L0/N+ToGpfIwefrtEeSb9PAJjUwYuxJ1gp46ll13POjqf117MmPy7AeNOSwGJUh2+Ik8ndQnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ElyawKgF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ElyawKgF"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260713073343euoutp0277ffc42cbeb060129a8a4f2d613b143e~ByRXsv4q52405024050euoutp023
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260713073343euoutp0277ffc42cbeb060129a8a4f2d613b143e~ByRXsv4q52405024050euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783928023;
	bh=NLUW5dhApt4DncasEExekOkd+r4XUBra32jveDecPOo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ElyawKgFX4CTHiAxRO7yL8hA9weqJ5k89zO6IvER8U1HRZ/16UaFwVMkIbx+76hwQ
	 hUVK4SqDrOb448hp150YRSSVhwqybNJq3SiBr1GSbhmwZfIIBO4C4MhgWpFdUjDnzi
	 Epxa5pvuEvXOjqN+TTnAbYawmqyqfwji1aANAvIk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260713073343eucas1p2167006eee7c5c0481ce9b04877f5e984~ByRXbabLP1939719397eucas1p2p;
	Mon, 13 Jul 2026 07:33:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260713073342eusmtip1fa3fec8c52e72a0fdecbbed7fe68c0db~ByRW9c-kd2213022130eusmtip1W;
	Mon, 13 Jul 2026 07:33:42 +0000 (GMT)
Message-ID: <76732ad3-6533-48e2-87b7-e9cf36135c93@samsung.com>
Date: Mon, 13 Jul 2026 09:33:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] kernel: dma: coherent: fix spacing coding style issue
To: Vova Sharaienko <sharaienko@google.com>, Robin Murphy
	<robin.murphy@arm.com>
Cc: kernel-team@android.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260623000821.2269955-1-sharaienko@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260713073343eucas1p2167006eee7c5c0481ce9b04877f5e984
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260623000828eucas1p1bb57979dfbe5b3b03ce605db4db05f4c
X-EPHeader: CA
X-CMS-RootMailID: 20260623000828eucas1p1bb57979dfbe5b3b03ce605db4db05f4c
References: <CGME20260623000828eucas1p1bb57979dfbe5b3b03ce605db4db05f4c@eucas1p1.samsung.com>
	<20260623000821.2269955-1-sharaienko@google.com>

On 23.06.2026 02:08, Vova Sharaienko wrote:
> Fixed spacing around * coding style issue
>
> Signed-off-by: Vova Sharaienko <sharaienko@google.com>


Applied to dma-mapping-for-next with slightly changed subject prefix. Thanks!


> ---
>  kernel/dma/coherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index bcdc0f76d2e8..480dd1766ece 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -28,7 +28,7 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
>  }
>  
>  static inline dma_addr_t dma_get_device_base(struct device *dev,
> -					     struct dma_coherent_mem * mem)
> +					     struct dma_coherent_mem *mem)
>  {
>  	if (mem->use_dev_dma_pfn_offset)
>  		return phys_to_dma(dev, PFN_PHYS(mem->pfn_base));

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

