Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DF7B
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 05:57:07 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63FA868AFE; Fri,  7 Apr 2023 07:57:04 +0200 (CEST)
Date: Fri, 7 Apr 2023 07:57:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
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
	Roberto Sassu <roberto.sassu@huawei.com>, petr@tesarici.cz,
	Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230407055704.GD6803@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com> <20230328040724.GB25506@lst.de> <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com> <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf7c515-9ce6-a2ed-0643-972aa3eba2fb@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 28, 2023 at 02:43:03PM +0200, Petr Tesarik wrote:
> Oh, wait! I can do at least something for devices which do not use
> swiotlb at all.
> 
> If a device does not use bounce buffers, it cannot pass an address
> that belongs to the swiotlb. Consequently, the potentially
> expensive check can be skipped. This avoids the dynamic lookup
> penalty for devices which do not need the swiotlb.
> 
> Note that the counter always remains zero if dma_io_tlb_mem is
> NULL, so the NULL check is not required.

Hmm, that's yet another atomic for each map/unmap, and bloats
struct device.

(Btw, in case anyone is interested, we really need to get started
on moving the dma fields out of struct device into a sub-struct
only allocated for DMA capable busses)

