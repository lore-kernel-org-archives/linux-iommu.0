Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E922C4332B
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 11:44:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BECB2070A
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 11:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CAYlGPef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BECB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A58DC879F8;
	Tue, 24 Mar 2020 11:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IE04Xx90I3ka; Tue, 24 Mar 2020 11:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B292987631;
	Tue, 24 Mar 2020 11:44:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A095EC089F;
	Tue, 24 Mar 2020 11:44:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88BD9C0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 70D7385FC7
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7YTN4Y-YefsG for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 11:44:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D065385FB9
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 11:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtLC+krVy2YatXxLAJqi72IQYrEQck0S03MHKTlcdh4njBORzhbOi4q4sz/nfgLpoxSR90uzRq7K9IB8d7HjOjtOetM9HDVP6KocnrINs6M3JoL3xh4tooQsBrRbJTWmPK0wEVs171LvHuHCk6ZCWNn+O8jKHOamihNK+FmpGFxSQe7QcmCeFgFlJSbNHQCxYoUw/vXd19JXY44uZ3CdURTxE0k6sYikheZPANS8YyY0+xLPO3LzBnQ9Pk8jyfQQF56OxLMN697q/yuGlEJ6sTWSRbHjnhz1VLRR7XC9iRbHrvRU57mXGDRxgYjV1bAURLkvdNw+VIuL9Uq4bENFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg+8IM8Rq0BMgwys+NY7eYgPbomblGiHhi2paGqATyE=;
 b=kAZpLZ8jlVMnnpAZINILZbsjLcRmsZ5hyZYmzUpAtQBLYFi3sA6LBrIsxV+He1SS5bTwdM7OBQtblZo8qRBap0ejI5LzY28oK4bCHaKFtqGizzmIhliN8NHzGnvPHAbNpbgeHAu53CLTqT8YJ8QjivhNdnTUgVMfyNJCjImoNXytZvLPtdfUmu/hq18rbxwPVFUk4cBSKLMrKsCIgUuys/n/SwsHAKaCq/jtZLQs1ITwofM0lPBQ5A6RrlqBDjVh9Xj4kAJUDdKsU/KUkaKn5QipMcXpJKXI6XxhdtKgIxOGar40XcDI7KPH8nZ8wO3jFQEdfVPVgXHb7T1wFLGqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg+8IM8Rq0BMgwys+NY7eYgPbomblGiHhi2paGqATyE=;
 b=CAYlGPefVtskV/QBSfluZCwjWpJzUnMK9JIEc2wQWSPLDsGa9qb5nzKWgSoW3XLzYibCUWmR5oa2x5txV1msNXmwgPpjwLb/yPdj4/48ZNTVm5JVwZtLX2DsrWf2fnoUqi40erdMhxT65MRHjkYv5mbcU3uuae6cPtkwb47xXpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5960.eurprd04.prod.outlook.com (20.178.92.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 11:30:33 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 11:30:33 +0000
From: laurentiu.tudor@nxp.com
To: robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [RFC PATCH v2 0/4]  bus: fsl-mc: Add ACPI support for fsl-mc
Date: Tue, 24 Mar 2020 13:30:19 +0200
Message-Id: <20200324113023.322-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: AM0PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::49) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by
 AM0PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:208:ab::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:30:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28b32295-fb09-4428-f5d8-08d7cfe6c3bf
X-MS-TrafficTypeDiagnostic: AM6PR04MB5960:|AM6PR04MB5960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB59607971FE7BA0001F8AE2D6ECF10@AM6PR04MB5960.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(66476007)(6486002)(66556008)(66946007)(4744005)(6512007)(2906002)(9686003)(478600001)(81166006)(8676002)(186003)(16526019)(81156014)(26005)(52116002)(8936002)(6506007)(1076003)(7416002)(2616005)(5660300002)(956004)(4326008)(6666004)(36756003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5960;
 H:AM6PR04MB5925.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynWu7pCsEJey1HU4WGwPJ5dUFiPt3KAyhqafdbU9WjH7zEfOTLD5gmYdjJk/E4DGv8EyGcc4QMCeR5iAdx1lU3xEL+vKnxE0zMpPVzQMKsb8CqU+BPDG9O7MPEPu8jK2wgHziwlfQdq6e6w9wyHnc2zx4bgOvEHT0H48C9l9P9+xQz1oj8WwktwUoY3Q2u6KfEtCm1RYXd6SVvE+JMx7nP1Fpwkm3WxrawAoKeDgzOlcIe9xm86bXc73L1g4MwW18UIksJ/s04n4GbiaUeiRse06F5olFIzKE5vxySS3ih9Y/92y66karBz9nXxBShloxieBmUGBl8soJXcU+7+xW+NWKQuHyb2i3V0sk+xb/OWZ5cPOcwbspq2tmLeSmRkhashOmeUP3U7uhyNWrwF5mV5ivpA/0J88OlyMqjC/pqKWjjYdLQphlG5vypwdBUXS
X-MS-Exchange-AntiSpam-MessageData: aVMGSiBUXOvriiq4pyg11djuzvEY54WIiqHjUdNfqWTH2otwT0pfpFdeJDMbMJrKn45+vFoZ/xtbnRGpOzf1goWuHmgTHaIlzAokziMD6pjcqBOfo2QJPQKM390LvsvLdtnm2DAH0EDcvpcXVHYo5Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b32295-fb09-4428-f5d8-08d7cfe6c3bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:30:33.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnjXs3yIVCmR8QplT/ye/7nf7mwJSRSqHnyphhvZw1D/FlJpCanDkLX3O/skWP18nl4f/e1tboKC1QgNqz8U9Q==
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch adds ACPI support for the fsl-mc bus driver. First 2 patches
are prerequsite that remove dependencies on device tree. Third patch
adds the actual ACPI support and the final one drops some fsl-mc
specific code in the generic device tree handling code.

Changes in v2:
 - add missing of_xlate call in custom .dma_configure (patch 1)
 - added a cover letter

Diana Craciun (1):
  irqchip/fsl-mc: Change the way the IRQ domain is set for MC devices

Laurentiu Tudor (2):
  bus: fsl-mc: add custom .dma_configure implementation
  iommu/of: get rid of fsl-mc specific code

Makarand Pawagi (1):
  bus: fsl-mc: Add ACPI support for fsl-mc

 drivers/bus/fsl-mc/fsl-mc-bus.c             | 85 ++++++++++++++++-----
 drivers/bus/fsl-mc/fsl-mc-msi.c             | 11 ++-
 drivers/iommu/of_iommu.c                    | 20 -----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 69 ++++++++++++++++-
 4 files changed, 145 insertions(+), 40 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
