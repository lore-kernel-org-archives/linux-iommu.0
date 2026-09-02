Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B64A64F8
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362068; cv=fail; b=Laj8ZFMjeWNM8JNP2U/s3VxmT8VlTjnj3GzllYucMc6MDe1F/AV++W07s8zSbB+J6JLYMHFXkLN6chify/RvPdxiqpxIgKmgrPglQhUaelELAgnCN5kbz4uUNcce4fnTW9tYU+NGCLaQusSyjvQCB2uf6Jhw+CWQ6L55ZxkNy64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362068; c=relaxed/simple;
	bh=d0cOkmGKmet9HQ5FqXWR00pJP92JCwIgpkd8WfAPzvk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m71u5q7GlaAvkq7JCS1mtbgmlFez6yReRLQ9WgrlT+AV79Zog/WxwyRkCqq+5yRv8MNTQJDiObxSfteik5eM04A+twe5jAdWeAVIPryfFQnKFqwEKLgGrSjqi8LqBo6OqaRln+bNKVyvGPRiJj/d6OC/WFlFhg4k3ON7jPM3kB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/U2l0XP; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/U2l0XP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4nuwz3Gpi2N0QKcrNAfEzOpbWGtYQJVPqsVnMOZwLocug7HVR7Of44nRv/R3XQnMk/RynIkFqDjULrnla9ZQf8ksCV4tUWdSnR3R4mOYMc25xYVijaJlc9zCg1ftHmf/j2zfHp5mjyJSwI41dvFBBUv+zfzielwedeUmgvEJ4Vj3d0IqKWgwuFNSKGkrAlRlpqp8k4GJOGVFEjIq8EMnoue1GUDNdCpDjQuPHpIiU4jQyn6jrOoVf01zU/IUuCfjLOSU2DecJRPAYTsZ3d6Ov6MUIn5H8w6LPcBMVJSmMOJV+rB8ZDNprMpB1TRjBdiaR/uhv/XtPIiTTtlqe9Ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC/mGsv+wwtUCtT29fL0RI4IN/xA25oXFZ4gLHxkxlo=;
 b=RDWZUlUYPUZDkshm3aGYdROSXM0gpvfccr+iZoHsQk59gCYr0r1y3tOzxbp66eRm+28RSFrOfy1AGi1I+XtTQPIgd8AV+E8UzrM8lI/O+68SCJu6/pIW1hxs8Y1BTcIPiLEeko2kqY0jPKm4otfzfE6o/2EvYoyLs29zCiLGZVLnELp0jKuX3D+TOfxQhILlMGiGebo0JltWnJL+XFjPBEmgzBRxcw/azNYP//B7rJM1reWVcfWvDEHdy3/LFBz7YbBawHnKHPCXwLt/aZUyNF0JytcvjPWRugUoub+sHkPr7T10xx/wjGpwqKdQhAm3Lu4GYUdLn8+G06cdXSfZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC/mGsv+wwtUCtT29fL0RI4IN/xA25oXFZ4gLHxkxlo=;
 b=C/U2l0XPYNfriqRjf2XJmz4GVljjxMLfVwsZj0dDXRV9hV8FKEC8PqhG9jQ4jZMnKrWSE+HPmCzXEGJpSlIAnkMs35xf611UvTOmtsVtG75RyrfP5gCwiIzvBwNT4lrzfmtlp563CLipGyKSbaTeed6p/kwbEWg280HHlldWkmFyccOpVpiogAWzkxWAKl98NSf287oLCGtrGu7yf7lkLB3r4oH4p9y/1zzEgZxwqNWNHNdiTkfcaCwR7eKQGUROws+DR6JnSGbK6DEov5VeiKa3C4wDk+NliwnftkAm422y+vS9OqYbxlXtHV5pkwOGAh2MvxlIGB7oHC2DgU6ZgQ==
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:14:16 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::5b) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 15:14:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Wed, 2 Sep 2026 15:14:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:13:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:13:47 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 08:13:46 -0700
Date: Wed, 2 Sep 2026 08:13:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>, Peter Shier
	<pshier@google.com>
Subject: Re: [PATCH] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <apg9KNnBSjej2deN@nvidia.com>
References: <20260902124333.2461949-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902124333.2461949-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 21857b00-fc30-4562-234c-08df0904dae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	emEQVMbo7wIFzwGD+c9v3cnR4ktJpmzrq5UsdoH2TTK0EcVDjo8dNO95UOT1628+fjKf3z0ofdZuW8GH9LgtxmFMpgWN5/f9V5LIs1U6J3caZ1/F2VifpvR2I7l0uB+mk6jixzYxlABYxIUSaLGZbhZy80Wg6DaGFo5hFpwQZothfNogEZglkiE8BvjDSWIjUbNvT8E2VyYXoDsTJ4b1EUVOYdy0WNJ1D9zscrWLuweREL5cbqEZJVJ0P5Y2AUFmPa4TUmWWkT/C87c4BFe23qtd0kkMRhCgjb7SrKGqVdBwB/pZPbL+hv+ViPx2j8vC1GzV4nw+hwd9ZUf89H/fAoqG/6gGpmHXeQx6lwjsO6nigf/CJrBH+ZiMpnHV01Ru8BNQy7uS1qtrxNaEajii1ZjENY83YExx5tCTQZGhIkDBebYNcsENUw5HkOKqTEwXJisEhfCENjEGjXNkQQBSxG4Rg/VAYt4TUrdvBlmN8AZo4ONb/Y2oO2cNgksZYMEjWBJZPEhMEpKa/9fEoLYKPLUdrIPFwApPjAjq88rblO/oOcyzmcMYWp4yp74ZE6wkrak4eZk1TrdzjQjm2AMW0P11F6QhSLl8JPSFLu50+O+6iBCiCRXqJpxkuzNuJhXUAXwk8gb8ZY8VDf+aILB/VCQjY+2j6GawSrAay0dvESJeLjT53LzdkzSxjddw5AEjgqOoquNDXFMmarfQQ+huUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yzTDU9TdCWawJ43DAE6FXbaa2/q+1auU9iqSJ+jExfzxU719JW4NFwpFB7u8QavR6NkqAOJ1DVrRaulKAG+pqr6+yteNuPW/br02rloTO5zDGhRtIzmcssJqUqz3hVGxxoLcQwLW1bcZCSzkppPWxVE8e/rT941IZYcSLycGdQPnP14giP31w/MwJMTMk3DTJB6XSo/gYQLr3pd06rhvaGlH7eun5uq7behX3SYKnaeUbyO/l5Sqtl0uke/WxZKf5vVTDMCewjTbI9a89sJKFi+UAuNCW/94vm/N8goKRyRZ6X/IoEYZGlHfmKGjM33XxEG/yKv9Uu2X/Lrip8bSl0PIvLw3y8CN1xhe0kUgAvBeEIznBRhCKqSgZohW0yamFdb+j2TKD+OviypJ+eAYImv00BMn0MPYaIw7UaFw5kQWBCMIOkToBx99kDZtST/e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:14:16.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21857b00-fc30-4562-234c-08df0904dae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150

On Wed, Sep 02, 2026 at 12:43:33PM +0000, Pranjal Shrivastava wrote:
> The IOMMU_HWPT_INVALIDATE ioctl uAPI explicitly allows an empty
> invalidation request array by setting entry_num == 0. The uAPI
> documentation in include/uapi/linux/iommufd.h mentions:
> 
>   " An empty invalidation request array by setting @entry_num==0
>     is allowed, and @entry_len and @data_uptr would be ignored in
>     this case."
> 
> While the core iommufd_hwpt_invalidate() handler honors this by
> skipping its bounds checks, the generic array copy helper
> iommu_copy_struct_from_full_user_array() incorrectly rejects it
> by returning -EINVAL, breaking the uAPI.
> 
> Fix this by returning 0 instead of -EINVAL when entry_num is 0.

I think the caller of this API should be aware of that and check
the entry_num. I have submitted an SMMU patch doing so:
https://lore.kernel.org/linux-iommu/5223275dbc8ef00af233f3fee01efa09e45f26b5.1788127877.git.nicolinc@nvidia.com/

Not very sure this API should be changed though..

Nicolin
