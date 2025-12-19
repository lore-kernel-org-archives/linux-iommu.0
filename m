Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BCE2D877E
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175154; cv=fail; b=NmsDOryv0KxW3D9sk9Evim4Okip0dE2WiOBDFYwjTRvmDlE+WvNaGZvR/tQ/viH+D+1EGKMmrmwSRwfoVnprNvXqcNrQyNF6kDW9ko8hp3UvefMDT46YOsId/4zeQhMChxUzAzd4uzt+Okt1uacjqUwA3tCfUUrsFYW75klh4yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175154; c=relaxed/simple;
	bh=C/xdiENoWhh3rgO4t49jItVKw+boHDVfQj9OVDyFq1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf8z9f/K9iyjHypYc8uc97vQpSiBT0nif7ppAlAjGW9TdNe+MrLIpQ+bV7fm5aRx14ySJhxGzMQSF2Xq42sOn4uwjaScGH9syrKe6a9QncCy8ei7u841VKuGRNngBurKO8AT6VqK+x898kkEqrlzfCKc4wpq58Tq7O2z/fZl+PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYrf2LMt; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYrf2LMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBtm+E7aJSRB8AHkN9nhBF5PrDL/IAqSi5Ugdyfne/LzOE8sj7+5FWynzHrMWeB7950dHIT4e36f9mO+I6qsLF+ClEdzJgPhKIXRsjw8/LQZTq/SWi8vVOMnGcifj4XaCrNmQ9bdo8BFMJDq6YXQzraEbFXvaWK7syFxiv/m2ZFeuH01Vfe3s3thi3qcX6t2gpGOVG+UsQ4CBgOyvyLQLtmF5gA0iyB7jjq4lo2C7kiSMBshqybOEZUj9DHXjRecJkUnRGErF85J6rMmngtH6J7B60Ay8mm4+snfd+WCj7zfs7foYMZW2hXNredLGl7JYSp6PSdQw05+Tyoqcv6cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=Ujy1UMhX9GerCm6YTq3yAeaN9Oe0t+xVm5JIHtMTP/hymMXfa0oC8QKQm9r9POPUxApzSmoVUgUWD5YkRVkUdxF4oFoHUgLZWvJZ+6snho3H2EghBXws6NcHZbBZLo7M88fJz4muLdFtyNHnjn74r9tfBn+MwW5+6EBJUQ1F39Cn3GQ6bT3A5WDl5EgRUIC3pqjPR2fOaTg5MBh+TiyVT/b/dqxqbnFYQMSNLV6ArLlHdSnIbcPEjWKrGHDw2Kj1GSN9Z3v3fWquYb2eo/zUAzeBSgnlJ3GhNXye17f2yEyAT9Scw1JKXXZjx7s16FSz+YZKzPaGPm5JDLHFxBV1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=QYrf2LMtJr8hNLQsZODBzurCsBHC4apuhFu1WuEwOVaSElCHW2vznOaZDfVINGk7sBHKZBkVFcinDvLm9yia851y0UsV4iWhK5O2g+IZhSDizW4ESGP/zvc4irRYUEfbP7LcNpJcbiTJpYZYyR0esLqIUmxmvyAYJUe/Vf3tIcWu4zeF2S6XuUG6z59+e76qapCmlHDXm12iQUpFimEtANcnJbDIwYZmnyNLMGheYqjznGlXWVLvJV8RdbHhAcbx4CYftl9EBaZ3uojxw4S6McKLRDN3cANgFCAsgjydcWp8ZZIoR1LHO9DNnhOngi03j+auiWXRftoM+jW+HWlVFA==
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 19 Dec
 2025 20:12:28 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::c0) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Fri,
 19 Dec 2025 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 20:12:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:09 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:09 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 12:12:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Fri, 19 Dec 2025 12:11:23 -0800
Message-ID: <df4b8cbc0d67a0bfcccb09be868e0da5f0cbb743.1766174731.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3368674f-eeb9-4494-4142-08de3f3aeec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qfi3ue9R6Vu1hr9o4vGdzFeCimH9oANH5mXfr2vmlVGgXyGSQQZQYypudoBy?=
 =?us-ascii?Q?N5vD/BF7OKp5yZrCTn61I9u8yPOhJ7ffSop/g5iOYOnXwLmz53ufs0tjohq3?=
 =?us-ascii?Q?p2Z8Etr4dFjqYXbSjHg7NI8u0fYjNY0MUBqY+KXDeek8cGKbj8ipCKGp9hXl?=
 =?us-ascii?Q?TG0NrWRx4GIdCDo8foDJd1SzypmdRMlLAo9LSfiWiqvSBOI9+QeQicH0/3l2?=
 =?us-ascii?Q?P6HTZZTZL5opHGaJ064BiJ8tAlOcNyGdIZs2hQr0gGP24gF4BtCNsUYzPM/q?=
 =?us-ascii?Q?fDHFUoBppreDP2b6oYNuaAWGF5L26OvKQ2U5z7q0RsY/R9koTOGUksjHAq/w?=
 =?us-ascii?Q?ARp+hWkamB3g1fBxuYb7mAx/SLytoB7UptIuLC61Q6GBzugFLMgYnBLN7aGF?=
 =?us-ascii?Q?InYFCWN6Qbh3rVtufi4RJ5vn7t1qL5yAs3Y/F6gvl4eQAchjCEBTpYo9N90/?=
 =?us-ascii?Q?KVGOUMUc4PRz6dW7pYDaBXFGksZGLXH48RYfruscfPdYhHbAuso9nCq3Qbr+?=
 =?us-ascii?Q?wOz/2i8BPGLZulfhEyuIsCRqZmVt/zQn/CTgxV83TfOqozrB8oJDFOrtGLD4?=
 =?us-ascii?Q?n5FKMY9kfcOjkJlK85pcFDCmL+Ep/yfQh54vORKRA1VOhYC5NY60Ed7DXP89?=
 =?us-ascii?Q?pqkCJlwM/YjPpsM8YlhjCqsDHyL13GfRf7XCVgiL5F/uDhnCXXBWMP680pUF?=
 =?us-ascii?Q?c28CpA5mC6IDetnOKjYW5cI4SUCInITj/kt7C+IdV0RrJiFKUKu7cGvpkqm7?=
 =?us-ascii?Q?1XaCX/LzreL4SIebUEUrqQacqV7rnojoxcE1ubb/oGsSxieAVSJCyxwDF91e?=
 =?us-ascii?Q?dHhgqdIabSVommWWIZk5xlkeSJfI/kB8zvgnHUINOn8T5SJC/jd9sArXgJ/s?=
 =?us-ascii?Q?xZkn/g+s+SxaMjf8cTjaEjS+oE2VCorj3PxnVX9AeYytQEB/0H9AHVam6tpn?=
 =?us-ascii?Q?W0aUG457dQDhLAwzmzb7aH05Z4iO/SdpUxcgWrCix9E5vj9N5ZO8ibQXepIn?=
 =?us-ascii?Q?xF5VSDaW1r6g/LvcIV6nk+D1kE/eWDLUBTOML1qlQzB5yxeFc0zFfPPSOPUG?=
 =?us-ascii?Q?rHJVy4uv1kU1wpQGKbsHPENqULU/LzzLbQV4eif1XruL98m4xM5iBxtVirL/?=
 =?us-ascii?Q?PWuxxZ0dXsH/MBA+0y+YQqhQ/kq487+nwzJLczYu49hRfJgv5TgFItAitAXs?=
 =?us-ascii?Q?dNYQj5Eh4yTtNMIE/R6k+GxLlya/pRp1BctW0X8zKZYCdw45CzXuncvT0pvx?=
 =?us-ascii?Q?bgvRUSnu3pTst2L0voAKtIT4JGGkN/WQ3tKh90B9fDjxnugYSMS++BRPUpG+?=
 =?us-ascii?Q?HSt4Pd5qZ7DPxSLBrLrLahDsqLLzD9eEhr3hIyl/RVM1m3pZWWC+MYPBNpG+?=
 =?us-ascii?Q?GaSlcRcg18OPixszH6Bngdp+tq1fEYrJzUvKmbSFc1I9Ego0nfDTDJjkGdr7?=
 =?us-ascii?Q?YRG0UehBUJPvAXoqcksx+BCumOu9ZpUN+SFGAulvAW0e2BAPenYsSmSefVRf?=
 =?us-ascii?Q?EyM/q2HwKvh2z+1/wasAMIT52qQk1z3xVx5I1snhGzXpGPicweAJPwQtdxV9?=
 =?us-ascii?Q?VLvKThjgCo5nyhH48cc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:12:27.8388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3368674f-eeb9-4494-4142-08de3f3aeec5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..5c0b38595d20 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -858,6 +858,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80..6097f1f540d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -346,6 +346,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	 * ARM_SMMU_FEAT_RANGE_INV is present
 	 */
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..9d9f24a08062 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3065,6 +3065,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
+	default:
+		WARN_ON(true);
+		break;
 	}
 
 	arm_smmu_attach_commit(&state);
-- 
2.43.0

