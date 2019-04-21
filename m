From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 08/10] iommu/vt-d: Check whether device requires bounce
	buffer
Date: Sun, 21 Apr 2019 09:17:17 +0800
Message-ID: <20190421011719.14909-9-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190421011719.14909-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This adds a helper to check whether a device needs to
use bounce buffer. It also provides a boot time option
to disable the bounce buffer. Users can use this to
prevent the iommu driver from using the bounce buffer
for performance gain.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Xu Pengfei <pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/iommu/intel-iommu.c                     | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..86880eb3fc73 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1726,6 +1726,11 @@
 			Note that using this option lowers the security
 			provided by tboot because it makes the system
 			vulnerable to DMA attacks.
+		nobounce [Default off]
+			Do not use the bounce buffer for untrusted devices like
+			the Thunderbolt devices. This will treat the untrusted
+			devices as the trusted ones, hence might expose security
+			risks of DMA attacks.
 
 	intel_idle.max_cstate=	[KNL,HW,ACPI,X86]
 			0	disables intel_idle and fall back on acpi_idle.
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e4a164324bdd..0d80f26b8a72 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -380,6 +380,7 @@ static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
 static int intel_iommu_sm;
 static int iommu_identity_mapping;
+static int intel_no_bounce;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
@@ -396,6 +397,19 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
+static inline bool device_needs_bounce(struct device *dev)
+{
+	struct pci_dev *pdev = NULL;
+
+	if (intel_no_bounce)
+		return false;
+
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
+
+	return pdev ? pdev->untrusted : false;
+}
+
 /*
  * Iterate over elements in device_domain_list and call the specified
  * callback @fn against each element.
@@ -478,6 +492,9 @@ static int __init intel_iommu_setup(char *str)
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
+		} else if (!strncmp(str, "nobounce", 8)) {
+			pr_info("Intel-IOMMU: No bounce buffer. This could expose security risks of DMA attacks\n");
+			intel_no_bounce = 1;
 		}
 
 		str += strcspn(str, ",");
-- 
2.17.1
