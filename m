From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCHv7 4/6] arm: dma-mapping: add {map, unmap}_resource for
	iommu ops
Date: Thu, 2 Jun 2016 14:50:13 +0200
Message-ID: <20160602125013.GM8307@bigcity.dyn.berto.se>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1464794549-6601-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<20160601161605.GA19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160601161605.GA19428-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

Thanks for your feedback.

On 2016-06-01 17:16:06 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 01, 2016 at 05:22:27PM +0200, Niklas S=F6derlund wrote:
> > +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> > +		phys_addr_t phys_addr, size_t size,
> > +		enum dma_data_direction dir, struct dma_attrs *attrs)
> > +{
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> > +	dma_addr_t dma_addr;
> > +	int ret, prot;
> > +	phys_addr_t addr =3D phys_addr & PAGE_MASK;
> > +	int offset =3D phys_addr & ~PAGE_MASK;
> > +	int len =3D PAGE_ALIGN(size + offset);
> =

> Shouldn't both of these be unsigned - preferably size_t for len?

I have looked at arm_coherent_iommu_map_page() when writing this where =

len is int. But I do agree that it should probably be size_t and offset =

should be unsigned. Will fix this.

> =

> > +
> > +	dma_addr =3D __alloc_iova(mapping, size);
> =

> Is this really correct?  What if size =3D 4095 and offset =3D 10?  Do we
> really only need one IOVA page for such a mapping (I count two pages.)
> Shouldn't this be "len" ?

Wops, you are correct it should be len not size.

> =

> > +	if (dma_addr =3D=3D DMA_ERROR_CODE)
> > +		return dma_addr;
> > +
> > +	prot =3D __dma_direction_to_prot(dir) | IOMMU_MMIO;
> > +
> > +	ret =3D iommu_map(mapping->domain, dma_addr, addr, len, prot);
> > +	if (ret < 0)
> > +		goto fail;
> > +
> > +	return dma_addr + offset;
> > +fail:
> > +	__free_iova(mapping, dma_addr, size);
> =

> Shouldn't this be "len" as well?

Yes.

> =

> > +	return DMA_ERROR_CODE;
> > +}
> > +
> > +/**
> > + * arm_iommu_unmap_resource - unmap a device DMA resource
> > + * @dev: valid struct device pointer
> > + * @dma_handle: DMA address to resource
> > + * @size: size of resource to map
> > + * @dir: DMA transfer direction
> > + */
> > +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dm=
a_handle,
> > +		size_t size, enum dma_data_direction dir,
> > +		struct dma_attrs *attrs)
> > +{
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> > +	dma_addr_t iova =3D dma_handle & PAGE_MASK;
> > +	int offset =3D dma_handle & ~PAGE_MASK;
> > +	int len =3D PAGE_ALIGN(size + offset);
> =

> unsigned/size_t again.

Will fix.

> =

> > +
> > +	if (!iova)
> > +		return;
> > +
> > +	iommu_unmap(mapping->domain, iova, len);
> > +	__free_iova(mapping, iova, len);
> =

> Here, you free "len" bytes of iova, which is different from above.

Yes you are correct. By using len instead of size in =

arm_iommu_map_resource() the sizes do match.

> =

> > +}
> > +
> >  static void arm_iommu_sync_single_for_cpu(struct device *dev,
> >  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
> >  {
> > @@ -1994,6 +2051,9 @@ struct dma_map_ops iommu_ops =3D {
> >  	.unmap_sg		=3D arm_iommu_unmap_sg,
> >  	.sync_sg_for_cpu	=3D arm_iommu_sync_sg_for_cpu,
> >  	.sync_sg_for_device	=3D arm_iommu_sync_sg_for_device,
> > +
> > +	.map_resource		=3D arm_iommu_map_resource,
> > +	.unmap_resource		=3D arm_iommu_unmap_resource,
> >  };
> >  =

> >  struct dma_map_ops iommu_coherent_ops =3D {
> > @@ -2007,6 +2067,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
> >  =

> >  	.map_sg		=3D arm_coherent_iommu_map_sg,
> >  	.unmap_sg	=3D arm_coherent_iommu_unmap_sg,
> > +
> > +	.map_resource	=3D arm_iommu_map_resource,
> > +	.unmap_resource	=3D arm_iommu_unmap_resource,
> >  };
> >  =

> >  /**
> > -- =

> > 2.8.2
> > =

> > =

> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> =

> -- =

> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- =

Regards,
Niklas S=F6derlund
