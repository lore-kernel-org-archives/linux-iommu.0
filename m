From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
	necessary
Date: Sun, 21 Apr 2019 09:17:16 +0800
Message-ID: <20190421011719.14909-8-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190421011719.14909-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The bouce page is necessary whenever there are untrusted
devices in the system. The bounce page policy depends on
swiotlb, hence don't turn off swiotlb if untrusted devices
exist.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af040602bd44..e4a164324bdd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4528,22 +4528,27 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
-static int __init platform_optin_force_iommu(void)
+static inline bool platform_has_untrusted_device(void)
 {
+	bool has_untrusted_device = false;
 	struct pci_dev *pdev = NULL;
-	bool has_untrusted_dev = false;
-
-	if (!dmar_platform_optin() || no_platform_optin)
-		return 0;
 
 	for_each_pci_dev(pdev) {
 		if (pdev->untrusted) {
-			has_untrusted_dev = true;
+			has_untrusted_device = true;
 			break;
 		}
 	}
 
-	if (!has_untrusted_dev)
+	return has_untrusted_device;
+}
+
+static int __init platform_optin_force_iommu(void)
+{
+	if (!dmar_platform_optin() || no_platform_optin)
+		return 0;
+
+	if (!platform_has_untrusted_device())
 		return 0;
 
 	if (no_iommu || dmar_disabled)
@@ -4557,9 +4562,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
 	dmar_disabled = 0;
-#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
-#endif
 	no_iommu = 0;
 
 	return 1;
@@ -4653,7 +4655,8 @@ int __init intel_iommu_init(void)
 	up_write(&dmar_global_lock);
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	swiotlb = 0;
+	if (!platform_has_untrusted_device())
+		swiotlb = 0;
 #endif
 	dma_ops = &intel_dma_ops;
 
-- 
2.17.1
