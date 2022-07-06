Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB45C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 11:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C11CF41839;
	Wed,  6 Jul 2022 11:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C11CF41839
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ihSu78pi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rAg3J7QJvDHp; Wed,  6 Jul 2022 11:48:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1383C4176D;
	Wed,  6 Jul 2022 11:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1383C4176D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1306C0035;
	Wed,  6 Jul 2022 11:48:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8D56C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93CE1404B7
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:48:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93CE1404B7
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ihSu78pi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YczVmKdkW_4k for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 11:48:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C51A2400AC
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C51A2400AC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:48:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLLYvQ02NMYrs2OzsUWdmVyvGZD5Kgbu1PqHE2QzLHe0WSf8JhPNYyFg6bRgMseWhI0Yu6iHclcxmPqqhWwGn/zBPOhpFF7ca+UTNwCkUigJ3iCfwXj+NqfGEzQIo1N3broNxBMQ2EXMvgJQIfuz0ndVfyE5bgJM7DpWMpnh5P3exdiu90/m8I9+ONGigxlRy66xwUfsZttswwhCzlTKmt/I8VdQPEQtIrQ5tJx0V0S7jomZBwZ8nIh4BdLz07M6gZCmpgingxMVtkagNEDXYTfUT2dvaXIP/Yz/F19S6m2TrdEKHhyJAcOBe9LSte54K3V9NRKZSXsEGBELQh8sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doTyrQZp9Y3Ex6QX6iLwFFlvxb2x6FQYaTV0PMPAcd0=;
 b=mqyQs/y2z49X0AIkM5gbnpjvcOInRtxbAJRG0VsyZ0fHP1ferCDJ79envVPZ0CjKksab4BvlXS57R03/YeQ1U+v+8KlBeKVnRcnaR4XQnVs9foUCZdc1NoO1vGon8IR2fuTUAU65ofN8I8wuUeTz3DabIipsOWnGMw75zTxmYwOc18ICIUzaS9hangrWOxzVPDh7hM3eM0CChN4jIfuDdaYrHCs25fCQuMHLWLF0BH40gPCZsgsJpje7lr7+26JLhAbsfIx6W/Lep8Dl/gwVCiPollsK5EtN+tNdUPntljdS7vUHZJLuvrEgY4kIML+dEjCeV7men3zUdmLhBSDEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doTyrQZp9Y3Ex6QX6iLwFFlvxb2x6FQYaTV0PMPAcd0=;
 b=ihSu78piv30U1VTVw3pso+i1bKZiWM5xeunD5e8KYRgEoe9x9UQNwVePlwUwppp+uOazIt1salhcssEOdbf08aRRxmo6mRlE4q6l+j0aeASwswl9TwuQF6F1vuaMggezG8FAU3Mz+FqAhTNpOGt9VEwcwlHbP6lg42QpOvqBKgc=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 11:48:49 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::15) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 6 Jul 2022 11:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:48:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:48:45 -0500
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
Subject: [PATCH v3 RESEND 25/35] iommu/amd: Update (un)init_device_table_dma()
Date: Wed, 6 Jul 2022 17:08:15 +0530
Message-ID: <20220706113825.25582-26-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90aaa066-e6d3-475c-e33f-08da5f457d5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlWIEueqdvBuOW78zeH7/seYaN4Eb14cuwevaKLbcVkjahSK3FJOwcO6NfYKtb7k1JDR0jy1Bkfjbm4YVKvH4YmIPHr+ivS+h7BdKaz7oCTIEzhASELfV66qizpYMwO3wAYjmZFR0zljTBTWBcbvulyoNezS9LdDJEF+nU6PH22pExsRWKJIO/5ZNOV66CbsifwolJwRW8sKBV88kqRqipDTZ9GHnfGECrE2bsgPBmgAt+ai8GZ9xgtwNg/CPugd/Xma0eVuPZj1PmWiPmOHSyrwzfxSC0+e18UY6REA9Jz4+2YL3YvDNF+pZ8SBbk6hZLRXeUfDQjhXgPIt4hg+689IC8luguQxnGYzaWTAp0wEMTA0XZQJrzTX+n9ZBk51awDf/GA4+SM7xqnrHvnzmHUFPXnxPyukqa29Mjy2daAIpjlHJSVEV4bWnv3r/VvrpUTOrv9oJvORwk9BLJeJZ11RlMLJA8/JpVTALZ4pvC5U4cMvyl+VuPuGeQKvuN9QsXAXhyaOzAJ46X8Lvl+QCV2uhxlPl+j4hiEUAAlQBryFlbeo0E+EBRSrcItObJQSNQN0P00mZ7n7Bfirnl0SrSVDRx5uR3n3Q4JdZtC44VlVt/uv0oWJOGLR2cRvw3VvGK73c430x60PAq7oaBjcyuENQZew/JCtvwL/CXlulLvCqaojyPoLFfufzsm0+ZknjsNz+VrUkrglS4K22pHmbza1WIanJlWCNA4K/x+NqFQZjAkaNuYRc8vd3lj5scBLpOME/jV5zHEsdfZ6DS0ond8/IM4b+evaHPTXCG81VyytvF/wdnVHxQxCipSHbOdXW6vMmVJt1cGujG2U00Hj+7SmYaXjYnPzsI0ddhossd5Q1iphV4OFnuHyng6cV/r7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(8936002)(81166007)(426003)(5660300002)(54906003)(70206006)(70586007)(4326008)(41300700001)(86362001)(82310400005)(6666004)(316002)(356005)(110136005)(36860700001)(186003)(47076005)(34020700004)(16526019)(26005)(36756003)(7696005)(2616005)(40460700003)(2906002)(40480700001)(8676002)(44832011)(336012)(1076003)(82740400003)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:48:48.5289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aaa066-e6d3-475c-e33f-08da5f457d5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
Cc: iommu@lists.linux-foundation.org, Vasant Hegde <vasant.hegde@amd.com>
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
index b7e54bb5efc5..3024fa9a89d5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -238,7 +238,7 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
-static void init_device_table_dma(void);
+static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -2116,6 +2116,7 @@ static void print_iommu_info(void)
 static int __init amd_iommu_init_pci(void)
 {
 	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
 	for_each_iommu(iommu) {
@@ -2146,7 +2147,8 @@ static int __init amd_iommu_init_pci(void)
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
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
