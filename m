From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/3] iommu/io-pgtable-arm-v7s: Support IOMMU_MMIO flag
Date: Tue,  5 Apr 2016 12:39:32 +0100
Message-ID: <0afc84da4755b08c5593cd2403365b6aaf189afc.1459854347.git.robin.murphy@arm.com>
References: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Teach the short-descriptor format to create Device mappings when asked.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9488e3c..de5865e 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -258,9 +258,10 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 					 struct io_pgtable_cfg *cfg)
 {
 	bool ap = !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS);
-	arm_v7s_iopte pte = ARM_V7S_ATTR_NG | ARM_V7S_ATTR_S |
-			    ARM_V7S_ATTR_TEX(1);
+	arm_v7s_iopte pte = ARM_V7S_ATTR_NG | ARM_V7S_ATTR_S;
 
+	if (!(prot & IOMMU_MMIO))
+		pte |= ARM_V7S_ATTR_TEX(1);
 	if (ap) {
 		pte |= ARM_V7S_PTE_AF | ARM_V7S_PTE_AP_UNPRIV;
 		if (!(prot & IOMMU_WRITE))
@@ -270,7 +271,9 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 
 	if ((prot & IOMMU_NOEXEC) && ap)
 		pte |= ARM_V7S_ATTR_XN(lvl);
-	if (prot & IOMMU_CACHE)
+	if (prot & IOMMU_MMIO)
+		pte |= ARM_V7S_ATTR_B;
+	else if (prot & IOMMU_CACHE)
 		pte |= ARM_V7S_ATTR_B | ARM_V7S_ATTR_C;
 
 	return pte;
@@ -279,10 +282,13 @@ static arm_v7s_iopte arm_v7s_prot_to_pte(int prot, int lvl,
 static int arm_v7s_pte_to_prot(arm_v7s_iopte pte, int lvl)
 {
 	int prot = IOMMU_READ;
+	arm_v7s_iopte attr = pte >> ARM_V7S_ATTR_SHIFT(lvl);
 
-	if (pte & (ARM_V7S_PTE_AP_RDONLY << ARM_V7S_ATTR_SHIFT(lvl)))
+	if (attr & ARM_V7S_PTE_AP_RDONLY)
 		prot |= IOMMU_WRITE;
-	if (pte & ARM_V7S_ATTR_C)
+	if ((attr & (ARM_V7S_TEX_MASK << ARM_V7S_TEX_SHIFT)) == 0)
+		prot |= IOMMU_MMIO;
+	else if (pte & ARM_V7S_ATTR_C)
 		prot |= IOMMU_CACHE;
 
 	return prot;
-- 
2.7.3.dirty
