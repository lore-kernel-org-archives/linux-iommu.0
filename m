Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC1C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:07:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 021B340183;
	Mon,  4 Apr 2022 10:07:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irKcq-9QtyuW; Mon,  4 Apr 2022 10:07:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A72E74002B;
	Mon,  4 Apr 2022 10:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A144C002C;
	Mon,  4 Apr 2022 10:07:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD03C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4709360C1C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2BG4IrVgfzIE for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:07:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::607])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4738C607F7
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2HloUseoV5nV1hYz650oYPtJwRAtLUNDS7Tc3OoBxVMMXusywXjjRUcsb8o2laBUzsX4uC5ifKtis6IPvExU2ekNkjHQ0wlizaVUk9xWY3GU8eUpqsQWPDMA2NZuMNKYwsSZIdmUY9yaNS1iNIsmF7mI/M4GvWAdeiA0CAIWC6H9kNcbR3sVj5TNb14v2zSkMt4i0kaYXFuFX8IkYYAI3fVycC28kbnUzSr4LMQ0jGCNNDFemcGMWzqv/pSnWKbA0hS657PouIKtJHYA9wGq3W7U+9ztnbE/qV1Tpztpd4dndV5PvUCIw3DIJw3yW6cn+2efAqDwR0PcDwhwmIxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=DteSFilM1q42VoDHIdz0zyKr0h/+i4yWyu9cAquIF2lIv8C46Ve8QzKTESHidNu14wW2F7Gl1Brkq8KNCHkdB9ag33z8Bdtuk4sckDqZo3pHSYGcVU7gjJiJjL93Yclni2DSnQHswmVz+oUa78+dtFtBLo16Fx/i8xgayyWcTZ+gA709EfXzhlpXVq83yCXZ1E/UHwJU3CTukJBVXjb3qUme+XxQTYZ+b64EMw9Te8AekWSGdJ09+ukoHH808Ph1GeuOga5ZUbc/yc+3Fwq/LSPozY/HWBM3k9kYCZY3Gogj48l3206BMsGusHik4ztPnpp4aDGwHuTMcKyKk7Xq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=AUy0Y3wVpmjkWVRrP0uQFdKa/mdlk5DMVwR/XWbWCd5BQqj9gvor00wBDBJPfdehOqfeYyzwhL5/6NPnTMHUqxddzy9m58oHfBs18STPBgVyzM6iSgCYrkx4yTe59S2QtnYcgdukLsKJHJt4ICVr+fXZh8kcoHrm2QddpDNbonU=
Received: from MW4PR03CA0090.namprd03.prod.outlook.com (2603:10b6:303:b6::35)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:07:06 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::e6) by MW4PR03CA0090.outlook.office365.com
 (2603:10b6:303:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:07:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:07:02 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 25/37] iommu/amd: Update (un)init_device_table_dma()
Date: Mon, 4 Apr 2022 15:30:11 +0530
Message-ID: <20220404100023.324645-26-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa35828b-db18-42c5-25fe-08da1622ded4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4973:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49739D94F8235AF839C14B7B87E59@DM6PR12MB4973.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH/s0pEIxS+AY9wjTYNBlt1rA6eu5UCCLumVZlFB2yx5jZRKUqFeRLhdHFD0Ceb08PtnxO7tl+j0uS4htua8RoelBklu7g8KZwTI56cD9emJdmJdHibqFAZj/TZ4qMtZOy7pj6Xxdchg/1hJEPBlW0F7OvZ5ja4/3Mfbq0nwL3cqRZrqu+yZwWGus7zoTrXKuKZBLrO01TxUWkMx5YLLd0/Gb1lvBhFY7tFGFXW0vuAYBZ/peSJaISEO+i3XnAwCScyHddb2+hvLzTJnr+C3rC+ea/BVHzwJCquC4/4l8g2Dx5kMN7falUS91Z48OvyzKuB0GZgO1NV/KWf55YKSw2vDNQa6M8D5vj2jn5wbklq1FY6IsuotPN9Q3/AxYkueIPWwENcG0S4bRQYAskOcO81ZR1Vuf2g2jdwLz36OoClCAVjQYbPaE1bOgqdJwAxTs/ZuXYBoNDIAeMdGtuyRv2revrFDzidnLIraz2XSIkparfE3Z1FmxEhNPyuZ4mPM5sUwZMHBT0jfp8jG45Z0sHKWnhY5SriNsk2oEZFW7FCHliNzQKdH80advIiljP9OWrw3bvSzCRm7Ys2jcecocuoWqibuPI2PjJ1L4J9gVXyUeobTEn0ZBKOzhMV2hlahEdB8eVxNQWlWm3ESFAxNC++/3ng6uGQPTF46m4kxNBRScYiiL3Do6CfAzbfVyaRZArgat3b4g7uqJITtO2Y3yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(2906002)(6666004)(83380400001)(16526019)(47076005)(8676002)(70586007)(70206006)(36756003)(54906003)(110136005)(81166007)(4326008)(316002)(8936002)(36860700001)(508600001)(5660300002)(1076003)(426003)(336012)(82310400004)(44832011)(356005)(2616005)(26005)(186003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:07:04.7772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa35828b-db18-42c5-25fe-08da1622ded4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
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

Include struct amd_iommu_pci_seg as a function parameter since
we need to access per PCI segment device table.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 70eb6338b45d..dba1e03e0cd2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -238,7 +238,7 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
-static void init_device_table_dma(void);
+static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -2115,6 +2115,7 @@ static void print_iommu_info(void)
 static int __init amd_iommu_init_pci(void)
 {
 	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
 	for_each_iommu(iommu) {
@@ -2145,7 +2146,8 @@ static int __init amd_iommu_init_pci(void)
 		goto out;
 	}
 
-	init_device_table_dma();
+	for_each_pci_segment(pci_seg)
+		init_device_table_dma(pci_seg);
 
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
@@ -2508,9 +2510,13 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 /*
  * Init the device table to not allow DMA access for devices
  */
-static void init_device_table_dma(void)
+static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 {
 	u32 devid;
+	struct dev_table_entry *dev_table = pci_seg->dev_table;
+
+	if (dev_table == NULL)
+		return;
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
 		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
@@ -2518,13 +2524,17 @@ static void init_device_table_dma(void)
 	}
 }
 
-static void __init uninit_device_table_dma(void)
+static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 {
 	u32 devid;
+	struct dev_table_entry *dev_table = pci_seg->dev_table;
+
+	if (dev_table == NULL)
+		return;
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
-		amd_iommu_dev_table[devid].data[0] = 0ULL;
-		amd_iommu_dev_table[devid].data[1] = 0ULL;
+		dev_table[devid].data[0] = 0ULL;
+		dev_table[devid].data[1] = 0ULL;
 	}
 }
 
@@ -3117,8 +3127,11 @@ static int __init state_next(void)
 			free_iommu_resources();
 		} else {
 			struct amd_iommu *iommu;
+			struct amd_iommu_pci_seg *pci_seg;
+
+			for_each_pci_segment(pci_seg)
+				uninit_device_table_dma(pci_seg);
 
-			uninit_device_table_dma();
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
