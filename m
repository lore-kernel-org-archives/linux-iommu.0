From: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 3/7] iommu/fsl: Enable OMT cache,
	before invalidating PAACT and SPAACT cache
Date: Mon, 7 Mar 2016 17:34:19 +0200
Message-ID: <1457364863-18004-4-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Enable OMT cache, before invalidating PAACT and SPAACT cache. This
is a PAMU hardware errata work around.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a00c473..ce25084 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -731,6 +731,16 @@ static int setup_one_pamu(unsigned long pamu_reg_base,
 	pamu_regs = (struct pamu_mmap_regs *)
 		(pamu_reg_base + PAMU_MMAP_REGS_BASE);
 
+	/*
+	 * As per PAMU errata A-005982, writing the PAACT and SPAACT
+	 * base address registers wouldn't invalidate the corresponding
+	 * caches if the OMT cache is disabled. The workaround is to
+	 * enable the OMT cache before setting the base registers.
+	 * This can be done without actually enabling PAMU.
+	 */
+
+	out_be32(pc, PAMU_PC_OCE);
+
 	/* set up pointers to corenet control blocks */
 
 	out_be32(&pamu_regs->ppbah, upper_32_bits(ppaact_phys));
-- 
1.9.3
