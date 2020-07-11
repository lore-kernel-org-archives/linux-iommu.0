Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214CC433EC
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87CA20720
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VxaDBwba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87CA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B61C089B49;
	Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-cLPmllZ6Gg; Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3AFA988AE0;
	Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 261BFC088E;
	Sat, 11 Jul 2020 06:51:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C19BFC016F
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BCE8B88810
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oiOZZs3yx7hN for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2CBCC88334
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:52 +0000 (UTC)
X-UUID: 9f2f9c82384d48eab65d0cdff7e8ed94-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=X9X6VUl15O0QLqjDskaPZDckZoa2Ua3bbD5IeU7Lw9k=; 
 b=VxaDBwba6ry0rLEPWGVCgBQs2hX5YWuU/zE8PZeTbd20IU/9Fe+noVHlRdwYLbeXwZdzi85fdUWF7Qy41CPBleUkwM6dSPk3mYZyfSnkHkCk3is5xSOjUYNy0/j4L8/Ni5VYXgycm2yNAZRzujgh/6CKQldHSMRbXuzGEswPcYc=;
X-UUID: 9f2f9c82384d48eab65d0cdff7e8ed94-20200711
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 264599427; Sat, 11 Jul 2020 14:51:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:44 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 13/21] iommu/mediatek: Make MTK_IOMMU depend on ARM64
Date: Sat, 11 Jul 2020 14:48:38 +0800
Message-ID: <20200711064846.16007-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: DC67469FEF3469DEA3B505AC9A9CDD09FA042BA3EF01BF46EF49FD74EEF01B462000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

Originally MTK_IOMMU could depend on ARM || ARM64.
Both build ok. actually the source code don't support ARM.
this patch changes it only depend on ARM64.

This is a preparing patch for support multi-domain.
otherwise it will build warning in ARM case.

This is the build warning log:

drivers/iommu/mtk_iommu.c:163:27: note: in expansion of macro 'SZ_4G'
  {.iova_base = 0, .size = SZ_4G},
include/uapi/linux/const.h:20:19: warning: large integer implicitly truncated
to unsigned type [-Woverflow]
 #define __AC(X,Y) (X##Y)
                   ^
include/uapi/linux/const.h:21:18: note: in expansion of macro '__AC'
 #define _AC(X,Y) __AC(X,Y)
                  ^
include/linux/sizes.h:46:18: note: in expansion of macro '_AC'
 #define SZ_4G    _AC(0x100000000, ULL)

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b510f67dfa49..6bebfd3e0021 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -467,6 +467,7 @@ config S390_AP_IOMMU
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
 	depends on HAS_DMA
+	depends on ARM64
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
