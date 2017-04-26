From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: [RFC PATCH 08/20] Memory: add notifier flag check in memory_replay()
Date: Wed, 26 Apr 2017 18:06:38 +0800
Message-ID: <1493201210-14357-9-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

memory_region_iommu_replay is used to do replay with MAP/UNMAP notifier.
However, other notifiers may be passed in, so add a check against notifier
flag to avoid potential error. e.g. memory_region_iommu_replay_all loops
all registered notifiers, may just pass in wrong notifier.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/memory.c b/memory.c
index 9c253cc..0728e62 100644
--- a/memory.c
+++ b/memory.c
@@ -1630,6 +1630,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
 
+    if (!(n->notifier_flags & IOMMU_NOTIFIER_MAP_UNMAP)) {
+        /* If notifier flag is not IOMMU_NOTIFIER_UNMAP or
+         * IOMMU_NOTIFIER_MAP, return. This check is necessary
+         * as there is notifier other than MAP/UNMAP
+         */
+        return;
+    }
+
     /* If the IOMMU has its own replay callback, override */
     if (mr->iommu_ops->replay) {
         mr->iommu_ops->replay(mr, n);
-- 
1.9.1
