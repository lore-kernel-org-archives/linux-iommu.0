Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8AC433EC
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C4820720
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ogxD5nZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C4820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 912AE89AB6;
	Sat, 11 Jul 2020 06:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FA7qwRkyPOB8; Sat, 11 Jul 2020 06:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16EEF887D9;
	Sat, 11 Jul 2020 06:50:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F335FC088E;
	Sat, 11 Jul 2020 06:50:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61690C016F
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4954E88334
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sc9GslZyY9Fu for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:49:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 04BCB88328
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:49:48 +0000 (UTC)
X-UUID: 16e9aa3a37264cdeb66c1b05d55a8ea9-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=vwYwfmBuQ9EeaF9o2hLTJCCqrK2cnovh37RuGZvptlA=; 
 b=ogxD5nZ5xaqn2O6DU45WGIt10Ix+cItMJ86xGrFDF1nd1rk3bSmJV7Dm6rkoSd0Ln+jd8bkZjOydmYdEvMESb7BiKiW7i9KbDp/NmDZscGbqpwlForPAcrpKJ8aUf7Ae9n9dapZ1t5BZyiDzroljpMmSBbStKRra7aZ1hq91BhA=;
X-UUID: 16e9aa3a37264cdeb66c1b05d55a8ea9-20200711
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 979733848; Sat, 11 Jul 2020 14:49:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:49:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:49:34 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 00/21] MT8192 IOMMU support
Date: Sat, 11 Jul 2020 14:48:25 +0800
Message-ID: <20200711064846.16007-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-TM-SNTS-SMTP: A82A830F0FA76FCD9B4AB531CB0600E0FA50BF41F1516541BB4CA6E4B4AA79502000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Tomasz
 Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
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

This patch mainly adds support for mt8192 IOMMU and SMI.

mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
table format. The M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                      ------------
                       SMI Common
                      ------------
                           |
  +-------+------+------+----------------------+-------+
  |       |      |      |       ......         |       |
  |       |      |      |                      |       |
larb0   larb1  larb2  larb4     ......      larb19   larb20
disp0   disp1   mdp    vdec                   IPE      IPE

All the connections are HW fixed, SW can NOT adjust it.

Comparing with the preview SoC, this patchset also adds two functions:
a) add iova 34 bits support.
b) add multi domains support since several HW has the special iova
region requirement.

this patchset depend on v5.8-rc1 and mt6779 iommu[1].

[1]https://lore.kernel.org/linux-iommu/20200703044127.27438-1-chao.hao@mediatek.com/

Yong Wu (21):
  dt-binding: memory: mediatek: Add a common larb-port header file
  dt-binding: memory: mediatek: Extend LARB_NR_MAX to 32
  dt-binding: memory: mediatek: Add domain definition
  dt-binding: mediatek: Add binding for mt8192 IOMMU and SMI
  iommu/mediatek: Use the common mtk-smi-larb-port.h
  iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
  iommu/io-pgtable-arm-v7s: Extend PA34 for MediaTek
  iommu/io-pgtable-arm-v7s: Add cfg as a param in some macros
  iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
  iommu/mediatek: Add device link for smi-common and m4u
  iommu/mediatek: Add power-domain operation
  iommu/mediatek: Add iova reserved function
  iommu/mediatek: Make MTK_IOMMU depend on ARM64
  iommu/mediatek: Add single domain
  iommu/mediatek: Support master use iova over 32bit
  iommu/mediatek: Support up to 34bit iova in tlb invalid
  iommu/mediatek: Support report iova 34bit translation fault in ISR
  iommu/mediatek: Add support for multi domain
  iommu/mediatek: Adjust the structure
  iommu/mediatek: Add mt8192 support
  memory: mtk-smi: Add mt8192 support

 .../bindings/iommu/mediatek,iommu.txt         |   8 +-
 .../mediatek,smi-common.txt                   |   5 +-
 .../memory-controllers/mediatek,smi-larb.txt  |   3 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/io-pgtable-arm-v7s.c            |  51 ++--
 drivers/iommu/mtk_iommu.c                     | 265 +++++++++++++++---
 drivers/iommu/mtk_iommu.h                     |  11 +-
 drivers/memory/mtk-smi.c                      |  25 ++
 include/dt-bindings/memory/mt2712-larb-port.h |   2 +-
 include/dt-bindings/memory/mt6779-larb-port.h |   2 +-
 include/dt-bindings/memory/mt8173-larb-port.h |   2 +-
 include/dt-bindings/memory/mt8183-larb-port.h |   2 +-
 include/dt-bindings/memory/mt8192-larb-port.h | 237 ++++++++++++++++
 .../dt-bindings/memory/mtk-smi-larb-port.h    |  22 ++
 include/linux/io-pgtable.h                    |   4 +-
 include/soc/mediatek/smi.h                    |   3 +-
 16 files changed, 565 insertions(+), 78 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
 create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h

-- 
2.18.0 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
