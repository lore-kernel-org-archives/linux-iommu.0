Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732856B86
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dp/5gUd7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9y6vzIUr7BL+Is9CzoCeKzFdxT0nYr2Zz2reuz7XU4tbKqIRBR0sQQjbICG7sBVHwlLW5TP2dUIm9/xncLtHQQiUARxncSFdu8Yrq6SyNfTe/uj9Sabh1LUeM70B64dnjLzjnNkT2mwgu3QeOOHr3cu66bpJFrJ83/kNczkK1SxMV/b/OaYMVaUMm8Z7it1abgdX4/G9czHK+AH8NLcjBoWVl9qQNmbgPB0hi/ndQtiHTCLCQmuRf+HfuOH9Y8Mx2htFFHEcsd/OPVA3YZkE5p90c2nzSyOoxpYUds72kgshrOPubslbsnlu13QQRF73Pw0K7VisKCyhMyFCc1qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNmkjcJsKLcC17tU0HRvHTWjb3/2xe70ZqbFxjbe+sg=;
 b=LwTRMR0EQHOb9sY8aZ1wXXNvcRQx1BE3AeQkpCiN+Dv7ponnlrzytPW7pkI/uZ+xI/KN2Rc64+/i387YRcuRKkuIy459j+dV2ipy8VFLYXdM1cdnDdauHtovbbPS44fB0nNlgTWQtM/yhAahuV9f2qk2Kxn3MOCnnl4CDXGz5RN7H72XI7O9AC33EymVaPvradfH2p27y4VutccvhXscbtyMPz1unotT/9gHqnddzYz9Qm31YUpGWauTc67NInw+JqgTQvKZBez5oP8aiqn4ANqlvSBebCPhXDf+n5FdWZxgT8IdWX1xZhs6rUA5Q65SZsHfLbCpCr7LPqQQtWWBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNmkjcJsKLcC17tU0HRvHTWjb3/2xe70ZqbFxjbe+sg=;
 b=Dp/5gUd7hdeA5L8RcBnf4xYiUe/eiqK0ijPW6K/K0o0Pt5tUKOTZ7XdAgHxODCBlezeL8nMAjatWAKv0ikkeJW7/h2MnQNe9sri3Cr/ZcUqXYd4J/eJV6XCWr5NB+lUyllsZ2mPDOrWgYKbUNyRO/HKgl+KfU4wOL+VMc1mQMEU=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:54:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::9d) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 08:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:54:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:54:37 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 05/16] iommu/amd: Introduce per-device GCR3 table
Date: Tue, 12 Dec 2023 08:52:13 +0000
Message-ID: <20231212085224.6985-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 73601ecc-e84f-406a-3613-08dbfaeffa0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+YiNq0PTzJfHs5lj0i6IxOw4qcgKghYBEOFO6jAFGpteKO0MTqmDXF9XueuAmuC0xd+YDIQhKjizAaak/XTkwjXO6KlGYpUYspVTeERoyrvpcYUGOxgMZjUYAToTeAQmy9AVoWWXGC9myacmT2ao7jAfiM1wYOH4JvIcP7iq8X47Yx+XledeQrnSuRT15+fWZK6K6V2v/uoUv64A6Es6GKJevqUoaCEMF6J2UvBNUeuxTNTT6zREjzPFQxr3yEMnNwJRoYuzHu1d9y7gJzFDFNPxexKFx/5v9eTP4xDoY5GwDEIjlSIG1Slv+KdFOjLL78nkxytm0njrg++d0qi5OB4XC62MhWNflR1YYePTL3n7qbV0rtFYwqOW5vJPYUoamDYgfZN0Dd7yL2IV0A5g9ddG4993V6JamFFhGUzIMR0ux287DBxiAMcmsG8zbAsBDt+PNfdghqQqScqrPGLqHtozgeu5i9688pKueDN4bda8CyPENDgdBvjdsmLobdiSBiHdmdyLjQc4QwIolmPTQ9qYmgZ8864JbsgM7LNDY5TuO57wKkjZtrH0ja+uWB1vOxFlwoPJXUse+ZejOtnj95/oNT42hYEgmMEBllhIQVXfOeBggE3+EDRSWDgR8y+PMHyklymRFwsS7PMSTYJMXoMb0FQ5Bu7174/R6m1+6nNfwbQ+0sBj+M8OVtLK+gUnhKVpF4Ej5/vPYbbmYjhMTtLH+KZHChMvwEn/n28ywu5bNvNDR/IW+5Exi3mZpEavr7gzTXWS7sFQ2Xyy6RNazw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(40460700003)(2906002)(44832011)(5660300002)(316002)(4326008)(8676002)(8936002)(70586007)(70206006)(54906003)(356005)(82740400003)(2616005)(426003)(36756003)(110136005)(86362001)(36860700001)(81166007)(47076005)(6666004)(336012)(478600001)(16526019)(26005)(1076003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:54:40.0726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73601ecc-e84f-406a-3613-08dbfaeffa0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

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

