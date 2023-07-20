Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19536443A
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 08:22:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B09B6732D; Thu, 20 Jul 2023 10:22:42 +0200 (CEST)
Date: Thu, 20 Jul 2023 10:22:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, James Seo <james@equiv.tech>,
	James Clark <james.clark@arm.com>,
	Kees Cook <keescook@chromium.org>,
	"moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
	"moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 8/8] swiotlb: search the software IO TLB only if a
 device makes use of it
Message-ID: <20230720082242.GA6932@lst.de>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com> <a8d31d3fffa0867dce2b44b98dc2714289edfdc9.1689261692.git.petr.tesarik.ext@huawei.com> <20230720064744.GA4395@lst.de> <20230720100238.58f11c06@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720100238.58f11c06@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 20, 2023 at 10:02:38AM +0200, Petr Tesařík wrote:
> On Thu, 20 Jul 2023 08:47:44 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Any reason this can't just do a list_empty_careful on the list
> > instead of adding yet another field that grows struct device?
> 
> On which list?

dev->dma_io_tlb_mem->pools?

> 
> The dma_io_tlb_pools list only contains transient pools, but a device
> may use bounce buffers from a regular pool.

Oh, true.

> The dma_io_tlb_mem.pools list will always be non-empty, unless the
> system runs without SWIOTLB.
> 
> On a system which does have a SWIOTLB, the flag allows to differentiate
> between devices that actually use bounce buffers and devices that do
> not (e.g. because they do not have any addressing limitations).

Ok.
