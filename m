Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246910FA
	for <iommu@lists.linux.dev>; Sun, 16 Apr 2023 06:26:36 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A294D68AA6; Sun, 16 Apr 2023 08:26:33 +0200 (CEST)
Date: Sun, 16 Apr 2023 08:26:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	decui@microsoft.com, tiala@microsoft.com,
	petr.tesarik.ext@huawei.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] swiotlb: Track and report io_tlb_used high
 water marks in debugfs
Message-ID: <20230416062633.GB6195@lst.de>
References: <1681408657-2172-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681408657-2172-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-next tree.
