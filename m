Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544E1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwyRB77oo4lSqvRjzBXPjNEQXEjYNJNjT+jfYs/cooSm5qFpwoM1HKOQ6bRdWytNq4/V1rtJg4DtzzyeAmgvMmy2R6Xbhg000HrgG42KH2tAx5fC4EKqVDr4pHUbQY4V6oKFoxnK5TMu1mF2yleVexV32FpF82+38LxntCkK269n9r2PlGM8/StkuTHhtxVJefAMPwXNh5xNwjP5vESPriHhnIWOF2V4163R86SfNd1qTHKmNh2tTIsGvXZ9lLpmrYg4BNf0lcvpPOXyHsUqTWudJyXudqPIGC1yVqZIUJgRMYgirs6WWg7YpeGn7ZyEaXMgsdDLszc9Hg1n0BByqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+10o/QSwCMrO8fGTYreBsiKjxwmwm20JKBiS25BzvU=;
 b=bl7TfjEEXHjv+H7PsjGlmpCJIeKm9Gx6AoBve3/CC1NK8fkA74Inb2LHWT+IM/jdm2TnxZOxHHY+3UehX1nx/mtGrkisupM2738D8RUGbk0P39pfxyAq8XZTr0/IoyKAlVH6XAssFquctk0OQMXW/bPYcWyw1YqD9phWfLTj3UTEMlOctpJUhTXL7+rUfe3eNUYlBewXWy0AkxdVFMvDfUUKQ5x2lfACp1JCEpDyc8L9fBxSOgLxCcSgknb3xwoDAWNVonnPGDtXtAWNet1wcOiiP0uzxMz1qldlXl5QdMFwDYiVHMqJxe/cdHu1XdVAftbbUH5pINADN0vY+0JztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+10o/QSwCMrO8fGTYreBsiKjxwmwm20JKBiS25BzvU=;
 b=SADn8xpif3Y+PFmzkMdOfN11WhZOB5RUawGpBY8RkUHspefKDuHyexELN6xIJbl4RvsWf7aKfRLNap/u8ACwSI2/BuQMLUb/Qj4Qk1FF5sxlTUx6U6cbpOdkbzWg1zKc15EzisPrMSRc8ixGezHHivc97K8ok716kNJ54gbvAgw=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by SN1PR12MB2496.namprd12.prod.outlook.com (2603:10b6:802:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 06:41:12 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b4) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23 via Frontend
 Transport; Thu, 25 Aug 2022 06:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:41:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:41:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 2/9] iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
Date: Thu, 25 Aug 2022 06:39:32 +0000
Message-ID: <20220825063939.8360-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8caf3bea-77f0-4572-63d7-08da8664ccfe
X-MS-TrafficTypeDiagnostic: SN1PR12MB2496:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1VAjG2uvhNEKpuatFz6OG7Ac0B/uLcNTxy0aIAHYOCIKJQz6eRsL9rG/kZ5PtrDblRKkAMKceIGadZpU1yl3XYEZ86Ecp6ZrZ+NdDhANjdz0EjGQ5t2HT2HAUg5yq4Da0qE+HlBUJPvPF02rNjUqiPvHSDjEt6t7fBUK5GPm5WrMdgTXZRps4RSEvbe4kb7sVQa8VGIIZPedM6cDOHckh67PevH4seINLx9dqTLx6zI02ZaLSDjG8xYbKr6dlU8EB/CHcjYdvMpzivfaY+j8ISjhIWvqfYk8ldPcHCJ1jFKQV9lPbz4TO875ZVWHT6U8Y5o+Q4egn3hGEPTapbYYbdS6gWYFsMb8d/3UNUiydw7mXdjFaIjAs6LrOVDje4pPhTFyyF1g8gG0FboXxoCxKXpawfo/pFXSvLv4LkoDBWPpFCvG6eZNwTv56pqNb0O1SHGKisSxKjTKC+on0R0sfe2ubGbtNwwpbJKQPPaZaYW8dqjJBwsC+ulbb7xD6+fEuEq4Lu7+Oia2eG1vD4BqjncVNNPckXRg1fy9Xn3l6YIRB2BjLOQbd5lBbvbIZ0Nq4PkePttGGhcIz3b6TicD0hb7LeOl+HRCXe5ty94DQr6Je6C1TiSg7SaeX5bJigaV4Glb+yhD26TvOTzjyzQmz7+ZIXKEEZdNRuqPQI3MswpGF0eMHPAWDErZhB01r6EXQk4wPKpeYx7NrN3tboJAoa5T+atJIzen9Ms9iuyLZSNo1rX0MSiIkam1HBA7DIVSFUgy60KHhh5z51YaGOPyTHTPO8o6bfeORLi14WvBs4o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(356005)(5660300002)(2906002)(186003)(44832011)(41300700001)(40460700003)(478600001)(7696005)(8936002)(81166007)(6666004)(86362001)(36756003)(40480700001)(82740400003)(82310400005)(1076003)(426003)(16526019)(47076005)(36860700001)(336012)(2616005)(83380400001)(26005)(70586007)(316002)(70206006)(8676002)(110136005)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:41:11.9328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caf3bea-77f0-4572-63d7-08da8664ccfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2496

Implement the io_pgtable_ops->unmap_pages() callback for AMD driver
and deprecate io_pgtable_ops->unmap callback.

Also if fetch_pte() returns NULL then return from unmap_mapages()
instead of trying to continue to unmap remaining pages.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index df7799317f66..ace0e9b8b913 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -435,17 +435,18 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
-static unsigned long iommu_v1_unmap_page(struct io_pgtable_ops *ops,
-				      unsigned long iova,
-				      size_t size,
-				      struct iommu_iotlb_gather *gather)
+static unsigned long iommu_v1_unmap_pages(struct io_pgtable_ops *ops,
+					  unsigned long iova,
+					  size_t pgsize, size_t pgcount,
+					  struct iommu_iotlb_gather *gather)
 {
 	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
+	size_t size = pgcount << __ffs(pgsize);
 
-	BUG_ON(!is_power_of_2(size));
+	BUG_ON(!is_power_of_2(pgsize));
 
 	unmapped = 0;
 
@@ -457,14 +458,14 @@ static unsigned long iommu_v1_unmap_page(struct io_pgtable_ops *ops,
 			count = PAGE_SIZE_PTE_COUNT(unmap_size);
 			for (i = 0; i < count; i++)
 				pte[i] = 0ULL;
+		} else {
+			return unmapped;
 		}
 
 		iova = (iova & ~(unmap_size - 1)) + unmap_size;
 		unmapped += unmap_size;
 	}
 
-	BUG_ON(unmapped && !is_power_of_2(unmapped));
-
 	return unmapped;
 }
 
@@ -524,7 +525,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->tlb            = &v1_flush_ops;
 
 	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;
-	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
+	pgtable->iop.ops.unmap_pages  = iommu_v1_unmap_pages;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
 	return &pgtable->iop;
-- 
2.31.1

