Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E85C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CD1640A51;
	Tue, 15 Mar 2022 16:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFyQAg_2P5fy; Tue, 15 Mar 2022 16:35:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4497E40A69;
	Tue, 15 Mar 2022 16:35:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2985EC001A;
	Tue, 15 Mar 2022 16:35:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62EA2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D7E440414
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RoyXue96v-k for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:26:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::619])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CE4540012
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMgMSQJLXt0Vl2NjzSXsmFQqs499zl+vL9WReVvnrkEhDYhJCTzABT6bmhtKoRWHCygAaCWs+t4GGEoqTDJhuKbr4OTRFBRyQrU27XRdLFzAGAC00rjFjgFMcDF0KfI0petCW40z4s/w9mdf/o10xYWvmtDruXGWwchgKj6Il977rxB1uRKe1d2CxUSfrEyikbT9IqjuvRDybzNaK5oez+TvhF0JYUxXRHUsJTZnyPuW6zTKzTw2npGg9RPLJvpojnS0wHHGwqlnGZT8PLTXDOnjQuKcXICrEIpXrgKNH9P7rxnKMX9r/nep25/TfqTjXz/n6e/jUL9tMMJJYSh+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+m/EbSAiPbDEaxNu0wtIWJ+F42c77FY9wowyWQLqUz4=;
 b=SbTVd5F3hpjvoXrt+InYOYL62ZDuZkrCp/uevuMx+FW8DNkdGYgQF3psT50jJPq6Zr6NilhKxJuPvVn1nX0VqM/VuICnFhe+fjNUeiMxSpPsUMgKkqIRVLiYRkaHgM8q5qpD6kurrKw6yR1Gop8xkBFktulj9DtscaCEQ00UB3oJOJGxopkPtYYdfOxkhxU1eBxo1PeIH45os28KibvGCeWEbn/5wHmaW7bB6Ex1/uGgMU76Ui6V/htvSc6oQKZ0x/YDtpkkF5Qee7fvFEcsQjPoncdpBaLbsFNZoT25FbHBybN0lotUzv5HDlTX+8AX82EkEXpERb0ekxrj4IykCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m/EbSAiPbDEaxNu0wtIWJ+F42c77FY9wowyWQLqUz4=;
 b=SbEwupqRxeo4BjB67TYTa7bIQ5VrzT9iTReCW8B+clVePXpVshm2gMXoei5GLWnjiM4PcNXihfMq4o6hIWuBygyhAAamGcSjLvcArXmzqz34/2bmiW9z+zZJnKygF0F02Ouvem5zkSZ34b+qLAveNDN8FKX9HZ7/OjY1QOpMBXk=
Received: from CO2PR04CA0082.namprd04.prod.outlook.com (2603:10b6:102:1::50)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 16:26:00 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::5b) by CO2PR04CA0082.outlook.office365.com
 (2603:10b6:102:1::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Tue, 15 Mar 2022 16:25:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 16:25:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 11:25:53 -0500
To: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Date: Tue, 15 Mar 2022 11:24:54 -0500
Message-ID: <20220315162455.5190-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7cf218c-92d3-4b8b-ef47-08da06a07d3c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4559CAC249F1F1735C174955E2109@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhYCtwhwOlNc0y/Ff8usjF7VwDlMOGgdcjoXR44haGMnrdKD8PcohntRutEpHM0ZpM7ZzGYWlj5+vkRinePuIe3Bu4cWZIsV4nG0qoRR4RNTcEkeRI2oq0d0c64gPCHlqoL5HieiZQZSzPXsQVZEDenqhIpa7r68Bl2riAZL8atTWeHQhHZtfaP2d/Svaj2dZHe6njFXcBPcLbZM5Fl6z1AKS7MyPrL5HomNUyA93ZMktExJgbb3ThWIokes0dBQDHGTc9GlzoR9stTiZuS+2A2NKdreUX/R0J3yZGC/0n2vrU4tVOFS76psXn80axneCwtI0OWGJzZL4+zL4SdD5BWrEcRkbxfXsEyjdHOuWeh+0LxxjHxKwfnDj+7EIGwQyO4hjoardnnSHsGIppTwi62iaWRIZPr5mRaAk4nJU9JMizonj2jEaVIFLPPA9+9PtYp/ahSZA4lOfUkBMP5qE0OxxPvAf5L28fB+HyHGdNmDAmsw5ryB1VvHS5cM8ipD8QDMVH/ru5ldd+/qHwKEiF0z8P6dTNQhbHR1V3yDwAsS5E25NL8Ogfq2y4ZJKxds+AM4UWoW45UxuK4WKvUS0vtw32B4E2Xhqkm7V4zmwCR7QqU7My3ZlnblVva/dxkfO6iB4MJc11Ybrh2DFuhxs9HhJbmzpo85rz+2oqYdSwrR5z19UT21L/FaBXqCxVkOC46knFuNacZBNcPIPQXxOAySB199N4RLd4B+r3LuFvgOWrp41Zo8E6pLE4WzHf3TckAvNaJ0qRXEu0jY6kRNnGtKPvABUFlEmNz/5A2268g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(186003)(110136005)(16526019)(54906003)(7696005)(82310400004)(508600001)(966005)(2906002)(4326008)(8676002)(70206006)(70586007)(316002)(356005)(1076003)(81166007)(2616005)(44832011)(47076005)(36860700001)(5660300002)(40460700003)(8936002)(83380400001)(86362001)(426003)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 16:25:59.0151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf218c-92d3-4b8b-ef47-08da06a07d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
X-Mailman-Approved-At: Tue, 15 Mar 2022 16:35:04 +0000
Cc: Michael Jamet <michael.jamet@intel.com>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Andreas Noever <andreas.noever@gmail.com>, Will Deacon <will@kernel.org>
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
From: Mario Limonciello via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Bit 1 of the IVFS IVInfo field indicates that IOMMU has been used for
pre-boot DMA protection.  Export this information to the kernel to
allow other drivers to use it.

Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 18 ++++++++++++++++++
 include/linux/amd-iommu.h           |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 47108ed44fbb..68e51213f119 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -407,6 +407,7 @@
 /* IOMMU IVINFO */
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
+#define IOMMU_IVINFO_DMA_REMAP  BIT(1)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7bfe37e52e21..e9b669592dfc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -182,6 +182,7 @@ u32 amd_iommu_max_pasid __read_mostly = ~0;
 
 bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
+static bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
@@ -326,6 +327,8 @@ static void __init early_iommu_features_init(struct amd_iommu *iommu,
 {
 	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP)
 		iommu->features = h->efr_reg;
+	if (amd_iommu_ivinfo & IOMMU_IVINFO_DMA_REMAP)
+		amdr_ivrs_remap_support = true;
 }
 
 /* Access to l1 and l2 indexed register spaces */
@@ -3269,6 +3272,21 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
 	return NULL;
 }
 
+/*
+ * ivrs_remap_support - Is %IOMMU_IVINFO_DMA_REMAP set in IVRS table
+ *
+ * Returns true if the platform has %IOMMU_IVINFO_DMA_REMAP% set in the IOMMU
+ * IVRS IVInfo field.
+ * Presence of this flag indicates to the OS/HV that the IOMMU is used for
+ * Preboot DMA protection and device accessed memory should be remapped after
+ * the OS has loaded.
+ */
+bool amd_ivrs_remap_support(void)
+{
+	return amdr_ivrs_remap_support;
+}
+EXPORT_SYMBOL_GPL(amd_ivrs_remap_support);
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 58e6c3806c09..d07b9fed6474 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -170,6 +170,7 @@ amd_iommu_update_ga(int cpu, bool is_run, void *data);
 
 extern int amd_iommu_activate_guest_mode(void *data);
 extern int amd_iommu_deactivate_guest_mode(void *data);
+extern bool amd_ivrs_remap_support(void);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
@@ -194,6 +195,10 @@ static inline int amd_iommu_deactivate_guest_mode(void *data)
 {
 	return 0;
 }
+static inline bool amd_ivrs_remap_support(void)
+{
+	return false;
+}
 #endif /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 int amd_iommu_get_num_iommus(void);
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
