Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B8113FE0
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:37:50 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AB1267373; Thu, 20 Jul 2023 08:37:44 +0200 (CEST)
Date: Thu, 20 Jul 2023 08:37:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
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
	Christoph Hellwig <hch@lst.de>,
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
	Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: Re: [PATCH v4 1/8] swiotlb: make io_tlb_default_mem local to
 swiotlb.c
Message-ID: <20230720063744.GA3842@lst.de>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com> <7f64111986f4f361a2deb4a1a1b6f588e63a851b.1689261692.git.petr.tesarik.ext@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f64111986f4f361a2deb4a1a1b6f588e63a851b.1689261692.git.petr.tesarik.ext@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 13, 2023 at 05:23:12PM +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> SWIOTLB implementation details should not be exposed to the rest of the
> kernel. This will allow to make changes to the implementation without
> modifying non-swiotlb code.
> 
> To avoid breaking existing users, provide helper functions for the few
> required fields.
> 
> As a bonus, using a helper function to initialize struct device allows to
> get rid of an #ifdef in driver core.
> 
> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> ---
>  arch/arm/xen/mm.c          |  2 +-
>  arch/mips/pci/pci-octeon.c |  2 +-
>  arch/x86/kernel/pci-dma.c  |  2 +-
>  drivers/base/core.c        |  4 +---
>  drivers/xen/swiotlb-xen.c  |  2 +-
>  include/linux/swiotlb.h    | 25 +++++++++++++++++++++++-
>  kernel/dma/swiotlb.c       | 39 +++++++++++++++++++++++++++++++++++++-
>  7 files changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 3d826c0b5fee..0f32c14eb786 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
>  		return 0;
>  
>  	/* we can work with the default swiotlb */
> -	if (!io_tlb_default_mem.nslabs) {
> +	if (!is_swiotlb_allocated()) {
>  		rc = swiotlb_init_late(swiotlb_size_or_default(),
>  				       xen_swiotlb_gfp(), NULL);
>  		if (rc < 0)

I'd much rather move the already initialized check into
swiotlb_init_late, which is a much cleaer interface.

>  	/* we can work with the default swiotlb */
> -	if (!io_tlb_default_mem.nslabs) {
> +	if (!is_swiotlb_allocated()) {
>  		int rc = swiotlb_init_late(swiotlb_size_or_default(),
>  					   GFP_KERNEL, xen_swiotlb_fixup);
>  		if (rc < 0)

.. and would take care of this one as well.

> +bool is_swiotlb_allocated(void)
> +{
> +	return !!io_tlb_default_mem.nslabs;

Nit: no need for the !!, we can rely on the implicit promotion to
bool.  But with the suggestion above the need for this helper
should go away anyway.
