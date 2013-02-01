From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/4] iommu/shmobile: Add iommu driver for Renesas
	IPMMU modules
Date: Fri, 1 Feb 2013 14:54:57 +0100
Message-ID: <20130201135456.GG25591@8bytes.org>
References: <1358765669-14567-1-git-send-email-hdk@igel.co.jp>
	<1358765669-14567-2-git-send-email-hdk@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358765669-14567-2-git-send-email-hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hideki EIRAKU <hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
Cc: Katsuya MATSUBARA <matsu-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 21, 2013 at 07:54:26PM +0900, Hideki EIRAKU wrote:
> This is the Renesas IPMMU driver and IOMMU API implementation.
> 
> The IPMMU module supports the MMU function and the PMB function.  The
> MMU function provides address translation by pagetable compatible with
> ARMv6.  The PMB function provides address translation including
> tile-linear translation.  This patch implements the MMU function.
> 
> The iommu driver does not register a platform driver directly because:
> - the register space of the MMU function and the PMB function
>   have a common register (used for settings flush), so they should ideally
>   have a way to appropriately share this register.
> - the MMU function uses the IOMMU API while the PMB function does not.
> - the two functions may be used independently.
> 
> Signed-off-by: Hideki EIRAKU <hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

The patch looks good in general. Just one question inline.

> +static int pgtable_alloc(struct shmobile_iommu_domain_pgtable *pgtable,
> +			 struct kmem_cache *cache, size_t size)
> +{
> +	pgtable->pgtable = kmem_cache_zalloc(cache, GFP_ATOMIC);
> +	if (!pgtable->pgtable)
> +		return -ENOMEM;
> +	pgtable->handle = dma_map_single(NULL, pgtable->pgtable, size,
> +					 DMA_TO_DEVICE);
> +	return 0;
> +}

Why is it necessary to call dma_map_single() for IOMMU page-tables?
usually the dma_* functions call into IOMMU drivers, so why are they
used inside an IOMMU driver?

Regards,

	Joerg
