From: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] iommu/s390: Add support for iommu_device handling
Date: Fri, 11 Aug 2017 19:02:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1708111844340.1769@schleppi>
References: <1502274354-643-1-git-send-email-joro@8bytes.org>
	<alpine.LFD.2.20.1708102104390.4919@schleppi>
	<20170811073118.GF30515@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170811073118.GF30515-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

Hello Joerg,

On Fri, 11 Aug 2017, Joerg Roedel wrote:
> Hey Sebastian,
> 
> On Thu, Aug 10, 2017 at 09:07:06PM +0200, Sebastian Ott wrote:
> > With this patch pci hot-unplug fails with a use after free or refcounting
> > issue - I'm currently trying to understand what's going on...
> 
> Let me know if I can help with debugging the issue, do you have a
> backtrace for me to look at?

I would have send backtraces but everyone looked different: random mem
corruptions, panic during unrelated allocations and stuff like that.

..but I found the bug, actually 2 bugs:

* That patch embedded a struct iommu_device within struct zpci_dev but
the iommu_device has a release function (via its class) - so when
the release function gets called it frees memory that was never allocated.
The fix is to not embedd struct iommu_device in zpci_dev (see below)

* iommu_release_device must not release the struct device but the
structure it is embedded in: struct iommu_device (I'll send a patch
for that)

With these fixed it works fine.

Sebastian

---
 arch/s390/include/asm/pci.h |  2 +-
 drivers/iommu/s390-iommu.c  | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 386df9a..de3129e 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -123,7 +123,7 @@ struct zpci_dev {
 	unsigned long	iommu_pages;
 	unsigned int	next_bit;
 
-	struct iommu_device iommu_dev;  /* IOMMU core handle */
+	struct iommu_device *iommu_dev;  /* IOMMU core handle */
 
 	char res_name[16];
 	struct zpci_bar_struct bars[PCI_BAR_COUNT];
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 85f3bc5..58a7414 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -174,7 +174,7 @@ static int s390_iommu_add_device(struct device *dev)
 		return PTR_ERR(group);
 
 	iommu_group_put(group);
-	iommu_device_link(&zdev->iommu_dev, dev);
+	iommu_device_link(zdev->iommu_dev, dev);
 
 	return 0;
 }
@@ -201,7 +201,7 @@ static void s390_iommu_remove_device(struct device *dev)
 			s390_iommu_detach_device(domain, dev);
 	}
 
-	iommu_device_unlink(&zdev->iommu_dev, dev);
+	iommu_device_unlink(zdev->iommu_dev, dev);
 	iommu_group_remove_device(dev);
 }
 
@@ -336,21 +336,25 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 {
 	int rc = 0;
 
-	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
+	zdev->iommu_dev = kzalloc(sizeof(*zdev->iommu_dev), GFP_KERNEL);
+	if (!zdev->iommu_dev)
+		return -ENOMEM;
+
+	rc = iommu_device_sysfs_add(zdev->iommu_dev, NULL, NULL,
 				    "s390-iommu.%08x", zdev->fid);
 	if (rc)
 		goto out_err;
 
-	iommu_device_set_ops(&zdev->iommu_dev, &s390_iommu_ops);
+	iommu_device_set_ops(zdev->iommu_dev, &s390_iommu_ops);
 
-	rc = iommu_device_register(&zdev->iommu_dev);
+	rc = iommu_device_register(zdev->iommu_dev);
 	if (rc)
 		goto out_sysfs;
 
 	return 0;
 
 out_sysfs:
-	iommu_device_sysfs_remove(&zdev->iommu_dev);
+	iommu_device_sysfs_remove(zdev->iommu_dev);
 
 out_err:
 	return rc;
@@ -358,8 +362,8 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 
 void zpci_destroy_iommu(struct zpci_dev *zdev)
 {
-	iommu_device_unregister(&zdev->iommu_dev);
-	iommu_device_sysfs_remove(&zdev->iommu_dev);
+	iommu_device_unregister(zdev->iommu_dev);
+	iommu_device_sysfs_remove(zdev->iommu_dev);
 }
 
 static struct iommu_ops s390_iommu_ops = {
-- 
2.5.5
