Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1A2D636
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urUtTj0j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnLAhrNRqsfDMXQm4TgTH8jno8M9zX0ALiDsTIq3zEBQ0d0AxHnf6+7DbTp1CegYuA60vdiIEnwW0W0otZr6AgTu0WFoOj1LyLh57R2Zny9cKgxH5g6TzbUu00PIw7L3K8caSjzWKUYVWc6I1/uTWiKAzJs+3pUtthICjJlHoVHUeofCQyqTJBJQtbkS0uaF9gsdigMtiPWTSgcWlHOCNooL1YCWYaXWFTIIbUoZeEypa7Rnhz5z3tnX3YkBA/zFdBpu67lqcdSKP6ds1R/Tsj+zziEfcjWQ8sKxHlDJgLTMo8GaKu+Ll6kcWlgdhwrcAg9nZnfj1XUXfmtu/lc9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faYCRXHGY0ix5hJz40ib9dx5Omc8Ph2D2NayjGDflSI=;
 b=adjOqOY34bOmPQnvtREV4PcfIZxXhaP3ODTXVPgG4mv1tRWPKgKEGRxlzydF/4f8X8KVUxckZ10fmlPk55NJrJ66X/xsHg45jo1PRC7ljFx5CYyForbMWovGfCuakir1ZAPDkgOQDuC62LTajzkpNvWipXEeveIZGWX+oM7vGZmUhWoaCI29zK8lMK79AC2neVvJzfLYM4S8h/WL++f2HTNsQbGGAMKm+10fGzuikhVbLQ2YgoG59onxg9w5npId7fxNYd+4yUcIdiR39jsyQmMtP1Q4g4pMZtNmaPp4SPAcOQTrkwGBwOolC4yiTuxWflkKsGAxm2oZ48Jt5ts/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faYCRXHGY0ix5hJz40ib9dx5Omc8Ph2D2NayjGDflSI=;
 b=urUtTj0jU2t3wOtqRnsw77BpFHOfLV2HdGoaqZc0qS0z0r+qmTMji4BC0jl2lgJNnojcZkzrWEBYtUjgaJq24e0OKUf/aPwB3VjIL5AUE9JecytcPTM7ucsMfTRhzMdMxZgQXSMrwrwP5T91+20g5+yfP4uePtRQ0AF+GjNFkaU=
Received: from SA9PR03CA0026.namprd03.prod.outlook.com (2603:10b6:806:20::31)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 09:03:46 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::a3) by SA9PR03CA0026.outlook.office365.com
 (2603:10b6:806:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19 via Frontend
 Transport; Wed, 22 Nov 2023 09:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:03:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:03:44 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 4/9] iommu/amd: Add support to invalidate multiple guest pages
Date: Wed, 22 Nov 2023 09:02:10 +0000
Message-ID: <20231122090215.6191-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a699ce-c416-4db9-2e7b-08dbeb39ef6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dcx1pZNaXC0JoRLMM7e6XbhwIdblB/FnZpzKs4zpF8SZJZY+sX7s3wi7YMzWLszBjRxb9lP5uu7R+kYzKBo/sFqSdH98CbSg0OSW7YjHK/71emBSkrTAE/vSwNWqP6dvY0DzvNTzDtnlH+v7sMbSka1igKrYBxlJjn1NMmHbC6aC/xhbY17FTQ/ZHzWUXotTaVd5k3R4HCt0SCAk+Gb+7QW8t+LdDH3C2I4dbdbt6YQ5f0aQVwesWEvW0b3hkhVskbp4MjS6L6SEE1G+hr9djoXYaDJBRzl1myWhHjsLSkdQ/vyOCx+mMGI7C9ygUTYPtM5d94ruyn0q4a4EOKihmL8st8cBBchpn3YouB6Koh6aAi5pgqqKw9B0WpPTp19INHbE3bPXeWL5i/nKQrjKMKBEE3Pv63SebeAHZB5sfDfV3QmgmHdSmSnmEGqan59magx1xcBzUa5sqq4eaG3byKYdCJttEaDWbthl6b/8MtiLzvJ4rq+PbNjc1leCQf8rTT2JbZdpYuer8FUXxZ2VEN0eV/n3+QaTilAMkP+7X40gdNT7BgOXWBG/n30A0tH3I34ex4B7gZ3kmfGccVEupDf7aVCRf8zT1OzZpcjkdO7MIsF1idHSG9eSs0yXnyuejvdRGLEiNugXz6Am3OFZZY403v5pnWc6eCIFOkspOI38QwpgvzXL8uQVlhJHGfGTGOHwAtoPbAGagQwx5PBMMxrf+CnObLwzc86hSNofBm3x6evdFz4nPEtQmr2OrkmCjkMtFymaYh9ky0xCTCfYUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(336012)(426003)(47076005)(16526019)(26005)(44832011)(1076003)(83380400001)(4326008)(41300700001)(8936002)(36860700001)(8676002)(5660300002)(2906002)(478600001)(70586007)(7696005)(54906003)(70206006)(316002)(110136005)(6666004)(81166007)(356005)(2616005)(86362001)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:03:46.5005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a699ce-c416-4db9-2e7b-08dbeb39ef6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

Current interface supports invalidating single page or entire guest
translation information for a single process address space.

IOMMU CMD_INV_IOMMU_PAGES and CMD_INV_IOTLB_PAGES commands supports
invalidating range of pages. Add support to invalidate multiple pages.

This is preparatory patch before consolidating host and guest
invalidation code into single function. Following patches will
consolidation tlb invalidation code.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1ad889acf8cb..68dc19784f4f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1152,40 +1152,36 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 }
 
 static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
-				  u64 address, bool size)
+				  u64 address, size_t size)
 {
-	memset(cmd, 0, sizeof(*cmd));
+	u64 inv_address = build_inv_address(address, size);
 
-	address &= ~(0xfffULL);
+	memset(cmd, 0, sizeof(*cmd));
 
 	cmd->data[0]  = pasid;
 	cmd->data[1]  = domid;
-	cmd->data[2]  = lower_32_bits(address);
-	cmd->data[3]  = upper_32_bits(address);
+	cmd->data[2]  = lower_32_bits(inv_address);
+	cmd->data[3]  = upper_32_bits(inv_address);
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
-	if (size)
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 }
 
 static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
-				  int qdep, u64 address, bool size)
+				  int qdep, u64 address, size_t size)
 {
-	memset(cmd, 0, sizeof(*cmd));
+	u64 inv_address = build_inv_address(address, size);
 
-	address &= ~(0xfffULL);
+	memset(cmd, 0, sizeof(*cmd));
 
 	cmd->data[0]  = devid;
 	cmd->data[0] |= ((pasid >> 8) & 0xff) << 16;
 	cmd->data[0] |= (qdep  & 0xff) << 24;
 	cmd->data[1]  = devid;
 	cmd->data[1] |= (pasid & 0xff) << 16;
-	cmd->data[2]  = lower_32_bits(address);
+	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
-	cmd->data[3]  = upper_32_bits(address);
-	if (size)
-		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
+	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
 }
 
@@ -2656,7 +2652,7 @@ const struct iommu_ops amd_iommu_ops = {
 };
 
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
-			 u64 address, bool size)
+			 u64 address, size_t size)
 {
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
@@ -2720,7 +2716,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 				  u64 address)
 {
-	return __flush_pasid(domain, pasid, address, false);
+	return __flush_pasid(domain, pasid, address, PAGE_SIZE);
 }
 
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
@@ -2739,8 +2735,7 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	return __flush_pasid(domain, pasid, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-			     true);
+	return __flush_pasid(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
-- 
2.31.1

