Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7B23A8
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:21:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 220B568AA6; Mon, 11 Jul 2022 12:21:35 +0200 (CEST)
Date: Mon, 11 Jul 2022 12:21:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ben Dooks <ben.dooks@sifive.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>,
	Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Jude Onyenegecha <jude.onyenegecha@sifive.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711102134.GB4639@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
> If none of your peripherals should need SWIOTLB, then the fact that
> you're ending up in swiotlb_map() at all is a clear sign that
> something's wrong. Most likely someone's forgotten to set their DMA
> masks correctly.

Yes.

>
> However, by inspection it seems we do have a bug here as well, for which
> the correct fix should be as below. The fireworks you're *supposed* to
> get in that situation are considerably louder and more obvious than a
> DEBUG_SPINLOCK complaint ;)

This looks sensible, I'll pick it up.
