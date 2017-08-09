From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu/pamu: WARN when fsl_pamu_probe() is called more
	than once
Date: Wed,  9 Aug 2017 16:46:53 +0200
Message-ID: <1502290014-2890-4-git-send-email-joro@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502290014-2890-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The function probes the PAMU hardware from device-tree
specifications. It initializes global variables and can thus
be only safely called once.

Add a check that that prints a warning when its called more
than once.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a34355f..9ee8e9e 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -42,6 +42,8 @@ struct pamu_isr_data {
 static struct paace *ppaact;
 static struct paace *spaact;
 
+static bool probed;			/* Has PAMU been probed? */
+
 /*
  * Table for matching compatible strings, for device tree
  * guts node, for QorIQ SOCs.
@@ -1033,6 +1035,9 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	 * NOTE : All PAMUs share the same LIODN tables.
 	 */
 
+	if (WARN_ON(probed))
+		return -EBUSY;
+
 	pamu_regs = of_iomap(dev->of_node, 0);
 	if (!pamu_regs) {
 		dev_err(dev, "ioremap of PAMU node failed\n");
@@ -1172,6 +1177,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 
 	setup_liodns();
 
+	probed = true;
+
 	return 0;
 
 error_genpool:
-- 
2.7.4
