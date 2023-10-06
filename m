Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EE15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SlQQ7FeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRY2/5FEukiSr7RsX8r744fMIihDhYfGJVp/fWwcfu3r4p0If175KpNU+MxXAmUG5Krd5WZFcfY1XSWqF6clI14cNURqIkZCxtrvG1svqfQeP9q2Yq4akuPugi4DH1Y/wGKMHATDSw9FMIcvR4s7di7jPJTHR8pxvGYwwCopI6NTLBEreIjwA8TKbb8ROpQmdSrgzupr5UDVjDcxBTLs2ZGvdkq/qUwot++g08fArK2TMLS0MPYKJH35mDIE1A4x4w9gJSXrSXugS0umKUx5RfPCqDXNCkEvXCn4bDo+jxfhT31Gh8f704/sJ0VfocIzMtoVtLVL9v+dOci0v0w56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jNiyvz8k7IhxDBETvRaC/UOAGC4SczvNn0DQr3+koM=;
 b=Co9ILHdOX3laq/JYSHZkhNG2Zsl4WV1UrLOWXu4XcIq8VGnaXCoRp7oVxpsUyrXFQvSU6Mo2T5Teob9fXDnj9a3vtuiRIzXgoFaVB9INZQDysJocGcll5vtunGbW/fTQyzWQ8YAlAsaFLiqmXxt+zxPLPXxKPsKSFIO6dqtSFyzYNvlmrej290rv3g6Mac77yPXj8JnJvFEm6B44B9kLtDH4WqFzgTKVh4ErsmBs9g5W0WHD1WJup9BMuDCqNLMFjF7/2wSwJaVNoEl/4PfsaaRz2O6P3z3PfeAfsJvQVD4u/SvAEKzch0Me2L5vV94iFp/GiHQvlYYwjg0wQkNHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jNiyvz8k7IhxDBETvRaC/UOAGC4SczvNn0DQr3+koM=;
 b=SlQQ7FeLoOVWpcbM6GVSjEkd7E5W7McG2kJc/oTp9tDl5oRvbv9R0FFjmYDKgZRxWJuxij709Gay9XWk/bEyOPESF9JYDANtVgOiJL2N4WruUDVw+nuJQVOa3YacxVEZ5xXbLL3vb0iOFrTn2dbQ6eUI7Emh8UvdDk7qC/0y9qk=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 10:17:47 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::b0) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Fri, 6 Oct 2023 10:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:17:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:17:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 03/13] iommu/amd: Remove redundant passing of PDE bit
Date: Fri, 6 Oct 2023 10:16:14 +0000
Message-ID: <20231006101624.5912-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 570e795c-4fb1-4261-4b5a-08dbc6557cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YHxr/G69YZDVEn0TtDscBKfY/NIxHXsSadmzRqxDRAghI+QRcpX+edVhQbEPhgKzk37Z+ykWJLXzd/IkS5qPGf3X3aHc8FoNmzCpK1p/evByMSvEYylb4siCSisyGxbXo3PdPFPu2YDrVcpb1+H4EyOnuX9KEAK4CGdligjBYLMv9osLytME3pO28ao/KtYGQN22PhDHg0dvjkEP9pJoVOZo7ZlYfSR1thfoSmvF0QFb1c1jjGJH0hH3Trrb8Z0DHM8PGrwa/oYLM7D0O/Ryd9S8wKfv0rXZrJrLs45FKHcH33HIKneJLtjaHt4iRj6nRaVpxx6Naky+nc4JQUQ/iBBwk4zXpt/IfVMO/w+E8/htWeFibViS19aNzoac0XXpfoeT4dyOcxh38c65N+K/WlZSibVINSkN4eSf9JM5ODasiW0zNRA9NxeigPTmlC6mOR1wxqRjiRQqblJPmqWj/esFp6x8Dg86jg2vMG6FNKr0kIw+nGRWuCk7SHCIUmaFCwxJlcFPg99VRhkTW14ytjnWDlyOamVzqUFX7hpdWSG56d3AgTHoNxt8eVY+tlD13/6NQoXbx4JG66eWSx2XzCEc0hzWFsBZWYdH9+wgUz9pK7fVnU7cBBPerxoTbmreiq+kkYzZDTLCYOJ7R1sMMKO7qUbrWVkezZJVoHIivpvQuqGgm2ovEhuLIt1x/6ZtHPO8RU1n9apHly/MRSN2Z/6Uan6GC6AR8+TCobI6jsBkrTH8CtMtk182H1rgZlOqQJ2k5qf6QI82rbPTWN1S6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(7696005)(6666004)(478600001)(47076005)(86362001)(36860700001)(356005)(82740400003)(81166007)(316002)(41300700001)(2906002)(2616005)(336012)(83380400001)(426003)(1076003)(26005)(16526019)(54906003)(36756003)(44832011)(5660300002)(70206006)(70586007)(110136005)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:17:47.2006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570e795c-4fb1-4261-4b5a-08dbc6557cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

Current code always sets PDE bit in INVALIDATE_IOMMU_PAGES command.
Hence get rid of 'pde' variable across functions.

We can re-introduce this bit whenever its needed.

Suggested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bbbb7204b635..94c230bd3fba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1122,7 +1122,7 @@ static inline u64 build_inv_address(u64 address, size_t size)
 }
 
 static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
-				  size_t size, u16 domid, int pde)
+				  size_t size, u16 domid)
 {
 	u64 inv_address = build_inv_address(address, size);
 
@@ -1131,8 +1131,8 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
-	if (pde) /* PDE bit - we want to flush everything, not only the PTEs */
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
+	/* PDE bit - we want to flush everything, not only the PTEs */
+	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
 }
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
@@ -1339,7 +1339,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-				      dom_id, 1);
+				      dom_id);
 		iommu_queue_command(iommu, &cmd);
 	}
 
@@ -1350,8 +1350,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 {
 	struct iommu_cmd cmd;
 
-	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-			      dom_id, 1);
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, dom_id);
 	iommu_queue_command(iommu, &cmd);
 
 	iommu_completion_wait(iommu);
@@ -1474,13 +1473,13 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
  * page. Otherwise it flushes the whole TLB of the IOMMU.
  */
 static void __domain_flush_pages(struct protection_domain *domain,
-				 u64 address, size_t size, int pde)
+				 u64 address, size_t size)
 {
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
 	int ret = 0, i;
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
+	build_inv_iommu_pages(&cmd, address, size, domain->id);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (!domain->dev_iommu[i])
@@ -1505,10 +1504,10 @@ static void __domain_flush_pages(struct protection_domain *domain,
 }
 
 static void domain_flush_pages(struct protection_domain *domain,
-			       u64 address, size_t size, int pde)
+			       u64 address, size_t size)
 {
 	if (likely(!amd_iommu_np_cache)) {
-		__domain_flush_pages(domain, address, size, pde);
+		__domain_flush_pages(domain, address, size);
 		return;
 	}
 
@@ -1541,7 +1540,7 @@ static void domain_flush_pages(struct protection_domain *domain,
 
 		flush_size = 1ul << min_alignment;
 
-		__domain_flush_pages(domain, address, flush_size, pde);
+		__domain_flush_pages(domain, address, flush_size);
 		address += flush_size;
 		size -= flush_size;
 	}
@@ -1550,7 +1549,7 @@ static void domain_flush_pages(struct protection_domain *domain,
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
-	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
+	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1577,7 +1576,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size, 1);
+		domain_flush_pages(domain, iova, size);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2457,7 +2456,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.31.1

