Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3568AC433E2
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5052332F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kf11B4z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5052332F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4CFA89357;
	Mon, 29 Jun 2020 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eAHghLXEdWOY; Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7C86F8936D;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E786C0895;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19803C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F3DA288580
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJzPeFJs4tfa for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id F0D2C8859C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:19 +0000 (UTC)
X-UUID: 989a9aedb14f42eb9622a687f3483f8d-20200629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=eQSffpyY3QwD6v9nyZvoSuQ+Lu76geQsw/vxH4WGBnE=; 
 b=Kf11B4z/+Imfoj75543OrjLE5xE2OKbJ6PXQh67A8TpGIr/svPPhIbMFTO08NLS1WKAgjS5iPxUfUvReksyIZJDrPvg7xgcm3CfKyY8xdrGQJCsJT51HanqVeWkh2bRQBZWn7DCFQ4KtC3glO2k2wIgxuMy7Yo2nyBUPvLJa1Zo=;
X-UUID: 989a9aedb14f42eb9622a687f3483f8d-20200629
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 888407227; Mon, 29 Jun 2020 15:14:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Jun 2020 15:14:07 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Jun 2020 15:14:07 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: [PATCH v5 00/10] MT6779 IOMMU SUPPORT
Date: Mon, 29 Jun 2020 15:13:00 +0800
Message-ID: <20200629071310.1557-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-TM-SNTS-SMTP: EB340D25FCF0995099D65A6A691B61DC50D13EB1B663B4F80CE82A4AA1C94A382000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

This patchset adds mt6779 iommu support.
mt6779 has two iommus, they are MM_IOMMU(M4U) and APU_IOMMU which used ARM Short-Descriptor translation format.
The mt6779's MM_IOMMU-SMI and APU_IOMMU HW diagram is as below, it is only a brief diagram:

                       EMI
		        |
      --------------------------------------
      |                                    |
   MM_IOMMU                            APU_IOMMU
      |                                    |
   SMI_COMMOM-----------                 APU_BUS
      |                |                   |
   SMI_LARB(0~11)      |                   |
      |                |                   |
      |                |             --------------
      |                |             |     |      |
 Multimedia engine    CCU           VPU   MDLA   EMDA

 All the connections are hardware fixed, software can not adjust it.
 Compared with mt8183, SMI_BUS_ID width has changed from 10 to 12. SMI Larb number is described in bit[11:7],
 Port number is described in bit[6:2]. In addition, there are some registers has changed in mt6779, so we need
 to redefine and reuse them.

 The patchset only used MM_IOMMU, so we only add MM_IOMMU basic function, such as smi_larb port definition, registers
 definition and hardware initialization.

 change notes:
  v5:
   1. Split "iommu/mediatek: Add mt6779 IOMMU basic support(patch v4)" to three patches(from PATCH v5 08/10 to PATCH v5 10/10).
   2. Use macro definitions to replace bool values in mtk_iommu_plat_data structure

  v4:
   1. Rebase on v5.8-rc1.
   2. Fix coding style.
   3. Add F_MMU_IN_DRDER_WR_EN definition in MISC_CTRL to improve performance.
  https://lkml.org/lkml/2020/6/16/1741

  v3:
   1. Rebase on v5.7-rc1.
   2. Remove unused port definition,ex:APU and CCU port in mt6779-larb-port.h.
   3. Remove "change single domain to multiple domain" part(from PATCH v2 09/19 to PATCH v2 19/19).
   4. Redesign mt6779 basic part
      (1)Add some register definition and reuse them.
      (2)Redesign smi larb bus ID to analyze IOMMU translation fault.
      (3)Only init MM_IOMMU and not use APU_IOMMU.
  http://lists.infradead.org/pipermail/linux-mediatek/2020-May/029811.html

  v2:
   1. Rebase on v5.5-rc1.
   2. Delete M4U_PORT_UNKNOWN define because of not use it.
   3. Correct coding format.
   4. Rename offset=0x48 register.
   5. Split "iommu/mediatek: Add mt6779 IOMMU basic support(patch v1)" to several patches(patch v2).
  http://lists.infradead.org/pipermail/linux-mediatek/2020-January/026131.html

  v1:
  http://lists.infradead.org/pipermail/linux-mediatek/2019-November/024567.html


Chao Hao (10):
  dt-bindings: mediatek: Add bindings for MT6779
  iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_CTRL
  iommu/mediatek: Modify the usage of mtk_iommu_plat_data structure
  iommu/mediatek: Setting MISC_CTRL register
  iommu/mediatek: Move inv_sel_reg into the plat_data
  iommu/mediatek: Add sub_comm id in translation fault
  iommu/mediatek: Add REG_MMU_WR_LEN register definition
  iommu/mediatek: Extend protect pa alignment value
  iommu/mediatek: Modify MMU_CTRL register setting
  iommu/mediatek: Add mt6779 basic support

  .../bindings/iommu/mediatek,iommu.txt         |   2 +
  drivers/iommu/mtk_iommu.c                     | 100 ++++++---
  drivers/iommu/mtk_iommu.h                     |  26 ++-
  include/dt-bindings/memory/mt6779-larb-port.h | 206 ++++++++++++++++++
  include/soc/mediatek/smi.h                    |   2 +
  5 files changed, 299 insertions(+), 37 deletions(-)

--
2.18.0







_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
