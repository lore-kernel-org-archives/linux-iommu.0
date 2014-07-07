From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu: Fix IOMMU sysfs stubs
Date: Mon, 07 Jul 2014 14:31:36 -0600
Message-ID: <20140707203054.28174.58508.stgit@gimli.home>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

0-day kernel build testing reports:

   arch/x86/kvm/x86.o: In function `iommu_device_destroy':
>> (.text+0x7a0a): multiple definition of `iommu_device_destroy'
   arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x490): first defined here
   arch/x86/kvm/x86.o: In function `iommu_device_link':
>> (.text+0x7a15): multiple definition of `iommu_device_link'
   arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x49b): first defined here
   arch/x86/kvm/x86.o: In function `iommu_device_unlink':
>> (.text+0x7a25): multiple definition of `iommu_device_unlink'
   arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x4ab): first defined here
   arch/x86/kvm/x86.o: In function `iommu_device_create':
>> (.text+0x79f8): multiple definition of `iommu_device_create'
   arch/x86/kvm/../../../virt/kvm/vfio.o:vfio.c:(.text+0x47e): first defined here

These are due to failing to define the stubs as static inline.  Fix.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

relative to joro/iommu.git core

 include/linux/iommu.h |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c7097d7..20f9a52 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -403,23 +403,24 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
-struct device *iommu_device_create(struct device *parent, void *drvdata,
-				   const struct attribute_group **groups,
-				   const char *fmt, ...)
+static inline struct device *iommu_device_create(struct device *parent,
+					void *drvdata,
+					const struct attribute_group **groups,
+					const char *fmt, ...)
 {
 	return ERR_PTR(-ENODEV);
 }
 
-void iommu_device_destroy(struct device *dev)
+static inline void iommu_device_destroy(struct device *dev)
 {
 }
 
-int iommu_device_link(struct device *dev, struct device *link)
+static inline int iommu_device_link(struct device *dev, struct device *link)
 {
 	return -EINVAL;
 }
 
-void iommu_device_unlink(struct device *dev, struct device *link)
+static inline void iommu_device_unlink(struct device *dev, struct device *link)
 {
 }
 
