From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 6/7] iommu/vt-d: Remove misleading "domain 0" test from
 domain_exit()
Date: Fri, 08 Feb 2019 16:06:22 -0600
Message-ID: <154966358199.132359.6085600915087301558.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

The "Domain 0 is reserved, so dont process it" comment suggests that a NULL
pointer corresponds to domain 0.  I don't think that's true, and in any
case, every caller supplies a non-NULL domain pointer that has already been
dereferenced, so the test is unnecessary.

Remove the test for a null "domain" pointer.  No functional change
intended.

This null pointer check was added by 5e98c4b1d6e8 ("Allocation and free
functions of virtual machine domain").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6e9f277bfd6d..b0860a8c48d4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1903,10 +1903,6 @@ static void domain_exit(struct dmar_domain *domain)
 {
 	struct page *freelist;
 
-	/* Domain 0 is reserved, so dont process it */
-	if (!domain)
-		return;
-
 	/* Remove associated devices and clear attached or cached domains */
 	rcu_read_lock();
 	domain_remove_dev_info(domain);
