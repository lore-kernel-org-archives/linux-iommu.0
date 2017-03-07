From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 00/07] iommu/ipmmu-vmsa: IPMMU multi-arch update V7
Date: Tue, 07 Mar 2017 12:16:43 +0900
Message-ID: <148885660307.28553.995847796823338863.sendpatchset@little-apple>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: IPMMU multi-arch update V7

[PATCH v7 01/07] iommu/ipmmu-vmsa: Remove platform data handling
[PATCH v7 02/07] iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
[PATCH v7 03/07] iommu/ipmmu-vmsa: Break out utlb parsing code
[PATCH v7 04/07] iommu/ipmmu-vmsa: Break out domain allocation code
[PATCH v7 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
[PATCH v7 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
[PATCH v7 07/07] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency

These patches update the IPMMU driver with a couple of changes to support
build on multiple architectures. In the process of doing so the interrupt
code gets reworked, the foundation for supporting multiple contexts are
added and in case of CONFIG_IOMMU_DMA=y (on 64-bit or 32-bit ARM) devices
are grouped together and handled via ->xlate() - thanks Robin! Support for
existing 32-bit ARM SoCs from R-Car Gen2 is kept as-is.

Changes since V6:
 - Rebased on top of v4.11-rc1 and the following fast-tracked change:
   3b6bb5b iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to 32-bit address spac
 - Updated patch 5/7 to roll in a few patches from other series
   See individual patch for more details
 - Build tested on 32-bit and 64-bit ARM
 - Run time tested on 64-bit ARM (with additional SoC-specific patches)

Changes since V5:
 - Rebased series on top of next-20161019
 - Updated patch 5/7 to simplify domain allocation/free code - thanks Joerg!
 - Added reviewed-by tag from Joerg for patch 1-4 and 6-7.
 
Changes since V4:
 - Updated patch 3/7 to work on top on the following commit in next-20160920:
   b1e2afc iommu/ipmmu-vmsa: Fix wrong error handle of ipmmu_add_device
 - Add Kconfig hunk to patch 5/7 to avoid undeclared ipmmu_ops if COMPILE_TEST
 - Rebased patch 7/7 to fit on top of new Kconfig bits in 5/7

Changes since V3:
 - Updated patch 3/7 to fix hang-on-boot issue on 32-bit ARM - thanks Geert!
 - Reworked group parameter handling in patch 3/7 and 5/7.
 - Added patch 6/7 to fix build of the driver on s390/tile/um architectures

Changes since V2:
 - Got rid of patch 3 from the V2 however patch 1, 2 and 4 are kept.
 - V3 patch 3, 4 and 5 come from
   [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
 - Patch 5 has been reworked to include patch 3 of the V1 of this series 

Changes since V1:
 - Got rid of patch 2 and 3 from initial series
 - Updated bitmap code locking and also used lighter bitop functions
 - Updated the Kconfig bits to apply on top of ARCH_RENESAS

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Built on top v4.11-rc1:

 drivers/iommu/Kconfig      |    2 
 drivers/iommu/ipmmu-vmsa.c |  359 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 299 insertions(+), 62 deletions(-)
