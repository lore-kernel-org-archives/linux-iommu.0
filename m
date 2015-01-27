From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] iommu: Make sure a device is always attached to a domain
Date: Tue, 27 Jan 2015 01:08:58 +0100
Message-ID: <1422317339-22620-5-git-send-email-joro@8bytes.org>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422317339-22620-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make use of the default domain and re-attach a device to it
when it is detached from another domain. Also enforce that a
device has to be in the default domain before it can be
attached to a different domain.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b63a550..5080759 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -53,6 +53,7 @@ struct iommu_group {
 	int id;
 	unsigned dev_cnt;
 	struct iommu_domain *default_domain;
+	struct iommu_domain *domain;
 };
 
 struct iommu_device {
@@ -1040,8 +1041,17 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
-	return iommu_group_for_each_dev(group, domain,
-					iommu_group_do_attach_device);
+	int ret;
+
+	if (group->default_domain && group->domain != group->default_domain)
+		return -EBUSY;
+
+	ret = iommu_group_for_each_dev(group, domain,
+				       iommu_group_do_attach_device);
+	if (ret == 0)
+		group->domain = domain;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
@@ -1056,7 +1066,25 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
-	iommu_group_for_each_dev(group, domain, iommu_group_do_detach_device);
+	int ret;
+
+	if (!group->default_domain) {
+		iommu_group_for_each_dev(group, domain,
+					 iommu_group_do_detach_device);
+		group->domain = NULL;
+		return;
+	}
+
+	if (group->domain == group->default_domain)
+		return;
+
+	/* Detach by re-attaching to the default domain */
+	ret = iommu_group_for_each_dev(group, group->default_domain,
+				       iommu_group_do_attach_device);
+	if (ret != 0)
+		WARN_ON(1);
+	else
+		group->domain = group->default_domain;
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
-- 
1.9.1
