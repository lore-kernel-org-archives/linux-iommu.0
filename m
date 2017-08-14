From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Mon, 14 Aug 2017 18:24:34 +0200
Message-ID: <20170814162434.GF2853@suse.de>
References: <1502274354-643-1-git-send-email-joro@8bytes.org>
	<alpine.LFD.2.20.1708102104390.4919@schleppi>
	<20170811073118.GF30515@8bytes.org>
	<alpine.LFD.2.20.1708111844340.1769@schleppi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sebastian,

On Fri, Aug 11, 2017 at 07:02:36PM +0200, Sebastian Ott wrote:
> ..but I found the bug, actually 2 bugs:
> 
> * That patch embedded a struct iommu_device within struct zpci_dev but
> the iommu_device has a release function (via its class) - so when
> the release function gets called it frees memory that was never allocated.
> The fix is to not embedd struct iommu_device in zpci_dev (see below)
> 
> * iommu_release_device must not release the struct device but the
> structure it is embedded in: struct iommu_device (I'll send a patch
> for that)

Thanks a lot for your in-depth analysis, this bug has been around since
4.11 time :-/ Unfortunatly I can't test iommu-unplug here, so I didn't
notice it until your report.

Meanwhile I worked on a different fix that make the 'struct device' in
iommu_device a pointer again. As Gerald and you noticed already,
struct iommu_device is embedded in other structs as well, and I'd like
to keep it that way. The reason is that in the future the code in
iommu.c should call into iommu-drivers and supply a struct iommu_device,
and the driver can then just do a container_of to get its own data about
that hardware iommu.

So just making the dev member a pointer is a simpler fix for now. The
other option would have been to call back into the iommu-drivers from
the release-function.

I attach the patch I wrote to fix this, can you please test it together
with the initial patch in this thread?

Thanks,

	Joerg

>From aea46317b063d04b5e445aa56e25cc278678e991 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Mon, 14 Aug 2017 17:19:26 +0200
Subject: [PATCH] iommu: Fix wrong freeing of iommu_device->dev

The struct iommu_device has a 'struct device' embedded into
it, not as a pointer, but the whole struct. In the
conversion of the iommu drivers to use struct iommu_device
it was forgotten that the relase function for that struct
device simply calls kfree() on the pointer.

This frees memory that was never allocated and causes memory
corruption.

To fix this issue, use a pointer to struct device instead of
embedding the whole struct. This needs some updates in the
iommu sysfs code as well as the Intel VT-d and AMD IOMMU
driver.

Reported-by: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Fixes: 39ab9555c241 ('iommu: Add sysfs bindings for struct iommu_device')
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # >= v4.11
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_types.h |  4 +++-
 drivers/iommu/intel-iommu.c     |  4 +++-
 drivers/iommu/iommu-sysfs.c     | 32 ++++++++++++++++++++------------
 include/linux/iommu.h           | 12 +++++++++++-
 4 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 294a409e283b..d6b873b57054 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -574,7 +574,9 @@ struct amd_iommu {
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
 {
-	return container_of(dev, struct amd_iommu, iommu.dev);
+	struct iommu_device *iommu = dev_to_iommu_device(dev);
+
+	return container_of(iommu, struct amd_iommu, iommu);
 }
 
 #define ACPIHID_UID_LEN 256
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d5e8b8628a1a..39d51995e777 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4615,7 +4615,9 @@ static void intel_disable_iommus(void)
 
 static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 {
-	return container_of(dev, struct intel_iommu, iommu.dev);
+	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
+
+	return container_of(iommu_dev, struct intel_iommu, iommu);
 }
 
 static ssize_t intel_iommu_show_version(struct device *dev,
diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index c58351ed61c1..36d1a7ce7fc4 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -62,32 +62,40 @@ int iommu_device_sysfs_add(struct iommu_device *iommu,
 	va_list vargs;
 	int ret;
 
-	device_initialize(&iommu->dev);
+	iommu->dev = kzalloc(sizeof(*iommu->dev), GFP_KERNEL);
+	if (!iommu->dev)
+		return -ENOMEM;
 
-	iommu->dev.class = &iommu_class;
-	iommu->dev.parent = parent;
-	iommu->dev.groups = groups;
+	device_initialize(iommu->dev);
+
+	iommu->dev->class = &iommu_class;
+	iommu->dev->parent = parent;
+	iommu->dev->groups = groups;
 
 	va_start(vargs, fmt);
-	ret = kobject_set_name_vargs(&iommu->dev.kobj, fmt, vargs);
+	ret = kobject_set_name_vargs(&iommu->dev->kobj, fmt, vargs);
 	va_end(vargs);
 	if (ret)
 		goto error;
 
-	ret = device_add(&iommu->dev);
+	ret = device_add(iommu->dev);
 	if (ret)
 		goto error;
 
+	dev_set_drvdata(iommu->dev, iommu);
+
 	return 0;
 
 error:
-	put_device(&iommu->dev);
+	put_device(iommu->dev);
 	return ret;
 }
 
 void iommu_device_sysfs_remove(struct iommu_device *iommu)
 {
-	device_unregister(&iommu->dev);
+	dev_set_drvdata(iommu->dev, NULL);
+	device_unregister(iommu->dev);
+	iommu->dev = NULL;
 }
 /*
  * IOMMU drivers can indicate a device is managed by a given IOMMU using
@@ -102,14 +110,14 @@ int iommu_device_link(struct iommu_device *iommu, struct device *link)
 	if (!iommu || IS_ERR(iommu))
 		return -ENODEV;
 
-	ret = sysfs_add_link_to_group(&iommu->dev.kobj, "devices",
+	ret = sysfs_add_link_to_group(&iommu->dev->kobj, "devices",
 				      &link->kobj, dev_name(link));
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_link_nowarn(&link->kobj, &iommu->dev.kobj, "iommu");
+	ret = sysfs_create_link_nowarn(&link->kobj, &iommu->dev->kobj, "iommu");
 	if (ret)
-		sysfs_remove_link_from_group(&iommu->dev.kobj, "devices",
+		sysfs_remove_link_from_group(&iommu->dev->kobj, "devices",
 					     dev_name(link));
 
 	return ret;
@@ -121,5 +129,5 @@ void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 		return;
 
 	sysfs_remove_link(&link->kobj, "iommu");
-	sysfs_remove_link_from_group(&iommu->dev.kobj, "devices", dev_name(link));
+	sysfs_remove_link_from_group(&iommu->dev->kobj, "devices", dev_name(link));
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..176f7569d874 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -240,7 +240,7 @@ struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
-	struct device dev;
+	struct device *dev;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
@@ -265,6 +265,11 @@ static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
 	iommu->fwnode = fwnode;
 }
 
+static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
+{
+	return (struct iommu_device *)dev_get_drvdata(dev);
+}
+
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
@@ -589,6 +594,11 @@ static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
 {
 }
 
+static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
+{
+	return NULL;
+}
+
 static inline void iommu_device_unregister(struct iommu_device *iommu)
 {
 }
-- 
2.12.3
