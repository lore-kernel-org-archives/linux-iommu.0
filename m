Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F623AF
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVzaTII++YyaA50K8ObU5G2sreMKV2xEJlr38qEw4ikB5kl/pv9P8OjGZ1UIuSEL2QB03s85rD/xHMePlg2RSK63oiK9UIwKkeojxZczWdDnCf7V5OW1FXOwVD1Do2bqUtYoaqF06eRBLA3NGefcyhXdD1YSAWU26XvyeqYvGBzPvSAxygxbOeoIke0N12UC4yvhfiFRxlurK9g/KxmogUqh5ViOXMkbCoqN6/CLqqhlUq1zlzoMwhjaUenq3j5tTpMzYzfwMcPUw3s4Dtb3CXT/DMbiW2yTcUq05zRraEGnnZhsh8rdZkKjnNm+2fRnlYEj9uQzT5HKNPQ1IQ76TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LveEAt4bXPLSNbuJWsFrqAq3EgUl3zkOfRLEDgYCkqc=;
 b=MUhjVs1hKegjp1E7yBhdEshxNMa3X6n/wqb9XD3Lb3+xq50sUCe2m3YeLg17IvRMJ4CGeElAdkP38/stMG3DNtUJFeg41qTDFomLX5is01oJQ+EX+XwCHKDrhoaOzIs00e70wNjnTOAR0dct8HCFDrG/PmOjyCBPfOSyTZVU0Zp1pdM7rBDwB4mI3H/FwuKEOdNl+BMdk9FUz29uWDtl0TIeQnZ+0361HRaSSDG2w/f+8ds4e/AP/23TAiBvWk3Fl5md/5MSL3LOctWv3PHvH6Kq7pPyASTR8q9Szmm51UqXM+sf2F1KZm+YzefbaVD9Y6046CudGMSCHc2ZBITisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LveEAt4bXPLSNbuJWsFrqAq3EgUl3zkOfRLEDgYCkqc=;
 b=1MVWfOldjioWLx+C6DlGk3vcJjML1zkdwTvsfS67iCO6OA1CaI14bI2J5/eAzT7gd7sodj0+KkTtp/KNeQAB6I67+KKBQB9DT0YDuNvYB9iDL6RjocY5OxtoOHZ/7wXVp+ZX7fpiYNKvHVwdgeicQizuRNCm5Nsv2N37Hp2DkZA=
Received: from CY5PR19CA0076.namprd19.prod.outlook.com (2603:10b6:930:69::22)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 09:31:55 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::d) by CY5PR19CA0076.outlook.office365.com
 (2603:10b6:930:69::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:31:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:31:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 0/3] Allocate IOMMU page table using numa locality info
Date: Fri, 10 Mar 2023 09:31:27 +0000
Message-ID: <20230310093130.6064-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 18036084-6726-4c34-303b-08db214a49be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8qoiZQpNEomoH4ZaZMhdse8OiyV5Ht+SG560QcO+drkPqR+yWAkIIWKFQvMa3HckXg/MRGdOF0+rIZJk2nFG0FS4KAd1KvwyLhzGABCOZhXoi9M7oH6uPQrio37c1X+KUxrS9x4uReg3NFrlVher/SMF9ogC+z0iH/4FjnWg6ni943+dusH4HBBINgTMjD0Ikhb3+QeUdi9dwbhehNZmixCxrjVqbOe8Ot0/1aUMNOue75PsMjGs+SYYUJLMP8rsY10OIWkgdGApkzoyteTPra8MeClYyqXFB3ifgvnfjTcLFgrk4KuVJlgItiQiScvQ/pNbhAKggX8BDri6Cto+0wcT3MFFBjxfw1mLb1SBvOPjOBLz+Bd4I3Yc/FCZL92Ge9APtnTntwy1C3n4QXHdCp5ji1b3Vw2O4aejZuUn2M8gYOjAO7BDpiv97hTOuWTmD4NxCp357WrbYWNlK5bAZmm1Zhtk2CIlE9hvIZ+uwzA/rGgoRd+tChonEupYbhDHYaI2WHhaJlHhToDK5scfc8XDDDl1IiwjPJDIQJv/YNCzcO1wP8GcCIgG4JMBocfUJpDd9x0+/MJ7Q0rs0ra9yZLJJiuj6fjfARXhyY4VXWmQd9VS2ZhCIoVtQsLgryZwMKxBzM+1cDXaQiDr2GFjkrvO6fkB/JCYdwv5czyV9yihKn5+ljvmehxNpELjcs0AVkSwZ+XIXa/PT1DWnW+STc+eMhN7wPZgl8/KtrCo/Io=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(478600001)(4744005)(82310400005)(44832011)(186003)(16526019)(5660300002)(83380400001)(26005)(2616005)(1076003)(40480700001)(47076005)(336012)(426003)(86362001)(36860700001)(6666004)(36756003)(40460700003)(356005)(2906002)(70206006)(316002)(41300700001)(8676002)(81166007)(4326008)(70586007)(82740400003)(7696005)(54906003)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:31:55.0616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18036084-6726-4c34-303b-08db214a49be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568

By default page allocator uses running CPU info to allocate page table.
If it allocates page table in remote memory then every IOMMU access to
page table will have overhead of reading remote page.

This patchset uses IOMMU NUMA node info and tries to allocate memory
from same NUMA node.

Vasant Hegde (3):
  iommu/amd: Add node ID to domain
  iommu/amd: Allocate page table using numa locality info
  iommu/amd: Allocate IOMMU irqs using numa locality info

 drivers/iommu/amd/amd_iommu.h       |  8 ++++++++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            |  3 ++-
 drivers/iommu/amd/io_pgtable.c      |  4 ++--
 drivers/iommu/amd/io_pgtable_v2.c   | 16 ++++++----------
 drivers/iommu/amd/iommu.c           |  6 ++++++
 6 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.31.1

