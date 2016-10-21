From: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Fix IOMMU lookup for VF's
Date: Fri, 21 Oct 2016 15:32:05 -0700
Message-ID: <1477089125-18523-1-git-send-email-ashok.raj@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sainath Grandhi <sainath.grandhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

IOMMU driver must pick the same IOMMU as that of a Physical Function (PF) for
any of its Virtual Functions (VF). It is not practical to list all the VF's
in the DMAR scope, as this list could be quite large. Linux also ignores any
VF's listed in DMAR. See dmar_pci_bus_notifier() for virtfn handling.

Since the driver is looking for the bdf of the VF, it will not find one from
searching the DRHD listed in BIOS.  As a result, the IOMMU driver associates
the VF's under the INCLUDE_ALL iommu incorrectly.

This patch looks up the IOMMU of the PF when handling VF's.

Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Sainath Grandhi <sainath.grandhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Sainath Grandhi <sainath.grandhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..c2e4b5c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -885,6 +885,7 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 	struct intel_iommu *iommu;
 	struct device *tmp;
 	struct pci_dev *ptmp, *pdev = NULL;
+	struct pci_dev *pf_pdev = NULL;
 	u16 segment = 0;
 	int i;
 
@@ -893,6 +894,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 
 	if (dev_is_pci(dev)) {
 		pdev = to_pci_dev(dev);
+		/*
+		 * Always lookup the PF's IOMMU when handling VF's
+		 */
+		pf_pdev = pci_physfn(pdev);
+		dev = &pf_pdev->dev;
 		segment = pci_domain_nr(pdev->bus);
 	} else if (has_acpi_companion(dev))
 		dev = &ACPI_COMPANION(dev)->dev;
@@ -905,6 +911,9 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 		for_each_active_dev_scope(drhd->devices,
 					  drhd->devices_cnt, i, tmp) {
 			if (tmp == dev) {
+				if (pdev->is_virtfn)
+					goto got_pdev;
+
 				*bus = drhd->devices[i].bus;
 				*devfn = drhd->devices[i].devfn;
 				goto out;
-- 
2.7.4
