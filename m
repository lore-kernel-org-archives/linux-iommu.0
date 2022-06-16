Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AD5C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3817740C7C;
	Thu, 16 Jun 2022 01:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QiMHyNmbjBGs; Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E32224031D;
	Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6D49C0081;
	Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF21C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE6EF41A1B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Baa-wYgR2Jgn for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B305C41A1A
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTlRlITjbdM21M4RasUBZsGLqMLXBPQZP7PgJ7B/bOrUsR7ppDE8ApylQwo/3xbXTzT9l5cHzpvDR4PPFx+oQ0Hixd8bJnBxYX6xhlkyJ3uIkKa0FPOeqLWQc6kzlZpASdvJkKcNktF3LjgkxheRmPBkCLRqvdzUcuwn/TjF5HxXHTY/oA8c5CvnaQt4zof6BWnCExPjAUajSx+eQjUTjjqm9HBN3lXtEp0P2L7MKluN5QmAd5thf8ESpXLBrH2HZMfryNwnuG/xV1wDU/DMc1gmbkkohO/wf035JAcgkAX5DvdZzd/PbjnKLxsj6Ed9nPq6Kn8+H0WIVSnTvwCDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIGbfdOxw2SxUQd9xfOv8DA2my2O4uYPD2LCqkA/fyg=;
 b=BF3/CO8ipCJPhZCr3ahXQHTuSdAByZ+JJgUp7j0Yzg3ItnQt2CLh/2No3j9DMg08HynTw5Y8X1ksYIS4N5IFJy+fsp8GH5GE0BoxoMKvSCtRf7NRgRmx/gXXiyYUyUaqFEPkFgjNY1ZhcGv2Nu6FDaAWoRX2eJ6k9Bqghk+6rYeR+duSHcBS0pDGGx8f0MkTSWSwhXkv9YOoDNbIT/nb8/aUJ6fIJ8jtXKInt/2E/9yb2d+Rboas0I7E5IqejRNR40KCDGBqvuRR9NGo9YJV+idUMXK5Xk+kYSZ418QBM8u+qkDQDTNFW1vdDP1P7XV38u6XMktga/yhvmCzpdevJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIGbfdOxw2SxUQd9xfOv8DA2my2O4uYPD2LCqkA/fyg=;
 b=yoqyEz7t2dOgF0z/yruaQIGfPiUR1mcbs5yDATHmXexGlYTwnVixz40NvRbc9mV5aT+ajNgmedRQg0dMomC8neny8E4a75tV9RbYjpiFtcYtVqMLbgdjNU7e7JP3TtHEyGlvDIDfXva+9Youm1CkcSCnK1130pvyTNdmHWKpQIM=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 01:56:24 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ad) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:24 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:55:54 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 1/7] iommu/amd: Warn when found inconsistency EFR mask
Date: Wed, 15 Jun 2022 20:55:35 -0500
Message-ID: <20220616015541.11207-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ca3df0-f0f9-4ad6-7b6f-08da4f3b6b1e
X-MS-TrafficTypeDiagnostic: LV2PR12MB6014:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB601455F5E47EA43C94DD1521F3AC9@LV2PR12MB6014.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0jP32XK3I4RMi3y0F12rGMmmiKkZuoOM5rCwTTmTkdp6lZXgoAh7vc6aEdsmDWETRuDpDYvV+kzY2oLFbFAM4Bk0Wqd6QgQPMuC+k5AjmBfkkeKCSbtf5vsSelefbCjryGPAt249PLQv5no2vie62+Nm/g6yBkso07esbJ78S1tc5vUhlDrehQ5d2CjpX4yODWLOC7WKQPk8cwcdAJYJrfX+H74ZLZKOtmENdaT+JK7UH9azuriqUAUD/iDUbMSp1ovZcsCYwDOO3NqKue2QelL+SlLy9/NSTLMIzME1DwwQwow6yWwEo8muF18/8s0rOaK1Ojupuqapiy6LW5aycYX+lMqvKAjDuM0TqxC+JNHJSVXCe7Aqb9ZJO1cKKuawFdRGT/y3YFO781f8BWtHgYQ0DDZXFluvlAk9yr9Kg5d0GPiBlwUlyRAT9lLbBP/JBqM4wDhTNgvWLhLwWcTBy6j+t7cM3r26CNc1v9LLPkEOJyRW2zLHT3jG6JfVzhSpSF0EptPh7VKNiw7iTHfKfJLkTxMU9pxP2eKNQDYxA65KRz23SLgkXrvkvpGy1N/SRuq987yqJ1ev4C4yrE3MNHEIqkYtPSVtlxTG6rXm48sFQoont7BuW3GA9lsOSFrcb2RKyogiTMOu4/s2oRjBVoEhGAok1yucoj8oKRcYXbQaHWr22Mn+gkfJlXLWEzPDS08wjJKqlXjP4idNNik3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(356005)(70586007)(8676002)(508600001)(82310400005)(86362001)(70206006)(426003)(6916009)(8936002)(2616005)(36860700001)(47076005)(336012)(26005)(36756003)(7696005)(40460700003)(83380400001)(4326008)(81166007)(6666004)(5660300002)(16526019)(54906003)(316002)(44832011)(1076003)(2906002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:24.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ca3df0-f0f9-4ad6-7b6f-08da4f3b6b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The function check_feature_on_all_iommus() checks to ensure if an IOMMU
feature support bit is set on the Extended Feature Register (EFR).
Current logic iterates through all IOMMU, and returns false when it
found the first unset bit.

To provide more thorough checking, modify the logic to iterate through all
IOMMUs even when found that the bit is not set, and also throws a FW_BUG
warning if inconsistency is found.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3dd0f26039c7..b3e4551ce9dd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -261,18 +261,29 @@ int amd_iommu_get_num_iommus(void)
 }
 
 #ifdef CONFIG_IRQ_REMAP
+/*
+ * Iterate through all the IOMMUs to verify if the specified
+ * EFR bitmask of IOMMU feature are set.
+ * Warn and return false if found inconsistency.
+ */
 static bool check_feature_on_all_iommus(u64 mask)
 {
 	bool ret = false;
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
-		ret = iommu_feature(iommu, mask);
-		if (!ret)
+		bool tmp = iommu_feature(iommu, mask);
+
+		if ((ret != tmp) &&
+		    !list_is_first(&iommu->list, &amd_iommu_list)) {
+			pr_err(FW_BUG "Found inconsistent EFR mask (%#llx) on iommu%d (%04x:%02x:%02x.%01x).\n",
+			       mask, iommu->index, iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			       PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
 			return false;
+		}
+		ret = tmp;
 	}
-
-	return true;
+	return ret;
 }
 #endif
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
