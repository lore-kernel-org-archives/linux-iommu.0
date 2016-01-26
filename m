From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v3 09/12] iommu/amd: Don't update the domain information to
	iommu dev before dev init
Date: Tue, 26 Jan 2016 18:29:23 +0800
Message-ID: <1453804166-25646-10-git-send-email-bhe@redhat.com>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Don't update the domain information to the related DTE entry before
iommu dev initialization. For this a new member 'domain_updated' is
added to iommu_dev_data.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c0b96e0..b6e669c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -101,6 +101,7 @@ struct iommu_dev_data {
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
 	u32 errata;			  /* Bitmap for errata to apply */
+	bool domain_updated;
 };
 
 /*
@@ -2046,12 +2047,14 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Update device table */
-	set_dte_entry(dev_data->devid, domain, ats);
-	if (alias != dev_data->devid)
+	if (!translation_pre_enabled() || dev_data->domain_updated) {
+		/* Update device table */
 		set_dte_entry(dev_data->devid, domain, ats);
+		if (alias != dev_data->devid)
+			set_dte_entry(dev_data->devid, domain, ats);
 
-	device_flush_dte(dev_data);
+		device_flush_dte(dev_data);
+	}
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -2402,7 +2405,8 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list)
-		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
+		if (!translation_pre_enabled() || dev_data->domain_updated)
+			set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
 }
 
 static void update_domain(struct protection_domain *domain)
-- 
2.1.0
