Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AB2D636
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Kev6wLP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar7e5sWWse+GtQSKKfiaBwLNADwtQuFxrI5bd1hdklw81hJbo5AG7QMGmy2jlG75R74T/VjWfJfI84kps4ZxX5AbXjtb2acTZqsVJ6P1Ka0UjKfQjAUAM7uAGuKuqfF05ZCUeX628XIxTJi7gktsr+ppgR5Byl7v/IZB4iOauAmIzU5jd/P916KLzJf91tWc31Zi5/vSP0Cdv8EW8AUmKlg7kfNPiIdbFeat+omF9+SbZXlPGi0VtazSrGDCbyvH0XrVxJ28tZnlG8yZWvbx+oc4uMMa/gaNitV9Q3s0o9MaP77Fcey59jDT8qHFciGRbgXariFHPn3otiP9jgljwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8AuYIBozdPjm1C0O1nDvAtPbEbHUdkxFKiW3YwGc9M=;
 b=Ig9APrNWY8aFeTIQ+WpZocdKpqzXyDihtYzh2wn4oMHEjsi7xKPAunMhW6J9UjQM3S2Qkn+sDXIEamPUcfwLW79uJRVTNgMhifX6Dn+8Rw7MXOwe6lT4TtcfkLcI7QfLdjUYD2OY6eGQXU9oRqgb/HWX3GlkcCuKzyjFcCydxnMuaIqJchEPJsSn86JhchkmSMIhKX3hg9jnUy+yc0BMIhiBbfZ6bmWqfdR5EwYop0rJFbvrvGCLnyMj+t1vh0gueEln3Zn4pfBEukOyZzpzDHz8NiM6B+p0FxVRp9HMN0Pzkix8C54KGS+vVZh+gfONeV8bUFG4JWl7HWeEbW+yKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8AuYIBozdPjm1C0O1nDvAtPbEbHUdkxFKiW3YwGc9M=;
 b=4Kev6wLPKvSu8vTI8/kXJXUNccovsgMLNkz+cw4ZTxfbt6iJr6xPY67V9DWgwsjdWADkUHeWRA+QPMjn38aWjRkUeB92N7mD5xQGP79rbjzAbFNsW6myxyHp8YR5NWM7MonUBOB+omRC3QaostIBzWlGHYbGfouoOgGvZ0RFvDs=
Received: from PA7P264CA0485.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::12)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:03:32 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10a6:102:3dc:cafe::f9) by PA7P264CA0485.outlook.office365.com
 (2603:10a6:102:3dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Wed, 22 Nov 2023 09:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:03:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:03:28 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 3/9] iommu/amd: Remove redundant passing of PDE bit
Date: Wed, 22 Nov 2023 09:02:09 +0000
Message-ID: <20231122090215.6191-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122090215.6191-1-vasant.hegde@amd.com>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc97cb7-cea2-44a0-8e7b-08dbeb39e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	baVsaI11k9AMyjF6lFjUsJXsQwG6OdKnQI46y7wxe6fILhp4QSl5at4t2ONVVzXZp6C4osEdJWDVRvS/K/rjiSuJavnSUn25ZXBPElmLIHJont0uZZN7xizKFKQOWPgCvGfYemjS6+p6r6sAYWmFQzZDj82HTRfJ1UnEGLbkwSRKjW56j9n6LF+zW8Z+bMfkBNhbusxj2cwtJ3GdvxAJz96FLX7UpiK6cgQy7VzMBNiVkBASCK4/DMhH9MqqsL6r4rGpxgNrLTgEzsdIYnFC8WinYktWSKlnPVqkqQHDzMcizqnwYTDqbiE77sRwzghQb/VvQysiRC9WmZJYNqEMctwYk22HAwJ154KkS0nCwYn2Dl1+W+bGD6bOeKSJNM1rhxitsQgKqtOk0RJWTZFBfKuLQz6K1+ZxutwFVgoGV8tiPkJf5CYfPpzYw4krRuHQt3zmI44HV+0jG+0X4d+eneJ42Oum99Z5JxvoIZD14iMHLR/9zEFzM4PwD6XBtN8+1g7YE1j5+oZUwkfV3i/xamSEcD/rBKPwI9w4lASg7dDiKhw4olVtgR+YnFPvybPf3sCTiDbxog99UoKyqCg5ice/vIWo7i09cyz32MnF+PmJHiN+WhLsvMvjtQACk4Em1rkDUOYm8e59iTUBHwXm1ojTGZEmIvAp1N0HlDqepMZ0WeDwsugwQRVII1sylJAJY1JoOri7fRc+YTXRBc0z1gW9VsEoM6Zs24+gITLw08ksny8+DaevedD7spZOqqBgZAKikKFoQ3hnnHaISp6zow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(110136005)(70586007)(70206006)(316002)(54906003)(2616005)(6666004)(426003)(356005)(36756003)(336012)(7696005)(1076003)(478600001)(16526019)(26005)(82740400003)(81166007)(86362001)(36860700001)(83380400001)(47076005)(40480700001)(44832011)(5660300002)(2906002)(8676002)(4326008)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:03:31.7664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc97cb7-cea2-44a0-8e7b-08dbeb39e6a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

Current code always sets PDE bit in INVALIDATE_IOMMU_PAGES command.
Hence get rid of 'pde' variable across functions.

We can re-introduce this bit whenever its needed.

Suggested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2d40bf5f406e..1ad889acf8cb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1124,7 +1124,7 @@ static inline u64 build_inv_address(u64 address, size_t size)
 }
 
 static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
-				  size_t size, u16 domid, int pde)
+				  size_t size, u16 domid)
 {
 	u64 inv_address = build_inv_address(address, size);
 
@@ -1133,8 +1133,8 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
-	if (pde) /* PDE bit - we want to flush everything, not only the PTEs */
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
+	/* PDE bit - we want to flush everything, not only the PTEs */
+	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
 }
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
@@ -1341,7 +1341,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-				      dom_id, 1);
+				      dom_id);
 		iommu_queue_command(iommu, &cmd);
 	}
 
@@ -1352,8 +1352,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 {
 	struct iommu_cmd cmd;
 
-	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-			      dom_id, 1);
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, dom_id);
 	iommu_queue_command(iommu, &cmd);
 
 	iommu_completion_wait(iommu);
@@ -1476,13 +1475,13 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
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
@@ -1507,10 +1506,10 @@ static void __domain_flush_pages(struct protection_domain *domain,
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
 
@@ -1543,7 +1542,7 @@ static void domain_flush_pages(struct protection_domain *domain,
 
 		flush_size = 1ul << min_alignment;
 
-		__domain_flush_pages(domain, address, flush_size, pde);
+		__domain_flush_pages(domain, address, flush_size);
 		address += flush_size;
 		size -= flush_size;
 	}
@@ -1552,7 +1551,7 @@ static void domain_flush_pages(struct protection_domain *domain,
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
-	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
+	domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 void amd_iommu_domain_flush_complete(struct protection_domain *domain)
@@ -1579,7 +1578,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 		unsigned long flags;
 
 		spin_lock_irqsave(&domain->lock, flags);
-		domain_flush_pages(domain, iova, size, 1);
+		domain_flush_pages(domain, iova, size);
 		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
@@ -2591,7 +2590,7 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
-- 
2.31.1

