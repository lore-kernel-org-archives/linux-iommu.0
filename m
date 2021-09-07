Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5530BC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 08:30:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05D5261104
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 08:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05D5261104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C68F64051B;
	Tue,  7 Sep 2021 08:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OWrB-Jddg9LV; Tue,  7 Sep 2021 08:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B760F40635;
	Tue,  7 Sep 2021 08:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E337C000D;
	Tue,  7 Sep 2021 08:30:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7786BC000D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64B8282883
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbjuB5alMAzx for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 08:30:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74C778284B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 08:30:42 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.85,274,1624287600"; d="scan'208";a="93225460"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 07 Sep 2021 17:30:40 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 61796400C4FB;
 Tue,  7 Sep 2021 17:30:40 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH v2 0/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Date: Tue,  7 Sep 2021 17:30:18 +0900
Message-Id: <20210907083020.907648-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

This patch series adds support for r8a779a0 (R-Car V3U).

Changes from v1:
 - Add {Ack,Review}ed-by in the patch 1.
 - Add support 16 contexts in the patch 2.
 - Add Reviewed-by in the patch 2.
 https://lore.kernel.org/all/20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com/

Yoshihiro Shimoda (2):
  dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779a0 support
  iommu/ipmmu-vmsa: Add support for r8a779a0

 .../bindings/iommu/renesas,ipmmu-vmsa.yaml    |  1 +
 drivers/iommu/ipmmu-vmsa.c                    | 29 ++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
