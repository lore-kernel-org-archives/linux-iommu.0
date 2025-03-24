Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BB19F438
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846709; cv=fail; b=Y/4sX92wY2mLtNRqp4noYwNa090H1iOfbA8LwABkJiX9/0Rv/agdBUSobMIx6vJlQgL7Dny9iiQb0AzCZi+Va33iBJVOYbuVTIhrUUYJRInTI1t9tw5iMZhmd8/Wj1ZCNx/9WrbPFIMlGX1jEibncvXesZSFXj7XpvDcclGIR+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846709; c=relaxed/simple;
	bh=oK/MXMeQxncMNQEaxBgjvXK6nTcMj4Zzyu0ktfvF47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lOsU68xogTIAvMtrMzCns1XCxDfBrx64Vwwefglgkhu4lAyBT0dURzgKdyvcwJ9NCd9osV+tQfT2QBErOrr6ZcJvr44xhPehce6wbNi8wgEccNtR6uR3OaAhFGBJfXfln5eYECLrRfmxvwQP7aVsjN+w7nyPLUij2aigRia/9oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XjFxuX6w; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XjFxuX6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG+wKSYkQpNLEZNpr7pzAFq037ji91j4LzG9f9KVX8hZk2csyQxtI/DosAsL8OtDSBwW6/SMG7fnIq1KThDkLSVOkR8zJitS0ZuXqyGLpMo+46IQ0yx3dxPWWYZB5abtR2EFnEnkqGyr220ZBV+XsfIFWaoolw+ktztOBpxHxx78oMcoB3MxNGH+t9gona8d21SLTUffnAboAF7t1zSSD3nxjZCMkko9XUibXT/Z47AzlsX2o+BA22Vi0l8nmWkMyKih5ZRZmsEBOVn9jtijJ5megbai2ycLQlEqDFLw1C9TdYSA7CMU0VsIne7GNRZKJPf/H43vergJMQHy4UB6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0ypRq7qQaQv3o5hgvtE9AOFUZIant2UU7f7OVVPH1c=;
 b=jCWVpUoBBIZvfRE0Pc1DSv5W3jRqbgrawT446ofyTB9uq10zmMPtBJR3M72qn5KSLqhVKQJgI6cBYaDKTUhxF1PK61ozGYhY9Nz65+O3c696pyEyadLreQ3pWdAqRfszfguvjPBtULQN0XuhcEZKEnntfxoji/c21rUVOFA3YaUmyH9HJx32/mJisOxanlQjWZzuXReR4SM4PXEZLpB1LV6Kgl91IU1gyYKYYa+MB4tfAJPitY3pKV6a7CWFR3qVoPlkmQgfzm1ql14AXQzmXxxXCM1rrN7xOD69l5rD+p+GuLbu5gecWF6uBfErQPv9Q83dPRlzBfvL+QkzxX6/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0ypRq7qQaQv3o5hgvtE9AOFUZIant2UU7f7OVVPH1c=;
 b=XjFxuX6w49RJL8lhheVawTmo8WxEeTPBlP93x04iTAqPFsf0GuRA2nsffPtAcaNlh3gRtP5cQ07e6KNHaqOJJTKmwfnbFzQMX6CGgPyvsvIG4lpy/y/I9xfV1Lwxv2usfRxCb6LmLPsWK0XyeAXPdOJKve8LT4MFQF33E12KwAzHa/LwT0J4/tIV3jWZAwwmCovd3DbxNwaVAuGuM7LqqwdSYq61JR3ifN65Zu6ci1b7yt86MnLH17veapVHcbSv8jFBj1tKtCO+y9v0jquVx9p4O7gupXztuz2nDmIeFmYR8EDTodXtJEW9qtG/1N3JPWV+8E8fpV9SGh/faFGt6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 20:05:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 20:05:02 +0000
Date: Mon, 24 Mar 2025 17:05:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+G67avxHQt5L+62@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
 <20250324170743.GA1339275@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324170743.GA1339275@ax162>
X-ClientProxiedBy: MN0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:208:52d::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cde9b2-6d69-499a-69f6-08dd6b0f29cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZsLugLuy6ZDS3IDo/L7wvVNSg4tDJsrY2s/zcGJyh91DC9W4LQ5zSijDBvN?=
 =?us-ascii?Q?QaxIqARSNsgkVv5Upr42fYXoUJZFg8F6WnhNTZ2qhSWOPKgZwX7MxMI9JQCP?=
 =?us-ascii?Q?J2QXiPW+X+ADfez5SsdGwy9w2pZoJziqwocb8oqNDJWqoIh3vS5d6XFuwHV0?=
 =?us-ascii?Q?vYnux10v5Cpihx4+k8sHg1JaYYhyZmr7sd/Jc9vWS8f0dC+UqC+pN3+mGeKq?=
 =?us-ascii?Q?gXAHGp5uPJTLsLXUXB8IcIyNUoTfMqqdIf2U7al3VHX0u8C+wANSFewG+tFb?=
 =?us-ascii?Q?fqQKmX0EuzYe/qu60tvWWgZgM+b7ttckYF7EFqssXU2P9ccichUU/UvVSx08?=
 =?us-ascii?Q?DbvJ5bFg9/fqKGowYJGRluhay3Aa4fouCjk4f/bh/I5VOlL2vgK8J+2CeZAy?=
 =?us-ascii?Q?Zzn/zg8gDFM62qA8LmxYL72PEDhmognAQ6e9iUXOGIB9XGkXcgGC7Syk2loV?=
 =?us-ascii?Q?eRqKJzuiJhlz43ZPDcYhVhWVipyb6pHbo4Rl4GgnkLrKKOgmkA/rZsoS+CkD?=
 =?us-ascii?Q?SnzNI8/yNtwz4ExEMMQT2FQvdVIXvNw7iRffvGvmazkFlBsZiNdZ3pG4VUDG?=
 =?us-ascii?Q?8OLhxEELPmzerniOHhHgDOcovV/BYoY9KRqlCnDPa4Mph4oO3M1B6Gn4nxK3?=
 =?us-ascii?Q?lGOu6XbxugF8y19bjBFLS+HcY+mpuljKSasxHozSVE0P7xAMFrA+3fKV+f30?=
 =?us-ascii?Q?p7mWAhHZ6ToCt75YSl1h2J5vK4L8DxIimcWmysAUQTxLAcoYhQ8L9vPiwWGE?=
 =?us-ascii?Q?lOZ4rWKKKCY+U6CqftDINqy8iBU+BaO7fJn89OlvcEcBgm7XDP+NPDa8IaGW?=
 =?us-ascii?Q?rNN2QfgExhGZPnipndq9rsYzYCOfneVVVDp/3pxABSoqmFa1FFZXXvMLT18a?=
 =?us-ascii?Q?NZoP2uqwYoXgS+5qLfs6MCjEgqrYZtDP8wJRoOkHS5GFeihl/VFL0bsd2wbB?=
 =?us-ascii?Q?LKXdTF3pWSV8DZ+Dzq4TsfcogXUtVXPjAYvWhQ4BCelqpv97wbdypAFNV9rm?=
 =?us-ascii?Q?c3SWkhQm/8lM46jrMvfJhRtmbThwJU7hm3OTH9LWXuQJyNOPmr8kDLaYbD9u?=
 =?us-ascii?Q?fzusDsj6yb7riXOzFE/2R+dowRvxrFmJOYpZLh3hS1pCIDnzHiqLaLeNiYBt?=
 =?us-ascii?Q?QXIx9J0XUx/5BqOwPPxSxVSRAvC9JXaC5IRgfSDQgHQjhncSFD51qBCl3Ye5?=
 =?us-ascii?Q?e8KpEBLgzqZm/H00lDmxSC7d9ZjHdBPAn4AMo/OGa73GURCWWTGbq9oWHsUS?=
 =?us-ascii?Q?zV9fBiAi8O2l9bqLlw/Qy+c87NAPG++whpt62oN2BNXRjQAm1f0bH18Sb+JB?=
 =?us-ascii?Q?ZAH0ZbIG/JxmXCCok4qYvCp2BENixsGRd4hhw32PeyjOVCP7miGe7MKwyPtr?=
 =?us-ascii?Q?68eLUfqCPlWKji+LEPhzgqA+RmLqIH8JnxSPqMidrIPZHnDsmY3LN8oEhFiN?=
 =?us-ascii?Q?hKzloCdYbro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKS/VFxVDntv3oQyRzGUzwQCnmpZYyL6mmXFbaUxWPA/LU9HkHT8Zkg/0Bu7?=
 =?us-ascii?Q?qk/95xcjSwO1gTsVK/euHr583QmzEuDF5Un98ZJ+XrJAPHOqb4jAgULJgyjZ?=
 =?us-ascii?Q?TjUFS0fw/4aMtJuYA2jY3doIfb7zPLxFcYH7cWm/JkAVNAyg+jfdqyqhjHpG?=
 =?us-ascii?Q?tt0QdEF9Ck1FOk5vJanc1OHK+8vwBcI0efb8Wk5GfQwmkBNQZCK/uerWqHal?=
 =?us-ascii?Q?YjszyvbiK8ff+HoI51J7TTwpaKueeTw99aPqWPbAw+guNUxiuzk2DTkuc0NK?=
 =?us-ascii?Q?/+whzox7JCXo1UXou2aIEb5y9RKoZze7/SFHni01OalZXx+7D9gfytsaFild?=
 =?us-ascii?Q?1h8f1KjE7E63p2yC5kFJsvmapDuyaPzgx6u/0F8TEzb2O5OBSWH3E4hEh3Oe?=
 =?us-ascii?Q?QXvn0QaY8H5lYOg9u4B0/LP2Wp20CqkqSJx598StvEKo/K/rZO08I+e6mK9p?=
 =?us-ascii?Q?GuHgmRNWSVzgo/7XCHLCirymL9QMMztkVAhAI8Pvrs7GPVdIMbVBe6kKrRFx?=
 =?us-ascii?Q?Ef56hjeTyV9wl8i3H7VXMedLrC1MquRd5TPccrTHDsbQdiDZ1qxeG0Q4Q0bQ?=
 =?us-ascii?Q?if6GcEIotQNoDg3V1HwxMLQBEW/8gUK+ikwrS2o5XqftA8oBjo+83xtjbBNe?=
 =?us-ascii?Q?6VFcJnEMFkkGjcfIDx4a85fQ/K/Vhg92deXulBO9Ia+7OrZqEkeeyYj3EpFG?=
 =?us-ascii?Q?H93NdWObAQ4wr5DoeZhpXWNxJjDcrVanM9Bqh69YTxYSMOKjD5+jcC5F/Kuv?=
 =?us-ascii?Q?MlfvASoh1KqkOK2IXbUv4fHyelXYNBBGq/mBb1LFlhNqpf9cHG/veBjNQGHE?=
 =?us-ascii?Q?EFwYYTqw3zE5O8HT2koyf0FsTlWBWmxDA+92CgR3KAKYw+3EnU2oytWmGOd9?=
 =?us-ascii?Q?39O6CxuNRw3xs/urL/mF+EuqB84r+aA/IT65wyS1i0dyYUTQewfQfpGr0RcU?=
 =?us-ascii?Q?x9aY735X2snTdaMgwcpG/xj9+X7HCKbv1IZFjM6WzEhF0uZzwKkKc6LFytzR?=
 =?us-ascii?Q?9AMpr8be2pSKCd3T1jNej9LmPsP7v/Q82JyPKTFFsWc6f4rupDuHgiwLf8iT?=
 =?us-ascii?Q?cEs8/poUdWrrwMxePqDDXLDnZaM5yb704pkgs34hF9C7kbsAaA/yyWzaS+D4?=
 =?us-ascii?Q?M0lnr415R+cx7u+X+EAKptjujQ21Sh5Imoiz7lpqLozorUo4OAzVEn6Q+0Aw?=
 =?us-ascii?Q?ZvEocBnkyeEregeMAmZeLfmTUI8M6LznK70tmTtnnpmvJUyhifqYtRc4sZQL?=
 =?us-ascii?Q?FSrj830jTn1dofI8od/OdA78xsOQxGSpRpejQtmqUYtvM6PiQz110ZbF5D3c?=
 =?us-ascii?Q?0qPuWTB4IbLtume6SISUU8peCHHRfnHK/lnZeSDuzwoezQg6fRCrgexiNfJm?=
 =?us-ascii?Q?6H228Vv+Y9I4K+kQwc88PhOA11MA2L75vD34qpjyWlxT8XYO0yW4jEj0ynry?=
 =?us-ascii?Q?Ve2M5WpRcAsRF6PjmP5JoYAW4jXIOa57KUiq7HHAtWA5XcE7PkRvPvCJtQkL?=
 =?us-ascii?Q?4TeUVORdhyAZid3fu45CqsBqAKMvJvUUk0A9J78KZiG0aNjgtLMFHwhSbofT?=
 =?us-ascii?Q?P8/hqKaRKszDtQ7LVNk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cde9b2-6d69-499a-69f6-08dd6b0f29cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 20:05:02.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueToQ6WsaMG+exdwN84/bT1noLwOBGwoLqT6ZWArHzlb2FkCA2leCMVc3SbYrAs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

On Mon, Mar 24, 2025 at 10:07:43AM -0700, Nathan Chancellor wrote:

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0f4cc15ded1c..2b81166350ae 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3661,7 +3661,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
>  			break;
>  		default:
> -			ret = -EOPNOTSUPP;
>  			break;
>  		}
>  	}

Can we explain why this scenario has a 0 cookie_type?

Actually.. Is it just an identity domain? Nicolin did you test this on
your arm system with a device using identity (iommu=pt kernel param)?
I would expect identity to end up with a 0 cookie because we never
setup dma-iommu.c code on it.

Should we be testing for identity to return 0 instead?

Jason
