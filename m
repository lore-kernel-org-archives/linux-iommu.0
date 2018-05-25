From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 11/25] MIPS: Octeon: move swiotlb declarations out of
	dma-coherence.h
Date: Fri, 25 May 2018 11:20:57 +0200
Message-ID: <20180525092111.18516-12-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180525092111.18516-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

No need to pull them into a global header.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 .../asm/mach-cavium-octeon/dma-coherence.h     | 18 ------------------
 arch/mips/include/asm/octeon/pci-octeon.h      |  3 +++
 arch/mips/pci/pci-octeon.c                     |  2 --
 arch/mips/pci/pcie-octeon.c                    |  2 --
 4 files changed, 3 insertions(+), 22 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
deleted file mode 100644
index 66eee98b8b8d..000000000000
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2006  Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
- */
-#ifndef __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
-#define __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H
-
-#include <linux/bug.h>
-
-struct device;
-
-extern void octeon_pci_dma_init(void);
-extern char *octeon_swiotlb;
-
-#endif /* __ASM_MACH_CAVIUM_OCTEON_DMA_COHERENCE_H */
diff --git a/arch/mips/include/asm/octeon/pci-octeon.h b/arch/mips/include/asm/octeon/pci-octeon.h
index 1884609741a8..b12d9a3fbfb6 100644
--- a/arch/mips/include/asm/octeon/pci-octeon.h
+++ b/arch/mips/include/asm/octeon/pci-octeon.h
@@ -63,4 +63,7 @@ enum octeon_dma_bar_type {
  */
 extern enum octeon_dma_bar_type octeon_dma_bar_type;
 
+void octeon_pci_dma_init(void);
+extern char *octeon_swiotlb;
+
 #endif
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index a20697df3539..5017d5843c5a 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -21,8 +21,6 @@
 #include <asm/octeon/cvmx-pci-defs.h>
 #include <asm/octeon/pci-octeon.h>
 
-#include <dma-coherence.h>
-
 #define USE_OCTEON_INTERNAL_ARBITER
 
 /*
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 87ba86bd8696..9cc5905860ef 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -94,8 +94,6 @@ union cvmx_pcie_address {
 
 static int cvmx_pcie_rc_initialize(int pcie_port);
 
-#include <dma-coherence.h>
-
 /**
  * Return the Core virtual base address for PCIe IO access. IOs are
  * read/written as an offset from this address.
-- 
2.17.0
