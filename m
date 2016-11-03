From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 8/8] iommu/arm-smmu: implement add_reserved_regions callback
Date: Thu,  3 Nov 2016 21:39:38 +0000
Message-ID: <1478209178-3009-9-git-send-email-eric.auger@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1478209178-3009-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The function populates the list of reserved regions with the
PCI host bridge windows and the MSI IOVA range.

At the moment an arbitray MSI IOVA window is set at 0x8000000
of size 1MB.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7..9d1db19 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1533,6 +1533,68 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, &fwid, 1);
 }
 
+static int add_pci_window_reserved_regions(struct iommu_domain *domain,
+					   struct pci_dev *dev)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct iommu_reserved_region *region;
+	struct resource_entry *window;
+	phys_addr_t start;
+	size_t length;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		if (resource_type(window->res) != IORESOURCE_MEM &&
+		    resource_type(window->res) != IORESOURCE_IO)
+			continue;
+
+		start = window->res->start - window->offset;
+		length = window->res->end - window->res->start + 1;
+
+		iommu_reserved_region_for_each(region, domain) {
+			if (region->start == start && region->length == length)
+				continue;
+		}
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region)
+			return -ENOMEM;
+
+		region->start = start;
+		region->length = length;
+
+		list_add_tail(&region->list, &domain->reserved_regions);
+	}
+	return 0;
+}
+
+static int arm_smmu_add_reserved_regions(struct iommu_domain *domain,
+					 struct device *device)
+{
+	struct iommu_reserved_region *region;
+	int ret = 0;
+
+	/* An arbitrary 1MB region starting at 0x8000000 is reserved for MSIs */
+	if (!domain->iova_cookie) {
+
+		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		if (!region)
+			return -ENOMEM;
+
+		region->start = 0x8000000;
+		region->length = 0x100000;
+		list_add_tail(&region->list, &domain->reserved_regions);
+
+		ret = iommu_get_dma_msi_region_cookie(domain,
+						region->start, region->length);
+		if (ret)
+			return ret;
+	}
+
+	if (dev_is_pci(device))
+		ret =  add_pci_window_reserved_regions(domain,
+						       to_pci_dev(device));
+	return ret;
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1548,6 +1610,7 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.of_xlate		= arm_smmu_of_xlate,
+	.add_reserved_regions	= arm_smmu_add_reserved_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
1.9.1
