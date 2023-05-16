Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CE19E73
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 06:13:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F6EB67373; Tue, 16 May 2023 08:13:10 +0200 (CEST)
Date: Tue, 16 May 2023 08:13:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Borislav Petkov <bp@suse.de>, Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"petr@tesarici.cz" <petr@tesarici.cz>
Subject: Re: [PATCH v2 RESEND 4/7] swiotlb: Dynamically allocated bounce
 buffers
Message-ID: <20230516061309.GA7219@lst.de>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com> <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com> <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 15, 2023 at 07:43:52PM +0000, Michael Kelley (LINUX) wrote:
> FWIW, I don't think the approach you have implemented here will be
> practical to use for CoCo VMs (SEV, TDX, whatever else).  The problem
> is that dma_direct_alloc_pages() and dma_direct_free_pages() must
> call dma_set_decrypted() and dma_set_encrypted(), respectively.  In CoCo
> VMs, these calls are expensive because they require a hypercall to the host,
> and the operation on the host isn't trivial either.  I haven't measured the
> overhead, but doing a hypercall on every DMA map operation and on
> every unmap operation has long been something we thought we must
> avoid.  The fixed swiotlb bounce buffer space solves this problem by
> doing set_decrypted() in batch at boot time, and never
> doing set_encrypted().

I also suspect it doesn't really scale too well due to the number of
allocations.  I suspect a better way to implement things would be to
add more large chunks that are used just like the main swiotlb buffers.

That is when we run out of space try to allocate another chunk of the
same size in the background, similar to what we do with the pool in
dma-pool.c.  This means we'll do a fairly large allocation, so we'll
need compaction or even CMA to back it up, but the other big upside
is that it also reduces the number of buffers that need to be checked
in is_swiotlb_buffer or the free / sync side.
