Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3C2877E8
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894057; cv=fail; b=BjEJ5IlTbrezTlw6B+ITOOuSl60SJn4qCTER/FW9HEKWH+g8FYXzQ5pEknCop75qcGP7+HdIaF6xGc1v8++sq9y2NmOFAqyMmJGSZxfCIgysvMFlzqGNY2X7uo0WgaELXneiau8l6qGblFOTyVX4sAoDIufbZihypJwD6NAB6bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894057; c=relaxed/simple;
	bh=yz9HnMlecYLKbt1f5VOL1WiM5fqg2D1Mim7Gz8njxus=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbrKj7xGbDz7JDts0LIFsuhf4qeY7XXllC+LNisRIQS6D+D+7dK+Ubb9oxiGJxl7kqaavc7LlAFkdy/33ZEwV+Qm6GPFCEGuKAkSt8UckCeuJxQvxhSjEsccFZ2W8b3pLsJQ4mdiCOF41z8APLr8h0JWgYKBy9kuPUadAG4bEZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmQigWxS; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmQigWxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAHCvYY3wb6gk0VWpTedcsHSfGSX4xrxBalRFSPfhURLz2j1RazeGicZdckrUMKe13cUiOnRLybV5mhf4W3rArjgHVI+TbOXHVQiLjM2yYUBzWkSLSfEwbNS6MX5VRJ40yJVeHAUAKSMzWKlPOPithZel2dFpXigmyh18uKTJ09W9yYa0erXoOf8nsZ8UkV/zSvnN5n8EU1ExIsvTooGbBorul/KvJ1xcfOjPnBzl1dZ8bNvN2pAuXT1DKBylEs6KAoffWYzg9F5xIcN3ifnZ9+xvYr0S5SVxP25T6JnOzGXulFqV1k8DxjvHjYx69CdhwajAGd4uCpg7vIYyANYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHECeQLRSwUHtDGzvPudG9U2/+fOeGCvvy8hJsnMmgI=;
 b=i3w4VFgQ+1p46gJLpwk1ws+0i/zo2DOXsU13i2D3ZiE2W3fHC8OieY0Uk4/Yd6lyEe+YAl08cK/SVX/5VDzprYhnaBTc4gfOFcKMad2f0SLMGetAFnNNPdyfiLZE3cZ4mF+EwXqZ8oihTpwh7gkkNGGaIDY/qMwIGpW1wZf5kyxpiF6u7t+8wUxaJXihSVRfAlIlpVptsI+oXqgQlEmBXVMVjTV8UaP7t+2ocxrEdSyiKsq5vnc2bOjozK4b+WHB1rJfBTLfV6nN2zv+J9Zfziy84WDknU1vf/Oa2RNp7x98hwa8s+5L5/EaHRSnXNoR+lgaBZEKWVZdcnyL/LYRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHECeQLRSwUHtDGzvPudG9U2/+fOeGCvvy8hJsnMmgI=;
 b=jmQigWxScKIsKzXxbf9dVVQdxRe1smbQIrOYURHt62Yxi6tROydrlYXSZWNLX94az02/gToKLuBxzuTHT96nQNrvKq+deJB4WTW3Z8A+M64m96sVkPsORwRDBnYwwoYWGy89KcY9mGzTbN3v2YLtYtKRaV8ZrcLE7BWmfllcpxPjipAZ7nKMMbJ9PvAnXj9xCU2u63K27p2zYkQWJy5LR/VCSSukziGb37cjGX/FP+2E+haHX4vzrhwhrcN1NDrVqtbQfD0wSQ1grSAHFHEk7VQpTXD2P2J3ShjU54xO8GOCjbzjzheNbZRHr0jZdLuTMQxP99lMOUPJZlU9dKbLvw==
Received: from BL0PR0102CA0067.prod.exchangelabs.com (2603:10b6:208:25::44) by
 DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.18; Fri, 22 Aug 2025 20:20:52 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::b0) by BL0PR0102CA0067.outlook.office365.com
 (2603:10b6:208:25::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 20:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 20:20:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 13:20:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 13:20:26 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 13:20:25 -0700
Date: Fri, 22 Aug 2025 13:20:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 8/8] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <aKjRB5MqCrJ2Px7G@Asurada-Nvidia>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 032df5e3-dac9-4ffe-ceed-08dde1b9644b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+T45q6UR4KfNzsciJl3Dpb80JQFublKUe6jmV075zMZgurIrRZQUYmMmlU8v?=
 =?us-ascii?Q?zSVXCwfDj6g+QNu1TUj+ULck+KiI7Skhf5Fk7M8wCpIivA/Aq1PLUf+9eYnv?=
 =?us-ascii?Q?3zqSSPMjUL+DQQ749Yyt+yKjvL5pkG5uRJaHs6BV6YszIn/SZWz73z5oVy2F?=
 =?us-ascii?Q?Ye1zyOdeSPYdOIC5QEyC5ZlG3ZR/JhhQQEy3GVyfhYM5Ac6pXlUHRY1ad7rU?=
 =?us-ascii?Q?Bu714c1iwqC7k1dyk8EVtSWUFhGk2bHRO5mjtP+rP8D8RWinugZcCTvMowpk?=
 =?us-ascii?Q?TGtMZSnh2hJWhYeetRgu6RaVDBOf7xuQBEUIPewvdFje7Rwucc7miNjZbQpN?=
 =?us-ascii?Q?gPCdWncppVA+TsWNlsq501MU1yVTcErgd6qL5+XK1FuVOwQT1D3ctedMSJDO?=
 =?us-ascii?Q?35xv1sxcixZCj58QCmE4ngUeBWZXs3AdB+cAVgm0ko1QMpd+R6PNREaotpF8?=
 =?us-ascii?Q?cWAG8rWp76OsKFhVwRFBkJ0lh7WWdQeTFWx9KXtZyx4PGXVy07XR69aTIKSb?=
 =?us-ascii?Q?Stut3w1+YIqgDa8MJLLKrHRgAq3gM2KftvtSFIsV+pobx7aLxhHJX0lJ6Pqs?=
 =?us-ascii?Q?5aywT2pup8zrf77Y2CCzy5Vl6EYLqOhCYjLtxZo6eDX+qGM/g+Yt8KjAEISX?=
 =?us-ascii?Q?DnAY9szWZAORIyo2LWEMob7BGYgx3VW/i3Q3jhqc1yHd5icNJaUcQOgwkq0z?=
 =?us-ascii?Q?0MASV/jvMjLwc8YbUa6RMqsyfaOLgaZWYxjORGYjtfzTUrb3Q5kJDfwsPBhL?=
 =?us-ascii?Q?Rk3lBEbDX2AtVRgL4Nq1+hLRe7ewas5m0fL4P1n0/qnBNl4Rw4fNGLSGfYNF?=
 =?us-ascii?Q?9BGpwYguH2MyIkR/TBPO2nFFhs6Yefoh1tqQmkOHZKZARaUIwdHQ/mfuh0nv?=
 =?us-ascii?Q?sZUnr2Gb5PHggB3bGtN1p8cve+JEYBhSu+CkXXRYSUGwYEzqlqBtN66zdTTn?=
 =?us-ascii?Q?T60sBMLxxP4wEtQ846k9Q2UAJwg9MCPw8ag5mgnnVbwgzw8uQ+cbplUKXoG8?=
 =?us-ascii?Q?HR1Ny2ooyvt0j+ChNiTLO0bsrtbDgmvzx9oFlqL95LHOU9ZiGa3wOKNkUZcq?=
 =?us-ascii?Q?Y75kFd7X78BS6ZRh1phEbIS6gbS1pFsVTsNMVVKFAHhhT+3Tb4xVCclo0FhM?=
 =?us-ascii?Q?NAd70rQ8y6gNXKemaUtlbr/EvoESilBS6TPKkwNrXaTDMXwiqzzz8+eDiBtX?=
 =?us-ascii?Q?FadvfG8E70JrhKaJvLu4+5tM6R9P9Ml+9sTxx4wUw7C7X86uom23aVeIIvUW?=
 =?us-ascii?Q?u/TkhfZScm+4F+H9zKQzbJR5JE9SDPWxrnSDFLoGJOIu7EYhOJsVAKVPC8NJ?=
 =?us-ascii?Q?5Iw7DliTORQARSP39fosZO8HHNoFQ7/9LEKpQ/oTVRU675r9+nGNF3ir4mRM?=
 =?us-ascii?Q?VwOumcS0AgslUWoyU4ovN+Thw8iUxsAceJ9rHMQiovvJu+7/BfKdhVATeE1Y?=
 =?us-ascii?Q?SHtMyEngC4vlA583StmQcsR3NTgMTDpiATb7tC8MdqnXCGYYbjzVSgsxn/to?=
 =?us-ascii?Q?DL47Bw4rh1B6cZqbnYJNT+2Mlvm3ti+uE0/d?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 20:20:52.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032df5e3-dac9-4ffe-ceed-08dde1b9644b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

On Wed, Aug 20, 2025 at 11:30:09AM +0000, Suravee Suthikulpanit wrote:
> +static inline bool has_gcr3_table(struct gcr3_tbl_info *gcr3_info)
> +{
> +	if (!gcr3_info || (!gcr3_info->gcr3_tbl && !gcr3_info->trp_gpa))
> +		return false;

"gcr3_info" seems always pointing to "&dev_data->gcr3_info", which
can never be NULL.

> @@ -2061,7 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>  	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
>  
> -	if (gcr3_info && gcr3_info->gcr3_tbl)
> +	/*
> +	 * For nested domain, use parent domain to setup v1 table
> +	 * information and domain id.
> +	 */
> +	if (amd_iommu_domain_is_nested(domain))
> +		domain = domain->parent;
> +
> +	if (has_gcr3_table(gcr3_info))
>  		domid = dev_data->gcr3_info.domid;

There is already a local variable "gcr3_info".

> +static int nested_gcr3_update(struct protection_domain *pdom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct iommu_hwpt_amd_v2 *hwpt = &pdom->guest_hwpt;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev || !hwpt)
> +		return -EINVAL;

to_pci_dev is a container_of from the dev. !pdev indicates a !dev
that should never happen in the path of an attach_dev op. Or, did
you actually want to check if dev_is_pci(dev)?

Also, hwpt is "&pdom->guest_hwpt", which would never be NULL.

> +static int amd_iommu_nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct protection_domain *pdom = to_pdomain(dom);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (dev_data->domain == pdom)
> +		return 0;
> +
> +	ret = nested_gcr3_update(pdom, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (dev_data->domain)
> +		amd_iommu_detach_device(dev);
> +
> +	ret = __amd_iommu_attach_device(dev, pdom);
> +	if (ret)
> +		return ret;
> +
> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> +	if (pdev)
> +		amd_iommu_pdev_enable_cap_ats(pdev);

Is "dev_data->dev" expected to be "dev"?

Nicolin
