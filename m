Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039F7E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=jsVmACtilpMLn0n8wyXNeEZzgK
	M3fBNa5WUYTOVbTdrknZEwj6EG3B30M6Um/GvL5GwRsWfhD8af1L/tDk4KizcrDY/TINI+r3Q1Nhm
	bAR4O0mdk3XOWvzoiHx/GkOL+HBZt05oIiomr5CJL2Xb+E7a9ELMhvQTBkOAy3SbZIOtLndeJnwXq
	iSHfnuFOXKKdbyKSmnP2qCYYkaUUqZUfSwkwSPcq7q70+irytwEr48VONZM5NcvZOnsoeBYPlwiNN
	gNvf1W+QYyhyFCXx8K2RAalzwNWvZOVcD4I96gP/+P78MNIwsnPNepuYP0Ap2Jk8grvRS7MC2NVyk
	YOaPvyQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVqb4-004O8F-2U; Wed, 07 Sep 2022 08:39:46 +0000
Date: Wed, 7 Sep 2022 01:39:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [PATCH] swiotlb: fix a typo
Message-ID: <YxhY0uHkQ5Y2QqSB@infradead.org>
References: <20220826095046.880626-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826095046.880626-1-chao.gao@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, applied.
