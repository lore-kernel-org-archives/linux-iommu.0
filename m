From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 2/5] vfio: platform: decouple code probing devices from the
	platform bus
Date: Fri, 22 Aug 2014 11:01:25 +0200
Message-ID: <1408698088-5349-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1408698088-5349-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hide functionality related to discovering Linux platform device resources
in separate callback functions. This will allow us to implement AMBA support
while reusing a lot of the code.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform.c         | 28 +++++++++++++++++++++++----
 drivers/vfio/platform/vfio_platform_irq.c     |  6 +++---
 drivers/vfio/platform/vfio_platform_private.h |  7 ++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index f4c06c6..99aa9af 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -38,7 +38,7 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
 
-	while (platform_get_resource(vdev->pdev, IORESOURCE_MEM, cnt))
+	while (vdev->get_resource(vdev, cnt))
 		cnt++;
 
 	vdev->region = kzalloc(sizeof(struct vfio_platform_region) * cnt,
@@ -47,8 +47,7 @@ static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
 		return -ENOMEM;
 
 	for (i = 0; i < cnt;  i++) {
-		struct resource *res =
-			platform_get_resource(vdev->pdev, IORESOURCE_MEM, i);
+		struct resource *res = vdev->get_resource(vdev, i);
 
 		if (!res)
 			goto err;
@@ -385,6 +384,24 @@ static const struct vfio_device_ops vfio_platform_ops = {
 	.mmap		= vfio_platform_mmap,
 };
 
+/* probing devices from the linux platform bus */
+
+static struct resource* get_platform_resource(struct vfio_platform_device *vdev,
+						int i)
+{
+	struct platform_device *pdev = (struct platform_device *) vdev->opaque;
+
+	return platform_get_resource(pdev, IORESOURCE_MEM, i);
+}
+
+static int get_platform_irq(struct vfio_platform_device *vdev, int i)
+{
+	struct platform_device *pdev = (struct platform_device *) vdev->opaque;
+
+	return platform_get_irq(pdev, i);
+}
+
+
 static int vfio_platform_probe(struct platform_device *pdev)
 {
 	struct vfio_platform_device *vdev;
@@ -403,7 +420,10 @@ static int vfio_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	vdev->pdev = pdev;
+	vdev->opaque = (void *) pdev;
+	vdev->get_resource = get_platform_resource;
+	vdev->get_irq = get_platform_irq;
+	vdev->name = pdev->name;
 
 	ret = vfio_add_group_dev(&pdev->dev, &vfio_platform_ops, vdev);
 	if (ret) {
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 6768508..50c8293 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -38,7 +38,7 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
 
-	while (platform_get_irq(vdev->pdev, cnt) > 0)
+	while (vdev->get_irq(vdev, cnt) > 0)
 		cnt++;
 
 	vdev->irq = kzalloc(sizeof(struct vfio_platform_irq) * cnt, GFP_KERNEL);
@@ -46,7 +46,7 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 		return -ENOMEM;
 
 	for (i = 0; i < cnt; i++) {
-		int hwirq = platform_get_irq(vdev->pdev, i);
+		int hwirq = vdev->get_irq(vdev, i);
 
 		if (hwirq < 0)
 			goto err;
@@ -172,7 +172,7 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev,
 		return 0;
 
 	irq->name = kasprintf(GFP_KERNEL, "vfio-irq[%d](%s)",
-						irq->hwirq, vdev->pdev->name);
+						irq->hwirq, vdev->name);
 	if (!irq->name)
 		return -ENOMEM;
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 86a9201..b79f485 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -44,11 +44,16 @@ struct vfio_platform_region {
 };
 
 struct vfio_platform_device {
-	struct platform_device		*pdev;
 	struct vfio_platform_region	*region;
 	u32				num_regions;
 	struct vfio_platform_irq	*irq;
 	u32				num_irqs;
+	void				*opaque;
+	const char			*name;
+	/* callbacks to discover device resources */
+	struct resource*
+		(*get_resource)(struct vfio_platform_device *vdev, int i);
+	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
 };
 
 extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
-- 
1.8.3.2
