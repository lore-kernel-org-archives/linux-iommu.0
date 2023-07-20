Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99417FF7
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 11:54:15 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 554AB6732D; Thu, 20 Jul 2023 13:54:09 +0200 (CEST)
Date: Thu, 20 Jul 2023 13:54:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, corbet@lwn.net,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	akpm@linux-foundation.org, paulmck@kernel.org,
	catalin.marinas@arm.com, rdunlap@infradead.org,
	peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230720115408.GA13114@lst.de>
References: <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev> <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> It's based on linux-next tree.
> 
> This patch should be after my other patch in linux-next tree.
> a960925a6b23("dma-contiguous: support per-numa CMA for all architectures").

Where did this land?  dma patches really should be going through
the DMA tree..
