Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC110239E90
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752514490; cv=fail; b=cYf5gDc0+vV9B3T3JrVhWv8qnlksE+RSi0arxf9o4nxnCsvLiq/IhoBoEwNzu+5Kf/OHfz0gHvo4MsWle9vBX/AxaomuxNWfccDMj6xrfcaTwVLKMkqUk4rGK89s1ZR9XhAdO++Sj/xfuXbVRfCzXYrzjarU2oeU3kGyrZhWDKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752514490; c=relaxed/simple;
	bh=SoiBPW1OziaG1dIW1MsSHIPjzry4YJuQSD4tGJ/StrA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plBXiIjzTEMFjz1EcCS/eWVjlqYcYZqibf6Sb6B+Pu84mQcjHbeUj/n38EVaEmXgYonf3nWBj6FSY9PgCtKoAExGUwl3XGEvSvcBLuno98GUZcSdheMqMRuhYWgqJDmKjoDOmS3czEHGKoZsecBGrIQDq9SSqb50qY2n7eGwLrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqdgRqS1; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqdgRqS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+LiRI00NtvZyEeA34srNhXO+k+qem8rNc4FuKNAnlZH/FhvfITotDbYqSwXQNJo51k+X6hc+dNTpS+o2cavD1/IFiWw1ILydKFXHb1m7b4BmlB3czp9IWFUBv71cNk6BF8zlqcAoq2xGsOuVFDBuTp8keSpEx0+sOgcyCboMrGam+uk1dYrKdT5Ly6/XzAIRypSqcgenVDrW4Ns3gXGKEzi5y/oM4iKgNcVicykoyKOQ9CA1GJ8KafZgIuNl5rQWHU0HThe0tK9fdSIKAg8iF5z8P8LxElvhk1+6Baprx93rU9fkao2TNZkpL7XxTQJMWEW2hfkNiHI7AN1lk2KjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHr9QcrDOXuaWJk+0qllFFP3btaqV1bB0Z5N9cew89c=;
 b=rbrB9xb8RaSBI/qnyXTn65QvRpDdboeTE1Q1fgtVtkVBs8nY3p+oz5W+efSCRiYHWYySQBEv8wOP5oUPYE+kAxPH8oL/MFGmD5APl8j9iwjUcetfdjgVoPC7ghdffcwynT3lF+ZnVosy1AtepdsuSVgrBxTJ6FtXgHuYrmkZZiJ6WS3GpNfehHsKvr+sZ2GPY/Z1CHWMrrxZIpab+9v62qMiMwJkpslsFFMRZr5fvX+u7uwKQBCO69dq/1P9i4yJhWba9OKRZdIx/GDnlrSej2Ing/zKtr5lup9mHtTe6wxIK7PV9FgfMIMJiPuGCTDpj2AFEBXBPWQkP727KOYpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHr9QcrDOXuaWJk+0qllFFP3btaqV1bB0Z5N9cew89c=;
 b=bqdgRqS1IcHMOCQ7GDAdVkaYxUr3aACbNiZlmxPysZsnKnW+Sw+iuLunU6dD9W+dyE93+N/OA+WqDCw/15FS4PLjWp9ilzeRP7re4kfnhOoV6S47uEH2vyX8yd68P2Q7+jIZ2emzbUQP0lFKbfBzmfw9VFdvf4M0x9q7tTniQIvr6GhkvXUEn1oGIGhTL35fOM93rQ34qa6siXPvMutFDbhJF/qL44IsBm8ERKLcgyv8ONQGNFdbbZL7ycdQ9mCJUg9LualC5/9DsYbjdvEsPt0H3NFA+KXrKvA70rdM9SV6JW21TX0lDtZukPUWmLF8NXpZdYIcFrKqBJbJJHRD5w==
Received: from CH2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:610:54::40)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 17:34:45 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:54:cafe::d4) by CH2PR11CA0030.outlook.office365.com
 (2603:10b6:610:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 17:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.1 via Frontend Transport; Mon, 14 Jul 2025 17:34:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Jul
 2025 10:34:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Jul 2025 10:34:23 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Jul 2025 10:34:22 -0700
Date: Mon, 14 Jul 2025 10:34:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHU/nVdsuxgRK+u4@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
 <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
 <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>
 <aHUzCAM8NKuFYbj3@yilunxu-OptiPlex-7050>
 <20250714165346.GI2067380@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714165346.GI2067380@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d4d573-4aa2-4efd-303a-08ddc2fcb902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAumE0b6CreyrjVAO0pAIbQ6AB1UDjJV8tPhf1KgLn5dC2ZmAnsZ2n0PYITZ?=
 =?us-ascii?Q?Z59xcnXxQHrWXWP7bauA5BQtgNrJ6N94c42Twc8W2kMEcAsf2NKh1MlcAOAc?=
 =?us-ascii?Q?WM7jTxQhmtS9X1o/vzmjIv/88pe6DqVPDgA4rS71WFd/+nz/057Va5usmMvi?=
 =?us-ascii?Q?ZZTIa7jatQOBSA+m7xcnaD4K9Uq67R04DYitmrKhtHMySZ3RXAyWphXtYbhh?=
 =?us-ascii?Q?1/sOClvjVFT9E1ciS6ytAzB57OgoSruUW+yZY55mOK7Voo5VlzMdnIgOW/xb?=
 =?us-ascii?Q?5heyZsHuNsMb2I3U4Lyud1Fx2/fy+re5J9DmugmBN/3oArzWHvIeaOVAh/y5?=
 =?us-ascii?Q?ZDam8ERR7DHOj4GqldadbiaaLyDB+KMxSz2hLwTlpByGK6eklFev4VB/tjLD?=
 =?us-ascii?Q?9AoMbZBzG/ydkGU8E+bU0i5QgJICQ0oJ/k50mYMZ/dqOBHmBISZUHeUo1cdq?=
 =?us-ascii?Q?VXXmD0detTJd31Op9hfqM6OrH8KSDCBi9iiJOj1VGGDUjVAWg9IhityGMEZk?=
 =?us-ascii?Q?Rfw1Cs1VLr0eLzYe8yFBod0+bUOS9sZA2GCV5TLdDiTP1pPM9+2xq3sMSLRF?=
 =?us-ascii?Q?I7LCA8rJM9+HOqkPrXjFq/6xEuAEVGv6Bk6hP0O+wlSQbMHZdX3k0QY28rgP?=
 =?us-ascii?Q?YzhhkvEYhu5Ttm0l+rTK2zCdO7w10IDasvgBsQdwPc6CaH8uKnZscT4O5g0j?=
 =?us-ascii?Q?d+EO9WLXeGrRt7BbaWoL/QxQcMclN1FMMg0/YaO4HTVCwbYdt+oitOw0/Saw?=
 =?us-ascii?Q?k62r4KH9ujRohFx1Pe6R6g2ykKtyuaZ2mF3Jw+Fw61WhwRL3gibskpI5aJMC?=
 =?us-ascii?Q?WZuGc/dB0DBVE0d62vcW+G6sxY4kKsJBn2XuSCQ5rW15Rbcm0iMZxjSLiIlc?=
 =?us-ascii?Q?t4t6Gq6PLDsRmUwYzdAOHHQt97YyuFHBfrXzo+smJHC1tEleYH4A9P3DeWMr?=
 =?us-ascii?Q?IqAFO3LAgA8x73I+NSbIa37kJWHBeT9XxQGXrTVxBNq0V9xNP0EybC+jQ8AF?=
 =?us-ascii?Q?XK9Lnjfwg+ueV1AmaGAcjUxQVRHF3kcB0UcSzTt1rp1EeEW9coAgbdFfqM/j?=
 =?us-ascii?Q?lwLydMXlKeG6AYF7AqLlY4gz6KsF3GEGdd0c93GBwGdpnmO42AKvdouUcAfR?=
 =?us-ascii?Q?YPB8QNQRYo0vV6LKQDWZjvPCuguP7gT97CpWl0/EjMOT1FOqU2IhS4ymc7VB?=
 =?us-ascii?Q?BQyqq9kcWn3YlQDHjUYp+yK1TD5bsV/vQhfzb5a2piz7YvWJN2udvAPoaPKU?=
 =?us-ascii?Q?zeena9wsi7A4wzX46Eep50J+ZBChJsb7ciMxfO7+w1hR1Du5wRMPohp0naq3?=
 =?us-ascii?Q?99V95h8PkxHLAx5Gw6tZLxfquNRaITV9vRdiyCtXP2gnVgX9z9MmgOAXrxpe?=
 =?us-ascii?Q?z1fhWyJ6i6T7anvlV77tEm8bciDXQhDDIVFTrlDNHa4Qjw7euhWECtOlKL3c?=
 =?us-ascii?Q?I7Z2MKuwJdZFpIdth5mHJqHXBIMBx6BuanmJVSZ7PyTYQeYunXiKhNjIGNWi?=
 =?us-ascii?Q?D/ZJZUkAULW4VDez/uxd2dD/LZM7w+DGkqnq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:34:44.6504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d4d573-4aa2-4efd-303a-08ddc2fcb902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

On Mon, Jul 14, 2025 at 01:53:46PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 12:40:40AM +0800, Xu Yilun wrote:
> > diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> > index 702ae248df17..bdd5a5227cbf 100644
> > --- a/drivers/iommu/iommufd/viommu.c
> > +++ b/drivers/iommu/iommufd/viommu.c
> > @@ -128,7 +128,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
> >         mutex_lock(&idev->igroup->lock);
> >         iommufd_vdevice_abort(obj);
> >         mutex_unlock(&idev->igroup->lock);
> > -       iommufd_put_object(idev->ictx, &idev->obj);
> > +       refcount_dec(&idev->obj.shortterm_users);
> > +       wake_up_interruptible_all(&vdev->viommu->ictx->destroy_wait);
> >  }
> 
> I think the main point of keeping both refcounts is to keep the above
> hidden in the main functions and out of the object functions.

I see. Maybe we can just update the comments that we are keeping
both refcounts but using shortterm_users only to do the trick.

Otherwise, we'd need an iommufd_lock_obj_shortterm..

Thanks
Nicolin
