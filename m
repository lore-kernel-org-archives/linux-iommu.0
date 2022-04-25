Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB22CC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 701EA405C0;
	Mon, 25 Apr 2022 11:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NF4y-W69JFRO; Mon, 25 Apr 2022 11:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 58E95400CE;
	Mon, 25 Apr 2022 11:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8B0C007B;
	Mon, 25 Apr 2022 11:42:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22E43C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D644F60DB7
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QDLiWcJSesME for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:42:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FD7A60C0D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/KwV5GyalEgyi2sJu5w+pTFzhEElOaSyzViQ6A509qdp71nTk6Kig1M66uXKDMrej2Lj8rt4bw7HbP9vv1gRnMlAana6xdmHLhQPv2wuacOzV2QAsqyYYxT69p/HQtytCMenI/NDORMmAeAslNzBze3HoQy+1t1kg21E8Qjfz/m6qzsaUMO9Y8jCSzOfy9WHCXPqnLYAWkii5BZaA3ZC80SemT9Z/4Cp+/gmS56yw56zoSCD/ND4avtKUXO4wkBuD9DbsNUeohDJ3dNHWU1/H47m6rSnsVIbfeCRZF5K9bBPVKn8NSkzXZjH0eJG0hQ0z6DS6N9r2PZhaFSoQLrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbsxvQpRVGbAlFqSv6FCm3cQOU4SsEll4YAdbwvXzvM=;
 b=QenVzvDPkjAsP04kluweWFDKypgxwO07HfhM/31VUYfVWmSB2hEgCmlLdtUeppXSSZOmAklRtD6Ed5VeOCe7uOV1cit0P1MgcQ8Qq62LCPPDeRm1iA/xbxwTsRcSisaAO3TxAFmOr/61/sbXd/OXc23nIRf4520vUL7NfogerYKLWpXsUU8kpHTyOsKkFNiYIHEMZnD6Bybp0140rtx4CCpRka/Ui5j1o/HT8xncDJC8KxctMUCoe1Ey/S4jrtxLYeCeg1htm0ozsoQ9EzV4fUJPy84AyU+YP1WmnoW4l7nNyaNE6oYtItgjDUhw/S/V3LbdRwcBY94wrQTPLWk+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbsxvQpRVGbAlFqSv6FCm3cQOU4SsEll4YAdbwvXzvM=;
 b=3PuA9GlxG6oXeKzDtDeTp8z30y8UiVdZWfQVPW+uCSNe5qp0aZ+hEJkzr6dxlABx/qJbMZP7AE4Ayk3g0tdLaHB3nz0LG4NmhiVRIchOQ9fgXlog8jrKamN/6PAwrcfdKRzURz2T5VZ08pQBmM1DGCus8VOHsVAZ0vOnoH570T8=
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by DM5PR1201MB2537.namprd12.prod.outlook.com (2603:10b6:3:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:42:29 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::5d) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:42:28 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:42:27 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 30/37] iommu/amd: Flush upto last_bdf only
Date: Mon, 25 Apr 2022 17:04:08 +0530
Message-ID: <20220425113415.24087-31-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64a6de81-6110-4e69-e400-08da26b0ad3f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2537:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2537A3F8BA1671E871D5B73C87F89@DM5PR1201MB2537.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ka5C40IoqPoYWIgwocR8EjHqbJpu6+czn0bAypyeXoxOSzwa1/o5T7LL8ckTCLx80ZeNTo07qxWYcfUHhKpSDbfyWHlH4ShUdNbFGu13v76qhqEyYESQIZlqdlKUDR/CRB7tqK0t8fGpbBjQBL9sFNWrrcPXCR+ncE5aY1wSXbiA0zfJuHBshSpMm0VanHnuBt3fdDwXOLAAXvl0W3tppKKQLCXeQqfB00exxSgiPeZ0a5/nHeVe3Rtk7wysU6UkDBEM98aE2ehyj6dl+5YIAhgiiac4JtbL5RbX5IMbpSNfl4eUYN/4ntfyXrsCGscxD2hS8ZAFHJH6xnBFxDxILgZO7fVMac+SuyGfAGTBUs4DWmajUuJkx75u7NoMY4LMiu4Oe47VizbliN+hs4P3NDjBnJJOBiCfc77rmu7ucbljaXxeOhrF7ue8pZs6NdghJrWuBmLFD7XDFxPX9XrkUXNnOQ6XP+eeSe39bjaKsF1hCRAxd1hR32zDPItaESWf93zWv9WdHzI1qDciI8T3/y4d+2/mPAKDVjMT+VvHWvCHRaOFh72SCXPjgTOX4NCMPvDOkIbkMlt4dz1ldFkISFHNMV3p1Vvr+77hrqA1jfTndiudAPhtG+lpHeWNLYCpg2nuJ5GQNTmkmBeFEYw7XTbo8vLtQpmMVjUwyackQBA/jBVUTp/WLn0JXfr7y5p2mW9sXEstDwRJsaGljXJgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(426003)(47076005)(336012)(1076003)(4326008)(44832011)(26005)(82310400005)(16526019)(5660300002)(186003)(8676002)(70586007)(54906003)(6916009)(36756003)(8936002)(36860700001)(40460700003)(70206006)(316002)(81166007)(508600001)(83380400001)(6666004)(2616005)(86362001)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:42:28.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a6de81-6110-4e69-e400-08da26b0ad3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fix amd_iommu_flush_dte_all() and amd_iommu_flush_tlb_all() to flush
upto last_bdf only.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5976038d48a3..40415e477853 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1191,8 +1191,9 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= 0xffff; ++devid)
+	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
 	iommu_completion_wait(iommu);
@@ -1205,8 +1206,9 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (dom_id = 0; dom_id <= 0xffff; ++dom_id) {
+	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 				      dom_id, 1);
@@ -1249,8 +1251,9 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= MAX_DEV_TABLE_ENTRIES; devid++)
+	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
