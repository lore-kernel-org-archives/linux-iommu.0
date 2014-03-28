From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] iommu/vt-d: returning free pointer in get_domain_for_dev()
Date: Fri, 28 Mar 2014 11:29:50 +0300
Message-ID: <20140328082950.GN25192@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

If we hit this error condition then we want to return a NULL pointer and
not a freed variable.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fbce01..69fa7da 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2257,6 +2257,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		goto error;
 	if (iommu_attach_domain(domain, iommu)) {
 		free_domain_mem(domain);
+		domain = NULL;
 		goto error;
 	}
 	free = domain;
