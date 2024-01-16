Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAA1B81D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sD4lMiye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHGFVTBolbWDBxI/mb1Prsk0P60lhHpPBxNXqsmBX61PdDAeha3IAU4rDexU3d5iL743M8QcwV/NDMxgBwlPYOjMx3bsHKtAnJu/SjodzXJahO4q3Eq+0NaOyDGbWMzmN2M5IfrM4SoH7r9eu1MgQhj4MO1/LdbHtaagh9FN83FMf1zuqZMnx+gpOfnebs8yqlrlxGY3Fv84uPkZ0W/0y8gZcafB7LIeNh0semmct8bZfanKEbF82puJQrPlbi6/YXY3bw+ePhSQ9oeoy2K2D7EfoYBNTRcb7AhWkTVogND8ZUrQ7TA7uVlAEsx+VU29sMFC6jjLIJlNpmn52C0jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNmkjcJsKLcC17tU0HRvHTWjb3/2xe70ZqbFxjbe+sg=;
 b=SvR8KPYltFFoPVhqjQuZec0DK+0dYRNDXIcKgyb106/+VctdWDoKZ9cYEnRWuBl6AjP2VjLCAT8LPqj0RqQ8BVNiktCh4/gYWCBEFkxDIXhvmvLK/HLwamkJRbVXY5QhGNPivr6+Z/rDEamV4qkTUPk8tMpMjV2pGCmKWBqtz+P3HJLpQ8YK8GHGNhNbQZpkOKgWVvuHloh48cvCqYuUKUGW2k6JmjCx2UJ0Zb9kIn/Pvlk9NCT4o3X/3G7MNUrQwI8GVdWOKPdQGpa/ZqbEf91TR5AnED6Gf/C4gL1wjPKdRdQXGDAQ1ya3c4IfDDm5oE2ZhJyNEwQ9/lpUWcQYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNmkjcJsKLcC17tU0HRvHTWjb3/2xe70ZqbFxjbe+sg=;
 b=sD4lMiyerEXFH64+6TOKxjJa1tHIS64l1jch4mJoMZ0xpzbMDij5ed4qmkw9O1lfkAuGapPk/VW1Fp2ymsWPxg+/SDO+fjkbInj6To9vN0HdZXCj5ZjibVnvW3JG+XoFHbpLUQeQt7wScGpVRtNcw8GbU0PEN7XUdyYXsJCdkNE=
Received: from BYAPR01CA0001.prod.exchangelabs.com (2603:10b6:a02:80::14) by
 PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 16 Jan
 2024 16:55:17 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::a) by BYAPR01CA0001.outlook.office365.com
 (2603:10b6:a02:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:55:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:55:13 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 05/17] iommu/amd: Introduce per-device GCR3 table
Date: Tue, 16 Jan 2024 16:53:23 +0000
Message-ID: <20240116165335.6043-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbe1d57-58a1-428d-de0d-08dc16b3ea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jl3YO0qnzBz9UaV4ba0+IWKjT0p6PZBjwB2zbsRexDIrqOXRMguFMlIByXsmtL8hRqge9b0SvZKeyGs0BWt6Y6W0JAjNZ+lfKThBisBH+Uvm3DQ+bE3nl1mLOkS1i4CuU0LrF8Y75HLI5ECIX6QECI4wPTiD+PBJzHO041E+tXlYxnZUpyFj1OWiJsS6uuuV29tPAItMKvkbNsPjVHsBAV4tH/8xC0IWFdG7GKOvr7WSaxB2XhDQHQW+xOTIItytxdMCF+oety5bmKxycWI8wh9FrSu+47vwkKUAcoirkEk5sF45VoKPZ/vzWNUyNNbl4kfd+UPhjbUKiFBzOYPpHoTuBivxtEeRAe6ywmbEA7Cfw7rTRJLyi4DXGfwgpZGTmIiClurD2SJfi0OKBSaBzwHJS6ewB80E7UL3OIJNR33EuJfKxikPDbBKF4eLgl3FuZspkrRBgzOYcoecbkKvy+Vk8mpLUvXpl/c3gCIo3PeTLSV3J5lVfK67N5bi6OKMLV1pH8F4LDdn+bBCKChJJGO2IwCTs6Kq+eV4mMBJpNBF33Q6LThnRZ937tFmym4b5Qi0sUpvk2NlHLIhjT18/ZHMWFNHBQ9euIo83RcG4HJID9NNYMLl32luCQQT+JWQZWBRcFEa4c//ctgOAM86zth18X82tO2SurGAV2MHpT6cjN8EoGs6CJPMoEnzPsB4G+K78PbuPnFYx8hQatVpl31ch3b0tyjVHu0UlkIf9uvhhbneQA5UQlsYHJGhhXVdFLAxOrKwv0/kV1RfV/4gsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(16526019)(478600001)(426003)(4326008)(336012)(5660300002)(8676002)(8936002)(316002)(70206006)(70586007)(54906003)(6666004)(26005)(44832011)(110136005)(1076003)(2616005)(36860700001)(82740400003)(81166007)(356005)(7696005)(2906002)(47076005)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:55:16.9049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe1d57-58a1-428d-de0d-08dc16b3ea98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051

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
 drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 934a63f64839..fead9033796f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -541,6 +541,12 @@ struct amd_irte_ops;
 #define io_pgtable_cfg_to_data(x) \
 	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
 
+struct gcr3_tbl_info {
+	u64	*gcr3_tbl;	/* Guest CR3 table */
+	int	glx;		/* Number of levels for GCR3 table */
+	u32	pasid_cnt;	/* Track attached PASIDs */
+};
+
 struct amd_io_pgtable {
 	struct io_pgtable_cfg	pgtbl_cfg;
 	struct io_pgtable	iop;
@@ -822,6 +828,7 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
+	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 
-- 
2.31.1

