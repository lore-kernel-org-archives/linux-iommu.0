Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E202C433E1
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 11:11:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5142070A
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 11:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fi2V1ZpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5142070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EB82020784;
	Mon, 18 May 2020 11:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rcaZN+RWblCG; Mon, 18 May 2020 11:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6445A2076B;
	Mon, 18 May 2020 11:11:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B60DC0888;
	Mon, 18 May 2020 11:11:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0F10C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 11:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D668D2051C
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 11:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViWcIGIrUiBL for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 11:11:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by silver.osuosl.org (Postfix) with ESMTPS id 01FDC204EA
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 11:11:05 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04IBB02f118853;
 Mon, 18 May 2020 06:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1589800260;
 bh=0yjXkwQ80QOrE5YkHpj7T7bDrIcnDcee31J5NNtAn9g=;
 h=From:To:Subject:Date;
 b=fi2V1ZpLOPPHjTEVRcTpX529CB2KkEvSnUhuQE0YSya6DVVnxCJpA76Lp1B3c55wF
 bi75VIJmqF1lTn+RBQrsfmTLcotWr9/482zt4mbLeblmRYEIheb/ug61rbvhrr+usD
 Sj+dHTwzOYffu8l40XW6Cj2ylsJ0GMe/7KZgvymA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04IBB0Cp119314
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 May 2020 06:11:00 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 06:10:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 06:10:59 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IBAwBL121537;
 Mon, 18 May 2020 06:10:58 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>,
 <tomi.valkeinen@ti.com>
Subject: [PATCH -next] iommu/omap: Add check for iommu group when no IOMMU in
 use
Date: Mon, 18 May 2020 14:10:57 +0300
Message-ID: <20200518111057.23140-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
From: Tero Kristo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Most of the devices in OMAP family of SoCs are not using IOMMU. The
patch for converting the OMAP IOMMU to use generic IOMMU bus probe
functionality failed to add a check for this, so add it here.

Fixes: c822b37cac48 ("iommu/omap: Remove orphan_dev tracking")
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
Hi Joerg,

This patch applies on top of linux-next, fixing an issue present there
at the moment.

-Tero


 drivers/iommu/omap-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6480d5a62e33..c8282cc212cb 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1727,6 +1727,9 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
 	struct iommu_group *group = ERR_PTR(-EINVAL);
 
+	if (!arch_data)
+		return ERR_PTR(-ENODEV);
+
 	if (arch_data->iommu_dev)
 		group = iommu_group_ref_get(arch_data->iommu_dev->group);
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
