Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE915C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0r6h6i7Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1L2YCdnsN3rBpuwT4gkzfpTEpIVefS+xPz2FFW16SlY43HpSqle10qwKaZxXUL8sGLj6orcR0LEuQ9yWeJx/JVqAuQI6zzAKPm9p8OEMT5fAjOjiZ/Zt47qO7I1n9R4HhNggM4FTHlRp/W3gyyyNwVLkD7+66e+hyw/ZlI+k263hMyQuPsSEwTnDAouPtNREXA/ImGAzoHeBGYM/deF3ZFC2tD7XWzewuVNTAejzGtWdytB2KxwuOFWLbaDOtsQ2av5AyexrcKwjqcgq5Iz5/3tu1drj2CykgXE2MCr70xSk4Y2av682irEPt+E7Jc94PbA3ExzMGd4pPlmMMmlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gq2AMHkZ0Q7PWstIEOxqTJzzK6N13iME0sR/61CJcI=;
 b=ZsqWZGyDvTsGpBOgwG/QF+SACyJAK2Z0MW85PrEoHKg6GQ2ft9BPZPB04YWDPmteQJVjjFgAwSu3Iq4CPHzwzALrNeLwO6Wd3r1i/1wp2FI28qI4NzEMe3BLSqN+Jh48Dv0k8yXroCqj5GDdsSMnt+Ui7mdN7U9AwUCbRSYwl6vDfcuIeMa+9A1Sqtiab7Mbqc0oDRaWC/F9d/fNeW7lKrkh4D4jTmfE7PcpovqQNfBsxwHC33wkQmSx9cJy97qdHlxrpPhlGU8od1OVQ8lrjPigHYIvlaFMDTpXoauvXoTGIwD7Uy0ozf8J5MbHO2qENk6lnxpcJS6VF1rKLyLnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gq2AMHkZ0Q7PWstIEOxqTJzzK6N13iME0sR/61CJcI=;
 b=0r6h6i7QHg5d6eQiodx5CWWTfuT6MMtYd0WWG/iKU8Z3YWXat1/CSCpM45+qHsOBr0vYUbycTLblyMrnUOMGvFDi5zwcfVAEoYk9JOMMBE2583FlhiLNzTxNZ83fLxmu3igq9FTbDlo+lWQb7OEHpJkDlcKOlqQp7CcJyxVjbt0=
Received: from MW4PR04CA0184.namprd04.prod.outlook.com (2603:10b6:303:86::9)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 10:18:02 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::1c) by MW4PR04CA0184.outlook.office365.com
 (2603:10b6:303:86::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 10:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:18:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:17:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 04/13] iommu/amd: Add support to invalidate multiple guest pages
Date: Fri, 6 Oct 2023 10:16:15 +0000
Message-ID: <20231006101624.5912-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dfaf67-e4fe-45ce-8b13-08dbc65585b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bB//yMUPqfeIo6LWpN0EWKbicKV9XyoTGx74jGKDD2EsReLj2VRO403GjEYgM456CB4SBvqAVq2lIMUYyJT9H+i2N1YepUwx8z5MOCh7Vz4+GUGXoxM6LqIRQukv+6zbGsZDj2cgtt2Zby0ONSXggn0N0BRAH3jRRGn8BIotJF0C9QRhmVEdyY4DBMn0RtrbSQGu8tlwP2+95pdPDS93Xw4jPBEay0Ss3wKPExMEfROj3nFhQKmGf+uLX1dg327NVeUemZbw2xpM95rK/3Xwn3+rBZDjHU4D4ZjISK5U3wgscW2VRpf/2lb1OPLSgik8g4RdOryVdMg4DW9JsDaCMHU+7sMSw0jg0ZkLlMw6UhiBwfdkfI5s4Kv/FjNZLo5ewg3VQZkh1ZOQoDLiOA1GRqTWSCnhlwUjGwnVTODb9xeVwRBbb+kZb9Vjiq4Nl6XOHEHnPBB22eJzIZc9mf7m7olSoseVLm4R72YQa52pLmbeal/adLnoIW+lCFazkSQVEx1auW80bKkkBTzaNTzByvsY9ZiKxgdgji6HVJ7BREMAsqaNra+HCjx8pgXXZMl4TiHCzwMjakzAMfJ4YqZ+meJPFrpusikD54LfdOinuUSlQkYR992VX2rzpoCx7tCLc7O3iAhP6y/p1qlLWLfd5fTav4Xv3eKY2GmZHQ2HFN22HzxFA3mhb53/BCXtHEejm+JwcC1PwKzqD9Hvsz7BIJ8hGs6DaW9sYtWCb7r09uFAJu/dgqBSgqV9qvgioUAce1MrJuukBoVYp6XWufEg4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(6666004)(478600001)(7696005)(82740400003)(36860700001)(86362001)(356005)(81166007)(2906002)(47076005)(26005)(16526019)(426003)(336012)(83380400001)(2616005)(1076003)(4326008)(54906003)(70586007)(36756003)(8676002)(70206006)(44832011)(5660300002)(316002)(8936002)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:18:01.9412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dfaf67-e4fe-45ce-8b13-08dbc65585b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015

Current interface supports invalidating single page or entire guest
translation information for a single process address space.

IOMMU CMD_INV_IOMMU_PAGES and CMD_INV_IOTLB_PAGES commands supports
invalidating range of pages. Add support to invalidate multiple pages.

This is preparatory patch before consolidating host and guest
invalidation code into single function. Following patches will
consolidation tlb invalidation code.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 94c230bd3fba..ee81ce65d25e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1150,40 +1150,36 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
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
 
@@ -2516,7 +2512,7 @@ const struct iommu_ops amd_iommu_ops = {
 };
 
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
-			 u64 address, bool size)
+			 u64 address, size_t size)
 {
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
@@ -2580,7 +2576,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 				  u64 address)
 {
-	return __flush_pasid(domain, pasid, address, false);
+	return __flush_pasid(domain, pasid, address, PAGE_SIZE);
 }
 
 int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
@@ -2599,8 +2595,7 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	return __flush_pasid(domain, pasid, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-			     true);
+	return __flush_pasid(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
 int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
-- 
2.31.1

