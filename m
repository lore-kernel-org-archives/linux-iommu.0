Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765131C84AE
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151130; cv=fail; b=tUxaTljrFFYo+owdazDDQ80SsBHNBAB71cmy3WeINP0TqfdWAo15oB5vvWiNAaIDf08VaKkTRkIUyT1xw0kSOzukw2uW8oyhHqPWHk3MXLKYa+xyMChEQbwG3i1WP5ae6Cp0e6UuwhZRDnAlYFZRs80e261VmqCU0aksYUe29Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151130; c=relaxed/simple;
	bh=VvBUXS/1abVkq1nDwwtZopAEtK+XQoyz8ogJY2DHArg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ony8JqV+VMAk92mBvKnpq1v7+UDOr+fY651bOsuP+/a57YpKxU1oFIoxir+wwZm2LVujKG0jYyMiZ7KVq2f/uXn9LGpPqle+UpdYa0YC9zVkQ4IvqXIeinwruiirTBq8my8+oBYOHoBTEGspMo/F3hAm0QlB15PUA3bZWF78UdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hl6aKA0q; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hl6aKA0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pin9F/0w/rMODB4Z51RsbgN5KnsEatQnVHglZJCXKRd6iwylhSDMxiFLwnv+NSBYrrdTD3BCSLUvd/oVdXqGmjKOJJ4YVrIlDOpZURHh7MfW5RszrlpGo+hg7VGxNHPAHO6M7ngN8lNsADtMDDPUd1X6NIzjg2vCh9gj6qhCdgWA+blXdzBRJDOuLYTO/3jdizzJ/x6mZWW6iI/krIiXVu+l9AsWBRmFekWbnpR4hjEg5Gnh/cbDYHVMI89A1muEZtaftqat872iHaqSiRYD0yWCfkfH+9r3eMVZsEJvYwXF20RK80CsALaDiniQYmxNrdR6ZPr3qtaGXsO98hGvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS8bHMbgVHP4hr481XNUufLfvliCKe47cyu10MwFhos=;
 b=mFKpZHaH+DWbSlnKXl+sVm4MX4Z4BWjuvfhhzWy5crz71EoKyltIifTMvEumH+ubhKyEqoVIaX7TFB7xTVn4pU5tD+eG/0/99Mh4I3ZZ8P5OkqsWPr5rVi5f9i5sVbNVo/UpkwU0FxFtSokK+DKVSsRfR+7tTMGm6WU6qg9T7Wtkg5qEB1Ctl4Ild8jkRqegfgBFd6vNIJsjqaoEHLxVaLk3sU2aqkB29zMDFKGidDysdkW6rc1AuG5mOM7N/Chf9GQgCGI3LzpCpneqepWpgcV7YfDHUp9hNd400fEQXVJXIgneomKgvEXwr+OqaV7RVMgFxas5MTXjbykE+4tGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS8bHMbgVHP4hr481XNUufLfvliCKe47cyu10MwFhos=;
 b=Hl6aKA0q7CzWjFmiIz2qWRq9hqnJNVLX95UCRcsS/5dSoD3SgJMaMm9iEQQ1+FasMlJVlb/LNFv9kULrq3ysCqjkvDlK5nnvXkuIhi5hG6suZKoPYoiB/aVVvmlTSaXNsRLQk2xOKB0yczkXt+62/ULzksQGp7pi/mSGe4URbKWLWU/dF3p6W+qnVzFJS7aKGU1huPTgOXVtFTVjwDSpX6UpwZ47m8aPIqX+tyq7K0Phap/ZzAkB5n+m5ZMgifCjIus8j8WotlM4rIqDa7qP1MI+EIxtZoFxok3d9gOl2D0UJv0s7MdheC5I1WhdS3qvLkxHQ36fhBeQ3LwKCOql9Q==
Received: from MN0P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::25)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 05:05:26 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::4a) by MN0P222CA0019.outlook.office365.com
 (2603:10b6:208:531::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 05:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:05:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 21:05:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 21:05:11 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 21:05:11 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 4/4] iommu/arm-smmu-v3-iommufd: Allow a shared s2_parent to allocate vSMMU
Date: Tue, 4 Mar 2025 21:04:03 -0800
Message-ID: <564eda8dee4bbf4c6e1d1dd9ed6bd40cc1a2df26.1741150594.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741150594.git.nicolinc@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8dd552-195d-413f-a3a5-08dd5ba35741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PsWcfjzQHYbqoPXZAhdg291YaL51M/vx0l5vzNbwPJxer2QiSkL4JAcDOAcq?=
 =?us-ascii?Q?PyU9hzQZwhxA86bpS+vO+cq58QHE22lqrzTqYs30xfHbzWEf2bRMdByvFRfH?=
 =?us-ascii?Q?hV807KAdr9UqLzE+oB607d7+8QH9b3LSeVa7w32ynwqojQk/vP7XdXShivj2?=
 =?us-ascii?Q?giGgat7dLhYZG3X4YM5WpXlIvyUsyUlmKhL9jDIlLkOt32jIkG/EPR3/68TD?=
 =?us-ascii?Q?ntQyChDz080CZUIKnYRWNlw3u1SAStyRJWLYZVmEMKC4KwQu2DHsIVfuP9d4?=
 =?us-ascii?Q?gK7Ea2BTB/wctEhc+piHMq98vecDERo52aFn2dIiJbrshNXyqeCFpkiQxTBW?=
 =?us-ascii?Q?tPvPTsA3bi8RcBY7xKSNNdrxbymJAQehelfu4b1/yEDZ0410vAKKEGNDNs9p?=
 =?us-ascii?Q?wciXNkXX8/qF4PEkzEfTemsBZrI2KDQkpQre36Es3PLnJvIxGWAhy/37Zcnk?=
 =?us-ascii?Q?m23S/egbEH1j3o8SgDRIfkY7LpSKGVkYKgZXnBmpPY8n5O0hV7sANz0iGcCY?=
 =?us-ascii?Q?fRhFLwak+SMbz6w8e9A5iuDLqIUTXpzxBZv1bWIwTYg1CyFYE5SLdv+kMyiD?=
 =?us-ascii?Q?nCORoRbljDngit8nm8WYVmqhkue/D8lEb288bJK4DcgxtQkSu3FDWfw3t1yN?=
 =?us-ascii?Q?BWdhO/2dp816Nqbf9VA+bBrIipGzjEfGtjp445PzvVeieUju08+HDCZ5X/87?=
 =?us-ascii?Q?oN53DJOYlW56rY8bBFkjxsiRQuATK32XmVF4+724bKJTpo02g3dLlo6qCgoz?=
 =?us-ascii?Q?pyi6SZox1MbBt11nCSK1anJQ7kDUMAigSrEc+z9qnIEvtTdyBGEynyLnxMyr?=
 =?us-ascii?Q?9spCgp2BqpL1ZGJoV7kWdDCPL/+dk5HCVvnTjOOGD2vGoc2G38uyOTXZEq4B?=
 =?us-ascii?Q?tlaR7h11D9OGOuwRlwML3GnJqSR/vuOg7wG8MAvbH9wWBNaVhUO3Ok3P9zgm?=
 =?us-ascii?Q?4JJIe/HpWl4en2xKX9DNdtxaIgC2CWOqiG1T3OvduMoM+Taiw43buwElrJa2?=
 =?us-ascii?Q?Z7SF99tsLtuLd7pV5EnNU2adK4zZL6SrQD8pHTtNCytbzZ7ffLF2Y94Umrfk?=
 =?us-ascii?Q?apy5EeteYf3gnMH5qU8pQtdOkaJpnp0lS9Nojk4d6uUnQe3P+6dBMyFU4+OZ?=
 =?us-ascii?Q?dKX2GYvAjn4fe6G9RszvIsfYe0Xv8gntclUR0n4VrWkrb9W340UdhV1sEErI?=
 =?us-ascii?Q?2HdGxCT/dpcGOhmAZD2GvLti+oGbTx0+W0uAI5oxVbjdFlYExWb21KTE5Pas?=
 =?us-ascii?Q?U+SaqoeY9y0rUquB/xPe4ZLoXlRlCGk9vkhdo6OewvCDZ6uqVx8xM1Kc8sA6?=
 =?us-ascii?Q?1bbHdIkojfqkXGKxfaQtk8xFgRCGE14EHSxcAPFylMkpNWemvbyC9eaNZZrZ?=
 =?us-ascii?Q?QfiXF6Mu28gb66p0OJ7P3/OcqwMw1G5pfo/ZmG5ConCw90PfZ3X5wnbzPdlR?=
 =?us-ascii?Q?Hsp5dk7GgvLpwwqa6SZzZLA0MrG/9tcXML8dnYTS2dXq2ecuQtHNKwnik7gM?=
 =?us-ascii?Q?9vBdIsXhvZgTn3g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:05:25.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8dd552-195d-413f-a3a5-08dd5ba35741
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

Now, vmids are stored in vSMMU objects. So all vSMMUs assigned to the same
VM can share a s2_parent domain. This means a vIOMMU allocation per device
behind one SMMU can be given with a s2_parent domain that's allocated per
another device behind another SMMU, i.e. s2_parent->smmu != master->smmu.

Remove the validation line to allow this use case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2c5a9d0abed5..9bfa5fa5bafa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -378,9 +378,6 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (s2_parent->smmu != master->smmu)
-		return ERR_PTR(-EINVAL);
-
 	/*
 	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
 	 * defect is needed to determine if arm_vsmmu_cache_invalidate() needs
-- 
2.43.0

