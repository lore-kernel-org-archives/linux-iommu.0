From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v9 3/7] vfio/type1: bypass unmap/unpin and replay for
 VFIO_IOVA_RESERVED slots
Date: Mon, 9 May 2016 16:49:36 -0600
Message-ID: <20160509164936.1a5ae402@t450s.home>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-4-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462362858-2925-4-git-send-email-eric.auger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>
Cc: eric.auger@st.com, robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

On Wed,  4 May 2016 11:54:14 +0000
Eric Auger <eric.auger@linaro.org> wrote:

> Before allowing the end-user to create VFIO_IOVA_RESERVED dma slots,
> let's implement the expected behavior for removal and replay. As opposed
> to user dma slots, IOVAs are not systematically bound to PAs and PAs are
> not pinned. VFIO just initializes the IOVA "aperture". IOVAs are allocated
> outside of the VFIO framework, typically the MSI layer which is
> responsible to free and unmap them. The MSI mapping resources are freeed
> by the IOMMU driver on domain destruction.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> v7 -> v8:
> - do no destroy anything anymore, just bypass unmap/unpin and iommu_map
>   on replay
> ---
>  drivers/vfio/vfio_iommu_type1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2d769d4..94a9916 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -391,7 +391,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  	struct vfio_domain *domain, *d;
>  	long unlocked = 0;
>  
> -	if (!dma->size)
> +	if (!dma->size || dma->type != VFIO_IOVA_USER)
>  		return;
>  	/*
>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
> @@ -727,6 +727,9 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  		dma = rb_entry(n, struct vfio_dma, node);
>  		iova = dma->iova;
>  
> +		if (dma->type == VFIO_IOVA_RESERVED)
> +			continue;
> +

But you do still need some sort of replay mechanism, right?  Not to
replay the IOVA to PA mapping, but to call iommu_msi_set_aperture() for
the new domain.  How will you know that this entry is an MSI reserved
range or something else?  Perhaps we can't have a generic "reserved"
type here.

>  		while (iova < dma->iova + dma->size) {
>  			phys_addr_t phys = iommu_iova_to_phys(d->domain, iova);
>  			size_t size;
