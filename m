Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC460174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMPExb3MMA89fewIQpWwCF++oeh911WWOZ9rSlY2OM456tcEh3EX8m+JzH7adFgR9I2CGII4Fj9SoJE6zSWjlU1gc9JKz7Oj3597gn5i68yZRiQrmoqUir6vEqbLxqwg1pystvNXQ0uMb4PqwiX8xZuDM2Cp0Lr1a5rB4MrwR9k5Dn5fasF2JFOZLFqMv5rv6IHAp1F/qyqzlHd/+yqFx3Oys/gxD+h3U7Y8Q0RyknWO9K0OSNpJkyteLcOADsvV9JjAEAOh6WRbvtH9cY6NLCMVLD3oTpkUPNFnr02Cj7ynyOxR7OWCJ8MVmUCqHWnsHFciLuUibIi8xYitQOmvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+t+p1XAOGHO7iGm3qp/WyB0o3ueEofw/Hy0BHRdfcM=;
 b=PNCO+SxnPIO+vp7RVaz+btHSgai/T5spzZoHn/KmU7ANnJh605E9vdoo89CL1x651v16SHW6a1XL4CbiY7X2a6nTJv+90EfULjqrN/n9lUIYRYVE7kdxn4HmL/2XLgtO/dwgE4dzVm7IXl+PcyRJ4hnuSXtS+im26oJAdY+NkqxDm+dn/3wrWXx4uhWF2l9l/yaiF6nS1RVYq3AOIrMpd83H7Wo+5AP3vqewQ+x8f9x5nYz8YloNdhpabAXwawDurHvXArH5x0vXz2z4+hnEGwGmSu2eCo5sg22A0B42jdISMlvGsnAbDziYU31pxZZoeWKDyaQ3WaSnhoLxQIjnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+t+p1XAOGHO7iGm3qp/WyB0o3ueEofw/Hy0BHRdfcM=;
 b=aRMmhux61v/Vp8K4xDa6ORxGC36deSyLLZPg+3VeZE3xjGujBGKfvmlsUAJrFXgvZ7E5FZCKeBh1P2h6iuYANxp1Xc9zsdH9zPOr4kXvHRp9f/Bp+34GdYk0YhW0lIuFpmBndtJwDsC0Lc/DP6bTdTI9uN4PrK6t6hn9Vxf/Yyg=
Received: from SA0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:806:130::34)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:41:57 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::79) by SA0PR13CA0029.outlook.office365.com
 (2603:10b6:806:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:41:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:41:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 04/10] iommu/amd: Introduce per-device GCR3 table
Date: Wed, 16 Aug 2023 17:40:25 +0000
Message-ID: <20230816174031.634453-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MN2PR12MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: e07c5000-d09e-49b1-e4ac-08db9e80164b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EyVKrSPvG5y2jEHUIh2Pkz0G90DaZUX+HLQ1Oo5uBznkF4XsmoMHTls12Ce/+x/yHVHwTYqJ50v83oD4jJgIE1y9RccA0pj76I+b9ezcGGxifbw9iPEQ9XJ8P20r6jjg/GqXy7d31GvwWFAuFRYPmMb1mi8Eiy6xqHp0QB0muuQv4deKvR8m3/B/eyvmI3/zRpgaljqmOdwWXo6QaRV2J6CrQgZznXQwTvtGYrqae/NW7Hj3xNvhBGQ1IXrXWSX+YRtt3GLNGkKrFCEi1ZgCjRv6gxlnsP6GcU4uytG9+RBpBlJFTKFz1EYC9wJRiE8fg5Fwl50icUplbhenu97oYT1i0TfLHL/tehhZQsFbuDJw/wYABMVFPobl0tVJi8UwbT6I7uNIIDEzcfBt+661GSixewtH3cbwkh3zPnfvuLJ722WAWOQ3GXbfyynG8zMdZCbyJqzob4thXC8eLdp7i4JxVSe9y4mXlgdrTRDz4PIxs0/rIIYSryKDNg/xdg8U9ASqSvSiqPoedgy7ggNISfQQBXbPh+UfVGw91abiq8Bc/2wED7lcz61N23ZFumAodlEtQXt17X95HrOKtLo9ddmV7v9o16zQ0KB7RVZi4ar2TowNcPXrd4x08cQ274sriZ8zMASwvpkqyQLriMnZa+9YMGQaJzztvDYZyTYFJFsWsbB1wMGIvjUq9sHn1QUD6FRxW9P8l70Gi2VglBHYlSM89/MEdMg/DzUUyqSMlc/KIXqONi9ZM+yuByamJcv1pF1GjRkaMmD7AVmUmwY9Jg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:41:56.9507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07c5000-d09e-49b1-e4ac-08db9e80164b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
register value, which is an address to the root of guest IO page table.
The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
driver currently managing the table on a per-domain basis.

PASID is a device feature. When SVA is enabled it will bind PASID to
device, not domain. Hence it makes sense to have per device GCR3 table.

Introduce struct iommu_dev_data.gcr3_tbl_info to keep track of GCR3 table
configuration. This will eventually replaces gcr3 related variables in
protection_domain structure.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index eb32df5371c4..1c4672ed90f4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -530,6 +530,13 @@ struct amd_irte_ops;
 #define io_pgtable_cfg_to_data(x) \
 	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
 
+struct gcr3_tbl_info {
+	u64	*gcr3_tbl;	/* Guest CR3 table */
+	int	glx;		/* Number of levels for GCR3 table */
+	int	pasid_cnt;	/* Track attached PASIDs */
+	bool	giov;		/* GIOV bit support */
+};
+
 struct amd_io_pgtable {
 	struct io_pgtable_cfg	pgtbl_cfg;
 	struct io_pgtable	iop;
@@ -810,6 +817,7 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
+	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
-- 
2.31.1

