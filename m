Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D9A21
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 03:57:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA62968AA6; Tue, 28 Mar 2023 05:57:25 +0200 (CEST)
Date: Tue, 28 Mar 2023 05:57:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz
Subject: Re: [RFC v1 1/4] dma-mapping: introduce the DMA_ATTR_MAY_SLEEP
 attribute
Message-ID: <20230328035725.GA25506@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0646e0e63380bb8595fbac81c23aeca30feae9.1679309810.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 20, 2023 at 01:28:13PM +0100, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> Introduce a DMA attribute to tell the DMA-mapping subsystem that
> the operation is allowed to sleep.
> 
> This patch merely adds the flag, which is not used for anything at
> the moment. It should be used by users who can sleep (e.g. dma-buf
> ioctls) to allow page reclaim and/or allocations from CMA.

So what drivers would call this?  As-is it doesn't have any users in
the series.
