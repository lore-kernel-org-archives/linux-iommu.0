Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273051DF75C
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390095; cv=fail; b=oF8TgzyakiRHlWbNy7WJqdo/YDt4lb2qAe66uns8Bv0WHtdBT7vhy2AXPdV1Kn7ylxwr0OUtxZmrH1p9xyNHFYtNnu+N3c/WJ7RrrmvmKb5udEKZSlqElSproobvqiUnd8ED7oEU8/KKrIBEO/484QoTUVAgdi2OEcW3hG3aDHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390095; c=relaxed/simple;
	bh=4Txy83nghCoyzfVg9QvIU4OXo1QcNk7rF6X3/NXQcFQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0+ga2apphMQu11ySCfcy3SQvzACA19JtEZLVaYzkgEUUTCiI/3El/BzLmgHFn+QiKdmz+4LtN9OFb5XKv1wjFGJHCCLr6JfXQvXxRir/VWUQhyXoC1dACoaGmoLCr6bC9cjthCS8Si6SSokGtQs2SQ8wOldDHNhszXtfqP801c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PDBhf/Fh; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PDBhf/Fh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3jHfPrM35LKNVUImF2GfFot2PEK6e1y6rvZ7xQCZr1SQ01OB0CZ0qK5M+YUXkmfVJzdiCzx2KvsepOejK00zibRAxOg/IfBPgn0Pl7wC7A2Q0IIEh0F3N+FUGv9Jih1aV13AeTVLK05h8Qf/XoRczCZV+8nHHYg8T6YBCkduT/zEPza122EKXHX1GGr8ALkCpL8ET+/vuMKnw+MX0eZ/oEiTH+rLJVZJkd+S5ywdLTCrX0d48q73KHNd//Ngiom9Z77DoXe5jBgKdexXG+JR2ZWKYWwjIaDP3psOt2DJzRtKK+/CE59d+wowR9PLdXQ2HqETvRDfH64YOXPMcG3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh9x9zfz45UxFZ2LlNRK5IpnygHSlHvPUni+WQ06vSc=;
 b=CeGRQm/glOGUKp/W8iVyziWv7ZdsVLMlwyLIN3l05zrcIQK/Eu3Pw4DbnHOIdts1Gl0E+1iThtmfSd0gwAKCrjqv89DJrBhDj0slag5PNtvANf+KGqTbTblHy8ukhS00kVyaMXND7DP9F7hqtfP2cgMGm0ZOmTRKz11deeMfQxyr7fZqCtseW97/rtH03xGTPoCUNBHSmz4SUAPJXOT2RVYsgkK++mB1sDcBJ8IBSnoYMC8H7lOKtl6LDUalbTJ3y35+0SIHm7alABL6jx4zdYSnXsmo1XvKTZ31ETxnEgjAaWk3RYkUiXAtUswvktcbUgnL64ZkwDt5DFvtOMtsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh9x9zfz45UxFZ2LlNRK5IpnygHSlHvPUni+WQ06vSc=;
 b=PDBhf/FhKwnvH66/d1FBq5lunBn8wAXHNCza6CLuQSqrS7JdWz8vK4yax/GXeco3IwS18rmwm4d9Tv2soLb3aYbEvAnPQIioiA458sl4BAjWW1tkOA9bveTM8OQmjX/bAJrTCYpzJeitRSzkR7l9UanvP5Jh3MWNJMYYmnS078zZlUkS5aiCRdZSmHWVCXtMrcDhtGMN6lpRcdiypU5TZmbPB3d+0v5R1CLCIC2y25fD1tSMAeg2Iix8GVKJdvtYc4ztZlRmb9JMv9+z++WKkaj3ZVeop1CrlcbcvwpkBxh8h1ybvaMtB5ygweqNsFQZbpXS2rHi2bJZexYel4JjMg==
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 06:34:49 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:337:cafe::cf) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 06:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Wed, 23 Apr 2025 06:34:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 23:34:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 23:34:40 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Apr 2025 23:34:39 -0700
Date: Tue, 22 Apr 2025 23:34:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH v2 03/10] iommu/tegra241-cmdqv: Add a helper to drain
 VCMDQs
Message-ID: <aAiJ/t1xQARjzH/w@Asurada-Nvidia>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-4-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418233409.3926715-4-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: c89e8161-c017-47f7-cdc9-08dd8230f21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KvUSO25oQhslp/H8eLiQxYg53/OnWcEUMVpLePoyjysGjm1BMO4lac/GgPf?=
 =?us-ascii?Q?/bBTytkgnDUVoWRihHyFZTD/7lz5krax926rk8WonECOUoKRASwFd7mfi6Lx?=
 =?us-ascii?Q?qSLGkbHWJ2yu4bT+H3SOU1AYwibdGhw0u3P6Bb0VaKLPqlWiwt69svDJnSsN?=
 =?us-ascii?Q?f0aBvimf1VXkvT73b+t51pwHCQeyQMzpE/sHfdLbZ/e+gjIXkgXAPthO1hX/?=
 =?us-ascii?Q?2pAkwx6Biq/FSTIRoxQiGn2rsviNbWL7l2aep3vQXczN1zI4v228HlyYrLd+?=
 =?us-ascii?Q?Fec+tNv4D+XiKonzBcD2EUCBlVojtW4jHFri66GiHbPRfZ2ixRnqsdmzgcPK?=
 =?us-ascii?Q?jZjFEv3mucneZyiNM72TwCmR2bj6snpiB02khiAoTGytoYHa20s9QD0gQ10Q?=
 =?us-ascii?Q?/p0WIERHJKD78gzRbq4f26QW50bEDD2EKNUkUzk00DVXpXgIz9upzFpKO2sN?=
 =?us-ascii?Q?9WJxj84qGsbFhRJVSAnte2L/dOEJJobylm8BcNfQ1YjbmN/D9Jziq6uhF2Bm?=
 =?us-ascii?Q?GMnoMMrYFce0vcjuc1H4CSGrufH/ZlRZ2wmSYXiwM6faXN7oE/UGNm0+jtsC?=
 =?us-ascii?Q?BoBXgsx/cOY7HO4GVzBHYyx3MWaG+kQAtzlVOkMM3H1xlg7WBhjeZ1dK0xwd?=
 =?us-ascii?Q?FWZ9Ra74fgK1IEjWBgbiDteHhQ7DpJhAqILhlTNFy2WI+0VYk0sr5dGf4ENk?=
 =?us-ascii?Q?TXUSwQzriFTy8bKcBAzw/TFGWXu1ZgdpgJ3d2/Z9hYZA0DGavLj4+L/88HXJ?=
 =?us-ascii?Q?9XeH2Rbj5gPW6ZdJVZjUANNMZjsCWOdtWgtersglJTaDX5N2kctq2i30LjJC?=
 =?us-ascii?Q?mwx+Pe4bB+2Y5qSl9Wi3s4EpjkzLx77tKRdoiK/AaJfH2oBLZx1XzHixEcJ0?=
 =?us-ascii?Q?KObEUfkBcMMZVn4LpA6xviWjmT5uNQZDIYVLtZ0NIa4AE3PtjQiTnsAvg6bK?=
 =?us-ascii?Q?XJTbsQtTX1nuL3g+voseztsRr75QnrEqxdRniQExr+E7bfLpnIkkpg/w9owk?=
 =?us-ascii?Q?t7/hpPXhTQXUPd79axafRRFkBUMl6DOmJXrD/k7cbtZei4CWvpWDQj2PFIYu?=
 =?us-ascii?Q?cq9Qw3QvxwxksODplkuya3NSl/REs1zs06TWu2YuIGYajBFwsNC5TgQ9zG5N?=
 =?us-ascii?Q?Wd7woaQMEDzQcw7FX2CmrbMFwrvSnEAu9areAXhfyMXcPe1M3X/+X0bi1BDv?=
 =?us-ascii?Q?wdl+MNaSopqhR0y1fROaZMXlsCnpMUWBgHUOwCGEQS+Di3qj8mo3pSf0SsGZ?=
 =?us-ascii?Q?BN4atdzLTVP7OM7GjuRb9WZUbV0lUs6izZuSukMTBarmOibQXPTOZ5aHBXFk?=
 =?us-ascii?Q?zvWV7dxreX4OK0oxY18DBvHBRwOURHScjOJbz49HiTkJb4A+QSDFbvmdFnKp?=
 =?us-ascii?Q?n/rV4SmbVe34gbYlKw8zN40BIaCAqEkUMrbqG6sJ6WFNaWtmPBfbg0WjI9AX?=
 =?us-ascii?Q?P7S2VOcbp+/1lyeJKpevxbH4L82OrYRQKyAIk5c8oUznzm+TfRWZo/fRfUZe?=
 =?us-ascii?Q?Mp1uHFhV2CjB7+4wCsT3ZLFSGZvq6I8YFlfo?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:34:48.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89e8161-c017-47f7-cdc9-08dd8230f21e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303

On Fri, Apr 18, 2025 at 11:34:02PM +0000, Pranjal Shrivastava wrote:
> The tegra241-cmdqv driver supports vCMDQs which need to be drained
> before suspending the SMMU. The current driver implementation only uses
> VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
> helper that drains all the enabled vCMDQs under VINTF0.
> 
> Add another function ptr to arm_smmu_impl_ops to drain implementation
> specified queues and call it within `arm_smmu_drain_queues`
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Some nitpickings below. No need to reply unless you disagree :)

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 +++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +++
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 28 +++++++++++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 58bfcfb0d04c..7f70e0f4f158 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -981,8 +981,8 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  					   cmds->num, true);
>  }
>  
> -static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> -					   struct arm_smmu_queue *q)
> +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +				    struct arm_smmu_queue *q)
> @@ -965,6 +966,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
>  		       struct arm_smmu_cmdq *cmdq);
>  
> +int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
> +				    struct arm_smmu_queue *q);
> +

I'd personally prefer these to stay in the change that introduces
the function, since it knew that a following patch wants it to be
shared in the header. But either way should be fine.

>  static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  {
>  	return dev_iommu_fwspec_get(master->dev)->flags &
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index dd7d030d2e89..767275e10d43 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -349,6 +349,33 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
>  	return &vcmdq->cmdq;
>  }
>  
> +static int tegra241_cmdqv_drain_hyp_vcmdqs(struct arm_smmu_device *smmu)

tegra241_cmdqv_drain_vintf0_lvcmdqs

> +{
> +	struct tegra241_cmdqv *cmdqv =
> +		container_of(smmu, struct tegra241_cmdqv, smmu);
> +	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
> +	struct tegra241_vcmdq *vcmdq;

Let's move into the for loop.

> +	int ret = 0;
> +	u16 i;

u16 lidx;

> +
> +	/* Kernel only uses VINTF0 return if it's disabled */

	/* Kernel only uses VINTF0. Return if it's disabled */

> +	if (!READ_ONCE(vintf->enabled))
> +		return 0;
> +
> +	for (i = 0; i < cmdqv->num_lvcmdqs_per_vintf; i++) {
> +		vcmdq = vintf->lvcmdqs[i];

	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[i];
