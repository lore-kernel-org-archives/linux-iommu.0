Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EB10A0B
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922903; cv=fail; b=TBRYhLWZS6YXEFuKvoEaFXKYZf0DpeGUTnD+4+cd7WU5gzS042zs9987WOOQIfm5XFNwbIZqh8qbFodUKd12Qzv5L/SWYq76grUzuYODfY3KaLSj8kS+O1VWl/04v2ii9Qgodt5b6uMczprco/vm1rI5Bh2+gpiLgBO0kwLoFbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922903; c=relaxed/simple;
	bh=ldxTONU4El/1EASf7TNF+JrnLel1jpNlwf5dfPdqLZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAHWJr5gw8ZdkvGu2PUCxHmuWfXln5lqoBc2gArJiSVkEo96R+H7disgMD5SZ/t1AK4zqS0IfxLObmZEAKkrhQuF7ek5EI6GxFAkJjIthi91Wh1EwukVJv5lIWKTfK+YzGp0C4I9LlradqotcGo6Q1JhfLKtqN1An6CGTZ6nrIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5tz4tuw; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5tz4tuw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Je+9IdkN+avD9vy7v8/eQm1O9mL/+E0nI2kcCu+w5izH5+GjRe2Ca6y9X6RYEXeIX4L+uIGqxs4iRUHGM/vATebG74TmHair1BcdYCBUXOFGvH8gU0je9TDqIHcSaGaAFTSIOliwL2I8e72FlrS39yI+cLZJEuM9u7Hno0cqoFVfZkQw2HXbBBK/4l3VMsRmjy1SwMMDaX6aWhb1DipfVpzRqbZq8PLDT77x8d2fHfJurIjxTgRocxVb9+8lgrUuvkqr7cNjKVu0Y1uwLWtpS0cQlWn6NXBItyeEQuYkHcnld9xDevCg/jH37cektieCgIe+b8zOTP4Zvxc28uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4hQjCfDFnWylIRCYG0IpdRMZcpotQGXbiOiz6XNbms=;
 b=CnGKWNestCFMe/gl/8oJO7Af0FxahRQoM0DqrBQT1uTJ6ljUAb7t3Ngtq2eTjdz8do8+ULwW38ynaAUOGnZXrswkR5k3kUjU/YUgQ+nnK4RIHCmGbvE78nVW0rOCa50y7/i3Ebpy+rXlPvdO5Wf45fwGgei2EwRom+/gVbI4w9O5hI0U7CFJMO3JgRRfLv/0GXTwMUn3SyQdQCyrlKg4PEDaBMQK8gWt30tkLqUcHLQo5yHim0QLKRTdRfxhqihwy++jBX8ZiCtEahcXlp0maa+XP1MJjC324diyiVYQoBeMgINy+jwWR7/bu+OjB9Fr6duQgeKi52aA29k4fm+DAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4hQjCfDFnWylIRCYG0IpdRMZcpotQGXbiOiz6XNbms=;
 b=C5tz4tuwm7MW7eVKDy6hzRRXQNw9L3lPU8yph4JI6lK2JfQW1VFegMxLjQsFHevr5pN/oJ+wY8lP1735e6DJvydr8Xqzav/QYTwnM+HK6ksIA3sWyq92Q3HY7aC14RxyQJHli2fr/l/cQ6ABNthbZUYkxfQpQAINgg0W1vosQwa9yypu1xFpEzDQBP+rAVx4kTl2zlToyqnLXAZk3j7DWL4RnUnjXYafsWxsnNp6BLLfwXtvqOkGXi+3CDwVhx23MG/d5E3QibTqCUB/nbYGBdy2WhSOyQMJ9jJOYf11OTOLXhsxflHIt7VGyx94tRJN7Z6JOwAAalw/kTIgBZp4jw==
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 05:14:58 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:13e:cafe::33) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Fri, 17 May 2024 05:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 05:14:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 May
 2024 22:14:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 May 2024 22:14:45 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 16 May 2024 22:14:42 -0700
Date: Thu, 16 May 2024 22:14:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZkbnvnaiV9nCHQOb@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <ZkDZE32JFyKprmpi@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDZE32JFyKprmpi@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c0d1e6-4cf7-4b48-70d1-08dc76304b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoqtFSew9y69LNnEp1O4RUyyOOsBzV34maJWAWERFCco64/NrkQyFT3CGGfI?=
 =?us-ascii?Q?Z4mSoH8KAu8qKyv63gusxIM+cpuHRY67QT3qrM+jVE0lNF1geXu5JTejJqtU?=
 =?us-ascii?Q?HsImyMBo7I75eR7rXHsSaR58SDAB46/cifhgTAABHHZiaeEhE/Bg1dgsKMOW?=
 =?us-ascii?Q?5SWndh97O2WIzc7afyt9MWniQkihSgfCD+K3UNRHfg+F5kwRZ33aApaoawQ+?=
 =?us-ascii?Q?EZSCpeOrzCIYkGW2VEhBstbgbrJhUVyCZvJWz2j9T6/+pe5M4IKIc9SzZDCh?=
 =?us-ascii?Q?2kUyquS5UD/4yTj1Yh7VRwXHJcClzdUNh5Gd+CBbo9n490BhxDYrBwF8tNuK?=
 =?us-ascii?Q?18LvU8d2yLnPiqHOq2ouD0zputYxEkbB9IWbgECXuENTkmOxSL3Blp85XWCi?=
 =?us-ascii?Q?6h+z1x75sV0B3eutMoI5L00aN0ti+KAg/zDuaV1YFBLsuhz0UFfEcAdWv5k6?=
 =?us-ascii?Q?uSJafm2yqU7AauYMMTVWI3+hrPmW/kCzVtxT6FAgEoveoic/pgSqSL764i/x?=
 =?us-ascii?Q?2lvAXtl1/L0a5j2WSA73DaOGctKVsOwbGe4miWqc6epTutIOBCfEG7gSzArF?=
 =?us-ascii?Q?Eu7aOx65WNChRQhzcFxq1qVfSOJDvNv7EaACV7nK3D1OZDRpGhJS6oAzUZIe?=
 =?us-ascii?Q?+RX9FR2RWgeQcvGFvHGLntmZcwM8zfuk5pjOqsCmJburhoZdfZxNUosL7WoR?=
 =?us-ascii?Q?cqWyCs4foLSD6AsVyk8qfiGqsEwh3hyxfCLJUMnktS3qdT/gsjcLeakFouTD?=
 =?us-ascii?Q?H0ldS5uJyyhdAVmn1XzqLoe7Cc57tcoSjwVQgtfmz/W+pAyzsrAsPO5pVp8K?=
 =?us-ascii?Q?jERMFNXa0jfWhed8CkkkupkoGtxLZsPPD9z3bt0eTuumLlkeGG5+mL3dyHvj?=
 =?us-ascii?Q?QSkMflXzlYF3lO8DzjeGKRMxNtMDnTIpOOYaObgDVSisaBgN06VnyTg8HshW?=
 =?us-ascii?Q?ulimUn1JuyuZH6y0W2sUV075ouE2h71LY7xBck1reJQL0UIkeoQ0YJwzT+6D?=
 =?us-ascii?Q?+YWUfcNu0V5td5ZFWegThCYwG6jx4YWqBafjfZGOLgBiILGk6WeykXfKcAef?=
 =?us-ascii?Q?5Bt4F9cSxI/S5nuGkI+rAYn9bCIqDB6QI0KXD8d9Xwlbpm7JF3ivu9idA2+o?=
 =?us-ascii?Q?aDjmEDiy8mDH35S4EFUWL1O3bC0FwuNJchSzyV31nEDBpu4ogP0Fxvm7Ea2j?=
 =?us-ascii?Q?h+oO2435nJRH2DRezH77GZ66h8b0Nt3n46q3Kwxi4fQYTeIEJuwXm85G/xp9?=
 =?us-ascii?Q?CCgmsIIusGo6hKZanIl5f/vqC/a3WlB6FBfGr5gHp/rixAFGaOuiudwuxYCp?=
 =?us-ascii?Q?jzm5riCf5QvT3ZRu3I+K4nfnslTGVgujAXmTmfJgurJbttieGRoikXi6z30y?=
 =?us-ascii?Q?GrTy3K+LbtuTXQgnKiod0F+gKYo2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 05:14:57.5895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0d1e6-4cf7-4b48-70d1-08dc76304b8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

On Sun, May 12, 2024 at 11:58:27AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 12, 2024 at 08:47:05PM -0700, Nicolin Chen wrote:
> > Introduce a new ioctl to set a per-viommu device virtual id that should be
> > linked to the physical device id (or just a struct device pointer).
> > 
> > Since a viommu (user space IOMMU instance) can have multiple devices while
> > it's not ideal to confine a device to one single user space IOMMU instance
> > either, these two shouldn't just do a 1:1 mapping. Add two xarrays in their
> > structures to bind them bidirectionally.
> 
> Since I would like to retain the dev_id, I think this is probably
> better done with an allocated struct per dev-id:
> 
> struct dev_id {
>     struct iommufd_device *idev;
>     struct iommufd_viommu *viommu;
>     u64 vdev_id;
>     u64 driver_private; // Ie the driver can store the pSID here
>     struct list_head idev_entry;
> };

I implemented it with a small tweak, to align with viommu_alloc
and vqueue_alloc:

	// core
	struct iommufd_vdev_id {
		struct iommufd_viommu *viommu;
		struct device *dev;
		u64 vdev_id;
		struct list_head idev_item;
	};

	// driver
	struct my_driver_vdev_id {
	    struct iommufd_vdev_id core;
	    unsigned int private_attrs;
	};

	static struct iommufd_vdev_id *
	my_driver_set_vdev_id(struct iommufd_viommu *viommu,
			      struct device *dev, u64 id)
	{
	    struct my_driver_vdev_id *my_vdev_id;

	    my_vdev_id = kzalloc(sizeof(*my_vdev_id), GFP_KERNEL);
	    .... /* set private_attrs */
	    return &my_driver_vdev_id->core;
	}

	static void my_driver_unset_vdev_id(struct iommufd_vdev_id *vdev_id)
	{
	    struct my_driver_vdev_id *my_vdev_id =
		    container_of(vdev_id, struct my_driver_vdev_id, core);
	    .... /* unset private_attrs */
	}

Please let me know if you like it inverted as you wrote above.

> > @@ -135,7 +135,16 @@ void iommufd_device_destroy(struct iommufd_object *obj)
> >  {
> >  	struct iommufd_device *idev =
> >  		container_of(obj, struct iommufd_device, obj);
> > +	struct iommufd_viommu *viommu;
> > +	unsigned long index;
> >  
> > +	xa_for_each(&idev->viommus, index, viommu) {
> > +		if (viommu->ops->unset_dev_id)
> > +			viommu->ops->unset_dev_id(viommu, idev->dev);
> > +		xa_erase(&viommu->idevs, idev->obj.id);
> > +		xa_erase(&idev->viommus, index);
> > +	}
> 
> Then this turns into list_for_each(idev->viommu_vdevid_list)

Done.

> > +int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd)
> > +{
...
> > +	rc = xa_alloc(&idev->viommus, &viommu_id, viommu,
> > +		      XA_LIMIT(viommu->obj.id, viommu->obj.id),
> > +		      GFP_KERNEL_ACCOUNT);
> > +	if (rc)
> > +		goto out_put_viommu;
> > +
> > +	rc = xa_alloc(&viommu->idevs, &dev_id, idev,
> > +		      XA_LIMIT(dev_id, dev_id), GFP_KERNEL_ACCOUNT);
> > +	if (rc)
> > +		goto out_xa_erase_viommu;
> 
> Both of these are API mis-uses, you don't want an allocating xarray
> you just want to use xa_cmpxchg
> 
> Put an xarray in the viommu object and fill it with pointers to the
> struct dev_id thing above
> 
> The driver can piggyback on this xarray too if it wants, so we only
> need one.

I also moved xa_cmpxchg to the driver, as I feel that the vdev_id
here is very driver/iommu specific. There can be some complication
if iommufd core handles this u64 vdev_id: most likely we will use
this u64 vdev_id to index the xarray that takes an unsigned-long
xa_index for a fast vdev_id-to-pdev_id lookup, while only a driver
knows whether u64 vdev_id is compatible with unsigned long or not.

And, we have a list_head in the structure idev, so a device unbind
will for-each the list and unset all the vdev_ids in it, meanwhile
the viommu stays. I wonder if we need to add another list_head in
the structure viommu, so a viommu tear down will for-each its list
and unset all the vdev_ids on its side while a device (idev) stays.
I don't see a use case of that though..any thought?

Thanks
Nicolin
