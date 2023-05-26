Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633320E6
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 06:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=411KGqD8IaDnPUkvIUc2KqzrLmyQ9q/ej5S6eECWqFI=; b=PcQqrs88WilvjLOuH6grbpPton
	+ghxrPI9BmRD/kgaGvA93AbBWtjOoyA8TTFDoe2K46n8/HGew9uWtWtWm7S+dGvql8u3zFmrrh5g4
	lRxvlCL9EmMMPpJgh+9jaKxSnQQfl/SRI+ofh9sJdokrwlo6JbC7EiKEqMkbLhTnp0nEkFfTPuXgt
	UnhVCzNDPc4nFSqdPceaTR2Wz1D1KEC5Tf/Rg7aeILPKcQhQGFVTf4BCzeGL+Ruq0BF+w7JEeVG2h
	w6iR26QSWbEdfbaSIneWhk6tzQVeoizeGhzjckaVDlI0ylj5A6xABLnxaHYerPWgnnZqGLJEb5wiQ
	4gmUBI5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1q2R9m-001IfJ-0y;
	Fri, 26 May 2023 06:42:34 +0000
Date: Thu, 25 May 2023 23:42:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
	logang@deltatee.com
Subject: Re: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
Message-ID: <ZHBU2nDuYtV9mLLJ@infradead.org>
References: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
