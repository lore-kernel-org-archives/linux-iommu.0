Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21051FCFD9;
	Tue, 25 Feb 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493921; cv=none; b=joWajE2Za/ZBbUzmxlhQl0a9qHYD4PrLO2Fr1is4xRZBDqRBrAflV53e50xnkvosRg692FU7SaHvfWtszQ8a9wNeNBhMMveRr87Cq5g1TR2ebChlhbRVBPZzfPG7atj2Z5ly6D+LXX4Rz0E/59TSdzsheBPEWTYIhvmcrxqwnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493921; c=relaxed/simple;
	bh=+xRF9Tk3XNeOHq+GTk8RWa8l8wzWPABhjbAB/Kg4TfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezuy3cVm1oB76Q9mYUQIYRqEelGd8WQ27df2ib8rzRAEWpjEORMufASv3524XpniXLBpuQ8D6dxqA7dtkit5e8ctRgE4PL7qn0eDxlPjmcbmayTtnI4Ayo7RxAfXyi7IFVUYc7YuJcNnVqBs5cq1EG4/nX+IwCOyiMyLcM+h2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRyh6RS5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRyh6RS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832D2C4CEDD;
	Tue, 25 Feb 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740493921;
	bh=+xRF9Tk3XNeOHq+GTk8RWa8l8wzWPABhjbAB/Kg4TfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRyh6RS5qByJiJPKiX0zP+SMcqbGPXIjtJmcph1ahsM967orLfmLFAh3tGN3bOPBz
	 hwKGTNb66NYJ+Om1Okw6Z9oipuZXMtipMSVUhFq5ka57gK6rxlNzk3WL9vvxPOfOrA
	 Vaz7TcyEUxkMN+ItHCVMOtE1E6ZaJukGu4kLKkX/reEhm5MBkO5x7+r1LhtGOpb0aC
	 TimGEkRF3cuxgnm9ob4gifcI9qOmZ/Krt1ZLLXHAPPrMDunQDxZ+vstmXKIT4rIg6r
	 c2Vb8RuAJNvl7FtSZz4PpkeMfJsDYNzBPK3EGWBCqFsVGvIJFOg3ZHqcO3kzevL6Un
	 SWb85NvrDvKsA==
Date: Tue, 25 Feb 2025 16:31:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@linux-foundation.org, m.szyprowski@samsung.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: update MAINTAINERS
Message-ID: <20250225143155.GA3167815@unreal>
References: <20250224162724.349679-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224162724.349679-1-hch@lst.de>

On Mon, Feb 24, 2025 at 08:27:21AM -0800, Christoph Hellwig wrote:

<...>

>  DMA MAPPING HELPERS
> -M:	Christoph Hellwig <hch@lst.de>

It is sad change to see.

Thanks
