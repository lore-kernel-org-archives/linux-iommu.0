Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901EDDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtQAefTbVGFv9VlI7M/25yufFTSQmOfNDHGJNzScwv7nziL6CtatkAnUkbDuCg/qtvxw8jYEVulWChl/oquuLcIepm+Qr+yrCIxxfWDTNM35WT49/JwYcQQGjf012OTD+413eUw58wU0Da0iIP7NY08UfsFI7Sz6YIa/YnfdU6rpVGrhQHmcV+b8Qkoeiyclf1vyfvH9NsUCa1z1eltPGScUJ8r1Dp1/yulqF9EwoOPuDjWZSz5tR+exTv75ix0d3ZSdbfoNvYHyZvJuvXfRA74EfycRyTUNFx8Gbz6oiZ8dJdRnbDuE6CakGrABjzU0NYV8LKePvsWElaTqBPfW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51oEQJYfTuQnxW2gckI9p3vtXzxtzOXP3GwXVGNiNW0=;
 b=Zye4ZtRYJcNsgai1dpK75C9NYBUTkmOpFlXnb1YfJARlHb/ehC+c0Z2rYnThvboeQEMokGpfmH4pbBVBwer7iLamTVN0nV+cl8c6dho7Kl2KG02UZxcEj9uG7Dwl3pDcPin2TmnDH9C5PKOBauOo61zf7Vym/Js6PcvcByqjWjes53kQ9DWfJmWqUSEU+Qy9LDafmiygUjYvg2k1buMKpcPSb0a0KXxoWb3nV+i1vRQnjSv4wQmvxNvQRBIafwFEifsvmks2bLh8JH2tP8p2YCGIlVp5ZGVVCWVIR6AKN0vomyrNUMx4yD30roX+WWkhT2GQZL2ukLlWuJx3MQQB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51oEQJYfTuQnxW2gckI9p3vtXzxtzOXP3GwXVGNiNW0=;
 b=JAozsQVjfMQliW0R62oPo2bO4qctjIdHUTSiXUJcXlset5Uz360r6uZsT0PWvzSZyGW8Kt6hs+eosT4Wy3N01/9zaG1Ae886DCGjsE5goUW+EDm1WFQDM3YyIGO/PwuIYSV5qLeN/JOrhvqLK148QrZsUbIXiY2vcFlHORFDoko=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by BL1PR12MB5898.namprd12.prod.outlook.com
 (2603:10b6:208:396::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:07:39 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::89) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.0 via Frontend
 Transport; Tue, 8 Aug 2023 10:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:07:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:07:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 07/11] iommu/amd: Refactor protection_domain helper functions
Date: Tue, 8 Aug 2023 10:02:28 +0000
Message-ID: <20230808100232.5977-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2c8329-cc88-4fac-252d-08db97f74bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kK3CCsJ9HMhlZLLds6D53BX3LDA1Zq/x9Td9ZTNF8S2s1rEp1/2f3dvszfVPKkFvqDuwh2G38+3Z2VjXWxxy2GUoJEZwR4um9cAcLPsuDQV7espkC/UDvJgxMEylmi+AzrErNhuUlHv9G6Ou2tTC8k5IzcmX229LY++GszbS+j/JVO0SAvLx01Mmv8WK3qCsQDFu9/LxS7o/xnh5denCZocJsWlfniNbfW3f1MJkvrrMH/3vA5K0nshYLjT/FEndwzvW53yjZdrWtAZKMgFZ8LkubUdicDMfWPG9TH+6IJmZGxAfQzBywAw9yBN56S9nhlLMTrlZIPqtbi8UYAM3QHG3NH0BOgXCzegq1PQkkQ24ZDs+aQmRSlxein2Hu2OKYg5IuUlpgbqLdUfgiGfhdjvNq4LerZ5t/OqZn8riWeQGSl6c0JCLDUCFBidYfR+2epgWmrFbdNWSqjjEGLrxDdFLPKIEylWmpdMjc5Nk55cQqq3o2JVL29bl1WxmS1lx66/aP3bqA/1DzfeBwNL59KW1BLlKEkZVoRdKMxDSSZH/KCrr506BV4oJsWw7UBHtMV4gU2cMEwB98qYCWC25RH28HZe5mGgAMaksY9Tttm53/pElvwGi9CjcjoZr3eAeHTYAG6PE1PNt92DnNJUHHKSWOV1Hye5F5vf+0t5oDXbVGSErEn+FoKAFQWKibVp/DOdtEOjHPGThXbpTktkSnkw/V1wGRtXkulAV3CXT5qs6P73pLGo73czKFRGcq1jtCBxw5HpS9W9i/SVCToEQmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(186006)(82310400008)(1800799003)(46966006)(40470700004)(36840700001)(83380400001)(426003)(36860700001)(47076005)(2616005)(40460700003)(40480700001)(110136005)(54906003)(2906002)(44832011)(5660300002)(316002)(8936002)(8676002)(336012)(70586007)(16526019)(70206006)(4326008)(86362001)(478600001)(82740400003)(6666004)(81166007)(7696005)(41300700001)(26005)(1076003)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:07:38.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2c8329-cc88-4fac-252d-08db97f74bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4fed3fbe069e..c9318be9fe4e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2146,9 +2146,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2176,15 +2173,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

