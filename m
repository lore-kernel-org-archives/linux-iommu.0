Return-Path: <SRS0=TgA1=WD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D46C19759
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8904229F3
	for <iommu@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WFsQjjoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8904229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 26D14F11;
	Wed,  7 Aug 2019 08:27:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF025E41
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6F5EA8A3
	for <iommu@lists.linux-foundation.org>;
	Wed,  7 Aug 2019 08:27:06 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x778R3SL004243;
	Wed, 7 Aug 2019 03:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1565166423;
	bh=QMYsjZeL3fWJgrYRQgaOg4p1fKD8ZHjR+InV1JW2e8M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WFsQjjoDK5myxGFY1gXYQM+6gF8wC88qIPfCtnRE29IJta3cciGf6PnNBENfL6OLp
	FhpEAmLDo/rxuK0gzzaZ2ysDZwdzH6vQNriQSmSGUrqxJaqNOaf4z9IRFg9peCVyvH
	BlJmeXmtkamR+VbBIP9EbWrh6PIhFk+oB4mNBEjs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x778R3U2098788
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2019 03:27:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
	(157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 7 Aug 2019 03:27:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
	(157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 7 Aug 2019 03:27:01 -0500
Received: from gomoku.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x778QwO2046515;
	Wed, 7 Aug 2019 03:27:01 -0500
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/8] iommu/omap: add pdata ops for omap_device_enable/idle
Date: Wed, 7 Aug 2019 11:26:46 +0300
Message-ID: <1565166412-31195-3-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
References: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Tero Kristo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Suman Anna <s-anna@ti.com>

Add two new platform data ops to allow the OMAP iommu driver to
be able to invoke the omap_device_enable and omap_device_idle
from within the driver. These are being added to streamline the
sequence between managing the hard reset lines and the clocks
during the suspend path, as the default device pm_domain callback
sequences in omap_device layer are not conducive for the OMAP
IOMMU driver.

This could have been done by expanding the existing pdata ops
for reset management (like in the OMAP remoteproc driver), but
this was chosen to avoid adding additional code in the separate
file in the mach-omap2 layer.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/platform_data/iommu-omap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 1ed6026..8474a02 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -13,6 +13,8 @@ struct iommu_platform_data {
 	const char *reset_name;
 	int (*assert_reset)(struct platform_device *pdev, const char *name);
 	int (*deassert_reset)(struct platform_device *pdev, const char *name);
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
 	int (*set_pwrdm_constraint)(struct platform_device *pdev, bool request,
 				    u8 *pwrst);
 };
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
