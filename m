Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8D1CDFAF
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812714; cv=fail; b=WXk81jcQg4d/10KkjwjotjLHhyFtdJ1cfE/MyM6Hd25Hrgp2+hGmoDnmp0gUesiaPOmQ90y2U3mhm8/2V3qP4o0KbCmlLgPiX7XigF/v55qGIY900hnPyCz061g/isZK2jgU7W+DqcgS+jft01xqQQviWSQLlM5M1egNV6z1W9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812714; c=relaxed/simple;
	bh=e/Cwnck9FBNoUc4drh5KyqC7753FILtPNl4EbOwZIrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmL4xcPI7m4uU+QGCOKGI0z4M/Qjjvompt3hfEEMrZGqiGO5UOXoYrNCG5xaA3eN11Eiyrry7IBUOjy4884n2x6mPAsgpLAETopoVCOPWz0rka08NGkafW9hy6n/2QeNxqGfn6aWcDH//ouGRvOy2/A9IeOY10NL5Ppx12qEIQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gkTpfa6X; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gkTpfa6X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGloR16kCAJJq4Y0jY0EqOY+pngSTm5FKCitRrkK+5MAjhyJ5CJqz3K24nj3foYc3HOtzF/gFTngcqsVh91LWoDzC2GWuWzGkzc3/dsC2HJdz5c/hW4b6QhV5vNr7KTh70oa4U0vs1TihPEDFjihTmEUOjQRgr5FyFaWz1tU7m3AeQMosp189IjjAlGfvTLpO/ljVXruynVjK/R4+Kt5BKCNEGdbhgV3U8g/Zp7e0TALxpFzGdfZ3n8Pd2QdNicmucK1V+AkIuLRIMF6ETxUUheqjHu68pSLJYTg+xpkk2mOuW36MRTE5fsVS1W3W52OY9hrEACHAOYWOmJEXeobVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+sXp4UwDyZVQiZ8ZdrdNLwDM6/WK8xam1E53ctLtnI=;
 b=dLzqT/idFJ0u0cLEiIk/5XPmngzwUa/vmnDmMlbU2/zLGV/a0yf3X70URVxu098INOtdPqhmm8Bh5xPYrlNU1iaUoGeFne/dxhuTq+i5cVfqDWqBcFdQhUaG+L2gNU3EcL4q+G7nR5VApdtMQu0Qwy5kugAAMxfKYHoPKzC2HDSAHxL9MD6Bwss3z+nOSIsmjAbDmQLp2Jm/b4aQZfwCSiP+SFHS43SJg0qAUMpv3JxjCYmNMre2l4eIH78OdPHTqBRw7aQc241JmYWpPlp1Hpl6mS69lt035XhOliamqjBeDhWqxCNHF5bDdya2Z9M8+n1Bs6MmSSlqQOEtlH5i0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+sXp4UwDyZVQiZ8ZdrdNLwDM6/WK8xam1E53ctLtnI=;
 b=gkTpfa6XeDfC01e3nxNun1rPFCL9K6JY9PbHrSJ+pa5yaMajiaz6ry6k2bzwSAkhywWSZNaT8IFqBwb6bnNjspGaobguDGEiTA2NVUn7TXFwJPn/RQuoB9fkPsyF1U4Qb852V/e+n+OIX2MRjeVbg1fu+zNRJ4lGeu28/HoFHp72cf/jT+7nBxZDQVjPNhWdVD4ppT14Bu+uLIDlm0aIksLAvl4sIJ5DMqo69yXCmWhVAEeVF5Ny79kwRTQnoirr8DlFJhX9dvLpd3JjQQUXAhgZjK5Epdo8DSPmvpF8lC+PBD9NKt5rek2Ss6OhiiQTgqbYdb9GWll0uPg3Nr1Ymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 19:58:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 19:58:26 +0000
Date: Tue, 1 Oct 2024 16:58:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 4/9] iommufd: IOMMU_IOAS_MAP_FILE interface
Message-ID: <20241001195825.GL1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727190338-385692-5-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d091c6-f04b-4037-5f3b-08dce2536994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1El8kS7jLKsiThIb6e7w6HM5e//L2h+aTN29YKSodHcxkvDu98Mn4d2DtysG?=
 =?us-ascii?Q?V9RUQmAGYSIln2UQsNfUtIMpFmcNX6UpuZx067a1CakNJEqJTnxLyLX3FU2k?=
 =?us-ascii?Q?AP81aIPtaTN5mMbuFmystoGB5gqUS+B7tb7yxTO3J6JxEaLHQNDfJw9JAtzR?=
 =?us-ascii?Q?fmYu1XkHhPWl4tZmba5RP1ylXmt0Sg3yI7UL8mR65Q19DuWEtYn5YgovuKk+?=
 =?us-ascii?Q?tQ1hV2tEthcU+Ixrv1qUPaSCwohtU0/jgF315uGirAGnyXyDdAg5E17mwjhW?=
 =?us-ascii?Q?gdOEFcGHbgri0Mm9VmDM1fRI3XfJMwh4Hwhw3nfvAwfrQk3zI4r/oyiwGt3p?=
 =?us-ascii?Q?jUwxL2juN/zwsvOfsVDULHmQvGbye5lRqaNW3aBbSsObi/MeZceXUUaG2cUq?=
 =?us-ascii?Q?iI+0j4cJAYJY1DUlyo2IrjeJKjiKax5aHp4Vx0v4+l9W7b9e5rlYWnuj2dQW?=
 =?us-ascii?Q?lSy2QYSE5QTuFBtVS86bqTxV4WRobuiwZUL44CHGvamXX0zyY5sSinzrO8p5?=
 =?us-ascii?Q?8XDNim6yEwUs2qvRLqsQTAPdy4DDTaMHV7EHBFAHb6bYJh2IilbT3O22/o4I?=
 =?us-ascii?Q?5tcqyZ/YB4LnJOUj/bOHCCV5sWvgAUCG9B2Kl1zKs6CVibqqaDw/2eV+7Ano?=
 =?us-ascii?Q?7EUxFRIaix1+en2xW70MkuYnbpZpkoQNgAdVf6y17Tctmgo1XD6Cpy29l8eO?=
 =?us-ascii?Q?50CCKjOxP9DwsDvyin0bBuc8mwU573VgpK/I8wjLz8Rl27F4+btfGg2nu/zi?=
 =?us-ascii?Q?r/WDxT6XYcOwUNfNt/vlFnEODZ7FolXtRZ/a0ehO+1bcivSA6G2BOHdo13sf?=
 =?us-ascii?Q?1YtQMqKjWnvMcT7Y+Y5llQbWP9rL1MpGXOsFh/pBuGjhggDIDIqygmAtHwaR?=
 =?us-ascii?Q?vCT3/+9JYhVk2ICp0qfdtoXjcSi4zyqaSYs2oTbWd9Ka8UerRnb3UKFBXB5L?=
 =?us-ascii?Q?9QobQfKSqggM/5HJtoVcojkD70N4hmBrzS0TzlVztO00XFJnGZfT6CATUVcv?=
 =?us-ascii?Q?AeN7Pgl1TNUX/TmXXdfR3lqM6omUOSzXeCZDq/xgmpEmh7WDfbUkVGzOI5PY?=
 =?us-ascii?Q?MmF+LSHxYn3nEUKnIpTxCRUQ29wU7lqKJWnrK4jB9YGXUb2fanNV4PVrh/wu?=
 =?us-ascii?Q?jFD9M2k80aBwc95me5KjaPDw9uX57Hfm8EkwDAoY/UKKWRmYTSTtrMCGftZl?=
 =?us-ascii?Q?eAeSpV+ItOPaQig9nChDVYLPrttrUL3XEaWnWFCYdwlfFsBHTS7LcZe30vD2?=
 =?us-ascii?Q?4U+s7sIXuuuGZD71j5mvLMchozZoLdRef2HGgAUUx1uC2AwspdxA84/p6ga7?=
 =?us-ascii?Q?ZWSnosU/ZjkUS6hbmKYrEw776SGTZNZArCS2FX/obEUjng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBpVMlV40O8IoaESO3FLYtfRJbQAQFnJRsqVECLiLOwvmerfRY2bC5IfQGuF?=
 =?us-ascii?Q?waJGLy8TPB9XXa9M7S8j7/T0azwKYqYDtdwLMMsXnEL9GDBbQ6ZR9cUVovlL?=
 =?us-ascii?Q?M2llYLjHKCyhWmW/aIZYbiDTLPZ42LUUrzNbaXYOu/0OoYGTcwFZXokCl0T6?=
 =?us-ascii?Q?6aYc8UKKJXRI9eF03GyJl9sL7ILiR63UDxpGdOJq8WY9DjLrxa/JTInz2Q6o?=
 =?us-ascii?Q?NnL+uWgEAalyHb+X5c4PVfK0/sBHPHhpyUSbyCSewhJEksDQjw1FJygdS1v0?=
 =?us-ascii?Q?qdOmp67dEpFht8dxQY/WDIOl3Mzd1BCjmQV2AwqTkeOAFrC8Eq1OCvUc15JF?=
 =?us-ascii?Q?qWd3UI83udNwlKU1/sefUsWVdQbxGsHg21Dzp5x185DYTJgBW8cL5vnYDyWr?=
 =?us-ascii?Q?M+AKONcKvmVw1b6yrA56aNUEdQ856dXQ+kFwYbnJdZ4fUtNligYm5qColQuC?=
 =?us-ascii?Q?0rTJDvjCtlTejLTh8hke/w1ynZ7eTaQsZXyieJVeSVwEApIUbb7c/+2sPmne?=
 =?us-ascii?Q?VHNsW128Kh4ixU91Bl/cotXsnUcmf0n8cW/9oQmjbl03GSGLSoPgZwEpZIgv?=
 =?us-ascii?Q?iS7Dq73h3RwVyQs5DPiKWLxMjwzkxXv/hT7tPANPBx7nDNttyTojZOyBS3os?=
 =?us-ascii?Q?kSjZoYjNbkhYoUwjMgK9BlIT0oJUWWJvo6V4LJlau2rk/IcJHVMDaY2QiQnN?=
 =?us-ascii?Q?U8bYQNZDxpwlxxdNhh8d3tsl9knl8N8Q7uFbpVqTYqm/8E2wQyWy4LYhls77?=
 =?us-ascii?Q?oOnDDF3SUS+USBRDMDEHWS2aHlzKr0p8ZsrBq+Q2QiHXizUcHimP7LR7JAo2?=
 =?us-ascii?Q?m1wmD4stCiPUMWLhUiU54EMr/tNxlccbIDxGO9h0E06vIvgCsYSPcUeu+J6k?=
 =?us-ascii?Q?G+1MtscMQASD1vk8tEgpdsqOUy6UCP+80OzkZvofTTGKLSqeTH5kaqjpl9Yu?=
 =?us-ascii?Q?+bP8lQJfH9b7Sbj6KhlRTLqkO3v2oqyP+6F1BteRvLZxWmB7sjdR3ZVlgMJ2?=
 =?us-ascii?Q?0bNkLbtdVs5XuEpNMAfP70uN9CHER1cJj31cvcdcdf2eFe0M9u12cIB1Ultu?=
 =?us-ascii?Q?9X+yZIIBWTR+yaEsihpgc++Syh6qU1eTlQELTVc4HEtLJ8Pp16D4oHZym0Pc?=
 =?us-ascii?Q?D9/s8RdGBhcgPvANjFy5ynbNHy+X7IEI8VucvKQ9H/2+/ELUco2+Lsg0B6Rs?=
 =?us-ascii?Q?LauxE/QXvnKhjm1lWJpqWtZxNl+QOTWGTt6sTEpxfXtXnwrEym8v8u4EwKcq?=
 =?us-ascii?Q?Mm9QFc9kleJosxiDkyShIzpBDxOxwq7yQmcJNyVEV+hYfTsLnYzbJYB3BZhT?=
 =?us-ascii?Q?kod+b+uSXxoghhA62kB7DCvPEsiuZcdgjGXwtySA4Y+dZjwy+GG2/nFdB61+?=
 =?us-ascii?Q?HVr0S2GpbFYYd98/rpq1RK6oyEODrkaMbz6Dyh6t8D+fwZvo6slU4WTafTFU?=
 =?us-ascii?Q?2Qkd5778Fu7OE4Ie0D33BAw0OuLHWiHVeiddlqOVUuzWB3ND+aNolYKlX9XC?=
 =?us-ascii?Q?KPzVYleQ0tIRWoX5ygyBw3nrJDkFohoZkcdDNF57+oZpkGm5H7hF+ZLBY/Q5?=
 =?us-ascii?Q?9BW16pJBsl0HzxmgQ8s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d091c6-f04b-4037-5f3b-08dce2536994
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:58:26.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0llVWUzpjErJCRvRMET4YEN9GdLVLRipVeW69PcpepuPyla3rpbK0VnQ4dAux3q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

On Tue, Sep 24, 2024 at 08:05:33AM -0700, Steve Sistare wrote:
> Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
> register memory by passing a memfd plus offset and length.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/ioas.c            |  5 +++++
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  drivers/iommu/iommufd/main.c            |  2 ++
>  include/uapi/linux/iommufd.h            | 25 +++++++++++++++++++++++++
>  4 files changed, 33 insertions(+)

I would squash this into the next patch, but it looks OK to me

Jason
