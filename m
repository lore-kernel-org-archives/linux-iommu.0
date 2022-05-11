Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F330C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D7934020C;
	Wed, 11 May 2022 07:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LagFJ70vgkpd; Wed, 11 May 2022 07:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A81F41883;
	Wed, 11 May 2022 07:28:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7371AC0039;
	Wed, 11 May 2022 07:28:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19307C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0875041883
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CdAAt05RDvIs for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:28:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A47A04020C
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvUy47mU55nyN1/AoJPvc1lI8lgfH4atQf7GyVeErX2tNKK6rjgT1I0Sck1oss6GDxheXRYY7+K8BqDrcG7TRt+LuJwdBLTvTyPSfBQLC5+t4LsmilIhVxwNe5kR6n41JUtDQVIpXyyMHY3y4149QJvAxhaXXDIsxCW4EOp4QA0YQtonKyBiBB1w7SKuN3E+zCtEsV56AdcdwYkxi+rxHgdz0qQtSOMumYXqihu8JVnRgZ3k9/FTAPxqPpHxdR98/BflkxaUMe041UqRowweaGHlD0fKdN099ge2mYrjN1IePekhbfKlaWwqE4MWRnh0WdBsFXPWas18eUQ0Z7rfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igOPu4vdTkjBEgAa0CZS95ScGwMxTVQl8I2WfN2V2Ik=;
 b=dzO8aRKa0hmET9usPdeoSzas50fLd0QxTNiEsWGdjRRwJhzZHbAUZhN/iFAfUltJlaOX0b63wft6kpgt55hZtf1UqrYKO9cZtMylasDHLXduohFK9hJdNfU2OBEAHPS+oBPi/omtj0kJsDQH1mxuIYduShQ97GdiXP0kIyJQspEkR03694Xd7ctBJ/+EcWk8qMUiuHotB6miKj6RW1ynmetavDtAj5ttbJGL+orDRELCj9laoiYQlXqTCrmCJdBrdyrV4/v37mzNkA0C4IjinA5dtSXRqySaEUiGM+klmMn+2l4hCEkc4wC81XLYgIWqPyCfYY7lobENwFYVjjLTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igOPu4vdTkjBEgAa0CZS95ScGwMxTVQl8I2WfN2V2Ik=;
 b=TWxNNS8fNTesBWOmHiBu3t4WWCNncXHtEJdb7vvd/xvvXBMFhFys1i4oxCDZSgJnoKCltoVKeNCHT30asXGA9eBuCi+22FTENgN+HpjYPNfL9G5TvJq7oPus3NGpznP/Fb9GXd3W2NAUs2JuOLL+2gpOAiEgBJAo9FYtRq0yYKc=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Wed, 11 May 2022 07:28:33 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::d0) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.14 via Frontend
 Transport; Wed, 11 May 2022 07:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:28:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:28:30 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 25/35] iommu/amd: Update (un)init_device_table_dma()
Date: Wed, 11 May 2022 12:51:31 +0530
Message-ID: <20220511072141.15485-26-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ede35757-d2fe-4988-1bce-08da331fda81
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4770C4C814EA6EAB5C6F776F87C89@BN8PR12MB4770.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FicCVuCewkd++FzubYc9siBsqohs8GQwK0c+bMn7Cgp6qjtr8Al44BKto5+mdbVi5TaVGissuJY70Z9qmkgPoayikytBn2TzyryXunCPlU/qj+fBmZ2KJYyK8x8c3P4dmQ3pb2E/Fk88nQAhDOjPlS5OxZo2meHK5mg5zi5I5WEeEAZqvHq71lzm93v5rX2SG15OQZf6TLYrY1YrHLDZwECwU8KMz0hGnh1XG5qN4wk7YIiKgThwbXhxQEkyAjCoCDM425tE32ekjRS84X+nbmvsDFKqkN6nNEFk/lUWZV63N3ijdZ/xfhm5VlusccFxSQseGmTfW7uBX9mtv3MHfhHqAG7ZGY73Ws6CtpNvXI6mnzsZB8+/L5Hd+gWq1Tn+sImdyRThb+oXv3vep29MBsZHTC1joZ2JMub3eg4WcHc1u0RK+CUN41rw/eNY7xm+2P8lG8+f31enOi0ilUrg9jah1u5MrLeuezh6+tdGCO1UCZDp6wUjwtggEjIWrZyYoqOF8mT1LwSHXYhMGtYY2DthtYTLYG1RhJuvxRZKa5hYk6WWPCCkpKqGma7avqIk5yPJsQuppo1F39lLO6VJZbZWH5BrXthnON2JMuLrs/BmVQA5aPLGg9Hb7cm0LbaHqb1p1DKI2M+VQbv4N5JXdnzaUElVfximJ8WnyczyZfCCmH1tbEjgg+tqvv0KRhExTMN6zMLBYyWvE11WYhlTOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(1076003)(2616005)(426003)(316002)(82310400005)(26005)(16526019)(47076005)(336012)(186003)(5660300002)(44832011)(40460700003)(8936002)(36860700001)(81166007)(508600001)(36756003)(70206006)(70586007)(2906002)(54906003)(356005)(83380400001)(7696005)(6916009)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:28:32.8306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede35757-d2fe-4988-1bce-08da331fda81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4770
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
index 5e8106641c5c..ca9131ab745b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -238,7 +238,7 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
-static void init_device_table_dma(void);
+static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -2114,6 +2114,7 @@ static void print_iommu_info(void)
 static int __init amd_iommu_init_pci(void)
 {
 	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
 	for_each_iommu(iommu) {
@@ -2144,7 +2145,8 @@ static int __init amd_iommu_init_pci(void)
 		goto out;
 	}
 
-	init_device_table_dma();
+	for_each_pci_segment(pci_seg)
+		init_device_table_dma(pci_seg);
 
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
@@ -2507,9 +2509,13 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
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
@@ -2517,13 +2523,17 @@ static void init_device_table_dma(void)
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
 
@@ -3116,8 +3126,11 @@ static int __init state_next(void)
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
