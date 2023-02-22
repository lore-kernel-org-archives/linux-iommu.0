Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A62F3F
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 14:45:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B5E868AA6; Wed, 22 Feb 2023 15:45:32 +0100 (CET)
Date: Wed, 22 Feb 2023 15:45:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] swiotlb: mark swiotlb_memblock_alloc() as __init
Message-ID: <20230222144531.GA13642@lst.de>
References: <20230222070411.6186-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222070411.6186-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree.
