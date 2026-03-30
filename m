Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB940DFCD
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867648; cv=fail; b=CZLlWNOaDc8Rhru74zZByfs4Y8Ok8/4tfF5HC3aNtqjqnr7gyfysJjP3a6YOPvFnjx0Fvzvzo8hDLiHz1p488P5uVEAvjlsQc2uS/zAH2GWlnYc3PlAE/1uCpW5Zl8/l/p7IufTRIR9CMU+cDvzW1+VCDBxD1P/oX7l2laSbCag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867648; c=relaxed/simple;
	bh=LSnhw6XhoHp2K871sq7ObZbmnmPq1R23kxTU7yhgl5k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYMjBWGTz4paBAm1A4S5RLIgqFIw9IaTwppD0TnTMCX2RN4c/0KlUyvUVgD3R+FuXzpfjpcTw3i3V9F1V+S2QO/+8ccPWwwb1inf9tNY0BjSX+aIlsk1aZWDH4LeDymIp2hK4w9/0f5/R9M6HkGWjWfQKIhlLbbUoqANIBpEa24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rovLEpFR; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rovLEpFR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uND7OlWXHrOZwwHp12cudniGHrUgsuVPVAVAM/9yMhULsYT2hL9oLOZpe0KF0S8wnMkkLp+k056oNZ60dcZtuqJPqGHMh1hDwNs14xe5VBo1mkDAYPJnn68IrulO5wTDwa4HNgju42R8sAUJvqdjL1+SvbIhZySfqx/URiBzZ8wtV1LzpaqYBoPJBWB/rqeDZ3nqmSBicgUINcO7Dh6+mRUPJY8lBa4Ebmkb9P2CDSBmElF7ySbWxfd7aWvy+afesZLf+XayDiVHbTpQTZsilIh70cVS+bx6Csbg4bTFM9dDq+QjQMuMHyNHXVHiij3tfyBq3fyTTM+y0fibns4DuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h5FbUNt4OiMypeOvTGHHHYhHz2eJ5Zgij310kztqyI=;
 b=bfR+bqCHRT0J4BI68sSQUW0TYVk9ntINKyuDZy7m9PePMn/D/3zWIIZJMlDOLh0iJkR2vcDY6VmzdepplKvsVVVTxFS3px9npDPSLhk84v108SKZjEcHh3/Z3mm/kPio6AIMrjgrhNsrgUkp4TwQwpeaKlZfl0taf/BfkeIZVWgjCn8prUZDyktB2Lu6Gl0NDEvUOsBbghpkgtO/Fskvsd4W41wbFT+xb17R+AeI6E3zzL1jtMxLX0dLlfOzi8BbB5XGkBZ4oSFW+gkQ12YLT7npS/BIA146Ifdq9azUnF69JE+Sso9gLecRRdCSCNaIx7wOQb3c2qUnk3rIrjQS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h5FbUNt4OiMypeOvTGHHHYhHz2eJ5Zgij310kztqyI=;
 b=rovLEpFRBR3MIiHXF0KbrfRktO77Wzr7iN3uzzy1WqYUfV8ZWox08oG4GggnROYt//Ib0qUsR5aQCoScK9H8pjPA0MTGeQK6zbUmJQPf81XrRu14dfEpb8aA4kVF5ERtyGA+8AwF5DPJAh4x5bbxriAi6iMHHQ02i6PNDEDGj/CUhlBTcxVPXiGZDA3Jw9ey3OBcBSS6LPdZ7VkRWSlGbNHCSRyVpaNGxlxwPgGJfSJX6sJQPCckZvLvEkA0rC4nN4kAdwCeO+44s4yD2cm+P3Z84IQk/TI+z3HcKlm0UekCZZBeJ8OA06ROUFYd4Vi54lvQqjl07Gdv7UM8R5tGIw==
Received: from PH7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::21)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 10:47:22 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::ed) by PH7P222CA0002.outlook.office365.com
 (2603:10b6:510:33a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 10:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 10:47:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 03:47:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 03:47:02 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 03:47:00 -0700
Date: Mon, 30 Mar 2026 03:46:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v2 1/5] iommu/arm-smmu-v3: Add basic debugfs framework
Message-ID: <acpUoZ7wx9gdT5BG@nvidia.com>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260328101706.3448655-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260328101706.3448655-2-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4184ce-ac3a-415c-41ff-08de8e49b883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	E+E0KZ/cd418KfUcMGQyaSHuozK9v3i7bBbcBw3kJ3XHqK05m/nFn8VOo2aeTjUpNfwh1A5KqXkLtIqEASOpSVkbNF4JaMgyOpQ68xZJGERXJVT7ctLlvvu3QKBy7Gku2REcORwOD1uHlziH4y87SpYR63sh+V1ms4JIsfUDiW4K0Z3mSOz04lmjGj11QBOTyP2LoBndY9vFkn35vXyoNL9onQeDaTQWHOoMmZE8GqJaBXW6xl9USfPVml7L5lIo3ZMcEaJxn6H8t10VkX9W1JL1xG/dvYHFxujeRWd9H6/tiRpxNA0Gyinuz1sWNCqR8rpvUy6BPxKipNMXWhgP1u6uWTBcTontwUFLJrLfZw+beJahwr1PCLEqTXpoL1Uu1dAFUltvCQIzzLvwPvhV7qBFr/qd2IMBwznIslC/opsN4M0Fw9l5jOX7Bn+dgFB+vfpQGYhgzkgv83ZzyMrbTrdV+zhxYgQtcpaqCGzdt/+CfjM/uLayly4rg7Cs/e7MKj44gmzLp06d0L2PEl6DXw5V6SyrvI2sQZ+QVsCCecAfRUpfEl3fUqz14wCxR7GNcCW9tjUXwSA/yaItv7k/dM4XezeDz7rhZuM80iJPznpmWt3TkaD8dLvFRwljoEKORFCpzUg/wWuPnOB/befVN/qJFtpCeUPb35ijrdE9yeC5B2xOsF5y7oK272tw7us6Vob1Q+njxPNOKeR9jlF9vPgQqPO03/0sokUBteyI+zfERmAC9iLzRMBqvZM22h9omeTmikI2hlF+l3jK8C8rOA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hvwnPc2Aq+Xzr2kFY4HKqlc7txQMrPEgpIS/typOwG7kyIFhF4ThcU/jYmtVT7jQSK9oIDLRZd8OoyKOO1CNen9nE8Bo1k+jKVK78exhFaGG5ovg3WQ/M8x51rCskwDl2MITy9qPIiyzTNYTQO/aPfoWxVYshPX0VZPK6fvnO3B4d3jMl6d6wHKMfaN9Mawj4R0eAu4gBx1AnLDnjPDV1+0MjjYpFLeaD8Bpaf63ytR+aeteb8NnBHoUHA8sbCDGDs9dDZfSetAXWwhbrOlzHAzxFf9B7MWEhcotP6cif28RzFzTPxPwTem9+JKJxMBFG5I3T9gi2hz8cCPLt89Am+Z+hbTQe53GkNaBhcE8tDj1lS+HnsKHuyiZTBhpY32XE+zm6xQOvXnDS323eD4z7Yc3QEoad5rVZCRVNJsb8GsAyw7sv9IlTx6MF6N5kgbA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:47:21.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4184ce-ac3a-415c-41ff-08de8e49b883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

On Sat, Mar 28, 2026 at 06:17:02PM +0800, Qinxin Xia wrote:
> Add basic debugfs framework for ARM SMMUv3 driver.This creates the

Needs a space after "."

> +static int smmu_debugfs_capabilities_show(struct seq_file *seq, void *unused)
> +{
> +	struct arm_smmu_device *smmu = seq->private;
> +
> +	if (!smmu) {
> +		seq_puts(seq, "SMMU not available\n");
> +		return 0;
> +	}
> +
> +	seq_puts(seq, "SMMUv3 Capabilities:\n");
> +	seq_printf(seq, "  Stage1 Translation: %s\n",
> +		   smmu->features & ARM_SMMU_FEAT_TRANS_S1 ? "Yes" : "No");
> +	seq_printf(seq, "  Stage2 Translation: %s\n",
> +		   smmu->features & ARM_SMMU_FEAT_TRANS_S2 ? "Yes" : "No");
> +	seq_printf(seq, "  Coherent Walk: %s\n",
> +		   smmu->features & ARM_SMMU_FEAT_COHERENCY ? "Yes" : "No");
> +	seq_printf(seq, "  ATS Support: %s\n",
> +		   smmu->features & ARM_SMMU_FEAT_ATS ? "Yes" : "No");
> +	seq_printf(seq, "  PRI Support: %s\n",
> +		   smmu->features & ARM_SMMU_FEAT_PRI ? "Yes" : "No");
> +	seq_printf(seq, "  Stream Table Size: %d\n", 1 << smmu->sid_bits);
> +	seq_printf(seq, "  Command Queue Depth: %d\n",
> +		   1 << smmu->cmdq.q.llq.max_n_shift);
> +	seq_printf(seq, "  Event Queue Depth: %d\n",
> +		   1 << smmu->evtq.q.llq.max_n_shift);

Nit: should we do all sizes or all depths? Any good reason to mix
them here?

> +/**
> + * arm_smmu_debugfs_remove() - Clean up debugfs entries for an SMMU device
> + * @smmu: SMMU device
> + *
> + * This function removes the debugfs directories created by setup.
> + */
> +void arm_smmu_debugfs_remove(struct arm_smmu_device *smmu)
> +{
> +	struct arm_smmu_debugfs *debugfs;
> +
> +	scoped_guard(mutex, &arm_smmu_debugfs_lock) {

It could be just normal guard().

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f078..cbb3fccc501b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4904,6 +4904,15 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Check for RMRs and install bypass STEs if any */
>  	arm_smmu_rmr_install_bypass_ste(smmu);
>  
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +	char name[32];

This could be moved to the top, as iommu_device_sysfs_add() can use
it, whether CONFIG_ARM_SMMU_V3_DEBUGFS=y or =n.

> +	snprintf(name, sizeof(name), "smmu3.%pa", &ioaddr);

And this could be moved after ioaddr gets a copy from res->start.

>  
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +struct arm_smmu_debugfs {
> +	struct dentry			*smmu_dir;

A personal preference: for new structures, maybe drop those tabs?

>  /* An SMMUv3 instance */
>  struct arm_smmu_device {
>  	struct device			*dev;
> @@ -803,6 +813,11 @@ struct arm_smmu_device {
>  
>  	struct rb_root			streams;
>  	struct mutex			streams_mutex;
> +
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +	/* DebugFS Info */

Doesn't seem very useful. I'd drop it.

> +	struct arm_smmu_debugfs		*debugfs;
> +#endif
 
Nicolin
