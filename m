Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B8C10F29
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 14:21:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C5020663
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRszfRy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C5020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED16C851D6;
	Tue, 17 Mar 2020 14:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cg5gbYA8-xbK; Tue, 17 Mar 2020 14:21:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 360778511F;
	Tue, 17 Mar 2020 14:21:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBE4C1D74;
	Tue, 17 Mar 2020 14:21:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7201AC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 14:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5BFA888B52
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 14:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LRe7gXi7m12z for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 14:21:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A488688A47
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 14:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFzDCOuLJ3NaNm6ENYa+mS57f6qQK3gGGMI/Zbh/Rj3ubx2BijU446GxXtLX7ND6eGaY6XJ1mEY/JXagqqGzbiJQKxZ9wj60PJfHgk8SPyLHgJB8iJphmc4hQQKDJQCfjH7KuRg44aDumGqlpv8YR/pGLUVJZzRisrqCmaQosWdTxXh6DBPah+S3yrBt25i5gAwlA0d+9asi0O+1XRQTAO17PKwkkBcr0uY8jdEUhcLN+8msBGCCgVzlSgsvmUgd5k76yhFFpAZJs4SfapltMjDX+GGm3erDi6IoDPTIALHLAIe1bqjPVrnuR2CjXzajbbnRvaJ+/9Hjuuca1+NPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPj5X1gl2PdatTZcZuFhLPksS7DLcdToHbQEUyrV0dY=;
 b=PkSh7SebL1SnyREH14AcDITLLqTWFYm/DibEbbk/1WlvtmyUToTkf0YrlkkOJcC74xAWftX3TD2YS2fs6C4Gr2Ya1nHYWuPrMHPdE8JVM4uPJBJH/msqYCxRvb24ResXZRNiaGnz0KSoplAsCMn5o0Qo+KtcfEsp5GIbE0B28o08nFEwqFMt1A7tRLgGQU24uRpW2p7oQdjpiKq2eZ4oUveFX3bJW3o98QIeBYcnU4T4yXWjh/Ldj9wLOVfyc1URsMJFhLCq+9YzdtbHSZ7ss4IvZ3reRi7zKaMn+FgIUtR9PHZIk/yE069q6euIYLjRK0YJyJXE7IVDplOdB/VLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPj5X1gl2PdatTZcZuFhLPksS7DLcdToHbQEUyrV0dY=;
 b=DRszfRy44XfWdMAwItxHeoZ/a9ge/8JT/YFGxenWyJKQ5QBBPmdkLA4ea3P9TMJu4CefI48ilV9AfRKXUNvpxeG0f1wlQzkUZxxGlFafAC19da9Wm2qQ5Ue4WnkWG9oac90/ytfNlz5rFfBBUWnKPdyAEBv5NQk7pfHFr+/rilQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5416.eurprd04.prod.outlook.com (20.178.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Tue, 17 Mar 2020 14:21:19 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::fdd6:55d:c03e:5818]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::fdd6:55d:c03e:5818%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 14:21:18 +0000
From: laurentiu.tudor@nxp.com
To: thierry.reding@gmail.com, robin.murphy@arm.com, will@kernel.org,
 iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 1/2] iommu: arm-smmu: Extract arm_smmu_of_parse()
Date: Tue, 17 Mar 2020 16:21:06 +0200
Message-Id: <20200317142107.28776-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317142107.28776-1-laurentiu.tudor@nxp.com>
References: <20200317142107.28776-1-laurentiu.tudor@nxp.com>
X-ClientProxiedBy: AM3PR05CA0105.eurprd05.prod.outlook.com
 (2603:10a6:207:1::31) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by
 AM3PR05CA0105.eurprd05.prod.outlook.com (2603:10a6:207:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 14:21:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 761985ca-eaa7-40b5-5d35-08d7ca7e75c3
X-MS-TrafficTypeDiagnostic: AM6PR04MB5416:|AM6PR04MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5416FBFCC28038221C50E47AECF60@AM6PR04MB5416.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(199004)(52116002)(1076003)(8676002)(81156014)(66556008)(8936002)(9686003)(81166006)(66946007)(66476007)(6512007)(7416002)(5660300002)(6506007)(6486002)(4326008)(16526019)(186003)(26005)(316002)(86362001)(956004)(2616005)(36756003)(6666004)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5416;
 H:AM6PR04MB5925.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj6RFZlyCSyI/E3yczuYetwd9rx5kfVakXc/wk5OExX2BKQLUppYb0MD/9Ji507Yma4T6nNzuCPWc/vZzT2c+0g6rEgkYK1TJuiGN5FckqQjgsi7hD4k9TcBFYJ/RZcGcM3sMede0fyXarc1SYgM+9SlM5vEWaSrdiOYprUW3rhErOfM5ZWbklB8YeEUk4pp60EUgR1NK/VQWokrNuZDNfeuGLNpu8acDGWOSByNZOfgkO4UD2J0LfQyoQcmLWfrKMe6ha3Qnp2jJtl+p6D/+Hbf/lCqYe1H+dBGsAmyvtZkatixmkiLEDAsQCJyQ9ZL+rmxUyUiB8XaOoWN/MlB7JkUbcWTYyFYkRcWHUA1AfBdg86n+J0C+qZJRIKrQ0sGBipRYKz6NWzt6Ke4HPR/0Wple2N2ru4JvF21l0U723s09lg7B+TsgUIPX+gxJTYX
X-MS-Exchange-AntiSpam-MessageData: V/W23DkVGWQ76l2Dl9VkT3NZFQU81P03ef5UyerXm3QcPXCxoZ8mVHMY54QoJnVGkYV19+DRdAGHbmGq45hlpB++p55tcb5XxJDK4gIC6GNAIHrSJrZagsOaj8+1TAV0eTrU+8iKGNmnuWUsUjeRVA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761985ca-eaa7-40b5-5d35-08d7ca7e75c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 14:21:18.8880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDLSJl+E7+tWUNwWwqvcZ2sPrPHkojx+3cBwJRfAq8uT8hShS4PIkL/vC5GMjZXftO3Y8/6IaWXpCY81Ui9UqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5416
Cc: saravanak@google.com, pdaly@codeaurora.org, kernel-team@android.com,
 diana.craciun@nxp.com, linux-tegra@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

This function will be subsequently used to extract stream ID information
early, before a struct device is available.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..8a238d5a4b51 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1584,18 +1584,28 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_parse(struct device_node *np, const u32 *args,
+			     unsigned int count)
 {
-	u32 mask, fwid = 0;
+	u32 fwid = 0, mask;
 
-	if (args->args_count > 0)
-		fwid |= FIELD_PREP(ARM_SMMU_SMR_ID, args->args[0]);
+	if (count > 0)
+		fwid |= FIELD_PREP(ARM_SMMU_SMR_ID, args[0]);
 
-	if (args->args_count > 1)
-		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, args->args[1]);
-	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
+	if (count > 1)
+		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, args[1]);
+	else if (!of_property_read_u32(np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
 
+	return fwid;
+}
+
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	u32 fwid;
+
+	fwid = arm_smmu_of_parse(args->np, args->args, args->args_count);
+
 	return iommu_fwspec_add_ids(dev, &fwid, 1);
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
