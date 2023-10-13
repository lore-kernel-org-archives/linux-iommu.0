Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2111CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PfGujLn7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO2J1CwNBvKRv9aLsS9t/CmzsQhcIlGgs9wGQ5U44szGRHi0uXxtJ8l0c7jsu120yq+mPuEIPjIg4xW+DGWMjtAOm4URw91gcdFanUs1i+8OX+sJ+S4bWm5rPc4DcbQ+J0hpRNjIE9ywpYhDQgkRHZMBxb8gcUGUG0ee8vsWYvmHlGd0x/bLXGw/pH/AyZyoGJPC57mk6laZoApbl4hc87qO2Pk81tp1TO0cTaUBlkyBaF/9TOjHtVYyPRObH+eeENQcY9qxeMg990vdye5FrQFuzZblM5sW2f5cYlYSjyg/wBQ7RTjmsLvQBu5FAfMwsnTakhU0P00ZzICAmWbTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM15C6ypDp7CH7iVjlEbHwngaD4JlU6FjY70KEhwiQ0=;
 b=SLDjfa/Cl1wsnMvu4kUbZJz87GCCgb382ttiKehJb4asWWwFoVvmwE7/wre3hDtZCDlHxPdrj3VjFpmRaEMXAXVhxBPrFf9UTDNiZ+M4elA1gZySqbOiBHb1PG8MO5hPVSHRD6kbwJ04apJZ6myiUKuUh3ZZerm8rxJrTO75SePHRpo8CMTxzI7wvmsFCtdOjHhXkqc/NzOXadzlhPHVLc8ukUzepklUweDbknQQPUgiS7OEFtj0/dH5nD5hTCG6tSOo+3V17lyMyOS70AV43kZCXzCAXZxA4KM1zxoSo7OpD6w2aPDBGf4GL3tCeoBNaCimxRbN/3+Tb/XPxRMqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM15C6ypDp7CH7iVjlEbHwngaD4JlU6FjY70KEhwiQ0=;
 b=PfGujLn73/tlwaZ5x/rGs2oTTCeBBKn8Dp/RIek5/g9O5FMdh130ONCPerMrTy95wgWZaNIjeJpXcDielwRmmIUqdlaSFN5wTg8UU/sXU9LoBYTIblSOHUh0cAKMNkluBmvVnbUQ6Cgo6ayOEks6gHSIuR/7WS1iLrjHZveygdE=
Received: from BL1PR13CA0089.namprd13.prod.outlook.com (2603:10b6:208:2b8::34)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:18:45 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::3d) by BL1PR13CA0089.outlook.office365.com
 (2603:10b6:208:2b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 15:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:18:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:18:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 04/13] iommu/amd: Introduce per-device GCR3 table
Date: Fri, 13 Oct 2023 15:16:43 +0000
Message-ID: <20231013151652.6008-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: a03550a0-8f02-4403-7aed-08dbcbffb0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b+aaZa/vX2eo1NKbH/LFkb3b3IXjFcsxwPzDIzUzFSOrOfCguRPDtEHHCWBO6/sFlJcmVOlOPto0wXs4J0UTSiPMF8QvhS75QSmVNDXOLijvh3iIXZODApk7vDUWLw7hGkpORJAz7iwRFsmS2iR5juIyD//Rn8lrj03g+6Po0PED7H2ncxZGJnYBieJVPSit7cK0+i9P4L6bIBLmo1lOsAaG8i333YMkAPrHV8o+pvgmdzH8IGtr33NsDL2MCoLHHVGWRTIjXrrBs2MAhgwa6yoUMDD6P1Ya4Mq1Flr8URboHstxNuM+LZPaBZyQGRJdXkdJMe47mMxhjxCYZhJFlxp/JwjNUM+kcC/cUkPKuhu35ydp9ruEOe0PHtOFB9VSa9Gy5UF6qH0+Mr2ObJjptIP2UTCn5whYMdI7Gbnwxuw8BFlpSq0NNEIS/H97xljdqetJw+4nRrnJkVZl5ktQ4hoLHz5O/vLCWoH6+boX7zDN5J5GRLgN0NIJSkpt7UgM+P7ldR6Xk3RBL+8m/9hO7yk8rIFMA9zBd7lw86waeKRyJY/gNPjGEtHmbilRZ2W4c83INRr794Kgym4ennLMy2WfbHBw3GHmtUYEB2+JR+JGPmX25nX9NT0Oshb1luL0jKvIxfehBVrCBjEOIdBm+6KOp3wN3Jl5XjGsXKwL89krmshX1621tp7b4z5507u573ABcXFH9kDQgtuKa1cWVMyehmd7ct8/UdsdEAj5ab0TtCdEi23YsojhhNXFc5kdyoJQhGUjK9nZ0duR2cOkog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(478600001)(2616005)(40460700003)(1076003)(7696005)(47076005)(336012)(2906002)(44832011)(16526019)(54906003)(70206006)(110136005)(70586007)(5660300002)(26005)(8676002)(4326008)(316002)(426003)(8936002)(41300700001)(82740400003)(81166007)(356005)(40480700001)(36860700001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:18:44.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03550a0-8f02-4403-7aed-08dbcbffb0b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

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
 drivers/iommu/amd/amd_iommu_types.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5785bd51540f..3b1ef1030687 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -530,6 +530,13 @@ struct amd_irte_ops;
 #define io_pgtable_cfg_to_data(x) \
 	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
 
+struct gcr3_tbl_info {
+	u64	*gcr3_tbl;	/* Guest CR3 table */
+	int	glx;		/* Number of levels for GCR3 table */
+	u32	pasid_cnt;	/* Track attached PASIDs */
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

