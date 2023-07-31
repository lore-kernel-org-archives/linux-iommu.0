Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8519BB0
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 16:03:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8915268AA6; Mon, 31 Jul 2023 18:02:59 +0200 (CEST)
Date: Mon, 31 Jul 2023 18:02:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Binglei Wang <l3b2w1@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cma: check for memory region overlapping
Message-ID: <20230731160259.GB8931@lst.de>
References: <20230726142823.6356-1-l3b2w1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726142823.6356-1-l3b2w1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for 6.6.

