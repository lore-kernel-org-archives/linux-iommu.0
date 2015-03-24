From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] iommu/vt-d: Remove unused variable
Date: Mon, 23 Mar 2015 19:50:21 -0600
Message-ID: <20150324014955.31056.96200.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, joro@8bytes.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Unused after commit 71684406905f ("iommu/vt-d: Detach domain *only*
from attached iommus").  Reported by 0-day builder.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel-iommu.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6228582..0e5ca10 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1743,7 +1743,6 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct dmar_drhd_unit *drhd;
 	struct page *freelist = NULL;
 	int i;
 
