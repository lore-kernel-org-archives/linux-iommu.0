Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D43199924
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327456; cv=fail; b=deDsCh4jh8eT7+2ONY/Hki57uxKOMHBNeIFRIFZrR7T652kveeyZIbDh5vx3gZzyoG+B0y7m2Mo3WlMbaleutvuA5FuC/JMzbyZWm6Rx0BhXhSU9t2fL9/sWuJDDJyLoIB9Ek/XKM953BmED5EuZVasQkAGCOqCXjT8Q72YBfwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327456; c=relaxed/simple;
	bh=Je+Z0Eo/MJ5Oa/rxo5EM7O/Euf9i2FbHYExgjoSmLac=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjm1xZKVDmccUua3LwuUXZy8tli98NvTE9X/ItDhMLuuCL0A3HYOMrPc3iVtIB2Nkoz1O5wqZmBpxQ76BXfrLhoPT0bBMqyBUl+1w+I+XSOSzGKSqAAU+Fvqu47InFioaT8pQT0QJxFyIrPzkgOSjsKbPYYgbnSkAGGlRizahXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ws1NvS9J; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ws1NvS9J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2jr3SaetyJI61ZikLy3axqJ1aQvCzh3XUAebBj2paXgnpzdpaRVhZCItYDWsKqq71CXzORCOetfFyh7HoVMFYZJErksmSAdj7NufsVfw9Eva0UQch0tcH5/dItg8LP4PugV1dPYKmvQXWC0BzXVl/9fBniqhmpkZVIbj1lfItBhnRDmn50rATHUvuio0zUEHDh7+8uy/dYeDDREBtJE9Srq7gfTM0UNHmOrXiB4ObXpH9TC6vzWEnZv60L0kVbYBrlQw21W3NN4nj26xGTBpNL+k1da9JiK3+y9aGrujOdjyCBES1AMGMOMcyZHw3HkRoL9yaGM+j8T12CDpbcHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/STo7P4QvmK76ieHn1ThjQLrHl/I/KdmtcqRVLyJfSE=;
 b=UftnxmHVs/Mr1zBSIGWe2FfC3zKmt1lIo9/x2Uf0B6IEcsKOKqhyv7pDV24QjVqICCCyRdKzckxDwERh2ToSNlnnGAbJx076R87vIwIZhNk4yWRyVSq4sNbB3iEojHkrOoLRNJilPDz1LMqzzt296Rmaox2iFllTbazroQkM4yLduXB0qV+CrxXccGgmrCi8Mek9Jvm75+UlZif7nZZTzDcZQa1UpF2TEPg/YalD9Pxzv+CRTrNTyo+fcP4tZDvuDb3YqymLOD1WpVyfGf8BqZxPyN87mHjZ4Wj1odt+YhJL8lpw0ePeXvXwCtq2lKbZnfcAc+xFfY2gstwno98Low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/STo7P4QvmK76ieHn1ThjQLrHl/I/KdmtcqRVLyJfSE=;
 b=Ws1NvS9JT4ujez5LRCIHQefNi2HUR8aAva2nehO3IV8lYaI7Ndizie7O0MCDy+jJsfrK1OOl+RYU/sttGawTK8lkgiRxtoi+wI1pavLpLN53qd1DfmMflBwkQfEvLxSV07vceexZ4qwvcShpAkjAmXGIs4OqkK0MWEHm9X5Nn9BtMu3yfx2uIZskI4iljY2fbrhat+FsO8kEb6xL1TYY/nybm4OPPtmudHBE45h8x+2RoJ0c9ywTT5Amx9mXUqpSnfGCAc7trrL+XndxPMl2zwp7Gj9JPFJDkXU8E9ht6nQvQAlAjILCf5i/LU5WBuyzwBjvcapMSBJbm2HcJlwKKQ==
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:50:51 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::26) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 19:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 19:50:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 12:50:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 12:50:33 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 12:50:32 -0700
Date: Tue, 18 Mar 2025 12:50:30 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>, Vinod Koul
	<vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/8] iommufd/selftest: Put iopf enablement in domain
 attach path
Message-ID: <Z9nOhn09L0prvkUi@Asurada-Nvidia>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313051953.4064532-5-baolu.lu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb80929-75b5-4611-7f1c-08dd66562f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aoAqbgeh99A3kFRM/74iH6c2G3AXBb/0JRPOiVWswHdGmLI62iwYbSj2BKhA?=
 =?us-ascii?Q?4i7d1aF1mqfvUddKsKRKD+ieDnJ4S7WthybOKrvRbxPHg49ZLGk/zT4Toctf?=
 =?us-ascii?Q?ZyCz0xyWZdUPtXRH7ZYkDMSl7fWa6TMls4uSgLsvyh0jXpeq6xh5sxSmD9Wf?=
 =?us-ascii?Q?3Gs3X5VmZtxvav68yd0uV8ifggmdtDdi8rPpV0+O9NLMk7/LDf+UFrxSAHql?=
 =?us-ascii?Q?ywsXJlVSzGf22xMBVSgszU8Fm4j6Pd03QZS24NsM9eb5trWC2ipMWxWI34wS?=
 =?us-ascii?Q?pdcvsX6AGFUZDRWtZX6x9Jozt34hNzO/pmd8e7fnD0HOua1akLAWy8xIYoqr?=
 =?us-ascii?Q?ALIDy3RqTVnWxs+Ew2hyg1fmUciGhblkFBr7YXoBqeFtbPXdmVw2McrJoECy?=
 =?us-ascii?Q?FeB44LOS2B9jKMaJeKgYbkDflA88LcBHC0oHYHq++kP6qkfptDIDOJUbPQAE?=
 =?us-ascii?Q?Esksod1ZXr84iQHCcI7zEebxBzz+81rVicGgpG3m68NK/hf+L9ROzktoZvMz?=
 =?us-ascii?Q?Y2dwbMNMV4TXzN9eNhT6kLsJexI6SLQ4SvJPvV9Gc15umHyrOuFrvbA2dVTk?=
 =?us-ascii?Q?71kHi93yf6W4Qc97nCIGs5ekENgMz1Q59t3TtMAzx2D7ug9ntOaiVEUAtmQP?=
 =?us-ascii?Q?/toBbZa9k8Nc91xA++eMWiVNsnoGdywfrJ9Zi+dtg1Rh3TgP5mRKOd23NydM?=
 =?us-ascii?Q?NWUIMAlrSgZXjKdBcb70zjYn5KrQ1/iJXqEzDKDe0hLp6HFICCPZ+3Vvw04q?=
 =?us-ascii?Q?LN3m/sQf+IsMmgFkdw51wVOwE47ubyOMzKrQTIKDBlC08NC7e8DSE7cBkq/V?=
 =?us-ascii?Q?1AueHSpqQq0zd20pBAYqJPycOpjvDeFao9XgMy7g91YUyw7fKX9C6aYG5bGl?=
 =?us-ascii?Q?6PGcRaTAal3MykGKK5UGpv6oC/PRn6lpPGk0j9oj3ZUcz7jwDMmmKF6deqDA?=
 =?us-ascii?Q?K/EnFYuB4Yg4BD4ygVNGMZmsiPXMwyD9F80pRbA74qF282+c4fpzWea32nlM?=
 =?us-ascii?Q?eCCI4UINxtkYR9SPbeYJRst6ysFnuYCbYd8v3SIxBh1WnNu13KemKu3qXsuH?=
 =?us-ascii?Q?7NkvI/KAodWG7sRMaF+76unNWPRyo2vkvGeet83dPfh4sse5ffuqErnNFn9r?=
 =?us-ascii?Q?pmxe3VsWyvijMlqGCpXC/clg6wyYfAyW+MNM+qhmGJfPqcjJb4mVOMEf/eiU?=
 =?us-ascii?Q?89DHD86AvbNAMUw90xWwgABK0wWluxzryKb/Nqh5DcOC8Iyn8J7ryTcOnNLC?=
 =?us-ascii?Q?xNmEafr/vllEMAXFC/FjeSzqeJwGAh+pZOriKJ02RPg1A1MwrDruFd5u2937?=
 =?us-ascii?Q?jNkbXnzfcua7JSNGKAIYC6CqxvQ9g3ZeWDL7W87qODOF8oWuM3CsXrI1NOMH?=
 =?us-ascii?Q?3IXaApg+AT4RGjoCYLwilXizbM8Dqe2SJTe41TbKnEh5eBJEYlyr4v/SbBZc?=
 =?us-ascii?Q?+7J57Mlhwhke2C8mZE9dmutiC941a+ft4D3tltmrRZe4YxZePagEqhlhMR5k?=
 =?us-ascii?Q?MjjFzVgR7zpjSKo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:50:49.6805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb80929-75b5-4611-7f1c-08dd66562f04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952

On Thu, Mar 13, 2025 at 01:19:49PM +0800, Lu Baolu wrote:
> @@ -164,6 +167,8 @@ struct mock_dev {
>  	unsigned long flags;
>  	int id;
>  	u32 cache[MOCK_DEV_CACHE_NUM];
> +	unsigned int iopf_refcount;
> +	struct iommu_domain *domain;

Assuming both are protected by the core group->mutex, maybe add
lockdep_assert_held() in mock_dev_enable/disable_iopf()?

> +static int mock_domain_blocking_attach(struct iommu_domain *domain,
> +				       struct device *dev)
> +{
> +	struct mock_dev *mdev = to_mock_dev(dev);
> +
> +	mock_dev_disable_iopf(dev, mdev->domain);
> +	mdev->domain = NULL;

The input domain is valid. Maybe better to rename mdev->domain
to mdev->iopf_domain?

With that,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
