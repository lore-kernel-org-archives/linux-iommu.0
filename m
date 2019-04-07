From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 5/6] powernv/iommu: use common boot option iommu.dma_mode
Date: Sun, 7 Apr 2019 20:41:46 +0800
Message-ID: <20190407124147.13576-6-thunder.leizhen__4173.11703074432$1554641328$gmane$org@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190407124147.13576-1-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Ott <sebott-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael
	Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel@>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

iommu=nobypass can be replaced with iommu.dma_mode=strict.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
