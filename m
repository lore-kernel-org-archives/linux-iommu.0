From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 10/12] iommu/amd: Clear out the GV flag when handle
	deferred domain attach
Date: Fri, 25 Nov 2016 13:13:17 +0800
Message-ID: <1480050799-1237-11-git-send-email-bhe@redhat.com>
References: <1480050799-1237-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1480050799-1237-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When handle deferred domain attach, we need check if the domain is
v2. If not, should try to clear out the GV flag which could be
copied from the old device table entry.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 22520f6..3a8e4ae 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1839,6 +1839,11 @@ static void clear_dte_entry(u16 devid)
 	amd_iommu_apply_erratum_63(devid);
 }
 
+static void clear_dte_flag_gv(u16 devid)
+{
+	amd_iommu_dev_table[devid].data[0] &= (~DTE_FLAG_GV);
+}
+
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
@@ -2299,6 +2304,7 @@ static void queue_add(struct dma_ops_domain *dma_dom,
  */
 static struct protection_domain *get_domain(struct device *dev)
 {
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
 	struct protection_domain *domain;
 	struct iommu_domain *io_domain;
 
@@ -2306,11 +2312,21 @@ static struct protection_domain *get_domain(struct device *dev)
 		return ERR_PTR(-EINVAL);
 
 	domain = get_dev_data(dev)->domain;
-	if (domain == NULL && get_dev_data(dev)->defer_attach) {
+	if (domain == NULL && dev_data->defer_attach) {
+		u16 alias = amd_iommu_alias_table[dev_data->devid];
 		get_dev_data(dev)->defer_attach = false;
 		io_domain = iommu_get_domain_for_dev(dev);
 		domain = to_pdomain(io_domain);
 		attach_device(dev, domain);
+		/*
+		 * If the deferred attached domain is not v2, should clear out
+		 * the old GV flag.
+		 */
+		if (!(domain->flags & PD_IOMMUV2_MASK)) {
+			clear_dte_flag_gv(dev_data->devid);
+			if (alias != dev_data->devid)
+				clear_dte_flag_gv(dev_data->devid);
+		}
 	}
 	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
-- 
2.5.5
