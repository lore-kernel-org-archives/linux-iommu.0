Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD61C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D32D611F2;
	Fri, 11 Mar 2022 09:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMzqkvSC6_l5; Fri, 11 Mar 2022 09:58:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 36C92605B7;
	Fri, 11 Mar 2022 09:58:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F146C0012;
	Fri, 11 Mar 2022 09:58:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 930E5C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82CE181334
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wzEHrOaZuggw for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:58:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::614])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0684812FF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cszw7FDCsu1l8oe7USWH5Bok2cw0cYY5dJfe9z9dGFwX0tZXRDupxyrHhF6K9RXDFW/F61bbatfjfkgjB1ZSkbfSrRwpLIPvzBPoEt7BNxvEHuZpzG6DKSic5BEjYU/Rek4VGvUBbBkyeg+VgCtsYxMl8+4QRIzKR0ERm44duOqJAqNCxbKhjYDv+VRLb/29o230C8E2S/5x4Os+0D7Vo60ZWyNNYZcM4kTn2NEqmXWJaBlEsUFCoHImcAS/dan3cjrk4GDsAuN9yJBblyfTdN65Feo/kBsiVX8A2p0xn/79XPUfN1D9IZ3CcLmyvLGS6CX/dIDI+0k9PQ/GJu0mCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=Rtgr9e+WStfDgey4/Qxj9yDb0ges31Ir4C2QIenZjp86QoHQdNfBdrX+RGgBVk8NOjl/hXYeMQxCj+qPKaQjnQv4PjHNm0JYIaRmgUXBePyZHurogjfGrR94YUrJ1Pr8p0ARdrKPM/rRhXps3D8/t4hiGRXdHOMODO8KXiYsf1wXfJEoydG6bIj1gTHfOmCO/5UmBxmLMN++4SlgKk9wZ5u5cM258eSHIYArm9dTSHKbi1FYTNUsn9/G5N3wxxiJegKYHFxJn8k9somvhbJ5851dz/t/245AgrXlF7Y8MY8geAfHpMXj4uxWcdLKAwHjiV/7+y8iK6qJOmbDtsOqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=lYXSUmzH/PSXlpzY0D1T2IEJkR8s1bI9sdObmFYNZFD3MVWTeO/B8y407O79OqCvjiuccG27DSZa5FjXDuP0Ms/h1eQb8jEIBiFBiRZ+CNjyEHtbe7ZCmlxtCELE0PdS6J4/ShjSj3zz5Wlm9xUIpcbeYBhDVYXFYnFewMFgch4=
Received: from DM6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:5:bc::20) by
 BL0PR12MB2548.namprd12.prod.outlook.com (2603:10b6:207:41::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.29; Fri, 11 Mar 2022 09:58:46 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::47) by DM6PR13CA0007.outlook.office365.com
 (2603:10b6:5:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.9 via Frontend
 Transport; Fri, 11 Mar 2022 09:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:58:45 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:58:27 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 24/36] iommu/amd: Update (un)init_device_table_dma()
Date: Fri, 11 Mar 2022 15:18:42 +0530
Message-ID: <20220311094854.31595-25-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7df295de-9f2a-4a3b-6b72-08da0345bb5a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2548:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2548A937C75B0987D78045B3870C9@BL0PR12MB2548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DGf5/AKwIYQz9FINdB8IJIWUC3fzwJcs9OsN8HPIAl9u0RQMbFWtFZBO5OU2cvmPDaxb0ulrwN7Qm/x8AcXE0unj73hEJhL4ezz5eorIui7LfoMTG4jbUn8AtcrILkV/lwY5YhILZaE+1TBzD2Qdw37bipE6bGmQnQ12ED90llbRIoF0Dycln8SmuJeSRmskxfsRgZ8kdduMZ7+FkwNe4ikNXuXQdFUw/S8IgYOxvfUM/7asIXTkxZQ7zlOnmEbmNk5/jDZ2THc4/ZxEmuiL+ZPUGpfmDH8dmD9EN3P4A2lLziA4BB9XGZsjkryzvN/LrFd8JgTL+4YjleKebijXxpQSKVvWore1pPJAu70QAAwAR5XYf8H37KwCMzP9RrXxEGHKqA2NEckK8+CoH+EjVcfqwXvpONfUHzBalTKkESFKzk2omVSEZdNrYO7XYFgYhNXS7wEJM84SuB5TL2mRA2tSBUJMK5gefLpvJJpnCifvP5k/gGsf3QEac1U3bR+ulzqkbciiXTrs+oRRa/o9IHZv47Q0RfSylovgvt+LkSmNoyWeQ/Bzo/o52vJRUt1yu/4osimB22Ad4bbrtjhICaDRS9H5sUugUV6fQzXcC5UL2Tbh3zYv7Nh3e3DpAlQejgiu3UbbD9Q4+jtCX3FkQLP54/dEnKyH7JK/6pvFgZTw3T5Yey69fUl3PAkBxpYSZeIlCuvKv1KebUZgjfOHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(356005)(5660300002)(336012)(47076005)(26005)(186003)(426003)(6666004)(110136005)(54906003)(8676002)(70586007)(81166007)(86362001)(70206006)(4326008)(82310400004)(40460700003)(1076003)(83380400001)(2616005)(2906002)(36860700001)(508600001)(36756003)(44832011)(316002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:58:45.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df295de-9f2a-4a3b-6b72-08da0345bb5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
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
