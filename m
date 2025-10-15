Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391B3074B2
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557409; cv=fail; b=UpyANeI2TOFaBkEozPlx/ec2TRG/IkUwNYpjCYOFWq4PMEs94j1V1tfzR9O5CvKp1+v4v3QC5Lr2NOn6IoX//c6OGFrDEJElHrcrVD9hucLtOXIUSv8pRltznnV9jc0ffFcms+RXOLcMZD7m/rXRG2sh8A7EHA/Xh4wF/gI61eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557409; c=relaxed/simple;
	bh=8CWhC7oCt9brhb/6YKk/DGiJSQ3QOrfngsjXG3JSey0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/DyhcUMFI5+XPY//p1nF+2JJlcDTQVDLbt08kFXFcR0gh40GqLiICzJNo9p1e6XyWyVExm2j4dJ7WnGYczJrbpw/ZWZ6nDKpnKj1olEYam0HfyJhWIvj/ZVhW1ZNxVtF0T5MOPvvBszkCe9IuWN3ErpY1GsToE8Y/sTYW2IzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qj6BXYrs; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qj6BXYrs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObWF78r19EeS8xlxYNdudTGGD+T8zeDCmPHQ6YIkA9y1X1rdkbLqbAIl3ytFjYUy/a5DHiazf4NTDgbhtFHDL4i+nu7uej3Br5YhAHsmMvxAHStUK6OxuIXk1m4qddCYjW0PqWhdIuqAwdlB5W0NhVfYNn19+8AvqhPBnbepn46dV3xDahKok55BmmkA/sUOD555hyVcgGtH4cjcTcn0A8ZE8VkeTG+Le9x0v721Ybj9f5G8N2Qo4aZeF9CyxcwEYYg+nwavxOwV60negZRvpkTzV9fSHLJHSZ1ae7S0NsFsOo4htYxMlKk6mQSTM57pt9lPrWhYi3uq6XOKQZ+P/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rK5jP9r1cJzxDHikRcrl9q5uVh2GztbACYz7WE1kwM=;
 b=Qu7oahkQqRP2CGwVoRv4b1uv1kW46eW1OZF2ID15aChWGQaZgVWrnVC+MNgJrNSRO/Fb0xpZyp8qJSFyPPQxaMnpZMaRUOfrIZBLM/kiSsXjx/+Rmgr7jfdK2XQpVLlqMCx07GRudaiX8tQnD7bBCoD5ejhtYBjIuQflCBstUl+FhS9fkyD28ydGFI07NE84m4LP3+LEXCa8gvqg/eZBqGGd4hy+RspfKj4lbUKSP7oHg6R0NpsKnX36oyr/S5yOJeoAcH9eP0tIBEMpEtSyXMZnn6jbY4cf/TMTEvSneDWnP8sKfObW9jXdMiDyT0gGA4gzwAYshMHR3PPNb+8rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rK5jP9r1cJzxDHikRcrl9q5uVh2GztbACYz7WE1kwM=;
 b=qj6BXYrsJhNqvd+1M39QykjoK6rKXR5fvy9X4wY2q5GHmsUf1FaOGHxW3Xfc5Ufnldcqe8qjd44Ei6dKbfGMK7rNpXvCbnfqPxem/tVdgKU8ryZvdew1qEI6od6FGDBVYdg9TfqCvvn0vSmMlIv9x1LD8eTgG2s/IZokb4tGebWtrLPoo9SKy/1TOxGpghzHFSnk1epyS/6O4wRvqDw2eHheoyW/eyPBKyEJ68ycZxPk8cuJgxtaaFs2UEUoa8eHxxkIvn3/dIqaznb5k0z0f9Hq2xuHHa2LZmxX6D/ynfN4g+KIvl6QgjwKXRMlbMzbd+NA5CIs68zM2IerThPM0A==
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 19:43:24 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::fb) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 19:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 12:43:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
Date: Wed, 15 Oct 2025 12:42:49 -0700
Message-ID: <fdbc981f7fd757be50b34e5631d9bbb9e0c98513.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760555863.git.nicolinc@nvidia.com>
References: <cover.1760555863.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c31705-cdd4-4f01-570f-08de0c231a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KtqQmSfGamPh8c9n+2c/A5XXM+imxeaUpHvQIU0+rWl/2ykIHEfgc8X3ikH?=
 =?us-ascii?Q?3mbghBfKR3XnPd7o6NOPbEvSZjoiXRGhMVnHhaMREXJx9kIrOEgEM9Zn8+J7?=
 =?us-ascii?Q?T/G1A0LLgR0q82EfrZqBgWuf5N1ZDA/MEJ0FNIcAPzpx7BI44vbmMm+jK4Ti?=
 =?us-ascii?Q?0y8bbm8qAy1JaOxRgmBfPTJQKuPZLUanIhUrzUjyhOXJTPYhx9haZMs2zn6l?=
 =?us-ascii?Q?En28tfkLcIrPqb6PGfRJ9cxUQxvRGjhCAa9qMt9sbxClubteGBcqvaec6XGH?=
 =?us-ascii?Q?hUTtnFS0s2Ow3xaf5vU9Svim6J9DjUJxtyjEGCxNt2Ct+nLH3kz78Bp/J7I/?=
 =?us-ascii?Q?wZ26sx5KknXj+NzRhY/1Am51FF2lQYFwyhwgWFaVJenmGd/HadvDzl5S7J9b?=
 =?us-ascii?Q?VKU9Fup/tz29DuXXvTqF0LcLHmOsW/ZMex5QsiNHh3xVQRH3fbGkCmakA7GC?=
 =?us-ascii?Q?s9HbyyNvHk5002NQC2nYfQ0643kzmpwX0Xlvql7KoaB8Je3fsxk29Ib7wSAv?=
 =?us-ascii?Q?jeB7/97KhvVzhBMeSIszcqqDGebYEV6wVkERrsHFjGS5ZZzXCJXpAyHrs/SQ?=
 =?us-ascii?Q?wwLWRLxl9hCNBF89Ilx5LA0QY4md8rGzhLszRZ3vpo+rxYAaCTmaFx/n6sJx?=
 =?us-ascii?Q?6KZOmM5V0pnQsqAfVbo2yK9wukEC8kgf7ppK/MdW/daUt9UDmsUPICsd5CDw?=
 =?us-ascii?Q?RrOtb44BRhOk//kD4+VsChUi9KdKwu+zq0OZdzZyZsb5Mqhqs7NNFneQeA31?=
 =?us-ascii?Q?GOHXvSl/TF01Pk4Q/Lga75fImnnGNdwt+3ClkRzA/+RRSxa9V1p+b3uyBpUU?=
 =?us-ascii?Q?U0pSPc124BCN0XEozJXXmSyDWApcLc1OcYKurmi+pj5/4t5ev0Wpp0r4uNjS?=
 =?us-ascii?Q?QwNCsrz0WFo+akLIDupminWk1c6tDSZSngpCSkxL8m6Ki3DO2jNc7sVYal55?=
 =?us-ascii?Q?iVN4OQeM4K7AdyREzdMvi6UD7gj5qlMIFAqWYjKiLK6QMThmfIOt7QKApnNi?=
 =?us-ascii?Q?thoLINlSOq94azo6o16WKs0J2H99in7a1KmlXNMRfBl6IAW6dl6VIYDem+V+?=
 =?us-ascii?Q?9dwFfqXKAwaIUHlbLO9kp72kAazrl4cvgxoNkpyBPQ5PF3Z6HIulC3D3POdx?=
 =?us-ascii?Q?NceGcp/Cp+ZAmSkIE0yPnoGgvOHQ1OuylI+RtjaT4QRiql+1EIY09AWlsD8a?=
 =?us-ascii?Q?z2yBeoJb2y4FPIjkTqPN2fh1l+FcfhRgn9SushT6Ec3jAD3B2qiICTRM/eqL?=
 =?us-ascii?Q?nQbVsM1I5cnkyiU5/my0bo4ooWWBAbxqotgIdY9yQ/9oVeaLUjIvxKocKHlo?=
 =?us-ascii?Q?wNCO2EV/ItMXprqVlL4P3jY55FoJhNs0g/233VxoV78rZNE/DzVvNQoM7rYe?=
 =?us-ascii?Q?1nYoRgarX7GvmkZgQGmpBhF78jCKOTs/Tc8xDWp8IJLCx1bS4AdjS7hjRkjA?=
 =?us-ascii?Q?J0guHYvl2AT+BpRC9zu2J5hrLhwOxkDDOcggd4u6AAt5HPjzE55BBxxld4gF?=
 =?us-ascii?Q?FXJ97nlN6Qj9bpPAz4WN0xBnyhikox9SXXPF2AwoRZD8GHQuNRjX+kNJtLFl?=
 =?us-ascii?Q?cDGRi9vnSjjRmreFHP0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:23.8110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c31705-cdd4-4f01-570f-08de0c231a67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

When a master is attached from an old domain to a new domain, it needs to
build an invalidation array to delete and add the array entries from/onto
the invalidation arrays of those two domains, passed via the to_merge and
to_unref arguments into arm_smmu_invs_merge/unref() respectively.

Since the master->num_streams might differ across masters, a memory would
have to be allocated when building an to_merge/to_unref array which might
fail with -ENOMEM.

On the other hand, an attachment to arm_smmu_blocked_domain must not fail
so it's the best to avoid any memory allocation in that path.

Pre-allocate a fixed size invalidation array for every master. This array
will be used as a scratch to fill dynamically when building a to_merge or
to_unref invs array. Sort fwspec->ids in an ascending order to fit to the
arm_smmu_invs_merge() function.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d079c66a41e94..c43b2ffef8a4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -930,6 +930,14 @@ struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_stream		*streams;
+	/*
+	 * Scratch memory for a to_merge or to_unref array to build a per-domain
+	 * invalidation array. It'll be pre-allocated with enough enries for all
+	 * possible build scenarios. It can be used by only one caller at a time
+	 * until the arm_smmu_invs_merge/unref() finishes. Must be locked by the
+	 * iommu_group mutex.
+	 */
+	struct arm_smmu_invs		*build_invs;
 	struct arm_smmu_vmaster		*vmaster; /* use smmu->streams_mutex */
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8a0c76af67b..97f52130992cd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3687,12 +3687,22 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_ids_cmp(const void *_l, const void *_r)
+{
+	const typeof_member(struct iommu_fwspec, ids[0]) *l = _l;
+	const typeof_member(struct iommu_fwspec, ids[0]) *r = _r;
+
+	return cmp_int(*l, *r);
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
 	int i;
 	int ret = 0;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+	bool ats_supported = dev_is_pci(master->dev) &&
+			     pci_ats_supported(to_pci_dev(master->dev));
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
@@ -3700,6 +3710,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	master->num_streams = fwspec->num_ids;
 
+	if (!ats_supported) {
+		/* Base case has 1 ASID entry or maximum 2 VMID entries */
+		master->build_invs = arm_smmu_invs_alloc(2);
+	} else {
+		/* Put the ids into order for sorted to_merge/to_unref arrays */
+		sort_nonatomic(fwspec->ids, fwspec->num_ids,
+			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
+		/* ATS case adds num_ids of entries, on top of the base case */
+		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
+	}
+	if (IS_ERR(master->build_invs)) {
+		kfree(master->streams);
+		return PTR_ERR(master->build_invs);
+	}
+
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
@@ -3737,6 +3762,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		for (i--; i >= 0; i--)
 			rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
+		kfree(master->build_invs);
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -3758,6 +3784,7 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
+	kfree(master->build_invs);
 }
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
-- 
2.43.0

