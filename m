Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_ALL_CAPS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE76C11F6A
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2A961D81
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 02:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2A961D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4543E606DC;
	Wed, 30 Jun 2021 02:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6UPkoMr7da8; Wed, 30 Jun 2021 02:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C442D6065C;
	Wed, 30 Jun 2021 02:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73435C0010;
	Wed, 30 Jun 2021 02:35:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B648C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 104026065C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6daH9bKDSZF for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 02:35:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5EA6606DC
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 02:35:42 +0000 (UTC)
X-UUID: 5911c5eb51dc4d4887087db639e97605-20210630
X-UUID: 5911c5eb51dc4d4887087db639e97605-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1746401114; Wed, 30 Jun 2021 10:35:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:35:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:35:12 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 00/24] MT8195 IOMMU SUPPORT
Date: Wed, 30 Jun 2021 10:34:40 +0800
Message-ID: <20210630023504.18177-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, chao.hao@mediatek.com,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

This patchset add mt8195 iommu supports.

mt8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
for infra-master, like PCIe/USB.

About the 2 MM IOMMU HW, something like this:

        IOMMU(VDO)          IOMMU(VPP)
           |                   |
      SMI_COMMON(VDO)      SMI_COMMON(VPP)
      ---------------     ----------------
      |      |   ...      |      |     ...
    larb0 larb2  ...    larb1 larb3    ...

these two MM IOMMU HW share a pgtable.

About the INFRA IOMMU, it don't have larbs, the master connects the iommu
directly. It use a dependent pgtable.

Also, mt8195 IOMMU bank supports..Normally the IOMMU register size only
is 0x1000. In this IOMMU HW, the register size is 5 * 0x1000. each 0x1000
is a bank. the banks' register look like this:
     ----------------------------------------
     |bank0  | bank1 | bank2 | bank3 | bank4|
     ----------------------------------------
     |global |
     |control|         null
     |regs   |
     -----------------------------------------
     |bank   |bank   |bank   |bank   |bank   |
     |regs   |regs   |regs   |regs   |regs   |
     |       |       |       |       |       |
     -----------------------------------------
All the banks share some global control registers, and each bank have its
special bank registers, like pgtable base registser, tlb operation registers,
the fault status registers.
 
In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
and USB in bank4. they have independent pgtable.

patch[1..15]:  support mt8195 iommu. 
patch[16..24]: support bank feature.

base on v5.13-rc1.

todo: there is another APU_IOMMU in mt8195, this should depend on APU patches.
thus, we need add that feature after that.

---
Yong Wu (24):
  dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
  dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
  iommu/mediatek: Fix 2 HW sharing pgtable issue
  iommu/mediatek: Adapt sharing and non-sharing pgtable case
  iommu/mediatek: Add 12G~16G support for mult domain
  iommu/mediatek: Add a flag DCM_DISABLE
  iommu/mediatek: Add flag NON_STD_AXI
  iommu/mediatek: Remove for_each_m4u in tlb_sync_all
  iommu/mediatek: Always pm_runtime_get while tlb flush
  iommu/mediatek: Always enable output PA over 32bits
  iommu/mediatek: Add SUB_COMMON_3BITS flag
  iommu/mediatek: Add IOMMU_TYPE flag
  iommu/mediatek: Add infra iommu support
  iommu/mediatek: Add PCIe support
  iommu/mediatek: Add mt8195 support
  iommu/mediatek: Only adjust code about register base
  iommu/mediatek: Just move code position in hw_init
  iommu/mediatek: Add mtk_iommu_bank_data structure
  iommu/mediatek: Initialise bank HW for each a bank
  iommu/mediatek: Add bank_nr and bank_enable
  iommu/mediatek: Change the domid to iova_region_id
  iommu/mediatek: Get the proper bankid for multi banks
  iommu/mediatek: Add multi bank support
  iommu/mediatek: mt8195: Enable multi-bank for infra iommu

 .../bindings/iommu/mediatek,iommu.yaml        |  21 +-
 drivers/iommu/mtk_iommu.c                     | 760 ++++++++++++------
 drivers/iommu/mtk_iommu.h                     |  33 +-
 .../dt-bindings/memory/mt8195-memory-port.h   | 408 ++++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   2 +
 5 files changed, 961 insertions(+), 263 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h

-- 
2.18.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
