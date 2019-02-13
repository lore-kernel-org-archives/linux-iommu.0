From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: use generic DMA mapping code in powerpc V7
Date: Wed, 13 Feb 2019 08:01:01 +0100
Message-ID: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

this series switches the powerpc port to use the generic swiotlb and
noncoherent dma ops, and to use more generic code for the coherent
direct mapping, as well as removing a lot of dead code.

As this series is very large and depends on the dma-mapping tree I've
also published a git tree:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.7

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.7

Thanks a lot to Christian Zigotzky who spent a lot of time testing
iterations on pasemi and FSL boards!


Changes since v4:
 - rebased on top of the latests powerpc/next tree
 - fix the DART IOMMU bypass selection
 - remove the return value from arch_dma_set_mask, which was done
   incorrectly and isn't actually needed.
 - add a new patch to remove swiotlb_dma_supported
 - add a new patch to set a dma mask in the pasemi ethernet driver,
   given that we now validate it
 - add a new patch to fix a ZONE_DMA32 assumption in the dma-direct
   patch
 - split up a few patches to improve bisectability
 (v5 and v6 were never posted)

Changes since v3:
 - rebase on the powerpc fixes tree
 - add a new patch to actually make the baseline amigaone config
   configure without warnings
 - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
   always present
 - fix compile in mem.c for one configuration
 - drop the full npu removal for now, will be resent separately
 - a few git bisection fixes

The changes since v1 are to big to list and v2 was not posted in public.

 arch/powerpc/kernel/dma.c                       |  362 ------------------------
 b/arch/powerpc/Kconfig                          |    5 
 b/arch/powerpc/include/asm/device.h             |   10 
 b/arch/powerpc/include/asm/dma-direct.h         |   18 -
 b/arch/powerpc/include/asm/dma-mapping.h        |   92 ------
 b/arch/powerpc/include/asm/iommu.h              |   17 +
 b/arch/powerpc/include/asm/machdep.h            |    4 
 b/arch/powerpc/include/asm/pci-bridge.h         |    5 
 b/arch/powerpc/include/asm/pci.h                |    2 
 b/arch/powerpc/include/asm/pgtable.h            |    1 
 b/arch/powerpc/include/asm/swiotlb.h            |    5 
 b/arch/powerpc/kernel/Makefile                  |    3 
 b/arch/powerpc/kernel/dma-iommu.c               |   75 ++++
 b/arch/powerpc/kernel/dma-mask.c                |   12 
 b/arch/powerpc/kernel/dma-swiotlb.c             |   89 -----
 b/arch/powerpc/kernel/pci-common.c              |   10 
 b/arch/powerpc/kernel/setup-common.c            |    1 
 b/arch/powerpc/mm/dma-noncoherent.c             |   40 +-
 b/arch/powerpc/mm/mem.c                         |   22 -
 b/arch/powerpc/platforms/44x/ppc476.c           |    1 
 b/arch/powerpc/platforms/44x/warp.c             |    2 
 b/arch/powerpc/platforms/85xx/corenet_generic.c |    5 
 b/arch/powerpc/platforms/85xx/ge_imp3a.c        |    2 
 b/arch/powerpc/platforms/85xx/mpc8536_ds.c      |    2 
 b/arch/powerpc/platforms/85xx/mpc85xx_ds.c      |    4 
 b/arch/powerpc/platforms/85xx/mpc85xx_mds.c     |    4 
 b/arch/powerpc/platforms/85xx/p1010rdb.c        |    1 
 b/arch/powerpc/platforms/85xx/p1022_ds.c        |    2 
 b/arch/powerpc/platforms/85xx/p1022_rdk.c       |    2 
 b/arch/powerpc/platforms/85xx/qemu_e500.c       |    1 
 b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |    1 
 b/arch/powerpc/platforms/Kconfig.cputype        |    3 
 b/arch/powerpc/platforms/cell/iommu.c           |  172 +----------
 b/arch/powerpc/platforms/pasemi/iommu.c         |    2 
 b/arch/powerpc/platforms/pasemi/setup.c         |   51 ---
 b/arch/powerpc/platforms/powernv/npu-dma.c      |    2 
 b/arch/powerpc/platforms/powernv/pci-ioda.c     |  132 +-------
 b/arch/powerpc/platforms/pseries/iommu.c        |   99 +-----
 b/arch/powerpc/platforms/pseries/vio.c          |   95 ++----
 b/arch/powerpc/sysdev/dart_iommu.c              |   58 +--
 b/arch/powerpc/sysdev/fsl_pci.c                 |   25 -
 b/drivers/misc/cxl/vphb.c                       |    3 
 b/drivers/net/ethernet/pasemi/pasemi_mac.c      |    1 
 b/include/linux/swiotlb.h                       |    3 
 b/kernel/dma/Kconfig                            |    3 
 b/kernel/dma/direct.c                           |    3 
 b/kernel/dma/mapping.c                          |   11 
 b/kernel/dma/swiotlb.c                          |   12 
 48 files changed, 317 insertions(+), 1158 deletions(-)
