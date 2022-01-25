Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB4CC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 12:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBD4B60B5B;
	Tue, 25 Jan 2022 12:56:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9bK04iSfhyI; Tue, 25 Jan 2022 12:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABBA060093;
	Tue, 25 Jan 2022 12:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22307C0079;
	Tue, 25 Jan 2022 12:56:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CB30C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B34A827C9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDUTtl9dNdbM for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 12:56:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7D88827CA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:56:13 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; d="scan'208";a="107604454"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 25 Jan 2022 21:56:11 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id CCB87400D4FA;
 Tue, 25 Jan 2022 21:56:11 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 0/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
Date: Tue, 25 Jan 2022 21:56:00 +0900
Message-Id: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
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

This patch series is based on renesas-drivers-2022-01-11-v5.16 [1].
Note that we have to prepare the following registers' setting
in a bootloader (U-Boot) because the registers are protected.
Otherwise, data mismatch happened if dmatest with the ipmmu is running.

 => mw eed01500 0xc0000000; mw eed41500 0xc0000000

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tag/?h=renesas-drivers-2022-01-11-v5.16


Yoshihiro Shimoda (2):
  dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779f0 support
  iommu/ipmmu-vmsa: Add support for R-Car Gen4

 .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml  |  4 ++++
 drivers/iommu/ipmmu-vmsa.c                             | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
