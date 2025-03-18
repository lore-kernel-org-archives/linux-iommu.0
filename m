Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3133E20E6EC
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315212; cv=fail; b=gVY2uk73kCqmZ4QFYkth3jQG+0b16i2Ln8SLJHA6ZNJ2cyPkbbXMK6RsvfQopVxHa9/vTb6rfDspUjseB9M1w+62bgNR15OYP5riLqHP+RtyGixtU/GaB5V91Srwo0gg4p+vPU4y2g6p9CkypY8JoudTZ36XMaQv0Gfx9KYZEdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315212; c=relaxed/simple;
	bh=ZE8Yp9w5yUJxMpfrKIBgmo5hjxDg53bJFqlLC2ChbkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na1WN9GxxWtOVh9tt8smBljHXmBYESCFjTMpO8LR/xovPmO5fSZjX9ALsVjm9cb5ZZncbBtjFk9dz0hkWX+veOzvJ0rYpV5p8pgq5/TrzYWZ7xnB6ZhSaN5Kym6/sXJi4cBg/Qyiz5zUM4FDuGaEmJhg8beeLbiA5wZzI2Y8LBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVKle5np; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVKle5np"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWgAll/ivgJLNHGk68ZJaMmeGkMGxErzjz1n8NEsoHtO2F6iqGdtB2sPer8BkFomlUoj4i5yxhXZuM+mQ8DJVpax6mID7cJgunv8K49hgIPBDOGW7wkWNbYcW/8wtNXkZzI2rA9D0opc0hNICreEGJgXVCaVjgMsbdf6Zu1JoByJa2LhoI50a4AuKW+JuoUIHi89+U9BOXzp8RlQ9sztrLKWfNdN29QbkJASgct1MWd6dSBnZnbJdnJUWSu0n9mWIUc+5tPtO3nX07r+rV8gc0bS95U8mVQtKgITnWOhQONOAxg+2CaFONd1vYOjVsX9TWUI9DqwU7zkUnCnm4kp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3R1KlK+WiEGrYixRXIRS95vqVxuXyIITDGcXEsDdGU=;
 b=arK8QI81zMPu2plqW4KL/ngwviJnKr6PDmbQWQrgN2KRn/FsL7fVSCfiQJ1Iw2ns6VysYmiVDm0X2MaGoiiPttVmQwRw3sDAW5yTATvhi/EyW5LblO4yMg2vI8kX3FqYvIeJ+O6zAwI5K0Jo7sx0uo/xwrI3FtqhcW1iHWfYLxBvZBH5c/Plznwd2mp12KcFWlg7pHUDUar/Bc7tsMjMV1Jb+rnQfAhUz/EwUNjT0vfbMOQjIqA/xjFZjUdebKchI6JKlb7HE8Puax6d89O+bFzAmEzpmysOmTSG5xbcnyL9gCYY0sja2bHNzPkv+4IWiFW527DcvfkJiPvDcYpdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3R1KlK+WiEGrYixRXIRS95vqVxuXyIITDGcXEsDdGU=;
 b=NVKle5npHnbCejdzPboiSbjiNcX1ROQMbR5lfYoF8BV8A8sYraxtHMbQPkqRmHc/oMfgjFUpBbYA9xcXgzCARD59LfFRIq6wZcvNFDPApP/O7ZQ1ASVTKdWmyA/FajmzkpjZIzXBdMIBawueBOhR/ubaKSwQwEY4gdi1K1goVpfPrXHDIwzYotFI/C+/Zi8hgPRX+g/xThKv/BowoITvn2eq6ylBwRsh2PBhFZaZRijQZmh42xRDtBFoUNcGEqMjAOKy3i/zqBtw5HF4hTvn3DvwZSDTYWoNJZAAukrKyGJBccIBdQBj4SDkhHloeB2zdd4849KJbeghjUrGg5F2pA==
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Tue, 18 Mar
 2025 16:26:42 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::60) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 16:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 16:26:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 09:26:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 09:26:28 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 09:26:27 -0700
Date: Tue, 18 Mar 2025 09:26:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>
Subject: Re: [PATCH] iommufd: Fix IOMMU_VEVENTQ_FLAG_LOST_EVENTS kdoc
Message-ID: <Z9mesnGdSWjfLaY4@Asurada-Nvidia>
References: <20250318162017.709212-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318162017.709212-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 178ae6c4-339c-49aa-5781-08dd6639aa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ko9XmeUdHRxlxyNEuGC8lOwgXfvRA01N5uuPkxWXJvzQRgR04V5e4lzVy6EE?=
 =?us-ascii?Q?hwAjP3CXcxgheiMRTzoUxaoFUF1NKi4G3wZuaPdolQJj0/rdP5Z7dd916b+k?=
 =?us-ascii?Q?jJyMG4pZDWX5ULIVJcVnvoGTwdDwi9EMddiPbYrGrX1jNeLdCq4kS/KEXKTp?=
 =?us-ascii?Q?6DB+YHgMk7qfogU6UGQ89Uwh6C1DzSzbBBMauqtqk0nHsnOCrb8Ee07yFEHf?=
 =?us-ascii?Q?XHcB3XnX613AthwoKbjNRa9ON412NLaRzIVMwYG3dmdmvBXxBu+Gyha8IWQd?=
 =?us-ascii?Q?nQpUZF8F35FsqgGJ6Ilq3ZoLFTxJP7iMHdjhodXxe47w0UBQJGm47c7vPUzE?=
 =?us-ascii?Q?diQzm7MtQowF1yqd2dvGZW5bkpiAjRadkKXRxW5hI0ajNWl85mOP3aLR7YZU?=
 =?us-ascii?Q?DBkA/2ydnfpuTvGY8pgftGaU3dHfkYnXXPFWY3vHrMuNF+dETf8fTgE+4NTq?=
 =?us-ascii?Q?Z9/tHbS+1U2/QhvcL0fOoXByS53/l022iaCaCpbtp686fhXQ7zGIevDGY0gC?=
 =?us-ascii?Q?+BIfvZ8DNcYbrMfN52OPeGpZ9hZ6UYQVKmLuAv46BKj5u6pGsxhKm942gHMk?=
 =?us-ascii?Q?wQFx/lFIuvUOLan7BBZvoLuTG0eqkOOOHI7k1uzB8AGXuY8cvhxa9cRuRVid?=
 =?us-ascii?Q?biWHfFZ+a4aByXGHCQkBZqgJJO6ZHyYUtfWCe2hv9JEIPF8nH6w/669pTrRB?=
 =?us-ascii?Q?HuFhjI2i8ue6fr92DRtDzaiCcW1M/9WNgvST73euQajCq8C2+k3JPbh51sUt?=
 =?us-ascii?Q?3Mrw8SGK0ArUkgg+NfS6bpbyFJlPjVDglttRyCpFzTxbs6BpIPBSQeC7tAeo?=
 =?us-ascii?Q?HKb5Ww4cJXCa/RyCo5ZgNYMReeKZeiyga+E4s4PieIzCoTxMlRltJNHnApDE?=
 =?us-ascii?Q?Mi9BimkDpyi+1mo4Acxt9QMcYymczbJuo8xGAP1X4fgsHUjZLpgwB/9nNMNn?=
 =?us-ascii?Q?yaaS+8cNbC1LsUfnTsPpdvm6iWIOOKAXDfqobfwnPyKw4ADP4xPO/VbvAx9u?=
 =?us-ascii?Q?c+h9ntaXqPV6phaKmD5uvIs8d1wg18Bqw++RByNjopFLov1Ha7bcWgV7fzzw?=
 =?us-ascii?Q?vlTCrsPt3kedztsYQ/4igKa8RQ+xANqqw40fQI2CDW3IBjxr/nThhNBuiBCk?=
 =?us-ascii?Q?2rqqha82bX6rTyPkfA8ugBbP9LCu6trtjYPnFEtDynMyT+wIGUxh/hgtOHwI?=
 =?us-ascii?Q?H5X4hbPo55CpOL8sDOsHFlzXOquRWzzGL8LsI6zpwDYHVrv+Joo0gnjgAxvS?=
 =?us-ascii?Q?dv64vWqZglz9qngkHM61Lx9jr28++qHBobovGaMRPemfoCgtfqtxVqyoGtPr?=
 =?us-ascii?Q?FR7DdNQgyOJexzujr8gra6e3z8cvDhbEzbpZBFenK8eEv4aM5KnhYIp7qbmp?=
 =?us-ascii?Q?Hqn9029Y4dJDSK3lZUM8DpFRb2q0FzYBX99gVMWiM+r8Qvk0V1yCW0AV9OeU?=
 =?us-ascii?Q?2ZY1szueTGR3/vnpGMy8ljFFOIJ41IKWRpcIUF+3/5Mc3DdTmsACggTH6Sf7?=
 =?us-ascii?Q?ny1LI6bHU4vg6bI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 16:26:41.7279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ae6c4-339c-49aa-5781-08dd6639aa9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345

On Tue, Mar 18, 2025 at 09:20:17AM -0700, Nicolin Chen wrote:
> The kdoc update wasn't fully saved. Fix it.
> 
> Fixes: 50c842dd6cd3 ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250318213359.5dc56fd1@canb.auug.org.au/

Oops. Looks like I should fix another warning together.

And the link isn't the clearer one. I will respin the patch.

Nicolin
