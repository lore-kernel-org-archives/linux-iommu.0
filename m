From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/vt-d: Create RMRR mappings in newly allocated
	domains
Date: Thu,  1 Oct 2015 16:34:34 +0200
Message-ID: <1443710074-29701-3-git-send-email-joro@8bytes.org>
References: <1443710074-29701-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443710074-29701-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Currently the RMRR entries are created only at boot time.
This means they will vanish when the domain allocated at
boot time is destroyed.
This patch makes sure that also newly allocated domains will
get RMRR mappings.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e182d81..e9ace17 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3243,7 +3243,10 @@ static struct iova *intel_alloc_iova(struct device *dev,
 
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
+	struct dmar_rmrr_unit *rmrr;
 	struct dmar_domain *domain;
+	struct device *i_dev;
+	int i, ret;
 
 	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain) {
@@ -3252,6 +3255,23 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
+	/* We have a new domain - setup possible RMRRs for the device */
+	rcu_read_lock();
+	for_each_rmrr_units(rmrr) {
+		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
+					  i, i_dev) {
+			if (i_dev != dev)
+				continue;
+
+			ret = domain_prepare_identity_map(dev, domain,
+							  rmrr->base_address,
+							  rmrr->end_address);
+			if (ret)
+				dev_err(dev, "Mapping reserved region failed\n");
+		}
+	}
+	rcu_read_unlock();
+
 	return domain;
 }
 
-- 
1.9.1
