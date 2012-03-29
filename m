From: "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [Intel IOMMU PATCH] Re-evaluate RMRR info for devices removed
	from si domain
Date: Thu, 29 Mar 2012 13:19:58 +0000
Message-ID: <9774516974AF5F4C8A2C3C69CD3412332037D105@G9W0755.americas.hpqcorp.net>
References: <20120228190537.10845.31327.sendpatchset@tmingo.usa.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120228190537.10845.31327.sendpatchset-G9O6rAK5tKBoF4rmPqRKaQC/G2K4zDHf@public.gmane.org>
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
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "Camuso, Tony" <Tony.Camuso-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch is being submitted to handle the case where a pci device is
placed into the si domain, when booting in iommu passthrough mode, then
removed. The RMRR information for such devices need to be re-processed
to avoid DMA Read errors due to the Present Bit being cleared in the
device's context entry.
Signed-off-by: Thomas Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
Tested-by: Tony Camuso <tony.camuso-VXdhtT5mjnY@public.gmane.org>

Details of testing performed (per Mr. Camuso):

I think I was able to prove that your patch works with si domain devices.
 
I was able to Device Assign the two Patsburg USB controllers on the DL360G8 to your RH6 VM.

When I did that, I saw them on the VM guest, but they did not appear on the host. This is exactly the behavior you expect for Device-Assigned devices.  

Guest ..
[root@rh6 ~]# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub Bus 002 Device 002: ID 0627:0001 Adomax Technology Co., Ltd Bus 002 Device 003: ID 0000:0000 Bus 001 Device 003: ID 046d:c03d Logitech, Inc. M-BT96a Pilot Optical Mouse

Host ...
[root@dl380g8 ~]# lsusb
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub Bus 003 Device 002: ID 03f0:7029 Hewlett-Packard
[root@dl380g8 ~]#

When I powered-down the guest, the USB controllers appeared on the host system again. 

[root@dl380g8 ~]# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub Bus 003 Device 002: ID 03f0:7029 Hewlett-Packard Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub Bus 001 Device 003: ID 046d:c03d Logitech, Inc. M-BT96a Pilot Optical Mouse Bus 002 Device 003: ID 0424:2660 Standard Microsystems Corp. 
Bus 002 Device 004: ID 03f0:3207 Hewlett-Packard 4 GB flash drive
[root@dl380g8 ~]#
 
Then, I powered-up the guest again, the usb controllers were there on the guest system again.

[root@localhost ~]# lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub Bus 002 Device 002: ID 0627:0001 Adomax Technology Co., Ltd Bus 002 Device 003: ID 0000:0000 Bus 001 Device 003: ID 046d:c03d Logitech, Inc. M-BT96a Pilot Optical Mouse [root@localhost ~]#

And they had vanished from the host system.

[root@dl380g8 ~]# lsusb
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub Bus 003 Device 002: ID 03f0:7029 Hewlett-Packard
[root@dl380g8 ~]#

I believe this proves that your patch works correctly with si domain devices.

PATCH FOLLOWS...


diff -up linux-3.2.4/drivers/iommu/intel-iommu.c.ORIG linux-3.2.4/drivers/iommu/intel-iommu.c
--- linux-3.2.4/drivers/iommu/intel-iommu.c.ORIG	2012-02-22 16:10:07.105254130 -0600
+++ linux-3.2.4/drivers/iommu/intel-iommu.c	2012-02-28 12:49:38.537694065 -0600
@@ -2676,7 +2676,8 @@ static int iommu_dummy(struct pci_dev *p
 static int iommu_no_mapping(struct device *dev)
 {
 	struct pci_dev *pdev;
-	int found;
+	struct dmar_rmrr_unit *rmrr;
+	int i, ret, found;
 
 	if (unlikely(dev->bus != &pci_bus_type))
 		return 1;
@@ -2699,7 +2700,24 @@ static int iommu_no_mapping(struct devic
 			 */
 			domain_remove_one_dev_info(si_domain, pdev);
 			printk(KERN_INFO "32bit %s uses non-identity mapping\n",
-			       pci_name(pdev));
+				pci_name(pdev));
+			printk(KERN_INFO "IOMMU: Re-processing RMRR information for device %s:\n",
+				pci_name(pdev));
+			for_each_rmrr_units(rmrr) {
+				for (i = 0; i < rmrr->devices_cnt; i++) {
+					/*
+					 * Here we are just concerned with finding the
+					 * one device that was removed from the
+					 * si_domain and re-evaluating its RMRR info.
+					 */
+					if (rmrr->devices[i] != pdev)
+						continue;
+					ret = iommu_prepare_rmrr_dev(rmrr, pdev);
+					if (ret)
+						printk(KERN_ERR
+							"IOMMU: mapping reserved region failed for device.\n");
+				}
+			}
 			return 0;
 		}
 	} else {
