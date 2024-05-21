Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370536B0D
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316219; cv=fail; b=i9TfR30S3LuB0ksYCBTtsnaa+Bpusnfz+9BFmtuyki+9i1izIMclnMhIMKmlsBhWMzkjQlSfbGz6D4p7lB0ynFD9Xuc6VUI8DEM94GUo+QFred48IYJynUuO908klhOT5DBK1eYIvBk3HweWKnXg1jPrGhIIF7Akm84968hS3VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316219; c=relaxed/simple;
	bh=gAeUQonP0OQD8Pigz6eeEOyyOPLHOzxfEYZ4GU2zCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tvwahLajVAicT7Ol61+vMJGOjSiXrSPojiZ1MKpA9wR5aYH5BaWF/d7bWx2OebHOh4sXvviv4iJGKOTwLoeQYAc3e4mRIpnvDlSUmrjWW5ALXaGAoJYu4vkwyDfX9n39K8EEvRdA/WawZAB4RSwgA2dFySR8BmGeVFKKyH2olA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CRYfIodJ; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CRYfIodJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkiFqfYyfccAfW95+q/6mYg6G7bDFrpEqy8GkCT6lhkN4YGiJ1Caq9lpNfnUW3MT8NeybWf7spMPvv8/9Rcl8kAQ5p9tXxJ37fiAKG9hebLpR6KK7+h10ItmhscJa++N9/NC7zpvC5bzwVmcm1ktxZWAN8qc5HCtnQA09aDNeW+EMGZThAQ5OQar753rE7mnIQ1HkjTuWvP5PADwj79NfNLv1Bl486WH7b0b90uO7C7baC6lCSKiHj00NuJc2tFLEhZHKbnRFYUe7mRDq1q/knZST3dmu/4gYrjcBoIY1uoACXnYfiabI7gsUpxoi2y94SMwr5y+QGa2eFS2UlYk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urmKDCN/c1yuNT3iC0Qy+CzxhZEjJJu4+gjP74XGxSA=;
 b=lSTj9l9K61UVujbYU6WsWmO0pEVMtuW8uQ1a7OuWnXtA9XRZERo/6rvDmgXdHQmpmMhANkqwm8Jfau/5bfJaxltr991H/e6hFSbV9B6YRfB6xKzsLwcN5ksrbdFoTTVobFAA+6mSsJQVBKaAyyXVtQXuAAMQ0k43Yt+WooLQiSo7+dNo8FSVfBsJipQCWY+mVjEmnOR7LLo/Qt5MxHdm1BgviqqzXb3TTVi0VfPDNo4qwv8jYfZ27ezoJbxI6vfU4MbdVOkcuqpS5fMWU1Qyq6O1TNAeKQI9pwbkk7vjR+XF8YN3zQyW4cKeccylFfHqRx7zbLi+bCHE/qNUbpekQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urmKDCN/c1yuNT3iC0Qy+CzxhZEjJJu4+gjP74XGxSA=;
 b=CRYfIodJkf7diSIKOeq6RZiruupcH16pEmODf+6+/tmuQzRghk5ExKk7YcxXE/6VFu4liwhHJ7qsULcbdlIzx5uTCoaRtvXWRvE00HvXxSgxkwO7lJqKaHarE0Ap/ed3wOavakx+WLw65Uml8uty7cr44iRvPnCe9gFj0OiBtCJz+uyEfeN8KpPaRzENY0JRyZKn3lZDcpJuhzDdqeXqlDZdexg6V6aFJwKzjtFr/5JfWRKRaXJLtzA23QOla68ARVLKcMOXYpP6nKgbITDyrPJ2CblZwLczYQw3ceYXrhJiMCIMwewOPnRjTF9mowalqEKmBdS9yxkiSAlIREgowg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 18:30:14 +0000
Received: from BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe]) by BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 18:30:14 +0000
Date: Tue, 21 May 2024 15:30:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240521183011.GO20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <ZkDZE32JFyKprmpi@nvidia.com>
 <ZkbnvnaiV9nCHQOb@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkbnvnaiV9nCHQOb@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To BY5PR12MB3843.namprd12.prod.outlook.com
 (2603:10b6:a03:1a4::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: f506ca8c-7112-428f-885f-08dc79c40e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xCHag+ex3FLn7IV5JrtQtZfyxjN1aLk6/1mEjmA2UWk8QM236nGzPGOWsKM?=
 =?us-ascii?Q?hIkNzWr+DLl7ksdaNEC/Gp77UKc9WdKamRPhhPl8j1a+43KHdgD8llfBUApd?=
 =?us-ascii?Q?mvA8oZINYDG1xvs2gfRCuBJBN9EXIA7CuMUrA6eaetzWkSk0kKyJRX4+Sgnt?=
 =?us-ascii?Q?942f2yyBR8lSCG97Yoz2mR/FkQYqrkNHpueC6kKXDGThN0npx6D9FzCNFhlX?=
 =?us-ascii?Q?k0RBhsWTvhaJpW0KHvW/oca5DzgiaDLAqMXPeFE72+zZ6n+MlNkAdmMkCNqj?=
 =?us-ascii?Q?PU0z7Q4RRWPR2J/d0n0LXzHEIUuvd4AZbFdq7XfcmgDYdyWyE/euDFg45h/T?=
 =?us-ascii?Q?hgkr/trD9wyXKV3ISJ37giHwJ+oe97PA51ME8RE7evf7YU7hE7XdVvwd0yJT?=
 =?us-ascii?Q?gqRdKv+tAb94H68u3bGFjJqQVQGtTZTx8tcqSdBlof/mF7cISslN5TMMdfRT?=
 =?us-ascii?Q?SkDJo+RfCQ2pP8YZj5sMOalq6wF9+qtizuX7BuEB+WitoCwUBak/kNdAGQez?=
 =?us-ascii?Q?hdzzO0OCIDpOe+115FA3380f9OAe37dlmiSYOHaLA9XqENdbBmvC6GAU5jqA?=
 =?us-ascii?Q?ycVdkkgDcqmzQbdJdbNs+WxOXgonyq8JG8b4DmpXvBhVP2t2oZaorbJUUl4/?=
 =?us-ascii?Q?xWY/wSGE0KevYbzgZjNrHCbq+110Rlo2hHbks8X4yfvpCTKAGxPI3uCr5uSP?=
 =?us-ascii?Q?MSG0St7i1PtSDf9YqC7M+BvhO1nlOHnHUqDfuF495NpbUy4oLMlSbTwsHFS3?=
 =?us-ascii?Q?XWxpQ6n2eIeUXpWer7s955cPopYni6WrksqmP/JdcnUrcwzsWJFwZCQtdn3b?=
 =?us-ascii?Q?JD9CWreplFwZbMcF4VHJSQwt5BBXKxB2+3HOa/H9dosz+3/jYF5TB/G5sluV?=
 =?us-ascii?Q?yISLB9n99I8t2NPWTFXRAOduNS1d0pnu2TkAYwq/Ziumf11CGz68uMlI8mIx?=
 =?us-ascii?Q?tAjFPF6aakcr8IsWWUG2vgOW7yyAbD/e7o+7yYSyDSUrUYE4jEuGHdRMSl2a?=
 =?us-ascii?Q?HwoUbR+mmkhhOh2L1XLTcNVd/M4l2K20umdA8IfXWngUtKYmL2cnu6nv5t2A?=
 =?us-ascii?Q?LXImk1ZNl6TE18N+ZlEiFCpq/CpCkCEjy3klkJCWVXJVsANimlyUjJTCDKj1?=
 =?us-ascii?Q?zDWElrt5bbYFJLbYmkuA0dl1mT2lQuUU2qYU9bhVf8avOlcQlHCbaSUnQ9hA?=
 =?us-ascii?Q?L6jtkSajHwhjf/jpc+0aotTB1qgJ9JpsYQtDbjDHzKM4mgXqtLS9Jar/sxNG?=
 =?us-ascii?Q?lE1caPo/n9fAMucdSzxekpTXl1U1XEe10Kjyxh1KrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Q02kDOS/J1OyFsVzH0L9kGLVMsl63BLXDBJdRfIXMcao25WdfL/o1xW4WtD?=
 =?us-ascii?Q?+lfS4Z5tgo8KMp6qPcAAFp/hrRqgCeUAWjjDMkSHiOBaJ0GlqBc76MtdztkL?=
 =?us-ascii?Q?Hxl0z9H3Q/Vz5UOpAqWgbsa/J9PR3UyStRFRnOrmkun6/6yru6tQezEFPeCC?=
 =?us-ascii?Q?K2bkjAx6tHMsZMEte1mdZFj3dGzJeBxDIQ+hJVpi+MNzzf5UFHTvoZc/tFha?=
 =?us-ascii?Q?ByST37HSDhijaQWJW+vXC3puGujqOM25eno3/+nzZXWPlDWC0is70YbuDMhB?=
 =?us-ascii?Q?7y150GbyHa81Jt1zkV8TQfiOJiO7cE1bjNp1SzGpUM9iV2t3shmJUjcCoMkA?=
 =?us-ascii?Q?wK5aESVRUoz8ouSAjbGkf1qLxWvvMtn60IrQyDtiDOpi66sh3QCTQ0vFFbpY?=
 =?us-ascii?Q?hFsCeyMTLnWQzWdCFDPfyH5JFuxQTkbCrOJxVJLhdU38TrK8pwUTu4thU5Tz?=
 =?us-ascii?Q?wes+OIk/pPdjdOraXKRwHc6I3/S81M1ALggWi1bzaMAlB7HhT+99Mu7GUZ8R?=
 =?us-ascii?Q?SB/iRR5gg9h2POeJSa5aoh5+RkE1SmiFAKvg19vO0daZvbSdj1BdjsY/Ve80?=
 =?us-ascii?Q?ceoc1Rwe9JMWRnCqgC5cT4+LD4ylzC1Gn5/Rvvsjup8FwPpL07l5GHZ/qIze?=
 =?us-ascii?Q?6DJ3eQ0UQ659yMTPy4QMWOAl4eTy2GJ2NbG+vK7yOFCV/vkAFg8I8ll6uiJt?=
 =?us-ascii?Q?MXglRa2WKw+kXoCO/N3N0rsbY4+kpVciMelyW/Z9qYdCOpO8MOQZE2Ip0tBC?=
 =?us-ascii?Q?8Rohec8EXMxGmE4hKtqmQtKegbp+QSNX3aMcN30fEwo4UVd3dJP2y2G32uPK?=
 =?us-ascii?Q?8QTo41BO9XaNIMvDZrTvyBFcu0JhP3RFZWWbafaWlyMiUXsaqa0JMd20cRHc?=
 =?us-ascii?Q?2cgwowDpcn1ImkDc6471rlTrrAoFzxU9E0RQMgsW9N6aWBVNzkboz6BlPT2I?=
 =?us-ascii?Q?MQi1zCvB/nCTuYHUZVY31jhdQ8TU2BswudoH0i/lESJkLi/zJyO/7RqfnSXT?=
 =?us-ascii?Q?1t3oj5N5C2voSjAFjYslfnDigIoEQoLn/BWEzm0pybrvphVsBbUzx+FIUX+3?=
 =?us-ascii?Q?ygdxX7PkNAmAL5SgOxeaKuFT0Kpw9ujMnWrUdi0EoJv60gcuG1Ne6tJd3CDx?=
 =?us-ascii?Q?ahMKIleYOcjs7kNnlqkIMMY5hzPQw/31uK5MItSiVGSFcqRnnzfVsDR1nxvB?=
 =?us-ascii?Q?vslbx7hGbHahYiJNzzoeO/ltwQv9XBLTNDbhbD3do0OtThlMicTdQpiFd8/n?=
 =?us-ascii?Q?WGI7IY9c5cGfoIf+HHLtB+8elzmA2FvB+dqlO72dBqzUQdnmS7QdCJWkSCck?=
 =?us-ascii?Q?rZstGOD/bP0D4cVy5EHRHT3AlGU5vcSXI/lBsdtlA/vronou/Le7bJtS67JU?=
 =?us-ascii?Q?MI4DzzDOcFCntSgnPQ1NhevFgjGCaGCwlEW6D3jlE94wZBE74GfZ5BBpRJI7?=
 =?us-ascii?Q?h3uT+pjN9f5J5wzRhBl/iLslFWDKBuwJ0+PaToH3zCQh/nRJEH2fgJod5XqW?=
 =?us-ascii?Q?/LdrBl/YSLt2bO2stDE/nsfSBJmZ6H9LAVeP8lsSjMxMXVJjZApsYkGBq84y?=
 =?us-ascii?Q?o2Ifn2XGV5f8FcQEFQw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f506ca8c-7112-428f-885f-08dc79c40e5f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 18:30:14.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tanT7N/nOzRmNC1mdIPpBBfEJW8jLH1K1AAPckH39xbV6V6WwkXIzOpwLKdfx2jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

On Thu, May 16, 2024 at 10:14:38PM -0700, Nicolin Chen wrote:
> I implemented it with a small tweak, to align with viommu_alloc
> and vqueue_alloc:
> 
> 	// core
> 	struct iommufd_vdev_id {
> 		struct iommufd_viommu *viommu;
> 		struct device *dev;
> 		u64 vdev_id;
> 		struct list_head idev_item;
> 	};
> 
> 	// driver
> 	struct my_driver_vdev_id {
> 	    struct iommufd_vdev_id core;
> 	    unsigned int private_attrs;
> 	};
> 
> 	static struct iommufd_vdev_id *
> 	my_driver_set_vdev_id(struct iommufd_viommu *viommu,
> 			      struct device *dev, u64 id)
> 	{
> 	    struct my_driver_vdev_id *my_vdev_id;
> 
> 	    my_vdev_id = kzalloc(sizeof(*my_vdev_id), GFP_KERNEL);
> 	    .... /* set private_attrs */
> 	    return &my_driver_vdev_id->core;
> 	}
> 
> 	static void my_driver_unset_vdev_id(struct iommufd_vdev_id *vdev_id)
> 	{
> 	    struct my_driver_vdev_id *my_vdev_id =
> 		    container_of(vdev_id, struct my_driver_vdev_id, core);
> 	    .... /* unset private_attrs */
> 	}
> 
> Please let me know if you like it inverted as you wrote above.

Seems like a reasonable direction

> I also moved xa_cmpxchg to the driver, as I feel that the vdev_id
> here is very driver/iommu specific. There can be some complication
> if iommufd core handles this u64 vdev_id: most likely we will use
> this u64 vdev_id to index the xarray that takes an unsigned-long
> xa_index for a fast vdev_id-to-pdev_id lookup, while only a driver
> knows whether u64 vdev_id is compatible with unsigned long or not.

This seems like the most general part.. The core code should just have
a check like:

  if (vdevid >= ULONG_MAX) return -EINVAL;

And if someone wants to make 32 bit kernels support a 64bit vdevid
then they can sort it out someday :) I think this is not a big issue
as all iommus seem to have some kind of radix lookup for vdevid and
want it to be small.

Matthew has been talking about support for 64bit indexes in
maple/xarray or something for a bit so it might sort itself out.

> And, we have a list_head in the structure idev, so a device unbind
> will for-each the list and unset all the vdev_ids in it, meanwhile
> the viommu stays. I wonder if we need to add another list_head in
> the structure viommu, so a viommu tear down will for-each its list
> and unset all the vdev_ids on its side while a device (idev) stays.
> I don't see a use case of that though..any thought?

I think you need to support viommu teardown, at least from a
correctness perspective. The API permits it. But isn't it just
list_del everything in the xarray and that will clean it up enough?

Jason
