Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE5CA4D
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1Yxo7xGutc0V488k7Zfp9Guc9+DBmeewysE5bD5Cy8HZtB3cVDKWb1HZNUEx9lTby8Th1jsownk5MUIN8K+lAospAxslErnc9aQhW+qcNlWbeGyiKfJc5t/EILqmO0e6o7BOSkTihytyLEU8ENfuzpyypPZRv8ghQ2ZZvGSTK04kadPZVHqh6BoOVjBkAom5QIAzTaS5UPcmetPiYqHP2C7yQFoVkSl2CYMKSRpbOyvLpdkQntEo/nIVLjIS2QBHUy6cB9Prm9RZKgmrMb7jidlUcvA51iB8ofoz7fB/XJBEwXiS5J5s7AFbmej7VH3lI+7U0vdc5/+oF36Wdx/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfa5g+oes4m5TY2TLJmkuTUfomg/uVYgZUcaFuoy9Tg=;
 b=ViYsMrJ4rs2upp50eU2uh7cu6R1WKLfFSddQVm5YWozZhOQTpTaudlHhajUCoq87cnnfqpgmOPv2Tz/P/PPrnZNtcI0xe/DYB9X7pQ5Ug1SBSu6LfdorKDqVUKneUlH5bfpOG/VwtiGl7Thvt23kpnVpM0qcIjXEzOLImlu0FK0xERM07WquilZ6Rt+/xxMYm1WhOIxi1L2gZJXjQFXcfyp5roBjDH/c6ipQPISwREXzaOa0H7P8nL6LzzX3f/1sjq1yH6ggy84+TKyCJtfX8HFxdfbj/ksxIp3z7za70wi7NFjga5wCu0fLDTQc91mLo9Pc6a5AoG0O5GE3QjBCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfa5g+oes4m5TY2TLJmkuTUfomg/uVYgZUcaFuoy9Tg=;
 b=bdsl8xShPgHtf/IBFrjz21Xtols+GORthh0w6och1j6w//kaLAvPASXaMmzmFqqNa+W1Fn/2eoIfntjSlT/1bjMEbwOMTs1W3NUaTWXox/hjRYQmMPHZBj1Jg3ws+qBZ14Nj0LUK5f70NblqnEhc+SEDHkbWmzFOxw824/YOArE=
Received: from PH8PR07CA0039.namprd07.prod.outlook.com (2603:10b6:510:2cf::7)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 12:11:51 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::85) by PH8PR07CA0039.outlook.office365.com
 (2603:10b6:510:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 12:11:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:11:47 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 01/11] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
Date: Mon, 11 Sep 2023 12:10:36 +0000
Message-ID: <20230911121046.1025732-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ0PR12MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6a2bfd-e614-4a4c-241b-08dbb2c0479b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9fmBBY5qEnFXaszwrj0yUnNuDqNF6Tr1YbU2GQBKMd8xlelKrdfyzpj2aIvlHccP5UgiZpVODx/0LlV2ngU1H8u5/vIIn12Frv/THSl/XGjhoZPB4QmRbWGgVyUolOGXqKfm0zsFa4mD8WXgvAnN0GZ6uXPUy4bRjNExjks8DY9UsIS4GFdD6gxGCdZXFn2RXVbAEMabaDQ7FwgBhfj1nRryjLi84xZ4GcdUoyTuOQ4D0KmY5HYk6TdMKCSEUom3fPr2gGetO5HjnW64cW2LNrWwwBdBYomaOd5QlA3rhYCCTaHTZiKntyU+/rxebHc453N0L60BYy6WgfLOcwu4EPzhXNT1CsnMsUHTxbfqUdlt7POFgr1EpVOsH2gJGXPo70oA0oi/Odxqaz36OE5jKUr+FNMORfi87g8wEAKNLlvqvXXKmU/Dyo33uiOkDTFIVpBn9JoYBV8xzYYucQxzMCL6wc0dCXW1LEsso3qy4xAn3eXoq/tJRTAeWwFPh+eylS/JyQI5lIG322l/pX/8+f8REQcdZiuQno0xHmEER+gY+lOrMjeavkus6PULP267gVwgT1Jhp8Z5Y/IZHKQNjBOzU6WDmuxNNWNokzbkgMMO4ngQtd0GD+oZs2dL8WngEMVLbCfHKLA11C46nJNBhqBb6oKur9XaFPhCknI6uarcfStykXLuGDkYcUcIgrlsnJKnvHpFGZ+kSbLV19hIrbKGIRm+Oj96/7g1G88rBloHAhaL1zpSQPtltanjxRj7gZQWm9XBFn229XXkgmX6Mg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(83380400001)(2906002)(1076003)(2616005)(16526019)(426003)(336012)(44832011)(54906003)(70206006)(26005)(110136005)(70586007)(316002)(5660300002)(41300700001)(40460700003)(4326008)(8936002)(8676002)(40480700001)(47076005)(36860700001)(86362001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:11:50.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6a2bfd-e614-4a4c-241b-08dbb2c0479b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1aa061543c9f..7d18addb731e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -38,7 +38,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_sva_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 64bcf3df37ee..3820ae738088 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_sva_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

