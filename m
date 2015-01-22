From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/3] iommu/fsl: Sprinkle some __init* annotations
Date: Thu, 22 Jan 2015 08:47:22 -0600
Message-ID: <1421938042-22580-3-git-send-email-Emilian.Medve@Freescale.com>
References: <1421938042-22580-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421938042-22580-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org
Cc: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 113fb7b..db9c1eb 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -59,7 +59,7 @@ static struct ome *omt;
  * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
  * string would be used.
 */
-static const struct of_device_id guts_device_ids[] = {
+static const struct of_device_id guts_device_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-device-config-1.0", },
 	{ .compatible = "fsl,qoriq-device-config-2.0", },
 	{}
@@ -187,7 +187,7 @@ static unsigned int map_subwindow_cnt_to_wce(u32 subwindow_cnt)
  * Set the PAACE type as primary and set the coherency required domain
  * attribute
  */
-static void pamu_init_ppaace(struct paace *ppaace)
+static void __init pamu_init_ppaace(struct paace *ppaace)
 {
 	set_bf(ppaace->addr_bitfields, PAACE_AF_PT, PAACE_PT_PRIMARY);
 
@@ -612,7 +612,7 @@ found_cpu_node:
  * Memory accesses to QMAN and BMAN private memory need not be coherent, so
  * clear the PAACE entry coherency attribute for them.
  */
-static void setup_qbman_paace(struct paace *ppaace, int  paace_type)
+static void __init setup_qbman_paace(struct paace *ppaace, int  paace_type)
 {
 	switch (paace_type) {
 	case QMAN_PAACE:
@@ -679,7 +679,7 @@ static void __init setup_omt(struct ome *omt)
  * Get the maximum number of PAACT table entries
  * and subwindows supported by PAMU
  */
-static void get_pamu_cap_values(unsigned long pamu_reg_base)
+static void __init get_pamu_cap_values(unsigned long pamu_reg_base)
 {
 	u32 pc_val;
 
@@ -998,7 +998,7 @@ error:
 static const struct {
 	u32 svr;
 	u32 port_id;
-} port_id_map[] = {
+} port_id_map[] __initconst = {
 	{0x82100010, 0xFF000000},	/* P2040 1.0 */
 	{0x82100011, 0xFF000000},	/* P2040 1.1 */
 	{0x82100110, 0xFF000000},	/* P2041 1.0 */
-- 
2.2.2
