From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: hide unused ipmmu_iotlb_sync
Date: Wed, 11 Oct 2017 15:16:21 +0100
Message-ID: <459ef50f-e51e-32ee-0816-b1003b2b4e4c@arm.com>
References: <20171011135919.3653302-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171011135919.3653302-1-arnd-r2nGTMty4D4@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/10/17 14:59, Arnd Bergmann wrote:
> There are two sets of iommu_ops in this driver, and only
> one of them contains a reference to the ipmmu_iotlb_sync
> function. This leads to a compiler warning when these
> operations are not in use:
> 
> drivers/iommu/ipmmu-vmsa.c:622:13: error: 'ipmmu_iotlb_sync' defined but not used [-Werror=unused-function]

Oh bum, I forgot there was still quite so much #ifdef'd under CONFIG_ARM
in this driver :(

> We either want to use the function in both operations, or
> we should hide it. Without having additional information
> which approach is correct, I'm picking the second one here,
> which avoids the build error.

For correctness I think it needs to be the first one, otherwise
iommu_unmap() will wind up missing a sync on 32-bit ARM.

That said, I think the third option is now viable as well, namely to
shuffle some lines and get rid of the almost-duplicated ops entirely.
I'll have a quick go at that shortly.

Robin.

> Fixes: 32b124492bdf ("iommu/io-pgtable-arm: Convert to IOMMU API TLB sync")
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index af8140054273..bdd0d0d20925 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -619,14 +619,6 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
>  	return domain->iop->unmap(domain->iop, iova, size);
>  }
>  
> -static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
> -{
> -	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> -
> -	if (domain->mmu)
> -		ipmmu_tlb_flush_all(domain);
> -}
> -
>  static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
>  				      dma_addr_t iova)
>  {
> @@ -810,6 +802,14 @@ static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
>  	}
>  }
>  
> +static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
> +{
> +	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> +
> +	if (domain->mmu)
> +		ipmmu_tlb_flush_all(domain);
> +}
> +
>  static int ipmmu_add_device_dma(struct device *dev)
>  {
>  	struct iommu_group *group;
> 
