Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089BCC4332B
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819F622B3B
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819F622B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D13086F8F;
	Tue, 26 Jan 2021 06:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mA-6jri57QBi; Tue, 26 Jan 2021 06:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17E4786FE8;
	Tue, 26 Jan 2021 06:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC13C0FA7;
	Tue, 26 Jan 2021 06:01:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AB3CC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D98592036D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btyJteyqVxXt for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 06:01:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by silver.osuosl.org (Postfix) with ESMTP id 2088D20367
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:01:10 +0000 (UTC)
X-UUID: beee6b93ef014787948b329bda876e1d-20210126
X-UUID: beee6b93ef014787948b329bda876e1d-20210126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 595013166; Tue, 26 Jan 2021 14:01:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 14:01:04 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 14:01:03 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: [PATCH v2] memory: mtk-smi: Support SMI modular
Date: Tue, 26 Jan 2021 14:00:55 +0800
Message-ID: <20210126060055.11050-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-TM-SNTS-SMTP: 413277F7CA28486647A4C0608B164AEC3EA3B448FD5BFC262DF895F4FE03C3FF2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

This patch mainly support SMI modular. Switch MTK_SMI to tristate,
and add module_exit/module_license.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
This patch rebase on the clean v5.11-rc1.
and this one: memory: mtk-smi: Use platform_register_drivers
https://lore.kernel.org/linux-arm-kernel/20210121062429.26504-2-yong.wu@mediatek.com/

change note:
a) squash the last two of v1 into one patch.
b) Remove module_alias
---
 drivers/memory/Kconfig     | 2 +-
 drivers/memory/mtk-smi.c   | 9 +++++++++
 include/soc/mediatek/smi.h | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 3ea6913df176..05c6d4a32285 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -173,7 +173,7 @@ config JZ4780_NEMC
 	  memory devices such as NAND and SRAM.
 
 config MTK_SMI
-	bool "Mediatek SoC Memory Controller driver" if COMPILE_TEST
+	tristate "MediaTek SoC Memory Controller driver" if COMPILE_TEST
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	help
 	  This driver is for the Memory Controller module in MediaTek SoCs,
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index e2aebd2bfa8e..3a269415db73 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -597,3 +597,12 @@ static int __init mtk_smi_init(void)
 	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
 }
 module_init(mtk_smi_init);
+
+static void __exit mtk_smi_exit(void)
+{
+	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
+}
+module_exit(mtk_smi_exit);
+
+MODULE_DESCRIPTION("MediaTek SMI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 5a34b87d89e3..29e2fb8f33d6 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -9,7 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 
-#ifdef CONFIG_MTK_SMI
+#if IS_ENABLED(CONFIG_MTK_SMI)
 
 #define MTK_LARB_NR_MAX		16
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
