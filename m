From: "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [PATCH v3] Prevent devices with RMRRs from being placed into SI
	Domain
Date: Wed, 17 Oct 2012 21:19:20 +0000
Message-ID: <9774516974AF5F4C8A2C3C69CD341233233D0E28@G2W2530.americas.hpqcorp.net>
References: <20121018021735.23962.51639.sendpatchset@RHEL63BL460c>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121018021735.23962.51639.sendpatchset@RHEL63BL460c>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Don
	Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

I meant to edit the preamble with no reference to init. This patch will prevent any device with an RMRR association from getting placed into the SI Domain and any time.


Tom

-----Original Message-----
From: Mingarelli, Thomas 
Sent: Wednesday, October 17, 2012 4:17 PM
To: Alex Williamson; David Woodhouse; Don Dutile
Cc: Khan, Shuah; Mingarelli, Thomas; Knippers, Linda; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH v3] Prevent devices with RMRRs from being placed into SI Domain

This patch is to prevent devices that have RMRRs associated with them to
not be placed into the SI Domain during init. We don't put USB devices
into this category, however. This fixes the issue where the RMRR info
for devices being placed in and out of the SI Domain gets lost.

Signed-off-by: Thomas Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
Tested-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
----
PATCH v1: https://lkml.org/lkml/2012/6/15/204
PATCH v2: https://lkml.org/lkml/2012/9/18/354


drivers/iommu/intel-iommu.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff -up ./drivers/iommu/intel-iommu.c.ORIG ./drivers/iommu/intel-iommu.c
--- ./drivers/iommu/intel-iommu.c.ORIG	2012-10-16 09:34:23.148089944 -0500
+++ ./drivers/iommu/intel-iommu.c	2012-10-17 20:41:40.509642356 -0500
@@ -2320,8 +2320,38 @@ static int domain_add_dev_info(struct dm
 	return 0;
 }
 
+static bool device_has_rmrr(struct pci_dev *dev)
+{
+	struct dmar_rmrr_unit *rmrr;
+	int i;
+
+	for_each_rmrr_units(rmrr) {
+		for (i = 0; i < rmrr->devices_cnt; i++) {
+			/*
+			 * Here we are just concerned with checking each device
+			 * that has an RMRR associated with it and not allow it
+			 * to be placed into the SI Domain during startup.
+			*/
+			if (rmrr->devices[i] == dev)
+				return true;
+		}
+	}
+	return false;
+}
+
 static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
 {
+
+	/*
+	 * This is where we will refuse any device that has an
+	 * RMRR associated with it and is not a USB device and
+	 * NOT allow it to be placed into the SI Domain. We don't
+	 * need a separate bit for this because it could be ANY device.
+	 */
+	if (device_has_rmrr(pdev) &&
+		(pdev->class >> 8) != PCI_CLASS_SERIAL_USB)
+			return 0;
+
 	if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 		return 1;
 
