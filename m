From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 2/6] dma-debug: add support for resource mappings
Date: Mon, 05 Sep 2016 12:39:06 +0300
Message-ID: <2296171.Os8u9NTgGI@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <20160810112219.17964-3-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160810112219.17964-3-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 Aug 2016 13:22:15 Niklas S=F6derlund wrote:
> A MMIO mapped resource can not be represented by a struct page so a n=
ew
> debug type is needed to handle this. This patch add such type and
> functionality to add/remove entries and how to translate them to a
> physical address.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/dma-debug.h | 19 +++++++++++++++++
>  lib/dma-debug.c           | 52 +++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 69 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index fe8cb61..c7d844f 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -56,6 +56,13 @@ extern void debug_dma_alloc_coherent(struct device=
 *dev,
> size_t size, extern void debug_dma_free_coherent(struct device *dev, =
size_t
> size, void *virt, dma_addr_t addr);
>=20
> +extern void debug_dma_map_resource(struct device *dev, phys_addr_t a=
ddr,
> +=09=09=09=09   size_t size, int direction,
> +=09=09=09=09   dma_addr_t dma_addr);
> +
> +extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t
> dma_addr, +=09=09=09=09     size_t size, int direction);
> +
>  extern void debug_dma_sync_single_for_cpu(struct device *dev,
>  =09=09=09=09=09  dma_addr_t dma_handle, size_t size,
>  =09=09=09=09=09  int direction);
> @@ -141,6 +148,18 @@ static inline void debug_dma_free_coherent(struc=
t
> device *dev, size_t size, {
>  }
>=20
> +static inline void debug_dma_map_resource(struct device *dev, phys_a=
ddr_t
> addr, +=09=09=09=09=09  size_t size, int direction,
> +=09=09=09=09=09  dma_addr_t dma_addr)
> +{
> +}
> +
> +static inline void debug_dma_unmap_resource(struct device *dev,
> +=09=09=09=09=09    dma_addr_t dma_addr, size_t size,
> +=09=09=09=09=09    int direction)
> +{
> +}
> +
>  static inline void debug_dma_sync_single_for_cpu(struct device *dev,=

>  =09=09=09=09=09=09 dma_addr_t dma_handle,
>  =09=09=09=09=09=09 size_t size, int direction)
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index fcfa193..2ba086b 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -43,6 +43,7 @@ enum {
>  =09dma_debug_page,
>  =09dma_debug_sg,
>  =09dma_debug_coherent,
> +=09dma_debug_resource,
>  };
>=20
>  enum map_err_types {
> @@ -150,8 +151,9 @@ static const char *const maperr2str[] =3D {
>  =09[MAP_ERR_CHECKED] =3D "dma map error checked",
>  };
>=20
> -static const char *type2name[4] =3D { "single", "page",
> -=09=09=09=09    "scather-gather", "coherent" };
> +static const char *type2name[5] =3D { "single", "page",
> +=09=09=09=09    "scather-gather", "coherent",
> +=09=09=09=09    "resource" };
>=20
>  static const char *dir2name[4] =3D { "DMA_BIDIRECTIONAL", "DMA_TO_DE=
VICE",
>  =09=09=09=09   "DMA_FROM_DEVICE", "DMA_NONE" };
> @@ -399,6 +401,9 @@ static void hash_bucket_del(struct dma_debug_entr=
y
> *entry)
>=20
>  static unsigned long long phys_addr(struct dma_debug_entry *entry)
>  {
> +=09if (entry->type =3D=3D dma_debug_resource)
> +=09=09return __pfn_to_phys(entry->pfn) + entry->offset;
> +
>  =09return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
>  }
>=20
> @@ -1495,6 +1500,49 @@ void debug_dma_free_coherent(struct device *de=
v,
> size_t size, }
>  EXPORT_SYMBOL(debug_dma_free_coherent);
>=20
> +void debug_dma_map_resource(struct device *dev, phys_addr_t addr, si=
ze_t
> size, +=09=09=09    int direction, dma_addr_t dma_addr)
> +{
> +=09struct dma_debug_entry *entry;
> +
> +=09if (unlikely(dma_debug_disabled()))
> +=09=09return;
> +
> +=09entry =3D dma_entry_alloc();
> +=09if (!entry)
> +=09=09return;
> +
> +=09entry->type=09=09=3D dma_debug_resource;
> +=09entry->dev=09=09=3D dev;
> +=09entry->pfn=09=09=3D __phys_to_pfn(addr);
> +=09entry->offset=09=09=3D offset_in_page(addr);
> +=09entry->size=09=09=3D size;
> +=09entry->dev_addr=09=09=3D dma_addr;
> +=09entry->direction=09=3D direction;
> +=09entry->map_err_type=09=3D MAP_ERR_NOT_CHECKED;
> +
> +=09add_dma_entry(entry);
> +}
> +EXPORT_SYMBOL(debug_dma_map_resource);
> +
> +void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_add=
r,
> +=09=09=09      size_t size, int direction)
> +{
> +=09struct dma_debug_entry ref =3D {
> +=09=09.type           =3D dma_debug_resource,
> +=09=09.dev            =3D dev,
> +=09=09.dev_addr       =3D dma_addr,
> +=09=09.size           =3D size,
> +=09=09.direction      =3D direction,
> +=09};
> +
> +=09if (unlikely(dma_debug_disabled()))
> +=09=09return;
> +
> +=09check_unmap(&ref);
> +}
> +EXPORT_SYMBOL(debug_dma_unmap_resource);
> +
>  void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t
> dma_handle, size_t size, int direction)
>  {

--=20
Regards,

Laurent Pinchart
