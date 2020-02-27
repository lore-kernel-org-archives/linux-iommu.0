Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F2C4BA24
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 11:39:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0DD24690
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 11:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XS/nQy7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0DD24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 276E122CC7;
	Thu, 27 Feb 2020 11:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJN87pi3xUGM; Thu, 27 Feb 2020 11:39:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC942204C3;
	Thu, 27 Feb 2020 11:39:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D321EC1D80;
	Thu, 27 Feb 2020 11:39:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93490C0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8E7E287EA7
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:39:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dju8CF9aRToZ for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 11:39:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60066.outbound.protection.outlook.com [40.107.6.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 984C0862B2
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 11:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3gYgNwElYwAOAm2MNvO0LDwbWFyDDZYw53nzgEmEo2PLTIRyRffmuWr6ISU2tGW8WAkCTOYZ8VOcCUHpbyltM3Z5ZWXDw+K4upL0T8kuj091iTOU+2f7O7fzn0IwXLwXBHLf8fi6DHpyAH7BzjpClbR+3V1JeuHlwjdBkffJhc7tWksQbqqpGNAu2a6XqBVcFFWNbxRwuycnKuIUYRcGfcwaUmLu+RCll6UTWOC6NOZADhp/sDb1CNBJdc+x9o1hyv6zxdrJ5w9XHKeHv1+g4v0GJ/NhkkDXBiirKrDRDC3l1Svpd5ZoeyKKytlqDklzSvusiqUOAJdy7F2jGfKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=FlWVvzRfZaMIE0msNw+kZmPGf0j/UXZ3bK8DBj5djuUf8Yh6xOhANd1mwFxc884gZvmNqrk2nIQ7ZqGAkJmuwF7LQpFnVkv9UJbl0xkbAECfb7xGXUFT+lUl9jH6VJTesi0fSxLAm+JveLAWx0LtiMlV3VdkniTie9jKI7C4Xux8N6ZspvkfDIef6mVO9vKY+fGLM5LIky5ValkDvI9c6AvxuAOLFY8bBdXaUcCbeYee8qSJAW7eHPdYV0OxEEkh7zvSDD29ZFyfCkvaORkiHYm1hbcQkr2XrpScgi2u7e8RRSZUFAuQBHWIwOQqslwGbgL6YYbCaHjhV+pjJgzA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=XS/nQy7jGw4NKM9GWgcxBNlw3RoMQfT6DPFNIgTZpFiqLsyPqKy0fsFjPLjywXtdV4qalHl/LTpfDS9UsOFJFva3SOO1mEL+BA6R2roqhq3qFuxGA5qBKePi7kzx1V1rR7qfAxDuQ7tjLgGEjMT4S9GM3JeVhpyGq+6mTrY0C5c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4312.eurprd04.prod.outlook.com (52.135.165.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:05:54 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:05:54 +0000
From: laurentiu.tudor@nxp.com
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH 2/4] irqchip/fsl-mc: Change the way the IRQ domain is set
 for MC devices
Date: Thu, 27 Feb 2020 12:05:40 +0200
Message-Id: <20200227100542.13819-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by
 AM6P192CA0056.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:05:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d1a28c7-35ae-4b82-fe70-08d7bb6ca1b7
X-MS-TrafficTypeDiagnostic: AM6PR04MB4312:|AM6PR04MB4312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4312027521DBF6F444394A8EECEB0@AM6PR04MB4312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(66476007)(1076003)(66946007)(478600001)(52116002)(6486002)(5660300002)(66556008)(4326008)(7416002)(6666004)(2906002)(8936002)(6506007)(16526019)(86362001)(26005)(9686003)(36756003)(8676002)(186003)(6512007)(316002)(2616005)(81156014)(81166006)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4312;
 H:AM6PR04MB5878.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94tD5Tz2mP1GwIWNFOYGmveoIeY1tDG0PjGE9L5Q4j/LFZSqLSzVI9yPdu8uwp2Iywo/zpwQpNeC2b8rfG+ZQ0XN5uo8NfOL317FuoWtLbIWugYEAxbz9FHNSX+LpOqovx61Yrls2kKPCiXjtTTSU7higU+QCXwJbQ6yELK6b6suQ8Fj4cFXDqhixSuJ7RV+UQsrHatpJo1BrItudElvWxmb9Jh1gepb4AVPfHKz3O1Boo/bNqY3YZBxVdPw/qj9bsVAkZ3qLLA/Yi2Ubld6J0Z4SQKmkevFlAOdgFx+gl7QKIjRksu5laka5i/5Qiqfw3Ze7wNBGY5Pq7EBbTtxeX+MuvXilSbtMqff/SDJ2gy1HSiAr/cj54x42Vp7S6u0+j41nOVmI0Gwc9aJHezGIU53cD5XULljYFB0aUtwo5hGqPAftbYJosDy3vqbkfd6
X-MS-Exchange-AntiSpam-MessageData: YjOY6gmyIVrVtBwgHx7w5IEEAAQP5ep2vKoBWPc3yrAodetfvEycA4JuMJn7d9S+GCOnFr/LhaoSTR1MRLF58y/ofQq0nYO27oaM+1tdpX1WuQrk4jlMGtGn+weK5fMHFl7XgoJVpBPXEOvmakIJCg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a28c7-35ae-4b82-fe70-08d7bb6ca1b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:05:54.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLV64tTm6HjpFoXlXhtFVDwlVsu2b8TZ34TkpidSEKfjVKkeWwYosMMpGNFmrw/OcgfAEW3GMwDb1307UZQM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4312
Cc: calvin.johnson@nxp.com, ard.biesheuvel@linaro.org, maz@kernel.org,
 pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com, jon@solid-run.com,
 jeremy.linton@arm.com, makarand.pawagi@nxp.com, cristian.sovaiala@nxp.com,
 V.Sethi@nxp.com, ioana.ciornei@nxp.com, tglx@linutronix.de,
 robin.murphy@arm.com, jason@lakedaemon.net, Stuart.Yoder@arm.com
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

From: Diana Craciun <diana.craciun@oss.nxp.com>

In ACPI the MC bus is represented as a platform device and a named
component in the IORT table. The mc-bus devices are discovered
dynamically at runtime but they share the same fwnode with the parent
platfom device. This patch changes the way the IRQ domain is searched
for the MC devices: it takes the fwnode reference from the parent and
uses the fwnode reference to find the MC IRQ domain.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..1e2e97329781 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -182,16 +182,23 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 {
 	struct irq_domain *msi_domain;
 	struct device_node *mc_of_node = mc_platform_dev->of_node;
+	struct fwnode_handle *fwnode;
 
-	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
-				       DOMAIN_BUS_FSL_MC_MSI);
+	msi_domain = dev_get_msi_domain(mc_platform_dev);
 	if (!msi_domain) {
 		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
 		       mc_of_node);
 
 		return -ENOENT;
 	}
+	fwnode = msi_domain->fwnode;
+	msi_domain = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_FSL_MC_MSI);
+	if (!msi_domain) {
+		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
+		       mc_of_node);
 
+		return -ENOENT;
+	}
 	*mc_msi_domain = msi_domain;
 	return 0;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
