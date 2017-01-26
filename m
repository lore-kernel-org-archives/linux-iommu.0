From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to
	32-bit address space
Date: Thu, 26 Jan 2017 11:23:31 +0000
Message-ID: <78112a99-dee0-c163-1d16-68a17f64f701@arm.com>
References: <1485424391-29914-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1485424391-29914-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26/01/17 09:53, Geert Uytterhoeven wrote:
> Currently, the IPMMU/VMSA driver supports 32-bit I/O Virtual Addresses
> only, and thus sets io_pgtable_cfg.ias = 32.  However, it doesn't force
> a 32-bit IOVA space through the IOMMU Domain Geometry.
> 
> Hence if a device (e.g. SYS-DMAC) rightfully configures a 40-bit DMA
> mask, it will still be handed out a 40-bit IOVA, outside the 32-bit IOVA
> space, leading to out-of-bounds accesses of the PGD when mapping the
> IOVA.
> 
> Force a 32-bit IOMMU Domain Geometry to fix this.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> Should the generic code restrict the geometry based on IAS instead?

Which generic code? IAS is specific to the io-pgtable library (well,
really it's an ARM-SMMU-ism, but "input address size" is a fairly
portable concept), but io-pgtable is just factored-out driver helper
code and doesn't know anything about iommu_domains and the IOMMU API.
Conversely, the IOMMU API core and kernel code beyond also know nothing
about io-pgtable internals - in fact the domain geometry *is* how the
IOMMU driver communicates its configured address space size to the
outside world.

Robin.

> ---
>  drivers/iommu/ipmmu-vmsa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 798578f1676480c6..eb8b3df8733b15fb 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -424,6 +424,8 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  	domain->cfg.ias = 32;
>  	domain->cfg.oas = 40;
>  	domain->cfg.tlb = &ipmmu_gather_ops;
> +	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
> +	domain->io_domain.geometry.force_aperture = true;
>  	/*
>  	 * TODO: Add support for coherent walk through CCI with DVM and remove
>  	 * cache handling. For now, delegate it to the io-pgtable code.
> 
