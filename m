Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41025E81B
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906472; cv=fail; b=Smae+15nr3RgXJMbc9QiJ9AkygiahaFp63nbwmeH6f011ow4Pi7uVS70r/kkaDaChJoMyRb01m/9azy5XsAmDI062qrPc/Mz5lqS/IdoDvSZ3aN0kkeuz/k0NiKK5NoRz5Y3i632/c6vzsokIMS9hA1H4RHAb7CYfYtSBBQJWCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906472; c=relaxed/simple;
	bh=n5Yw79hGXjKuReVr+nIa+AIddl6fLQBtn/4dzwBfvVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzHcB5FK92NYQeiMjXzK3RT3go0XMAMBdmXAe1zaPFAK33JDEOQ7orQck80+KWar0Wbz/ESazi0KODrdENlRbkXrBQbqc/+TJgDAIKtorLDWnb5po0NNJWtna8cnrdAWAhmddRTSffoMVb+7JfK2wubRUaKKcnTQCFeCWDFcfhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bw8T2BpN; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bw8T2BpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdn1ZRWyO+eqepOCuaHC0P97ozFWXzWpZSM9S1v6Ka35o3P3EC61RBuSsbzFjURWYb6yKKL9rIHSWggDNsaWFoh8w9Loc4jwkWsMGIAffGRiSUIskSWQck+PUtTshjfprbsAG1HtN6KaluUxcjwi+rWLDPDrKLelYKNBcy8GksM2lzFFMkzKJMzQeu6+nIyFybUqTP/vgWL+/ijdsTSkSIYKQMCUET53xm0XRe/XKzH3kTLFRV5s+5JkNyoxWhO/bGVDA9SZkE/P18M4oVkm+UYlOZutUGhBD8fOSdIHNJlzNaobgT5MF09GW0v3lliyfdbaFyHM57NYRVGjKesvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5cWZ7VHSzObqLxN0pXY8NmhurIekCV+1r2zf/3Rq5Y=;
 b=R2/YO6uMUk3zzJDL0jTfHjwbFqO1gyokxZalczmRzVoOwp03T6SypRx6t/o+nOGQHV+1nh5gRvDe8BmIYxs+DertHEMP7C+TY4MMVYmPz1xZNfJVuxIcSqoP6/mr/3aIL7H3Ay7cMbEojHgKjwaa33GIax9Q4xiGGp07ASCMGqUBoS8iTJRFfGG9ExQFv7vn1r10NRwXXRz3G5xxgegzPkIXrGV3s5i7jzXE8kKrmDAdBhUsGX/16XaWk+McdXFrRkzBm3g6eCbtl4VmoNxac+N8Zskpo1aYHKokgJ3+dgUTgYAWMMRqUrGODASJcfzgxxWaOG6WSIiqpU+JtYqcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5cWZ7VHSzObqLxN0pXY8NmhurIekCV+1r2zf/3Rq5Y=;
 b=Bw8T2BpNQNV4vnB+/0wnmAlqesZJjixqYfWbGFHI9klo0TgtT24wx9XmraZx4WFf/+BL7RAYgb7Lj8j84fn384kFzH7maZRwPKgfaEhpsrz711dpjzBX3YpidgPZd/RNa4EZpL69puPhsHksb6Cf9gWYOct/JYmU++IG9r7pAtvgbsYKm2Wvo0ukPHbmWeGGqXPSZe+HYw6ZraPlDhXi1536w2sdSHHp8g1zlvwYuYXmp2Z7PcwC5Yo5qTSQ3g6rYLpsNevb54boBjLgUyl4yavqXUItqaUKCo9a03cNMeaPfmmwd1/14hVZc/+rC3P/u87o0Q3GG/o6lMEw9Vv+jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 12:40:58 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:40:57 +0000
Date: Tue, 25 Mar 2025 09:40:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	nathan@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v5 0/3] iommu: Clean up cookie and sw_msi in struct
 iommu_domain
Message-ID: <Z+KkWGwwUHMKxWxm@nvidia.com>
References: <cover.1742871535.git.nicolinc@nvidia.com>
 <Z+Itnw4ys6dmDsc+@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Itnw4ys6dmDsc+@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:208:32d::21) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c14e247-5091-4cb2-3155-08dd6b9a4a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihva4OHKFgnORc3JP7+7DA3mqSlrA2Vme9GMM5jt6avmpH+0mjiUwc2ow1bQ?=
 =?us-ascii?Q?IfofsiLruoDddKYT3lxBoXu76clSzgBccvxd9YfRBGOHS93OBJDFu5orshrJ?=
 =?us-ascii?Q?I5g3HMavQl8JzpC1SGLst/j7igwrHddh7D0kYypabfcKyCvhiWsgI83cH//c?=
 =?us-ascii?Q?z+lvLU2vv1OlWE9nJDOBDtE3htypb2aaymR4k8f6zd9JyeehdXG2CHLbeeUZ?=
 =?us-ascii?Q?h5Xt10UmlYpHFuJitZycJhENcok/ucYrFE3Q80LrNO89pjuxzDGFWQfeiA8A?=
 =?us-ascii?Q?l8JjDE/QUkU+wlN5tPVPYnyuDNWRJHnF9ACNmz+6UkfS1A+LgdWDMgyMUDIx?=
 =?us-ascii?Q?xSYEdLtH0GMljLjMlXuwApO9tyaRKe8Ljj8IKkD2Qzc4b+/AvmN6rCF0R+no?=
 =?us-ascii?Q?kuw4H4MwyD7O8X7lQSJp6EKUNIzfa3msGQtdC0QcVqiUusohtuBsMscuqC1W?=
 =?us-ascii?Q?HtWV2VqnZriuQmPomZDdwr0sH7z4VhXviktwhOPMLzXG0FGGYNorndfwaO28?=
 =?us-ascii?Q?RPB9HK7i43r2X4lwFibJuUsRfXdKKV+8c2ZHJDXXjANdi6uOyp193gp2ygTB?=
 =?us-ascii?Q?UYSFNZ6NMQE4kcZSPiTYZqE67i2nnG/qWd2UeajGC/AVKv/IzxBWyFRHrM7+?=
 =?us-ascii?Q?2GgEoFCXV6j3M0yhAmFmZwdLIaiNoRVB1/Z7X+gkTtwb2FwoFX9tiOYvbj8Q?=
 =?us-ascii?Q?SkBnBUqFKA3/EYpFNfco7k5aNHIlKAumAtp9rFE2V6jImT8PMmGWfTIMMV58?=
 =?us-ascii?Q?pnNv+54V5pnepyRohhYDgSoeWwXzjFoEJqfmTqunWQsOo4+OhGV5+J+f2jmq?=
 =?us-ascii?Q?fcPCKDI2GbhQxMmmF8HEYTTGkhcQlyMOxezhpRxn2XRU0Fl8i7oD7HSuWEKy?=
 =?us-ascii?Q?rvTzORjQneJnu8qFDHzXLUFyupRKuR1f0yH3Cq7sRrQJLv/SueCx+L6ecXEj?=
 =?us-ascii?Q?E3GO0uUOCuOA5Gnh63wp0hLqixf8ZDJqKao4Xbv26SsZ5zzLU7fvfX+F0cTm?=
 =?us-ascii?Q?ULpbSixscvuS4iD79epkjjc2Ee9dPVYvh6hZE/C6gDyod82s798JsoI3gfHT?=
 =?us-ascii?Q?B3tdhZgU8Y7tTaOkAaJ+vVcFm9/dJ0/CMHEaAQM7K1SBQaexZSKULNHkzoab?=
 =?us-ascii?Q?VeqovJC8k24lHZojWd+Q6PzbyTp9aJX04G8PeC+PAUS2EhfTD268acC83FJ9?=
 =?us-ascii?Q?wJVfnq1GcWoW6/HNUjM5WES+N2sUUZDIqZpp/MDK5QBZlApY/UNBGczlWKgM?=
 =?us-ascii?Q?pL2jAZqzJT9oGmjjq1xqyOQJJ4YB4PiN9Q5pE8BGvTQdAoWERfCA6B/p7QUi?=
 =?us-ascii?Q?Acor2VWt5xMAEG9ky5Rwf0P0mJDhRljDSfXDMs1u5Skw124S9ToywnZg01fq?=
 =?us-ascii?Q?G8E3p3XOviGGdS9Wj6fJ0Hv+hOe6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2AWD/Zti4vTKHFUEkPZrdib2G/KDdlXggFt9fy+KPVPuWD+shUnUTXZZ7pwu?=
 =?us-ascii?Q?RSc3WoG1ga4JL8S3z71NNy6xg9tZAc7/BbK8l6oxsbkivk7K6Mim2y47bBEw?=
 =?us-ascii?Q?LEcB/P77bbWl0/ZAu+cf3IPJ7nrYSt/rufJU9h5AO2avD+aE/IJuXkWJE+pp?=
 =?us-ascii?Q?xvuYGBbksstcUChFn2I+sEAWYJK/I7LBuk5Q0TxGU8P4FPjx/kfNew4hZXVW?=
 =?us-ascii?Q?2oO3yiOKaUccLJyrJtOuuqg9etXgtveCkztZr1CosJ1E4eflpn3Y+jF6QNzH?=
 =?us-ascii?Q?3Lze/ukLP3I5cd7kBU3HYFnT3S+BmE+CUhrgqDqAVICwwpBEUiRcII4SZMqC?=
 =?us-ascii?Q?Bqz0rItkyEBQZi8LX15b4J9MIPGWHq0tYOhA0dCAzBamH8jqnVa50U0vjzXs?=
 =?us-ascii?Q?GXA9n392zGsOJffjzysJk4aVMBrre8nQPkn+WwCwY08gbqw+AayBdlMbOaY0?=
 =?us-ascii?Q?2n8Ry4vE1Akxi4RwFXXyP1J38XIRJ8Vf24zFh+0HK9K1zn1BX+Q+59SMeVDT?=
 =?us-ascii?Q?PWb102Ere7R9jNS6LukvmKm5KNAOqtoOp93InpoRRxMMB2x3rNTvkMY31AMG?=
 =?us-ascii?Q?CUfjvGRqCZk+x9oEFCyN5h1H44f9H5HBRJWLPvZ/tyusKs3K/zZCjQxUNVcX?=
 =?us-ascii?Q?INGi4991Oy1rCngpfZ4ADZby9mLKIXZN5EEBo30N4V+FMYZZOyLddtbjFq8i?=
 =?us-ascii?Q?1JmJaUuCtcKvzqud6rI/tDB4D2AeA8oRapi41389sHsYnaLS3hP99FRJrG5+?=
 =?us-ascii?Q?6Rk1FAzK1EWHtysxL9AqFcKo4piCdmuN7ZkEbTjiCT4t3sYvbYOGwSgxk81J?=
 =?us-ascii?Q?yh8r39r4Zda807IiSN7xRvZZMLTcDl2CaxetU0v9/OMINbD2JfXms1TM0wMC?=
 =?us-ascii?Q?lFB9FnPp5tZVYfa3aAd0UmCxQJVETNCZLHyi//IKAL2qX3H+tYkYS23DWzAN?=
 =?us-ascii?Q?JwK0I5eWOS9DIuSSFcgO8UF0gX9ZPIsKVd1/wvvQmZxsANtXKTqIzdzbaZuZ?=
 =?us-ascii?Q?uScuqTHL4lqwh/1ESpBqZpvGJbvojjKKypnfgKNLFBCcGBo6Hm52HpRRNq+D?=
 =?us-ascii?Q?4FG3DJr/1pOQNfyFSHlqfTa08OhYPS7ye97KOqdmuD5pimKm1dIqo7IKxtXC?=
 =?us-ascii?Q?VO+p2YMcc3NEefKNAUoa9nv597i9DDkFHOKnJ1f+eTqA9FWMXNycatFphK0D?=
 =?us-ascii?Q?K6x7a7fL6lvpHePAOLhico9SMLXlkn+2vaawPpZP7JX7ptqd2DSgpxC8wVKa?=
 =?us-ascii?Q?zNoFhYpgRM9ol3I5nii/64rOLFWviQllHai2cw4WqD8UVAg4hkS9/8yI8etR?=
 =?us-ascii?Q?aEuKV5j9fuYlYr6OIMTzYDs1pq1NzHhT5VIWfOtRbottON7pv5OcrlbJNWA1?=
 =?us-ascii?Q?8R38MIpiFYJvl6MCbDv/MW8qGlv6QOjiwuJNFJXA+x0KWCaGrpeffcXvrFq4?=
 =?us-ascii?Q?1PG3ZKx1EPZsHYidCRxGtLwXMcb0vto51ExHG6aO5UluYsFnbgHt39/NMMpe?=
 =?us-ascii?Q?SLZvHJ1pWIkOY4MTCFqkF08wQwWZlLMM6xgRVcTdzQCg0gg4DO/KfvVbOSaY?=
 =?us-ascii?Q?81hyyaPZzhF2Adfr/30=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c14e247-5091-4cb2-3155-08dd6b9a4a8c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 12:40:57.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+jOGh8I6yX+K0eG0R3gBZN1GPy3/W7UYwh0mLSPI1vxaP6CtylxUrZVYnoheoxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

On Mon, Mar 24, 2025 at 09:14:23PM -0700, Nicolin Chen wrote:
> On Mon, Mar 24, 2025 at 09:05:14PM -0700, Nicolin Chen wrote:
> > This is a clean-up series for the previous sw_msi Part-1 core series. It's
> > on github:
> > https://github.com/nicolinc/iommufd/commits/iommufd_msi_cleanup-v5
> > 
> > Changelog
> > v5
> >  * Add IMPORT line for IOMMUFD_INTERNAL and change IOMMUFD_DRIVER_CORE
> >    to a "bool" module, fixing build module errors reported by Arnd:
> >    https://lore.kernel.org/all/20250324210329.2809869-1-arnd@kernel.org/
> >  * In iommu_dma_prepare_msi(), let all IDENTITY DOMAINs pass through,
> >    fixing the regression with IDENTITY domains reported by Nathan:
> >    https://lore.kernel.org/linux-iommu/20250324162558.GA198799@ax162/
> 
> > base-commit: da0c56520e880441d0503d0cf0d6853dcfb5f1a4
> 
> Hi Jason,
> 
> Assuming that you want to replace the commits in your for-next
> tree with these patches, I rebased them on this commit:
> da0c56520e88 iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
> 
> Again, sorry for the trouble.

Can you post a v6 please? That is a bit easier

Thanks,
Jason
