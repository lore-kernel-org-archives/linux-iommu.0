Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F7C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7F04812FF;
	Mon, 25 Apr 2022 11:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oc52I2XePh6Y; Mon, 25 Apr 2022 11:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B527A8130B;
	Mon, 25 Apr 2022 11:40:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E6A3C0039;
	Mon, 25 Apr 2022 11:40:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C063EC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE9C08130B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLahtDjElTqN for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:40:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::610])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 048BB812FF
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cObO4UgQzJOqIBg8T23M6zh13CU+yZmA1m3Vq1rxCyZLkDtnrpioTJ8aBInh0vZoGwHMIqaqOstJOBGg7eUkortbM9AVluO/IR5xnwWnN6+t6aRL9ZXQy80CNHQPZ/rqW1wcrIli5Orlx/87jFzMtPlTp0Imk0ou+YEYb3gvPl4Pnn9rh3OEHaTkp1ZgsZRGfNpyzsDXddpMszpJAslonR47z0/MW2chvseSUTGk0WJPPg7ui5F91byW3WkqE3mbf2K073LY4aLoRdL4hQiCXQ+6vY12nhEsGQb0EzMTl8wYtYdfx2Fuj8Q+pmO0OrguJDxYzIeYcCwmrnSSEmr8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNiNRd5q9vchiBPk+cYHTF0p1Ozgol5KmXV/8+lqq5E=;
 b=MTvf//+dRuBrFV6tQAP6Dz2cochaD2zgB0lHrmjMdFbK+6205xNonyVe+wKvjDUJvy42uuHdTjxVRZN9jL3mWjZl3YfGdzD12TVOEQ2aOTqExn696PkLQo4XVxVRISyyz60t3P/uImXgjz6dS5gIUaZRhr6iCmNNx9oGWmyyP6LXLOJRmtwugTbs6yImDhtrx7o618r/4rZ+tKzbSuxPUMLDuBcoHUl7DMytx+16oDvX+9pAANySOR4CmDNnuQgoCNNxmWR33/npfemPQJJPls/J5RJWyZgEBVdJU3r1PjOw3D3bFPOX+RtO5e3bKUwshCMbM88kbxDucx4dHVUuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNiNRd5q9vchiBPk+cYHTF0p1Ozgol5KmXV/8+lqq5E=;
 b=SoN2yiAnhPcPCzF9xr+WrZoCyME62xPf9+tqPjlq+GHLbBlpPR8A0VFUVeN4RDZEjx9IOEmGy670f16ZIVpposwlLQ+xGSPNqVqIN0p7p5jUscuxbWdNv18Ip4KZJIjoohnt/zG76yFZInvMHga3GQzqwP9cAGd6NR4Y3XpDRGs=
Received: from BN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:408:ee::12)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:40:30 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::4c) by BN0PR04CA0007.outlook.office365.com
 (2603:10b6:408:ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 11:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:40:30 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:40:28 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 22/37] iommu/amd: Update iommu_ignore_device
Date: Mon, 25 Apr 2022 17:04:00 +0530
Message-ID: <20220425113415.24087-23-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c614c8ea-6213-4849-1288-08da26b0669d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090190789DE21CC71DF4AA587F89@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hHQwE6otEk91kisutsJSRLFpxe5o9POcfyJhC+KBJ6/o5/zTZNZ/ThfL6Q7zJZbXN0v3CPIaX2gJtBMlQYAeR29Yw5BlmGBlmBRq1yrW/Tv0PbtGu1mzCtOOolosPtZp4jWvCaUxAYHe8U8dJpnwgJNg6NkZk2Hag7cYhMyoFUbxcbNjpLMsmRi0cDdx646WEJjKWUJmGF4Cj7tq8UE7eJbshTTx52BMEb7MnmfxCsrlTpKjJ4xmTvHpypaTtWYkqulhX8WUMowHPsh2iTzGNAHeQxdrjV1/67zSUGU2EKeFmoAwyiv5M79hpoKAaZbWr0hQC0ZbPjomu256cVokgCcENRgdxYiMLdsfGqsWk8MVWaabffRBdOaXl4mVZWE+smmSVtHdgmzW5ikdIQTLFR8GksHRFX5GEyfZcrPiy6H815ZM8mg+uBCtNt2sM6tRMfkBYhbq9SELgKbk+BenLlS3xpi0pT4ZI7/3r4Um/okXyQTgtxTUHYgkBVycu4GMrkcwViDjDVsjwNZgrfHBg9loD1in+bBzPhN/kX/mAiWi23IxeMEhI65/CW/u9ge3JdMxEuZc546YStv04eegFhwGwHFK+PwYr5pdgQTeTp5ZIqjroFVNukWZu0v8KKLTZWrFygM8G0KQNAkGZs/wC2HtIfRjiqBRVV+y+KC2qbqnGQcdNI3LDCXLrKd/2cq8IxFUpLMIMgFg966i1ohhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(86362001)(6666004)(4326008)(54906003)(316002)(40460700003)(6916009)(8676002)(70586007)(508600001)(2906002)(70206006)(8936002)(36756003)(44832011)(5660300002)(16526019)(1076003)(2616005)(47076005)(186003)(426003)(336012)(83380400001)(356005)(36860700001)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:30.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c614c8ea-6213-4849-1288-08da26b0669d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 689d3c355d73..f2424a72100b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -413,15 +413,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = get_device_id(dev);
+	devid = (get_device_id(dev)) & 0xffff;
 	if (devid < 0)
 		return;
 
-
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
+	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
 	setup_aliases(iommu, dev);
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
