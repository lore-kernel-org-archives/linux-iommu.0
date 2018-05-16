From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 1/3] riscv: simplify Kconfig magic for 32-bit vs 64-bit kernels
Date: Wed, 16 May 2018 16:43:00 +0200
Message-ID: <20180516144302.823-2-hch@lst.de>
References: <20180516144302.823-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180516144302.823-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org
Cc: linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We can deduct this directly using a select from ARCH_RV32I/ARCH_RV64I.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/riscv/Kconfig | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c27bac1d4f65..7817bbe0cfac 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -3,6 +3,12 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+config 64BIT
+	bool
+
+config 32BIT
+	bool
+
 config RISCV
 	def_bool y
 	# even on 32-bit, physical (and DMA) addresses are > 32-bits
@@ -95,7 +101,6 @@ choice
 
 config ARCH_RV32I
 	bool "RV32I"
-	select CPU_SUPPORTS_32BIT_KERNEL
 	select 32BIT
 	select GENERIC_ASHLDI3
 	select GENERIC_ASHRDI3
@@ -103,7 +108,6 @@ config ARCH_RV32I
 
 config ARCH_RV64I
 	bool "RV64I"
-	select CPU_SUPPORTS_64BIT_KERNEL
 	select 64BIT
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
@@ -165,11 +169,6 @@ config NR_CPUS
 	depends on SMP
 	default "8"
 
-config CPU_SUPPORTS_32BIT_KERNEL
-	bool
-config CPU_SUPPORTS_64BIT_KERNEL
-	bool
-
 choice
 	prompt "CPU Tuning"
 	default TUNE_GENERIC
@@ -196,24 +195,6 @@ endmenu
 
 menu "Kernel type"
 
-choice
-	prompt "Kernel code model"
-	default 64BIT
-
-config 32BIT
-	bool "32-bit kernel"
-	depends on CPU_SUPPORTS_32BIT_KERNEL
-	help
-	  Select this option to build a 32-bit kernel.
-
-config 64BIT
-	bool "64-bit kernel"
-	depends on CPU_SUPPORTS_64BIT_KERNEL
-	help
-	  Select this option to build a 64-bit kernel.
-
-endchoice
-
 source "mm/Kconfig"
 
 source "kernel/Kconfig.preempt"
-- 
2.17.0
