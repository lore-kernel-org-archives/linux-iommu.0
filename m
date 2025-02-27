Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029126E947
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672300; cv=fail; b=bUFn+FtK9DFnXsQ6IuX68mZeioe3AwtWzqq+xdFPowSYb8ZB4zNBTQflxR6Ttl4jF+PN4Vn8WLPDu1dkYUb7/t7joKs2AigVm1ZLA2rBm1p+KgLNMueDR49PYECsA/Mm2/fw4i//9UY+5EYCoUWwtrI0VgEdRJlkdl+mVGHw+0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672300; c=relaxed/simple;
	bh=I6xncNkA9puhNW0NFDG1jMHJ9HGzyUssShOxRTxRkWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apgClskB0BwR/KnibOgfGp3ZSiUpZtLU+DNbc9idEGDXcE/1KYguj5u+4luc9oTfs8qF/OByh6lQ6Bo0osh/67HovoU+i/kqlS1mISB4m3EjrAszFm07+aGzlOB8IPG/LyXdxgpp/g4O3Sj2TcfgKK80Id5eeeUMK8bxj7LHmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y36/+SDY; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y36/+SDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUCSYT25pNKLwIdL8W3EeHwngkmG4Ll9oJVkHGsNo/INvN1apasY5RNQp/SzqxzC9O1e0OC3In127yDcuMF14NwNQXTU3g2KSJr9RkDTbpGSuqe40hP1DuxETresggiT1f2D0Xu6i2SBrAkvyly5ycEcG+5wEQaJZQ72zfhqCr+Nku14vMLJ47qJnlJ1Qf+J4q9hRllL0JTCUcM2zkpMvH4dbM3BW60PjBBEtYQfrSQ2W/SqTce5+/StH+uLA5d2HuWROJNCmXxinmjALTIVXtfa77RMmP4VWYWAAhqumL+9KXiudU+KQvS1srQHEXqO70IhBDtVJKY6NmUBOhiLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7GSL+Y7Iv8Sqry7zLxH2RYlyLDMdQxOpuLeEtm/GvM=;
 b=JNWR4LVWiosnmBUFcKvyAI7FxooPBDGSJRYRI/arHPBkrsDbJ5ygsD2wAfSf+YoFlhkBRiT1VJi/ncE35eT5MdATGKKuiEw5zghWGRn40UJhooAvJM5zih9A7NxMtmLrCCD5bLCySIJOppgELH/GcLRaMywpg/As1QIgKzD0Xq0mfsLn8Ohj9aSC917kvscym4Wd6b4qDKnaHcjScc1fVyRzmfn42O5OF5cTEvIQo8E/yfTRKuuAARUMO2w2hGJICpLPGrkuZI67r1NduEWwlSXv038rjNN/UOc+GHYogRp4zzhq80lxArCPHTKmOupDP0Aqyw/AGAOQuAJ86Lzp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7GSL+Y7Iv8Sqry7zLxH2RYlyLDMdQxOpuLeEtm/GvM=;
 b=Y36/+SDYpfcUHXsVwHoUQXo5rH0DGyRycMlxf3VuBJtbMZuOVAmU75lJbrQsmlRni9Tl21E26U5QnRQGrEna/jYgFFQfHBp08eTeQ5QMMAyJjgzMP3l1yZueOQzMVaOpYyMhs1i1Fyrpkbal4TNdAlKJ7YmulUmlIOOleBVykC6PmaM93hcmpHt3ohLfQjjUQm6j9eXRgC3KqN2Qx/yTHuOLCQp1fPiOPCb9kwz2+FNY1i3ew3j9uMiVdx5iek0qhivkCHskFygjS7q8UHzgM6yC6XQkT9LRdHKWNbc1fLOBtmsuxWIxCvyelT8aXqc9W8fJo8gLOLljrqI2fdUiPw==
Received: from BN1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:408:e2::10)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:04:54 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::79) by BN1PR13CA0005.outlook.office365.com
 (2603:10b6:408:e2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 16:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:04:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 08:04:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 08:04:34 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 08:04:33 -0800
Date: Thu, 27 Feb 2025 08:04:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Message-ID: <Z8CNEDwUCZuNUv7C@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
 <Z7+fmawdDhATfOX0@Asurada-Nvidia>
 <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d6b97c8e-f126-49b3-b752-92fe3069af51@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 3491fdc6-32f9-470a-3260-08dd5748794c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EsaT0JzNHRbdXBDEezG+yg//R+kbpENo5pBAlxlEbm6fCuNtFcMQ3b+lCKtT?=
 =?us-ascii?Q?8//L5O/IG3909ZlkHlvWGbVix2GZGUgwz9QR5Vw1WFRLI+E955Vx4t+4+hQn?=
 =?us-ascii?Q?6/aERhQXZF3MrhuBomyDC8gFgTKJdWalrbyNUZt2Ph6M5qHM9Jfkl/BnZUgZ?=
 =?us-ascii?Q?vX2WiT5FEottbEtVFSpGCMOGdfKzdu+IIlsnwIkuUaVazoXaIDq54yQN47VT?=
 =?us-ascii?Q?tQBoc8QCiUCJW0qS4h0y6st9S4bGNUZK3F9DfS3QtqQegBTfY3YxYaxJZ/jw?=
 =?us-ascii?Q?rWZ8oC75FwYQx9lhJalHp/a1AULYQgh9gOkJXEz0716YMT3EPUIod8Ss+d7t?=
 =?us-ascii?Q?gYDwGX7G2L59ofZAxnhytVVJAeiEx13RkG3YBLGreOL0ATn/eCJt1AJxaCRG?=
 =?us-ascii?Q?aD/aJEWJBZCZFjBVEHuM/ocSUe6VXCqSCExSdrROOOWyWXeD17l6i+AOhc6W?=
 =?us-ascii?Q?HP83gpFqHFYXzz1j4S4sM5ImSAlEVE0owioyPHLsGxgPCTHpz+q4/S6dBRyV?=
 =?us-ascii?Q?/KYwQVnMcEBM3aYtfw15leDM/SpPzrAAuLYZtihXP06eulbOqll5oyHb7wRK?=
 =?us-ascii?Q?f4jgfYkWiHU+r+eYfyr/hlg6VeBtlwqQxj9VxjMneiywnC48aHk42URgpM7e?=
 =?us-ascii?Q?6An8Ti1LslenO96c/6B1oiL4G4IfX1nNd1tsAuDnqhjO0bd0ksI/NzwLhmcG?=
 =?us-ascii?Q?FYqjHs7ceuwDmwUyLqEF5089rrjfiTXPSFBhIA5tEZ4xD3zPcY8Dsjh7H7v2?=
 =?us-ascii?Q?8EDWwGSJ9e9zk9yc9EGSdUjFTFancRKe32ZrP75EXFvCzjMvnMKK4b3BDNaD?=
 =?us-ascii?Q?3tw3oIPBYsKY+Tp1h2weJonpswTM7+DlLq4DoaYknQDCHKyvXXao5ag2edPM?=
 =?us-ascii?Q?DLWt5MyTzeU06/b7I8KVY52pOwkqbDEP/0pjXBQQIuOWi8bBx5Gw3uySzgVn?=
 =?us-ascii?Q?wnTfiKTcPWFCMZUan6yyFOp53c0fJ+Gj/6Dcw9+JuhCoMEzDmmbALEOU0i7M?=
 =?us-ascii?Q?vmo5RnYPxpoIzqgWWp4aIR+W8r/bD1BpsKAWlEgDg7CuzmhyeBi/gmqs6FbI?=
 =?us-ascii?Q?iM7PSaADo1TOWJFX77pmwgvx0MLYvro3rkYQykOZYoSR+mGKrtFo0Wx4S5m4?=
 =?us-ascii?Q?omczYIO+62rcfXMGjfJYU5Z2mWpL2RfNMBQp2mmlY+tSsuh9HV220iHSfP7p?=
 =?us-ascii?Q?THEYsR3oLKqnPLoyuJ45yS3Rc2PdEiRSvQ1G1IFWLs4fT+8Yk9mWu1Y1d1XE?=
 =?us-ascii?Q?9pYVwyvGhA/e9bRe0lWxSe6z4SnxYCES0T8qEGp03tu1KHGndSEpLz7uTW7B?=
 =?us-ascii?Q?TPoU01C/gct9zAKcjlA9/Azjgu7yonFojqAUx5tqCA55zlmj+KHQPfZaKM13?=
 =?us-ascii?Q?C8jKeJgyaxjdaI7/GWxG9OX8+JFKH9rZpf8+UL071cbSp/TDd2Qmg0GuJi+4?=
 =?us-ascii?Q?SlTUD1SF/a+zFVrIQD4KMxH2k5XdNO+Yv0xGWVu3vwfCzofVO4IZ6MLD5x2S?=
 =?us-ascii?Q?hnB94E3eYKjnLZo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:04:53.8745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3491fdc6-32f9-470a-3260-08dd5748794c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

On Thu, Feb 27, 2025 at 09:43:01AM +0800, Yi Liu wrote:
> On 2025/2/27 07:11, Nicolin Chen wrote:
> > > +/**
> > > + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
> > > + *                                     is attached to
> > > + * @domain: the new iommu domain
> > > + * @dev: the attached device.
> > > + * @pasid: the pasid of the device.
> > > + * @handle: the attach handle.
> > > + *
> > > + * This API allows the pasid to switch domains. The @pasid should have been
> > > + * attached. Otherwise, this fails.
> > > + * The pasid will keep the old configuration if replacement failed.
> > > + * Return 0 on success, or an error.
> > > + */
> > > +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
> > > +				      struct device *dev, ioasid_t pasid,
> > > +				      struct iommu_attach_handle *handle)
> > > +{
> > > +	/* Caller must be a probed driver on dev */
> > > +	struct iommu_group *group = dev->iommu_group;
> > > +	struct iommu_attach_handle *entry;
> > > +	struct iommu_domain *curr_domain;
> > > +	void *curr;
> > > +	int ret;
> > > +
> > > +	if (!group)
> > > +		return -ENODEV;
> > > +
> > > +	if (!domain->ops->set_dev_pasid)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (dev_iommu_ops(dev) != domain->owner ||
> > > +	    pasid == IOMMU_NO_PASID || !handle)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > > +	entry = iommu_make_pasid_array_entry(domain, handle);
> > > +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> > > +			  XA_ZERO_ENTRY, GFP_KERNEL);
> > > +	if (xa_is_err(curr)) {
> > > +		ret = xa_err(curr);
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/* Not a replace case */
> > > +	if (!curr) {
> > 
> > Mind elaborating this?
> 
> If curr is null, this is more an attach op.

Does it mean that this function doesn't allow to replace a domain
that has no handle? But how can that be an attach op? I mean there
still could be a use case of replacing a domain (no handle) with
another domain (no handle or has handle)?

Thanks
Nic
