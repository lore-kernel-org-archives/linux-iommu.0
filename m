Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4610F9
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 06:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i+eWorUZAxr8u3bQU9GUz/2yUzwX+s8AluEa/DYe4Ik=; b=onhqi6ncl1moTM1CUXT0wZ5PjD
	wSgl3qTpu405LvBOmx9IzvMXyg4M5xeubJLn68IvpmJ/4wYtcwYFybiLJgqjO1mE2Cg/gw7QgKdaZ
	jsRXiOhin7EODAf5NvbDcX+D36wbh/hfQ0cuxNNmWyQ6vXAVMv1HC+Cu95n6t1D3cxOrLdkBFor6T
	feheVzfpBpvnh+2abjxw8yFVsNdx1xC7CgxVuczISVVPvpvFzdwBxr1klR2ohBwR+6uRLEG0stzCd
	/09cMSKJE2mreejUe5wTjEyly4joG8UN0GxHwM863yaBxL1liAU6RLUdzqCmJGW30wQRcHl7yPVdc
	1I9vZXTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaWzV-0016my-5F; Tue, 20 Sep 2022 06:44:21 +0000
Date: Mon, 19 Sep 2022 23:44:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] swiotlb: Replace kmap_atomic() with
 memcpy_{from,to}_page()
Message-ID: <YylhRQUEsB4E8gH6@infradead.org>
References: <20220901132906.14063-1-fmdefrancesco@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901132906.14063-1-fmdefrancesco@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks,

applied to the dma-mapping tree for 6.1.
