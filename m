From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/12] iommu/amd: WARN when __[attach|detach]_device are
	called with irqs enabled
Date: Tue, 20 Oct 2015 17:33:37 +0200
Message-ID: <1445355225-17557-5-git-send-email-joro@8bytes.org>
References: <1445355225-17557-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445355225-17557-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

These functions rely on being called with IRQs disabled. Add
a WARN_ON to detect early when its not.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 54e0862..d47c4b1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2039,6 +2039,12 @@ static int __attach_device(struct iommu_dev_data *dev_data,
 {
 	int ret;
 
+	/*
+	 * Must be called with IRQs disabled. Warn here to detect early
+	 * when its not.
+	 */
+	WARN_ON(!irqs_disabled());
+
 	/* lock domain */
 	spin_lock(&domain->lock);
 
@@ -2199,6 +2205,12 @@ static void __detach_device(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain;
 
+	/*
+	 * Must be called with IRQs disabled. Warn here to detect early
+	 * when its not.
+	 */
+	WARN_ON(!irqs_disabled());
+
 	if (WARN_ON(!dev_data->domain))
 		return;
 
-- 
1.9.1
