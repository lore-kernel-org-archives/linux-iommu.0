Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254E7B
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 06:00:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9BE168C4E; Fri,  7 Apr 2023 08:00:49 +0200 (CEST)
Date: Fri, 7 Apr 2023 08:00:47 +0200
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
Subject: Re: [RFC v1 0/4] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230407060047.GE6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <630334b5-05d0-0152-7c2c-79174703f0ed@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630334b5-05d0-0152-7c2c-79174703f0ed@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 27, 2023 at 01:06:34PM +0200, Petr Tesarik wrote:
> B. Allocate a very big SWIOTLB, but allow to use it for normal
> allocations (similar to the CMA approach). The advantage is that there
> is only one table, pushing performance impact down to almost zero. The
> main challenge is migrating pages to/from the SWIOTLB. Existing CMA code
> cannot be reused, because CMA cannot be used from atomic contexts,
> unlike SWIOTLB.

That actually sounds very interesting, although I'd go futher and
figure out if we:

 a) could get away to only allow the CMA allocation for sleeping contexts,
    if we have enough sleeping context to matter
 b) check with the CMA maintainers if it is feasible and acceptable
    to them to extent CMA for irq allocations.

That being said, I think cases like dma-buf sharing really need to
be addressed at a higher level instead of basically double allocating
these long-term memory allocations.

I'd also really love to hear some feedback from the various confidential
computing implementors, as that seems to be ther big driving force for
swiotlb currently.
