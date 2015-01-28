From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH v2 01/26] iommu/fsl: Sprinkle some __init* annotations
Date: Wed, 28 Jan 2015 08:34:33 -0600
Message-ID: <1422455698-3074-2-git-send-email-Emilian.Medve@Freescale.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
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
 drivers/iommu/fsl_pamu.c        | 12 ++++++------
 drivers/iommu/fsl_pamu_domain.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index d958e65..652c34d 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -50,7 +50,7 @@ struct pamu_isr_data {
 
 static struct paace *ppaact;
 static struct paace *spaact;
-static struct ome *omt;
+static struct ome *omt __initdata;
 
 /*
  * Table for matching compatible strings, for device tree
@@ -59,7 +59,7 @@ static struct ome *omt;
  * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
  * string would be used.
 */
-static const struct of_device_id guts_device_ids[] = {
+static const struct of_device_id guts_device_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-device-config-1.0", },
 	{ .compatible = "fsl,qoriq-device-config-2.0", },
 	{}
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
 
@@ -689,7 +689,7 @@ static void get_pamu_cap_values(unsigned long pamu_reg_base)
 }
 
 /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */
-int setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu_reg_size,
+static int __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long pamu_reg_size,
 	           phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
 		   phys_addr_t omt_phys)
 {
@@ -998,7 +998,7 @@ error:
 static const struct {
 	u32 svr;
 	u32 port_id;
-} port_id_map[] = {
+} port_id_map[] __initconst = {
 	{0x82100010, 0xFF000000},	/* P2040 1.0 */
 	{0x82100011, 0xFF000000},	/* P2040 1.1 */
 	{0x82100110, 0xFF000000},	/* P2041 1.0 */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index c828f80..48a72b3 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1095,7 +1095,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.remove_device	= fsl_pamu_remove_device,
 };
 
-int pamu_domain_init(void)
+int __init pamu_domain_init(void)
 {
 	int ret = 0;
 
-- 
2.2.2
