Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EA4CA9EA0
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:52:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8989B21D81
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8989B21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 57DDCEFE;
	Mon,  4 Nov 2019 11:52:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BDD27EF6
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:52:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D390A710
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 11:52:41 +0000 (UTC)
X-UUID: 3cbef7e6586948899fbff3153634440c-20191104
X-UUID: 3cbef7e6586948899fbff3153634440c-20191104
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
	(envelope-from <chao.hao@mediatek.com>)
	(Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
	with ESMTP id 2146603920; Mon, 04 Nov 2019 19:52:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
	mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Mon, 4 Nov 2019 19:52:35 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Mon, 4 Nov 2019 19:52:31 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
	Brugger <matthias.bgg@gmail.com>
Subject: [RESEND,PATCH 00/13] MT6779 IOMMU SUPPORT
Date: Mon, 4 Nov 2019 19:52:25 +0800
Message-ID: <20191104115238.2394-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
	Cui Zhang <cui.zhang@mediatek.com>,
	Jun Yan <jun.yan@mediatek.com>, wsd_upstream@mediatek.com,
	linux-kernel@vger.kernel.org, Chao Hao <chao.hao@mediatek.com>,
	iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	Miles Chen <miles.chen@mediatek.com>, linux-arm-kernel@lists.infradead.org,
	Guangming Cao <guangming.cao@mediatek.com>
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

I am sorry that previous patchset(2019/10/28) has a problem with e-mail format, some websites don't recevied it,
so please based on this patchset to review, thanks!

This patchset adds mt6779 iommu support and adjusts mtk iommu software architecture mainly.
1. Add mt6779 basic function, such as smi_larb port define, registers define and so on.
2. In addition, this patchset will adjust current mtk iommu SW architecture mainly to adapt all the mtk platforms:
   Firstly, mt6779 iommu can support more HW modules, but some modules have special requirements for iova region,
   for example, CCU only can access 0x4000_0000~0x47ff_ffff, VPU only can access 0x7da0_0000~0x7fbf_ffff. Current
   architecture only support one iommu domain(include 0~4GB), all the modules allocate iova from 0~4GB region, so
   it doesn't ensure to allocate expected iova region for special module(CCU and VPU). In order to resolve the problem,
   we will create different iommu domains for special module, and every domain can include iova region which module
   needs.
   Secondly, all the iommus share one page table for current architecture by "mtk_iommu_get_m4u_data", to make the
   architecture look clearly, we will create a global page table firstly(mtk_iommu_pgtable), and all the iommus can
   use it. One page table can include 4GB iova space, so multiple iommu domains are created based on the same page
   table. New SW architecture diagram is as below:

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

This patchset depends on "Improve tlb range flush"[1] and based on v5.4-rc1.
[1]http://lists.infradead.org/pipermail/linux-mediatek/2019-October/024207.html

Chao Hao (13):
  dt-bindings: mediatek: Add bindings for MT6779
  iommu/mediatek: Add mt6779 IOMMU basic support
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
 drivers/iommu/mtk_iommu.c                     | 488 +++++++++++++++---
 drivers/iommu/mtk_iommu.h                     |  50 +-
 include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++
 4 files changed, 685 insertions(+), 72 deletions(-)

--
2.18.0



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
