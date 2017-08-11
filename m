From: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Fri, 11 Aug 2017 19:11:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1708111909480.1769@schleppi>
References: <1502274354-643-1-git-send-email-joro@8bytes.org>
	<alpine.LFD.2.20.1708102104390.4919@schleppi>
	<20170811073118.GF30515@8bytes.org>
	<alpine.LFD.2.20.1708111844340.1769@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.20.1708111844340.1769@schleppi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 11 Aug 2017, Sebastian Ott wrote:
> * iommu_release_device must not release the struct device but the
> structure it is embedded in: struct iommu_device (I'll send a patch
> for that)

--->8

>From 2839c92e038af47b8cb569f84d571878c54d1815 Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Date: Fri, 11 Aug 2017 19:04:00 +0200
Subject: [PATCH] iommu: fix the release function of iommu_class

The release function of iommu_class must not only free the device
structure it gets called with but the whole structure the device
is embedded in - struct iommu_device.

Signed-off-by: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 drivers/iommu/iommu-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index c58351e..b65a501 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -34,7 +34,9 @@ static const struct attribute_group *iommu_dev_groups[] = {
 
 static void iommu_release_device(struct device *dev)
 {
-	kfree(dev);
+	struct iommu_device *iommu = container_of(dev, struct iommu_device, dev);
+
+	kfree(iommu);
 }
 
 static struct class iommu_class = {
-- 
2.5.5
