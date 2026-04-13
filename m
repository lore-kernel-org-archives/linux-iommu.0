Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE039185F
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122845; cv=none; b=ADWu+99IMQ+A2eYPxF0gmjvoGzS2QFd02tRjRgw87nXpJSSCKd/iXgXC/l5D3MW9+jemQXa5ulHDEnyWh7tK4GB5dvK8A8FS08FlKe6YbgBD+tPj4dRp6uAbV3PjgmFHlGmbFZKJKZLb2kShuolSCZwdtyEjtZ82DLXgteFOo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122845; c=relaxed/simple;
	bh=sKtjr55PtoM9USMx0AA9JHeaSfVhUSHii1KBWCiw1hE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MOD54TMfMdAFcgV2qn2YSdje7wPfFiNDaaCuoGn/pHj4Mi9EanE+6Y4bXi245ak5oKQtZu8GpBGWi2/LoWImMdZngSrbtqaRtzUF9dngiUWyuuE4ghw8JNVuiuFEIWP7I9Zc4i3QtkGlmMPvizvWmGN1thZFxCxRZ1U6Y37Na4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wCQgS-000000005f7-2ncU;
	Mon, 13 Apr 2026 23:27:12 +0000
Date: Tue, 14 Apr 2026 00:27:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/mediatek-v1: add .of_xlate and defer
 arm_iommu_create_mapping()
Message-ID: <e258b2fa7990bc8dac6f9dcbd5848ccf9dc9de1a.1776122765.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") the iommu core populates the device's iommu_fwspec via
of_iommu_xlate() -> ops->of_xlate() before calling ops->probe_device().
mtk_iommu_v1 did not provide .of_xlate and instead parsed the "iommus"
property itself from probe_device(); with the new flow of_iommu_xlate()
returns -ENODEV, the fwspec is never populated, probe_device() is never
called, and the device_link from consumers (disp-ovl, disp-rdma, ...)
to their smi-larb supplier is never created. As a result the larb is
never runtime-resumed, its SMI clocks are gated by clk_disable_unused(),
and display and GPU DMA through the SMI bus fabric hang as soon as
unused clocks are disabled at late_initcall_sync.

Register mtk_iommu_v1_of_xlate() as .of_xlate and simplify
mtk_iommu_v1_probe_device() to just consume the already-populated
fwspec. arm_iommu_create_mapping() cannot run from the of_xlate path
because it eventually calls iommu_paging_domain_alloc() ->
dev_has_iommu(), which returns -ENODEV while the device is still in
the middle of its iommu setup and not yet attached to an iommu_group.
Move the mapping creation to probe_finalize(), which runs once the
iommu group has been set up for the device.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/iommu/mtk_iommu_v1.c | 58 +++++++++++++-----------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4b..e33e123fedc7b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -413,12 +413,10 @@ static const struct iommu_ops mtk_iommu_v1_ops;
  * MTK generation one iommu HW only support one iommu domain, and all the client
  * sharing the same iova address space.
  */
-static int mtk_iommu_v1_create_mapping(struct device *dev,
-				       const struct of_phandle_args *args)
+static int mtk_iommu_v1_of_xlate(struct device *dev,
+				 const struct of_phandle_args *args)
 {
-	struct mtk_iommu_v1_data *data;
 	struct platform_device *m4updev;
-	struct dma_iommu_mapping *mtk_mapping;
 	int ret;
 
 	if (args->args_count != 1) {
@@ -442,47 +440,17 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 		put_device(&m4updev->dev);
 	}
 
-	ret = iommu_fwspec_add_ids(dev, args->args, 1);
-	if (ret)
-		return ret;
-
-	data = dev_iommu_priv_get(dev);
-	mtk_mapping = data->mapping;
-	if (!mtk_mapping) {
-		/* MTK iommu support 4GB iova address space. */
-		mtk_mapping = arm_iommu_create_mapping(dev, 0, 1ULL << 32);
-		if (IS_ERR(mtk_mapping))
-			return PTR_ERR(mtk_mapping);
-
-		data->mapping = mtk_mapping;
-	}
-
-	return 0;
+	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
 static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = NULL;
-	struct of_phandle_args iommu_spec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_v1_data *data;
-	int err, idx = 0, larbid, larbidx;
+	int idx, larbid, larbidx;
 	struct device_link *link;
 	struct device *larbdev;
 
-	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
-					   "#iommu-cells",
-					   idx, &iommu_spec)) {
-
-		err = mtk_iommu_v1_create_mapping(dev, &iommu_spec);
-		of_node_put(iommu_spec.np);
-		if (err)
-			return ERR_PTR(err);
-
-		/* dev->iommu_fwspec might have changed */
-		fwspec = dev_iommu_fwspec_get(dev);
-		idx++;
-	}
-
 	if (!fwspec)
 		return ERR_PTR(-ENODEV);
 
@@ -516,9 +484,22 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 
 static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
-	__maybe_unused struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
+	struct dma_iommu_mapping *mtk_mapping;
 	int err;
 
+	mtk_mapping = data->mapping;
+	if (!mtk_mapping) {
+		/* MTK iommu supports 4GB iova address space. */
+		mtk_mapping = arm_iommu_create_mapping(dev, 0, 1ULL << 32);
+		if (IS_ERR(mtk_mapping)) {
+			dev_err(dev, "Failed to create IOMMU mapping: %ld\n",
+				PTR_ERR(mtk_mapping));
+			return;
+		}
+		data->mapping = mtk_mapping;
+	}
+
 	err = arm_iommu_attach_device(dev, data->mapping);
 	if (err)
 		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
@@ -585,6 +566,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.probe_finalize = mtk_iommu_v1_probe_finalize,
 	.release_device	= mtk_iommu_v1_release_device,
 	.device_group	= generic_device_group,
+	.of_xlate	= mtk_iommu_v1_of_xlate,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
-- 
2.53.0
