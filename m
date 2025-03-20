Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E9F215770
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514182; cv=fail; b=bJ2L+T7ooVq3mzwfMF57O3z7bS4jO3SOJ5cHMzahVt+ncQCdeyUCQC0iDj5+qvgmawIn2mfM2cchUZiDUp+Y06ASwQnhhADsRkLtf8aQTBstQlFlI/2VLuTFa/KOrJ+ywXnbjwTovLPWkDeDKLNUNKEvfPjbWwKrcecC5ZIxaZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514182; c=relaxed/simple;
	bh=qFpKHiOhSbEwoEQkYhBAcD5NsEhs7ldMnAUsGlZDHFg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1qHkToHBeFILnqXgnCBAf2SSKmZxEUm+hhKKqySYa4xFEvnXLC1L31uTYl0SQ3W0pb7Mcw6Oy79lhtdJFZlBLWoLgw3N4fQqAv7fym63Cio/nyBMyhjB5PdnPjxVnx7rG328gxNY2kRitv30A/Efv5UNzqEp1MF3MJrloFlFT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkt7vMlJ; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkt7vMlJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9iAEY/MaBdXeYA7JEFQkd3pgvBiIZgYu87sCtbFZIODeHSHqqHfzgRuDk84Fpesdarf76hWUy7XwgJQxM2y/FbPwmnVU9VVMtEbxPRSmx6imkvAxIRP/7HpFOIHxRgYvvmjDd451AZT89UT3NJ6/By9aBTif9ubeJSZ9v8nwM6SlhYsPRt4yodIlsw5OBf/9CPxWYPeboWCEuqXtjdJJcepVRiqZUrGd1OM/F48eKZFeAl7UeJtkbEozFczAYzlIpehJprmf9pNSwPAJ8VYDB9AyayqnKCjm2wziV5r35lr7B6vhublNBvk/0Rw4E6q9rUywM8yLvLv2u5k30eSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHyevp8YboVhWTsBHKKVZbqsiIFJQGaUVLoPZToZpiA=;
 b=F2wOopD8urDS7FOtxLv3fJD1l4Tp80vo6tk3nLneQg7kwR6rOqPL630YTA5myUxZ8dxwDOmG/EqpTwGhpQpF4mfaT+6H+lw0Vm662bRdXfqrDWI16KhiUQyF7ujqNjcnTwhwUSvSoWbPkS8MYFlL5Y81DytZ6SAmQxoDsi08jvw5IDuDicuiasM4e4SMu9lmT85YPUoSz4tZskIGI40zYkLn0Fy5kfK04QnrxOgjtSwn8upCFU4lIPzDstFC/FmehDVPj6IzsaUBk45eSwyc1cfErKtcSzJ/d8XpUb02GNa33xblkGEEcz/SlqxPKtIwZ9vcgadmdxJOP1+DMlZNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHyevp8YboVhWTsBHKKVZbqsiIFJQGaUVLoPZToZpiA=;
 b=lkt7vMlJUlCyI0TOQX8y0PBCs6p4liSg2Tyre247ojUnThzwgtBWfIo5gNokixGYMHw5s0E5K6xo10eGmmDzAaZpuAjueN5f8nuJ8/U07npHpSTMPORpO4VYbZzIyUuKJWn0PPJ8NfDAvMmMt+s/RGooJCODsx5c6yYPbkInPJZ6S75yAP8dFYzA0ltbiXgVuHXExNJHvjurmL8J+DFmr9NBES9q5J9xUgjnTlFURTI8xtI/qhrt7lM6gS2aNoBY1TD48UZgK49cVymo9tYSgTgUKPIsZEGkI/Gx2EXDyBiLaDgyANiNJO5ZSOWT6Xu450kYlcgK1bhanhdKz7Qqrw==
Received: from CH0PR03CA0317.namprd03.prod.outlook.com (2603:10b6:610:118::12)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:42:54 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::78) by CH0PR03CA0317.outlook.office365.com
 (2603:10b6:610:118::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 23:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 23:42:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 16:42:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 16:42:47 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 16:42:46 -0700
Date: Thu, 20 Mar 2025 16:42:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <Z9yn9c46eyz4kkpt@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com>
 <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4151345e-7f21-4e75-68f5-08dd6808ef0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99OLllbaT0yEDGJkWR2xLTQhN5BOsWtCSJhPwMCNBlmI5adkPkYkS0Gqwx7p?=
 =?us-ascii?Q?zAqqGkKCib1wR+pcBO/5IhqdI2kcur3KMerJ32J8Sb+rh7ml5vYBWe97uJ4a?=
 =?us-ascii?Q?txwrrfyH+HHFP6TRWLYE4vDIGQHkoTCQagh4yUNNVWvdBR/xfozBQu80Qm+E?=
 =?us-ascii?Q?jUKL7+p1OstfaEdz/0tto6H6Hiv/ulGmihMffWEhSwU49mAY0SofgqY9RlNJ?=
 =?us-ascii?Q?A5EqAsvVry6SMaa4NryFEtq0HERVVVGLW0/iSWJLROzIjA4f1n0oKn11nPqs?=
 =?us-ascii?Q?4wo9luBSKAQsMh0Mr/glY8ANdKpWyJsr+Ic4gHn3icf2GhUt58IJJIftEbUe?=
 =?us-ascii?Q?MKOQSJHKN5uhFQpoR7AzR0ZCcFcupotLUOfL+aI57UVe8Zt5xS0+OEWdZQns?=
 =?us-ascii?Q?rjT0Zr7uGLH/OqCIRyc+VPO253GvbyCbNNpzOB98h4np2fOi3BfCJU5BVz3M?=
 =?us-ascii?Q?vHTmVeWHJ/skfdmRs6cFG5642LfHdt5xsokQQKlESRIvEtw0jjjFlpl223Sy?=
 =?us-ascii?Q?WkKvgsDXO7vKpLgUJ/VuPYkfghQCi8A0/WhxkqdI2zDvaYcowhqhVolkkIK6?=
 =?us-ascii?Q?IIRdpmKvjtMySlvkeyQWWPbFMUpxqyUhSY140FAwjmtuHRSah0Zx6M8wyUQD?=
 =?us-ascii?Q?j6gjh8/3Gl244kmLDs7SqDWUrPIvdoOCGPuEvs2z+c8GoTnpiuWz4qUj+vlr?=
 =?us-ascii?Q?cR1pU9QB+sd1q/9LCw6VKA5pFIvtxWqkoqEGciPIPtf0lSMK+7B7RdMUZ7SA?=
 =?us-ascii?Q?1UsQ/45HqccDhlex1bTrnZN8ASMkfCfU2VBoVJJK06IiUqzhJWMX0oCACDha?=
 =?us-ascii?Q?ApYPLKwjWUmAePYxxL+xKjP4sYYGa2Hw9lNxlLzN8Hc5tWNfYzSb9qhoMkN2?=
 =?us-ascii?Q?K3ALGTBUZkSEurYtS16m+vs+QCqr1ZWTGHFI3KxxhUovRC/08gfGzAgOPSOt?=
 =?us-ascii?Q?+ET7x2id7/7nQbxuV8pL8fOTEnfWJ8y9hyJyE/4PsAtnTxeGCISqD6KTv8uG?=
 =?us-ascii?Q?p3+UCocw2NpcjHy0ndyPiNM0VhjJwkHnfPJN+D9u0aqYc5nTIqk/CwDiTu6h?=
 =?us-ascii?Q?iw5z95gEEgG4FJhIdA0eBQXEiVYFP1bwR3lpw1DhC33x8AqNn6DYxOVsfuKJ?=
 =?us-ascii?Q?cfFQpQ3KoV0vLE/sIHv0rieCyuyWQ34zrBmW0ZVM9mZFxFUHV1He3W9xPV4u?=
 =?us-ascii?Q?qDd3EPEzGl4ILhj9Rvh1gc7YpWoISIr6BSbXzpAJSGV+3YIHb0833pOXoh25?=
 =?us-ascii?Q?C/54rwxQ1gDNeUgBwCTY91L2tB56Q1GxDwJ0LwwtKKt44XG6pSVxL5K+x8wO?=
 =?us-ascii?Q?NzNWF48SpaiEjgKPtK5s02t7MLq15SNvm3FUYLSmDQua5B8//7VaQCvpfFTL?=
 =?us-ascii?Q?v89AeYS6l35r2rtbUX+8ZBTgZIa8FfoyD3fYY8hOUPuz4mESOJTz9pgsjGj/?=
 =?us-ascii?Q?ENObOGtsI4gNqQTNMUSi1HA950Bi1xvRXW54mVDvilFR/yKJHmBCYbCVN861?=
 =?us-ascii?Q?g/3VB2AyC4r0qBA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:42:53.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4151345e-7f21-4e75-68f5-08dd6808ef0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423

On Thu, Mar 20, 2025 at 04:17:58PM -0700, Nicolin Chen wrote:
> On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
> > +static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
> > +					   struct iommu_test_cmd *cmd)
> > +{
> > +	struct iommu_domain *attached_domain, *expect_domain = NULL;
> > +	struct iommufd_hw_pagetable *hwpt = NULL;
> > +	struct iommu_attach_handle *handle;
> > +	struct selftest_obj *sobj;
> > +	struct mock_dev *mdev;
> > +	bool result;
> > +	int rc = 0;
> > +
> > +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> > +	if (IS_ERR(sobj))
> > +		return PTR_ERR(sobj);
> > +
> > +	mdev = sobj->idev.mock_dev;
> > +
> > +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
> > +					 cmd->pasid_check.pasid, 0);
> > +	if (IS_ERR(handle))
> > +		attached_domain = NULL;
> > +	else
> > +		attached_domain = handle->domain;
> > +
> > +	if (cmd->pasid_check.hwpt_id) {
> > +		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
> > +		if (IS_ERR(hwpt)) {
> 
> Do we need cmd->pasid_check.hwpt_id to be optional?

Okay. After reading PATCH-18, it looks like what we want is to
verify whether the hwpt is detached or not using hwpt_id=0.

Similar to check_iotlb() and check_cache(), I think this can be:
	/* hwpt_id=0 is to check whether pasid is detached or not */
	if (!attached_domain && !cmd->pasid_check.hwpt_id)
		goto put_and_return_0;

	hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
	if (IS_ERR())
		goto put_and_return_PTR_ERR;

	if (hwpt->domain != attached_domain)
		rc = -EINVAL;

Also, given that we pass in hwpt_id, let's call it:
iommufd_test_pasid_check_hwpt/IOMMU_TEST_OP_PASID_CHECK_HWPT?

Thanks
Nicolin
