From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [RESEND,2/3] iommu/dma: Clean up MSI IOVA allocation
Date: Thu, 6 Apr 2017 13:14:25 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1704061313220.4602@lazy>
References: <0d9ed41de4b88964e5bd0d653eed1094959e7276.1490971180.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0d9ed41de4b88964e5bd0d653eed1094959e7276.1490971180.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 31 Mar 2017, Robin Murphy wrote:

> Now that allocation is suitably abstracted, our private alloc/free
> helpers can drive the trivial MSI cookie allocator directly as well,
> which lets us clean up its exposed guts from iommu_dma_map_msi_msg() and
> simplify things quite a bit.
>
> Reviewed-by: Nate Watterson <nwatters@codeaurora.org>
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/iommu/dma-iommu.c | 58 ++++++++++++++++++++---------------------------
> 1 file changed, 25 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8e0b684da1ba..1b94beb43036 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -61,15 +61,6 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
> 	return PAGE_SIZE;
> }
>
> -static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
> -{
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -
> -	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
> -		return &cookie->iovad;
> -	return NULL;
> -}
> -
> static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
> {
> 	struct iommu_dma_cookie *cookie;
> @@ -368,11 +359,19 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
> static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
> 		size_t size, dma_addr_t dma_limit, struct device *dev)
> {
> -	struct iova_domain *iovad = cookie_iovad(domain);
> -	unsigned long shift = iova_shift(iovad);
> -	unsigned long iova_len = size >> shift;
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	unsigned long shift, iova_len;
> 	struct iova *iova = NULL;
>
> +	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
> +		cookie->msi_iova += size;
> +		return cookie->msi_iova - size;
> +	}
> +
> +	shift = iova_shift(iovad);
> +	iova_len = size >> shift;
> +
> 	if (domain->geometry.force_aperture)
> 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
>
> @@ -396,6 +395,12 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
> 	struct iova_domain *iovad = &cookie->iovad;
> 	struct iova *iova_rbnode;
>
> +	/* The MSI case is only ever cleaning up its most recent allocation */
> +	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
> +		cookie->msi_iova -= size;
> +		return;
> +	}
> +
> 	iova_rbnode = find_iova(iovad, iova_pfn(iovad, iova));
> 	if (WARN_ON(!iova_rbnode))
> 		return;
> @@ -406,14 +411,15 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
> static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
> 		size_t size)
> {
> -	struct iova_domain *iovad = cookie_iovad(domain);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> 	size_t iova_off = iova_offset(iovad, dma_addr);
>
> 	dma_addr -= iova_off;
> 	size = iova_align(iovad, size + iova_off);
>
> 	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
> -	iommu_dma_free_iova(domain->iova_cookie, dma_addr, size);
> +	iommu_dma_free_iova(cookie, dma_addr, size);
> }
>
> static void __iommu_dma_free_pages(struct page **pages, int count)
> @@ -838,7 +844,6 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> {
> 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> 	struct iommu_dma_msi_page *msi_page;
> -	struct iova_domain *iovad = cookie_iovad(domain);
> 	dma_addr_t iova;
> 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> 	size_t size = cookie_msi_granule(cookie);
> @@ -852,29 +857,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> 	if (!msi_page)
> 		return NULL;
>
> -	msi_page->phys = msi_addr;
> -	if (iovad) {
> -		iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> -		if (!iova)
> -			goto out_free_page;
> -		msi_page->iova = iova;
> -	} else {
> -		msi_page->iova = cookie->msi_iova;
> -		cookie->msi_iova += size;
> -	}
> -
> -	if (iommu_map(domain, msi_page->iova, msi_addr, size, prot))
> -		goto out_free_iova;
> +	iova = __iommu_dma_map(dev, msi_addr, size, prot);
> +	if (iommu_dma_mapping_error(dev, iova))
> +		goto out_free_page;
>
> 	INIT_LIST_HEAD(&msi_page->list);
> +	msi_page->phys = msi_addr;
> +	msi_page->iova = iova;
> 	list_add(&msi_page->list, &cookie->msi_page_list);
> 	return msi_page;
>
> -out_free_iova:
> -	if (iovad)
> -		iommu_dma_free_iova(cookie, iova, size);
> -	else
> -		cookie->msi_iova -= size;
> out_free_page:
> 	kfree(msi_page);
> 	return NULL;
>

This patch series helps to resolve the Ubuntu bug, where we see the Ubuntu 
Zesty (4.10 based) kernel reporting multi cpu soft lockups on QDF2400 SDP. 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1680549

This patch series along with the following cherry-picks from Linus's tree 
dddd632b072f iommu/dma: Implement PCI allocation optimisation
de84f5f049d9 iommu/dma: Stop getting dma_32bit_pfn wrong

were applied to Ubuntu Zesty 4.10 kernel (Ubuntu-4.10.0-18.20) and tested 
on a QDF2400 SDP.

Tested-by: Manoj Iyer <manoj.iyer@canonical.com>


--
============================
Manoj Iyer
Ubuntu/Canonical
ARM Servers - Cloud
============================
