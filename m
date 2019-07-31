Return-Path: <SRS0=24gJ=V4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F58CC32751
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 16:00:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC71206A2
	for <iommu@archiver.kernel.org>; Wed, 31 Jul 2019 16:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC71206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 232973EB7;
	Wed, 31 Jul 2019 15:59:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D2B03AA5
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 15:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CBAB3E7
	for <iommu@lists.linux-foundation.org>;
	Wed, 31 Jul 2019 15:48:06 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 4554EB020;
	Wed, 31 Jul 2019 15:48:05 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
	marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] arm64: re-introduce max_zone_dma_phys()
Date: Wed, 31 Jul 2019 17:47:47 +0200
Message-Id: <20190731154752.16557-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731154752.16557-1-nsaenzjulienne@suse.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: phill@raspberryi.org, f.fainelli@gmail.com, mbrugger@suse.com,
	frowand.list@gmail.com, eric@anholt.net, robh+dt@kernel.org,
	linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
	will@kernel.org, nsaenzjulienne@suse.de
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

Some devices might have multiple interconnects with different DMA
addressing limitations. This function provides the higher physical
address accessible by all peripherals on the SoC. If such limitation
doesn't exist it'll return 0.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 arch/arm64/mm/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8956c22634dd..1c4ffabbe1cb 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -174,6 +174,19 @@ static phys_addr_t __init max_zone_dma32_phys(void)
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
 }
 
+static phys_addr_t __init max_zone_dma_phys(void)
+
+{
+	u64 memory_size = memblock_end_of_DRAM() - memblock_start_of_DRAM();
+	u64 zone_dma_size;
+
+	of_scan_flat_dt(early_init_dt_dma_zone_size, &zone_dma_size);
+	if (zone_dma_size && zone_dma_size < min(memory_size, SZ_4G))
+		return memblock_start_of_DRAM() + zone_dma_size;
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
