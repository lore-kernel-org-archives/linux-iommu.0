From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 V2 07/17] iommu/vt-d: free resources if failed to create
	domain for PCIe endpoint
Date: Wed, 19 Feb 2014 14:07:27 +0800
Message-ID: <1392790057-32434-8-git-send-email-jiang.liu@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392790057-32434-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Enhance function get_domain_for_dev() to release allocated resources
if failed to create domain for PCIe endpoint, otherwise the allocated
resources will get lost.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 67b114e..503cc73 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2015,7 +2015,7 @@ static int dmar_insert_dev_info(int segment, int bus, int devfn,
 /* domain is initialized */
 static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 {
-	struct dmar_domain *domain;
+	struct dmar_domain *domain, *free = NULL;
 	struct intel_iommu *iommu;
 	struct dmar_drhd_unit *drhd;
 	struct pci_dev *dev_tmp;
@@ -2062,17 +2062,16 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 		free_domain_mem(domain);
 		goto error;
 	}
-	if (domain_init(domain, gaw)) {
-		domain_exit(domain);
+	free = domain;
+	if (domain_init(domain, gaw))
 		goto error;
-	}
 
 	/* register pcie-to-pci device */
 	if (dev_tmp) {
-		if (dmar_insert_dev_info(segment, bus, devfn, NULL, &domain)) {
-			domain_exit(domain);
+		if (dmar_insert_dev_info(segment, bus, devfn, NULL, &domain))
 			goto error;
-		}
+		else
+			free = NULL;
 	}
 
 found_domain:
@@ -2080,6 +2079,8 @@ found_domain:
 				 pdev, &domain) == 0)
 		return domain;
 error:
+	if (free)
+		domain_exit(free);
 	/* recheck it here, maybe others set it */
 	return find_domain(pdev);
 }
-- 
1.7.10.4
