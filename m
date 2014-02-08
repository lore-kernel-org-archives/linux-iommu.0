From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v4 06/10] VFIO_PLATFORM: Read and write support for the
	device fd
Date: Sat,  8 Feb 2014 18:29:36 +0100
Message-ID: <1391880580-471-7-git-send-email-a.motakis@virtualopensystems.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391880580-471-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VFIO returns a file descriptor which we can use to manipulate the memory
regions of the device. Since some memory regions we cannot mmap due to
security concerns, we also allow to read and write to this file descriptor
directly.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Tested-by: Alvise Rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform.c | 128 +++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index f7db5c0..ee96078 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -55,7 +55,8 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 
 		region.addr = res->start;
 		region.size = resource_size(res);
-		region.flags = 0;
+		region.flags = VFIO_REGION_INFO_FLAG_READ
+				| VFIO_REGION_INFO_FLAG_WRITE;
 
 		vdev->region[i] = region;
 	}
@@ -150,13 +151,134 @@ static long vfio_platform_ioctl(void *device_data,
 static ssize_t vfio_platform_read(void *device_data, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	return 0;
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int *io;
+	int i;
+
+	for (i = 0; i < vdev->num_regions; i++) {
+		struct vfio_platform_region region = vdev->region[i];
+		unsigned int done = 0;
+		loff_t off;
+
+		if ((*ppos < region.addr)
+		     || (*ppos + count - 1) >= (region.addr + region.size))
+			continue;
+
+		io = ioremap_nocache(region.addr, region.size);
+
+		off = *ppos - region.addr;
+
+		while (count) {
+			size_t filled;
+
+			if (count >= 4 && !(off % 4)) {
+				u32 val;
+
+				val = ioread32(io + off);
+				if (copy_to_user(buf, &val, 4))
+					goto err;
+
+				filled = 4;
+			} else if (count >= 2 && !(off % 2)) {
+				u16 val;
+
+				val = ioread16(io + off);
+				if (copy_to_user(buf, &val, 2))
+					goto err;
+
+				filled = 2;
+			} else {
+				u8 val;
+
+				val = ioread8(io + off);
+				if (copy_to_user(buf, &val, 1))
+					goto err;
+
+				filled = 1;
+			}
+
+
+			count -= filled;
+			done += filled;
+			off += filled;
+			buf += filled;
+		}
+
+		iounmap(io);
+		return done;
+	}
+
+	return -EFAULT;
+
+err:
+	iounmap(io);
+	return -EFAULT;
 }
 
 static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	return 0;
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int *io;
+	int i;
+
+	for (i = 0; i < vdev->num_regions; i++) {
+		struct vfio_platform_region region = vdev->region[i];
+		unsigned int done = 0;
+		loff_t off;
+
+		if ((*ppos < region.addr)
+		     || (*ppos + count - 1) >= (region.addr + region.size))
+			continue;
+
+		io = ioremap_nocache(region.addr, region.size);
+
+		off = *ppos - region.addr;
+
+		while (count) {
+			size_t filled;
+
+			if (count >= 4 && !(off % 4)) {
+				u32 val;
+
+				if (copy_from_user(&val, buf, 4))
+					goto err;
+				iowrite32(val, io + off);
+
+				filled = 4;
+			} else if (count >= 2 && !(off % 2)) {
+				u16 val;
+
+				if (copy_from_user(&val, buf, 2))
+					goto err;
+				iowrite16(val, io + off);
+
+				filled = 2;
+			} else {
+				u8 val;
+
+				if (copy_from_user(&val, buf, 1))
+					goto err;
+				iowrite8(val, io + off);
+
+				filled = 1;
+			}
+
+			count -= filled;
+			done += filled;
+			off += filled;
+			buf += filled;
+		}
+
+		iounmap(io);
+		return done;
+	}
+
+	return -EINVAL;
+
+err:
+	iounmap(io);
+	return -EFAULT;
 }
 
 static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
-- 
1.8.3.2
