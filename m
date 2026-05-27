Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129242F28EA
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848346; cv=fail; b=UJUu3LPnmtJm+q+iE31jW74/iBIPHvNxrdfJHrN0yJh1ExFZWRdEz+kiSVUAONgXgyEGg7QZygM8378ct8DlI55e18GNVTrsQj2xfsfI8jg3pBXXxrHzkctqaMJTQf83UiiQgVUL/VIJKYTOKTj/NVOVe7v/gk+Nl2casTRvW9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848346; c=relaxed/simple;
	bh=2eBpqc5fxhIXXih8FIB2viJJPeMkOe5Z+V/zFJRZKUk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptdU8PofdDRfU+2hMbRPevHcc8Yil7L2ACXuDf+sx/pHoo9jAwbP0SF3TdyOj+R9Y5nCkOkATvNHNrIcaEOWeL0B3jPoQkaFvJBrk0RiucQdY1BDCgFmIkB7nMxQCd8QIW1pvga3a4IiyVcbOvr/XHxcG649rmTJyA6v6fyxEnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ceuJSkd2; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ceuJSkd2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNHLbommL04hW5/Py3mmCkNvxnZzWGt2DSAHhFGABQ+m6VtuC9Gkf+i6UouKli3TqwfSiCBA7d8ll5Ehn7hszExyYnsRDc2HiL2wlGS/B5mYlqdsNhNgRw9BYAtbtpcSmfyq3mQ6ikpNGgvuubbPaLwBrW9xxZ4fCg9D83TjguDMEgVvs5v3cdc0Eqlp8AUosybU3PtoiIjwKMLzVdvHqPgg7FZUc1CkOqG837mtMoIZAnt/1czjzxdKHWOsORppjzeLgEalm4qtT8Myx/sMQHhxUE/D5rxIS6ltF/LMa4N/9xonoBv+42ee25PpKjXvsJ57kiBv5jWu5gEGPo1XAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSF/O7MmBX2yDC5yMAyIl7IiPpDSBQSIG7WtN1niwFo=;
 b=C9YzV2rh32jLuMXJIA/AVnxmPSP0EdTgAGAOFaTOT/iXI6/nf3h8SCnenfYB+Ia3GlLhAdhnXptXyid7qyPKxh03nyHn0X43HR6KVGcMb7ihpuikfOIV1ixuvXXfKp6o1rpmIdKYfdYQQf2pG6mDt8tfBvklWQlglsPCnRPhj1uyr1fBTEezI6RonT6prYm4rVshipHlgNWs0UL8JRjQ8AQglv9NlpuzktD1CQHrUtBNmhfeUEXYgVimgXrTn4byGOqJ3NqETONxvQVwuLrhRzFlvP3aOut4SBTHnUFosHKtQ/urcyAxqqbCRqZGPTN+6iRGLhvDWfnHS2hXRZoZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSF/O7MmBX2yDC5yMAyIl7IiPpDSBQSIG7WtN1niwFo=;
 b=ceuJSkd2bFDdN8k4rtx0WVxjqsYXWtvRN9Mq2P51dtppPOgUK3qs+koruzbd/8ml2+N+09nc3JSwAX15CmnT483uWGINgZ7oHpew8L9tenmV2pzUwOwheHuMtxHCDg3cw4Rpmh1l5+HHYO2f9a49unLK64e4SJE4izik4hRZCjAL0SLyRcUPTMxCgYMVM2iBVjaAUZ9gxO5CreCqXmcnw6Rb9jjqnlaOsPB7n3Jw8ap5kdzzD5s5gWmh0YMv1J68TPZ/ROHBPj3lLUk5XC08tGpPN7ziyN+QM5s00C3fjuhQpBfYWhwxjZ6TKDqx0pJZEpdufTuSKSE8POOxYP76bQ==
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 02:19:00 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::40) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Wed, 27
 May 2026 02:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 02:18:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 19:18:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 26 May 2026 19:18:56 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 26 May 2026 19:18:55 -0700
Date: Tue, 26 May 2026 19:18:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <jpb@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<wangzhou1@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>,
	<wuyifan50@huawei.com>, <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] iommu/arm-smmu-v3: Add Stream Table Entry display to
 debugfs
Message-ID: <ahZUjmpkB8puCNds@Asurada-Nvidia>
References: <20260328101706.3448655-1-xiaqinxin@huawei.com>
 <20260520063714.2440584-3-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520063714.2440584-3-xiaqinxin@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 0110b3f7-6cf1-4850-7907-08debb964f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	i/kwNvAYLWwSacVXX1PwNcTYwgU3dZZ2XXF10TWWeOj7/hUnZ13kbk5Aofy7/zinr6vwH5zGKEKLBeRA28qCGrBIcoiM8B6m9/Uvyso5sCIeXAJKPEcqes8V6qimlgmlSN7E6MA3Ln7wQZTasp1lGg7+5nXBrofd/mBgK+XEjkpp9wQ+MBJVeAekOk2zc39YLsyeA3aeXwyK+9EReeLwWDO66adRRI+ZCFHdCCglBbz0NNy1RvoZPs1vOSbQvEpYOh/ysS3PFs43q0efw98EEvVzsfCsRe4koFmMpCNnYETXlh8Ui/zcbfGB7dj8PcdXJBOesWfQ6tupgFwhld1DMnCwZv53yo/ait//a61YJNOW9UVwlT/IE1wf15FNs8HaVb8nFnJnFVNrfWS1EL+r9oOW9ztRTWgXbuiS2SOSfnl3ZnQX5aHtlrvwBra5Qt6OE2+0NUwCNc2C3nMPeCqDa8Ll9hvR9Ej0jVfdoQz3648Lct4zAjplRZ2Vvta4UAQnMBxrEGBNZWptr3f7yfHukG7Dbz0H+f3V1vBLKHHmed9934L9zFiQyLpBDTLgQoB14BrBFiLnZjTK5OiVc9buvUcYgK0Od4aPTi31dGS/NcYCeSsAkj/jNcyi9dD0qdBySph1bi/j2lKFor/Ay8VsYQv0tTfEQdXtwWiis5erA5C1J2JKotvZYZStaVkqIdkhCgrtBTgSpVqS+uQn4e40U/NulRrhAEpFhHt9shfsKdI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mYjiulMYrlEezHOR824Xd4M4va7RvxUnHhT0yg1APf3N0wXJLPsNlL/pBeajmO9vqotznCfRn4W9Hxv5tVYRZYSlOYeYKzyDvOhc1ctJxLkVmlB/W6oAEipXoOcJw7mRefv+i63YBSGDdBZSxCPRUR9Z2OpxjOcbQWjmyHjlZW9RaFS/ZmEH/nux6uC92RYBU7gnnAAmRqumyBrtc3a3kejAf5QCv4BRUmxkx4nKC8hCNrFske2Ru92IGfSqvM+XE3qUX/ZpBR9gpTBrjyhD2nhRlFAHH9/4UFGyUzlFxWws2RrYTtV/tiHk4JS40h8to/KFshxsnTrrSW6w7Vj7WIBITUZMBPnHzHm4uvnQy36KHYJ/r3umMvDgJyImTslBez741RxNEdxIKIIzCgyD81BpwXERtFtg378DTUZ3XerH69MKE5GHSkCKV5mvJyoA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 02:18:58.4617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0110b3f7-6cf1-4850-7907-08debb964f68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On Wed, May 20, 2026 at 02:37:09PM +0800, Qinxin Xia wrote:
> +static int smmu_debugfs_ste_show(struct seq_file *seq, void *unused)
> +{
> +	struct ste_context *ctx = seq->private;
> +	struct arm_smmu_master *master = ctx->master;
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_ste *ste;
> +	u32 sid, cfg;
> +	int i;
> +
> +	if (!master) {
> +		seq_puts(seq, "No SMMU master data\n");
> +		return 0;
> +	}
> +
> +	smmu = master->smmu;
> +	guard(mutex)(&smmu->streams_mutex);

Given the whole thing is fenced with streams_mutex..

> +	sid = ctx->sid;

... the point in having the ctx is for the SID?

SID is convertible from the parent folder name. Can you try:

	struct file *file = seq->file;
	struct dentry *dentry = file->f_path.dentry;
	const char *str_sid = dentry->d_parent->d_name.name;

	if (kstrtoint(str_sid, 0, &sid)) {
		seq_puts(seq, "Error parsing SID string from: %s\n", str_sid);
		return 0;
	}
?

> +/**
> + * arm_smmu_debugfs_create_stream_table() - Create debugfs entries for stream table
> + * @smmu: SMMU device
> + * @dev: device to create entries for
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int arm_smmu_debugfs_create_stream_table(struct arm_smmu_device *smmu,
> +					 struct device *dev)
> +{
> +	struct dentry *stream_dir, *dev_dir;
> +	struct arm_smmu_master *master;
> +	struct ste_context *ctx;
> +	char name[64];
> +	u32 sid;
> +	int i;
[...]
> +	master = dev_iommu_priv_get(dev);
> +	if (!master || !master->num_streams)
> +		return -ENODEV;

The caller has master. Why not just pass it in? Then, you would
have master->smmu and master->dev.

> +/**
> + * arm_smmu_debugfs_remove_stream_table() - Remove debugfs entries for stream table
> + * @smmu: SMMU device
> + * @dev: device to remove entries for
> + *
> + * This function removes the debugfs directories created by
> + * arm_smmu_debugfs_create_stream_table().
> + */
> +void arm_smmu_debugfs_remove_stream_table(struct arm_smmu_device *smmu,
> +					  struct device *dev)
> +{
> +	struct dentry *stream_dir, *dev_dir;
> +	struct arm_smmu_master *master;
> +	struct ste_context *ctx, *tmp;
> +	char name[64];
> +	int i;
> +
> +	/* Check if stream_table directory exists */
> +	if (!smmu->debugfs || !smmu->debugfs->stream_dir)
> +		return;
> +
> +	stream_dir = smmu->debugfs->stream_dir;
> +	master = dev_iommu_priv_get(dev);
> +	if (!master)
> +		return;

Ditto.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8e1c19b6831c..9c9be63dc9e2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -821,12 +821,29 @@ struct arm_smmu_impl_ops {
>  };
>  
>  #ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
> +struct ste_context {
> +	struct arm_smmu_master		*master;
> +	u32				sid;
> +	struct list_head		node;
> +};

Does this need to be in the header?

Nicolin
