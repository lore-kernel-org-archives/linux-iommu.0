Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4541CBEBC
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531953; cv=fail; b=VQ56rx1VDtN14POIyqZmv37ql3ij5OWVhTi9VVPvUkLMu62OtUKZloBjDFNp0Ric/NuaLNZBCvjzwcGIvJCrHtXCnTcW+sB8mwPqpdY0e9MLcrb6VHPYqODO6NRZvKFw0k/OVDlVgu1Np9T2K3/UlyynsH2sHniHUYjE10HYsLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531953; c=relaxed/simple;
	bh=peKJ7FpMs8NR5fWUa5h0YoYM+T1Ckt9RUhKrmUaL8z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=govZ8kZk85KisJY2s5Cr+Ws+pQvKh3TQsRInGPzMTCYxNWEC/7JrGV8Z8gE9fm+dzC1DZH1S2cfyyqErEns/a6YusScqK5p+eVKQFb/fsLm08BZZOLOdUQV7j0Z/lUEvUR51PMAzU95m0BdrRU5HS6pw2gg8LaMFJenX3BFmebo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGjHE5Dd; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGjHE5Dd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijvdxxxpeM9CjyubT5ZCgfeI0aixVPEjUroEXQM5EzR05p9y3Uq4aerIQHZmEawRC5MTWUKjhHNyrOiVTxXKw97P2/da7GaPOWw2clLzO2EwVRzMzAtzLbVauR16bHjNperEPeul1xUi4I82wUqNNzHkXDvxjhSJeC09rYlz4/VFHh9IXLTtay6nGcC5RijY7x1pppYM6dIiI7uTwwXfnsaiSkzJsSEszD7HYneKyFTdxHSY4S4O38ia/Kl+miQlvfKjDccqnT/woFH+boxT7ALWc7MqcrsxChQcwa0V+vyYzduPf1nYwNZgRqPl+gXyUhz8HJJEmQHmhlfq8CgKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4H+D+rr5zNrKk5UOIWiQXwqFdyPAitsp/ZNGgEO7D0=;
 b=AoCISSEg+kbl2UXLkBNqdiImj9eiBhtuaGZwQewLLy+rZtfCF0Ul0pkunnHBhJaMV31OjJ4mhbhLMy56dm+sFvfnQqx14YwlqufYGxu92hKc+lja8yuNjRIp90ZWZIhSuvOWQiY1RXPPiaCACki9jWypkWeIxl70eqBMyzvzsXzWBF3Fcu+VqoguXo8AF8NYMinjQmBefwZZGWbuuX0u1XKqd5dxpUb+nXgISwOg98u3fNjZ334hpOQKznQpOD6yWz8LJllGUj42TVFNhar+na2XaqwHBQxqfe7Eu38TXyMcUW5Gz821OXojo+Ncvq5lmHD83bvYD9sdRlzheSS80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4H+D+rr5zNrKk5UOIWiQXwqFdyPAitsp/ZNGgEO7D0=;
 b=qGjHE5Dd5A3J2XxGveKFJaREsZvQFsfW9JuhoIl/o6uKdJ6GxI+s2UKguqpGCev+eVxyrs1de0J9pZSYlCpfUyxh5spUtHCgoTBP7mKKM6ljKwr0lGivBceQxnmOdj1CjMBVNEwfIf2nECPNfTFaDn1JcmxdRIxA+XQZ6tP+KBUwcVDuLQNO97m4BChuA3WMgEvaqCPhzAhYumnFwMsD6nXAGau+MPlGO+wFgEd6FMHtNb+hfH4UnPfY4hJom1X4i12tZtLn9xgDkxUWXjaG/bBNMpyuQvGSuDv5bY+/WuXahtx4XLyoHsrv4hAEPaA53/JsbdMcBTzge5e4EBkQ6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:32:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:32:27 +0000
Date: Mon, 21 Oct 2024 14:32:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V4 6/9] iommufd: pfn reader for file mappings
Message-ID: <20241021173226.GD13034@nvidia.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729286856-127844-7-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a001aa0-cbbd-4eb4-a411-08dcf1f65534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yaBN5NLjnS0wjCeAK3gYtl42/f3Fk0SAs08AtWDaH7d5y+TTaUIY8ROVfJey?=
 =?us-ascii?Q?fjt96VvNhNS1IvtOh9rvllGI68rPIa93ClLkpj3CPmmzN8G5jwfGpQ2sAmNh?=
 =?us-ascii?Q?WIvsqaLu1HxfxrhQttO3JZd8RuWrV34V2RNae+2O8etQTX/eXkCkwYwNV5z7?=
 =?us-ascii?Q?sWaGEfxqDAYH0PXPUDp5Q33RzGHbRCPLsizDluyYNcL2U2P3+j9QueZPzR+R?=
 =?us-ascii?Q?lwcFIQ+H43LO21+NZkHXlpoduE/FnXlXqs+/2KEP1XuRIP8ob6yCoRIvtxS8?=
 =?us-ascii?Q?C7GWAGa0ODFWD0kde+eu93lLZSE2bpGajY8VVRSCuqWV1LDxOEsXrUDEqAQe?=
 =?us-ascii?Q?daIXf1FSxMDh8vfuhAPWODdKMez0ve8Pgwmt90SlL9wv/h6OQLh6QP+qvId+?=
 =?us-ascii?Q?eEU+T7KbMnBvDJr0yDzjk7r/NIXWHPl7As1SzZv2RpJHV0dXOO0qoOOXl8/C?=
 =?us-ascii?Q?MDHxAuIkGfmqY34Isk3gGF2cLFgPFfaG7pamTIwITxrmFYOZvtboZtzxzX7T?=
 =?us-ascii?Q?ANnrIrdV7sbF9lByaqKDUEmOYZ6Wt2zJaRfZEkUJplZLoIKsFSUhKcXpDe2F?=
 =?us-ascii?Q?at8mXpd1F//qMS3S+vTo9IwM7kSLTTMPrp4hB7Y0rA5ThnZTQ1TOG1EFZDay?=
 =?us-ascii?Q?4+iUHVXCtR6ikKulTiq1L7mNsd4jfWTcspJwdyztk1xsDsb1SO8zboUIYLKu?=
 =?us-ascii?Q?K4pr//U/coB8oSj/QeKsjAzCGNp/qH7DIFSX0dynh6IgM2xyTVY2EkIVRq0c?=
 =?us-ascii?Q?QrLK9Dod8JtEkVT3sC28CTwy4jVhl3UDE8ES9fgsBEbuPl1gX4a39yGiaH6b?=
 =?us-ascii?Q?RWyZxT9dvbGm6kBRab1ZocjmgUL+YyCFFr2FwRUhImdQHoG8QkNZ5Lugs1ih?=
 =?us-ascii?Q?scYb1cGnhVdJaRC2R/helAzBpBFLvFdC0YCW0jIZjH7yzuNRWZvwtw5qRZia?=
 =?us-ascii?Q?aIU+TUqLN0UeGu0q7hDIw5YGG+NioZgf5iodM2tHSTCFTwezutBjeoh/nYnI?=
 =?us-ascii?Q?7XfNDMx6H96uO0vVw17bJXyyJC2kQ84cUMQbp67Un+Iy1sPzwgGSOhUy735H?=
 =?us-ascii?Q?stomu2ZYd7ss8jueFD/B9MFf9vMp7/UuMp+kd5P9Vk2RPfWY4yVbxolqsn9J?=
 =?us-ascii?Q?2LClXF8awbTjimK5rydQ2CmeTDMN6Q/Zu+6u16bZkWnKWN5uTbgNovSfNOwN?=
 =?us-ascii?Q?Ftr8p+BfXDv/UYM6BfczbeA4p8XVXxQn790uG1rNgqj0mmgmff6zXshPIj9N?=
 =?us-ascii?Q?VeeZjEAKjiUUw7gob05XN6zDTAStcRzpJB67gAO0b8tybO8+BnOphlrcx2Kf?=
 =?us-ascii?Q?ZK4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0ycCoUHS7u+ifL3jY0KpjkF4rVmH+9ZXO66L77dRVq35MvQI83dg024hhrG?=
 =?us-ascii?Q?UZ9YMuVw02MOO50IKStESEmg2l+RoCRAox9otLHYx37qJu72bWSpHctn1LzZ?=
 =?us-ascii?Q?cz695AdgGxqWIgmtv5Q4Au+BYP2x4+PpE1oG1CDdR1XhkOcXaeLq6/qu9fqO?=
 =?us-ascii?Q?p9VRCOFds8dLBJHVm4J9yHvScdujtZIiVjMBdmZyBD/GyVcBseeEccb3ygJr?=
 =?us-ascii?Q?w8SItynfc58XoWustO4zbhpUYv6gmV7q+MQ8IludH6Hq6rQ0gVRwTdweqIHC?=
 =?us-ascii?Q?AxP/2sdzxKHBqcVin+APYDC1O7QX0wSLePrif+weQ3fJAB/EWrSDfM/CSXyt?=
 =?us-ascii?Q?je289khMwmBGMqg9FHyrNlIu7Q7lKHLlEPdmZdTW0my38P8xlvo4sc5Hd02Y?=
 =?us-ascii?Q?nB56B0UHLjk/Dz2KalHXrVeYtyHMaWT6DBCU01ACLpogpgmuq/0kYaPMlRa4?=
 =?us-ascii?Q?yurLi509BFDH/UAePuO9MbZJ0UJUw3k//I2hqKJSMAj/YPzH2x0/D7CI7ZZ/?=
 =?us-ascii?Q?UKmXzpbOeo6G2oR7SD882AIA4nQ9V/j1hXkIm83OCx5iDrZI+elamd04R0WY?=
 =?us-ascii?Q?zc3QTnAPl96iXwf4CyQqzpDurVwyvvjqVIzhiovHmCRdB3zLCRXwQo7yOCCJ?=
 =?us-ascii?Q?HCNV83zXkxi2vOi2+ID2nA6zbbgX33GvAzP2128sEMsZ+vM+JbtgH1sTDk9C?=
 =?us-ascii?Q?kbwPX/M2ytWKPBdsvO0QypQBWTASbdNbhJN1jTM9U0sMWB02iS2iNQyKPa9i?=
 =?us-ascii?Q?t8CQgJCBQjtSes7c4/nk/K+ZkZQoGYbEJU6bafq9eC12r4ABFotbVqRuIdto?=
 =?us-ascii?Q?Gh/K/ZvpZoXiecnSyR7nd1aOLipCoLXaM1oAtNIOxeNZSEA7d+fParkIgDZs?=
 =?us-ascii?Q?hgddjp0UgOdLDlG5Go2vlTt7ELrUj+vau+xEeKWO+l0//8EdKe+udvkalGpZ?=
 =?us-ascii?Q?3GI62H2QVrE4w/CHkgColwniC4Hv+cS3HyxVkUigK57rm3r205kpfr+O2BT8?=
 =?us-ascii?Q?BCzrT+KfBfpBoAY+mvyMSbN9wJJ2ak9ww1NgFmwboKdxNR691lI6H5f47UXf?=
 =?us-ascii?Q?8YpfCy9trKNkBHNosTWSKiEkgaDQaUWet3A+n2Vlwg9YvaCO8ZtuEu6zzNvl?=
 =?us-ascii?Q?bB75mO2W8nR+mN2TLlEvninhtn+Z27CMxVI5vEJxpJEVW1zPKawCfrowrs5L?=
 =?us-ascii?Q?ppM0k9MxG0eL18OURzX5qVg1M6CfhtvnLubr9Kuwf+y14baR8wL0BmTLFK5a?=
 =?us-ascii?Q?xuw0QzJpnmXH7ryREeC9Lb+6ML/U5tTCMv9yTmrc2Hjljnx6jma0KRoWtaDt?=
 =?us-ascii?Q?44BC+MJht/kYNR+G2jQMiIpKrQdhGAl/CJlLqcy+0vhijt1E4iOSTyznkBsR?=
 =?us-ascii?Q?XwI91PG1L3b3YZh5M6uLwhfuuIEkoOuUKzPyXoPvhpy9rhISbkdNg/CbRABF?=
 =?us-ascii?Q?ajA3MOr+8FCcHmWJ/OsuSB8rn9aTqpf0ikyH7dbQ1wdx/QJW4ixzbcReK55r?=
 =?us-ascii?Q?hLUIV4zwtY/9BzNSTbUcnUve4E0W1qkutfLw5f6GKJoj8grtg87W8RNC4Dph?=
 =?us-ascii?Q?SRlduuSFXxIt+9umtnBCQKOhUDqwRHDerpWAwwNq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a001aa0-cbbd-4eb4-a411-08dcf1f65534
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:32:27.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulMyOhPABcwfLScDqI8SmmAct6C/JXJBhxeIMT9Q910h02Nx2sitdLqTuGtZ851S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041

On Fri, Oct 18, 2024 at 02:27:33PM -0700, Steve Sistare wrote:

> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
> +			    unsigned long npages)
> +{
> +	unsigned long i;
> +	unsigned long j;
> +	unsigned long offset;
> +	unsigned long npages_out = 0;
> +	struct page **upages = user->upages;
> +	unsigned long end = start + (npages << PAGE_SHIFT) - 1;
> +	long nfolios = user->ufolios_len / sizeof(*user->ufolios);
> +
> +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> +				   nfolios, &offset);
> +	if (nfolios <= 0)
> +		return nfolios;
> +
> +	offset >>= PAGE_SHIFT;
> +	user->ufolios_next = user->ufolios;
> +	user->ufolios_offset = offset;
> +
> +	for (i = 0; i < nfolios; i++) {
> +		struct folio *folio = user->ufolios[i];
> +		unsigned long nr = folio_nr_pages(folio);
> +		unsigned long npin = min(nr - offset, npages);

Let's add a comment note about the loop computing npages being able to be
optimized someday

But I think this looks good, with the add_refs change you noted

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +		if (upages)
> +			for (j = offset; j < offset + npin; j++)
> +				*upages++ = folio_page(folio, j);

The upages path is 'slow' and rarely used because it is for mdevs
only, so it would be fine if it was the only loop here.

Jason
