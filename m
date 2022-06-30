Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D09C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 09:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6058261328;
	Thu, 30 Jun 2022 09:36:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6058261328
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHyGf1DK9az0; Thu, 30 Jun 2022 09:36:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DAAA260B52;
	Thu, 30 Jun 2022 09:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DAAA260B52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DCC3C002D;
	Thu, 30 Jun 2022 09:36:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6E7C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BD8084387
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:36:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BD8084387
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZYuQCdLcnDs for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:36:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FB188452F
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FB188452F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:36:32 +0000 (UTC)
X-UUID: 91504978c4f14f459b6699b60db35cb8-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:b54d77d8-e192-46cc-8eb2-4bf84182d200, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:-5
X-CID-META: VersionHash:87442a2, CLOUDID:28e00d63-0b3f-4b2c-b3a6-ed5c044366a0,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 91504978c4f14f459b6699b60db35cb8-20220630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 896558495; Thu, 30 Jun 2022 17:36:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 30 Jun 2022 17:36:25 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 30 Jun 2022 17:36:24 +0800
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Yong Wu <Yong.Wu@mediatek.com>, Miles Chen
 <miles.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v12 0/2] iommu/mediatek: TTBR up to 35bit support
Date: Thu, 30 Jun 2022 17:29:24 +0800
Message-ID: <20220630092927.24925-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo Kang <Libo.Kang@mediatek.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning Li <ning.li@mediatek.com>,
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
From: "yf.wang--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: yf.wang@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patchset adds MediaTek TTBR up to 35bit support for single normal zone.

Changes in v12:
- Update [PATCH 1/2]: remove GENMASK(31, 7)
- Update [PATCH 2/2]: remove MMU_PT_ADDR_MASK definition.

Changes in v11:
https://lore.kernel.org/linux-mediatek/20220630062508.23512-1-yf.wang@mediatek.com/
- According to Yong's suggestion in [PATCH v10] to update patch
  - [PATCH 1/2]: Because keep ttbr u32, so the special logic of encoded PA
    bits[34:32] to ttbr lower bits will apply to all the MediaTek cases,
    not only for the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT, so remove
    quirk check.
  - [PATCH 2/2]: Because no need calculate the special ttbr, so remove ttbr
    from mtk_iommu_domain and remove MMU_PT_ADDR_MASK calculate.

Changes in v10:
https://lore.kernel.org/linux-mediatek/20220616120713.12728-1-yf.wang@mediatek.com/
- According to Robin's suggestion in [PATCH v9] to update patch
  - Recovery ttbr to u32, encoded PA bits[34:32] to ttbr lower bits.
  - Remove PATCH: Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR.

Changes in v9:
https://lore.kernel.org/linux-mediatek/20220615161224.6923-1-yf.wang@mediatek.com/
- According to Will's suggestion in [PATCH v8 1/3] update [PATCH 1/3]
  - Rename function to_iopte_mtk to to_mtk_iopte.
  - Modify gfp_l1 and slab_flag and add comment explaining.
  - Add checking that the address is within 35 bits use cfg->oas.
  - PATCH 1/3 & PATCH 2/3 no change.

Changes in v8:
https://lore.kernel.org/linux-mediatek/20220611102656.10954-1-yf.wang@mediatek.com/
- Add and update patch
  - Add [2/3] patch update MTK_IOMMU_ADDR to calculate the special ttbr.
  - Save the special ttbr to mtk_iommu_domain avoid calculate it again.

Changes in v7:
https://lore.kernel.org/linux-mediatek/20220530080432.29123-1-yf.wang@mediatek.com/
- Update patch and commit message
  - Extend arm_v7s_cfg.ttbr to u64.
  - Move the special ttbr logical into mtk_iommu.c.
  - Update commit message for single normal zone.

Changes in v6:
- Update patch: gfp_l1 = GFP_KERNEL | __GFP_ZERO;
- Update commit message for single normal zone.

Changes in v5:
- Only update message-ID.

Changes in v4:
- Fix build test WARNING: use GENMASK_ULL replace GENMASK.

Changes in v3:
- Add version changes description, there is No new code change in V3.

Changes in v2:
- Update patch and commit message
  - Add Level 1 pgtable PA up to 35bit.
  - This is new feature, remove stable@vger.kernel.org
  - Update commit message.

Ning Li (2):
  iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
  iommu/mediatek: Allow page table PA up to 35bit

 drivers/iommu/io-pgtable-arm-v7s.c | 75 ++++++++++++++++++++++--------
 drivers/iommu/mtk_iommu.c          | 13 +++--
 include/linux/io-pgtable.h         | 15 ++++--
 3 files changed, 73 insertions(+), 30 deletions(-)


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
