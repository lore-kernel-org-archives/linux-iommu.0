Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741F43156
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699657; cv=fail; b=XSV2ty24NMCjxeYhqPolGU+xcK12Ltj0CYYGrxtLHtF4Eyjjw8mx1JwI3gs5i0wq6/HdaKQ8mifrm3r726D6OtYqdulAr7czw4M8q4lS7UQfU08Y74TtnF1UIA5ZHqgaxzd+OSU3x5Wgy5dYijtI94Ofet3vZd5ZZrnLEWPiewg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699657; c=relaxed/simple;
	bh=fr4nM/K6fs/iTxyXfFT8pdEyInYHkuvGeJNTBeq0uFE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4SYaWraRZl+KWxB7FPkNtDDMbqDG2Q5CTsl/0MM4HVjNy5jxka2BVBjo7lOyE/85MdCAK18SonwVsK0xb+xMehuiOzdgjNiZ+0UMZBi7/z6roXxx5riUJqMatkjmPWwUFKhc5tQy3SHG4gfI5dWRX1V/QipOaGKzE247r7/xkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YOxjtVD6; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YOxjtVD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6z7gOgXsom4n6ySaUnKm6ZYB1BK6BU7AnBgssVQTvjH0xQpiWqiH28m/a117gkzqIpgi+geNZ9DafKqZohDKHeQDPsEWTkSeYqv/HciLmM8X/oi4EWupwH9+m9hCm/RFqkp0mXk64WkW2D4N0OJUreqQczf6obeQQ54zHgXSMHfKHpHGXDHSHhsXq19qvmO/VX0dwiJ89Ntyq9erFpVy62J3P1GAo/933WSvmc0HIzYIFWZdZ3RSwU61UPMZXN9v9WYpFV78vSoYw6NnMlkz5VBi1vBKCGgA3ibAzDNTlbE/7rnNqneFNWO7L9+c0XAIFsf3NCifVCKFCJPvxM2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vu7YyHSGk8rCdzVu5n+8kyPFQGRNGr3WPH0LKPkqJr0=;
 b=sYRd2SZCukd2YEds2TtuKM3PrqxtCEcBSACq3OjdSR9L6XBfW3bQBXfgNlfQ3rxMnOyyVqEI9+iNdiXJrP5u0APcbkVKxo2uAQJ9DE1jCysXuQgt1u3aYdj16HJSg6kpHYhh1nkMv2Qt0nCETH9JJFJwXsYsYMpXX090iSXIqCTpnBujLbbJfzHDchjvA210cxCYpQjLK0q+a6d++gLGaMHb3DxEgRWWq4YOpQDDpIsVqEjClEjmNTvQeEu2tl5mmhprWE23IaFPkFhXk0cGYVnwkUPtc0k398KrRbV32ZxqrSBSiFt0HJuGVYlVBo8PYP2BSvreWhN+Z+sLifUCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vu7YyHSGk8rCdzVu5n+8kyPFQGRNGr3WPH0LKPkqJr0=;
 b=YOxjtVD67J6VRIhjkBCm7Wt/HFsOGkCPrA1EwlbW+u5eC+qPidQNLnhEJYg8sOQVMpwvg/FF2WUm4GSekyMMOi78DubMOQ4MFm38I1Egf0sHEvkl95rJtJPaqLPZq7p9EGbj4R1IIEdZ6t45XX9Gye4wJfYm/5KArM38Yi1aIixtuQGrQzNz1HDGwTSh0W1cNNHELoEVSSmllmE7ecMM+OcrHxRph8aowdLSKcz3WBO8Gr0EVL8FbrNBQi9yA6zGpN9DQSM4UwBYuTHQ+tqsZtnSsYIOTImyQOSjQyABExSAlC2p1lEmnn3G16EgkwMWO0jzJ4M+D7DrrUcq/vsVDw==
Received: from SA9PR13CA0152.namprd13.prod.outlook.com (2603:10b6:806:28::7)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 05:27:30 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::8) by SA9PR13CA0152.outlook.office365.com
 (2603:10b6:806:28::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 05:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 05:27:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 22:27:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 22:27:16 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 14 Aug 2024 22:27:15 -0700
Date: Wed, 14 Aug 2024 22:27:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <Zr2RsrcZ0478Cy5B@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
 <20240814215753.GY2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240814215753.GY2032816@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 4054d5ef-b08b-4c58-762c-08dcbceaf510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5NKXkSxj0pCkmvtGH8Q0PhP0XSf9F5PKeA7c8GHVlC7+o0iAZOnQIMLPCeN?=
 =?us-ascii?Q?a//OF6v9TaF44n0+KIVh8XVPB8x3jVKiKk2tcc9KazW8m5xjfGg+JKjzqpeq?=
 =?us-ascii?Q?4n9iPo1zPBw4ENtUlUh+Cavw2oG7f7Ts8px60e6rTGpKpsMEVj64mM5aAaHl?=
 =?us-ascii?Q?ZI7AvBe1vQO9b7v47cKrKC6Z0DQo2rd15GJ/FbhRHBmnCXX4R4DUwEGDdOdp?=
 =?us-ascii?Q?E+0RrJEfxmLIuj+EghQd4x7c74D3MJ9lm4neebQlH8WQd4W9Q9V9i0hTKGzs?=
 =?us-ascii?Q?qJTQ+6H/tmhq9iT8ZWgrvzq/2VJxwItbXm9ZdoDplv0hRL0/PtiWrLm5e+0X?=
 =?us-ascii?Q?yzFz9NkIB10foLceHmE9OMRhSAXhlChLclj1DuHFQAt+x04yB9HVtCaqQnM/?=
 =?us-ascii?Q?jF8pEqdEDePNtBIUphdXOEzL5HHT380+ppie1kV20bNXwAfKqBAu5a1oWJRL?=
 =?us-ascii?Q?UT19eJMo6N+pYJWWXZ9rJY33AOxTet/80DT+bEiY30WCkTGj7bMyMSKFZMOf?=
 =?us-ascii?Q?RRdpSWllP8jHbIT3jGl37tJ/raA9L7WWhXtSE3qK6c1Fqed+aD5j09mORi0e?=
 =?us-ascii?Q?UMgqHySFuuYigwesM8InyjCuS1SdRE+9jbPhWWTdxG4i5wrYMxhUBTlRogNf?=
 =?us-ascii?Q?BXQ24DaVfpx+TU+AeLQEpuGGjUyGrwJ7V/4sYh0L8v3qIXAVPAF+d+UZEZcd?=
 =?us-ascii?Q?FWHpg7kr2mZN0IAdq4kUnynfVod0A9A2K6jXXc2niCbw7daSP+I2eJq+VZ0C?=
 =?us-ascii?Q?q2cgwL5ENxsyG/df3m0D1aAM73H3cvqhMlvaIf3zA6CaQbLT626chjTKsIBW?=
 =?us-ascii?Q?5rF+CbeFZhwONi/9Gk/sHvmyePiE7GvB+vk+5e79w6jHloDAx7J5c8I8u7r+?=
 =?us-ascii?Q?6tqHs7/kP51pNV5i0nM0hl3Zivk0Rmi4XgABKod6y7/atacaFjDMcTO1R4kX?=
 =?us-ascii?Q?nAvI2F5mHUNnEXQlbyKff2VeLJBBQIER6WhfAgxMsQ9358EUqaKVbxMKl55O?=
 =?us-ascii?Q?Eiyt6FhbO42Rc8mlQzW4puxRc9aIuVz63273Bp93+SblTzjPNI6twsLHijjZ?=
 =?us-ascii?Q?PP6/XcpBKerAnBdzK61KvkQy51c7avJm2rT0O+qqWAffU47mryRMAssASdN7?=
 =?us-ascii?Q?BKE5EQmPt0R/75wrcI83AISAGxOOjtaYXXLLAAiM3pMchfThovX3WwPjmuQ1?=
 =?us-ascii?Q?5yTAfm3DbOZkpPvlC4S20Y4F5HCzy4CvdQUI5jaA36WTh9atKbjBixyUdpko?=
 =?us-ascii?Q?QXuMQqMhxLYNk5gvv+T+pUAN5Iph0po+8aChdtA8GcZN0mJJBUex8+6zPxq3?=
 =?us-ascii?Q?cCJ4HPCYV6CPN4f4uOR336Oo8Uw8NvYg0Lp9axsNlXFjgBgoQyb8o/gyCvwp?=
 =?us-ascii?Q?p62xAgAoC8NThfyAtkFRTX8/xskKpmO2HYfeG2hu7Kmm6Ukg6huaL+lv70Uz?=
 =?us-ascii?Q?MF8PhnWv7dhWzstM/iS/1iwZ8vx0ABBX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 05:27:29.8227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4054d5ef-b08b-4c58-762c-08dcbceaf510
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

On Wed, Aug 14, 2024 at 06:57:53PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 07:11:53PM -0700, Nicolin Chen wrote:
> 
> > +static struct arm_smmu_device *
> > +tegra241_cmdqv_probe(struct arm_smmu_device *smmu,
> > +		     struct resource *res, int irq)
> > +{
> > +	struct tegra241_cmdqv *cmdqv = NULL;
> > +	struct tegra241_vintf *vintf;
> > +	void __iomem *base;
> > +	u32 regval;
> > +	int lidx;
> > +	int ret;
> > +
> > +	base = ioremap(res->start, resource_size(res));
> > +	if (IS_ERR(base)) {
> > +		dev_err(smmu->dev, "failed to ioremap: %ld\n", PTR_ERR(base));
> > +		goto iounmap;
> > +	}
> > +
> > +	regval = readl(base + TEGRA241_CMDQV_CONFIG);
> > +	if (disable_cmdqv) {
> > +		dev_info(smmu->dev, "Detected disable_cmdqv=true\n");
> > +		writel(regval & ~CMDQV_EN, base + TEGRA241_CMDQV_CONFIG);
> > +		goto iounmap;
> > +	}
> > +
> > +	cmdqv = devm_krealloc(smmu->dev, smmu, sizeof(*cmdqv), GFP_KERNEL);
> > +	if (!cmdqv)
> > +		goto iounmap;
> > +	smmu = &cmdqv->smmu;
> 
> Should stick a:
> 
> static_assert(offsetof(struct tegra241_cmdqv,smmu) == 0);

Done.

Thanks!
Nicolin

> In here. The copy inside the krealloc won't work otherwise.
> 
> But this still seems Ok to me with the new ops
> 
> Jason
