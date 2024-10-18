Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F620E30D
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229264; cv=none; b=Wh4s3NLQ4icceEZEVwJzW7p76oUxalhSBpfPHICB/Oo1JYH7AY/zaXxGRzdwwJv/WnoTXN5kXS1hyFGwMinv+2Q4Jb8EBIC9prSOaxffiok110GDAajes4LfQ0xUS+Xs9BwfitK8mj/IamiXe+c89RWMn3TUspzTYtv7nPMHP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229264; c=relaxed/simple;
	bh=zuvQWdEGQt2takvATObbj2UEmAahbnLWjYKE3v8ZmAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJuTtyyi2cguVFxyswgdOLLwiNKsi+IghdetCWsRisXHgCPr9xV0OHdFrHlHzl3FNZ9kZu8ETNclGMeGb1Tbkw1kYrr5zgq4mZwMbANHx1H09kxU4UnZt1PpTsQlfOzpQwBBpw+S2Zqu5JlCnGUpSX8dBv4wnZh3LuEJCOvop9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98A6A227A8E; Fri, 18 Oct 2024 07:27:38 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:27:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/3] dma-mapping: Use trace_dma_alloc for dma_alloc*
 instead of using trace_dma_map
Message-ID: <20241018052738.GA20045@lst.de>
References: <20241017181354.2834674-1-sean.anderson@linux.dev> <20241017181354.2834674-3-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181354.2834674-3-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 17, 2024 at 02:13:53PM -0400, Sean Anderson wrote:
> +DECLARE_EVENT_CLASS(_dma_alloc,
>  	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
>  		 size_t size, enum dma_data_direction dir, gfp_t flags,
>  		 unsigned long attrs),
> @@ -149,7 +149,60 @@ TRACE_EVENT(dma_alloc,
>  		decode_dma_attrs(__entry->attrs))
>  );
>  
> -TRACE_EVENT(dma_free,
> +DEFINE_EVENT(_dma_alloc, dma_alloc,
> +	TP_PROTO(struct device *dev, void *virt_addr, dma_addr_t dma_addr,
> +		 size_t size, enum dma_data_direction dir, gfp_t flags,
> +		 unsigned long attrs),
> +	TP_ARGS(dev, virt_addr, dma_addr, size, dir, flags, attrs));
> +
> +DEFINE_EVENT(_dma_alloc, dma_alloc_pages,

The scheme we used in XFS (fs/xfs/xfs_trace.h) for the event classes is
to give the class a _class postdix, and use macros to avoid the repeated
DEFINE_EVENT boilerplate.  Any chance you could rewrite this to use
a similar scheme?

