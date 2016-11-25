From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 12/12] iommu/amd: Allocate memory below 4G for dev table if
 translation pre-enabled
Date: Fri, 25 Nov 2016 13:13:19 +0800
Message-ID: <1480050799-1237-13-git-send-email-bhe@redhat.com>
References: <1480050799-1237-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1480050799-1237-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

AMD pointed out it's unsafe to update the device-table while iommu
is enabled. It turns out that device-table pointer update is split
up into two 32bit writes in the IOMMU hardware. So updating it while
the IOMMU is enabled could have some nasty side effects.

The only way to work around this is to allocate the device-table below
4GB if translation is pre-enabled in kdump kernel. If allocation failed,
still use the old one.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d362b63..f17f297 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2149,11 +2149,23 @@ static void early_enable_iommu(struct amd_iommu *iommu)
  */
 static void early_enable_iommus(void)
 {
+	struct dev_table_entry *dev_tbl;
 	struct amd_iommu *iommu;
 	bool is_pre_enabled = false;
 
 	for_each_iommu(iommu) {
 		if (translation_pre_enabled(iommu)) {
+			gfp_t gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;;
+
+			dev_tbl = (void *)__get_free_pages(gfp_flag,
+						get_order(dev_table_size));
+			if (dev_tbl != NULL) {
+				memcpy(dev_tbl, amd_iommu_dev_table, dev_table_size);
+				free_pages((unsigned long)amd_iommu_dev_table,
+						get_order(dev_table_size));
+				amd_iommu_dev_table = dev_tbl;
+			}
+
 			is_pre_enabled = true;
 			break;
 		}
-- 
2.5.5
