Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29915C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JQKiI5k0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl1MVO8JQj2QLKHRYEHruhOcdrY9AoMzitTWL936zWH0ai7AGzYRP4f5CRHW2DUBW8O0OfZfSDJgYFvmfsFED4x0wj8oZQdmyaYjLd6VAvYdQt+DoBy8ZfUReshJzFHCYN9ZIuGBr34J4GjhT1Wye3OvG8vNX6yf7LnVxQnXHhhNCDzF6/dT/uofOmHHUm0pocvZi8Txr6bgH9zt0Trfpt7Q0TuiP+Xua5gkZyY0igi9Ce0NxTMKEVtREyDnW/l8yhUlFoqGsr3RGU6RPjSwxV336z0T9m/Gw7cJZ1YbKRlXRWWwNruAdB76lSCLJiYcOD4RVDItrCS0T+T4LT8sQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXJf1ep3SeeClEvKnB0RMBmPjqT8Mt4RUqEqWdjJX08=;
 b=NvFVnB8yl0sloDslVD9V4BRNmNEdeOrrigCkerLLu7u9WwQI1sGbZC0oc8qA5/ISxsZXzAMiBXrjfskJ3mUGy3KBHWCX+rYLTO5TWNUaiH7dfU/rY78ti16TLiO6Bo6NEHRzFCAX4PqYTZdCK72AXHCfLQgRStc8Z3RBSgLfXXwBI6oNMwgk5Fl6Vj2+yVLe7Yf2XVWMbYtoSie2vKtjXQbVICQL+uF0cQc0JyrUuSNsIrJPTzdpP0srWbdJVq6QEHic6rSix5l2ne4F9DNKLHOxvYxzRGSCO13rEskxsf0umTfZUQz+qKsZxiiNNenHfByAoN4gs7ZXC+VQSMnRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXJf1ep3SeeClEvKnB0RMBmPjqT8Mt4RUqEqWdjJX08=;
 b=JQKiI5k0zB2vernwVv7RXIhTevwA5Y5utaODBH3ig81+sOjPur7ihdABIQXpArveHzxxXx+3qzCkxcrNNQRHFYV3DdJgPdTukKRccV3XuJoT1ga1XgaAPS0hL0S/oQblu2NPAgOriUimTHZfPLn5SoBW9lRMGWRuNHkKb5QNvK4=
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 10:18:32 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::b4) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Fri, 6 Oct 2023 10:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:18:32 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:18:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: [PATCH v1 06/13] iommu/amd: Refactor device iotlb invalidation code
Date: Fri, 6 Oct 2023 10:16:17 +0000
Message-ID: <20231006101624.5912-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 8192cf25-f3d3-45df-96ff-08dbc65597f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eB12iFnGg6oDjhn7ufpXSeqU3HFu6XVVd7nvl/aikmx5iHGDSF08EjOIAZTZjxVOAoe69n48GxcmiVqjixRr7vTxpkBHuA4fO1UBwAybgsZcEYgTRDFQg5K+pfkWms430zhzg1rBRYK4q1ZyN33GWHuFFtBEEczNpCCQyzQ1jlZ/33tdXIkT1fjar+EAWPitNhm8ehTf/ZHTkFWuvl2/961I+d6U77+vXjRvgmte54So1rxhnS5vQqPc1tEJe67GH4uikAmczxPG74UAOrp+E+qnX9wqLy55QCUa8DU8bqY7AdwtEHlgL+4C8JlVQouV+/kTUpeQjL0LEeWygH7ObtDviXPfDB+bU/7oW8KPwvmFIQnNVhBtOTd8s8j219W0ms1E+RA/B7gwAuOur2y4Ai293T6kkllFREMfExYmLohmgzjdnQiwZ9JSn9VlMlr0YpBPMEvmf8ocz/zD+LjPrPRzOatoZaW1wZlVEWuzrE90QcUuZnkRGUtFbskTb9UWJl1BfK7tyROD7n36NaU/Tbbn1XxtlC5TinKUEw71CEEZnGEUz3eC2LzlKxtPHysUWfn89P4KHnkSJTXtmb3DmIDDQb/7MRtdR9kReSUU7/C1plWLd4vhXyQtD2JNJ0m44G/J9U03jsDH71xNqJEIYpcGGjjzt3AKWXJzuxuRVp4/Fvr2/+J5pxXdmEn7F8DZ+ktPKg8TlaNzT7nFzz2trBZ+GPVx7hAo+c3PMKCh/WlYGYWw7EC+bG2JjzThTqPZ8SE+T9yz8r2pMwD32AAz/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(426003)(2616005)(83380400001)(336012)(16526019)(1076003)(26005)(2906002)(316002)(41300700001)(54906003)(110136005)(70586007)(70206006)(44832011)(5660300002)(8676002)(8936002)(4326008)(36756003)(36860700001)(47076005)(86362001)(356005)(82740400003)(81166007)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:18:32.5600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8192cf25-f3d3-45df-96ff-08dbc65597f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221

build_inv_iotlb_pages() and build_inv_iotlb_pasid() pretty much duplicates
the code. Enhance build_inv_iotlb_pages() to invalidate guest IOTLB as
well. And remove build_inv_iotlb_pasid() function.

Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index aa1bd45f18b9..2e7360fbc3c4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1142,34 +1142,24 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 }
 
 static void build_inv_iotlb_pages(struct iommu_cmd *cmd, u16 devid, int qdep,
-				  u64 address, size_t size)
+				  u64 address, size_t size,
+				  ioasid_t pasid, bool gn)
 {
 	u64 inv_address = build_inv_address(address, size);
 
 	memset(cmd, 0, sizeof(*cmd));
+
 	cmd->data[0]  = devid;
 	cmd->data[0] |= (qdep & 0xff) << 24;
 	cmd->data[1]  = devid;
 	cmd->data[2]  = lower_32_bits(inv_address);
 	cmd->data[3]  = upper_32_bits(inv_address);
-	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
-}
-
-static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
-				  int qdep, u64 address, size_t size)
-{
-	u64 inv_address = build_inv_address(address, size);
-
-	memset(cmd, 0, sizeof(*cmd));
+	if (gn) {
+		cmd->data[0] |= ((pasid >> 8) & 0xff) << 16;
+		cmd->data[1] |= (pasid & 0xff) << 16;
+		cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
+	}
 
-	cmd->data[0]  = devid;
-	cmd->data[0] |= ((pasid >> 8) & 0xff) << 16;
-	cmd->data[0] |= (qdep  & 0xff) << 24;
-	cmd->data[1]  = devid;
-	cmd->data[1] |= (pasid & 0xff) << 16;
-	cmd->data[2]  = lower_32_bits(inv_address);
-	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
-	cmd->data[3]  = upper_32_bits(inv_address);
 	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
 }
 
@@ -1402,7 +1392,8 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	if (!iommu)
 		return -EINVAL;
 
-	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
+	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
+			      size, IOMMU_NO_PASID, false);
 
 	return iommu_queue_command(iommu, &cmd);
 }
@@ -2547,8 +2538,8 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 		iommu = rlookup_amd_iommu(dev_data->dev);
 		if (!iommu)
 			continue;
-		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
-				      qdep, address, size);
+		build_inv_iotlb_pages(&cmd, dev_data->devid, qdep,
+				      address, size, pasid, true);
 
 		ret = iommu_queue_command(iommu, &cmd);
 		if (ret != 0)
-- 
2.31.1

