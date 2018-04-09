From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/4] iommu/tegra: gart: Add debugging facility
Date: Mon,  9 Apr 2018 23:07:19 +0300
Message-ID: <fe55521bc6fb1c576fb532dd7fb64ede4904beb7.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Page mapping could overwritten by an accident (a bug). We can catch this
case by checking 'VALID' bit of GART's page entry prior to mapping of a
page. Since that check introduces a small performance impact, it should be
enabled explicitly using new GART's kernel module 'debug' parameter.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index b62f790ad1ba..4c0abdcd1ad2 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -72,6 +72,8 @@ struct gart_domain {
 
 static struct gart_device *gart_handle; /* unique for a system */
 
+static bool gart_debug;
+
 #define GART_PTE(_pfn)						\
 	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
 
@@ -271,6 +273,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	struct gart_device *gart = gart_domain->gart;
 	unsigned long flags;
 	unsigned long pfn;
+	unsigned long pte;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return -EINVAL;
@@ -282,6 +285,14 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+	if (gart_debug) {
+		pte = gart_read_pte(gart, iova);
+		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
+			spin_unlock_irqrestore(&gart->pte_lock, flags);
+			dev_err(gart->dev, "Page entry is in-use\n");
+			return -EBUSY;
+		}
+	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
 	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
@@ -515,7 +526,9 @@ static void __exit tegra_gart_exit(void)
 
 subsys_initcall(tegra_gart_init);
 module_exit(tegra_gart_exit);
+module_param(gart_debug, bool, 0644);
 
+MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
 MODULE_ALIAS("platform:tegra-gart");
-- 
2.16.3
