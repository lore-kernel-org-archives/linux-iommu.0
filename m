Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A1165EFC
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050116; cv=fail; b=XO8gPWWsHn3VtbRHGINTt6Vu6LWkPdVyCuXBMf2e9CKM28QGCQlB3KRCqSZNo2qcGRxVKBy9Ekj229Ro1K4DdI4wFuzwUTt4gP8Cd4uNd0+MpsfIohEAcnPm8fZnGmThG9RgcjQh/T/qbcf2f0KthVy4odPVLSkgz8aUbLfoAEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050116; c=relaxed/simple;
	bh=Wjtd4aBVRxoA3Kt1BktntYfThFGZWHKeFfdZfuzQ0/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7wMOXz5CXQsvF2RzjU+7esKlX/89HndRXoFaJKS9VGRiY/371YO6Y82B7biksXGEwLWYS/dXmBcPU8yZctU73LekJ8qVaG+F4veiwQq/k0YEF4MYBo1eRaDJGkDc5HV/89SxMkXIReRJJy8GBu3KYb3j+n0KVz8siBt9s0ii0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d290S8dm; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d290S8dm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c34CjAiZa2Ni2T17zhIy84WLWpsUeMvbPccf5wU6ckZqh7rbfu60Mvh28aR3f80rlu56/WnJjk4IJCWGe9t6bCiqyI4ltM+mH/9ebM/Y1MmCYBFheGTheJD2/WtAQLAsKu6kIcQKiZ6fp++QVGXWfne5WOLfkD9OMm/sjAm3w6meenfBuHYw7RWGrf9lOmXPgRr6bP89bl7CNhKCY5j8y28/9AZZ+Kejt0lk5P+ZMHRwgg6SEbf1QMUW9ZLFcvcrEnQZNZEFhoalLxb3IJ2NrR3tj1fYqWA+lY532bvw8CZD6Gofde2Q4MCGfywjjKlq22j+uzaNPLP2ckHcOrcxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34kbxuy/wamTwfjyc4lPIJlVqSS2Cuz61nIsbtd+oII=;
 b=F+VjcZyOGcHm2VkFrA5ckOiCH/PD28Q8KbxXfvJ1sgZMI/Y3v0dkIx6ThdGeR2BPzOaaYT1QAeHJUMN17h1zbtQCBfNcCTDMnP/lOqxe7TiCl7sAlcslLsR1eC9ZJzXHXSSt0jVd0jtmWvtNgeGVUoODGAe7Z58hE+bfzGH7LdZnamIdo64IOZE3NjqvRchcytB7CJa8L70MjSEqAd724BeRmtsP8Xs5QsJu0n/AWZAsSLM3VEqY6xgK1PinxGYXbsMBiQEBcZgavUtKQFWI63ROWc84U1y1mvN9lFRWznU4mYS5enj5XOLOCrTtoQBwJa7z0NtWakM4NSwjb8JJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34kbxuy/wamTwfjyc4lPIJlVqSS2Cuz61nIsbtd+oII=;
 b=d290S8dmtseTqknPNFddffBLnkyVuG5yXDrPJk/puVzhKvi3/a2HagZVVE5F0AAN2Yp/+5Ksyh0BocMAPmBjeKEWlP+B5lsyehl4R7s+Nw3zZ1QQAmIpq1WoYvsIX0o+IUK337310/xbz77c9uM5ZSpjswazL9bnXkV0qBydB48=
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 10:21:50 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::d3) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 10:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:21:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:21:46 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging support
Date: Wed, 11 Sep 2024 10:19:10 +0000
Message-ID: <20240911101911.6269-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b70d42-c5f9-4110-85ac-08dcd24b8cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?byN0ZvDnfRZgVasFPhFqc1ofH3zXYnxN5xkDa0zjxpY5glPM1ToWZiX/+h1D?=
 =?us-ascii?Q?dL5Jckhmy0bCo+LZRMmqxWhJUeMNCtPjqJPCJ/HoCF6WT/OR5ySJqmu3PP8G?=
 =?us-ascii?Q?NL3ZV+QK8Bwe1KxEE5oaDpwHC8YV6W8zLlJZZ6g6s6rq6y2Jy6NMeOVLx35l?=
 =?us-ascii?Q?QNJErmM8nyE8ZrjLKb9BQAxLxngyqmOyojAs/2HFTqzbodPTKbRL5HMGdbsY?=
 =?us-ascii?Q?s0mXFcq5SzmHluX3hjHWrlouGg7YEKRWvR7T7Xirwjy4qOpawLDpUG47jmev?=
 =?us-ascii?Q?LX2HCNju7wLQI/XBkWS823NfrhFcGD4x3BMxNpVC+ZI+MVS2TAlCr5SH4Hyb?=
 =?us-ascii?Q?g05WEg/hf7I2IM9GApoKkkgatj5GliDnN5XKH6n7vZXBo6W/eZEcjqRrTFTa?=
 =?us-ascii?Q?9ycyRMvgIMw5z/fLXs0i9CcL4CzKcKXi45ek/NF4Mr1pv78N5SGgOUTFQBV6?=
 =?us-ascii?Q?K6SW8KqkFLXtLXd6g0eZoOoANWf45Erv50L0iIyYf2ydBAzGCVVEdn4VAQpL?=
 =?us-ascii?Q?zv+Vd4ZKEoCZEoaIxSJIyH5E5PGMUhr6ntMCyaahDZVQwMu5B1ZfFVMsVKAX?=
 =?us-ascii?Q?/Y49TtNOOWZZqlJuHX1h8WDqlp+bcQ2XXDU2v5IqfekN55X6U0w72E5WavE7?=
 =?us-ascii?Q?GTAeYTCj9TXoxVejjqS6hMF/BkWncSC3KTD6CBTtJsaTPMs3Vur1VhlFDHr3?=
 =?us-ascii?Q?mOxeCPUACTce1cgoN+KTxWc+BUcH6YkqJ7v0qXfCSYusctRbIZy/0qwEdBH8?=
 =?us-ascii?Q?9p4SnBjsUDQFKnRuV4YIQUb+lJRXLWY/HnksSjjKPbEcrcOtUTpG4b/5Cswg?=
 =?us-ascii?Q?jZjE6vAlcoAfdKXL5cop9LprkIhhG44bVssEj8uDl36b29Cdw4QERQcPt30b?=
 =?us-ascii?Q?bdU8aGTmtuX/y4aYisLKI6dRzk3hiSAc5pLHTt/J25umU3jqBg+HrA2baThj?=
 =?us-ascii?Q?rWCmKBSmlQy4GQa7FoSWjFUTuKMhSFrpAMBLA/woqsnXGP8C7SHsQdmdTDpH?=
 =?us-ascii?Q?TnYoiNjAintOpGRkv00x/agqW8khW/sj7DDq4qEqhUfN66L4DdLGRHjROFdd?=
 =?us-ascii?Q?MNo447NUVf1SWHkcRECvEeLxSWJr37fYuTvJprfsLoRiO7JSEcPiWph3n2AC?=
 =?us-ascii?Q?bTpbbOKqOxHjeRETSygCd7/PM4Zu8j8HlnI27hdyPus0JexL5K9uj4r9MWLi?=
 =?us-ascii?Q?O5lzUpGhNqQG4LeIU1rKZC6HXaIMZ/M018jiXZyPI5CbmFMA7XVuPaP52n3k?=
 =?us-ascii?Q?myRgA4p/FSs5qTMXbbmYVYYbq1pGR7RnfgFX8Kfkd9GM9TQtM9nEYPXqVpKw?=
 =?us-ascii?Q?BmVyvqLjkhO9YxK6/cFFsfHKYwsMDhzdF2s4m8StU0RSeK+rv61w7IVFCg6S?=
 =?us-ascii?Q?Jzrl+9aogiIMDvReYbb0URHBGlvN+A4us1CMESquUD5pLZcqN6yVNn2I9YJh?=
 =?us-ascii?Q?qPfrSFTy8PnglC5yjL84q0f5sEMf4WWc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:21:50.6513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b70d42-c5f9-4110-85ac-08dcd24b8cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156

Add support to allocate paging domain. Note that core will call
domain_alloc_user() to allocate PASID capable domain. Hence its not
checking device capability and allocates page table based on
amd_iommu_pgtable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1c9e539f15a7..e6b4460c485d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2395,6 +2395,16 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
+/*
+ * Allocate domain with default (amd_iommu_pgtable) page table type. Core will
+ * call domain_alloc_user() interface to allocate PASID capable domain.
+ */
+static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
+{
+	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
+				     dev, 0, amd_iommu_pgtable);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
@@ -2858,6 +2868,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
 	.domain_alloc = amd_iommu_domain_alloc,
+	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
-- 
2.31.1

