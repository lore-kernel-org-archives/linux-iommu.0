From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu-groups: Add list_head for iommu groups
Date: Fri, 4 Apr 2014 11:12:37 +0530
Message-ID: <CAD15agaN=ymK8JTPELNygF055r3zPyqmJ7bMVabL7pM8EusHjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi All,

Please find the below patch and let me know your suggestions on this.

With this patch iommu groups can be linked and iommu driver will
get to know which all iommu groups belongs to a particular iommu device.



Each iommu device might have multiple iommu groups,
with each group populated with many devices. With
this configuration, iommu driver may require a list
of iommu groups belonging to each iommu device.

Add list_head struct entry in iommu_group.

Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e5555fc..70588dc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -36,6 +36,10 @@ static struct ida iommu_group_ida;
 static struct mutex iommu_group_mutex;

 struct iommu_group {
+       struct list_head list;  /* lower level iommu driver structure
+                                * may require list of iommu groups
+                                * belonging to that iommu device.
+                                */
        struct kobject kobj;
        struct kobject *devices_kobj;
        struct list_head devices;
--
1.8.1.3
