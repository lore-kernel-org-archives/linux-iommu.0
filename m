From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] create context mapping entries for devices that use
	phantom functions.
Date: Mon,  3 Dec 2012 19:16:27 +0800
Message-ID: <1354533387-4110-5-git-send-email-acooks@gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1354533387-4110-1-git-send-email-acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Joerg-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Roedel-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Justin-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Piszcz-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org, Robert-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, Hancock-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, YingChu <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: "open list:INTEL IOMMU VT-d" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Create context mapping for phantom functions.

Signed-off-by: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 554e6ac..b3c9b55 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1673,6 +1673,32 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 }
 
 static int
+context_map_phantoms(struct dmar_domain *domain, struct pci_dev *pdev,
+			int translation)
+{
+	unsigned fn;
+	int ret;
+
+	if (!pdev->phantoms_enabled)
+		return 0;
+
+	pr_debug("context_map_phantoms()\n");
+
+	for (fn = 1 ; fn < 8 ; fn++) {
+		ret = domain_context_mapping_one(domain,
+					pci_domain_nr(pdev->bus),
+					pdev->bus->number,
+					fn,
+					translation);
+		if (ret) {
+			pr_info("function %d phantom mapping failed.\n", fn);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int
 domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 			int translation)
 {
@@ -1685,6 +1711,10 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	ret = context_map_phantoms(domain, pdev, translation);
+	if (ret)
+		return ret;
+
 	/* dependent device mapping */
 	tmp = pci_find_upstream_pcie_bridge(pdev);
 	if (!tmp)
-- 
1.7.1
