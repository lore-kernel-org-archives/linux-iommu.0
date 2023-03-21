Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACE79C7
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 09:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I17Ky+oVuQ4M7DjleXmfjPBAT1/0zjeaQmcLvZg4Lw8tGWMFYSeFaG0Ia1KSE6OKKXE70b6Icp65q65gPcuMz0FVxWy9F3XZPtUvnQ6RO4Qwss6tIFy36HD01cQ537Icgfgi0MKZQ4PIm+xKz43iaaIFDkLjwHjBJ5jdABhk5AlIwgaZocKhLXrkMPMMyi9JLSKKj87Tpfiu4J6fde6gAaxzhjuC450P0sK0lKGU78IsEpBvbc8hzxypYtf5owTsxZvMe6vPMXOAIOiRZAO3NJDvETiIELLJym4GRmy5MVXTm97vLf3ThH5rvlW4Fp8X62BKePRqFVEbijEJXIFwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOxLj3rrXhGKT6qigSovzB62ihZIKRk9ubtOdEw93iA=;
 b=gg/PEmL693g9IwxHCJhPICYD87Xjqn/vEeNXtZrfJmJbBOJTZQL1+31LBXcHDAU1erW2nCR8TKeLleN7JNl0jXpNpG27UZ1BLXBkeFd+FZLtx8r1HU1loXHAK2AfNuYEFfnCxHwY+pA8QZkZocjsRh24PXCT22qnWoCOiXFkdvp+fI9owvlRe8wWg3A++QXRBBI1LMb3mdBHtQ4UjeFSdmPS4E9JFaLhQinshLTGf3t1WqxbwJeJgfM/TRXMqXXw4SY1ZmTCCq5y4h/y3OSDrkn7By2LSQoeu+KaUXzQfnn4QC2ZNKc0m7BqJfvxMyUbLt+3KUSqto90KNc2sQRzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOxLj3rrXhGKT6qigSovzB62ihZIKRk9ubtOdEw93iA=;
 b=DX173Vw3xA/Ztl+BZGgcmiwmBxUPo0sCjQesxkM2Xf8yTQ93+zDHbengYxx5DHI4/Q4x+bFBwrGR+R4lY7h+P7ZA+stdqrgRGSQJOhfSAHysGm2aJ0q+N3Dti/g2SOWFGTPkzYBYXVPRSawBIVjA5KQp5ikmnL5Vuxd8nV70ypw=
Received: from BN9PR03CA0621.namprd03.prod.outlook.com (2603:10b6:408:106::26)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:24:06 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::ae) by BN9PR03CA0621.outlook.office365.com
 (2603:10b6:408:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 09:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 09:24:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 04:24:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <aik@amd.com>,
	<baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/2] Allocate IOMMU irq/page table using numa locality info
Date: Tue, 21 Mar 2023 09:23:46 +0000
Message-ID: <20230321092348.6127-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2a08b4-8285-4ead-8fa1-08db29ee04aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3xeg8RCBu+YdtjhwV8Iv6xbCpuoZiEfRlRv0rbuI2Qup2h6iA6wR96pIsQxNow+qTvx1fuHNLJMBKCDxf/a376uxeJRX4CKzUbRNVvjpObIQiQZ12MpFS37SIfpISGk6hDfkuoeQ9Jiq3xcrqnP95IBlBfXHla3YtteKp9evDWF/sxmwxW0I/SRQ0/T80ONFtgjWej1MqxLVhJFH6UFDUYT5VQHgejKrVoyJoqyeCeG0vtUNOID2vJNz5QRcCqsLEzJvx+DZOjR7PaobsUPqgRblUnfO7hxyQkBov2hqXA82EX76+D7Ld4MaSw5UmpBozvVqpKXpdRxjVXoyN5sAmfWkES1DiGhPgcaoAQ9vk3ySrPZmNSdIlHVSwbBuLRZjU27Va3wKNKxk+Vk49trsROJJqWI2fGts2VbxuciTgZ4QcHYIbK+Ub8cwNBnevqZsq2XsG4S9jKiduro8tkojZmScP0U0btQj3fqfmL+mrlHwQ2fNvMmD+zGev9RTIrMIwV7w2t1SWWtMfFNsgOIzUP7qwx6oCYEJw/3Gq+YGe8RCHxkHlztPMTtI5kn5/urv1a6zWIt2ggrSnRLKcJ/XlaEHf8QOHS8aX7mWgllIBCLfEPmxdj2XqiHueyQ8wBFKtJN7P3L8IHdrenzA2Fhz5WkDYnHUDaTewcARDU55H0tNYsM/V0Q/YlZP1U5FA0lvaQKAbNRlBXQimSRN7O9goanHCUWszVEhoL54d6c+04=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(8936002)(4744005)(40480700001)(41300700001)(5660300002)(36860700001)(356005)(44832011)(86362001)(82310400005)(36756003)(82740400003)(2906002)(40460700003)(4326008)(81166007)(54906003)(83380400001)(1076003)(478600001)(16526019)(336012)(7696005)(426003)(6666004)(47076005)(186003)(26005)(8676002)(70586007)(70206006)(2616005)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:24:05.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a08b4-8285-4ead-8fa1-08db29ee04aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

By default page allocator uses running CPU info to allocate page table.
If it allocates page table in remote memory then every IOMMU access to
page table will have overhead of reading remote page.

This patchset uses IOMMU NUMA node info and tries to allocate memory
from same NUMA node. Similarly use NUMA node info to allocate IOMMU
irqs.

Changes in v2:
  - Removed redundant GFP_ATOMIC from alloc_pgtable_page()
  - Folded first two patches

  Thanks Lu Baolu and Alexey for the reviews.

Vasant Hegde (2):
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

