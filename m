Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72360C433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 11:10:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517352072F
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 11:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517352072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33C6088530;
	Thu, 11 Jun 2020 11:10:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XZQVCKeapeH; Thu, 11 Jun 2020 11:10:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EAFA0880A0;
	Thu, 11 Jun 2020 11:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFBDBC0894;
	Thu, 11 Jun 2020 11:10:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C6AFC016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 11:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B8BD875F6
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 11:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wK7_DrlIIJw7 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 11:10:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 25CD487547
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 11:10:41 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.73,499,1583161200"; d="scan'208";a="49201358"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 11 Jun 2020 20:10:39 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2112A42B6920;
 Thu, 11 Jun 2020 20:10:39 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	robh+dt@kernel.org
Subject: [PATCH 1/2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: add r8a77961 support
Date: Thu, 11 Jun 2020 20:10:29 +0900
Message-Id: <1591873830-10128-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591873830-10128-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1591873830-10128-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add support for r8a77961 (R-Car M3-W+).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
index 39675cf..e9d28a4 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -35,6 +35,7 @@ properties:
               - renesas,ipmmu-r8a774c0 # RZ/G2E
               - renesas,ipmmu-r8a7795  # R-Car H3
               - renesas,ipmmu-r8a7796  # R-Car M3-W
+              - renesas,ipmmu-r8a77961 # R-Car M3-W+
               - renesas,ipmmu-r8a77965 # R-Car M3-N
               - renesas,ipmmu-r8a77970 # R-Car V3M
               - renesas,ipmmu-r8a77980 # R-Car V3H
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
