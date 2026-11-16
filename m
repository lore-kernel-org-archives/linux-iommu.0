Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822689;
	b=GVaITsqW60lYpWRp83oXRaQ8D9NeYjxGX+L9de64isLAcXxcVLscErffC49q0uv4bVyV
	 YtlnrXyJxI5VZJwbKYr/iXaOv0DxQAY3JpOedMgIHJnnEVg/OOg66t2KfXfdYICsSnKP+
	 Xho5eZcl7OILIh3O4w+1BS0ODhvqpQ/EZ6v+B58+LkCPiXYS/Mi/r+ZAsPymvPZnk7vZj
	 qLwFWyou8W6sMLbERGOMHLu6h2TnUDOZEjgR2wMJY4Sv7eOga5AWjQpOZwh/ppYXW0LTn
	 CvYVDLBoarYORKbOzkOJbd8vj7VyoRVKCMY7oFNltS5/bHKKz3e7YqBOhX8U7pGoTQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822689;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=r1/VRU/vGDJ8CYD8ahbybXIE2uq73+EPqpl2ADlA0hc=;
	b=YiWl/U9c8iqQxf0VgaLgu7EFmN2sPu8cG7pMf0pk3p21ccrBTWPBCrvyDECsIrYYcr7L
	 qB/SNnyTZE+j2R0URKUww/AFhXYABuWp67xVm1/QWjVczxEgaNM/sQhZtfwIBRjF6vbBI
	 OnG+/9iYwdhkHoviqBy6/tzuvayqt4/d19VX3485flE18564NTpogg2T7yl0I4splKObb
	 ks2Oh4s1dvvmNCE8hLERgpr4mFUtdPR5J4qW5YOTtPvZACbuP7UpuIvk8w945Rob+mL0q
	 ZlmwzZc2yw6yfu3rCMqzfPK7inmO9xHIQniCf9ZJXFt15szoM36UtF1OE62sEYakO0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lGz3NLbp;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45740606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45740606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lGz3NLbp
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261116095125euoutp02dd7311925a25e954cb61e031b8f14484~ofbkaiqdm1545715457euoutp02L
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:51:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261116095125euoutp02dd7311925a25e954cb61e031b8f14484~ofbkaiqdm1545715457euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794822685;
	bh=r1/VRU/vGDJ8CYD8ahbybXIE2uq73+EPqpl2ADlA0hc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lGz3NLbpztdCAJkSUgTQ+HWAjNs74m5KEHFHA52dFZ+A2NAyzD4WKZHRWlH5S9x8g
	 UMB3LYxKwjK0Z3epcN9YMFBileueZzplPOGMPJ5fMGJXZ4itUlY648pr4ID0ZCcOmg
	 tmbDcmA3kpfO5rVNq3gNiMAhmI9rtLv0QwPH0Mr8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261116095125eucas1p23cc09ac574344adb6af7b98f2c17d1d8~ofbkLsCE30199601996eucas1p22;
	Mon, 16 Nov 2026 09:51:25 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261116095124eusmtip2244698a9c9b6675e60c1a1d139dce1ef~ofbjvVDDL0539005390eusmtip21;
	Mon, 16 Nov 2026 09:51:24 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Russell King
	<linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] amba: Fix race condition during DMA configure at IOMMU
 probe time
Date: Mon, 16 Nov 2026 10:51:09 +0100
Message-ID: <20261116095110.1490284-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261116095125eucas1p23cc09ac574344adb6af7b98f2c17d1d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261116095125eucas1p23cc09ac574344adb6af7b98f2c17d1d8
X-EPHeader: CA
X-CMS-RootMailID: 20261116095125eucas1p23cc09ac574344adb6af7b98f2c17d1d8
References: <CGME20261116095125eucas1p23cc09ac574344adb6af7b98f2c17d1d8@eucas1p2.samsung.com>

amba_dma_configure() can be called from the IOMMU layer via
iommu_init_device() with iommu_probe_device_lock dropped, while the
driver core is concurrently binding a driver to the same device.
In that case dev->driver may change between the moment @drv is
computed at the function entry and the moment dev->driver is checked
again before dereferencing @drv:

  Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
  ...
  pc : amba_dma_configure+0x3c/0x74
  lr : amba_dma_configure+0x2c/0x74
  ...
  Call trace:
   amba_dma_configure+0x3c/0x74 (P)
   __iommu_probe_device+0x408/0x4bc
   probe_iommu_group+0x3c/0x64
   bus_for_each_dev+0x7c/0xe0
   iommu_device_register+0xd4/0x248
   arm_smmu_device_probe+0xc08/0xea8
   platform_probe+0x5c/0x9c
   ...

This has been observed on the Thundercomm RUBIK Pi 3 board, where the
deferred probe of the GPU SMMU raced with the probe of the CoreSight
AMBA devices.

Fix this the same way as it has been done for the platform bus in
commit 95deee37a123 ("platform: Fix race condition during DMA configure
at IOMMU probe time"): read dev->driver only once with READ_ONCE() and
use that local copy both for the NULL check and for accessing the
driver_managed_dma flag.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The issue was observed on the real Thundercomm RubikPi3 board, then
analyzed with LLM assistance.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/amba/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d721d64a9858..bf0bc4f70134 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -324,7 +324,7 @@ static void amba_shutdown(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
-	struct amba_driver *drv = to_amba_driver(dev->driver);
+	struct device_driver *drv = READ_ONCE(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
@@ -335,8 +335,8 @@ static int amba_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, attr);
 	}
 
-	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (!ret && dev->driver && !drv->driver_managed_dma) {
+	/* @dev->driver may not be valid when we're called from the IOMMU layer */
+	if (!ret && drv && !to_amba_driver(drv)->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);
-- 
2.43.0

