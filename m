From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 5/6] powernv/iommu: use common boot option iommu.dma_mode
Date: Sun, 7 Apr 2019 20:41:46 +0800
Message-ID: <20190407124147.13576-6-thunder.leizhen__16790.164557618$1554643671$gmane$org@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190407124147.13576-1-thunder.leizhen@huawei.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@>
Cc: Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

iommu=nobypass can be replaced with iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 --
 arch/powerpc/platforms/powernv/pci-ioda.c       | 23 +----------------------
 drivers/iommu/Kconfig                           |  1 +
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a2df11945b33fc9..f88a8bff3c0caa0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1789,8 +1789,6 @@
 		soft
 		pt		[x86]
 		nopt		[x86]
-		nobypass	[PPC/POWERNV]
-			Disable IOMMU bypass, using IOMMU for PCI devices.
 
 
 	iommu.dma_mode= [ARM64] Configure default dma mode. if unset, use the
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3ead4c237ed0ec9..be0234c170316bc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -85,29 +85,8 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	va_end(args);
 }
 
-static bool pnv_iommu_bypass_disabled __read_mostly;
 static bool pci_reset_phbs __read_mostly;
 
-static int __init iommu_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	while (*str) {
-		if (!strncmp(str, "nobypass", 8)) {
-			pnv_iommu_bypass_disabled = true;
-			pr_info("PowerNV: IOMMU bypass window disabled.\n");
-			break;
-		}
-		str += strcspn(str, ",");
-		if (*str == ',')
-			str++;
-	}
-
-	return 0;
-}
-early_param("iommu", iommu_setup);
-
 static int __init pci_reset_phbs_setup(char *str)
 {
 	pci_reset_phbs = true;
@@ -2456,7 +2435,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 		return rc;
 	}
 
-	if (!pnv_iommu_bypass_disabled)
+	if (IOMMU_DMA_MODE_IS_PASSTHROUGH())
 		pnv_pci_ioda2_set_bypass(pe, true);
 
 	return 0;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d88dc44d60d88ea..b053eeaa82ebca8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,6 +77,7 @@ config IOMMU_DEBUGFS
 choice
 	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DMA_MODE_PASSTHROUGH if (PPC_POWERNV && PCI)
 	default IOMMU_DMA_MODE_LAZY if S390_IOMMU
 	default IOMMU_DMA_MODE_STRICT
 	help
-- 
1.8.3
