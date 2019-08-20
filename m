Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4EC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 14:58:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DF422DBF
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 14:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DF422DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 34675E46;
	Tue, 20 Aug 2019 14:58:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E5CEBB3
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 14:58:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 24AFA89B
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 14:58:33 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 8A0C7AE6D;
	Tue, 20 Aug 2019 14:58:31 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
	marc.zyngier@arm.com, robh+dt@kernel.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/11] arm: use generic dma_zone_size
Date: Tue, 20 Aug 2019 16:58:10 +0200
Message-Id: <20190820145821.27214-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: phill@raspberryi.org, f.fainelli@gmail.com, frowand.list@gmail.com,
	Russell King <linux@armlinux.org.uk>, eric@anholt.net,
	mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org,
	akpm@linux-foundation.org, will@kernel.org, nsaenzjulienne@suse.de
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

'dma_zone_size' was created as a generic replacement to
'arm_dma_zone_size'. Use it accordingly.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2: None

 arch/arm/include/asm/dma.h |  8 +++++---
 arch/arm/mm/init.c         | 12 ++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..52d19ffd92b4 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -2,16 +2,18 @@
 #ifndef __ASM_ARM_DMA_H
 #define __ASM_ARM_DMA_H
 
+#include <asm-generic/dma.h>
+
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
+#undef MAX_DMA_ADDRESS
 #ifndef CONFIG_ZONE_DMA
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
 #define MAX_DMA_ADDRESS	({ \
-	extern phys_addr_t arm_dma_zone_size; \
-	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
-		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
+	dma_zone_size && dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
+		(PAGE_OFFSET + dma_zone_size) : 0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 16d373d587c4..95680bad245a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -79,10 +79,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 }
 
 #ifdef CONFIG_ZONE_DMA
-
-phys_addr_t arm_dma_zone_size __read_mostly;
-EXPORT_SYMBOL(arm_dma_zone_size);
-
 /*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
@@ -109,8 +105,8 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
-		arm_dma_zone_size = mdesc->dma_zone_size;
-		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
+		dma_zone_size = mdesc->dma_zone_size;
+		arm_dma_limit = PHYS_OFFSET + dma_zone_size - 1;
 	} else
 		arm_dma_limit = 0xffffffff;
 	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
@@ -164,9 +160,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	if (arm_dma_zone_size)
+	if (dma_zone_size)
 		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
+			dma_zone_size >> PAGE_SHIFT);
 #endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
