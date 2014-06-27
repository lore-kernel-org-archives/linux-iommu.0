From: Hiroshi DOyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 09/10] drm/tegra: Add IOMMU support
Date: Fri, 27 Jun 2014 12:46:14 +0300
Message-ID: <20140627124614.050be2e406a4b9a02d9fe97c@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403815790-8548-10-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak@codeaurora.o>
List-Id: iommu@lists.linux-foundation.org


Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> When an IOMMU device is available on the platform bus, allocate an IOMMU
> domain and attach the display controllers to it. The display controllers
> can then scan out non-contiguous buffers by mapping them through the
> IOMMU.
>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/tegra/dc.c  |  21 ++++
>  drivers/gpu/drm/tegra/drm.c |  17 ++++
>  drivers/gpu/drm/tegra/drm.h |   3 +
>  drivers/gpu/drm/tegra/fb.c  |  16 ++-
>  drivers/gpu/drm/tegra/gem.c | 236 +++++++++++++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/tegra/gem.h |   4 +
>  6 files changed, 273 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index afcca04f5367..0f7452d04811 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/debugfs.h>
> +#include <linux/iommu.h>
>  #include <linux/reset.h>
>
>  #include "dc.h"
> @@ -1283,8 +1284,18 @@ static int tegra_dc_init(struct host1x_client *client)
>  {
>         struct drm_device *drm = dev_get_drvdata(client->parent);
>         struct tegra_dc *dc = host1x_client_to_dc(client);
> +       struct tegra_drm *tegra = drm->dev_private;
>         int err;
>
> +       if (tegra->domain) {
> +               err = iommu_attach_device(tegra->domain, dc->dev);

I wanted to keep device drivers iommu-free with the following:

http://patchwork.ozlabs.org/patch/354074/


> +               if (err < 0) {
> +                       dev_err(dc->dev, "failed to attach to IOMMU: %d\n",
> +                               err);
> +                       return err;
> +               }
> +       }
> +
>         drm_crtc_init(drm, &dc->base, &tegra_crtc_funcs);
>         drm_mode_crtc_set_gamma_size(&dc->base, 256);
>         drm_crtc_helper_add(&dc->base, &tegra_crtc_helper_funcs);
> @@ -1318,7 +1329,9 @@ static int tegra_dc_init(struct host1x_client *client)
>
>  static int tegra_dc_exit(struct host1x_client *client)
>  {
> +       struct drm_device *drm = dev_get_drvdata(client->parent);
>         struct tegra_dc *dc = host1x_client_to_dc(client);
> +       struct tegra_drm *tegra = drm->dev_private;
>         int err;
>
>         devm_free_irq(dc->dev, dc->irq, dc);
> @@ -1335,6 +1348,8 @@ static int tegra_dc_exit(struct host1x_client *client)
>                 return err;
>         }
>
> +       iommu_detach_device(tegra->domain, dc->dev);
> +
>         return 0;
>  }
>
> @@ -1462,6 +1477,12 @@ static int tegra_dc_probe(struct platform_device *pdev)
>                 return -ENXIO;
>         }
>
> +       err = iommu_attach(&pdev->dev);
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failed to attach to IOMMU: %d\n", err);
> +               return err;
> +       }
> +
>         INIT_LIST_HEAD(&dc->client.list);
>         dc->client.ops = &dc_client_ops;
>         dc->client.dev = &pdev->dev;
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 59736bb810cd..1d2bbafad982 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/host1x.h>
> +#include <linux/iommu.h>
>
>  #include "drm.h"
>  #include "gem.h"
> @@ -33,6 +34,16 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
>         if (!tegra)
>                 return -ENOMEM;
>
> +       if (iommu_present(&platform_bus_type)) {
> +               tegra->domain = iommu_domain_alloc(&platform_bus_type);

Can we use "dma_iommu_mapping" instead of domain?

I thought that DMA API is on the top of IOMMU API so that it may be
cleaner to use only DMA API.


> +               if (IS_ERR(tegra->domain)) {
> +                       kfree(tegra);
> +                       return PTR_ERR(tegra->domain);
> +               }
> +
> +               drm_mm_init(&tegra->mm, 0, SZ_2G);
> +       }
> +
>         mutex_init(&tegra->clients_lock);
>         INIT_LIST_HEAD(&tegra->clients);
>         drm->dev_private = tegra;
> @@ -71,6 +82,7 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
>  static int tegra_drm_unload(struct drm_device *drm)
>  {
>         struct host1x_device *device = to_host1x_device(drm->dev);
> +       struct tegra_drm *tegra = drm->dev_private;
>         int err;
>
>         drm_kms_helper_poll_fini(drm);
> @@ -82,6 +94,11 @@ static int tegra_drm_unload(struct drm_device *drm)
>         if (err < 0)
>                 return err;
>
> +       if (tegra->domain) {
> +               iommu_domain_free(tegra->domain);
> +               drm_mm_takedown(&tegra->mm);
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
> index 96d754e7b3eb..a07c796b7edc 100644
> --- a/drivers/gpu/drm/tegra/drm.h
> +++ b/drivers/gpu/drm/tegra/drm.h
> @@ -39,6 +39,9 @@ struct tegra_fbdev {
>  struct tegra_drm {
>         struct drm_device *drm;
>
> +       struct iommu_domain *domain;
> +       struct drm_mm mm;
> +
>         struct mutex clients_lock;
>         struct list_head clients;
>
> diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
> index 7790d43ad082..21c65dd817c3 100644
> --- a/drivers/gpu/drm/tegra/fb.c
> +++ b/drivers/gpu/drm/tegra/fb.c
> @@ -65,8 +65,12 @@ static void tegra_fb_destroy(struct drm_framebuffer *framebuffer)
>         for (i = 0; i < fb->num_planes; i++) {
>                 struct tegra_bo *bo = fb->planes[i];
>
> -               if (bo)
> +               if (bo) {
> +                       if (bo->pages && bo->virt)
> +                               vunmap(bo->virt);
> +
>                         drm_gem_object_unreference_unlocked(&bo->gem);
> +               }
>         }
>
>         drm_framebuffer_cleanup(framebuffer);
> @@ -252,6 +256,16 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
>         offset = info->var.xoffset * bytes_per_pixel +
>                  info->var.yoffset * fb->pitches[0];
>
> +       if (bo->pages) {
> +               bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
> +                                pgprot_writecombine(PAGE_KERNEL));
> +               if (!bo->vaddr) {
> +                       dev_err(drm->dev, "failed to vmap() framebuffer\n");
> +                       err = -ENOMEM;
> +                       goto destroy;
> +               }
> +       }
> +
>         drm->mode_config.fb_base = (resource_size_t)bo->paddr;
>         info->screen_base = (void __iomem *)bo->vaddr + offset;
>         info->screen_size = size;
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index c1e4e8b6e5ca..2912e61a2599 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -14,8 +14,10 @@
>   */
>
>  #include <linux/dma-buf.h>
> +#include <linux/iommu.h>
>  #include <drm/tegra_drm.h>
>
> +#include "drm.h"
>  #include "gem.h"
>
>  static inline struct tegra_bo *host1x_to_tegra_bo(struct host1x_bo *bo)
> @@ -90,14 +92,144 @@ static const struct host1x_bo_ops tegra_bo_ops = {
>         .kunmap = tegra_bo_kunmap,
>  };

iommu_map_sg() could be implemented as iommu_ops->map_sg() for the
better perf since iommu_map() needs some pagetable cache operations. If
we do those cache operations at once, it would bring some perf benefit.

> +static int iommu_map_sg(struct iommu_domain *domain, struct sg_table *sgt,
> +                       dma_addr_t iova, int prot)
> +{
> +       unsigned long offset = 0;
> +       struct scatterlist *sg;
> +       unsigned int i, j;
> +       int err;
> +
> +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +               dma_addr_t phys = sg_phys(sg);
> +               size_t length = sg->offset;
> +
> +               phys = sg_phys(sg) - sg->offset;
> +               length = sg->length + sg->offset;
> +
> +               err = iommu_map(domain, iova + offset, phys, length, prot);
> +               if (err < 0)
> +                       goto unmap;
> +
> +               offset += length;
> +       }
> +
> +       return 0;
> +
> +unmap:
> +       offset = 0;
> +
> +       for_each_sg(sgt->sgl, sg, i, j) {
> +               size_t length = sg->length + sg->offset;
> +               iommu_unmap(domain, iova + offset, length);
> +               offset += length;
> +       }
> +
> +       return err;
> +}

I think that we don't need unmap_sg(), instead normal iommu_unmap() for
a whole area could do the same at once?

> +static int iommu_unmap_sg(struct iommu_domain *domain, struct sg_table *sgt,
> +                         dma_addr_t iova)
> +{
> +       unsigned long offset = 0;
> +       struct scatterlist *sg;
> +       unsigned int i;
> +
> +       for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +               dma_addr_t phys = sg_phys(sg);
> +               size_t length = sg->offset;
> +
> +               phys = sg_phys(sg) - sg->offset;
> +               length = sg->length + sg->offset;
> +
> +               iommu_unmap(domain, iova + offset, length);
> +               offset += length;
> +       }
> +
> +       return 0;
> +}

Can the rest of IOMMU API be replaced with DMA API too?
