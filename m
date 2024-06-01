Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C733CA
	for <iommu@lists.linux.dev>; Sat,  1 Jun 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717276635; cv=fail; b=B/RY0ucYSq2L9irOaL6GuEHcAx7eIcOgWrT+DoAUBxkQ2Y7gp3mifwMZojkfOAmMO1Z1gV1qGmfFREBDh/fToi6MTOgpuOwRBy6CWn5gjHd1kwARFU6xJ9+alb21tiNDqfP3CtV0y0tfV24LSiUAYL6s9x6tvZ1040NJPOcgJd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717276635; c=relaxed/simple;
	bh=H4hf6IjzgYgD/9ajTxK0X/IbM6sSAdpu33GIo9QDhKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cjyuhhZvz5XnoGRblxvCL5zcqHT1pDilxOag5Qxkl1Ev1bHS4pO0XoFQRCPkzaereTTmmUoEQnN4kNufEZslti75QRGKArufQpao1ANlT1P5XaHWsnISaKwSAMeWOout5xqiGd1G4/hSBQseCg8QvWZy7RLnIeAGfpIcLk/YvrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXg2ufM4; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXg2ufM4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJPiwChLyzeR0ZLgYsVItKsra8QorcmaXyLmqc9069tIXzhEWBBt9myS7aJ/4ZVkNYV7yf0vyvJDFubbSWbq5No+vM9XXN3a4TOu6OnEksJpqE7R6A7epi3oC9n0LXUUMV+SgAgns0BiII0bw+MbAhnUXDApm8h0F8PqJrY+qs0CM4m9/Z6z0kNs+XwKqI5UgpG7fVfcZ46E03ePZhA6tQPFSRbq3PrhUrxkdNNuDmM3vJxnQNQol9QkPj48aGa0mCONt6S8g4jTPB1L0ABbWmozxa4lpuvlHnvgNf3SsWbv3KHj98S5nBuzGziJovqIQ1Br1j+YOZGM3S7IqGeMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqzvs0pyW+fDy6p6H6i9rNJcGx/vNhfPHCiZuUBiJNo=;
 b=dfdjzpZXoANkA+Us869SXbar0xciQFv7moI3GyKbg9Y2zAYekztrf8jyooJ14K7z4dGDz8yK+GbkmnF1wcYkxrb/yIejGl9eUn6l8M88kwCTDd2cuV+arxj2YaVRXMcctXq2kTPLneyukHo2XNUBaLVkI+IWkPzwdlVoJNcnhHw0aIgFBMPhdlzDdwzZBVAikYkoo0D02Xnwy1sjnSGkKx5RUnIKj1qhRP/hyDnScf+NboDPPjXsDHlHDLLW8zRa6/J7EBV+qR4NzVqbKt7b0dLYDnq35C/6xy53HQnwKoShxMf6xkxvJ7HdqgSGi/MxOOJICNVVcrnq9KYzmZDsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqzvs0pyW+fDy6p6H6i9rNJcGx/vNhfPHCiZuUBiJNo=;
 b=YXg2ufM4VKcS/mERdT39hNjTdeHcskokGEH7oAY4qXstKpfp+rmjHyomgDXWAWp244u+Zm4rdFwY5vAr/Hq7mdjFlUd6DEBhi0/jUcSqvARhuviKSGH8rGQm42D0/GbiLrkWSQLj6kZ7y+KqzjR/dIJ5X81CHVlunEWmK4FAL9c0CKXt/f3z2DdwWrA72EHuCz30ufnZAV9qlFf2cgRfgnTti7ZV66MUTFl8VwFzfDCj/qI3tOqYLyKStCiwDMHrjE1cOhkiW4mgX8dvZ1311V1drffJhAYO6/FU4jkaPGRrgp20M4Am7iHDZ5PmDkDYkvOV056OoMj9SlAH6SO7Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Sat, 1 Jun
 2024 21:17:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 21:17:08 +0000
Date: Sat, 1 Jun 2024 18:17:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v4 5/7] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <ZluPzQL/qF9A77du@nvidia.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
 <20240528071831.17560-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528071831.17560-6-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0158.namprd05.prod.outlook.com
 (2603:10b6:a03:339::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b7e3b6-ba1b-4878-783d-08dc828031f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hwa0UsAgo0U/9rO29BWUB7wqEqlnAUNTTbRin4XvyzChAHh7wl8PePnqlRJE?=
 =?us-ascii?Q?Z9M9DroQHHhroaKXxiZIGl3eYJVjpg5oCYmu0IZITxXO1JaTWlEacsMTEfDz?=
 =?us-ascii?Q?C4TAWDruOgc3DgAbub1oa71HnO8gYt60dX0xFNcEyKwiRWOhCx447o4PHCwu?=
 =?us-ascii?Q?wr/U+pvKJtuz2rIFO/62Q87rBwS5mgiYMN1kpd5LVGiBTtsJcsIMvxtBT1U3?=
 =?us-ascii?Q?nP+qoSQ2DU9bj3i4MPCql4jRwCd0r/BJkV8DQdwx3GVs5lcQ9yq4z388wyL4?=
 =?us-ascii?Q?MNy/XalTXaAVwL+rU5Rss5XefIeW+p0VFOifHVe9za8VSJkzGBRXLpQ2NdK8?=
 =?us-ascii?Q?WuPWjLYI02FtInNfiVNgIG4bIgcgqDKMhp90BsaN6tTorCawcflyiRZxWP9G?=
 =?us-ascii?Q?dgAL/r7qw0uknYpHgQmeDhRqevtg14gIozXyJ+e1jkqHe/G3OhCBolbFf7JZ?=
 =?us-ascii?Q?BidlaudwQxea/APKDGgR4Gb9cMLCI94Og4YxXyUrvfpl/J+VlgnAYFJ8giw4?=
 =?us-ascii?Q?Hi+Ts4HdW6/lU0LU4vZW5ilNGXaN9qPBBwm3o6GAXzc5HdNy3j7LX8zO4KHf?=
 =?us-ascii?Q?oUsBFhb7bc9Emncgl1I3hHNMMvAnerayly4e4tVjJldvpAImv/JUounHOn9S?=
 =?us-ascii?Q?+WboOA50HfiVB8wht41XFL31zibdW38d3j595E6a/jeVG+TL2BkiH3UdKW/7?=
 =?us-ascii?Q?AMMfiFK0u6/ziiIrR37EW6/MOGAhpsH6cpBFKJD5TqTwIAW5IRn/G4x8guEC?=
 =?us-ascii?Q?pbD0GvHdK3BLy45iN0MgBlDSu+HanfwS2vZAr3z/MJw8Ov7Zb1uE3PQGLNHg?=
 =?us-ascii?Q?rIxo82m8rlLr08SWljoW1othupD/N/z+7cnjLybKN+xkrokeUH7v3fHBz4YI?=
 =?us-ascii?Q?2Lp6Qi5Iz302Od4BUKqL1z3xOblEi9a98gIvhpyTZFe28I41I5Sfg5Qg7U4a?=
 =?us-ascii?Q?xZzMq5sKWWkkOLCXTmDmNlyHAh63sLCPN31IXBrzOLMm+Oxh3mI1VZSv8M/D?=
 =?us-ascii?Q?5MTjE8b40/6pohq+ni2RR3zOk+WmgLyzFnCQ+qwCmrrNDbfFwZW+11K6+U02?=
 =?us-ascii?Q?2QydFgx0d1c6GFd03BgqgIlZaJ5W2/3XxV0711HibrW+OsEa1Ffc+4FS/843?=
 =?us-ascii?Q?JCsKENaaJnL988TiJN1YlVWmpcV3u8yq0t63mbW9EDnSCYPwmo1pkQrjjCq1?=
 =?us-ascii?Q?KBd06rooucMNOPfc5DmwtWZPSoa8NwnHeUycjB1GabOuAlXkHh0mXY2dfc/d?=
 =?us-ascii?Q?A7fUvcYGwJL3ThBKQvWqlZ9904gp6RjgytXqeqZNsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/qYBLJjQ0AZfhBod49hWPttY7ImHcesoAz2eFlRdz4lajSly2hOpplALDgMJ?=
 =?us-ascii?Q?35yO9wVVLAsfpsC3EvTFVjRNoVfpXLlpae1DM+FhzO9KC7g/bLaQULPkKrFa?=
 =?us-ascii?Q?VCgc1aINsKDc7sRNvLt5235RAnWRxbuzYSunolUGz3dpHJETdwGbxqrl3C/4?=
 =?us-ascii?Q?1r2d6S7bAqw1FQG6mWNU1dtC4Love+qz7ec2SgrywKgLe+QAAzyDWfiyzwCL?=
 =?us-ascii?Q?iSMMTvWTQnkq8IsF7SF+hEVOZ7PrUaSdeJ9vu9b22vCF7QE3KI/OLXx1ierg?=
 =?us-ascii?Q?DaYoCw+2U6EMjTLpK5/OkTgw7y+WGzYOb5GH/zoxEKmFX78thtpdxHZcsurI?=
 =?us-ascii?Q?THXf1TY9GIQCkM5x0VVViuxiDEVZBWWtd9KAH2sKynNOc2BZ/lHMRJXfGkJ0?=
 =?us-ascii?Q?5IcM05LkRHHgsNgAXAIyqluSBpZ09M0XdraTIfe8MZwBGBrbazE1umbXiaAr?=
 =?us-ascii?Q?G9npUvck2k/h6cH8/IrmPXD1pPI09z6kLFyzWNXckpmDdJUEqKxUppOIRnZ9?=
 =?us-ascii?Q?3Egvd2P5fDTW3S2TAVu3Q83XuPKItFqQnaJNBSK+4L11mfB4m6/VcMkYbu8e?=
 =?us-ascii?Q?M1KJIKW8/++J4gSMzadsmgmytFcb3B3ibkHPPAr+m4SIT7y0q/fiSZ3HML/p?=
 =?us-ascii?Q?GV/GigAlnoxNRZdM/kFc3OiX8588E47wylvMcF71dIdkWFLYP4VRTFHNKDbJ?=
 =?us-ascii?Q?7UzM1SnxotI7OBw987Mb9e9w67xexd+rgYVFqprdcI65+kvEBH8sShpLhVd/?=
 =?us-ascii?Q?2WKMS7a9O+nQQWa6Ps8FxrLmwTO+tAI6mdZHd9MMgYclNN57XFVBnd9f8Ggd?=
 =?us-ascii?Q?PmfxRxWlUbI1PodRePRMhcN9oyp0tJ/c5DYcuk5WKVsxoBN2UIAU7GzBn40n?=
 =?us-ascii?Q?6cQVS0Qgx9NVihbVhKjpLJueSbI6OCqdOroPE9Jxo6k+C/1REPA/iUJY+ccy?=
 =?us-ascii?Q?6l3EXTjDh6Siu4sKQzmekZHTQGkV3uAElCEcBEuZYrrkKmtUBlg+4dqLGxIr?=
 =?us-ascii?Q?2jE1HLxy/AgZPQ7NUac3KTxjpK4+iYzTMnZ7mlw4aUdW9nxIyHcSkHaeg8bq?=
 =?us-ascii?Q?BsHb0QYWQsR/NKAHX58z3kXNxaXmSFODZ0++py0nOKTgaceq9LLjnBGpuiMY?=
 =?us-ascii?Q?XASLmv1aIJS8lzv9OPlFtdU7Focn9jjOhZZhYWnBlQU5IZCw1jhxABFd5bQx?=
 =?us-ascii?Q?Xd1LJvfrnhQzfjEyKgaZS37iDTlbeTAL0YUTosohYkD0MYqfAGGew115LFc0?=
 =?us-ascii?Q?i5gxGx7usL+UjhVn5j5DhuqqyqqQJhtdM1S0JlWqPGD5iv/wop2Zl+2BRZtO?=
 =?us-ascii?Q?WQEtM4wrrIDd82ILjwkEue0FiAqI/AgRi1GjqTJMeq7dpSY4PCg8D0CAD1w8?=
 =?us-ascii?Q?D9k3lje2GcPVl4wcuDWrrz0Dyjxl9K2zbcI/LCW8xN712Z4GFKDWJPwVj3Mf?=
 =?us-ascii?Q?wQ5QgYbEXD9FKRhHGs6kJYHmKpDzOBUZ7ph84Vwg7ZzXLbUCo+NReFwSfvyU?=
 =?us-ascii?Q?54kF4fyfS9J79gxQnLipPZhcpua5AzHIn9k9BtHFGs7yrxj12N/YXFxmLiem?=
 =?us-ascii?Q?+lFLgBLPmqJDnVHGfnP7pMYEIW+LCoTNy8ZCX8pq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b7e3b6-ba1b-4878-783d-08dc828031f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 21:17:08.6899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 985CuiWPOBy8A95DMk7uTR4Ym5k2Gq04zHhcGVGN1TEXqJheKcoFwZ3V0NbxqBQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

On Tue, May 28, 2024 at 08:18:29AM +0100, Shameer Kolothum wrote:
> .read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
> bits (i.e. PTE has DBM set and AP[2] clear) and marshalling into a
> bitmap of a given page size.
> 
> While reading the dirty bits we also set the PTE AP[2] bit to mark it
> as writeable-clean depending on read_and_clear_dirty() flags.
> 
> PTE states with respect to DBM bit:
> 
>                        DBM bit        AP[2]("RDONLY" bit)
> 1. writable_clean        1                 1
> 2. writable_dirty        1                 0
> 3. read-only             0                 1
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 114 ++++++++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
