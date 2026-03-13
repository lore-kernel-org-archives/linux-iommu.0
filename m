Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B5346AD6
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773434716; cv=fail; b=ZmlDr0q47gwvwZg/1XI2z5eC1Yaolfsn57FpQYhMVx/AkqxLosb1ByyVOm7pnbojXlybwjPe8kNDqSwPMSmkiHu3CPDi2dcx4qnp/phOMWpgPWRvJRj9oa5S7AdY4Zcvu9/TV7+VE1a+hekx3xo5Pqr3rxHMGkg6ucr0UFNX5H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773434716; c=relaxed/simple;
	bh=qgYByZwEO9xkCCrvfQuwfuo+ZC/PEVGdvDpdyCJla+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alRhUfPL9rU7KJO7QCs08uK40Vr+B6WjEPSyUb+qUQxUXb2T2Y4zqSPkvqN30uk8mPAvkO74pCu6FjFokzYpYIF4/N6g3SAyfgVuJNalNX50rYrkyU70lwoVUrSFQ7Gll3RzRDT1gqxP3fIPSCX4NI/sDDcuratASOa/gmxTUV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkimT49/; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkimT49/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZto430og0LERkkaLKtqqj3ejZ6PZPDrU2/7fpy91L9RMI2SRVjJ4LvhKEBFsVWv55GJcACsIpBO6kXowqJlicz2bV74nI72vvBoxZjK5MveddnoeX7lA08qIuR94EgxSejjYEwpXgOagZ0AXL7Yrh2iikMQxiszgOZC9blZi2x+Z0/fyN+uZmDyAM5EuaUnj+0xNhCho9cf7YiVvxYRBHdyULtnfVS2G5gXubMcQ6g4BTH8ylOTf6Q46mx85uRNmABPk6o8cDES623S9wuHtIi1v9LWwqJzpn/eqW2+ExEKsRdgVWlgt/y29HtFVDeVxQtCCSysFlh4mInEbwmRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiTrzHfNzisjeTI7jObopTIrsjTCjB2myW4oJP7pUfc=;
 b=YQRfE8wg3b85GObAuHFVoor5GyVJyhfCggpUg7rQk0qc5zljzBfkk+yTjD5HobfNOkI0u72GjdAP2uriUl9rMbmZzaniRvrtNKf6+0Xtfzz1yjrn8Dn5H1OwiLXcLNJ4ikpxqJuYAWLi2GmnXUrNWrN4t3dZkG3S1vLsD4a7HByg/xIPz9J53wyFs9xmZyc0/aBffDTNh+JvWgJuwUEsy4xjqazoOiFhlUKH2Ra9whsJhxBXMfQTfIoxMQFccYD5FxDvsOMq6w0+Z9fPLEs2yInkdJojKHLZVkKL4wJo8TvaMksmOlx5eG4P3ndQ/+w+3cjGDvndSFuK3CMr2oG1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiTrzHfNzisjeTI7jObopTIrsjTCjB2myW4oJP7pUfc=;
 b=VkimT49/8NIpDYfIG03UthnwT1RYhzGdr4GO66SRqp6b68GW3nBPvpLaonhPpgiuWEppy+Ucd4RkwYaZzbY/dfrne+E/naLEp+czi5B2k5L1wyQJriCeqKkwhHci/z16HQukwF1ilBJBeYCVRZdNvOiF++RN/yCpag7DriUwStVObhBZbHxI/1VF7gID5bQr8RhGMr9ffTezz2k/jqLJJHzJipp9MHV0FXt7LkcM2FCVEPl5fw+hvkXgdgugr5UkrOC0PGygpDG3CRggOIe+Qz9BTWOzfN+gEiy82nXXq7tXblap4yxFLdyxu3KGiE1b1tKXu35Mi5zcidrceebN9w==
Received: from CH2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:610:51::22)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 20:45:08 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::1c) by CH2PR15CA0012.outlook.office365.com
 (2603:10b6:610:51::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 20:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 20:45:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 13:44:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Mar 2026 13:44:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 13:44:51 -0700
Date: Fri, 13 Mar 2026 13:44:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 4/5] iommu/arm-smmu-v3: Add stream table directory
 structure to debugfs
Message-ID: <abR3QXHGAWz9E6qV@Asurada-Nvidia>
References: <20260313104351.3502293-1-xiaqinxin@huawei.com>
 <20260313104351.3502293-5-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260313104351.3502293-5-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de353c8-753a-4150-36eb-08de81416969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ySgkYKmTrse8mHIMrsHOrONFe1xpUASOYlkxU9xPzDiVtH+hzwNBe1/ddrwCiwpbwfEp135XeedgElGwrxEzLcITQ2EV1FAWEUP1aNKFkjV+h2al+Z2csWwvIb12EB3RVd5nAnFFN7ZIuKCjvRw1ak2dgJa0anDr9f1u0WwWGrKMorZ2QO7dbpId8GflzhPreLxzUSoFRKgBVar4XRzDDUuXWgA9/vnXiTwPq+JQ90ZELSQiUIJCmPcXHY/YaPNnRVG/PBQhZoUAUN+DusP69PVrmG22kkkyPnql0DYzkZAFkMZvZidpm6+d1QWgkzfl/KUN6J/my35Vx+r2aJ7MEi+HyCzisswwZZeL7lwnN9XeEa/FmAHuQ8DtQxhT3YWipkhkBKuMaQgPoGpGwhhofTPYHI4PKgaENjKpJ1tkMdPMEb7Ht54NtQw/1qH4IylU6ITlQDLXnxkkzZme9UXzFUYBJuiWq7JXEc4zivFoi/VFWttKocYwbI9C8DVl51devZFG5OoL/PXs4x7b6usM8lCsqVZXnc2fB+W4/7/aeHRtEvRIJLbB5aXJJufUFst1SOLbWd4ye7D197/JAv21UvfsopP6jwnnet99C9e5fMSSuLddEFUZgmLVVz+1BCNPIvtTVmO3uiLPANevdimOrajkaDMx+l4ApBiRnMu7s2Xdg+K/Wjol66UDPxc/3dVnL+cblYv0ei5COXpmX9NUilBy67nunwXQ/EeXP9Jcocqgs9JNc9cNtpFzIV8KoHVaMKpG4ekJRPkGPEY2ZouRPw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BcbF0tncia3Vi6fXsKYh5YsjD4eW87PPYNawIuc+C7PqMoyMECsigNqVEQH9ZuRRNkAcrtna8tEKTKl9kfW7eUGjbQyw35A5DWO2O2f3H8sOHRUKT0nChUAAuqkHSIOVlSaui5qbvoCdqIEaoKAp81SNIpeNQ5N63u4vhtf/d1kbz4GEGQ8c1Vu2TXUgHKulVDoFN7Y7f6AVVHna/4Rg63usSMVXIN1iLzSxmXkJhAZWKBP+zh8qFCYXCG7+I9TIj/lvdb9qw4+DoIHYaeHM9kVijYDrF5U2fX75imgi2j/VFYqHwBQKHeuU4TxusKQeR/pe+W6zyIGvLajqEQSdza0YLmefHMCmR6e4PxAERILLhgy8tGZIosVGOPrJ3oOgesVmOCNTu5IzQo4KLAEiDsWFkD1/LR2CUU6I10TP6NP8ByR4BL+zjAu0Sx+PwhZw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 20:45:07.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de353c8-753a-4150-36eb-08de81416969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

On Fri, Mar 13, 2026 at 06:43:50PM +0800, Qinxin Xia wrote:
>   * The capabilities file provides detailed information about:
>   * - Architecture version and translation stage support (Stage1/Stage2)
> @@ -324,5 +327,78 @@ static int smmu_debugfs_ste_show(struct seq_file *seq, void *v)
>  	smmu_debug_dump_ste(seq, dev);
>  	return 0;
>  }
> -
>  DEFINE_SHOW_ATTRIBUTE(smmu_debugfs_ste);

nit: let's not add that line in the first place

> +
> +/**
> + * smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
> + * @dev: device to create entries for
> + * @smmu: SMMU device
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int smmu_debugfs_create_stream_table(struct device *dev,
> +				     struct arm_smmu_device *smmu)
> +{
> +	struct dentry *stream_dir, *cd_dir, *dev_dir;
> +	struct dentry *ste_file, *all_cds_file;
> +	struct iommu_fwspec *fwspec;
> +	char name[64];
> +	int i, ret = 0;
> +
> +	if (!smmu->debugfs->stream_dir) {
> +		stream_dir = debugfs_create_dir("stream_table",
> +						smmu->debugfs->smmu_dir);
> +		if (!stream_dir)
> +			return -ENOMEM;
> +		smmu->debugfs->stream_dir = stream_dir;
> +	} else {
> +		stream_dir = smmu->debugfs->stream_dir;
> +	}
> +
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (!fwspec)
> +		return -ENODEV;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		u32 sid = fwspec->ids[i];
> +
> +		if (dev_is_pci(dev)) {
> +			struct pci_dev *pdev = to_pci_dev(dev);
> +
> +			snprintf(name, sizeof(name), "%04x:%02x:%02x.%d:%u",
> +				 pci_domain_nr(pdev->bus), pdev->bus->number,
> +				 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn),
> +				 sid);

Doesn't dev_name(dev) print the BDF numbers as well?

> +		} else {
> +			snprintf(name, sizeof(name), "%s:%u", dev_name(dev),
> +				 sid);
> +		}
> +
> +		dev_dir = debugfs_create_dir(name, stream_dir);
> +		if (!dev_dir) {
> +			ret = -ENOMEM;
> +			goto cleanup;
> +		}

A device can have multiple streams. So, dev_dir should be the
parent directory?

> +
> +		/* Success for this stream ID, continue to next */
> +		continue;
> +
> +cleanup_dev:
> +		debugfs_remove_recursive(dev_dir);
> +cleanup:
> +		if (ret) {
> +			debugfs_remove_recursive(stream_dir);

One is the other's parent directory. So it should be good enough
with a single debugfs_remove_recursive()?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 211a0c87507a..c57897e5f644 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3133,6 +3133,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>  
>  	arm_smmu_attach_commit(&state);
>  	mutex_unlock(&arm_smmu_asid_lock);
> +#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +	smmu_debugfs_create_stream_table(dev, smmu);
> +#endif

Calling in attach_dev doesn't seem correct to me. And device/master
can be unplugged. So, we would need to unwind those dev/stream_dir.

Maybe probe_device/release_device are the places to go?

Nicolin
