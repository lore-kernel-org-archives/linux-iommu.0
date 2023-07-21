Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265820F2
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 07:41:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7289067373; Fri, 21 Jul 2023 09:41:15 +0200 (CEST)
Date: Fri, 21 Jul 2023 09:41:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, Yajun Deng <yajun.deng@linux.dev>,
	corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
	akpm@linux-foundation.org, paulmck@kernel.org,
	catalin.marinas@arm.com, rdunlap@infradead.org,
	peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-ID: <20230721074115.GA22796@lst.de>
References: <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev> <25942dafbc7f52488a30c807b6322109539442cf@linux.dev> <20230720115408.GA13114@lst.de> <20230720142712.295834d0@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720142712.295834d0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 20, 2023 at 02:27:12PM +0200, Petr Tesařík wrote:
> V Thu, 20 Jul 2023 13:54:08 +0200
> Christoph Hellwig <hch@lst.de> napsáno:
> 
> > On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> > > It's based on linux-next tree.
> > > 
> > > This patch should be after my other patch in linux-next tree.
> > > a960925a6b23("dma-contiguous: support per-numa CMA for all architectures").  
> > 
> > Where did this land?
> 
> Well... in the linux-next tree:
> 
> https://www.kernel.org/doc/man-pages/linux-next.html

Well, linux-next just pulls in maintainer trees.  So nothing lands
directly in linux-next.  But it looks like Andrew already cleared up
the confusion.
