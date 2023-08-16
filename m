Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E82174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK916YedsirlVGdkRlKFxlyHLdp/JFNHlyzlUnJOXc+MmJzMnxfxiM08p6MzKOFKyDy0a3CzGgee4OuIJc8Cp+AVmlYcDVwbMKfrr+sk1tF02qCdPPZKtbartP5IpPFnsELZbYjYvLHeBsmWPXVMkBc6Hr+N12R0aQfYtIpRY2Oqt7BFcaU9TnJnJLhkiuUfGQ0g8Em0IEb4+9ANunaxayp2MKDwpqFcpOb9tnsVWpoD8BCp+QwvhRD6Xo7Y8l0dczEwEi6ZQPn6BW+jKEIGGmMV4FjxtBBk4W0WUYZnp6O5xS/buLeaqKmcr4a7CW5boEj1D4pVkdWAqrmSToffFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbIUAXToCASV/4CJLvEDfJ0lMWQAqPlqFq+d+30roQc=;
 b=PomZqlCNjdPzKDBIoqEORW2Ng2edzchro58Q3NJJQBxlOFJkTEDiOWBTVczwwRzjOiHfWWmnKusQ8CXDAKgqWnP/qxjPWz8Z2VV4Mo4f60j0Hvavpyy77IPvH9rVFxFf8C6+nzzIsUpVCIJ6fVJv7O4XgAwawznkjPKQLYZAWhgSK2BbIqHy8x66JDKRM4LE7IzS+xXkTTV8RCZqjO0NVuBmKbQV1WJ5TVUX2YXOp2fs9rjEZz07EO2m+uDaTSeAbcurJkZzFmNBzdB/Rk5nRpcxruYm4rxudi2a4ddcqBWQDm6MI/UUZ3wde7Gy1pD0HrDYeVHPT27mTO8ytzibbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbIUAXToCASV/4CJLvEDfJ0lMWQAqPlqFq+d+30roQc=;
 b=mgxUYeGENMbBYr0PdH8mtKf3o+5HQ8OeTE1aOZF++Hp5aCEMEuZ63qNUG3aQcfUjp799u9q0yUJD8f4gkmJcsZpI4jHRvArrXkyFbwtTpBstFgma8fjDMXC9bxK6TsUzhasvFoWXSh0HAQOacVuZB1slhv8kumiyImO7atJZfuw=
Received: from SA0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:130::19)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 17:42:13 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::40) by SA0PR13CA0014.outlook.office365.com
 (2603:10b6:806:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:42:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:42:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 05/10] iommu/amd: Use protection_domain.flags to check page table mode
Date: Wed, 16 Aug 2023 17:40:26 +0000
Message-ID: <20230816174031.634453-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816174031.634453-1-vasant.hegde@amd.com>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 278e1dfa-fee1-4348-2a91-08db9e801fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWUeLVfFFD+TIAVB2JNM9Wh95JmVeQ4FzOWtkuzj5GixZS8v8rrPdqFxYRT032gF5Lmpr1oD2nrqqdYmPxGmnhMzqOS93F/tnPhSqV9Qc/Rv14sDlhkQCsMWUadW6pqaa4MQIxrxyPkLPqPviNKN6k7NEehOW23XO1St8Fjma9Vo+/xTXQn1Qnqb7Ii6fAKkpN7gMHJs1wnKL2Z102AWmv9AfKCyx5cpLpdYKiT0sIGv1kyNWBWiRROY5E7dNfoXmV+rHRpBEhfEaXbOObReMM600JUw2eidUe0f7KuoFBrib7cFBm7VWdnXKjmZ1j86RPE3JLP5rNRx34F/DAjvIsPadGxaAIDdLxzE4gkwP+uM+eTuTPUb1MPqVC7JQNl1p40fGG/tgwwzHInlKDfWtqWxVKP4I/lB6qOyWpirGQDJv0iHI8AJYNZE9dgFv4/SuxjtNky6Mj8s2A35vgoDf69wTMohyoqORQ1dmIMpydsLHzIb0hlbz0fNzp5zpZFx4lLswsyIPKlVvGedSpor7axzxmyzncq/rQn3O9+O4o1ZR1pEJ8OczwAOgYn3RQJEPHf4uPeVo4hB+I1LKfTulT/s91a/lpW5J8goqvZQjR8UPkM7jZphJujEVIX7MUDkvA5EPauAzzWCdrwODA0JJewC1vAEGCta8AwRUE1BYi+BVTcxXV16YFES5VJtRd3ae5QDpc5hKdjITqqlomuEjRW9lrzVDzO7oX1CIEJqPkVNgf8hjwrsVxxgf7TuwuR3dpXVz3+ZIj5EXf3+WT0X6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:42:12.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278e1dfa-fee1-4348-2a91-08db9e801fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

Page table mode (v1, v2 or pt) is per domain property. Recently we have
enhanced protection_domain.pd_mode to track per domain page table mode.
Use that variable to check the page table mode instead of global
'amd_iommu_pgtable' in {map/unmap}_pages path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bfacad9ddc14..ca092b128402 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2289,7 +2289,7 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
@@ -2335,7 +2335,7 @@ static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 	size_t r;
 
-	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	if ((domain->pd_mode == PD_MODE_V1) &&
 	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
-- 
2.31.1

