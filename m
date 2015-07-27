From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH char-misc-next 10/19] lib: convert iova.c into a library
Date: Mon, 27 Jul 2015 16:57:32 -0700
Message-ID: <8131ebc8ecb5ef13ef0aa4c49dabe9694f0e410f.1438040669.git.ashutosh.dixit@intel.com>
References: <cover.1438040669.git.ashutosh.dixit@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438040669.git.ashutosh.dixit@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Robin Murphy <robin.murphy@arm.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Nikhil Rao <nikhil.rao@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Harish Chegondi <harish.chegondi@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Harish Chegondi <harish.chegondi@intel.com>

This patch converts iova.c into a library, moving it from
drivers/iommu/ to lib/, and exports its virtual address allocation and
management functions so that other modules can reuse them.

Cc: Joerg Roedel <joro@8bytes.org>
Reviewed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>
Signed-off-by: Harish Chegondi <harish.chegondi@intel.com>
---
 drivers/iommu/Kconfig         | 5 +----
 drivers/iommu/Makefile        | 1 -
 lib/Kconfig                   | 6 ++++++
 lib/Makefile                  | 2 ++
 {drivers/iommu => lib}/iova.c | 9 +++++++++
 5 files changed, 18 insertions(+), 5 deletions(-)
 rename {drivers/iommu => lib}/iova.c (97%)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f1fb1d3..c711889 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -41,9 +41,6 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 endmenu
 
-config IOMMU_IOVA
-	bool
-
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
@@ -125,8 +122,8 @@ config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
 	select IOMMU_API
-	select IOMMU_IOVA
 	select DMAR_TABLE
+	select IOVA
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6dcc51..fbb1372 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
-obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
diff --git a/lib/Kconfig b/lib/Kconfig
index 3a2ef67..62ba145 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -62,6 +62,12 @@ config ARCH_USE_CMPXCHG_LOCKREF
 config ARCH_HAS_FAST_MULTIPLIER
 	bool
 
+config IOVA
+	bool
+	help
+	  This option enables a 64 bit virtual address allocation and management
+	  library.
+
 config CRC_CCITT
 	tristate "CRC-CCITT functions"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 6897b52..058722d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -205,3 +205,5 @@ quiet_cmd_build_OID_registry = GEN     $@
 clean-files	+= oid_registry_data.c
 
 obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
+
+obj-$(CONFIG_IOVA) += iova.o
diff --git a/drivers/iommu/iova.c b/lib/iova.c
similarity index 97%
rename from drivers/iommu/iova.c
rename to lib/iova.c
index b7c3d92..7753006 100644
--- a/drivers/iommu/iova.c
+++ b/lib/iova.c
@@ -72,6 +72,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
+EXPORT_SYMBOL_GPL(init_iova_domain);
 
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
@@ -281,6 +282,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova;
 }
+EXPORT_SYMBOL_GPL(alloc_iova);
 
 /**
  * find_iova - find's an iova for a given pfn
@@ -321,6 +323,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_iova);
 
 /**
  * __free_iova - frees the given iova
@@ -339,6 +342,7 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	free_iova_mem(iova);
 }
+EXPORT_SYMBOL_GPL(__free_iova);
 
 /**
  * free_iova - finds and frees the iova for a given pfn
@@ -356,6 +360,7 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 		__free_iova(iovad, iova);
 
 }
+EXPORT_SYMBOL_GPL(free_iova);
 
 /**
  * put_iova_domain - destroys the iova doamin
@@ -378,6 +383,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	}
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(put_iova_domain);
 
 static int
 __is_range_overlap(struct rb_node *node,
@@ -467,6 +473,7 @@ finish:
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return iova;
 }
+EXPORT_SYMBOL_GPL(reserve_iova);
 
 /**
  * copy_reserved_iova - copies the reserved between domains
@@ -493,6 +500,7 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 	}
 	spin_unlock_irqrestore(&from->iova_rbtree_lock, flags);
 }
+EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
 struct iova *
 split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
@@ -534,3 +542,4 @@ error:
 		free_iova_mem(prev);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(split_and_remove_iova);
-- 
2.0.0.rc3.2.g998f840
