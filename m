Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F443B29C
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8ffAc09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z07pMTZ+8ZRAo+TWbdqSckSKABVj6akvcQvooiB09CBuRZ1H1+OoVWqFWqNMtdp0lybj3iInSWfQBK/qED1gjlWIfGlsUca58LlcUAwRRcjWlql+a93+i468I4AjXv+zeL+723odrQ+1gzMkgIA/yiF1/FZ8h6RtZTO6kHl6yJvlGJoy4N5sRG81GIR8G7nB4YBxVS/JakXMq7rTlM+Q0/oL4TbSgWPFIndWyUrI6wR0tie5zOVsbPxXPyEe6Tlf6MK/rBjTpqAkwUehUWpSSIWmxjCkiP53n4prTw1hvkiDtScloRb5MWPATE437JhWiW92jZWw7sZqjy42PcpfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOEjMR55kSv2eHM7QH59f6XRpmhuFZ0O+wfHUsOiXno=;
 b=HhJILZuO5j/rWXf2ISIDQYjX1r/7Ec6nlEupL6SRTw4tDO+h/YRMz+trYMllhTlS/3enkEWlZDnMveLyhvwisDsf+dRdmcnvH/KZ6bQouZqXIHE7+oz4NYWxDPAv8VrmDqrLXNdzk3GAaqw4UjH4OxJSCv5e5G5lKkyp51N0zGN25jU72XEkRU1tocsJLqmqKf3jim1yU7YDS8zFcfzpvFfOsKJEgVbI3K0Qyyfa5N/dHERLcH2n9Wn83cENzBHEdN2Lb9O3EjVGNv2f7xG3PKBhp0Esvb8qFTuL/PaQNz29jgtwurv+O1Ec68MWxpxtCnqCRkWFjoUoebrBbRyAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOEjMR55kSv2eHM7QH59f6XRpmhuFZ0O+wfHUsOiXno=;
 b=e8ffAc09SjUaAQlP6YBnkrzsnlUmNSza5y6iex2dTWz249uorWIGLkrSOmRcN8RlRH7xjXssAOwa56gfKDaM08bhk7+SpEpwX/gRmhgrigG/fnN6h08ymL2XZgiJOLRNQWJsz14hfN8aslRoMzLorx4Bz9uFjUw9b3Lloj06qOE=
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 09:04:02 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::80) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 09:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:04:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:03:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Kishon Vijay Abraham I <kvijayab@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v2 5/9] iommu/amd: Refactor IOMMU tlb invalidation code
Date: Wed, 22 Nov 2023 09:02:11 +0000
Message-ID: <20231122090215.6191-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de7e783-e009-4ab4-83f3-08dbeb39f8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TxXZQDn4owUncgCLLN6WDZujWEtqH0K1pRRR8b3RmnNA9d/1oU076H8L7S1A/kjY717K1Q0lZ40TFv4a9/BRvJXmkCM7VpkO629k4Tdl6ZX7oztrD5qJAujWgbx5lZsAeYq1GU6EqepvCliUZhFblB5DP9IDXeka4q1gj1HAykuxlIzA2kJlAx7WJiedJIQ5Tk2EyVcGxVk91tvmhOm3Svl9f6DOQZnMeuAi+xte/d3aGCL1B++QXw8P264F/64pibAI6cf+ODzZ9p6vaTAzo54dSd2bqLdVLh+deoeaUuDHq9GvJG5DQy6HN1nkLvSXGXMbmAdiSlnByCDSeSb80G3ctqFyKMOgaRvIaEItRig7pCm1FX5N3G2SWpF70OkpHmjSsCAqBxTdDZ9S1/iEOf1s8qZQkEUk/fC3Bie2O0bZbwJIALN7mRBPOzrqp2jzdnX54ku5thyNyRbLmgWp9DlxGevVMjuORK80wXkquG+QAzVkTwrsRyph+qE9rZpPo3PVuolXZS8SPdNrI+5qDDSvKhFfCa9cow2Jnn6DL+wcR+AbyCvf4jLGw9XQM7BwBBesJO/DQUAcGMMaqH1EgD7StllPDgZR+INigtAq6mMDobUulTs+oKXB7RETzpsWiAsJ6JLsT9SeBfj/cIVOluwO23M9Gj5F/M304dXSJPriqTxzX04iO7OHPeLn282C0GzwIQi9V/EvHhPy4d/ObjkZ5otslk08rG3yNQ+z2/Pf7C0qWm7C/W9Ak0nOBDtngm2EeJrhWQn8hgXwXdronQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(5660300002)(86362001)(70586007)(2906002)(44832011)(8676002)(4326008)(8936002)(316002)(54906003)(36756003)(110136005)(41300700001)(40460700003)(26005)(426003)(336012)(16526019)(40480700001)(82740400003)(6666004)(1076003)(2616005)(83380400001)(70206006)(7696005)(36860700001)(356005)(47076005)(81166007)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:04:02.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de7e783-e009-4ab4-83f3-08dbeb39f8aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

build_inv_iommu_pages() and build_inv_iommu_pasid() pretty much
duplicates the code. Hence enhance build_inv_iommu_pages() to
invalidate guest pages as well. And remove build_inv_iommu_pasid().

Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 68dc19784f4f..913875dc8730 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1124,17 +1124,23 @@ static inline u64 build_inv_address(u64 address, size_t size)
 }
 
 static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
-				  size_t size, u16 domid)
+				  size_t size, u16 domid,
+				  ioasid_t pasid, bool gn)
 {
 	u64 inv_address = build_inv_address(address, size);
 
 	memset(cmd, 0, sizeof(*cmd));
+
 	cmd->data[1] |= domid;
 	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[3]  = upper_32_bits(inv_address);
-	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 	/* PDE bit - we want to flush everything, not only the PTEs */
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
+	if (gn) {
+		cmd->data[0] |= pasid;
+		cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
+	}
+	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 }
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
@@ -1151,22 +1157,6 @@ static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
 }
 
-static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 pasid,
-				  u64 address, size_t size)
-{
-	u64 inv_address = build_inv_address(address, size);
-
-	memset(cmd, 0, sizeof(*cmd));
-
-	cmd->data[0]  = pasid;
-	cmd->data[1]  = domid;
-	cmd->data[2]  = lower_32_bits(inv_address);
-	cmd->data[3]  = upper_32_bits(inv_address);
-	cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
-	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
-	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
-}
-
 static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 				  int qdep, u64 address, size_t size)
 {
@@ -1337,7 +1327,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
-				      dom_id);
+				      dom_id, IOMMU_NO_PASID, false);
 		iommu_queue_command(iommu, &cmd);
 	}
 
@@ -1348,7 +1338,8 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 {
 	struct iommu_cmd cmd;
 
-	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, dom_id);
+	build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
+			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
 	iommu_completion_wait(iommu);
@@ -1477,7 +1468,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 	struct iommu_cmd cmd;
 	int ret = 0, i;
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id);
+	build_inv_iommu_pages(&cmd, address, size, domain->id,
+			      IOMMU_NO_PASID, false);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
 		if (!domain->dev_iommu[i])
@@ -2661,7 +2653,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	if (!(domain->flags & PD_IOMMUV2_MASK))
 		return -EINVAL;
 
-	build_inv_iommu_pasid(&cmd, domain->id, pasid, address, size);
+	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, true);
 
 	/*
 	 * IOMMU TLB needs to be flushed before Device TLB to
-- 
2.31.1

