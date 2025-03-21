Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A878F5B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527532; cv=fail; b=VQcmYaRqg+leFtxlH8ET4WW0bmzE+JXMrrdxD90+RBs9p+/xEBV0rPW/PePCmtEuA0z27mFZV1YZ3gWGGd47ZkS1DE1OXPuHOSw+/AMXnzKTb2TrkQU7nDnrd5Jdu2k4RO7wlR3S8TBYmqu5akbQuA1C8j1snfljtL5OhWs69Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527532; c=relaxed/simple;
	bh=wsT9GJnZ35cKDJaUnWQbEh5MZrfVD0OG61ShxB0KWFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3jFY48PjgLlqM68eL4tFMR/PxwuN2VOyi3c917l1s1TVs5tJZayt9lF2oU5wjkm9CIwDqwwKU4GdsTVUnZ11KHy3mGQjJkZewFzHuB6+JROAroLuI+0lrVRdzVLbYTDlW0aQtMBDGhRYBfP6GY7weXwNlCN7wJPNtIIoK15Fcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z02ynB9C; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z02ynB9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsJjCKqrSceL6ilZbQYPhmguK+OcUKltsdJLWP5wHS2aaOQHwUgXFYIlTpqEy+KuUMldYRsR5FrC1KuftKw9udpp/7O1wTzJiytza4/TVt/i9c9Ogb4eZsmfM4fgKrrkHY9qaGg4brG/t3U+40vWhTgd+yl3oJ2ZDn5LHy1HbhREokIkVRBbTuYmGJsr4/FNW/3Cs8OSHn1tlDW54YS4IDNNSCvjLPd1j7osnneBM99dMnebLRQqgr7edlD0E7hPTbWUfd2tavc4I0AWnBnZw4uCszoIEmb+3pXkzSDacgiQ8wIfXUQGmANW79H3o/BlGZMbXkIFLducGm7cqWqBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cXrjR+zZ6949qilM7AvKonczFu7CXazLz+6+S6qTUc=;
 b=c2FGYc4H2UhAZ6WZKnk8lmWHcMNft08otPiH55VQ4feJ+mSok9ask+GYXEuG84dCXUI2/XZFREAldf9B4FnuU6g0WsgcTi5QEYvWKmon5MuWbMvVAEwgFYgvQDIhSPD7vl/iL/mpn2YRQFyA2OyEUJn8AjIVEjYPgRNVVfxjHv7n6nJ5ykx1Sn1YRWzB+0sQc/aEXbf6pnyNZwI4pTNlXrBrAvqdCMy4/4tdOUJY72scUTfWopRPKouUo21ObCfTvHsHqgGfMeV43k08PD0aLSNOcxiXKdYqIn+rlJmTGMhgX+KNMyejNL8bhxURokXBIPuIB/vdCA1gETL3u1AoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cXrjR+zZ6949qilM7AvKonczFu7CXazLz+6+S6qTUc=;
 b=Z02ynB9CEgm0m2PayjgrpLoLeGlLNxpz2NG0saTnq3gQnsP9wzPxKdJfOuS/73wOb1wsNxadnR9AQt9F+CpYzwqWol9o6nT+ZN9SjVtoTFYAPNmbPcyRL0rqkNSejU994V7MVGUlGYbJQZfnK0N/QgqVi+umb3pT7GEb/fYLq9I0XBfza+WHRQ3n3ZNNl6dhJvX6IDMLqadwgw+88orbRuwmvzN+crzg8uU3qWAOJ+Ld5AbjaM1l9qvNid/xOqgC0YiVKbMSZPXGSB4bAo6QTP9/lHYrXZwPNbrf7i4z5mIEr+fg2fmlgWJaQMMSK1QqqbXjX1S6wmqMccTu4w1jJw==
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 03:25:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::8e) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 03:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:25:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 20:25:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 20:25:09 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 20:25:09 -0700
Date: Thu, 20 Mar 2025 20:25:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 08/18] iommufd/device: Replace device_list with
 device_array
Message-ID: <Z9zcE/RzQ11pFlFv@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-9-yi.l.liu@intel.com>
 <Z9xglleodSomdLPf@Asurada-Nvidia>
 <cdc6911f-bd81-4a24-ad5a-03a619832681@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cdc6911f-bd81-4a24-ad5a-03a619832681@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afb77f1-7189-4207-2b49-08dd682804fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kwt7KcseNPpAKv7DyZ8vDoIoSO9hxCSRTGd+Z0isPLjKy43Nq9T9C1B4q4jv?=
 =?us-ascii?Q?oqjMz1ZvrDIpgwhlAqlog5WpfrFbjOguXYmloLH/KGbjCS8oL2zhMjqCI3XZ?=
 =?us-ascii?Q?iBb4usfTeOVqu9tPmW3BffKLfodcDN79yjhJ91Yy3ur4KAUue2QsRUcoAMdD?=
 =?us-ascii?Q?zOUsP28JhCSI8GQRWkkZdI3yAv7UalxY63LHS2TQLLZ2tAK134Ogd2fbZUS9?=
 =?us-ascii?Q?oTnlikVnwrgM8QRR9CaZ6aAN1r5Wru+TBrfNaedHmYU1pr8xhORvn7OEdrTC?=
 =?us-ascii?Q?D8EwQp0JeW9ThEZ39XpzShRZIx2yWNKTnl3Z/avla2vfgXG6+roS5BOWQqCU?=
 =?us-ascii?Q?SssNZNFYqvFshlggALDT9Kijaonrw4vzvIhXv4ntin2Z7T/2m/JO2DiXBRSC?=
 =?us-ascii?Q?lMoC24nm1f/upfn+DInlQ/Uf3xViQo8fD78tl3uZJe+PT8EJIiN8nODGY5GH?=
 =?us-ascii?Q?7hagiKabOwKyV8IbcbYCk2msNRnkR6p+xEQdNSV3PtlfC9pdk4JY1JN+B8p8?=
 =?us-ascii?Q?FKymCm+wwpB+OwjFzJ6ASW+vl97Yi+0ZCWs2Ke8hZ+a6cLSgfqDJ1j+A04lt?=
 =?us-ascii?Q?19o0o/6LUG+kv/XwKB3tFhea2CawrK3EwAEZXXVwdkJbFLITSD7tM1A1ezZQ?=
 =?us-ascii?Q?lAINm9x5HpZfVTwuQaaQgjuLbzrkW5yB7y/WRKk+TTNDMifUg0UroZhERB5N?=
 =?us-ascii?Q?kRJfMlvZ5+PfU1LgPfcxj8N3Ule7Pjp3TpcQKPbJclVJoakGThj//7yNDmeC?=
 =?us-ascii?Q?2w+PliIUeL5CnbCP2P/audJ1fw6LGVsgb+4+AhPDCezaPEER+1qqUuuJi8e0?=
 =?us-ascii?Q?TzrVivGfAMOx434cykAWmJ3zWWS4MUAY5rMZU6G97B3WnwA4O9bKr6fxlyWy?=
 =?us-ascii?Q?RY6v1sSC3K4l4si5yR8kNxuXSFg9BoRkLa06J+FslAosyUau8QO8bE13KVZp?=
 =?us-ascii?Q?sRk04vDenAKlWZBlFX0y06RjXHA3NF1atnKYvQP3XyHXqTWKA4pkwLfwRCJv?=
 =?us-ascii?Q?wXRulrpGcJnjlmmFH+ha5rgE90lo+kz3W6ysJrs7dRVP5N7X/ol2IzW1kcF+?=
 =?us-ascii?Q?qMRg4WSVJrNX2qlyzuvKlJRg0LVVQ6sWWfwl3HNQ4gNumBcz6S9RMRY27ZEC?=
 =?us-ascii?Q?5dHXiTahTvRDwzrcrboxCUGHAIyOT7yiI3l9LHYQCg7Ybgi++n68hTblhief?=
 =?us-ascii?Q?nxtxjr6VXrTFHFCH+jqwGDeJJJuFyXMxlMl6ZYNsRBQcDZAR918Z271ipA/h?=
 =?us-ascii?Q?A0V8tkuvfly63+wa7W4+YClCYUmCbf1Ox9dFMQIs2hQmYdnmITgSK3LEE/96?=
 =?us-ascii?Q?xQQxGV6h4RlEBGaq7FoviROQV3+hQgTiLyaTu0V/BDSnbuRfqpfWRhRW1lt2?=
 =?us-ascii?Q?yZNf7w9n9D8Oe3zZsxZuoH+ANsTcs0Vw+jfyjtLrD3yQM8R0+CvSg6o5KJKU?=
 =?us-ascii?Q?yGzXfIxqhl+7ObfqyTe7vf9QeQqwUwUxku1zFLUqJt0GXvhWX18JFvCwA13P?=
 =?us-ascii?Q?nWiJr9DMEJm/V5I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:25:24.5931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afb77f1-7189-4207-2b49-08dd682804fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On Fri, Mar 21, 2025 at 08:30:10AM +0800, Yi Liu wrote:
> On 2025/3/21 02:38, Nicolin Chen wrote:
> > On Thu, Mar 20, 2025 at 06:47:34AM -0700, Yi Liu wrote:
> > > igroup->attach->device_list is used to track attached device of a group
> > > in the RID path. Such tracking is also needed in the PASID path in order
> > > to share path with the RID path.
> > > 
> > > While there is only one list_head in the iommufd_device. It cannot work
> > > if the device has been attached in both RID path and PASID path. To solve
> > > it, replacing the device_list with an xarray. The attached iommufd_device
> > > is stored in the entry indexed by the idev->obj.id.
> > > 
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > 
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Nit:
> > 
> > >   static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> > > @@ -625,20 +634,27 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> > >   			rc = -ENOMEM;
> > >   			goto err_unlock;
> > >   		}
> > > -		INIT_LIST_HEAD(&attach->device_list);
> > > +		xa_init(&attach->device_array);
> > >   	}
> > >   	old_hwpt = attach->hwpt;
> > > +	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
> > > +		       GFP_KERNEL);
> > > +	if (rc) {
> > > +		WARN_ON(rc == -EBUSY && !old_hwpt);
> > > +		goto err_free_attach;
> > > +	}
> > > +
> > >   	if (old_hwpt && old_hwpt != hwpt) {
> > >   		rc = -EINVAL;
> > > -		goto err_free_attach;
> > > +		goto err_release_devid;
> > >   	}
> > 
> > Could we reject old_hwpt != hwpt (replace case) before xa_insert?
> 
> reject it after xa_insert() has an extra benefit. It can detect duplicated
> attach on the same device and hwpt. This is supposed to be -EBUSY error.
> This is aligned with __iommu_attach_group(). I think this was missed in the
> before.

I see. --Nic
