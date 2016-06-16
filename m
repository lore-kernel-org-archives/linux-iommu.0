From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv8 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
Date: Thu, 16 Jun 2016 09:18:52 +0200
Message-ID: <20160616071852.GO31969@bigcity.dyn.berto.se>
References: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk
Cc: hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

I was wondering if you have time to look at this series?
Especially patch 4/6 which you had some good review comments on in v7.

On 2016-06-07 09:54:07 +0200, Niklas S=F6derlund wrote:
> Hi,
>=20
> This series tries to solve the problem with DMA with device registers
> (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> recent patch '9575632 (dmaengine: make slave address physical)'
> clarifies that DMA slave address provided by clients is the physical
> address. This puts the task of mapping the DMA slave address from a
> phys_addr_t to a dma_addr_t on the DMA engine.
>=20
> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t ar=
e
> the same and no special care is needed. However if you have a IOMMU y=
ou
> need to map the DMA slave phys_addr_t to a dma_addr_t using something
> like this.
>=20
> This series is based on top of v4.7-rc1. And I'm hoping to be able to=
 collect a=20
> Ack from Russell King on patch 4/6 that adds the ARM specific part an=
d then be=20
> able to take the whole series through the dmaengine tree. If this is =
not the=20
> best route I'm more then happy to do it another way.
>=20
> It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting wi=
th
> /dev/mmcblk1, i2c and the serial console which are devices behind the
> iommu.
>=20
> Furthermore I have audited to the best of my ability all call paths
> involved to make sure that the dma_addr_t obtained from
> dma_map_resource() to is not used in a way where it would be expected
> for the mapping to be RAM (have a struct page). Many thanks to Christ=
oph
> Hellwig and Laurent Pinchart for there input in this effort.
>=20
>   * drivers/dma/sh/rcar-dmac.c
>     Once the phys_addr_t is mapped to a dma_addr_t using
>     dma_map_resource() it is only used to check that the transferee d=
o not
>     cross 4GB boundaries and then only directly written to HW registe=
rs.
>=20
>   * drivers/iommu/iommu.c
>     - iommu_map()
>       Check that it's align to min page size or return -EINVAL then c=
alls
>       domain->ops->map()
>=20
>   * drivers/iommu/ipmmu-vmsa.c
>     - ipmmu_map()
>       No logic only calls domain->ops->map()
>=20
>   * drivers/iommu/io-pgtable-arm.c
>     - arm_lpae_map()
>       No logic only calls __arm_lpae_map()
>     - __arm_lpae_map()
>       No logic only calls arm_lpae_init_pte()
>     - arm_lpae_init_pte()
>       Used to get a pte:
>         pte |=3D pfn_to_iopte(paddr >> data->pg_shift, data);
>=20
>   * drivers/iommu/io-pgtable-arm-v7s.c
>     - arm_v7s_map()
>       No logic only calls __arm_v7s_map()
>     - __arm_v7s_map()
>       No logic only calls arm_v7s_init_pte()
>     - arm_v7s_init_pte
>       Used to get a pte:
>         pte |=3D paddr & ARM_V7S_LVL_MASK(lvl);
>=20
>   * ARM dma-mapping
>     - dma_unmap_*
>       Only valid unmap is dma_unmap_resource() all others are an inva=
lid
>       use case.
>     - dma_sync_single_*
>       Invalid use case, memory that is mapped is device memory
>     - dma_common_mmap() and dma_mmap_attrs()
>       Invalid use case
>     - dma_common_get_sgtable() and dma_get_sgtable_attrs()
>       Invalid use case, only for dma_alloc_* allocated memory,
>     - dma_mapping_error()
>       OK
>=20
> * Changes since v7
> - Use size_t instead of int for length in arm_iommu_map_resource() an=
d=20
>   arm_iommu_unmap_resource().
> - Fix bug in arm_iommu_map_resource() where wrong variable where pass=
ed to=20
>   __alloc_iova(). Thanks to Russell King for pointing out both errors=
=2E
>=20
> * Changes since v6
> - Use offset_in_page() and __pfn_to_phys(). This fixed a bug in the
>   lib/dma-debug.c. Thanks to Konrad Rzeszutek Wilk for finding it and=
 Robin
>   Murphy for suggesting offset_in_page().
> - Rebased on top of v4.7-rc1.
> - Dropped DT patches which enabled the IPMMU on Renesas Koelsch and L=
ager. Will
>   post them separately at a later time.
>=20
> * Changes since v5
> - Add dma-debug work which adds a new mapping type for the resource
>   mapping which correctly can be translated to a physical address.
> - Drop patches from Robin Murphy since they now are accepted in the
>   iommu repository and base the series on that tree instead.
> - Add a review tag from Laurent.
>=20
> * Changes since v4
> - Move the mapping from phys_addr_t to dma_addr_t from slave_config t=
o the
>   prepare calls. This way we know the direction of the mapping and do=
n't have
>   to use DMA_BIDIRECTIONAL. Thanks Vinod for suggesting this.
> - To be clear that the data type for slave addresses are changed add =
a patch
>   that only changes the data type to phys_addr_t.
> - Fixed up commit messages.
>=20
> * Changes since v3
> - Folded in a fix from Robin to his patch.
> - Added a check to make sure dma_map_resource can not be used to map =
RAM as
>   pointed out by Robin. I use BUG_ON to enforce this. It might not be=
 the best
>   method but I saw no other good way since DMA_ERROR_CODE might not b=
e defined
>   on all platforms.
> - Added comment about that DTS changes will disable 2 DMA channels du=
e to a HW
>   (?) bug in the DMAC.
> - Dropped the use of dma_attrs, no longer needed.
> - Collected Acked-by and Reviewed-by from Laurent.
> - Various indentation fix ups.
>=20
> * Changes since v2
> - Drop patch to add dma_{map,unmap}_page_attrs.
> - Add dma_{map,unmap}_resource to handle the mapping without involvin=
g a
>   'struct page'. Thanks Laurent and Robin for pointing this out.
> - Use size instead of address to keep track of if a mapping exist or =
not
>   since addr =3D=3D 0 is valid. Thanks Laurent.
> - Pick up patch from Robin with Laurents ack (hope it's OK for me to
>   attach the ack?) to add IOMMU_MMIO.
> - Fix bug in rcar_dmac_device_config where the error check where
>   inverted.
> - Use DMA_BIDIRECTIONAL in rcar_dmac_device_config since we at that
>   point can't be sure what direction the mapping is going to be used.
>=20
> * Changes since v1
> - Add and use a dma_{map,unmap}_page_attrs to be able to map the page
>   using attributes DMA_ATTR_NO_KERNEL_MAPPING and
>   DMA_ATTR_SKIP_CPU_SYNC. Thanks Laurent.
> - Drop check if dmac is part of a iommu group or not, let the DMA
>   mapping api handle it.
> - Move slave configuration data around in rcar-dmac to avoid code
>   duplication.
> - Fix build issue reported by 'kbuild test robot' regarding phys_to_p=
age
>   not availability on some configurations.
> - Add DT information for r8a7791.
>=20
> * Changes since RFC
> - Switch to use the dma-mapping api instead of using the iommu_map()
>   directly. Turns out the dma-mapper is much smarter then me...
> - Dropped the patch to expose domain->ops->pgsize_bitmap from within =
the
>   iommu api.
> - Dropped the patch showing how I tested the RFC.
>=20
> Niklas S=F6derlund (6):
>   dma-mapping: add {map,unmap}_resource to dma_map_ops
>   dma-debug: add support for resource mappings
>   dma-mapping: add dma_{map,unmap}_resource
>   arm: dma-mapping: add {map,unmap}_resource for iommu ops
>   dmaengine: rcar-dmac: group slave configuration
>   dmaengine: rcar-dmac: add iommu support for slave transfers
>=20
>  Documentation/DMA-API.txt   |  22 +++++++--
>  arch/arm/mm/dma-mapping.c   |  63 ++++++++++++++++++++++++
>  drivers/dma/sh/rcar-dmac.c  | 116 ++++++++++++++++++++++++++++++++++=
+---------
>  include/linux/dma-debug.h   |  19 ++++++++
>  include/linux/dma-mapping.h |  42 ++++++++++++++++
>  lib/dma-debug.c             |  52 +++++++++++++++++++-
>  6 files changed, 285 insertions(+), 29 deletions(-)
>=20
> --=20
> 2.8.2
>=20

--=20
Regards,
Niklas S=F6derlund
