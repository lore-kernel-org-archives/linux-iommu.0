From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 7/7] iommu/vt-d: Simplify control flow
Date: Fri, 08 Feb 2019 16:06:28 -0600
Message-ID: <154966358874.132359.3411695261972962024.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify control flow by returning immediately when we know the result.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b0860a8c48d4..6eaa4ada6e1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -509,12 +509,12 @@ static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 void *alloc_pgtable_page(int node)
 {
 	struct page *page;
-	void *vaddr = NULL;
 
 	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
+	if (!page)
+		return NULL;
+
+	return page_address(page);
 }
 
 void free_pgtable_page(void *vaddr)
@@ -2606,20 +2606,19 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 
 		/* DMA alias already has a domain, use it */
 		if (info)
-			goto out;
+			return domain;
 	}
 
 	/* Allocate and initialize new domain for the device */
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
+
 	if (domain_init(domain, iommu, gaw)) {
 		domain_exit(domain);
 		return NULL;
 	}
 
-out:
-
 	return domain;
 }
 
@@ -2665,11 +2664,11 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 
 	domain = find_domain(dev);
 	if (domain)
-		goto out;
+		return domain;
 
 	domain = find_or_alloc_domain(dev, gaw);
 	if (!domain)
-		goto out;
+		return NULL;
 
 	tmp = set_domain_for_dev(dev, domain);
 	if (!tmp || domain != tmp) {
@@ -2677,8 +2676,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 		domain = tmp;
 	}
 
-out:
-
 	return domain;
 }
 
@@ -3558,11 +3555,13 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 
 	domain = find_domain(dev);
 	if (domain)
-		goto out;
+		return domain;
 
 	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		goto out;
+	if (!domain) {
+		dev_err(dev, "Allocating domain failed\n");
+		return NULL;
+	}
 
 	/* We have a new domain - setup possible RMRRs for the device */
 	rcu_read_lock();
@@ -3587,12 +3586,8 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 		domain = tmp;
 	}
 
-out:
-
 	if (!domain)
 		dev_err(dev, "Allocating domain failed\n");
-
-
 	return domain;
 }
 
