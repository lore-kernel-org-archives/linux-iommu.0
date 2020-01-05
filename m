Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F7C33C8C
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:51:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A06221582
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 10:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mm9nNwvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A06221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AC188633B;
	Sun,  5 Jan 2020 10:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RyQL1sXTw-3y; Sun,  5 Jan 2020 10:51:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97EAA85A2E;
	Sun,  5 Jan 2020 10:51:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81393C1D84;
	Sun,  5 Jan 2020 10:51:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6CDBC0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D0C3985CE0
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1PYMLg16xK5N for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 10:51:32 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7B9EA85B36
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 10:51:32 +0000 (UTC)
X-UUID: 3bea9a535b7e4a3e9703a476143b1235-20200105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=lA5PzyXuyizUyRDDlXySD7ztXLzdwWD6WEfL0quguyU=; 
 b=Mm9nNwvcdYTBoA0oIgEh/5DwLQGgeYYRRSdRxD50lHMY3FkH8/l5mKBMnksK+mTHCaENlYj4Zrsj1HONsJVPPnWQQCv7DbxpqTcRj3GuwRCfINawFm2qZ20mb7WftGqqvVR+0BQVLNgUTPWlFYiaPR0KvK2oiOEpnDK2Munbhx4=;
X-UUID: 3bea9a535b7e4a3e9703a476143b1235-20200105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1689807649; Sun, 05 Jan 2020 18:46:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 5 Jan 2020 18:46:00 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 Jan 2020 18:44:56 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 00/19] MT6779 IOMMU SUPPORT
Date: Sun, 5 Jan 2020 18:45:04 +0800
Message-ID: <20200105104523.31006-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Cui Zhang <zhang.cui@mediatek.com>, linux-arm-kernel@lists.infradead.org
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


This patchset adds mt6779 iommu support and adjusts mtk iommu software architecture mainly.
1. Add mt6779 basic function, such as smi_larb port define, registers define and so on.
2. In addition, this patchset will adjust current mtk iommu SW architecture mainly to adapt all the mtk platforms:
   Firstly, mt6779 iommu can support more HW modules, but some modules have special requirements for iova region,
   for example, CCU only can access 0x4000_0000~0x47ff_ffff, VPU only can access 0x7da0_0000~0x7fbf_ffff. Current
   architecture only support one iommu domain(include 0~4GB), all the modules allocate iova from 0~4GB region, so
   it doesn't ensure to allocate expected iova region for special module(CCU and VPU). In order to resolve the problem,
   we will create different iommu domains for special module, and every domain can include iova region which module needs.
   Secondly, all the iommus share one page table for current architecture by "mtk_iommu_get_m4u_data", to make the
   architecture look clearly, we will create a global page table firstly(mtk_iommu_pgtable), and all the iommus can
   use it. One page table can include 4GB iova space, so multiple iommu domains are created based on the same page table.
   New SW architecture diagram is as below:

                         iommu0   iommu1
                            |        |
                            ----------
                                 |
                        mtk_iommu_pgtable
                                 |
            ------------------------------------------
            |                    |                   |
      mtk_iommu_domain1   mtk_iommu_domain2   mtk_iommu_domain3
            |                    |                   |
       iommu_group1         iommu_group2        iommu_group3
            |                    |                   |
       iommu_domain1       iommu_domain2        iommu_domain3
            |                    |                   |
     iova region1(normal)  iova region2(CCU)   iova region3(VPU)

change notes:
 v2:
  1. Rebase on v5.5-rc1.
  2. Delete M4U_PORT_UNKNOWN define because of not use it.
  3. Correct coding format.
  4. Rename offset=0x48 register.
  5. Split "iommu/mediatek: Add mt6779 IOMMU basic support(patch v1)" to several patches(patch v2).

 v1:
  http://lists.infradead.org/pipermail/linux-mediatek/2019-November/024567.html


 Chao Hao (19):
   dt-bindings: mediatek: Add bindings for MT6779
   iommu/mediatek: Add m4u1_mask to distinguish m4u_id
   iommu/mediatek: Extend larb_remap to larb_remap[2]
   iommu/mediatek: Rename offset=0x48 register
   iommu/mediatek: Put inv_sel_reg in the plat_data for preparing add
                   0x2c support in mt6779
   iommu/mediatek: Add new flow to get SUB_COMMON ID in translation fault
   iommu/mediatek: Add REG_MMU_WR_LEN reg define prepare for mt6779
   iommu/mediatek: Add mt6779 basic support
   iommu/mediatek: Add mtk_iommu_pgtable structure
   iommu/mediatek: Remove mtk_iommu_domain_finalise
   iommu/mediatek: Remove pgtable info in mtk_iommu_domain
   iommu/mediatek: Change get the way of m4u_group
   iommu/mediatek: Add smi_larb info about device
   iommu/mediatek: Add mtk_domain_data structure
   iommu/mediatek: Remove the usage of m4u_dom variable
   iommu/mediatek: Remove mtk_iommu_get_m4u_data api
   iommu/mediatek: Add iova reserved function
   iommu/mediatek: Change single domain to multiple domains
   iommu/mediatek: Add multiple mtk_iommu_domain support for mt6779

  .../bindings/iommu/mediatek,iommu.txt         |   2 +
  drivers/iommu/mtk_iommu.c                     | 493 +++++++++++++++---
  drivers/iommu/mtk_iommu.h                     |  50 +-
  include/dt-bindings/memory/mt6779-larb-port.h | 215 ++++++++
  4 files changed, 683 insertions(+), 77 deletions(-)

 --
 2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
