From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] iommu/vt-d: Make sure si_domain is allocated for kdump
	kernel
Date: Thu, 11 Jun 2015 15:47:43 +0200
Message-ID: <1434030463-942-5-git-send-email-joro@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434030463-942-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The si_domain needs to be allocated in the kdump kernel too.
Otherwise the iommu=pt case breaks with a panic of the kdump
kernel.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fcb9310..e5af94a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2781,10 +2781,6 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 	int i;
 	int ret = 0;
 
-	ret = si_domain_init(hw);
-	if (ret)
-		return -EFAULT;
-
 	for_each_pci_dev(pdev) {
 		ret = dev_prepare_static_identity_mapping(&pdev->dev, hw);
 		if (ret)
@@ -2798,7 +2794,7 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 
 			if (dev->bus != &acpi_bus_type)
 				continue;
-				
+
 			adev= to_acpi_device(dev);
 			mutex_lock(&adev->physical_node_lock);
 			list_for_each_entry(pn, &adev->physical_node_list, node) {
@@ -2979,9 +2975,20 @@ static int __init init_dmars(void)
 	check_tylersburg_isoch();
 
 	/*
-	 * In the second kernel: Skip setting-up new domains for
-	 * si, rmrr, and the isa bus on the expectation that these
-	 * translations were copied from the old kernel.
+	 * Make sure the si_domain is allocated in the case we are in a
+	 * kdump kernel.
+	 */
+	if (iommu_identity_mapping) {
+		ret = si_domain_init(hw_pass_through);
+		if (ret)
+			goto free_iommu;
+	}
+
+	/*
+	 * In the second kernel: Skip setting-up new domains for rmrr
+	 * and the isa bus, they will be allocated and assigned on the
+	 * first DMA-API call. This is to keep the old mappings alive
+	 * until the device driver of the kdump kernel takes over.
 	 */
 	if (g_translation_pre_enabled)
 		goto skip_new_domains_for_si_rmrr_isa;
-- 
1.9.1
