From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] iommu/amd: Check if domain is NULL before dereference it
Date: Thu, 24 Aug 2017 19:56:47 +0800
Message-ID: <1503575807-15746-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, joro@8bytes.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

In get_domain(), 'domain' could still be NULL before it's passed to
dma_ops_domain() to dereference. For safety, check if 'domain' is
NULL before passing to dma_ops_domain().

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 16f1e6af00b0..2e2d5e6a13b3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2262,7 +2262,7 @@ static struct protection_domain *get_domain(struct device *dev)
 		domain = to_pdomain(io_domain);
 		attach_device(dev, domain);
 	}
-	if (!dma_ops_domain(domain))
+	if (domain && !dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
 
 	return domain;
-- 
2.5.5
