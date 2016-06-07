From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 3/8] iommu: introduce an msi cookie
Date: Tue,  7 Jun 2016 15:59:17 +0000
Message-ID: <1465315162-5888-4-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

This opaque pointer will enable to store information about msi
iommu mappings.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
remove spinlock and RB tree

v5 -> v6:
- initialize reserved_binding_list
- use a spinlock instead of a mutex
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b553ee..f7a5d13 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -91,6 +91,7 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
+	void *msi_cookie;
 };
 
 enum iommu_cap {
-- 
1.9.1
