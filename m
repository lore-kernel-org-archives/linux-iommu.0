From: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 7/7] iommu/fsl: Added cache controller compatible strings for
	SOCs
Date: Mon, 7 Mar 2016 17:34:23 +0200
Message-ID: <1457364863-18004-8-git-send-email-codrin.ciubotariu@nxp.com>
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

Added cache controller compatible strings for T2080, B4420, T1040
and T1024. PAMU driver searches for a matching string while setting
up L3 cache stashing.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 290231a..47f54fe 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -63,12 +63,20 @@ static const struct of_device_id guts_device_ids[] = {
 /*
  * Table for matching compatible strings, for device tree
  * L3 cache controller node.
+ * "fsl,t1024-l3-cache-controller" corresponds to T1024,
+ * "fsl,t1040-l3-cache-controller" corresponds to T1040,
+ * "fsl,b4420-l3-cache-controller" corresponds to B4420,
+ * "fsl,t2080-l3-cache-controller" corresponds to T2080,
  * "fsl,t4240-l3-cache-controller" corresponds to T4,
  * "fsl,b4860-l3-cache-controller" corresponds to B4 &
  * "fsl,p4080-l3-cache-controller" corresponds to other,
  * SOCs.
  */
 static const struct of_device_id l3_device_ids[] = {
+	{ .compatible = "fsl,t1024-l3-cache-controller", },
+	{ .compatible = "fsl,t1040-l3-cache-controller", },
+	{ .compatible = "fsl,b4420-l3-cache-controller", },
+	{ .compatible = "fsl,t2080-l3-cache-controller", },
 	{ .compatible = "fsl,t4240-l3-cache-controller", },
 	{ .compatible = "fsl,b4860-l3-cache-controller", },
 	{ .compatible = "fsl,p4080-l3-cache-controller", },
@@ -647,6 +655,8 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 			of_node_put(node);
 			return be32_to_cpup(prop);
 		}
+		pr_err("%s: Failed to get L3 cache controller information\n",
+		       __func__);
 		return ~(u32)0;
 	}
 
-- 
1.9.3
