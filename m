Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024A7E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=YGqqWOkIlp4wL4QvSg1QvGSDJs
	7BsBuJd2vZloqmqZVYag6GUx8MgGcG6k7N6Pa6WmrLW2v0P3Feauq1+vLQ+SwrwlRqvINZJTOwBl0
	wxhU0qzT+TzCCWV4LS0+r0cG+EYsK+DYZQ3sjYAUWpcdmCUSBkcq7yVYgDJB9tmNVHEcj/tNk/8qu
	Zas15dUPp2A0MEg+269FxCrDmahwz7NCf5U+096527uMjhfymAT6htBZOWtUlPACwRzC2Uh3xjDRb
	38qUztzbGAsOSLShnevqSC1PVtIy2CBEGw05PdksfYfFhjkIJA01cvmGQEPnCpudRLstViBDIDa9+
	BE6aP28g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVqbG-004OIZ-BZ; Wed, 07 Sep 2022 08:39:58 +0000
Date: Wed, 7 Sep 2022 01:39:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dongli Zhang <dongli.zhang@oracle.com>, iommu@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
Message-ID: <YxhY3nOLlRsDi6dj@infradead.org>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831063818.3902572-1-yuzhao@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, applied.
