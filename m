Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F5EC54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 14:58:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651612071E
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 14:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F+q5X1v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651612071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 393F186CA6;
	Fri, 24 Apr 2020 14:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENqAjq2VpYaj; Fri, 24 Apr 2020 14:58:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 24B3786C23;
	Fri, 24 Apr 2020 14:58:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 093B3C1AE2;
	Fri, 24 Apr 2020 14:58:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 169E1C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 14:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 058328147D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 14:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22+R07ts3bot for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 14:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5DED385540
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 14:58:35 +0000 (UTC)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OEwUvY034335;
 Fri, 24 Apr 2020 09:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1587740310;
 bh=Obn4h9OYvkCQaLa2vsMMvPzZGJYPp0g7ACVWvl2xRdk=;
 h=From:To:CC:Subject:Date;
 b=F+q5X1v3IqHGeEZ145OcLBWGRddPol0+h9+r4xHSAS9p2So274mHNkpz9ZybzJQ8J
 Qni3U0vxJAMTkn0SlBktjCpFMmxKonAFPCcAPHn2ha0whB2yigIXim4JEvavwWpsI7
 urX1Xa41m/W2ayklVhtzupHeqIqJ+N/Ft4aN75vE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OEwU27071310
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 24 Apr 2020 09:58:30 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 09:58:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 09:58:30 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OEwS4J131047;
 Fri, 24 Apr 2020 09:58:29 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH] iommu/omap: Add registration for DT fwnode pointer
Date: Fri, 24 Apr 2020 17:58:28 +0300
Message-ID: <20200424145828.3159-1-t-kristo@ti.com>
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

The fwnode pointer must be passed to the iommu core, so that the core
can map the IOMMU towards device requests properly. Without this, some
IOMMU clients like OMAP remoteproc will fail the iommu configuration
multiple times with -EPROBE_DEFER, which will eventually be ignored with
a kernel warning banner.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/iommu/omap-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 887fefcb03b4..934726e20b72 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1248,6 +1248,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 			goto out_group;
 
 		iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
+		iommu_device_set_fwnode(&obj->iommu, &of->fwnode);
 
 		err = iommu_device_register(&obj->iommu);
 		if (err)
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
