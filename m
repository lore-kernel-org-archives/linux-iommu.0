Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C27F;
	Tue, 18 Oct 2022 14:33:26 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A17A968C7B; Tue, 18 Oct 2022 16:33:20 +0200 (CEST)
Date: Tue, 18 Oct 2022 16:33:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Beulich <jbeulich@suse.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
	iommu@lists.linux.dev, Robert Beckett <bob.beckett@collabora.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: i915 "GPU HANG", bisected to a2daa27c0c61 "swiotlb: simplify
 swiotlb_max_segment"
Message-ID: <20221018143320.GA19106@lst.de>
References: <20221018082413.GA25785@lst.de> <a5966644-72d7-4b25-83d1-9765d0593e44@suse.com> <20221018110243.GA4655@lst.de> <d67ceabb-b31a-59e6-fc77-8d6c48b277f2@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67ceabb-b31a-59e6-fc77-8d6c48b277f2@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 18, 2022 at 04:21:43PM +0200, Jan Beulich wrote:
> Leaving the "i915 abuses" part aside (because I can't tell what exactly the
> abuse is), but assuming that "can't cope with bounce buffering" means they
> don't actually use the allocated buffers, I'd suggest this:

Except for one odd place i915 never uses dma_alloc_* but always allocates
memory itself and then maps it, but then treats it as if it was a
dma_alloc_coherent allocations, that is never does ownership changes.

> I've dropped the TDX related remark because I don't think it's meaningful
> for PV guests.

This remark is for TDX in general, not Xen related.  With TDX and other
confidentatial computing schemes, all DMA must be bounce buffered, and
all drivers skipping dma_sync* calls are broken.

> Otoh I've left the "abuses ignores" word sequence as is, no
> matter that it reads odd to me. Plus, as hinted at before, I'm not
> convinced the IS_ENABLED() use is actually necessary or warranted here.

If we don't need the IS_ENABLED is not needed I'm all for dropping it.
But unless I misread the code, on arm/arm64 even PV guests are 1:1
mapped so that all Linux physically contigous memory also is Xen
contigous, so we don't need the hack.
