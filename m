Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1903E1C69D
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495929; cv=fail; b=mHTHZyhU4N7U0Rj6iQ8KbNJudS/VARRpv0mRuwM0cNG00CuuSRjVtVgUOQItl71VV5hK5cbvAh8Gr01Cj0NuG7R9+H+4QRuhSO8+lAPa9vcECEsvlPdVX5oxLdnAHSHjtloBbGxyyW4Eojl0jn9Z9tu+EzM6gIOGwEqVyKYiQoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495929; c=relaxed/simple;
	bh=b3YiWWT6s9Bu+IA3Edgpyi75G5U+na0g6V7QS+mz5IM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TngFP0cMc2UAFoJBQK5T6+eZeJcEh+6WNjAzJaBtzPdc50iOPxY+bYd83oewvcDQoq80Se9zMBOqHc5fKmS+JYrvWf4ktUBuZBD1BgjKMDm7+NLBzblPpgKCcX//4sATCMIzmEBjnFwYBp0Q2G0Pmb4PlDIBy8JfXSWLQsvDsic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qj2NvGSD; arc=fail smtp.client-ip=40.107.95.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qj2NvGSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8fDH1MA1goM6e49+k4NviEyrOvCT1OnG96pZUxDPOEjual9JiDOkukjlmD8Fi4haHDfObA2zh7607r5Z/LbWq3AlmvlKUZ91l5cxKpC/2BwiLM1tAHiJu1DdpLgTsFUHW8BWKgpT2bQkRhnsD/50KIaoIA3+azsnWRsbEMoWe1QWLcki1Z6UMEyULnYNePkf3ooZMZ680bFRCbvy4/HDh/aCgnwQa+mS2DdbCNOmEM0+NcLouQTGYun8NktI6erE/ztLx7lpQrwTvL1rEUXbp5+B17/06EezbxmX6M7Cx9xv5vcP2fds+1mu01dW+6x990Gb0vtwrov78wtRmlbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOKJrAuuIkX/LLZ4//FqgtU9CEGmogfCKTDNyPBJhmU=;
 b=SHtYK+UwTJMhtH0spZZ9AfiCjCcB5f5Mi6lTIJFM5hOc8LezGgg4Jpl5HWTWJtIDOq4jXGsfTvNcLgGxxj+Sh8cJGri0Mo6m4eAOsVTeqwBu3iU7HU+Y6GJP6aVrTM3PuJQ721Ei1BdW6FzDalO2LBCl3y1kTN3VjybNsX7yh2aGAbeKXgO95dGXwL++q/9rGVRfOeyF1wqEtSS0dG/uXfhgPAawVfZQVzwDdEKyknrd3v020Y7ioLgTGMX8bAJlsd/k+etN17g1mUrI+uxSoNv9clrfCTbnlG4zVDB3v51d84riWPXtTGdI0mMLeDeGB4V1P0Yie7F0SEYwgtY/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOKJrAuuIkX/LLZ4//FqgtU9CEGmogfCKTDNyPBJhmU=;
 b=Qj2NvGSDjuk04k+c4Ujd2gVo+iFT0I1LE/7PG32BXOQvh2ldGIr1rnlsLdp5UolKskbaEOPZb9+lfPXjUtY17AtYEVMtO6VufMeNytcziimFvoLPZs68X5zOGny1uGIXCdZJBijSsmjNYlcoxQezy70u+1QrQG7B3KccQNFTmO3geEhNbwUlzntBJWc2mr42n0twoEcDXIwsJJB3BP7H9jgYM9maCz70xRCzRjqDiXxDi6hwBipJ+SpCDK7F0i8Q+OWS0gC7e9hz8kdym4j10nzGmx8yTfjKwKJg2jtOk4YBQvEmuxdNkkAJSqQN1xa+0kSsWTmHtWtTLKR9WMFTqg==
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 20 Mar
 2025 18:38:41 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::31) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 20 Mar 2025 18:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 18:38:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 11:38:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 11:38:17 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 11:38:16 -0700
Date: Thu, 20 Mar 2025 11:38:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 08/18] iommufd/device: Replace device_list with
 device_array
Message-ID: <Z9xglleodSomdLPf@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-9-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-9-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b7365-2189-4f13-e582-08dd67de6f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbHKk2wRkYXMkbzsML06XCIq/3q6kPxiQtAJhm5JYgdJkn00Z+DRjpB5LOj1?=
 =?us-ascii?Q?RDUjquXyk37myfyPL495ziQbLKAq93sEeS/qqbYDB515iJSNSYYXbKVHa1ZY?=
 =?us-ascii?Q?TAnOAXeshezhME+wSxkndauLMGIm0ff2qPpVpl0nsLzontf38PT1EeefWq43?=
 =?us-ascii?Q?vMGHHy7FmJPqXlxPTYd7+MWaX+dYf23Jt8Xr5aGdxakj2JZnZNx1rI1pwbBf?=
 =?us-ascii?Q?dYZzobeYaYNILRafRdizXCBRjRQjKgGfKRw4UoCIoeBmTCNtHzSnpuJ8q5v3?=
 =?us-ascii?Q?Z7T1IoAYQyJIAektj8HOw9djad3CxYhqLZuXr+wNCqXxCkCjv5EFbF+J+jgL?=
 =?us-ascii?Q?zCNMnuoqYeD8r4tapr3Q+fbzqRLmUMx0Fts0bYgPEnLKt1/2v73qhwmm4T7t?=
 =?us-ascii?Q?NfzhmxLofhy0MTn6bm1O4NrnMEo9Dcq3z78fL7jHo+CV0duiSRZbhum+6VyI?=
 =?us-ascii?Q?le5kUf09MTF9K7iG9yrkTzVSJeCLvci7WID+RBJ6JcySt7uBmW0R9shX8nCN?=
 =?us-ascii?Q?Kr4LT0suovxy3YeM1+W5jFMo8/FOKxAgmKpUacYa1L/YOQxPKoqW6gcjZHcj?=
 =?us-ascii?Q?OWmx2yKKFDY3GLqcWupndYWJwGmbURVO0DG46Qhg+V6eN4TNY3AkklAACRMa?=
 =?us-ascii?Q?OpcrlTzToI6UKVnzpWGuICNAd/4R4UjPJnDRbyvy7vpzUbr0s60zcvBVwN2V?=
 =?us-ascii?Q?ouKey/T82OwHxMz+OP0V7pEV25V7erGrmxNjFsM6uLfS1gSqeDn/0JJ9+Swu?=
 =?us-ascii?Q?nLkbRHyUB97E7bPMBPOmEoBp0T9QKrGLykhSLxm2xER/M8pCtMuJHRVz14UE?=
 =?us-ascii?Q?ACiKtV5vbyG+s0SduFVfxbkaqNOsZVMs7FANFlryTt5TX4pXwJuE2c2d0tvR?=
 =?us-ascii?Q?c6tu66xftLRVLmXUb0RwI0HMR+NNZxCav1SXWRub/vBaRGn8XKSBUxDjbrq5?=
 =?us-ascii?Q?VyWUyXJTkA+tGRkPJ7i5FHYqZ37ZqoXq2tR5oy+HcnEr/GtHNH5cd3xNto5W?=
 =?us-ascii?Q?nupa0PsyYlVjX2k0P7B94Q6/Qi02tGT4xyuS9mRrAq044O5Fow+DTMOLbL6J?=
 =?us-ascii?Q?8/j+SzoejWak7P1r58oSEcwvTvD7Adj6tKBVED7hn6OjRTGLINUKOuigHJoC?=
 =?us-ascii?Q?2JnRZCTUJWviCnaZl8oP1Ac10jlIMzpYtUmj9Lv7Aj0oVBC3IHoAZvm/y/2v?=
 =?us-ascii?Q?wgFgaT3YGzYwufQ9uFyS5KkVjbEBzYsWHdDuuNuWKcrnrxAhwyqg0L2mIajn?=
 =?us-ascii?Q?dd/t/mOCsuTWLSZsCBzMKA8c7l3AHcXSGuZMCCqW0A3NJR8A+I/Sb/ly41MG?=
 =?us-ascii?Q?1CZzmXWfwPL8o8cvxCzz8WkFGqOSJjoPaEaOtroe43JxSmyWdpwchyncj1DN?=
 =?us-ascii?Q?h2IwXoydQCo5z1SwYJwMjRGXzIfTwAgxk+wMivBjK6mSmNaBOhhkYwYBX0to?=
 =?us-ascii?Q?fsnjDjclsVx5FmahVjFqDaDLSNdCVDePIfjZkg04WeCmmEQ3wDj4W5VotZFc?=
 =?us-ascii?Q?U/QiQW5syNwcpNU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:38:40.8001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b7365-2189-4f13-e582-08dd67de6f9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637

On Thu, Mar 20, 2025 at 06:47:34AM -0700, Yi Liu wrote:
> igroup->attach->device_list is used to track attached device of a group
> in the RID path. Such tracking is also needed in the PASID path in order
> to share path with the RID path.
> 
> While there is only one list_head in the iommufd_device. It cannot work
> if the device has been attached in both RID path and PASID path. To solve
> it, replacing the device_list with an xarray. The attached iommufd_device
> is stored in the entry indexed by the idev->obj.id.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Nit:

>  static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> @@ -625,20 +634,27 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  			rc = -ENOMEM;
>  			goto err_unlock;
>  		}
> -		INIT_LIST_HEAD(&attach->device_list);
> +		xa_init(&attach->device_array);
>  	}
>  
>  	old_hwpt = attach->hwpt;
>  
> +	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
> +		       GFP_KERNEL);
> +	if (rc) {
> +		WARN_ON(rc == -EBUSY && !old_hwpt);
> +		goto err_free_attach;
> +	}
> +
>  	if (old_hwpt && old_hwpt != hwpt) {
>  		rc = -EINVAL;
> -		goto err_free_attach;
> +		goto err_release_devid;
>  	}

Could we reject old_hwpt != hwpt (replace case) before xa_insert?
