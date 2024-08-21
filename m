Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABE1A4ABD
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247453; cv=fail; b=U8+tZg9Z3gYRwBkn2cN92FPSBYQw47DVp4+P0Nm4EBpCbLTG8z1wagaYhJNs19lOMcRug0fTqFSbFWxchTQbKUPWNJCj/QIw+yCes8N4yIeSaJh/iToXqZdwiYkkuoN3kTPxozkglg5wbX4yUFFZPApzuqw6pN8i3pKL6Or2KYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247453; c=relaxed/simple;
	bh=qTeq/iIUGwpm1SKVex++e0EFcbfW9vZigPmQez8hSh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaIZPWGdbelUAGRaEy9UktiGOqgZQv0esnfazqdz5UBO1g1JnnE9nio5K24n1jUvUsTm6LTRmc8xyTXrytBU+T8ol5RtJTpSlI1YggSU8sjQ3jKp2GIctdGa71LbzK5ohDA3cBBzdRFFlhV9DDodeA3DtSQ0WYATsML35Nny0cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcUYD3aF; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcUYD3aF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx51YiQrT00MaOlzz8zFH6oCuvOndioAQyLdvbmPgJHE7TeF2y4YzUEtanl535Bcqei/JpmpRsyeqrDYI5Q/80KJCzq+RJurbUT589NAs9S9UGySIkTgrbKRVykJUYs2hVpLNvOsL7RJyxCu2D1yxb079HVxA8wVU3ssz6DFUGltqGTRMioHaTdAYh1yS07zjJya+5nE7i8c2vdsLtaH6CODUr7tZ0dcJGjdhGgnmbJ1fL4CHkgjBL1ptjvS3G6tULkcylYrO8P7dHSJfYd6AJyNKcxnJiqe0g3JVIzXtNq4cEc5QkQJD8C4EtDEH/BhKTdZ7wUBJyBm+805xg5w4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKlWcdePCmL7I/eWFvPS7XqzUu3Dnk+czzn+5r7M8zI=;
 b=H+m6B0AwxCL8O4gElqmPf+aCXu9Wmzj9m1S6a3lZO9y0DGL6PpmFHD3HSiQb59R3yq/qLPIUM0b0IZ/C7P2iw2ladmtGV35I3oTpkTPljKxzZsEWyv3Ou7d9u3aybod77ZNlPdN4SXjFjtbsbuXq3y+AZSg2B8NPu7TkaF5+z0PcbFdVldAtkqoDllRNv6p9sC7JV4BiZUmyYbSigdFb65BAYSR697kEcc7L5N8OW1P5Az92JFiGphqv5OOdtxvcPoT1IHkz3AXv123lh/JCeYmy9MjhW8hFHUxur6KFzJ/tSUoI3tHXnRYoPP1vBeZandj8Lu/ARZlRax20iiJsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKlWcdePCmL7I/eWFvPS7XqzUu3Dnk+czzn+5r7M8zI=;
 b=HcUYD3aFa5tgSuFBCla+fc6WrXbJFprUYKyQuL9J/jjg7ygBs6F+eUPesCFf4UkXYAj/M+ARwhFJjqrMx9GkKHXA4yRTsVI5oMiJJjXIjZIgeArwfWQtGEBDZotZPTnxavHbRv1P18Wldvz0IjfWALZbnP2hZZBPTOpIS7i/JIc=
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 13:37:27 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::c1) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:37:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:37:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 4/5] iommu/amd: Enhance domain_alloc_user() to allocate PASID capable domain
Date: Wed, 21 Aug 2024 13:35:53 +0000
Message-ID: <20240821133554.7405-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821133554.7405-1-vasant.hegde@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b16f133-8935-4a2b-0416-08dcc1e665ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XcJXrvtMhC5CAgL+w93XCpWeaxknfVOLCKiCkj7sTeYVPOTEOHu+I62yXFc2?=
 =?us-ascii?Q?vSCNabFG3Z6BzJx9xZ8mc9io3InygHSi/HqnlNailpRQsIJJlUM19cMl43Dj?=
 =?us-ascii?Q?5e23ymz1kdOZqedIb8R1/wnpo929+79z4MQBmcklIxc8WQahH5EZ1bqS/lcu?=
 =?us-ascii?Q?C4nftQQ7aEpfWnM43+A2V/yl3Om4+RfhLX9EEYorYLY7F59cbNKgbSeX9vXK?=
 =?us-ascii?Q?5spKguw5C/EfPZEWUSu4xuSieghiV9wqjBI0rSY+CXyRpnRehBGy+He9HrpY?=
 =?us-ascii?Q?LcXDQaxmd/9e0zNzS6Y4xodCnAJDC55K6hjeKct+8MAgu1pg+itsSukRjBy+?=
 =?us-ascii?Q?9Q2dYG2aKiaQglaaX+QZyfLBkP8NrCHR9a+pfB+VEsiRb3W+ch705IiNNWNu?=
 =?us-ascii?Q?tobZ4IVKKJv3G3f3UFWDBVMfutpNPL3Mm/SZ4zZZhTSnERZFcM/7bPE21ERn?=
 =?us-ascii?Q?SxV5qUR1LvYyzxnyfqxVq7Nt5PckrI0op8FkgARBHF7bxeUWB77mAHXEZRfq?=
 =?us-ascii?Q?J/RZ8W8wIXOZiMOylZEGbAXXQb67XEWraRS2OWpCAMOO0SSOaW3PG/fsMtRf?=
 =?us-ascii?Q?4UbBLMWlwFZjWreHK4Q+F+OgzGiajARKqd2PwUp47/GtZtFGo5GlQrAZLTsa?=
 =?us-ascii?Q?IbWZIi6GD57j31RaAZ0dibx/DkkGxw85gU9F3ZDmqhxwYKf9gbSVStVHTVid?=
 =?us-ascii?Q?XTKIXymTjllKI252vKHvsQE7ZjzVTQi8B1kgRwI7K0hWaXRZ0ND8euCt0hh/?=
 =?us-ascii?Q?5pSZMjApg7N0f3HtMslcSIfyebvmpvUWR9JOxDNhatrs38xTn8h5Zzh2Cm/B?=
 =?us-ascii?Q?Peg3TFVSTtq+7QCBWHuysJysSNZYdqzPp777OXJHqf7ofnfKIT416RSdvc3I?=
 =?us-ascii?Q?SerzBoLvNMlpm3vh93PVxbA6TWPERiA+peHvEr53m7Zw7WKYtkvoc6+CT/U5?=
 =?us-ascii?Q?sHPOgfk/hvwsEYXYjd8T2Xcll073IyTHydB8+ZER44mik84PBLYEZ4aInC2D?=
 =?us-ascii?Q?82G5NST6IUPKq8kr30I/ZkZvQr6zqE9eg3eDPYM8gxEdWhtFjCtpM/hDmc9x?=
 =?us-ascii?Q?6VLUeNqQk1ZvsYmUzjpzwdyG8ngXANteczl2nMeMvRBeIsINIEv11g9uLTxk?=
 =?us-ascii?Q?FB8TO3de6ZGKs5v7yuZQSDuuTGUWbqRfrhL+AFBsEhsddY7diricXKrSvqbo?=
 =?us-ascii?Q?eT1fRphL031AMt1RY83B4KIcWd4MhIw4YcE05k0JKja3fQ+Z8GBIlE1wvdAj?=
 =?us-ascii?Q?xbrUZomHCrUwKXa4JwzDSQIAkP1HLb3jy7p1L4pF68K6JILcgJqCifdWFVnN?=
 =?us-ascii?Q?TAewWib9h2iiUc8ls3X0Jl6XkIjgNTSLCnZK9Yx/AK2WvJb1Ld/a0/GwETX3?=
 =?us-ascii?Q?EEEVXUGDOWCcJO/7MbAOjuciEnMSTILhF6DzHsG6Pt8yLT9Y4T3EN01V92d3?=
 =?us-ascii?Q?IttqOQHdUKRkivSFesL9J/8vSgwb6Qbg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:37:27.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b16f133-8935-4a2b-0416-08dcc1e665ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

Allocate domain with v2 page table if IOMMUFD_HWPT_ALLOC_PASID flag is
passed to ops->domain_alloc_user().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 817a26727894..a4e6789f0487 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2443,12 +2443,23 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    const struct iommu_user_data *user_data)
 
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	int pgtable = AMD_IOMMU_V1;
 
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
+	/* Allocate v2 page table if IOMMU and device supports PASID. */
+	if (flags & IOMMUFD_HWPT_ALLOC_PASID) {
+		if (amd_iommu_pasid_supported() &&
+		    pdev_pasid_supported(dev_data))
+			pgtable = AMD_IOMMU_V2;
+		else
+			return ERR_PTR(-EINVAL);
+	}
+
+	return do_iommu_domain_alloc(type, dev, flags, pgtable);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

