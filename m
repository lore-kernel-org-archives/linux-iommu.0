Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256BBA48
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 09:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DosZTQaBFCHA2duuJor2wvzr1UHiJFdcWwKv8eW5CGsthrSHx+uTT1QQ1dqvRf+a/kzgVEpqphpAOrbwhsYch8BIrm8/K3nrNPmpMe0F2HKunBKcF5btUrfr0h2L6sd56jBMXfVmT5LhgPaCltlp1SPTmqCsFvhvdKJRf6hrSUexmdqiyQKqPcr80oX78GhkfFeRH77OYwevAg++D10v8I7fMwTHKafUmzG2zz1cYOinl9bxi3s6EugsJFjXptXdouXMj81a1734+Htxv8VSFlRmsQtJak8gcVo6O4+FOdxFqh/6P0DmyJJyYFcF0+voUDxG50/gtA0i3pAD5VCATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L25Dp1tj5y5j1arkN3afgHZruBwx33nVKco1xMwSurM=;
 b=XNrxEfEzplzPqAYzYJ+CiRMDgiYzrg6xcg4w1D15vbiHFWR/Y0UU9KIsC+t6c3qj8lPCd/trCZCn1VirOKyeAocwCnpgVPQuQGQPK5lKf/524B4lvZziNua6xpwS0izevJSTu1D7GnKr00mG8Bj3M6U3+0uU5xo7NA+tfu2vipzNYPIw5j8RwP0fZOqifKghZtdcbq1JovSdm+H0y+WzeexcQKMN/fz4PlULJCd8yj/qs5/ddgEbb6lfcC3SKWpIyXq4J1CeiIBrYMd/+kydn+4o+IvnIa7fR7SE7bCoQB38VJAS57g3KMNsZ2ZgOG8r4muuG+wkJhFJpshD2hWNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L25Dp1tj5y5j1arkN3afgHZruBwx33nVKco1xMwSurM=;
 b=GQ8r0zGg/fQtkgg2OPFHw9C73KsvfNlyGLl7GEY6mGJvVoAbFS9T7CHCL3duK1hi/DE3J8SyR7bbcS6Sl4RXC9RzncDdBx1BFGg+k7a9Rbl7WrM3mgjX0mv7H2u4cwG1CW1Dpp7C+1Zs8a4v0xskcmOKcEBbhOfhyqKoFtGYvBo=
Received: from MW4PR03CA0342.namprd03.prod.outlook.com (2603:10b6:303:dc::17)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 09:03:48 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::86) by MW4PR03CA0342.outlook.office365.com
 (2603:10b6:303:dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 09:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Fri, 9 Jun 2023 09:03:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 04:03:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Fix DTE_IRQ_PHYS_ADDR_MASK macro
Date: Fri, 9 Jun 2023 09:03:27 +0000
Message-ID: <20230609090327.5923-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f292d1-403b-49a1-b183-08db68c86fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K9PCqoX2WgYXKirBh6G9IBbIfyiqbXlkgyXw7swJXeGs3+rQ608vHRzhXI4/rQTTMXlqPMd1xrTL8cJZb+7LLlx/a31h3Klx4c/5R5/uyuLYXGBDzmXsvaCFxjSA8HAhYvflc0G+yk8x9qiw+RTYYaKXTu+Ky6HScCm0J2aUwTeTg44Cf9Wlm9cvdwGEkAiWT2NOtCJ9sFjxZ5itzfzy8eDBlfvCzy1CXR2J20bQpEQl1j+D1d2yExxP5n8kp6YBUuIN7V5pQbCAph6aGxvwYD6LGrHijZioMsW6gjDtPxUtPLf2/xxS2gVzDFssoM22yjeZ29yRVm6l7nSV9xsMc9S617qmbpHM3YeaOxRT43TW2XNV9Ehv1xVqAOfbT97WKtJ73pjqKHskNLvGEcf7gNaSfRMJiS/bpPD3OcO+GLxdM69Iih5oUOIUtYwd8Y3mX71B/mA0JTQcQbIrICG5d6oYAHE/txbk/6B8eJIMyb31x5jmC/GtOvBWE16/YWqC3f2dnCILFeCYtTAU1sw/hv6rsBq8dNKjJJncUQqX6x2En0xqVxMrXGQA/tK146KwZykN+a0PBh5TZCZ3pFSHVtSy+L6KCLrLhbXy2qoCSVPqTQ/PHIYDk3CbnNFtMmlU1/cdxXQQUxIY0K6I5+FA60+4XLOm48mQEqkXzeEt9FAT6Q5wxzYtS5ysc1PaTzHAfw52u3jnrMgHBGUQTarnFKmm7g8OmEF348PKVWIsMQPxA+08aNQHti5e48GkQ6paw/yaWoRYzaCCIGGVZLsPRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(478600001)(186003)(1076003)(26005)(36860700001)(83380400001)(426003)(336012)(6666004)(47076005)(2616005)(40460700003)(40480700001)(7696005)(8936002)(316002)(8676002)(86362001)(82310400005)(41300700001)(82740400003)(70206006)(81166007)(36756003)(356005)(70586007)(44832011)(4326008)(2906002)(5660300002)(110136005)(4744005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:03:48.1894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f292d1-403b-49a1-b183-08db68c86fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

Interrupt Table Root Pointer is 52 bit and table must be aligned to start
on a 128-byte boundary. Hence first 6 bits are ignored.

Current code uses address mask as 45 instead of 46bit. Use GENMASK_ULL
macro instead of manually generating address mask.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2ddbda3a4374..ae0edeb379d4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -283,7 +283,7 @@
 #define AMD_IOMMU_PGSIZES_V2	(PAGE_SIZE | (1ULL << 21) | (1ULL << 30))
 
 /* Bit value definition for dte irq remapping fields*/
-#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
+#define DTE_IRQ_PHYS_ADDR_MASK		GENMASK_ULL(51, 6)
 #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
 #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
 #define DTE_IRQ_REMAP_ENABLE    1ULL
-- 
2.31.1

