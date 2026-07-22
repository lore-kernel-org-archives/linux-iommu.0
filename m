Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28243C051
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756494; cv=none; b=eKBh8a6DTDLTinb9yj1Le/U95g5zC2wdN6WWerhbGN0O3ZlgHqYvdOSFlQETBJPvrOOoHh9LLSeBAN82VS2fmd49vSrDZBaqHBS1FJhZnWudIT3NEX9b3TQQfNdQXvI/9TglHRaoqAkVBENTR31nnUAE2304ANrz8TYlymGtyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756494; c=relaxed/simple;
	bh=mS82Sqrmfy31wBFBmhkYtVARVlZixEJzT0A8V6kXh3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOwxynJsDMts6B/CSnH/HXrr5RScM3om4KOIpcrIkjsvW7dI5Ao1sJaLGswKsM7e6g090D86ILU26AL8IHCvDqWlNl1WGqfHz661jMRVvsWdleJVGulQu8Kb9bgJl9Vd1gxlurWuOSJ/3qNcCamIW48Lx6QWFsv6UHDNjn5mW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efhNUBJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efhNUBJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1369B1F000E9;
	Wed, 22 Jul 2026 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756493;
	bh=dMBR3RblX1R9eqpdwhEwEKJ+UC89Iidu44yGOa3ijEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efhNUBJKqg8rwflf5T8G6cE6MOrBLBJcxNvb80Pp0cHZwRTmst2/zYXEAu5RvOGNB
	 LojGPzScFflxCyqUqMyBwG0pxWUcQzyqXnlIg4nQ/iG8kZw5G/3QT1SGXKRfQgpWGP
	 CUWhsAYgzZSdH6khCSdsavDebEvxDbC9lCID34MTvuSlbpLUh+8mrWotiBgPMdOLfn
	 k4hEyfTvzx3AbUfgTpvLZkQoNzhluq7N90E4qoNTSfSlsWLrUrTXVnzPr4C5VASuOB
	 vqpQKmzeMdj89XjB3LwSP238CtFU9I2hZQ26ljQKciuUsscYll30PstHXWoZaU76cg
	 BbyNz+ClSl87Q==
Date: Wed, 22 Jul 2026 22:41:29 +0100
From: Will Deacon <will@kernel.org>
To: weimin xiong <15927021679@163.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH] iommu/dma: fix grammar in comments
Message-ID: <amE5CSp8bTSjm-ii@willie-the-truck>
References: <20260714024502.188501-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024502.188501-1-15927021679@163.com>

On Tue, Jul 14, 2026 at 10:45:02AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Clarify two slightly mangled DMA-IOMMU mapping comments.
> 
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec070..2c28b951f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1489,7 +1489,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  		 *   based purely on segment lengths without needing to know
>  		 *   the actual addresses beforehand.
>  		 * - The mask must be a power of 2, so pad_len == 0 if
> -		 *   iova_len == 0, thus we cannot dereference prev the first
> +		 *   iova_len == 0, thus we cannot dereference prev, the first

I don't think adding the extra comma makes much sense here:        ^.

I'll hoover up your other typo fixes onto their own 'typo' branch and
leave it up to Joerg as to whether he decides to apply/squash/ignore
them.

Will
