From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
Date: Mon, 11 Feb 2019 14:35:46 +0100
Message-ID: <20190211133554.30055-5-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The OF_RESERVED_MEM can be used if we have either CMA or the generic
declare coherent code built and we support the early flattened DT.

So don't bother making it a user visible options that is selected
by most configs that fit the above category, but just select it when
the requirements are met.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig     | 1 -
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/csky/Kconfig    | 1 -
 arch/powerpc/Kconfig | 1 -
 arch/xtensa/Kconfig  | 1 -
 drivers/of/Kconfig   | 5 ++---
 7 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..4103f23b6cea 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -44,7 +44,6 @@ config ARC
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..9395f138301a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -101,7 +101,6 @@ config ARM
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select OF_EARLY_FLATTREE if OF
-	select OF_RESERVED_MEM if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PCI_SYSCALL if PCI
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..1d22e969bdcb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -163,7 +163,6 @@ config ARM64
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..0a9595afe9be 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,7 +42,6 @@ config CSKY
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC if CPU_CK610
 	select RTC_LIB
 	select TIMER_OF
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..5cc4eea362c6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -233,7 +233,6 @@ config PPC
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 20a0756f27ef..e242a405151e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -447,7 +447,6 @@ config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad4d75b..3607fd2810e4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -81,10 +81,9 @@ config OF_MDIO
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
 config OF_RESERVED_MEM
-	depends on OF_EARLY_FLATTREE
 	bool
-	help
-	  Helpers to allow for reservation of memory regions
+	depends on OF_EARLY_FLATTREE
+	default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
 
 config OF_RESOLVE
 	bool
-- 
2.20.1
