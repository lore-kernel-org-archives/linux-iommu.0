From: Joerg Roede <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/vt-d: Make sure RMRRs are mapped before domain goes
	public
Date: Mon,  5 Sep 2016 13:02:30 +0200
Message-ID: <1473073350-13591-2-git-send-email-joro@8bytes.org>
References: <1473073350-13591-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1473073350-13591-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

When a domain is allocated through the get_valid_domain_for_dev
path, it will be context-mapped before the RMRR regions are
mapped in the page-table. This opens a short time window
where device-accesses to these regions fail and causing DMAR
faults.

Fix this by mapping the RMRR regions before the domain is
context-mapped.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bcdbe9d..a4407ea 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3428,17 +3428,18 @@ static unsigned long intel_alloc_iova(struct device *dev,
 
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
+	struct dmar_domain *domain, *tmp;
 	struct dmar_rmrr_unit *rmrr;
-	struct dmar_domain *domain;
 	struct device *i_dev;
 	int i, ret;
 
-	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain) {
-		pr_err("Allocating domain for %s failed\n",
-		       dev_name(dev));
-		return NULL;
-	}
+	domain = find_domain(dev);
+	if (domain)
+		goto out;
+
+	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	if (!domain)
+		goto out;
 
 	/* We have a new domain - setup possible RMRRs for the device */
 	rcu_read_lock();
@@ -3457,6 +3458,18 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 	}
 	rcu_read_unlock();
 
+	tmp = set_domain_for_dev(dev, domain);
+	if (!tmp || domain != tmp) {
+		domain_exit(domain);
+		domain = tmp;
+	}
+
+out:
+
+	if (!domain)
+		pr_err("Allocating domain for %s failed\n", dev_name(dev));
+
+
 	return domain;
 }
 
-- 
2.6.6
