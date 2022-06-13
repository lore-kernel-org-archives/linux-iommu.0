Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CABC43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63A264173E;
	Mon, 13 Jun 2022 01:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVaspPtLegYt; Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1FBA4170B;
	Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89C33C0081;
	Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D659C0081
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42B7160EB7
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1fPuVb4Joyn5 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::612])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F289860B56
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBWiE8xi/QJZ65Jky2vHRxhYVUDUGQE/c3h5jKGb3Cd6xpffQtHMrYxuy3fKiicxQ3fiYwrhUHq6qWLp2FVXHnyWS3sajT3MmyDjR/0hznm7BVqoYNiZU9KCaMGQDTKdss6dO7XxMTi03EuEFdjGSttQEk0KMq+nPdDpHYCXhMVLm7ZZqvwJ6ZAjY3LEn/yf8/aiKjx8oxJ2Y2akMDyrOdZAQAEomH0ZBxTWN3n/wNIn+If47dIZOCrdxp+U9ulKjp8f0qYVu4SuG+s96wU+OsORgKL051xNKiVci5aCwKJv0CZKn9JKbshC3/S2H3IDectsuS/2yDPuWAiViHT89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY3XcjyVk5ThHVGEk/8p3ERNRFP1rl6DmdBuqtSNVwg=;
 b=UUjWMC0zBMhNqUl/4iPBFmp8CT71IaFUOvelhMqaeDrM91v7jqWx+LMUDL7nUDpqYUMBZrjm3r/B7W0OJorYtiHKgHu7uoUgWm/QGxChANoUSljTF6TYbQBbAblkEE4lMOeu8iDve3xKcxZPdPp15KHEEtXHPMGhiXHeQmfaQqiTJRd1tbRfNPZSLu2r1T95IiQGOgVrFAdrHmnBsH+besgUopmpWnGMdxhRByL2n8mZslZobVr2v5IE1doUTF5BKsTBHED1lcZvQCYzX0cMejFIcBVv/SlcgQZSl20mRl2SFWM561gPfkaEl97f6SYbYElYuWOjkb7shRoIw1Yssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY3XcjyVk5ThHVGEk/8p3ERNRFP1rl6DmdBuqtSNVwg=;
 b=yzG+weLgQkLmafC/9mhCrQ8sVb8d9YSpJ3fv4diWndlb9EsC4b6XFxSf//L+woc0hEzEXnL9fK0PvSiQJZoArKsjHsEPqEUEoFE5HwIeTL7Utp8glUVxxSnQEFvScSRmEYGjAQqcaNt9dDpLwL9yKFOOdHWBMs5/I2GgTcyLlfA=
Received: from CO2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:102:1::18)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 01:25:29 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::e0) by CO2PR04CA0008.outlook.office365.com
 (2603:10b6:102:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:28 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:19 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 1/7] iommu/amd: Process all IVHDs before enabling IOMMU
 features
Date: Sun, 12 Jun 2022 20:24:56 -0500
Message-ID: <20220613012502.109918-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 192a92a3-7016-49ec-904e-08da4cdb99d2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB248627F89D870E077805190BF3AB9@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXHUqeX7VRtTAWvxHkzjKnTV/w5VbOiDKjg2cD8UWI/iS2h1wfziMcYQS/+SQTdkAZ/KbF4XV4fA2nAZtzAkWbbPbQ8OZrQ1oSo/D7umVZMopE6WGGcIQmYzise3reTyfieaYsfccFkxo/YVr/UWBcQd9uAQvjx4KidT8r6EA+Ck9mTPr2NGqo94/vVo7fVH+8l/kt+rbdFdq9us3lNdcIkmbr16nbv2LnGeiydz7tu4mPEWT/QrgFQwlqwGby0g96lLwP18BlOaWzPg5rlWFx1lDkQ9qSwX/KuuLKi6TQXTkIB+s3b5HclDlrDmyccT4vxKi49w9ScBDNVlTF2wsO/1aUVeXs/B1IBRNT7m1BXw8hVnBpAhMbbQgp5CjN6PnaVTzBBlTQvXOQw72Lh/L6Q2ff8NEyHj4cJgN1K0pWoiyRYcOMVWY7mZR9PxtxCIN4h9YhkmyyD6v2JsYcdSLHDPuKLQm00wP7eAXYIDljQc7AS3/Fzta18YBQdR7UxC6T6UfqpcYB2Ycv3RPMtyMpgoXpPDUzZESzQeZ8ASe4Hc0vzZPxp9Z4aIIWU2AGUXih13C4x7vNQJQlJrn21lRAa92XkMVPD+GxfWSgjK1SXjUIL2gUS+B68unQiPgx7qbfyhycScj3ZOicniJMB3yv2dv+6nrEspAiahQqCkRgav5qAXP8JMTcnC0WxRiJ3ADo9A9lTET0VJ8Y6wVpGCLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(2616005)(6666004)(508600001)(7696005)(44832011)(26005)(2906002)(82310400005)(356005)(36860700001)(81166007)(83380400001)(40460700003)(186003)(86362001)(1076003)(47076005)(426003)(336012)(16526019)(316002)(6916009)(54906003)(36756003)(70586007)(70206006)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:28.6733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a92a3-7016-49ec-904e-08da4cdb99d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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

The ACPI IVRS table can contain multiple IVHD blocks. Each block contains
information used to initialize each IOMMU instance.

Currently, init_iommu_all sequentially process IVHD block and initialize
IOMMU instance one-by-one. However, certain features require all IOMMUs
to be configured in the same way system-wide. In case certain IVHD blocks
contain inconsistent information (most likely FW bugs), the driver needs
to go through and try to revert settings on IOMMUs that have already been
configured.

A solution is to split IOMMU initialization into 2 phases:

Phase 1 processes information of the IVRS table for all IOMMU instances.
This allow all IVHDs to be processed prior to enabling features.

Phase 2 iterates through all IOMMU instances and enabling each features.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8877d2a20398..6a4a019f1e1d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1687,7 +1687,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
-	int ret;
 
 	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
@@ -1768,6 +1767,13 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
+	return init_iommu_from_acpi(iommu, h);
+}
+
+static int __init init_iommu_one_late(struct amd_iommu *iommu)
+{
+	int ret;
+
 	if (alloc_cwwb_sem(iommu))
 		return -ENOMEM;
 
@@ -1789,10 +1795,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (amd_iommu_pre_enabled)
 		amd_iommu_pre_enabled = translation_pre_enabled(iommu);
 
-	ret = init_iommu_from_acpi(iommu, h);
-	if (ret)
-		return ret;
-
 	if (amd_iommu_irq_remap) {
 		ret = amd_iommu_create_irq_domain(iommu);
 		if (ret)
@@ -1803,7 +1805,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
 	 */
-	pci_seg->rlookup_table[iommu->devid] = NULL;
+	iommu->pci_seg->rlookup_table[iommu->devid] = NULL;
 
 	return 0;
 }
@@ -1873,6 +1875,12 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	}
 	WARN_ON(p != end);
 
+	for_each_iommu(iommu) {
+		ret = init_iommu_one_late(iommu);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
