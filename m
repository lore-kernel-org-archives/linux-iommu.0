From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH 7/7] VFIO: VFIO_PLATFORM: Update documentation for platform
	specific devices
Date: Mon, 30 Sep 2013 17:28:43 +0200
Message-ID: <1380554923-17818-8-git-send-email-a.motakis@virtualopensystems.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380554923-17818-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Update Documentation/vfio.txt with information regarding the device tree
based platform devices support.

What is still missing in this RFC series, is information on how to bind
the driver to platform devices, as there is currently for PCI. This will
be added when proper VFIO driver binding is implemented.
---
 Documentation/vfio.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index b4eafa6..e8daa2b 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -237,6 +237,23 @@ group and can access them as follows:
 	/* Gratuitous device reset and go... */
 	ioctl(device, VFIO_DEVICE_RESET);
 
+For platform devices, if a device has multiple regions and multiple IRQs the
+index that will be assigned by VFIO to those resources will correspond to the
+order within the associated "reg" and "interrupt" properties in the device tree
+representation of the target device.
+
+For example, if a device is represented like this in the device tree:
+
+        reg = <0x101e2000 0x1000 0x101e4000 0x1000>;
+        interrupts = <24 25 26 27>;
+
+Region #0 is 0x101e2000, region #1 is 0x101e4000
+Interrupt #0 is 24, and so on.
+
+Additionally for a platform device, unlike PCI devices, an offset referring to
+a region within a VFIO device file descriptor will match the physical address
+of that region as defined in the device tree.
+
 VFIO User API
 -------------------------------------------------------------------------------
 
-- 
1.8.1.2
