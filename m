From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/12] iommu/amd: Set alias DTE in do_attach/do_detach
Date: Tue, 20 Oct 2015 17:33:38 +0200
Message-ID: <1445355225-17557-6-git-send-email-joro@8bytes.org>
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

With this we don't have to create dev_data entries for
non-existent devices (which only exist as request-ids).

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index d47c4b1..187a8bf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1114,11 +1114,15 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	u16 alias;
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	alias = amd_iommu_alias_table[dev_data->devid];
 
 	ret = iommu_flush_dte(iommu, dev_data->devid);
+	if (!ret && alias != dev_data->devid)
+		ret = iommu_flush_dte(iommu, alias);
 	if (ret)
 		return ret;
 
@@ -1984,27 +1988,33 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
+	u16 alias;
 	bool ats;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	alias = amd_iommu_alias_table[dev_data->devid];
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
-	set_dte_entry(dev_data->devid, domain, ats);
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Flush the DTE entry */
+	/* Update device table */
+	set_dte_entry(dev_data->devid, domain, ats);
+	if (alias != dev_data->devid)
+		set_dte_entry(dev_data->devid, domain, ats);
+
 	device_flush_dte(dev_data);
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	u16 alias;
 
 	/*
 	 * First check if the device is still attached. It might already
@@ -2016,6 +2026,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 		return;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	alias = amd_iommu_alias_table[dev_data->devid];
 
 	/* decrease reference counters */
 	dev_data->domain->dev_iommu[iommu->index] -= 1;
@@ -2025,6 +2036,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
+	if (alias != dev_data->devid)
+		clear_dte_entry(alias);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
-- 
1.9.1
