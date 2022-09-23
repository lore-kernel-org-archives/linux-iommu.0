Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3D3D90
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 14:48:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C083267373; Fri, 23 Sep 2022 16:48:04 +0200 (CEST)
Date: Fri, 23 Sep 2022 16:48:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nate Drude <nate.d@variscite.com>, iommu@lists.linux.dev,
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Muchun Song <songmuchun@bytedance.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, eran.m@variscite.com
Subject: Re: [PATCH] dma-contiguous: add optional cma_name for cma= kernel
 parameter
Message-ID: <20220923144804.GA18477@lst.de>
References: <20220912163805.4113238-1-nate.d@variscite.com> <aa96eb55-4925-221f-1fb2-8226ea347c22@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa96eb55-4925-221f-1fb2-8226ea347c22@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 13, 2022 at 11:45:17AM +0100, Robin Murphy wrote:
> If userspace expects the CMA heap driver to expose a consistent name for 
> CMA heaps, shouldn't it be the CMA heap driver's responsibility to expose a 
> consistent name for CMA heaps? Tinkering with the core CMA code doesn't 
> feel like the right approach.

Agreed.  In fact I think exposing this name in a uapi seems like a really
bad idea that is asking for a lot of trouble.
