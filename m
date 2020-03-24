Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA8BC4332B
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 11:45:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4C62080C
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 11:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSCul+BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4C62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 419DF20791;
	Tue, 24 Mar 2020 11:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PcEbiWGAyo7S; Tue, 24 Mar 2020 11:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D0DA2051A;
	Tue, 24 Mar 2020 11:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B39FC089F;
	Tue, 24 Mar 2020 11:45:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7829C0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9532385FC7
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id obNHHGeWWrNA for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 11:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10047.outbound.protection.outlook.com [40.107.1.47])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C034C85BC8
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lafBX4jNGaJsTFcztBUX0QBSIbD/0GvauIuEaIjzTTCZQE3hyPT/SdNoUhqQmpurmCBhVRRMvuKgonGdcOLlx4aRAJp4ELdTs6/E5iF26CmuU8SBDerLI/BRKb5Iw1PbHvH4LbNIeGlwUTdi6iWClGm8lw1c+mNE7qcWk9SM6BD/UB9znJGCA4yZ/lVCnUi/FitQvS5cQgu5kMKeKFAqaBTCcBX3G2doJogrMV1Z829umt4xGKF2Fr24C3n/eH9ybq7xtQjoYItI7idaA3kpa3RMwLKslDRHwvvfvzDTVcvW3/X/kcRfPNldg7KeV2OeQZF3VAFpPEqTMJq0S1RmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=AmURlWGi0QFsSCNyWAI1Hx7KxVQGRKyQ6EG/XFmss79oGLmksFRACzwjnURFVI/XiQoqxhWPGerMECRvO23KmsTedaZ1C/FHY486K6hq1QHAAFp4OqBwBkSIQYElxICKNOQFe9PUPOL6qyDWtUjPux7SKqigDmrBE+MUDj9DvSEAluRz0LUrPILzjOR3/sNZzhgELNXIS9EMQOjdYfzI7ReLw8c/jqTNTwA9x0jmdoHFaAscYF64BJBSNRBZr4jEsZq4IG1GE+dLCaYUNVeaZaixAwzOOZcb4+ye9JczvUmoTGCTtlIxL8SncEkSDhGjd+n1jCRDx2AUBULnz+cX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=aSCul+BBlRQEsUILCRhRfiRNHYbAhNdQWEHB6ShYvTdRB8m+4RjfakpFC39D62WzLXJeBb1mMu5KY+m8xbLNkUuf4OQkR3BfId+VG2jxxbwHJKNl4yP6XGZIGxUT3LaBAoPjNKY1uSp07WJlmt7Fz8/3GTvVl3ZidrS+hWyNITk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5960.eurprd04.prod.outlook.com (20.178.92.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 11:30:35 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 11:30:35 +0000
From: laurentiu.tudor@nxp.com
To: robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH v2 2/4] irqchip/fsl-mc: Change the way the IRQ domain is
 set for MC devices
Date: Tue, 24 Mar 2020 13:30:21 +0200
Message-Id: <20200324113023.322-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324113023.322-1-laurentiu.tudor@nxp.com>
References: <20200324113023.322-1-laurentiu.tudor@nxp.com>
X-ClientProxiedBy: AM0PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::49) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by
 AM0PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:208:ab::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:30:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 577bc46c-18b4-48dd-7fb4-08d7cfe6c53f
X-MS-TrafficTypeDiagnostic: AM6PR04MB5960:|AM6PR04MB5960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB59608B613DF87E931B2077A7ECF10@AM6PR04MB5960.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(66476007)(6486002)(66556008)(66946007)(6512007)(2906002)(9686003)(478600001)(81166006)(8676002)(186003)(16526019)(81156014)(26005)(52116002)(8936002)(6506007)(1076003)(7416002)(2616005)(5660300002)(956004)(4326008)(6666004)(36756003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5960;
 H:AM6PR04MB5925.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OERkQ7HtHAfQxhonHKHm4Y5Gfthd3eiypd48WInDiBAtE4M1UMLnRBPtGMUq9FZak4h7jQQGTapQZoDh5J3uIVRt7hN07l9FwD6EB67Dl7/RicJszhJP5pHb1f4JsxuVThVbSTwEe1cG9BdN/9GuPvVkk/RfMDc9uW+08wC3pi3++UMkft0qp5ZH227/z0B9n1coR3PmO+IWZkiP737WBZzRPeT8YeMXhbJXUFWTH3g81VIhj8TAYFCFwS96gJobUpzispYKxM8y7dHpMWXte5ct2aEO1RiKS5iujweNGMyaDAr4F8yKy+XZpJSMTMr3n/MkCAYfYrXF0XrJ1JrLIqNVu7Rl78UrTAihTp6aPmtaL484YnmgGKqa3OXqDSB+JkVIrw0ez+fACekqirD/pvz6UEcxtxRZ9asKiT8PIUyhlCmWxSDgB6B+9d0Dhf+b
X-MS-Exchange-AntiSpam-MessageData: Jm/A0HUqw3ODNthJdHsYHKzuAIJ9TjuYp8PYjQ4xwGkjKRlHGNIYF4p3u4XmW/7vGbT9jpfBQ+0/S2R0n/3fhsLkHcQj6vTojtf2N7Ip8ua6R71AOzfyWRUvTklkDuMtf4qNvgorqDUO3k1DkqSORA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577bc46c-18b4-48dd-7fb4-08d7cfe6c53f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:30:35.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zb2j1MEL2CoQkh3DBCQ/Dnv3kC0wtJYMFFrkYUh8Ieh+trAOkYJxx2BGdRbeJPVlz++Ppw4UiUtWM1KCcts4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5960
Cc: calvin.johnson@nxp.com, ard.biesheuvel@linaro.org, maz@kernel.org,
 pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com, jon@solid-run.com,
 jeremy.linton@arm.com, makarand.pawagi@nxp.com, cristian.sovaiala@nxp.com,
 V.Sethi@nxp.com, ioana.ciornei@nxp.com, tglx@linutronix.de,
 jason@lakedaemon.net, Stuart.Yoder@arm.com
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
