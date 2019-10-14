Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992FAC4CECE
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 18:31:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8025A21925
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 18:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8025A21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E522E2D11;
	Mon, 14 Oct 2019 18:31:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3C9292D06
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 18:31:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76F96821
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 18:31:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id D755DBB7D;
	Mon, 14 Oct 2019 18:31:49 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] ARM: introduce arm_dma_direct
Date: Mon, 14 Oct 2019 20:31:04 +0200
Message-Id: <20191014183108.24804-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: f.fainelli@gmail.com, Russell King <linux@armlinux.org.uk>,
	mbrugger@suse.com, wahrenst@gmx.net,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

ARM devices might use the arch's custom dma-mapping implementation or
dma-direct/swiotlb depending on how the kernel is built. This is not
good enough as we need to be able to control the device's DMA ops based
on the specific machine configuration.

Centralise control over DMA ops with arm_dma_direct, a global variable
which will be set accordingly during init.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/include/asm/dma-mapping.h |  3 ++-
 arch/arm/include/asm/dma.h         |  2 ++
 arch/arm/mm/dma-mapping.c          | 10 ++--------
 arch/arm/mm/init.c                 | 13 +++++++++++++
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca34..b19af5c55bee 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -8,6 +8,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
+#include <asm/dma.h>
 #include <asm/memory.h>
 
 #include <xen/xen.h>
@@ -18,7 +19,7 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	if (IS_ENABLED(CONFIG_MMU) && !IS_ENABLED(CONFIG_ARM_LPAE))
+	if (IS_ENABLED(CONFIG_MMU) && !arm_dma_direct)
 		return &arm_dma_ops;
 	return NULL;
 }
diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..d386719c53cd 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -14,6 +14,8 @@
 		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
 #endif
 
+extern bool arm_dma_direct __ro_after_init;
+
 #ifdef CONFIG_ISA_DMA_API
 /*
  * This is used to support drivers written for the x86 ISA DMA API.
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 13ef9f131975..172eea707cf7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -27,6 +27,7 @@
 #include <linux/sizes.h>
 #include <linux/cma.h>
 
+#include <asm/dma.h>
 #include <asm/memory.h>
 #include <asm/highmem.h>
 #include <asm/cacheflush.h>
@@ -1100,14 +1101,7 @@ int arm_dma_supported(struct device *dev, u64 mask)
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
-	/*
-	 * When CONFIG_ARM_LPAE is set, physical address can extend above
-	 * 32-bits, which then can't be addressed by devices that only support
-	 * 32-bit DMA.
-	 * Use the generic dma-direct / swiotlb ops code in that case, as that
-	 * handles bounce buffering for us.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_LPAE))
+	if (arm_dma_direct)
 		return NULL;
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
 }
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index b4be3baa83d4..0a63379a4d1a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -105,8 +105,21 @@ static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
 }
 #endif
 
+bool arm_dma_direct __ro_after_init;
+EXPORT_SYMBOL(arm_dma_direct);
+
 void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
+	/*
+	 * When CONFIG_ARM_LPAE is set, physical address can extend above
+	 * 32-bits, which then can't be addressed by devices that only support
+	 * 32-bit DMA.
+	 * Use the generic dma-direct / swiotlb ops code in that case, as that
+	 * handles bounce buffering for us.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_LPAE))
+		arm_dma_direct = true;
+
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
 		arm_dma_zone_size = mdesc->dma_zone_size;
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
