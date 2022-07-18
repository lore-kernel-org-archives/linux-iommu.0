Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9EA44
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=HOQX7vYq8SDzOd7E1gdk0oWwnQ
	r2ThWkQ5otK1i9cJw6HVmC7V5VEtI4CzC1MziwEGCj09Zmy+n5qwXZCIoEKg8KC9Nbz663MSLe8O4
	RUi6ApchxmPdLmLLq+m02IPHoTtCRrckHfMircsexKN6lyHm2LJVPbCPXz2m3qSZ8ejz+MEJ52ISg
	tUCnpVTFsGnASsreImdTvmDhO9TjVorzwPVHgPbNU7PrXr8G9AwlFrZzMsd2Tr7T64OL6Mruv7iE5
	gG+k/U5ImJ+n1ikCfdAOlx5v+Q3g9LvHAx6w/rlmjVkXYE0KT32kvwo2AaXFQiOD44txtgFS2T8t3
	ddJhXLYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIiX-00Avjs-PI; Mon, 18 Jul 2022 04:50:49 +0000
Date: Sun, 17 Jul 2022 21:50:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Fix use after free on error handling path
Message-ID: <YtTmqRvo2ZFYz1op@infradead.org>
References: <YtEjJkxyiZouY7d3@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtEjJkxyiZouY7d3@kili>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, applied.
