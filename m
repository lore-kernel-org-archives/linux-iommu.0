From: Rick Song <songwenjun@huawei.com>
Subject: [RFC,v1,2/2] vfio/iommu-type1: set only stage 2 translation
Date: Fri, 21 Oct 2016 12:39:24 +0800
Message-ID: <1477024764-79882-2-git-send-email-songwenjun@huawei.com>
References: <1477024764-79882-1-git-send-email-songwenjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1477024764-79882-1-git-send-email-songwenjun@huawei.com>
Sender: kvm-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, kvm@vger.kernel.org, songwenjun@huawei.com
List-Id: iommu@lists.linux-foundation.org

Normally, VFIO should use only stage 2 translation of
iommu, to create the address mapping. If nesting translation
is disabled from VFIO core, enable iommu domain only stage 2
attribute, otherwise, enable iommu domain nesting attribute.

Signed-off-by: Rick Song <songwenjun@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ba1942..c0265fe 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -741,7 +741,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct vfio_group *group, *g;
 	struct vfio_domain *domain, *d;
 	struct bus_type *bus = NULL;
-	int ret;
+	int attr, ret;
 
 	mutex_lock(&iommu->lock);
 
@@ -775,13 +775,22 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_free;
 	}
 
+	/*
+	 * Set iommu nesting domain attribute if nesting translation
+	 * is enabled from iommu vfio, otherwise set iommu only stage
+	 * 2 domain attribute.
+	 */
+	attr = 1;
 	if (iommu->nesting) {
-		int attr = 1;
-
 		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING,
 					    &attr);
 		if (ret)
 			goto out_domain;
+	} else {
+		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_S2,
+					    &attr);
+		if (ret)
+			goto out_domain;
 	}
 
 	ret = iommu_attach_group(domain->domain, iommu_group);
-- 
1.9.1

