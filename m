Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFBFC04AAB
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 18:53:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B154620B7C
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JFf67WwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B154620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 07E065244;
	Mon,  6 May 2019 18:53:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 831E35243
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 18:53:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC69C837
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 18:53:02 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id e24so16324578edq.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ybQIpJHlWaFs/zU9bGDFvVwxe0GuybJKNVxIUx2IidQ=;
	b=JFf67WwYhFLm0sTPsKCR4MLJ0rPWCvtSCjSSI4/WRj/g9uerAOoO3YHngKXqV5XRDA
	BsbOZnljWpcXPUXX/jdN2xuHesc6zNY0itBP+Fnyyrju3F9JKQ0g/s7Ckwv7CC2oFl1z
	wI0b3z3GIBx6hJ/4s6XRLBTMGNolbKMrJ0Vb3tg01k29lvgmr+SxiJ/TBbe4Qq9DsrKF
	qQiEaIlqgSuvkr/cE/rrrDO7H+Q6t/rD5v/qYXgdM3iw1x5tIh+qOQo1qf2dmaa/9AK4
	IrFWN83fIgwTfxZdeZHp0uHV/tDIwiIQrAP0r7XVNfccsjI2qQbvZKc+B08HsaVF6EPb
	B2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ybQIpJHlWaFs/zU9bGDFvVwxe0GuybJKNVxIUx2IidQ=;
	b=crqGZlLDYzV002j9Y1oZzQK3KdxCPlXtOLuUNe40R4jEvRqH1EI68uFsHWR34v8gbF
	OuBLEIHkHdNn3bVyxSWTdGVdDlnhGCjgzopw9AmeZ43GLhIUxSpD4yUFn1cUVlasxN12
	MRLlOHnBWyXhpeA9J1vo0W7PalyLAOEkuwzamGIm9GtUmBHfJiQTrhVBNCQKdwquqt3t
	zrRBvcN/b4PWwM41cKSBq6eST2aTisWnd5jirDd004HHcw0dHAYUgqyCyZCUTEHT5Agd
	/4jfRS/TTMrqcGHGDOkDth4fPf39sm+3Xh0TApR5S0uRf4wdwjS13P2RgPWZ2Os8uDuD
	aaHg==
X-Gm-Message-State: APjAAAXh2QwpYsYZtWB2X/0CxDqW5dOqViIKc+x3VHyiDVq4RBxuaXJt
	Pua9kOhuOxpBYd6dHLUUPlGFhK+xW3nIFQ==
X-Google-Smtp-Source: APXvYqy6IgposVXar6I91KdFzVPePJ0WSHgH7cCqvKmX63+rZDsgMJaDXv+5YPJR8LEJQrNd+kLsNA==
X-Received: by 2002:a17:907:1059:: with SMTP id
	oy25mr8017394ejb.118.1557168781318; 
	Mon, 06 May 2019 11:53:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:d9d9:922a:828d:a50e])
	by smtp.gmail.com with ESMTPSA id
	e35sm3361412eda.2.2019.05.06.11.52.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 11:53:00 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v3 2/4] iommu/dma-iommu: Handle deferred devices
Date: Mon,  6 May 2019 19:52:04 +0100
Message-Id: <20190506185207.31069-3-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506185207.31069-1-tmurphy@arista.com>
References: <20190506185207.31069-1-tmurphy@arista.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Tom Murphy <tmurphy@arista.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Handle devices which defer their attach to the iommu in the dma-iommu api

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/dma-iommu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a96c2c8f56b..b383498e2dc3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -322,6 +323,22 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	return iova_reserve_iommu_regions(dev, domain);
 }
 
+static int handle_deferred_device(struct device *dev)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *ops;
+
+	if (!is_kdump_kernel())
+		return 0;
+
+	domain = iommu_get_domain_for_dev(dev);
+	ops = domain->ops;
+	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
+		return iommu_attach_device(domain, dev);
+
+	return 0;
+}
+
 /**
  * dma_info_to_prot - Translate DMA API directions and attributes to IOMMU API
  *                    page flags.
@@ -835,7 +852,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	bool coherent = dev_is_dma_coherent(dev);
 	dma_addr_t dma_handle;
 
-	dma_handle =__iommu_dma_map(dev, phys, size,
+	if (unlikely(handle_deferred_device(dev)))
+		return DMA_MAPPING_ERROR;
+
+	dma_handle = __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, coherent, attrs),
 			iommu_get_dma_domain(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
@@ -953,6 +973,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
+	if (unlikely(handle_deferred_device(dev)))
+		return 0;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
@@ -1056,6 +1079,9 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	if (unlikely(handle_deferred_device(dev)))
+		return NULL;
+
 	gfp |= __GFP_ZERO;
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
