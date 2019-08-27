Return-Path: <SRS0=Te3Q=WX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CEC3A59F
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8307220850
	for <iommu@archiver.kernel.org>; Tue, 27 Aug 2019 00:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kPSZQov1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8307220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30562907;
	Tue, 27 Aug 2019 00:15:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 70EC15AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 00:15:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F031B887
	for <iommu@lists.linux-foundation.org>;
	Tue, 27 Aug 2019 00:15:22 +0000 (UTC)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7R0FE6h125381;
	Mon, 26 Aug 2019 19:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1566864914;
	bh=VGvGOml4Hwxt6/SECSn+6qFGSur7ryz1rS5cpT5i08g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kPSZQov1pPjdwZfruXOz4Zm80SrtwoBlTne7gijLBHKqlGmaXL2ByWbE7iLwrYu74
	gOTmcjdHysMtmmrdPRbwf3ovO2wFw+NU8p4JAbvUQb1vb5JWifV6OQMvxt58DxFm0j
	B0/oUj58sPSfGOUfmXf9YDbLTY1a8vNLSDs7tHRI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7R0FEga022369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2019 19:15:14 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
	(10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Mon, 26 Aug 2019 19:15:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
	(10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Mon, 26 Aug 2019 19:15:14 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com
	[128.247.22.53])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7R0FEKU005062;
	Mon, 26 Aug 2019 19:15:14 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id
	x7R0FEZ19069; Mon, 26 Aug 2019 19:15:14 -0500 (CDT)
To: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Add pdata for OMAP3 ISP IOMMU
Date: Mon, 26 Aug 2019 19:14:52 -0500
Message-ID: <20190827001452.31930-3-s-anna@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827001452.31930-1-s-anna@ti.com>
References: <20190827001452.31930-1-s-anna@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Tero Kristo <t-kristo@ti.com>, iommu@lists.linux-foundation.org,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-omap@vger.kernel.org
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The OMAP3 ISP IOMMU does not have any reset lines, so it didn't
need any pdata previously. The OMAP IOMMU driver now requires the
platform data ops for device_enable/idle on all the IOMMU devices
after commit db8918f61d51 ("iommu/omap: streamline enable/disable
through runtime pm callbacks") to enable/disable the clocks properly
and maintain the reference count and the omap_hwmod state machine.
So, add these callbacks through iommu pdata quirks for the OMAP3
ISP IOMMU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index dbe8d9718f70..3d597fb962e9 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -93,6 +93,11 @@ static struct iommu_platform_data omap3_iommu_pdata = {
 	.device_idle = omap_device_idle,
 };
 
+static struct iommu_platform_data omap3_iommu_isp_pdata = {
+	.device_enable = omap_device_enable,
+	.device_idle = omap_device_idle,
+};
+
 static int omap3_sbc_t3730_twl_callback(struct device *dev,
 					   unsigned gpio,
 					   unsigned ngpio)
@@ -621,6 +626,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap2-iommu", 0x5d000000, "5d000000.mmu",
 		       &omap3_iommu_pdata),
+	OF_DEV_AUXDATA("ti,omap2-iommu", 0x480bd400, "480bd400.mmu",
+		       &omap3_iommu_isp_pdata),
 	OF_DEV_AUXDATA("ti,omap3-smartreflex-core", 0x480cb000,
 		       "480cb000.smartreflex", &omap_sr_pdata[OMAP_SR_CORE]),
 	OF_DEV_AUXDATA("ti,omap3-smartreflex-mpu-iva", 0x480c9000,
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
