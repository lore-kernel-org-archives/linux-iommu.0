Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35B29AAF9
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891108; cv=fail; b=Kr5b1WWO196YlA0cZa2wi2nZiNQFAMzNCZtokU4tzPHdAUX5FXH+ROKbiA+KBjC1VMqnoYGcCpvAuroEJnF/sQp33yUmB699qlONxeV58v9ccQxZ9Hr7BlgLsRzV1YEXQ2rZtWWOIVdStYUOvccosnOkwLpZvGd2nXqhB6ylFLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891108; c=relaxed/simple;
	bh=MoYxdSytZdQk/okI7bHl7LJUeTCwS7ooBalOQToRPXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POXfzf0uwKOkB4sc8H+uIJ3Avuz5e6sJttd+oxZwi0u0fhU1RgF3CQuWvN6rOO92yLgL6YqEuTY9pweeMrn5REiQa7D1bVghRpUUE/s8G0ayzblGNAU4c4jN4d+ArxWlB7FO12HwlHMkgDZoNWSfiKwzxKSxBjqANWbGDso2s7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BsUyTIIv; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BsUyTIIv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9y7EikTX7tQ4NiY+qvEhF9epNnYQIW837kxmd2IxHl8pc0NlYkbthR50NsgwSgtd8wimXCyQ44Vtebz8KxTm8ZCFsYMN/pXl1QVawglOaIYmsM2dkR9sOudEJ6qmPUXSP3CBXMORPTd5b/QLNa8O1ub9fiM9RoEitd7G38dzspRqIQg8AK7ypaLJ4AVAS6OgN3ft4glebINqTg/BuZ15v+U/sQXbg3vlQcPZtBzBPnCTvRniG45RS+ajdv2y2TItGkzegrxdq6rUzF4usVEOG1/d1GVeKphQoeA3AvOHKD9hZAsrboopgFR5FJHjq7UtFyjbpVNksn/lCTmDrBZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCg5ZaFhcDxiUMpv4x7DUcqbp+UdIoqEZthr+4du8fY=;
 b=p7wA/zYy3czqOTv8jKZbuQytfuAFzurcIGgEufujR8M1hOMlWjmcfVWwtcvxnw3/WgR+DoI5XMgis6Mz7fdOl+cfolJiMUegJF1ui3+2YItUw/X/T8Ea/ixiEcxA/Mzb/tmeZgkPSRyowHookUSv164nqoKMaIABb1qTOpEws9LUsbSqMoWqxtuazLKI2ugxAFZ1Dog9OsbhO5w6ymz10qy4k4Vfjr4mYJDr6Zgy6Gl+6hwhrH+2koFlJ1ku9NWk8P7G9RLCqnvGxVBX7vWsk/rpLAE6vpvniWZwzfak+7NV0qk2XATWsYXGf1l0AI5sxkbgrsOMjIlaeesT7fz7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCg5ZaFhcDxiUMpv4x7DUcqbp+UdIoqEZthr+4du8fY=;
 b=BsUyTIIvl5BCE0Q5fYItJbZKf+XjuQXWLCGhSK573jrebC29h40Ph4fdSgINfz3R4QvGDGG1IamUYijHdKCfS7RCA8SfTG0AVt7ZWYj4Uqfo2VHAOKXc5xZvJpN1d+4L9+Lm1rgAZQ7hDk+smj9Ju8ahrUQkntVOHUC9gFKdrKjnNzfM9LLPuM6c2vNcgPznSdEpTLU2bOVfGyNYhIdh6v50hy+ntZiyLyicQhJC+m3y2BzIfTXcYSI6dJ7K04aYb4COUFFroTAeCAZ3sSjhb7ycsFkc8LnsZqE9IDE/hXLewQ8c3ynDw7FVYNVKw9I/HNUjJBcQs9qCYZFjQZjd3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 7 Jul
 2025 12:25:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 12:25:03 +0000
Date: Mon, 7 Jul 2025 09:25:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250707122502.GS1410929@nvidia.com>
References: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
 <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250702124042.GD1051729@nvidia.com>
 <aGuoZUaNOgclC2uU@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGuoZUaNOgclC2uU@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ed3bf6-5094-4e66-81ca-08ddbd514c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdePefKO7iZ34kU3YJQ3R+qvT+3U7jfBaF9yB7LAdlaTe9G6uR3feSyEBsJC?=
 =?us-ascii?Q?rWUVp8jNx1jegncBEJVV4tFYjWXnJUkp5hi+LHcsCKIr1G5Ex/caca91/ze3?=
 =?us-ascii?Q?LvySZ1RdG8nwwrCtwV3nrntfueKToFueKD1lhwKy7GV6QPJP4mgtRKvSlkZS?=
 =?us-ascii?Q?4H0YOfsd/0DQW1M8mKnyc98EPyApzfFHbtJs1nAV4lIvHJ5ozw3XlWWlj0v3?=
 =?us-ascii?Q?spLPAxXsABrZDzcEFWMHkEuJBtHYNrPCilG5HVivZSSyHMNZWFbgXuf7jKpq?=
 =?us-ascii?Q?X20eHJT9Wz36vhyjQ+1LlJzOyvYAm9LsrPBz02aX9GYp102MGNu4BGWy40hk?=
 =?us-ascii?Q?FuGkj6ja3nPSqlWh99eKBJqP04vWSwmGk+lcDSbxcHSEiRi+oY2HTimk8VLl?=
 =?us-ascii?Q?kqZ70D86o7Ozooiw/mIMT2Ygy05y+59cJUHB/hxMMkxvCZgenJLCX+j8PuWZ?=
 =?us-ascii?Q?Wx6vw20Yzkx89+VR7nJI3y12qqYFP9A3EfHmAuf2/gmx4Q0/yw010SSimqrH?=
 =?us-ascii?Q?kPfuvs3gc5K4OW1zP1G3h+3F7dthWgmLLnWpcnOs+muk78Dpf6Z6OP3qNkJ+?=
 =?us-ascii?Q?X/nDc2sG3MgwiB4lBW1PSD3Q6iGTuGS1knpXkeG5u2wjX8oCoCsf6cLjbmXq?=
 =?us-ascii?Q?w6GCgefZZ6C+DnrLzuSzdBzr+LoPbG0SW+43nV18yLC4d4VmGU0N64v39ACn?=
 =?us-ascii?Q?HyDcWrSuyNjw5ja4LYPPxUQHenrkgWKCyc7tAZGD6+1vKFw8w0aIbW7mEjlu?=
 =?us-ascii?Q?m/7s66J8aRLgrg1CIQnHVlkVexN+sEGiKbAR+5ZraDNMDgbsNT6lqBnXPDGw?=
 =?us-ascii?Q?kM4+12jQphqQrfcHWcXz8+ZSfWHjTgLilN+sscO1NSNFV7o928q4/NSpCo/e?=
 =?us-ascii?Q?wTjd4GV+NS9uPIlwz/mN2fKP6k3B9pxdszxNkEpD3O+uZh/M49oux9fx42Ev?=
 =?us-ascii?Q?YhERqAS5TSx5kC8CxSMJxpOOZTKFHgTUz3CIizbe0OzmwYNAV/iF6WdrU+1R?=
 =?us-ascii?Q?WB8Afs/e2JocvXzg8apREeWca9MnSb7a5TA3gLyYGuapmsYOltW0tBu8+Pyr?=
 =?us-ascii?Q?Sxf5iwNUYgP55Xe3+6OaVg4/wuLEngM84OrjJTIkuChgvPdKPcdRSa17qiNo?=
 =?us-ascii?Q?g22QdC+5nvU5xiIGz6fLIXy8f8XJIJpcuM+hbbmfwejWxNs/xdP+YIcGM4Eq?=
 =?us-ascii?Q?UJHWt8ot40DlwwuBLl+RCufzXFx5Vm/nk3JKlnc/OQK5L1wAOANqPNq4ewma?=
 =?us-ascii?Q?JU1bvqD5YenzXwwbdPVjIhf6zdIdJV8RxUbZAS+0hZR5jGAjIEW8SGWdlgCC?=
 =?us-ascii?Q?oSMkHoG4GQ+ET+bcYh3jVIeXXKLvawA/lsz60X1yGNIPw77B4LHw4xR2cne5?=
 =?us-ascii?Q?tsfqt6RIdXCLqBBVxfuWOJkHHjWjXlh61uepyw+w3VLxF6rvkggpqOV8Mvj6?=
 =?us-ascii?Q?+zcyzM1/9TQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2JkqroIQulTx1ZIE5psWFOlDcy4rmgfIlU66Y4dqWinJmey9FQO7TL8JjYfp?=
 =?us-ascii?Q?hBYgRjyRdaVgui8ASGEM7o9+8x8CPqUgEOR3RPeTJ5cwfx8BfoSj/40uNwhd?=
 =?us-ascii?Q?NMTdhn083FiJF3LXHQJjF07iNdW7p5DUL0rN3w5kd/JUATw74U0+D46qkDUf?=
 =?us-ascii?Q?sbEnjknAJj/mkr0Vihq3+wcnsxB2A32JQfFWx4Iz0sBIXA+YIvDqNOk/RAFp?=
 =?us-ascii?Q?sQVvxofcWXXdvO//wXm65rMbuwr64GTi+DAjxRWopLiHC1WRj0A+8wvNVfSL?=
 =?us-ascii?Q?TfdCKpRYRNPi6hcx1OaqiKBJShZNAwiMihNIK1O9p08ivVFeOIlMEtUOMPwd?=
 =?us-ascii?Q?sHQf/hUzGEZbSJX5yYHXtKH8f2dP++XdbgQTZV2mtoml/RRjAAW1jLh1Bgbw?=
 =?us-ascii?Q?Uvbiq33CnhkoJD2aAwOSJjXvbo7hqQEKqBMbQxJtC3TArB25VeaPNMfBiJr3?=
 =?us-ascii?Q?uarR9N13g+KL9P54CnvNooVOQct6jhW1/DVs2vlkLmJdxu9/2AvrXfTiqqHA?=
 =?us-ascii?Q?fEXHOIPiXyaCZ1725iBa27OCT6ZRfzgM/uniEMO5hjjWezfEOavcH1hseRfZ?=
 =?us-ascii?Q?fRvQky2Aw/nO0wPU/2AJ0nWQ1e/1vH3lnT9aC4wngy0pH/cOrI7MC2tfRd/0?=
 =?us-ascii?Q?70Mo68sRRipSm4RIxpRrhilEyVFYPl5H3VJad5gT0XHiSbWuCsUgqEziqIgy?=
 =?us-ascii?Q?tNz299UOUNkUfBqNZOkC1TwbIF1aJnxFQutFPGmMgnxxJbcao066Whl2i8DR?=
 =?us-ascii?Q?hWPuOev1svvfaQN9umSISoUpltPsxefZ4H3tVQC3QigEYYfbhGymagY/mVYC?=
 =?us-ascii?Q?BUdZVmR2jO1RyG+HnoO38LZdjwVeBYXZwK65GrbD3WgzY1ezQSHpfEz6qdcj?=
 =?us-ascii?Q?faKqS34EqGxEZuOG++WSzfwb+rXjXliez1cv9uQmhqNK0tZEHTYhA8jfHMgh?=
 =?us-ascii?Q?FJ55XAoG7GDAVMpX+w3KvMTr2i3N83tFzam0mbRDy9MW8UrMVexPu17dLQYF?=
 =?us-ascii?Q?2T2rbgyc6z92V/4TZPRNLP+Y5bV2v1RyHYgHW8zbRJ2noYWEFU7UPbdyGRh9?=
 =?us-ascii?Q?aJenOmUXs7yMrDoQKEm6whzatwtyDx/n1CBaIPc/0HIXYNpUOyWi0htJ4u5h?=
 =?us-ascii?Q?1dF1UzPNiM+DBBn3H05/A72sDXvCYVKutq5X7Gyo7nXof6yqxf5mZKdD7JCz?=
 =?us-ascii?Q?Fh9FAL7m+CGh3dNPDwgXZiSwCc40QuWLPzruoPHsd0Y4Bj5peHE8HYYa/f7R?=
 =?us-ascii?Q?Bnws+EabE6QAqP5ygQNcSPo78/Sm0Ss1X57y6mva8lTxPx7kaAd9Gz3ka5c9?=
 =?us-ascii?Q?ZJk7tJwZgC/FGL8irKFYg85GS/bqi1sPJ0Su+rMg7DDWI4MW6MfYuLMNcZ/M?=
 =?us-ascii?Q?wwpLaUmuMPNs2+hVYTf24yhmKErgFqcnZ/VoL/E2A07VHTUTjLJNGWJ8is/1?=
 =?us-ascii?Q?7G3GLWvSpoCFsIKcNDkVdDRHgt6GsI5RK09yfGZSJrhkhKS70iFwTMg2AaDg?=
 =?us-ascii?Q?6rjMd8W4gWDiiWQwoD4tBx1Gz/iAOjm0iNhPmAWZG8J/7ZTFn64Vo7vm0gqa?=
 =?us-ascii?Q?8Rp9h85S5NrsQO1RSfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ed3bf6-5094-4e66-81ca-08ddbd514c7f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 12:25:03.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAUvSWRAdxn6UD4JHIeS8do7XE4QFnnbYdcKSZu2eBUCP8RY10afCHiQI+E1BAUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

On Mon, Jul 07, 2025 at 06:58:45PM +0800, Xu Yilun wrote:

> I still see concerns here. The pre_destroy() and wait_event is before the
> idev's users count decreasing to 0, which means a new user could get
> in.

Hum, yes it seems we could get a race with another vdevice being
created during idevice destruction, but I think this could be fixed in
a straightforward way with a flag 'being destroyed' in the idev under
the lock if it is the only issue

> The worse thing is the new user could hold the shortterm_users until
> pre_destroy(), but there isn't a second pre_destroy()...

This is OK, the point of pre_destroy is to remove the reference
cycle. So it needs to prevent new vdevs from establishing references
and remove the reference from any existing vdev.

refcounts outside of this cycle are handled by the existing
mechanisms - pre_destroy is only about the refcount loop.

> I think extending the life of shortterm_users at runtime makes things
> complex. 

Well, it keeps the refcounting working the way it is supposed
to. Holding a pointer without a reference is nasty and is creating
alot of these weird problems and strange flows. Hold the refcount
along with the pointer and things follow the normal patterns.

There is nothing inherently wrong with shortterm users for this
besides its name. Think of it is as 'wait for users', and we clearly
want to wait for the vdev user to put back its idev reference.

I think there are too many gyrations with refcounts in this version
below. It is hard to reason about if zero refcounts are re-elevated to
non-zero.

>         vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> -       if (IS_ERR(vdev))
> +       if (IS_ERR(vdev)) {
> +               /*
> +               * vdev is removed from xarray by userspace, but is not
> +               * destroyed. We should wait for vdev real destruction before
> +               * idev destruction.
> +               */
> +               iommufd_object_destroy_wait_prepare(&idev->obj);
>                 goto out_unlock;

This is now really weird, we are mangling the refcounts and the
reasoning why it is safe with the concurrent vdev thread is tricky..

> +/*
> + * iommufd_object_destroy_wait_complete() should be called by first-destroyer
> + * in its destroy() ops. The first-destroyer should not access the
> + * later-destroyer after calling this function.
> + */
> +static inline void
> +iommufd_object_destroy_wait_complete(struct iommufd_ctx *ictx,
> +                                    struct iommufd_object *to_destroy)
> +{
> +       if (refcount_read(&to_destroy->users) != 0 ||
> +           refcount_read(&to_destroy->shortterm_users) != 1)
> +               return;
> +
> +       refcount_dec(&to_destroy->shortterm_users);
> +       wake_up_interruptible_all(&ictx->destroy_wait);
> +}

This looks weird too, why is refcount_read safe? That is usually not
how this kind of logic is written.

I'm not sure this is OK, it is not an obvious known-good pattern for
lifetime management.

Jason
