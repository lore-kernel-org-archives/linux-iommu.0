Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CD3DD507
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431952; cv=fail; b=ZlgvmHc23StJwzGxZJrPxfOKmijxDe+ajkrrsQdwJEtupeoH1oVUVLsWubw+QeAdpTvS/aZYfmXBrG+KWRwRPYKZvDOGCcvNUGMaSqHTHZCxfbGgVyjEybZxsK3HWnLn/bLlsSj35kI2yPS+QJ/7yDnsnfQ4XbDc8lrwQxsE/3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431952; c=relaxed/simple;
	bh=OGrZSA0aFg8f7uitP34zPTnpNRR4SRngm6NpoKbAPlY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFYSaQrEDa4DEslIy1vw6F4+GZmkRPQc+i2BJmUcomVw0mG/5A/Sc2EkcAHI8Ke8+lTScYDW/2/NcrDtWkWJxkz2yW7+jctrnW47Bcqy852fVzCTWXKyDi+xXnzXHKpLYPhS9LKgrHJqBDKyJrvhofktaIKjcrbj9B577s1P9qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VeabhZ85; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VeabhZ85"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka9+TiKGY6xNt/yUUQmdqIbfEUFRJVyN0YWzpx43aKb9aR91+GdK4GOKHBG15La8pA/VdgPPb94ohnCgoPyFz3MScBBQjgGUwlfaQsZTorzw3F88eJdiHwc07fds5JnA9ywsE/sEjWyxEUyY4cq2vGqglnF8DZ53sFIGtcbmChg0HS2e1b8jYz7WK3R8rqVOVk94s8w0sw3dVS71TlkyXSblUiDx0flA3EbwY+pcm3kciugySSr+oEjlUejYkBj6WaQq2OUF3scFOB1lDtCmdsE/X/B9XFotkfLdkBcekpYylSE66CmB3k2M9zLjvVIm3j5cNmXi0v0OFjt/7wW/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRzrZeQH5rO5VFXhIYBZ8uXWlUGvc/UkH3tOrEvngSA=;
 b=ExX+qB+Vyude8+tZ/jq+4i+33NPXMEAUMkv9h0W4xsKE/Z4lRuTGU1/OZg9qSqxaNntNTEJXmWrXD45w2Pys/gqsmsKVr6JWzIQKLFUw7jc8OH+XxWFR2f/yO43NFFwg75byK2ae92o2Mc5RTBtw1AieZxxF0tEg/AUfBEjiBuQ6IY1aZGStidTxoxLtHsDfPFWNYtDVDB7gyoCpQiwxIsB1ELyq/mVMzfb236OXrvFaxj6YHqNaJdjZa/GnUkd1uGIx+0vMo8gbceaomWfx92DZAX4RKYTxijkTO7DnQSDNg3BKPPhUioWi+2sQdD1AZbNlehgOREuAP88T2mASiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRzrZeQH5rO5VFXhIYBZ8uXWlUGvc/UkH3tOrEvngSA=;
 b=VeabhZ85VrtOTvFgRDaWOnYEI/ouNDDo7g2bQElHwWdiwN3TATDr8uTl8WMupW3w04KmmDMjZyBRNmusslcszQ14FyVnVhq3fxyHoUAFVLxRTgPr1HX5rWTq72dmZrVLifkHaMS7rZTESTm4ZqufzDb0I43D5iLqJ8LDRzqr9p58Z7E+j8cbfTVPrScoiNHczNkAla3CvHLfARkw/m9bs+ehmLFaIt4nUjBNDKV9Hmp8Ov7xBKDDdiCdSD0X+T9OA8vb8zX3MhJQrGtyf6hxMhl/0afklL+7Dg1fRE5O3IJSCByJ1gJEx3VonGF2EriNEe3DtQSGL+vI+bXq6nnjcw==
Received: from SJ0PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:33f::27)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 19:59:04 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ec) by SJ0PR05CA0052.outlook.office365.com
 (2603:10b6:a03:33f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 19:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 19:59:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 12:58:46 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 12:58:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 12:58:45 -0700
Date: Fri, 13 Mar 2026 12:58:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Add basic debugfs framework
Message-ID: <abRsdCYapDe16GtJ@Asurada-Nvidia>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313104351.3502293-2-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e532ffc-8c7a-4378-52b0-08de813af9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m/gAQkWQM4oXsrI4kAmHzFRjK/KjQ+I4wc0p0Saq7JF7zEXNwHa2uv1MnGcI3Eo9000NERomKfQ8hs3hPZCYOB9gwNRBkJcBP88CvYI7CwOCwgEndIQ3gR/d/Qrwfpc9veUv9pjvrFkVZ+Q9ymVjzEhIMDLyoW3MZo/btokhETWD40xTFL7PtQYs1G+PhXDyjcHNUTt4V4srD3GPz7F0Ad8BvQ4ibrIvvJt+sdSf/d82Sz4KFqcTLXtXJ/dPqSeTHo1+SWLt5YgozHvHMZs/VQqSXC3BaYg8r4NT1Gif67gEno1W2xmbVptHzjHVYsgxD+KoPuL0VBYV2hXNo6MthpJpiSnxU2ZagLeYkzPxpZQ5eyyU2kHN7c4SQQdL4ooQCM/YHwNscIrz6HN1vUh9Cn+W2Y4d3BtU8O2bnUIauzwhBFEqbYWmvRK+57xpFflUlIo7qucCjx+0h+54dTOmR1lgpVF3RpixoX6I4sd3QN1eqLEbKq172UPb6qbE8DQF7ho8T3lYY9ggFswNlBuPu432leZEGKFT9NqoV3eOi0r0Dr0S4MekMGgQn5bdwans49u3d/nKQYcZDxM6lVwO08Sd8kF11uEuWtIiH8D2/PbdCpvDLfuB7tkYkosqo4/1KIlyQCaBMtp+dIJrYnCOPaDfhbOzInTlmL/zOY3BQhYNphjJmiytIUN9u+YmiRwr7qrUb68bMD/uUOKXzfWUMZ0g7XN+dEBaeVJZ+taOKXJI4r479u+NZep7m/JeJJ3viyU/0ADJpPFna1IF1K8Hiw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3GPGOyZQLgQaKh9jraixyWuLwPyhkaoQhr0UkhAh5QbCs6Jvwa3ZrgYYa3ZyR5CRcn1aWxtXrvpwEKQKwHsLx5MWV+/wWMdMZlGdEhaQqgH9Bh5NJ6Wo2PEq8N46i24HMmz8mOu7tMohjmBltn6rgIjKzX/Xkns9esSjepufVw+ZCDZqnQz19Q8HTfsKGzhQVz7D6J7Rxbh02DQn9j3SIKZxCl1gzRbzY8xOYDEEmwFX9zQftlIrCrAqtUFOLA/nN+teM7xYwOEgLezEwu117Ry5JGkqTZPz+ZnaoJWiV33PbZsi4av4T3CvlS7hJO0+jyADcLomXeWpbaXsX6jm7y5kkKRP+gvU02efIdh8wrzazaeOWpPUQ4NZB+4we5VOBiGW3SmeZfce4mATxiYlqUBUpfMMge94CAXUy4suduwczQK2Q0aMxAc/kSDTCuzV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 19:59:03.0519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e532ffc-8c7a-4378-52b0-08de813af9b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

On Fri, Mar 13, 2026 at 06:43:47PM +0800, Qinxin Xia wrote:
> +/**
> + * smmu_debugfs_capabilities_show() - Display SMMU capabilities
> + * @seq: seq_file to write to
> + * @v: private data (SMMU device)

@v is not used

> +
> +/**
> + * arm_smmu_debugfs_setup() - Initialize debugfs for SMMU device
> + * @smmu: SMMU device to setup debugfs for
> + * @ioaddr: Physical base address of the SMMU device registers
> + *
> + * This function creates the basic debugfs directory structure for a SMMU device.

nit: an SMMU

Or maybe simply "@smmu"

> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int arm_smmu_debugfs_setup(struct arm_smmu_device *smmu, phys_addr_t ioaddr)
> +{
> +	struct arm_smmu_debugfs *debugfs;
> +	struct dentry *smmu_dir;
> +	char name[32];
> +	int ret;
> +
> +	/* Create root directory if it doesn't exist */
> +	mutex_lock(&arm_smmu_debugfs_lock);
> +	if (!smmuv3_root_dir) {
> +		smmuv3_root_dir = debugfs_create_dir("arm_smmu_v3",
> +						     iommu_debugfs_dir);
> +		if (!smmuv3_root_dir) {
> +			mutex_unlock(&arm_smmu_debugfs_lock);
> +			return -ENOMEM;
> +		}
> +	}
> +	mutex_unlock(&arm_smmu_debugfs_lock);
> +
> +	/* Allocate debugfs structure */
> +	debugfs = kzalloc(sizeof(*debugfs), GFP_KERNEL);

kzalloc_obj(*debugfs)

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f078..211a0c87507a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -33,6 +33,10 @@
>  #include "arm-smmu-v3.h"
>  #include "../../dma-iommu.h"
>  
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +static unsigned int arm_smmu_present;
> +#endif

Unused

> @@ -4909,6 +4913,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_disable;
>  
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +	ret = arm_smmu_debugfs_setup(smmu, ioaddr);
> +	if (ret)
> +		dev_warn(dev, "Failed to create debugfs!\n");
> +#endif
> +
>  	/* And we're up. Go go go! */
>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>  				     "smmu3.%pa", &ioaddr);

Since name is all we wanted, maybe follow iommu_device_sysfs_add()
by passing in: 
   "const char *name, ..." instead of "phys_addr_t ioaddr"

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3c6d65d36164..247f27426f6b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -733,6 +733,15 @@ struct arm_smmu_impl_ops {
>  			  const struct iommu_user_data *user_data);
>  };
>  
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +struct arm_smmu_debugfs {
> +	struct dentry *root_dir;

Unused

> +	struct dentry *smmu_dir;
> +	struct arm_smmu_device *smmu;

Unused

Nicolin
