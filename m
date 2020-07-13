Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B7CC433E4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7919B2068F
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxAF0ZDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919B2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4212C2272C;
	Mon, 13 Jul 2020 09:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRcX8zPB8PB3; Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6E8822264C;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D8CDC08A0;
	Mon, 13 Jul 2020 09:35:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED77DC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCC8E88E98
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Y456MtbLB8P for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 09:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3F455888CB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 09:12:45 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id b92so5935498pjc.4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wW9UG9GkA5eq2tRO9SfLLrAbTAFpGwf7ilxMSntDIQU=;
 b=YxAF0ZDWNLRZbwatioa2W5wcq4CfxtsxsHlwEUn8kgIb6fCeDsCrWleQlNqOvMXiJ+
 LOoq5CKoHitDi5bruIZe80ea/NHJk8Y7SPSlkaSj1cpKaSzzyLmt4+HU5BB+/Za+6ObR
 5vstthuC8jO7QKbBxZSldp54hw1ndXzecTz5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wW9UG9GkA5eq2tRO9SfLLrAbTAFpGwf7ilxMSntDIQU=;
 b=WvGJwL5p28x6CkVmSQDzC5mTJ/p0E6UviTYSJCkg0vdvOH8uajAJFdXEEJJkDjYSay
 3PSzR//wppKdnaaFn8MpSVzKjV3Jg97m1HX99fqtRfYglB9bZKN3XcPi8+mXuG5FrnRb
 ASJ8NDm2d9Wdu+eKr0UKK2A2FtUfqxJ54vATP6MApkJ91hB3+/t2PLTRIO2UPFDPGqy4
 dHfR0ItEdodz6u2Qwcnb0SpzOMXOjgVs8ZF2EtU/WtrF2zU13ym/P4HO3OuxbZr7d6Ls
 h7V26bzizbt/LWKj+IUarnle9t7yIehoW/uXUE7uY5IYlO/pzao2kSOrTFzsCHZCBgRf
 b3/g==
X-Gm-Message-State: AOAM533Sul9EgjqEdegmzXhKxyA2k4TdAuLEWiVlRvlk5/5R25hOhS91
 FtSIZQWAstGZdb46EGr7Eq0OAw==
X-Google-Smtp-Source: ABdhPJzFuHMhPXzcXoFvEGJ2D3yKj+lsnp095Bn7A6IGRnnd7qXSC1PeqLmbJsZOAM2xionjMj9p8A==
X-Received: by 2002:a17:90a:ea83:: with SMTP id
 h3mr19821787pjz.176.1594631564912; 
 Mon, 13 Jul 2020 02:12:44 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id d22sm13790576pfd.105.2020.07.13.02.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 02:12:44 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [PATCH 2/4] dma-mapping: Add bounced DMA pool
Date: Mon, 13 Jul 2020 17:12:09 +0800
Message-Id: <20200713091211.2183368-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713091211.2183368-1-tientzu@chromium.org>
References: <20200713091211.2183368-1-tientzu@chromium.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Jul 2020 09:35:23 +0000
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org,
 Claire Chang <tientzu@chromium.org>, dan.j.williams@intel.com,
 treding@nvidia.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add the initialization function to create bounce buffer pools from
matching reserved-memory nodes in the device tree.

The bounce buffer pools provide a basic level of protection against
the DMA overwriting buffer contents at unexpected times. However, to
protect against general data leakage and system memory corruption, the
system needs to provide a way to restrict the DMA to a predefined memory
region.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/bounced.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/kernel/dma/bounced.c b/kernel/dma/bounced.c
index fcaabb5eccf2..0bfd6cf90aee 100644
--- a/kernel/dma/bounced.c
+++ b/kernel/dma/bounced.c
@@ -12,6 +12,9 @@
 #include <linux/dma-noncoherent.h>
 #include <linux/io.h>
 #include <linux/genalloc.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 
 struct dma_bounced_mem {
@@ -213,3 +216,89 @@ const struct dma_map_ops dma_bounced_ops = {
 	.max_mapping_size	= dma_bounced_max_mapping_size,
 	.get_merge_boundary	= NULL,
 };
+
+static int dma_bounced_device_init(struct reserved_mem *rmem,
+				   struct device *dev)
+{
+	struct dma_bounced_mem *mem;
+	int ret;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	mem->virt_base =
+		devm_memremap(dev, rmem->base, rmem->size, MEMREMAP_WB);
+	if (!mem->virt_base) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	mem->size = rmem->size;
+	mem->device_base = phys_to_dma(dev, rmem->base);
+	mem->device_end = mem->device_base + rmem->size;
+
+	mem->orig_addr = kcalloc(mem->size >> PAGE_SHIFT,
+				 sizeof(*mem->orig_addr), GFP_KERNEL);
+	if (!mem->orig_addr) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	mem->pool = devm_gen_pool_create(dev, PAGE_SHIFT, NUMA_NO_NODE,
+					 "bounced DMA");
+	if (!mem->pool) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = gen_pool_add_virt(mem->pool, (unsigned long)mem->virt_base,
+				rmem->base, rmem->size, NUMA_NO_NODE);
+	if (ret)
+		goto error;
+
+	dev->dma_bounced_mem = mem;
+	set_dma_ops(dev, &dma_bounced_ops);
+
+	return 0;
+
+error:
+	kfree(mem);
+
+	return ret;
+}
+
+static void dma_bounced_device_release(struct reserved_mem *rmem,
+				       struct device *dev)
+{
+	struct dma_bounced_mem *mem = dev->dma_bounced_mem;
+
+	set_dma_ops(dev, NULL);
+	dev->dma_bounced_mem = NULL;
+
+	kfree(mem->orig_addr);
+	kfree(mem);
+}
+
+static const struct reserved_mem_ops rmem_dma_bounced_ops = {
+	.device_init	= dma_bounced_device_init,
+	.device_release	= dma_bounced_device_release,
+};
+
+static int __init dma_bounced_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_dma_bounced_ops;
+	pr_info("Reserved memory: created DMA bounced memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "bounced-dma-pool", dma_bounced_setup);
-- 
2.27.0.383.g050319c2ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
