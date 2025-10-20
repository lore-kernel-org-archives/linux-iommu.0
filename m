Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09E261B9E;
	Mon, 20 Oct 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987172; cv=fail; b=Oqx1AATPCwiLkN5N3L0x/1crx/k/lt6gBe9BH96u9oR+gOX0TWZacG42beINZZ5bTjEmqHdadKOm/qkl8RFBav/JnA6j2U2InYNaY7xuXZW5eY9pLIqfPEcDT6bHu8UpInUoftbbVcknvlShwnd/5KUYrLmyuXXQy2r/L+4T5n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987172; c=relaxed/simple;
	bh=H9pHGN9z0lMz7g3JOjrwXBMq9tBEGjWJ1qMAt5F4jB0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR6Xbh13kM50vp8kBBHh5gclwcy/9OfVs2nsz5xa8vtmMSYDjAkhL34uR7wt542rjo3YVcEEviBokmukl7P5xzKaxcsoUU0tGWmXD3JLXCcTXTJ1rTCc6ISaqmSsLUUgUbK3rby8wZBvX6t6IWp0Kt61pnPxuNS0KA1/R9Q+4js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHCnGm8P; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CHCnGm8P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXUJpLdJN5VS7xy5t1FPE+1SU30NulGxDG9gSf0OJ2IYyZyAnidpt31GERw2sctLJAstJ24Zhr3esRxOwZzkfpXim/Lvyv4Znwort3RIBLt2bP6+z9sijuFL1DWQLANpLDuUitYeQx55N8tciJuvIHGxHrftXWs/Q8Bl9wTVpkSXaoOOspDmp8jFHtpm06DLAOSi8sUuasHc0DHPlrH1J4w0j34NNU2izWlRgz+/9Tjvpx08NVdZ/28/SwxdB7ei+nTJrT+h8WcBlbfubXjB0ecIpNy82vdg8XDkX3PVQDkFDJ75V7elX4a2kOPepKGLkKQzghBV4l3A1Uf3iJCxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRtTZfToYpi/zar+4kFzgnP7oIxJF3wyFOsfagsPBD0=;
 b=cQ99L7h36JmXryKnFTYR4DEtuWxA7CsVtAH73deBLBJ51GE2NI9BEn8GjjYenTU13C8SXXtTAu0IX0wbV7GltTaOQSx26qRIXhfBCt2guJ8cBDM05QlnUcfgJ4KTbyLC9f7vD/2TJeGPYLWrAzfqNkrfs/k9KQYMRTGk54Tn0b3nMGtMSKq+7wGsaGaXFfpWnbtdYSNEaHS0AmULbj1/TiIzQLIrl5qAAtVDrk3REUF9aKwjTrgMxBgxujiVFhtfKuynw7Nzsi94xfvCd2QBbStbb6CAPb3Kt1cCiJVbRzCm/kFADxkvKkwA7oXAAtA4lbNTRJkbZJhJnXiG7JboeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRtTZfToYpi/zar+4kFzgnP7oIxJF3wyFOsfagsPBD0=;
 b=CHCnGm8PyZe7NXbJBac8OfXhrNH/s9YDnVnn5urpgsrCFC2xmk7sFtv5IKjhrkhrbVh/GHMjc+0VPZoCOURTuYLZkpzz/ytIIhbTYT8HpRcAwr5N6lzxVL2vKfPN1zJ3hX3sS65OhKIgEVFgUp+9cTguORp0bqFiRkU0cVxJGaTuXR0EeE94gdpP4FyWGAxHL5ufnu3BHC/7KP3DNR+ZuZ0dsAK9MPW/Szmck/XsyFPPVLh62mm0IhWYG9kViLEboFU+642u4v64i0+hWX3R3pDkFotQPfZWKJW8gJTAC2xe7WPH1eWWD2yqoGxG64+xDUd116G8EOSBKL7OMjXedQ==
Received: from SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:06:05 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3c) by SJ0PR13CA0026.outlook.office365.com
 (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Mon,
 20 Oct 2025 19:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 19:06:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 12:05:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 12:05:45 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 12:05:44 -0700
Date: Mon, 20 Oct 2025 12:05:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: kernel test robot <lkp@intel.com>, <will@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <aPaIB7yJvlHba/9m@Asurada-Nvidia>
References: <14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc@nvidia.com>
 <202510172340.XyneWIPI-lkp@intel.com>
 <aPKxBh14fxnVIXK+@Asurada-Nvidia>
 <20251020121225.GK316284@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251020121225.GK316284@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 680ac667-bee0-4d33-9b8a-08de100bb794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FZ1HhnR3fiZ0CBIrFNiutDWAh3hE59wZH4xc4pPhDf/c60w0vz+e0uxYawzd?=
 =?us-ascii?Q?0BvbiOGu/Z8GYVJSdmp3DNedrJbZD1Un7sgEV3w94l3CS2Y5SV1Y9cJ3sEvv?=
 =?us-ascii?Q?2G6hQk2TOMEN+aVqArgg6+I/aTT04Aq7ZER9Fll8pPpgEiyqDsi1IjqqLfmU?=
 =?us-ascii?Q?6P94quH+TFJV45xhBKd6j1BM4AIdQBr/tucoCG5A0qV+LK+g4Kh48OYjob2N?=
 =?us-ascii?Q?WXAJX54ZyFafkbpaWg3Y2G3XgsQ5Gcx/ItPUjywWGIsWzaxeQVpLdnyOgtY4?=
 =?us-ascii?Q?ET6yNerBasVmyrev/S/YD+68HGEnvLvCY1P8mMzb1D1BbltPOPnx1ehqzDnz?=
 =?us-ascii?Q?o/YMumzAoyo0CmKuq/HGwVAQr2SH068h3zmFGvHG4LsDj44fTe68ctLswbuM?=
 =?us-ascii?Q?XOC53vEgkbWYWY4gb+AUnR4EU0ZV9RzAn6tCvRsm3ZfvNvxbDGHNhIjpNacg?=
 =?us-ascii?Q?dvdYPXyL5lgCULMx3LuESdcizal/f22qHrLaFfP20/wpOhN/QsuC2EGNpaDm?=
 =?us-ascii?Q?F99IP3t+5fkrAAsWZzdNbM56V5u5JmqDhpHwksiK716j5/QO/PQjcKS6x3Zv?=
 =?us-ascii?Q?rVfE5jpW36k4WKhe3xI364GjPKWQZpdmybI3GJEs41L5dBcjepdsgr+xPGda?=
 =?us-ascii?Q?yZnpZHZbC+1dNni2EY/ZcAhFhkeCTGqJf4fBBs45McYO81dCjmEcigSUm4Tc?=
 =?us-ascii?Q?SJZfQRTuTBR4YDCERkxVzez22NgJgVgVmtNcRbV8m+YOu+UPlwwqqZAzYVvz?=
 =?us-ascii?Q?2pn7tgGKZHr6/Jh8k8VkPsCUiv5+rINE9XvRbfmXM1qNKIhNAGl7+FdMsJrz?=
 =?us-ascii?Q?KSliJwjeUsVH08QwR1xes0KcXo0VvJRm/n2LLH6DLudC0xnQsQYVf8LHJApB?=
 =?us-ascii?Q?UjWHgz/XNF0IbCZX3gm4ALQojunTMwCU6+pLhJi5C9h8Q/l5CfK30uB7Hu7x?=
 =?us-ascii?Q?vAl7WRuUCbYnKIzgMBO1BYqceYTQqF3cTq4c/340a5CAskzOO1KaDz5wzO3k?=
 =?us-ascii?Q?9vUwz9KwRD3r6lYGCIaH+nKsjYH8ORAx+vPhw4oyyqS0sqqQcF1te5hMEfvw?=
 =?us-ascii?Q?v3kN3PacHPFlZ3KiWI3okmCbuUqQhCrFqrTs69WlevxK/N3BytHqRST9w6xQ?=
 =?us-ascii?Q?m09VLJ7qOn/sssWGxKzemM4E2qKTYbODnfuPAnY1V4eF30s5tIOo7odqT6IB?=
 =?us-ascii?Q?XNp1GQtV9NxnT1WMfGyTx5WfANkplY22AqTyVoIJLL/d74eVLQgPQkG65QNE?=
 =?us-ascii?Q?+6LDnkSAOs83dtrZ/v8iYwY4kckYzA6sBd2D4W0XnpMXw7/yYdu2HIFrF3pY?=
 =?us-ascii?Q?MchzuFaGqDQ/ifyJ6dyK+l+dcYt/TYQnEX8ODeI/w+ZDUruumKcLK3ravx9V?=
 =?us-ascii?Q?a5u7aMd59uGKf76HRVtl2BtoAsVyospgXAqRkYkD8/dwy6PAWmCU9EXZHcmd?=
 =?us-ascii?Q?u7K1tNdi52h+Eqd040hrXm27sndm0uLf/GuUhjd7R/ePOofAljzUegMc8nMc?=
 =?us-ascii?Q?bp5MlP1gtnZkkRCX5XlLCeLplqS6feI9ALTNK4wQ+dnlHbU95a0tCjF2dVca?=
 =?us-ascii?Q?3+HPS7/pC0R5x+I0buw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:06:04.3494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680ac667-bee0-4d33-9b8a-08de100bb794
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447

On Mon, Oct 20, 2025 at 09:12:25AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 02:11:34PM -0700, Nicolin Chen wrote:
> > On Sat, Oct 18, 2025 at 12:03:27AM +0800, kernel test robot wrote:
> > > sparse warnings: (new ones prefixed by >>)
> > > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_invs **invs_ptr @@     got struct arm_smmu_invs [noderef] __rcu ** @@
> > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     expected struct arm_smmu_invs **invs_ptr
> > >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     got struct arm_smmu_invs [noderef] __rcu **
> > ...
> > > > 3208			invst->invs_ptr = &new_smmu_domain->invs;
> > ...
> > > > 3247		rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> > 
> > Looks like we need:
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 8906c1625f428..398d8beb8f862 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -1105,7 +1105,7 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
> >   *            to_unref argument to an arm_smmu_invs_unref() call
> >   */
> >  struct arm_smmu_inv_state {
> > -       struct arm_smmu_invs **invs_ptr;
> > +       struct arm_smmu_invs __rcu **invs_ptr;
> >         struct arm_smmu_invs *old_invs;
> >         struct arm_smmu_invs *new_invs;
> >  };
> 
> Isn't it:
> 
>  struct arm_smmu_invs * __rcu *invs_ptr;

Hmm, sparse warns this:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3257:33: warning: incorrect type in assignment (different address spaces)
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3257:33:    expected struct arm_smmu_invs *[noderef] __rcu *invs_ptr
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3257:33:    got struct arm_smmu_invs [noderef] __rcu **
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3275:33: warning: incorrect type in assignment (different address spaces)
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3275:33:    expected struct arm_smmu_invs *[noderef] __rcu *invs_ptr
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3275:33:    got struct arm_smmu_invs [noderef] __rcu **
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3296:9: error: incompatible types in comparison expression (different address spaces):
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3296:9:    struct arm_smmu_invs [noderef] __rcu *
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3296:9:    struct arm_smmu_invs *
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3354:9: error: incompatible types in comparison expression (different address spaces):
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3354:9:    struct arm_smmu_invs [noderef] __rcu *
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3354:9:    struct arm_smmu_invs *

3257: invst->invs_ptr = &new_smmu_domain->invs;
3296: rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
3354: rcu_assign_pointer(*invst->invs_ptr, new_invs);

But no warning with "struct arm_smmu_invs __rcu **invs_ptr".

Thanks
Nicolin
