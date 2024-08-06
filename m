Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116E3C092
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947931; cv=none; b=k1N6WxNGKwlezC0WujannYhLoEjIyQzAm907jzBDH2lY1xQT8NVhmncHOEsTrLQxVb2KxuU+oLK6s3Ov9wYqRLzfMqgD3w7jqplGCl17PZ8crtbNEvfNKXakP2qwweh1duj/gdj5KMcWCigVB0TAl9GgS0fJQy332i/E4ESTX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947931; c=relaxed/simple;
	bh=F89bbNBt02CIsoqTwElidN/E6oHTR4Q6GDCYm9oC+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq+OlwhM4URy6TPzz6L9MvUP0aWYqYOnNCjqwp9Jyok4UmVTa+xT1GNi2oQFTc5mFB3/wnTwsPao9ZWAZ55E7J/eHL0WCrqoSFJRoHGUaiSS8vxfTktCkBCEw2cTwqV7Ymlb4pOuKbS9aBPPsTweMOWZvHgf/c++50xdLPfD494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C48EA68CFE; Tue,  6 Aug 2024 14:38:38 +0200 (CEST)
Date: Tue, 6 Aug 2024 14:38:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rik van Riel <riel@surriel.com>
Cc: Christoph Hellwig <hch@lst.de>, Breno Leitao <leitao@debian.org>,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma,debug: avoid deadlock between dma debug vs printk
 and netcons
Message-ID: <20240806123838.GA9975@lst.de>
References: <20240805140844.6a863c76@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805140844.6a863c76@imladris.surriel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 05, 2024 at 02:08:44PM -0400, Rik van Riel wrote:
> index a6e3792b15f8..dc96e414be38 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -417,7 +417,7 @@ static unsigned long long phys_addr(struct dma_debug_entry *entry)
>   * other hand, consumes a single dma_debug_entry, but inserts 'nents'
>   * entries into the tree.
>   */
> -static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
> +static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);

This looks reasonable, but please add a comment here to explain why
this is using __GFP_NOWARN so that future readers don't have to wonder
about it and look into git history.

