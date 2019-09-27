Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82973C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 10:53:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EC520673
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 10:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EC520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F346FB9E;
	Fri, 27 Sep 2019 10:53:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 05113AB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 10:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
	[210.160.252.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 522728A
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 10:53:40 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.64,555,1559487600"; d="scan'208";a="27462516"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie6.idc.renesas.com with ESMTP; 27 Sep 2019 19:53:38 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B568241F9341;
	Fri, 27 Sep 2019 19:53:36 +0900 (JST)
From: Biju Das <biju.das@bp.renesas.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2] iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
Date: Fri, 27 Sep 2019 11:53:21 +0100
Message-Id: <1569581601-34027-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Simon Horman <horms@verge.net.au>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Support RZ/G2N (R8A774B1) IPMMU.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V1-->V2
  * Incorporated Geet's review comment
  * Added Geert's Reviewed-by tag
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ad0098c..9285be7 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -775,6 +775,7 @@ static int ipmmu_init_platform_device(struct device *dev,
 
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
+	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
@@ -786,6 +787,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 };
 
 static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
+	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
 	{ .soc_id = "r8a7795", .revision = "ES3.*" },
 	{ .soc_id = "r8a77965", },
@@ -1008,6 +1010,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 		.compatible = "renesas,ipmmu-r8a774a1",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
+		.compatible = "renesas,ipmmu-r8a774b1",
+		.data = &ipmmu_features_rcar_gen3,
+	}, {
 		.compatible = "renesas,ipmmu-r8a774c0",
 		.data = &ipmmu_features_rcar_gen3,
 	}, {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
