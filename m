Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834701C292
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134329; cv=fail; b=ooJyzPf1ubvzl1/HNsXEQPf8p/EyDQ5pbN8lKOQtzW3AGPB6sCmEI6WlREE1R6T3gu42YBQLH74EaKYc4koWhV8HFRVwkamOfAjh8SIHyJnL6wPXPLdWEYbbhWvuqRukjX72qlN0zh4RjezX8ja/fNyYSzWlRoHxMGpR6Btir7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134329; c=relaxed/simple;
	bh=Nqph5gIAXjAhoTTi5IKuS2TTd/aUplABhBbBG8PxqmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGhIbtaoZw1wGWXHclQaPB4/F07GfdVdqqXOFnGVsRotgGBBtcoQEli+uqRMX08yJMU8tm7kaACCvw/Ias3gUqVsU64z8vUfmjlOICJOHbjHESQaPpnS0abda+TMK07pcULvRuveIoJWlalj9PRZiCAXWAZrgD0ON69w820Ynr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XNUFGygW; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XNUFGygW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH0RsFtO21/TyIsvlWpYqjv8HDBmJ4MnQWxDjhrPraFZFdGQQaAUblyj+F+noWsJ40zOmlGSEGT1FNnr5kAYDOVGQF2V85lN6tFst+Uft6iZCuw6qOPS2FBfs8nEslgQfM7c0McjKEobp6ZAupMjMqFnktYAI4TdjJG9tVZ0HBiw1IIhTg2miMVXduUllvTOi0yWjXSzknsMoue0TZTKRIqW10OfO+UgDvFfdpkpfavMVfawTGn+pZyWAWfu7Weig8x9+KnkxM/hM4QBqb4SBtkpqXg02zo/z2ToLDCluTw2vTbdt4o/SXfJD42U8TeAROqVC3vlmBBfHRGXxsjntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTraNza3N77y7+atHmwhhzLwLPvtP0AgsYkPZfyTnpw=;
 b=hXYSiRnHAlB7LglBb3aNtz6cCB9BwCSrkhcsW6v7GYQoHeW+W/IEr61nmcMN4BUC9CKMKdgZ2srplAWAMIsGL5eGfkekP360QGL7qg6aquxCGWx9G/hXtp5cInJxAZ2B/UAYbk9wnNldlq/urF3bgwoZmwVMlem63oVVOMrdLrKkxaoDzukH/MDi0jhBoXiTG+gC2Pd7zrV4T2tW5TBQdaOyas3rXSYA9/BfFdSPqCyy+wr5AeUEGCLKNkxnwHPTtlJ6BL3rF8w5SntksDrvAukNgEdoS5KKs0Bm4ti1bxlSj1nlYsFRrqKCx0UVZKEKTl8xcDcEjrNiTbV2rVwoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTraNza3N77y7+atHmwhhzLwLPvtP0AgsYkPZfyTnpw=;
 b=XNUFGygWBMLrPqJkV8xXtPgi7VrX/1u+uhnYuR//rVQibBtxlSdUS/lDKAeIMpzlrgKFPpWDke8ZREVlrpHFPoTpQHPcLl9/9H282xK0lYHa8ceO+buIrDDfNu36JKXXIODNF5EXateG+TUC4vepzoA2XHzn81EJISSeTNbTq8U=
Received: from CY8PR22CA0002.namprd22.prod.outlook.com (2603:10b6:930:45::7)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 11:58:44 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::11) by CY8PR22CA0002.outlook.office365.com
 (2603:10b6:930:45::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 11:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 11:58:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 05:58:41 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 05/17] iommu/amd: Introduce per-device GCR3 table
Date: Mon, 5 Feb 2024 11:56:03 +0000
Message-ID: <20240205115615.6053-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: beda8fc6-cbfb-41e8-c507-08dc2641cdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DXkUdPae1Nk9fIpGGZ+W0pPDTjUCAoolUBKSQP0vbWsE4JRyd5xyIe9DO2ZAzHJiykArUfr98IRfHfZY+1knV1J4URnc97Ydj45z5D5mgWW2DbhCNT1NYSzdQXmWIDgS6jgRezjUbSI+FtGaUl+jOoTe0a1UJD9Ka30LxD0xlc96FpcZoevwS/Ghaf+UXtYXBJjj9cwQpJ5VB6KGCCBbxajzp7fbQ2OG/kaU0U0Tu4veFSoYJWgD4d5m6Sfsrpw9xU+4YK0qknNybbaTjs+YTdfehtYKiG2Wj+6HE8H9Hio5hop0rNYXMMvHsHwfB1XhXGgPxCVxV6JOqD3NxTnqppugC70MnfVjiN/e9RlquMQdJwuyo9xyNOW0eWoOARue3hJFGPxZn7zlvPK7A8F85k77e6X/9XJwdWlnK3mKCUmfAyUityPH86pMj67LDtfXFNVUlTgvwLXqEC6otibSvAsO9i5yBmXV+IKdmygOYfz9zbsTdmQFQ9cmWbZNyK7mMVPIWMVSh+arMofcUoMBRghKedCvp2Ue0QapCyuHjeiXd6ytGuAS2atKtQLb+dnZ75D9g/tUiL3+3vguBUtfDtrjjWIE1iIJNrCkvHQp2rPiM3Xxhzj1mV/8JM7J/gPRJ2Sus92HjZnh0gki/KhoT9Vc+7p9OvIoTJ5A/j/BPqzINm5t2xKfK9lw3y1vrkrG8DbuQVpfZ01suFDdVx2xEUA3Svtl1rq28M/6xXazMB3Wcp8P0Q4whSvtJBKttxGX7t/FGEUnR+/PXRHtMQjtaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(36756003)(478600001)(86362001)(47076005)(2616005)(1076003)(336012)(41300700001)(356005)(82740400003)(16526019)(26005)(426003)(2906002)(70206006)(5660300002)(81166007)(316002)(7696005)(70586007)(44832011)(36860700001)(6666004)(54906003)(8936002)(8676002)(110136005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 11:58:44.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beda8fc6-cbfb-41e8-c507-08dc2641cdc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

