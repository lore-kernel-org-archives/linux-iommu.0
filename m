From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/7] iommu: Change iommu driver to call remove_device_to_group
	trace event
Date: Thu, 15 Aug 2013 11:59:25 -0600
Message-ID: <53a8cce889b9620d26521d6a1170b98586b81577.1376587770.git.shuah.kh@samsung.com>
References: <cover.1376587770.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
References: <cover.1376587770.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Change iommu driver to call remove_device_to_group trace event. This
iommu_group class event can be enabled to trigger when devices get
removed from an iommu group. Trace information includes iommu group id and
device name.

Testing:
Added trace calls to iommu_prepare_identity_map() for testing some of the
conditions that are hard to trigger. Here is the trace from the testing:

       swapper/0-1     [003] ....     1.854101: remove_device_from_group: IOMMU: groupID=0 device=0000:00:02.0

Signed-off-by: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/iommu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 349c92d..278055b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -402,6 +402,8 @@ void iommu_group_remove_device(struct device *dev)
 	sysfs_remove_link(group->devices_kobj, device->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
+	trace_remove_device_from_group(group->id, dev);
+
 	kfree(device->name);
 	kfree(device);
 	dev->iommu_group = NULL;
-- 
1.7.10.4
