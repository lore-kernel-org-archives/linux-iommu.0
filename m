Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F44C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93E2A60BEC;
	Mon, 25 Apr 2022 11:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRwaBwM2-wT7; Mon, 25 Apr 2022 11:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5AC5760681;
	Mon, 25 Apr 2022 11:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41534C0039;
	Mon, 25 Apr 2022 11:41:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 294E8C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1590D60A83
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8V4m0XIbpRea for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:41:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58D0160681
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwm7WLsA/hM0w+g9skNumrTYmckcwRTisf/gazcnltpKbGY4CriNTC5CExnXOfZZIZlbMH5LOeQo3qCsANvzi9ID42r52VfDBPXWZXoh0T7j5YNZKdC/MMPSaBOXQspJ+POoDK7LZ3C1+sWHi1EAB5A6/pb7bJdthy3OzWt6OmgqRjrCimaHvX9RzUjSpdOtaeC+XVXQfTZ55XnAdYZntkFI2Ko/rXk1BstsTKQqoI2iv0L+WhEhCgNfocLlLudYlJd/1poPzUpubTm/hxq9vfzFvZKEfcqP3JlT5TKjD+AZBEojlDUM6rNZK7orvIUnM2SVjzg2lPhI71KQUaOYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=HdmOA992zgYQSfgCPNStluy9QwNrRG3mTUwIGvBkldYEz97SHyytvYrkoBqhi/0YcS7NznHGgJgYNP80KGDUsv9EnN4u5eZPjAvVqRtw6UqV3f7Ej8rCHa61hESMqGpevfCInO8ocXJDwkj+W+uizrdGg4w6d+It8HX5wViMeJ2hg2/JbvNhFlXAvsLcyQsNYxNe6rOOxrZdqR6wOSrxVETvMtZ6p/E8v8QVi4bctBebeISdFJhI8LWhxU3Y4tDf0v91bNLo+2mbF7hMZ8jugtfxYKyvActZlP0iTPhzYdDZ9UCw5Aaxne46lGT47t91n4nEd+pGMQzC1+FctojRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEUqQ9HuyZ/Xz4Qi0Og+utfZ7M+Qu91OqZoJUEvtY0w=;
 b=uh0P39DS4gpIKb16CrPm29XhJyMYjruVWhacqNesHU98jcCq+26IjQRyC8sx2D+6HBb0kz/EKPbicmEp8MW8wdbmalleeqxEgkuj+EYdReVgfbXJqr9RKPuYSja/DuY6yBHbZvk3cZp+afGrmSNrBeCqTcSgdV3gE+DO1M2NgXU=
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:41:14 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::38) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:41:14 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:41:12 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 25/37] iommu/amd: Update (un)init_device_table_dma()
Date: Mon, 25 Apr 2022 17:04:03 +0530
Message-ID: <20220425113415.24087-26-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15fa40a-147a-4209-ecd6-08da26b08103
X-MS-TrafficTypeDiagnostic: MN0PR12MB5738:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB573858ED2BE8389497DF35F787F89@MN0PR12MB5738.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+ODFNxWH2Ux5zWWqzrO9kUCTPBxcAjdoAde6IQ/obGtfp47zsNzsxxNrgSsH2RAdyxK6j4WhDhLkInlXdiX73LqJfh12TI5rM35hlSvRCfE/3IwApdtu75XAY+hKMaFuZTZJNUfJa2PO30sLIwiDZqytmFOsGkMCih1ukEqB3gnnnVHlgGcaHyX0gKbl6Pt6W3bqhHL9icKK2hkmNnIC0faI61bZtnmT42IP9DZ7yT05+QNs469gju9yxULH+AawJAUN6b6gAvXVA0qGqEQsB0j9KZnPUlJpvkRim76Pv59RP/aOBU5TgCEaO3jkN2vFcdGmRi+U6zhXWFx6XuaZr5I5+DYqGvXkuWV4XQpuIddx9cOJFsX58VJaS07NT+uBFylWVUwtlqx/FKpe+IP/bCzgMtkRiyA02pQ30NNTdnd2M7EikAgNlc5Cvyu/liYJh4GRcmHtIKFInRz4jPM8PtLFIQH/zGujWS2jgKehry+kAPvHOMUxszCcqvnruhpRAWQjS2SsLipAaeJ7UsDbLPocU9RCEhlCfQzLF94hRGkeJAYFMAenx+Q9wBlRE8cZ20hVVsd6Fx0d7rpoPmK3X1PpurHfzmW65W2NBeBHh/a85SFDQKo7Q8ltFICcpJQQEsq41w/PwI2lMVU1wB/o7XaDGCdsBCjBg7ZnqB652WT4j695MAXGIUflMMzbVDXbGmAZpVvNrdbqrZkkyCKnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(82310400005)(36860700001)(86362001)(508600001)(8936002)(26005)(54906003)(70206006)(44832011)(70586007)(8676002)(4326008)(6916009)(36756003)(316002)(2616005)(83380400001)(2906002)(5660300002)(186003)(16526019)(1076003)(426003)(6666004)(356005)(81166007)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:41:14.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15fa40a-147a-4209-ecd6-08da26b08103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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
