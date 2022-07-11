Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CC1879
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:39:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B6E468AA6; Mon, 11 Jul 2022 12:39:21 +0200 (CEST)
Date: Mon, 11 Jul 2022 12:39:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ben Dooks <ben.dooks@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Jude Onyenegecha <jude.onyenegecha@sifive.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711103921.GA6542@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de> <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 11, 2022 at 11:24:51AM +0100, Ben Dooks wrote:
> On 11/07/2022 11:21, Christoph Hellwig wrote:
>> On Mon, Jul 11, 2022 at 11:07:17AM +0100, Robin Murphy wrote:
>>> If none of your peripherals should need SWIOTLB, then the fact that
>>> you're ending up in swiotlb_map() at all is a clear sign that
>>> something's wrong. Most likely someone's forgotten to set their DMA
>>> masks correctly.
>>
>> Yes.
>
> Possibly, we had at least one driver which attempted to set a 32 bit
> DMA mask which had to be removed as the DMA layer accepts this but
> since there is no DMA32 memory the allocator then just fails.
>
> I expect the above may need to be a separate discussion(s) of how to
> default the DMA mask and how to stop the implicit acceptance of setting
> a 32-bit DMA mask.

No.  Linux simply assumes you can do 32-bit DMA and this won't
change.  So we'll need to fix your platform to support swiotlb
eventually.
