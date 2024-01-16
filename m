Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41E1B81D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjYig16B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4+/TnPqdLV9P//j/E08nyMQ6ftrfKASR08tdXS/gB2XNCalUtOmxYmArXiWYzTdy6RhFWYjVgjYMx1EnkOhDsKQj8JY83xil69jJnri6aXnrj2Nf341o/XVhLcDGdfbG4c3d0ZV/BnPbz1SX5wsfBDqP8D7t8CrgxghDGkoRwaoUPaUWy8vcc4OaM0SnS7dYTNcz8kGNBm8uLvnFF8iB9+VYP9rtMTaBgGRKA5mq308O+GEOp1hIdXO6ohp0fpumYGvjdaCks3iNAB6/VCRKEdEXyZE9X7bgUQI5eZkob/0dVrO6NBSwkyF0p7EjnIj3WVv924T0tLfSXqOk6X5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RP4E7Z6Qdyg4V8CwVGqkjuLiCyhMW8IQ8CmgLV7Jeg=;
 b=dudOyLkTteIoKQE/PtTCdPpLnmNxZ0iutLO/djmlNrbDuqowmcWinjZ6QF1yLz4LXCA9VqZIscvsB8X8bMfxEpnnE279DwOgPecIsOajuojJx2EPPvjXDk7GjvLvdSeTNpxDbkX6PY9k1L3c7dJ7uiVHEOtT7lyjOc0cwmiVHw9YA4SW5PvuokRVmolfR+VVxyjzE60PkoqHCkUOqDNSY/A50+kwc8+fQkqC1z4KBVhaNAF7JZfcpNmgTPI4RHJTdqE7eNtH6NMs69eJm3IUfybg3StxOv5x6N2gTftbLxKSC/U2AAb1NuivoIEHuYeiSR+vxgpR+CC0edBi2C84qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RP4E7Z6Qdyg4V8CwVGqkjuLiCyhMW8IQ8CmgLV7Jeg=;
 b=GjYig16B3zpMZwDjJMjE2bWRmFXOlRROVt98Lb2eoIu2Qfk9bR+abEqf+sqLMsnI6uM+9y7sxF4BAnQ1MhJZl69lUObTsTZvPrYhupjac39114HEQKzgZC4GIU2VFhuFIZzMJMouJpoIsqXsYsLskYiUPec0t//peYX2RZurjh0=
Received: from BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36) by
 CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.30; Tue, 16 Jan 2024 16:55:33 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::e7) by BYAPR01CA0023.outlook.office365.com
 (2603:10b6:a02:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30 via Frontend
 Transport; Tue, 16 Jan 2024 16:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:55:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:55:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 06/17] iommu/amd: Use protection_domain.flags to check page table mode
Date: Tue, 16 Jan 2024 16:53:24 +0000
Message-ID: <20240116165335.6043-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: c4953fb9-0a85-4b56-9897-08dc16b3f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rt+W7EfldLVQaneeOBykyp7Dfqz3ZWfE1scKaSSZtNaajfEyFXvGe73QqDEoff/wpwKqekNRRQb9pCEeTNPfWrBzAVG398rvLfCflgkRrJ7BSy5KjxH2yzg56L1nSfRJs0U9W5r5jpIFaXDSqz517yuOxisylDJq0Y3agnlwx0VMXBwDF3BJyVav4oOrW6p9pjHHcm2qPjAT8qkgPl25Wvd6IbNw1rBJocaaoTJOfW5QaVGgJ3HxJGHGeGezi8VkLzldV/fMVwaJzs4J1CLYF/arMNQhM/0v3pSQ6hqir+jDJvuGmLzhYt7L6nb7MpCi5bMol5UIjJmtwaPPKRR9WejH2tAY25rtPGe/eebbq2Lk0qc6yMf3NYW2yvb16WabFZmoZDSptxUbv2IXcJdqBkzUqaXOAoIxIJcCEB6G7ZO5OJVX4NAtAvmvpHF8nprTNDnAYle+XpdapVO+x+4lMptjeIzh7C6Q3zPqMnp0OhJjgxiy13ta00lq7rqACCabuvDDqJETc7fQja2CA0gi9eMqkdvNB4BxVY9SGEHPmpSaG7jts8/JgA3T/0yC/roeUkZGt5oziTSxfGTb3EfSmE9YwY488igyGYV5ggVPHqfsdfFZDMGX+2AB3cbJUfRKT0e95bYUk1okYS3MT3yxdGp/rBBKnS5ezCO06S71teXfIk0go3/dPhBeQT6YIpW39lMdFWAtqdTK302tD0va24ppS8pH3vr1aVcHCiF5d5DsK/QVLVtiWxcQ8NFlL0cteJsUf5ExLCCtdWiZBg9Rrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(36860700001)(82740400003)(47076005)(41300700001)(2906002)(36756003)(86362001)(356005)(81166007)(7696005)(54906003)(70586007)(70206006)(8676002)(316002)(8936002)(6666004)(478600001)(336012)(16526019)(83380400001)(426003)(5660300002)(4326008)(2616005)(1076003)(44832011)(26005)(110136005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:55:32.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4953fb9-0a85-4b56-9897-08dc16b3f3f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 88a536dafa7a..dac04585c7fc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2315,7 +2315,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2361,7 +2361,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

