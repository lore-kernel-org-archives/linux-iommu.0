Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CB41742
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184872; cv=fail; b=REUz64q0IZOQMot2Cl2+5ETgKM4SSp4VkaakX2iCtbkXzqZ9hjDr7lQB8+8ue19hQ68Vz7TTgNCqSswyT8XDMro/L3NmcCEW3yBpneGXR1NrdLSyBWCDwwz8jOuWZlsEanwuDgpBmuJC8Z8sP6hBucgvggox2YgaAhklbC83f1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184872; c=relaxed/simple;
	bh=Nqph5gIAXjAhoTTi5IKuS2TTd/aUplABhBbBG8PxqmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnkl0zqyQq/mteo7ARZpJYyOdTwFGQugCHHyGIXQDwTl4P+cCQyuhFp0WyYD1yw+/3BOSI7OBLhxEhKS7j7Jml4uoPXgOkTWLWZggQN2rgcJBrLmGyHp0lOCFldwW5uRv+IDyfVxuF0zrzloUPtiE7VuseF9aJpIZgFqDrThbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tvDDwrax; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tvDDwrax"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luR35Zl3+ANNr92NsGliXTr6yn9Q4vqI05lb6RbiWHWiEe6TKeN05E4WhGks874pwEGBkrosNT3nGoxQWjXBiJ/X5kY6ZMozJRrxB4wZvbgKWdyT+YCje8N4nU5eg4J+wfsiuyTm5lE9Y/EwK9uo+yJQilfICroXnRhu6XjTFjp+cO3poajn5d0a7T0a6JRXGR0SJcne0THX54XWTZOOQfBGB4wDcY6UhbOXJ7IAhIe0ry3XNKng0vYE/+ZifrfpwTHQwQNWQ61BNax0vPrrP/qFX+ZwUkUivHu3MgU9m2FfhavYYp7V35hKCSLUjCZZhjQ70QZxrFT/cxY8wd4yFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTraNza3N77y7+atHmwhhzLwLPvtP0AgsYkPZfyTnpw=;
 b=cqO1KhPQ25D+vzNqie2phnLM0eWa6N5jhg5vTP1aC9qsVCkiBZVLOcIhK/+J9qWiUZECHvUIJJfMOzLf/BCt962Rpb3jySx43L4tmQl/eRwlnbkUuG7xqJGvfHCRX2oKZPtzPnzTStNQn8GK/S7bJbWbg1UC+BnKjn1A0v13/CZH9UiZyrnYy7xY4NMa4WT8j3g6Ctne3R4E8LrqhbDVTlX70CXL7whBCzTv85QyefeFH/NaAFHYSmuuLaHzcq1PVyq3KPr65rh6yOiBnWlfozNQqpxRq8sgtGOrp2NId+kaPMeIvu1HUh+sWDPZtv4OhkG53YGo8xOhcYEFcB8OhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTraNza3N77y7+atHmwhhzLwLPvtP0AgsYkPZfyTnpw=;
 b=tvDDwraxwra9pJ7PQHFljFrmGryy1zK3iL8V+TnVOlzdTEQC76oHzt2EyuDa4trQKy5gejDMWSAXvRSokTYckeliwPr7MqopsiNtIOXI/leb77n5k76Xh43GQCPjwmkqTvAE5BUHxI185TyzDEQQ+xA+csNlyAcyQJk+vP40Xf0=
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:14:28 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::55) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Thu, 25 Jan 2024 12:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:14:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:13:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 05/17] iommu/amd: Introduce per-device GCR3 table
Date: Thu, 25 Jan 2024 12:11:23 +0000
Message-ID: <20240125121135.8217-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f306a06-3fcf-491b-8776-08dc1d9f2d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zQRjCW+rQoQy/GRZLjLK69ytrRHC/+2NclxElkiwcJkHdEPEAXXehtR2eYL+TTrWr/9WZEueM5a7pKObtASSXphf/xZ5vWfxBAFZj/btIuBP0mfxwJEsopO8Dqy14F4wvndrWCoQhSyYa9nDQ6VGaBoywq193CPVAFqfOMQX2GCAIG5zGat3F/F66rNZvI0PWHXdY7UI6dUCLgh/p8hJyqzhoHl1OYbb4YE7gdbEvwayKDWE0s/ftq5n4+86AL9Z8kZTY2J4qDZc0gRJCh3xO9SkcRUcPOLTkDVRJyNu+HLpTNtMarX81FCBWTRHQ15L6IItseTRPTJPdG/93KX5xXOURu1h/ERPx5Y9KFxjhU+3PF6f0wcrLO2TOJwatCeqpk6A00uTxTjZ/xrlx27wwJInhbIVmNQ3cxMrFCTfteNgzR1TPE6viDOVhhW2aC4RBkqo279xFIifvl2JK6px/vYnV2LSyroLlVagB2REq6rO13p9F0HgC6bOAYyVBj5l9//EnI9SZlp6DO4THzY2udJWM/9dVV4sTZIiQO07sjwGBPVEU7gT9jaSPaSqVEg8Mt3kMVktKr3CoMxPJG6u3+RjO0IosJCBBDFnKurufosORN4byVeI0ZrrNMPMZTfC54qtawBnyOJtj3Hdi9edmtqpDjDui1c+ZrxlyNGs+CEvI8EPHdEucNrbMalMEDf4Tym5RxT/zasTZ0q2qPE/sao48USnigfdYZrf/pgzO3Pilul6aY1gK93BGaJGBrFUMPZOWUnXVxPeOyXPo0Ekiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(2906002)(336012)(426003)(44832011)(4326008)(5660300002)(36860700001)(47076005)(36756003)(8676002)(41300700001)(7696005)(70206006)(110136005)(70586007)(54906003)(356005)(316002)(2616005)(478600001)(82740400003)(40480700001)(40460700003)(81166007)(86362001)(1076003)(6666004)(26005)(16526019)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:14:27.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f306a06-3fcf-491b-8776-08dc1d9f2d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

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

