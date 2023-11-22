Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEF38DD6
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpaUkOCj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChzN67F7dP4X03307yo5NXP/YsygG+YPfRerGDrBAa8zt7BNVYygf6SIRAkGIwh8Iy1da8zoZtmK8KBwmyOlbBV3mF84q6lVATyODoNhXdzgHIfkdmtsqOn39h8j3FxQ4VM4Z2jfVn2EGa9BGbQnlasCiXsJ+41iRYse9a9LOPEqX2bmeXeE91P09ZIh7wZaGsPFP19AVXjnqf7i0C3CIYcsTJhIw/Xp2mBBBdZzsvewpoA6TGHQMzW4jY37yl1/re3UhNBiAcSIsh5+aJM0kZmXzWbHcAywvozHdoX2z7BGQGVUzB6FI9Y5WzWIXyWwdObhZlcn5cZLSp4ilcHrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6hEEkFXQ7nhxLaFSbKBb2qa3VwnuI0mw5CfVg9aNxs=;
 b=IU9ih4at0XbzevG0UZ6q1fJFWPvV1HAnvES+NC+OfLiAn4tGHNiY386Dc8VeZ5mG98ljaue0TRX7ve+IIdPgFSSZGcVU63KFB+lSU8ATMYi61H1ehDD86yNL4KOgqV5NdYTLzkHZcNxd/MI3ARNXW7VOB9cGshfieMtKdslfPYAGfDhwSDCrNakv6glH/onrpyPOpTeApgcgSrqX2ckzgsK9OzUiXDgMbWFtyLMsw3FnT2bVlgadASukptoHgjcO3txr3engk3KiUlvAQ3jHKYTNY99Q4TwLE4zSwiFd/2cMGutQlXEMYu8NxBfGmrB/nri0YHDFDwMQpGj/QAKDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6hEEkFXQ7nhxLaFSbKBb2qa3VwnuI0mw5CfVg9aNxs=;
 b=kpaUkOCjQoxCtsiSAVSxuaOvSuW6jWR5RARShTRaWXGca0m2Cj2reEg6BXXFIOcTqv65Q/5BZVbbQ5zF18pclcwGfLZSDvO7FNDJ04tFw8xxNWbxGj/10+CmjpHm5eq3k/XsyaxTOFCLfdTtx16jpaP80mHXhwOt97GKshFlDUw=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 09:04:20 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d2) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.10 via Frontend
 Transport; Wed, 22 Nov 2023 09:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 09:04:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 03:04:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Kishon Vijay Abraham I <kvijayab@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v2 6/9] iommu/amd: Refactor device iotlb invalidation code
Date: Wed, 22 Nov 2023 09:02:12 +0000
Message-ID: <20231122090215.6191-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: 88822a66-c28a-40af-8557-08dbeb3a03a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hjoUILpvcAttaGIgQ+tt3vLZgjXe78vy6WA6p+GgDpk/eOwYWXFCtuIwGz/Kc98rOiLqbeo+hpklLMqThqJxngGQylapSYfeLMeZ8QRplgc2bmcfrBZfQGFV0QGdGJ4c3ebWjyPS2EP777gwRNevq56/7uXCNZ8pXOiTcbEP89bvY1fzuWUFD+8p5XBEY6qPYp3eM0GC0+kGIBzlGCO/YfqmiNffzg3PFFybIHbVgKfy8365g7RoFdPsy+D/g2FZpP6XwOjI0hHLuJm5TeMGK9XyhQj1ho4I0yCa+mOC0GnggQtWGTG8PpQZXIrQEJYsQ2N3MpICjvlQECtRfxqz3eEAnXiSgeSpzQqsH84VgetZIU4h+ytvP/j1aqFZxdFw8WY3vswIooR9bJ03K33Iuxl1YvVa0f7ivhzgN/X5PqY4VLa5Bsqfl1iNp/cIdj60VH0WEn92AVWXXXsG93POpRfGO1oaE0YN72JYokRNCMkuwLmErBflfgP0O2df8S0w1qx2JGZ1jX+qPDrqAVqHbMBkGud/1OcmsLv7Wa+CgfjvoiMdfnNKwrqZcib/KDEiTU80+QpLUT27EdtI4SEkCQQkpXhSz3Rxl5MaOXcwU3VZSoeSWSvQpf4SebcefrhanqkVttX1qXUej1srYI2gufdJAab/hPihtH9OaJ85tpOV+bz85qFBDNDcZ+xmn27C0UHHcgKsrEUCcoDjRZ5uIUo+Q0tkVJvGWntN/i8MhDIuChKh5yJqww5F2Zt9f2McGhMycKW1q2kRbyEDpycIkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(6666004)(86362001)(7696005)(478600001)(2616005)(16526019)(26005)(1076003)(8936002)(316002)(54906003)(4326008)(8676002)(36756003)(70586007)(110136005)(70206006)(47076005)(36860700001)(426003)(336012)(82740400003)(81166007)(83380400001)(5660300002)(356005)(44832011)(41300700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:04:20.3914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88822a66-c28a-40af-8557-08dbeb3a03a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938

build_inv_iotlb_pages() and build_inv_iotlb_pasid() pretty much duplicates
the code. Enhance build_inv_iotlb_pages() to invalidate guest IOTLB as
well. And remove build_inv_iotlb_pasid() function.

Suggested-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 913875dc8730..11bc222be528 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1144,34 +1144,24 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
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
 
@@ -1404,7 +1394,8 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	if (!iommu)
 		return -EINVAL;
 
-	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
+	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
+			      size, IOMMU_NO_PASID, false);
 
 	return iommu_queue_command(iommu, &cmd);
 }
@@ -2687,8 +2678,8 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
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

