From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: linux-next: Tree for Sept 24 (iommu)
Date: Mon, 24 Sep 2012 21:23:25 -0600
Message-ID: <1348543405.2320.146.camel@ul30vt.home>
References: <20120925005328.f748dfa3d077cebb345a4291@canb.auug.org.au>
	 <5060D876.5030209@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5060D876.5030209@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2012-09-24 at 15:02 -0700, Randy Dunlap wrote:
> On 09/24/2012 07:53 AM, Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > Today was a train wreck, with lots of new conflicts across several trees
> > and a few build failures as well.
> > 
> > Changes since 201209021:
> > 
> 
> 
> 
> on i386:
> 
> drivers/built-in.o: In function `iommu_group_remove_device':
> (.text+0x74cb10): multiple definition of `iommu_group_remove_device'
> arch/x86/built-in.o:(.text+0x140d0): first defined here
...


Here's a patch to get it past this.  It still doesn't fully build, but
the rest isn't iommu related.  Thanks,

Alex


commit 6955e1f06cb20ddd25665984c330b945443cce36
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Mon Sep 24 21:13:52 2012 -0600

    iommu: inline iommu group stub functions
    
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7e83370..f3b99e1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -256,72 +256,78 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
-int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
+static inline int iommu_attach_group(struct iommu_domain *domain,
+				     struct iommu_group *group)
 {
 	return -ENODEV;
 }
 
-void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
+static inline void iommu_detach_group(struct iommu_domain *domain,
+				      struct iommu_group *group)
 {
 }
 
-struct iommu_group *iommu_group_alloc(void)
+static inline struct iommu_group *iommu_group_alloc(void)
 {
 	return ERR_PTR(-ENODEV);
 }
 
-void *iommu_group_get_iommudata(struct iommu_group *group)
+static inline void *iommu_group_get_iommudata(struct iommu_group *group)
 {
 	return NULL;
 }
 
-void iommu_group_set_iommudata(struct iommu_group *group, void *iommu_data,
-			       void (*release)(void *iommu_data))
+static inline void iommu_group_set_iommudata(struct iommu_group *group,
+					     void *iommu_data,
+					     void (*release)(void *iommu_data))
 {
 }
 
-int iommu_group_set_name(struct iommu_group *group, const char *name)
+static inline int iommu_group_set_name(struct iommu_group *group,
+				       const char *name)
 {
 	return -ENODEV;
 }
 
-int iommu_group_add_device(struct iommu_group *group, struct device *dev)
+static inline int iommu_group_add_device(struct iommu_group *group,
+					 struct device *dev)
 {
 	return -ENODEV;
 }
 
-void iommu_group_remove_device(struct device *dev)
+static inline void iommu_group_remove_device(struct device *dev)
 {
 }
 
-int iommu_group_for_each_dev(struct iommu_group *group, void *data,
-			     int (*fn)(struct device *, void *))
+static inline int iommu_group_for_each_dev(struct iommu_group *group,
+					   void *data,
+					   int (*fn)(struct device *, void *))
 {
 	return -ENODEV;
 }
 
-struct iommu_group *iommu_group_get(struct device *dev)
+static inline struct iommu_group *iommu_group_get(struct device *dev)
 {
 	return NULL;
 }
 
-void iommu_group_put(struct iommu_group *group)
+static inline void iommu_group_put(struct iommu_group *group)
 {
 }
 
-int iommu_group_register_notifier(struct iommu_group *group,
-				  struct notifier_block *nb)
+static inline int iommu_group_register_notifier(struct iommu_group *group,
+						struct notifier_block *nb)
 {
 	return -ENODEV;
 }
 
-int iommu_group_unregister_notifier(struct iommu_group *group,
-				    struct notifier_block *nb)
+static inline int iommu_group_unregister_notifier(struct iommu_group *group,
+						  struct notifier_block *nb)
 {
 	return 0;
 }
 
-int iommu_group_id(struct iommu_group *group)
+static inline int iommu_group_id(struct iommu_group *group)
 {
 	return -ENODEV;
 }
