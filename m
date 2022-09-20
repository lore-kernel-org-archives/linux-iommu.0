Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617EB10F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+eWorUZAxr8u3bQU9GUz/2yUzwX+s8AluEa/DYe4Ik=; b=clPtkG7HsDwJbJaQXgjEj/NS+q
	KRDz5dIT4sdb9FAgOYRndkHLWEaH4jnR8snnrKl+6A9rrcHvHqz8AtVzc3Kw2vyiNOybiR2xGRdmB
	MAYtwtUrpp45aBkSmKn1NA0T9tpX7majM0HsleG82g/F/i3/mJbwVwoQvN3tRlFwcXguL42DB8uHx
	hsD9en1ohVdWe+r5byki2CV2Ef/TO1RZ/VruN4NCdlu4Iy7d3dYJ2Njoi7Al3AL0IgA41oNiASYC5
	MQDwO2cjdNiELJQpmx/oApyfbpo0Kky0ipPMA7zTNKse7WW52HF87ZDWT57+X9J0N9kMVMZvF+p4Q
	kHyXREMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaWzd-0016qR-Dp; Tue, 20 Sep 2022 06:44:29 +0000
Date: Mon, 19 Sep 2022 23:44:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	dongli.zhang@oracle.com, yuzhao@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Don't panic!
Message-ID: <YylhTadGmSq1Gci4@infradead.org>
References: <fe2bb33caac173c2b17c819503acef739f763ad1.1662557586.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2bb33caac173c2b17c819503acef739f763ad1.1662557586.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks,

applied to the dma-mapping tree for 6.1.
