Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73499DDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpZdtX/gvM9y+6yW7s5HjwJJ7vxlXTv7P3/JZZBGX13LfNTRhxYE6NHftW3vo/HjvJSlG2ar0Ac0xd9hwlWm3Y0FZO54cmDAm8mKaZRPybyI++4ygVul8H10wZ4Z5tYEAFcss6lqGkoAoPe79vZAULCAhgyMMf1fT9gBa8wIocBkPiEZ7BL6Pv2ILMfUos37XVoK2b9yI5LXtH8B6JBLa6v1ZG2l1x12Jib8RXDEa1TtJvxoNKtb3J+YPTms0gVps0Y37MDiZVPqdNND+oe3Gvvi5HvyIw3p3ZVZFQmOi4H2f+0ZLGECs/B3kpKdxwXihCgq+1XJCkTbUCHgN9UBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCMHb2rK6XYBmEsPyYlRQF9DslqmmG+1gyWJ+bQ/bXk=;
 b=fm7wUVReMD2stqxrhL1IfLOExCkQL0aUgzhH44/r6Vd0BREPjQ3Ymjvyzb2yde1tv6EFI+2yGIFJfADoAhRvaB3P8kH/m6svq+mXlEBvSpkMwkGeGapY4UD57RwQxAKMfeEL0EtqeEibqTtAoj2HmXbU4DARG/Fiiux30zW8xs78Jj1ci3q3yoMwIztIG4tB7qxYXyxC8i6IdjTrgl6kzoGdJiffAnMMucR7YcDXEhkB4TklYeDIs+UsJkr9w9UcxmOiv9f2EnaPImLM6fbneeU/5tQ858NfVnwlUP7fYG35eNQOUg4cNquERLxOSTHbmGBkZfegljbAUVwQwHb/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCMHb2rK6XYBmEsPyYlRQF9DslqmmG+1gyWJ+bQ/bXk=;
 b=HgC/X/vZzDgys1H+P9SzVXG50ftRsug0cVvauFg62D+SzRo7eTgdmK+kOMpffsmF8qMiARSwk2l2z6XQn3ZjnWKBhDIxLZGZk/dU6i4x1G5+kKMMdlJnUU9ytb7GCQy2tQ3rhicnsnQrr9Iemy9Zy8QQItSbztzaba/XBQ6CMsM=
Received: from SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::14)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:05:21 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::69) by SA1P222CA0148.outlook.office365.com
 (2603:10b6:806:3c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 10:05:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:05:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 03/11] iommu/amd: Introduce per-device GCR3 table
Date: Tue, 8 Aug 2023 10:02:24 +0000
Message-ID: <20230808100232.5977-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c8543f-5690-4c66-1b61-08db97f6fa03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AgRMztih5vrDTGxurfRLel98j+9V1038i/pIwlBdk2GbTxtncBNgqYauoD9jyYnz5OASWxFNRm5x8qwMSRm6GJGYfgTJKOLlp8u+TFYOsvBJHy8Cj5QuYBX76LNJcIA+0C1uM5E4KH2jJ44Z1SujYj9F4oqYWFdREE9dLs7tWBbi1XIA953ZN61WjacADWkbkP71u7qDl3HO6EhIylFfCaigFSIWbEJ8r5gBZ9eL6EGDFW246GY7yzojNkrq0xcw7YPN1RcDjgaG4PtfHnvjGyKhuBeL7zKDQ1f7Ak3OLydllB/t1Nhg4SCh99SbTvwE9AJZkSwfOZrNEMbkcbRQeuJjPAViRc+WKEiXzUKCjmtOM9agK65bgD4ovnL3YRTF7DRa8U4wgI23TVKTTf/E7Gk8mKZ6TZCDdtYsP6c5BQ/fkXa7YkhIW1GRah6UUoHicTD0RFXS8FrSv/hTnQwVC1zgl8+nlbQxbAKOPHVlsBZFRdk27bCXtCuqvzNAWl1FfvP4ivApJlg+/MoOTtqB3mClE7YMWQPIJ2ivyWuejIx1Rd5S3bYFmlHNq2W0L0rodFQeGIecxMZmC3/adQdik+OwidZGKdHQsd4PVomAP1vM7unXMb4LinTyDaPsOWHYdR4RzCImCURqzEYZx4wixvJkyYCRQZZvOxDrKsrX9UYJBx9erMZXzl/3HzRvtmovPp6YAgOrzED0706JklRfrBH3SRznbsI3l6TwmTUFDWhPDtYnSpWuQ+NhdACqUXRt+uxuDb09kGcDvlt/RO7chA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400008)(186006)(451199021)(1800799003)(46966006)(36840700001)(40470700004)(40480700001)(2906002)(6666004)(7696005)(86362001)(316002)(36756003)(4326008)(110136005)(478600001)(54906003)(81166007)(2616005)(36860700001)(47076005)(426003)(26005)(336012)(82740400003)(356005)(40460700003)(44832011)(5660300002)(70586007)(16526019)(8676002)(70206006)(8936002)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:05:21.4688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c8543f-5690-4c66-1b61-08db97f6fa03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
register value, which is an address to the root of guest IO page table.
The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
driver currently managing the table on a per-domain basis.

PASID is a device feature. When SVA is enabled it will bind PASID to
device, not domain. Hence it makes sense to have per device GCR3 table.

Note that when system is booted with amd_iommu=pgtbl_v2, it will use
PASID 0 for DMA translation. In this case all devices in the domain will
continue to share same GCR3 table.

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
index 5e89032b3dee..a275a4bbf8d0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -547,6 +547,13 @@ struct amd_irte_ops;
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
@@ -825,6 +832,7 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
+	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
-- 
2.31.1

