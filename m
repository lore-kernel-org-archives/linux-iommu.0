From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] drivers/iommu/intel-iommu.c: add missing free_domain_mem
Date: Tue, 24 Jul 2012 16:16:04 +0200
Message-ID: <1343139364-26936-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Julia Lawall <julia@diku.dk>
List-Id: iommu@lists.linux-foundation.org

From: Julia Lawall <julia@diku.dk>

Add missing free_domain_mem on failure path after alloc_domain.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@km exists@
local idexpression e;
expression e1,e2,e3;
type T,T1;
identifier f;
@@

* e = alloc_domain(...)
... when any
    when != e = e1
    when != e1 = (T)e
    when != e1(...,(T)e,...)
    when != &e->f
if(...) { ... when != e2(...,(T1)e,...)
                 when != e3 = e
                 when forall
(
             return <+...e...+>;
|
*             return ...;
) }
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/iommu/intel-iommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7469b53..0204b62 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2008,6 +2008,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	if (!drhd) {
 		printk(KERN_ERR "IOMMU: can't find DMAR for device %s\n",
 			pci_name(pdev));
+		free_domain_mem(domain);
 		return NULL;
 	}
 	iommu = drhd->iommu;
