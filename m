Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71C7C
	for <iommu@lists.linux.dev>; Mon, 24 Apr 2023 06:03:23 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5E5D67373; Mon, 24 Apr 2023 08:03:13 +0200 (CEST)
Date: Mon, 24 Apr 2023 08:03:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230424060313.GB9805@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com> <20230328040724.GB25506@lst.de> <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com> <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com> <20230407055704.GD6803@lst.de> <20230407121555.4290a011@meshulam.tesarici.cz> <20230421150349.35966e0b@meshulam.tesarici.cz> <4bd8ce51-5874-0aa3-bc82-fec0cee9b8f1@arm.com> <20230421170934.185a03a0@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421170934.185a03a0@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 21, 2023 at 05:09:34PM +0200, Petr Tesařík wrote:
> > > A. Only grouping those fields in their own struct?
> > > B. Or move the definition to another include file (cf. MAINTAINERS)?
> > > C. Or store a pointer in struct device?  
> > 
> > dev->dma_parms is already this, and IIRC still has some very old 
> > comments somewhere about consolidating the other DMA-related fields in 
> > there.
> 
> Thank you for the hint! I have actually seen dma_parms, but since it
> can be NULL and was initialized from various drivers, it did not occur
> to me that NULL simply means not DMA-capable.

Yes, dma_parms are still optional.  A much better hint is the dma_mask
itself, which for historic reasons is implemented in a completely
awfull way as a pointer to something stored in the containing struture,
which all kinds of platform devices or minor buses doing nasty hacks
there.
