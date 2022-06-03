Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769CBC433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BA9B417BD;
	Fri,  3 Jun 2022 11:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4QabEgAJxx2; Fri,  3 Jun 2022 11:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4214F417A7;
	Fri,  3 Jun 2022 11:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D6DC0039;
	Fri,  3 Jun 2022 11:22:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9962C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 982A9408EA
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id avPUG44hsW62 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:22:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::625])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3556240003
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAxmvoL+z5pb3hVKQwtUrndEULMSEQtocYBI6L9tt5UJCzBN5UTqTPadIcijpIuv4XOvbLXP0M7vhCGaM5/GNPkDSBACSOsCne79vIoM1ivdOkXUaIb6VyIBLiDMzoXcrOBkkhMBpBkDXN1W4rJVX9BnGJe2Jt3TBo5xg/mFgyLqJu2zuRcXy7TdrkXqrBuAjnrYYbOFt2CBtMMafEKf/5Dk9DJMJOpbTM0E4Lamd54oHfKxD/vbqDtgbt6tiXAnmUzwGRNmMMLFanXMsGZHO/lB43s/rThkqgj4kO5uPkCIk1UAUurc8DsyDeGIE2JKx6jweNl7VKAm3Dkltfqm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFQl27Fu6Z2/OcOnVoZpiH/ynNxLPLSUWCfk/f/0Lac=;
 b=S9LpNIA1Y7hprYrBK9/1MvXdC+ab4CBs7Nm7DkYPflp6oOvgUhQJO8iBsbcIjIEw+ak831iuI3ZV/Sd3a61Yg579AXzyhbPxNaHA1C2mkBiFl0Bmwiao6zsGNO9MvJNB8gG3z6P489+v7xcX/mkDdvSub+/Ke8iYak9j6njcZUrzCoGtXoeEx9TIczL494RR8Gs5sa5sJzk+r6NBAWhPxgrQIsGZNhyCvceQmGXf66YX2yvD0KUjq6K1el4v44hM9EP2g69wMczix4/LAwiK+ZRA1Hc5/VTpeUZDfW5k4oxitNEmKtzwf01f5UdrNLLpxYpV05HOY/ZIhBXdabV7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFQl27Fu6Z2/OcOnVoZpiH/ynNxLPLSUWCfk/f/0Lac=;
 b=F3w9mXjo36KYTlGcHGE5U3rT65PlvqXxVwaamkCBJGHOcMMleCS1ne1wrHpnj7RYwb7P8v+89M/Lc4DgjOvcF+4t+fu7xCEKLmEX6tjbXOG7k4B4BV8X2/exQnBkLoWYXeFDL9BKj9GviXb2Qrgcl/qbPzLO3Iq4TKDvsQhf86c=
Received: from DM3PR08CA0023.namprd08.prod.outlook.com (2603:10b6:0:52::33) by
 BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Fri, 3 Jun 2022 11:22:01 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::e7) by DM3PR08CA0023.outlook.office365.com
 (2603:10b6:0:52::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 11:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:22:01 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:21:59 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 2/7] iommu/amd: Update sanity check when enable PRI/ATS
Date: Fri, 3 Jun 2022 16:51:02 +0530
Message-ID: <20220603112107.8603-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae757f0-b5a3-434e-d6b4-08da455347c8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2728:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2728E56AC06BE1DA51E5AFAC87A19@BYAPR12MB2728.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK+xcDkt4yqQkyM+yG3G50CvYaH6ECrUAj2Wh65t8gK7OgA59pD1UxarDKKwFj8PIsMbpXy1T0L6WVKriO1YNUAlZZ3Vs8UHeHYEyH3qQ9dUJIBskqdXvbecnpMfyXGw5TLtP+HTgTcOUvGug81djP80Epg67fUyWS8LJjHNrakRUBAo7YFyPXIIa7BmjhguBcJP6KaXMjlMAu0j3DsYb1OFvM2Wst6A7RnFwckl4XrORJkFdDMBaQaTbicRCi01fYDUM14Y7iwcD58TIn0eq1MOFXuLLrNXLhogPthGKFPCACFuC48fT10H8zjXaJ/EF41sOAwZ2wfjrbF+AD/30yzf5fsnXyqCfsG85ycDDRs44xso3EL230u1ci5vFiT7jKAWp2vixGpyFbRv+cGB1/7EswMIqhOiFva7PzlnEUx/C0SoQJyFKjm6IZ9X1hl/xO7TaJFx1t2r05T/pg7UwVgmJa+JS6CVJrIArHjMUaGp0cHgdGiA2D9gvA5kjTu53dInVqqXVA0rrJzPnEnVq963i+u5rgX/e8HVnM5DqMPiMuf4cT2iQEmhs3TvxazwrASesMI04WGMogW2WfuMB1QOneld3vbRQrKu6r3F9YRXqd23/vexN+CLRMFF9h0EqbNVUwXn+o/DJfP0o2D1bcm7apqL4y7lM160RCNTGElrbEqMxo2krDOZVqkCGVYBYtQcdJZ2lW2YbuYHp0NU1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(44832011)(5660300002)(26005)(86362001)(40460700003)(15650500001)(6666004)(36860700001)(81166007)(356005)(186003)(8936002)(82310400005)(16526019)(47076005)(2616005)(336012)(426003)(1076003)(2906002)(8676002)(83380400001)(70586007)(36756003)(4326008)(316002)(70206006)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:22:01.4199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae757f0-b5a3-434e-d6b4-08da455347c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, PPR/ATS can be enabled only if the domain is type
identity mapping. However, when we allow the IOMMU v2 page table
to be used for DMA-API, the sanity check needs to be updated to
only apply for the case when using AMD_IOMMU_V1 page table mode.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 059e699c43d1..b558e8c30613 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1682,7 +1682,7 @@ static void pdev_iommuv2_disable(struct pci_dev *pdev)
 	pci_disable_pasid(pdev);
 }
 
-static int pdev_iommuv2_enable(struct pci_dev *pdev)
+static int pdev_pri_ats_enable(struct pci_dev *pdev)
 {
 	int ret;
 
@@ -1745,11 +1745,19 @@ static int attach_device(struct device *dev,
 		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
 
 		ret = -EINVAL;
-		if (def_domain->type != IOMMU_DOMAIN_IDENTITY)
+
+		/*
+		 * In case of using AMD_IOMMU_V1 page table mode and the device
+		 * is enabling for PPR/ATS support (using v2 table),
+		 * we need to make sure that the domain type is identity map.
+		 */
+		if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+		    def_domain->type != IOMMU_DOMAIN_IDENTITY) {
 			goto out;
+		}
 
 		if (dev_data->iommu_v2) {
-			if (pdev_iommuv2_enable(pdev) != 0)
+			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
 			dev_data->ats.enabled = true;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
