Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF813C9D8
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381473; cv=fail; b=qiZ7cj5lueRWiJURydjIZ1hDjJ+xWkBeVVDc33/f3rC1yxQzrdwSUly2Y6qCKjz8PfGqmWGG3YSsJeXG/OJ49Gefrm8RCjkO9JOUYv9iHo/ZVc4u7HKuF7sL98/18kLf82fbNfAIEOJ1wbFbq2TISrUJm8Y5NrK/YQUkZfBjU4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381473; c=relaxed/simple;
	bh=jOcQ1j7adFB7Y3JF/YixPnuv6uSBBXq2Xi5S3kmwDM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MDsHZX+aNFmGMh8dsRrlDrflSirrdJ/He4erb6gOBMurFbzDpRLqi7xRuOr4aSSnNoyCq02oAllDa7HwDuQg7Nlyw8ZC37wQRSAfiyUEmxRXaVv2hWd2NxzNmiZKn2jRRU5jST9QskuxcUdKPMY1fwPs3eY2Mz8S2473Dir0Qok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nR0sKjhT; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nR0sKjhT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYM20Vje3S3ocUJ9Jl0m9RMXVAZj36u4eU9encUOmvu51ymcqm71JrB3tyLDePQ2J7CPtveEGgwAy/s8GHT8rzlXmP4cw+vMXZ0YgAo8enmP/KyUsAP2+V6aYzXg+Gs576Htd9e5oYjCDlm2wvhcBhkEywAZowf8qngYsqO+LOLNhLWyTcri6oN4V1N5QafYMcl308rUzXCbcZoOgGAPaAX5CzS28KAtd/0+/gXVrpYgd/a8gNHxpMxsIq2A4UllLBcbcQ56kc/W/d/w7AVDmLXe/rDdLHkA8lW0bx7/usyMIQ6DiVHe+Oi1A5mOoBku1+E9EqdIbmJxMTmvHOEopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Le8UF0FDDB+LaqRyZHrqaAoSkEKiCLQRxcOrTHE0BI=;
 b=ITxcU3ehK40V50dVgR3vY/Uy3WZj1hoPyYPj8RFKNe2WhOQI8ohtOoH7ed4FNMSW5PvHLkGC2xPOfanUbNE8aqm+E4kUv5OuXohQMeG8RgHKowvZrcF9WAKzi8xv+on6QtB/IqJmyxL6TRHfqlIf+aAdm/mt+bGXCnDrKztDh8U6PI0B+ficQ5d6ZQdRrZnyvoDPGe8FYHr8YY/FxwIz2NckiGC4RoT7impl3EJ0ki2191105w0OXprKb8MRSBKeDXZEBM++qwrdWJrW3GnRHMRkGRRMa94aKwBN2rSgIw0U4ii9NQOgxxCCIu22G6/UXKFqJIh+wvoaSf8C8S8s9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Le8UF0FDDB+LaqRyZHrqaAoSkEKiCLQRxcOrTHE0BI=;
 b=nR0sKjhT1wKgAFaeGJN3T/2x7pNHjRHXGCjKAt9mMEKOKXQ6YgTICmqY0zRAFHWanZb55ljOMbxpN27LTpBLDvCtMkNrKM5SGPuVBevZyIyI6NR90xff+PHkalSdI5QxmpR4IOZRkWDqQcznM1baqzyoh6oIplwPTuuJImbv3akHkoIy/u31OYLb/MmDAXlWZqnSNDmFiIkay380W4h+gvYkG3mIJYkw+sx9rJix9I99hpWl5ddyaIn0mq7nqj/yrwto/YJjQViXJ8Z0DHnT92Nr7qWPmt7bsqVzaUFfHcY1y8k3SMuf9V7/3ZtEpodCfeFH4Go31BHlEa8vI8poqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 12:37:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 12:37:46 +0000
Date: Wed, 22 May 2024 09:37:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
	"zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <20240522123744.GU20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e2a119-f8a0-4390-b5f2-08dc7a5bfbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NE5/HgrT4tfs16OldXOrtP4tx4lY23iZ5FelTy3GXttNk6J6F9/Jt6OF33O?=
 =?us-ascii?Q?KkSafUQQ6w2gzitnRvoqEER96VgxOvtcj3jl/2qYRt7+i7TsKjlhn1wnTjae?=
 =?us-ascii?Q?Zv7srSg1PksQhTenjqqPcls7zxCPoAA7xissSDfff/ChFo8bkF/Q9BL3atgN?=
 =?us-ascii?Q?GpckOLUKLhv6Gi98kPEtboGxGQjesnWZa4lpcKYH50SjOncMedl6xXzD3E1u?=
 =?us-ascii?Q?o1uFEddudEPjUzI6JwNr7g4tlZIKgZrQpl+YIDlrwBHWz9nknc/A9XdqK5so?=
 =?us-ascii?Q?IPXcSZHtQK6OzSh5UBqk0dA7PwISphCfW46ei2ULSUZ9cAYSmtid/Ab34s/P?=
 =?us-ascii?Q?LABqah/2wr8RLC22ZkU0Wd2IfCnP+JRqjw2jTHFuAqRbvOEv9Dpsq90fwUtT?=
 =?us-ascii?Q?COO1dB1Z5T4cOI+i+f82r6+JMbUVnZI8O2E+68oEdntEHVWRKAUNKzNzke5J?=
 =?us-ascii?Q?R+q4nmZhesDoUOpQs8FwiwGae+2MtuEu0dqlDgGjlQzFsMamC0J1Uqph1DNg?=
 =?us-ascii?Q?RREGuzJ9DLw6bdbOVr8oIm/CUhriCZgiJkrE5tJKZH6z4BtS9/mkTAKDl2Ri?=
 =?us-ascii?Q?U+QYGTW8/11nzOzM+oWZ8OUWrygj4GheyZie7mfMGgobnJjY5G80e87UGWUc?=
 =?us-ascii?Q?ZkBzPslJ8Dhfi6x7PCCdRAIjh+ZxquqiSVXRo45b2Pwc81I/Ze/6ZkVkvIL+?=
 =?us-ascii?Q?7Cu0TqOyG/8nbtwQleWsYsFOuHmPUXx1pjdyF4jIseN9lXXw6O6WBl+czXE+?=
 =?us-ascii?Q?z1llUuiqOezVmz34K+uNA4MdLGYqKjqUmaJI+scf3Y0HVM8y/Mr80LjoTKWw?=
 =?us-ascii?Q?vf/oaP3HUeHbWbmbH8dZVWqNhjf/Jzdk/dXsKrGpvfWGhMKP9Bjbs6b7YOTV?=
 =?us-ascii?Q?10DtGe6DRnXjDVn6C4vsO66ynEeKd2NB8jgRFMheAfFvh82MVkE10sgYMQQz?=
 =?us-ascii?Q?n+R2rsTDrf1qMLd2duZzGxjsfHwj9Is+zPqttPLKdMwCKND1IuBaa6bZUJCP?=
 =?us-ascii?Q?w7EyFIg79N763v6S5WAsQkVHNj7WpI3GqB4FsFKR4/WwKtds+rMTLmTn8qbi?=
 =?us-ascii?Q?BmtlBWFOKgEiP3wqvnpUXpnaM5MSnFMnDv7rWUNRasRelHtNH4m1cbIrqZqp?=
 =?us-ascii?Q?Ym+q6X2OeOKPuIFvRJ6LWiUqx+q8+HbDiSazUb44Bq+1u0CBB77Uk/yHb64r?=
 =?us-ascii?Q?SMruOLK5ci6RjQvFnGGxa73B0gJU9j2mjRzqrCJIWZiHKzFgjhgZCv9C6fkh?=
 =?us-ascii?Q?CJhegZnvfDW1+wGRHMk2diwhLcfgXGy3nwT+IiS87Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAg1/X1dIEWLK9mo/xHjkEUm1X0mdMNvbcZRHhscfYHtHNRKjgd6iVwq+DgT?=
 =?us-ascii?Q?swe2vfwhjeUWpGtQOoUJ3c00UZXA6FWM4jxSeKzhkkdC9ptguw7iM5nga9kY?=
 =?us-ascii?Q?j7FxEd7n6JjiLN7S1cocZ3mepeVFuDkbE4/VHdSOEoHxLHTeVv+Wc3gd2hQ7?=
 =?us-ascii?Q?Z8e0+whB2wzVLpnUWTuv9RouAEq2u18NiBZIuoXN/y87OUTZCkMUChazbXmK?=
 =?us-ascii?Q?4OwpAlcWXQdBsjTagSlRfgG7bXpbJVEZnZwfaPoq9pId/THEnBagvLtIZf6z?=
 =?us-ascii?Q?SU4lixcAva0NEUwoYa1fuPx/2db2Hu96gdo0Bkro7UqUFMqcoG8M4z85r2Rq?=
 =?us-ascii?Q?CxjYoTwmpJV+l2hWg80QL6st12Sh+VoifoGtUaRg6Nqy5TP0DSycfkwxSo2T?=
 =?us-ascii?Q?k1yCDFGVIm15b8JhPW7KViqsPjmbPST3+z7SfvzyoXDqpfd80auaMLQiZ1Cn?=
 =?us-ascii?Q?yWp/u0unCc5wIgoENUVGOo4VgdFqvFamCsnTlpwuMjF6F59GOh1jhrqMqn8o?=
 =?us-ascii?Q?q7i/I5EBvklQb3wzQBglrJsw+ZIdYpU58jevtaW6v4HTnGP43IaxwD5o7WoG?=
 =?us-ascii?Q?iV9RTwFFOIAXvqTzpV5hSeuryGnBFHbLg4aRfld0rrrEoPaldhyALRzRzE8O?=
 =?us-ascii?Q?gca7rSgP46ko7mmUtWCKnZMeVo+YUOoiIoWB3mR2IdJQl3UbIhwhthxFR7EZ?=
 =?us-ascii?Q?0Rwi4Vnn5ObEl1cQZ0CWw/NOtmLksULx2bNPnjMtHHmS57xGw62gUo8iHjTZ?=
 =?us-ascii?Q?VrEeaS/1zVZTZ7u5vd1f+oIgXHkriXI4+0oco6OrD873piTKmHDQ8WMLyP57?=
 =?us-ascii?Q?tuH0lw9R1VlbEmjbI4kiwB/5EbccZWKZ5mQkT19wBY9dbOpklagFVLZvYNns?=
 =?us-ascii?Q?aoWcyaIiEV8Fi3F+ODhxcD0cZpmmyF7HssZ28kQA2K6n/atnuNZusDNzgQwe?=
 =?us-ascii?Q?mK1GTg4lphyxOZx8jlmZT9wNBcRCe4tDx/tNSIZ8oinV+QsCuGgQVSR2mQad?=
 =?us-ascii?Q?GvdkugJ4dXe2EKKzwRmOJu1qkAhnGKgJjOY1628als2KI2nRNUBBggq0Ba2j?=
 =?us-ascii?Q?jr/sCG9UjOnDO8dAChdCPau4Et54Puvsc1y37Cd0ywN/jVOUKMGxr8MPUC9n?=
 =?us-ascii?Q?QO9KvmK7I0ovJpzhLr9ztZQxuROJIIgrMNCIrcnhdtsyl2sGNzVBfd2Gkq1s?=
 =?us-ascii?Q?EWKWb008avRKgp9s6lZA8y4O7ncCfERfgpt4Vr1ZCyTxShNHoOZ8jn94a+bK?=
 =?us-ascii?Q?A3GNEcslPxrN9yX/9xDTwhBZJ7qHtzscKQJfET4a2TJxonjmNctTPYoJP+bn?=
 =?us-ascii?Q?ZRCNVoNpuVTmYV/rVOou0ZiSCCgosp1BnqNr32cUNF9bD/XwK0xu3QKXVlEf?=
 =?us-ascii?Q?MKe4D+jO+ssyb6Z7S2y8ZruSNTRw4fBuMBx5ox9C8JporARQk2fZgfcn2LT4?=
 =?us-ascii?Q?Dt79uh94XDSWZUgHL2iavYjBRkhDNMeJz2ZtiuqHcWjpVIa2PFxj4A3UAW94?=
 =?us-ascii?Q?4upwq0ge8Y6D9D55CKjpO1X5cTJAPnQxLAtW2PI4b9bwBIA6A6QW7puBWRuA?=
 =?us-ascii?Q?v5RVa2JZocNOVJeFveM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e2a119-f8a0-4390-b5f2-08dc7a5bfbcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:37:46.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v1Hec53rsn+q3rzF6cv2Q6LD4+VNMoLKZ81rwKqFo+Oxfkx+ibhRCa23gUAzmtW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On Wed, May 22, 2024 at 07:12:27AM +0000, Tian, Kevin wrote:
> > +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
> > +					 unsigned long iova, size_t size,
> > +					 unsigned long flags,
> > +					 struct iommu_dirty_bitmap *dirty)
> > +{
> > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +	struct io_pgtable_walk_data walk_data = {
> > +		.dirty = dirty,
> > +		.flags = flags,
> > +		.addr = iova,
> > +		.end = iova + size,
> > +	};
> > +	arm_lpae_iopte *ptep = data->pgd;
> > +	int lvl = data->start_level;
> > +
> > +	if (WARN_ON(!size))
> > +		return -EINVAL;
> > +	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
> > +		return -EINVAL;
> > +	if (data->iop.fmt != ARM_64_LPAE_S1)
> > +		return -EINVAL;
> > +
> > +	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
> 
> Intel/AMD drivers also checks:
> 
>         if (!dmar_domain->dirty_tracking && dirty->bitmap)
>                 return -EINVAL;

Those both seem redundant checks on a fast path?

Jason
