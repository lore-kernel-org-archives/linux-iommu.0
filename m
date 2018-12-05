From: Mauro Carvalho Chehab <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] media: s5p-mfc: Fix memdev DMA configuration
Date: Wed, 5 Dec 2018 07:31:02 -0200
Message-ID: <20181205073102.310edc76@coco.lan>
References: <CGME20180912164604epcas3p1ac72c0861ec182f50485959ac998ed52@epcas3p1.samsung.com>
	<d485dc3698304403620d5ed92d066942a6b68cfd.1536770587.git.robin.murphy@arm.com>
	<20180914121931eucas1p14292ee983fd9b4bb21968dffa303dde8~UQ3utL6mj2689726897eucas1p15@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180914121931eucas1p14292ee983fd9b4bb21968dffa303dde8~UQ3utL6mj2689726897eucas1p15-MHMrYXj8g+pqW5MlFJXMulaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Sylwester Nawrocki <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Smitha T Murthy <smitha.t-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jtp.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Em Fri, 14 Sep 2018 14:19:29 +0200
Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> escreveu:

> Hi Robin,
> 
> On 2018-09-12 18:45, Robin Murphy wrote:
> > Having of_reserved_mem_device_init() forcibly reconfigure DMA for all
> > callers, potentially overriding the work done by a bus-specific
> > .dma_configure method earlier, is at best a bad idea and at worst
> > actively harmful. If drivers really need virtual devices to own
> > dma-coherent memory, they should explicitly configure those devices
> > based on the appropriate firmware node as they create them.
> >
> > It looks like the only driver not passing in a proper OF platform device
> > is s5p-mfc, so move the rogue of_dma_configure() call into that driver
> > where it logically belongs.
> >
> > CC: Smitha T Murthy <smitha.t-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > CC: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > CC: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>  
> 
> Right, after recent cleanup dma ops initialization, MFC driver is
> a better place for calling of_dma_configure() on virtual devices.
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch seems to fit better via OF/DT tree. Not sure if it was
merged there yet. In any case:

Acked-by: Mauro Carvalho Chehab <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> > ---
> >   drivers/media/platform/s5p-mfc/s5p_mfc.c | 7 +++++++
> >   drivers/of/of_reserved_mem.c             | 4 ----
> >   2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> > index 927a1235408d..77eb4a4511c1 100644
> > --- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
> > +++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
> > @@ -1094,6 +1094,13 @@ static struct device *s5p_mfc_alloc_memdev(struct device *dev,
> >   	child->dma_mask = dev->dma_mask;
> >   	child->release = s5p_mfc_memdev_release;
> >   
> > +	/*
> > +	 * The memdevs are not proper OF platform devices, so in order for them
> > +	 * to be treated as valid DMA masters we need a bit of a hack to force
> > +	 * them to inherit the MFC node's DMA configuration.
> > +	 */
> > +	of_dma_configure(child, dev->of_node, true);
> > +
> >   	if (device_add(child) == 0) {
> >   		ret = of_reserved_mem_device_init_by_idx(child, dev->of_node,
> >   							 idx);
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 895c83e0c7b6..4ef6f4485335 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -350,10 +350,6 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
> >   		mutex_lock(&of_rmem_assigned_device_mutex);
> >   		list_add(&rd->list, &of_rmem_assigned_device_list);
> >   		mutex_unlock(&of_rmem_assigned_device_mutex);
> > -		/* ensure that dma_ops is set for virtual devices
> > -		 * using reserved memory
> > -		 */
> > -		of_dma_configure(dev, np, true);
> >   
> >   		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
> >   	} else {  
> 
> Best regards



Thanks,
Mauro
