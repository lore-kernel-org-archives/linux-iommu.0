From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 6/9] iommu/amd: Don't update domain info to dte entry at
	iommu init stage
Date: Thu, 20 Oct 2016 19:37:17 +0800
Message-ID: <1476963440-23039-7-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

AMD iommu creates protection domain and assign each device to it during
iommu driver initialization stage. This happened just after system pci
bus scanning stage, and much earlier than device driver init stage. So
at this time if in kdump kernel the domain info, especially pte_root,
can't be updated to dte entry. We should wait until device driver init
stage.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d5aef72..aa78506 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -138,6 +138,7 @@ struct iommu_dev_data {
 					     PPR completions */
 	u32 errata;			  /* Bitmap for errata to apply */
 	bool use_vapic;			  /* Enable device to use vapic mode */
+	bool domain_updated;
 };
 
 /*
@@ -1799,6 +1800,15 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	dev_data = find_dev_data(devid);
+	if (!dev_data)
+		return;
+
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
+		return;
 
 	if (domain->mode != PAGE_MODE_NONE)
 		pte_root = virt_to_phys(domain->pt_root);
@@ -1847,6 +1857,14 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 
 static void clear_dte_entry(u16 devid)
 {
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	dev_data = find_dev_data(devid);
+	if (!dev_data)
+		return;
+	if (translation_pre_enabled(iommu) && !dev_data->domain_updated)
+		return;
 	/* remove entry from the device table seen by the hardware */
 	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
-- 
2.5.5
