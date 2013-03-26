From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: soundcard (dma) stopped working with commit 27c2127
	(x86/amd-iommu: Use only per-device dma_ops)
Date: Tue, 26 Mar 2013 17:11:39 +0100
Message-ID: <20130326161132.GF2727@8bytes.org>
References: <CAHccUrL2_JLMyYzzBYUdUGy0VVRRk90u9_MyknPKcRJpr_ZDfQ@mail.gmail.com>
	<20130326094930.GD13035@8bytes.org>
	<CAHccUr+w1_65uBXLcmZLrPOgbC8Ldk8+PKxaRLv03rBYxBRDkg@mail.gmail.com>
	<20130326142336.GE13035@8bytes.org>
	<CAHccUrKmtjqBZVb1+1O5c4j6_9Er5Ow4tPRhExCW-g_kaV1-3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHccUrKmtjqBZVb1+1O5c4j6_9Er5Ow4tPRhExCW-g_kaV1-3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Degert <andreas.degert-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2013 at 04:20:54PM +0100, Andreas Degert wrote:
> There is a third sound device:
> 
> 04:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
> DSP (rev 35)
> 
> (at the end of the lspci listing in my first mail). This is the one that doesn't
> work, it's connected via cardbus (yenta driver), so it appears a bit further
> down in the dmesg output.

Ah, I see. But still, this device is in the alias range and thus also
covered by IVRS. It should use 00:14.4 as the request-id.

Can you try the attached debug-patch, boot and send me dmesg again? This
should sched some light onto the problem.

Thanks,

	Joerg

--k+w/mQv8wyuph6w0
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="iommu-debug.patch"

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c1c74e0..b96af8a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -244,21 +244,29 @@ static bool check_device(struct device *dev)
 {
 	u16 devid;
 
-	if (!dev || !dev->dma_mask)
+	if (!dev || !dev->dma_mask) {
+		pr_err("AMD-Vi: Device %s has no dma_mask\n", dev_name(dev));
 		return false;
+	}
 
 	/* No device or no PCI device */
-	if (dev->bus != &pci_bus_type)
+	if (dev->bus != &pci_bus_type) {
+		pr_err("AMD-Vi: Device %s is not PCI\n", dev_name(dev));
 		return false;
+	}
 
 	devid = get_device_id(dev);
 
 	/* Out of our scope? */
-	if (devid > amd_iommu_last_bdf)
+	if (devid > amd_iommu_last_bdf) {
+		pr_err("AMD-Vi: Device %s is out of range\n", dev_name(dev));
 		return false;
+	}
 
-	if (amd_iommu_rlookup_table[devid] == NULL)
+	if (amd_iommu_rlookup_table[devid] == NULL) {
+		pr_err("AMD-Vi: Device %s has no responsible IOMMU\n", dev_name(dev));
 		return false;
+	}
 
 	return true;
 }
@@ -2448,6 +2456,8 @@ static int device_change_notifier(struct notifier_block *nb,
 		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 
+		pr_info("AMD-Vi: Adding device %s\n", dev_name(dev));
+
 		iommu_init_device(dev);
 
 		/*
@@ -2457,6 +2467,7 @@ static int device_change_notifier(struct notifier_block *nb,
 		dev_data = get_dev_data(dev);
 
 		if (iommu_pass_through || dev_data->iommu_v2) {
+			pr_info("AMD-Vi: Using pt-domain for %s\n", dev_name(dev));
 			dev_data->passthrough = true;
 			attach_device(dev, pt_domain);
 			break;
@@ -2466,11 +2477,15 @@ static int device_change_notifier(struct notifier_block *nb,
 
 		/* allocate a protection domain if a device is added */
 		dma_domain = find_protection_domain(devid);
-		if (dma_domain)
+		if (dma_domain) {
+			pr_info("AMD-Vi: Already dma_domain for %s\n", dev_name(dev));
 			goto out;
+		}
 		dma_domain = dma_ops_domain_alloc();
-		if (!dma_domain)
+		if (!dma_domain) {
+			pr_info("AMD-Vi: Can't alloc dma_domain for %s\n", dev_name(dev));
 			goto out;
+		}
 		dma_domain->target_dev = devid;
 
 		spin_lock_irqsave(&iommu_pd_list_lock, flags);
@@ -2484,6 +2499,8 @@ static int device_change_notifier(struct notifier_block *nb,
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
 
+		pr_info("AMD-Vi: Removing device %s\n", dev_name(dev));
+
 		iommu_uninit_device(dev);
 
 	default:
@@ -3122,10 +3139,13 @@ static unsigned device_dma_ops_init(void)
 
 		dev_data = get_dev_data(&pdev->dev);
 
-		if (!dev_data->passthrough)
+		if (!dev_data->passthrough) {
+			pr_info("AMD-Vi: Initializing %s to amd_iommu_dma_ops\n", dev_name(&pdev->dev));
 			pdev->dev.archdata.dma_ops = &amd_iommu_dma_ops;
-		else
+		} else {
+			pr_info("AMD-Vi: Initializing %s to nommu_dma_ops\n", dev_name(&pdev->dev));
 			pdev->dev.archdata.dma_ops = &nommu_dma_ops;
+		}
 	}
 
 	return unhandled;

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--k+w/mQv8wyuph6w0--
