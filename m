Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2516BE3A
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172842; cv=fail; b=bbltGFkEJ1l8Roi8PsfEfba8LWBH8gTjRx/sObF7sF5DueI/c0D87KyrSRYgtRNzHHr55gw7uu2awzLenU3u/5rs6ZAqkq3q0F/TyCT+m1ChC8g10W1hDC9qoYpjz3iSHW6Fs6px3Q8wtw+dTeKCsoeQIbgS6edXwnwhieDEXuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172842; c=relaxed/simple;
	bh=hZi/cst7UXfe8cmOOIEK6oOMC/ta1oSKyLjsJFmQj74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTWtqI1AliTAH4rpvA4yyahuhmGIrmEegxVzAeY6RU3qZFJb4/8Jm0dMaA9GR2ARB9KKK+tI/sSQyO2gimfI7aeXpNvbxiIn+Ge3zDSTRfni1GIq/EDhVpOZ/yl4rzim6eG5UT1Z5FKukZWV6BPrVD4c+RAFT4wfjO/b4m3NqfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HLwkKsMS; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLwkKsMS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTcCD3hFW0RzlJBgZKZEQKq1r0A1AI/5/SpEjRJhwUl6UzQ7ivPKx6ZNWIHcXDZKm4oAM0jJyu1le67WF8P+5ZumsgFdOeZ6Xx1IhYRYsfhDm8MIa7SfsVq4FFCb6f3e6wnZwfsqcd779ScCoFi3B/ds0/eM5mmcty7d60W/cTfT3vH8ugDNwWXJ6wCIUfrGRr5GNnbtLJYi49BG+0QkuH8E9qnJq4l40qfE09zItSr4KdsviHjyQY6sG5ni4ZW3YgY/4UUFSK5nPDaXiWESyzlrhxYXiGxjsBiEi1KlKEPbo6AoYb3EFdIDR1i7moXf8yQD6g4VwmwBPB+43NqyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFVXeQv1IV/jdUn+HR3HeU5dfDR4NQhJG5az71+0d6s=;
 b=itE3BgcpkJDqIeobvbtZpFI9P7baC1pi7RoNRX19RzwJBux04TB73KzIsIkFQkxuxbGLVu51LXQagJH5S8JuvnhZEtlJ1iiVhT0zJr/JLlEZGL4lh/2K550XzOVSm/8QBU5huaDqDjMgfNrqK9J7n7ozKXQOeH9NYvMse+TS3GFts0SocUyKB2nzGk+HP4Qmzz2InzvHeWRCWz4/VoUnWzBJHOrHm2QIrSa3rtF79HJEm9h16DQgnXGYGy48Ixcrp9KekarJVnobrGpWWmdZ37WbAh7r71iPTbVneXDbLMkBRAt4jmQYEvGiLC5EFhPlAUF11UnUe0pL0IH8SoVwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFVXeQv1IV/jdUn+HR3HeU5dfDR4NQhJG5az71+0d6s=;
 b=HLwkKsMSJ+JDxAco76hKIwjULcK60VpaFjDIoCUGW/NwIFaBZayZnmJDCR3uPTvi0Ccud9qenomDkI2Sh0CoZ5PbJF8Ax/zw0AB9DEZtymKr/VBtvsnuBMwW33Capba1R938+o2rvpQzROqw2T30sGZEgjSJQnNEurMlCwpG84ioTqMmKBl6kCuCnb4u2qYbPjT5ujY1MCzzWxz5AbTp+hKDDSQvIOgS1aXjpQq0Su3RNgCGWMG05eqW0c0ZlLzrjdNOdARmD5ZWJBjnXqEpRJcyAXt1pmAPtl9GPyolP3H25gdIvusdwTuW79j0jIdqle2zylER7+sZApr1RCKQhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:40:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:40:36 +0000
Date: Fri, 28 Mar 2025 11:40:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: Re: [PATCH] iommufd: Test attach before detaching pasid
Message-ID: <20250328144035.GB10839@nvidia.com>
References: <20250328133448.22052-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328133448.22052-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: f08e50ea-d705-4312-49d9-08dd6e0680b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qM9SdwZ1LZqw66uc0vyOg3OcQYDPqFa087tGRG7WqB3hEtCRStFKOSOVQyHE?=
 =?us-ascii?Q?pTcAWxkdJ5+bpFykxy3mUJ5DsZx+kAQni1XKn14bjAZgWSnLDN7cbedvJ7Z8?=
 =?us-ascii?Q?cJkyz3bilNfFMLZ5YyfIgI96g0lBsIU2NGlV4nsctmdJAkExQPsVusX7gb/J?=
 =?us-ascii?Q?mMwv5s4SOF6ekUc9lrpyOXHr+fV0M1UL/udgJObZV1ZDx4pdKreFgdKs+r6N?=
 =?us-ascii?Q?77dqzFkIuOkfrzzbAkTmq7AZipwBt92fwJ7BpPOK5Da93CIYSWX8a21zqj0N?=
 =?us-ascii?Q?PiZRFZg+6xhcDBwKN2amsboz7QJnw3yTVTgobwH3q3izK2DEyHgLU/p5t9aH?=
 =?us-ascii?Q?ivUYXvHeZx91LKzuC/Nv1JkDfCdN2IeCCcrc2voZifxqgpfup3/utDf6OdDF?=
 =?us-ascii?Q?pFSeeHdG7YkqskJ/UuYXu2TmwXAKEffzwZzREw1A7aoUy8ta1lALZV0KVTW3?=
 =?us-ascii?Q?ikqgnsUv9ULfQmuKVqRePQYZe8EVysN+OheTZvCHLJ02dTyBqjElei0EJ0Ya?=
 =?us-ascii?Q?4Hqhcut3In6amqXq1wRNLwU3decUlVANUJK9e3zkWIkMDxaZq2pXcBfjjyvD?=
 =?us-ascii?Q?pQtObaxAgzmxUAgGzjll/QaFtx/B/DJI2KWbLBP/vBLnm2MsdMbLI+PeiLIQ?=
 =?us-ascii?Q?aYrrSLjeoQh7rU8u5N3PZCqQUXAGac6R9nrt4opPoM1c0VDSAYbvyBFmMxpr?=
 =?us-ascii?Q?5aF2iq0WmO11RpZCA7mrC29p4PUEz93YR5dGrPoobrOaz3v3NUaI8k+OQpN+?=
 =?us-ascii?Q?6IUvzy9dBv0/3VkSwx7Hu6lX7h11Twq1gklH/ClPAYV/a2oDJOByDNEUVj1N?=
 =?us-ascii?Q?gLuVhQn/4iN91BeR4QgkyLEp/HkJn2ZHwfIR2CTMLb8SaXdlPj1UyiZM3X1M?=
 =?us-ascii?Q?b6VenDiLbdvxjJh/gQ0Ye88JDdyuQyZzFjm3+chPtEZblPnnsh0DTNGfUPJF?=
 =?us-ascii?Q?xHz8fk3RK+fbDtySA1PFns/Et1otW5N5TCLA/D5AMji1HqwJC1f2y/yg7LaA?=
 =?us-ascii?Q?W5SalevtBw34Tl8nI8YJAEIIGr+lJ8U+6dfV/4DxCqIMSNpS5QLMz5Gtpv6q?=
 =?us-ascii?Q?KcSzFFT7uzBFr/C08nOBGGIwLpP2viPkn8dMAaZajem2yVmdbdYDjH0KGWAk?=
 =?us-ascii?Q?YzWRnNq0ZuYNAL7y9527p4zfetqRMvjN/1mKmRAokrjEkfTeg96JmWnE5Cww?=
 =?us-ascii?Q?q/lANAfWKhfXL6wrtIz1hIepGYqzBA8RXCwxA22SmlMLGUvz/EaQoLTzej0D?=
 =?us-ascii?Q?tU/CaRvlxHavOirv8qN5HpU9j45H1UdwcjnVRZOtFaaLyqRnRfJ5C7Eu10zk?=
 =?us-ascii?Q?fZrOdf9npzUbpJA9+l2tnqSr5ADhTlUt+cOGmWHfhVTRjqWO4r4CwPDq2nje?=
 =?us-ascii?Q?4RFeuUSx8x+9y2baI61aGvsk9gBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfgTKaS44n9EObBmO2QdEoLl2scUD+qltBpdVykXXkm59uGsHqEq3j2L8rmR?=
 =?us-ascii?Q?quPMLDwVeTrYLkTnamtwhIiw5C9SeSMiQ5o1vV38JQpaWUAyqULFBJJCdZ/3?=
 =?us-ascii?Q?7HGwd8tp3+mSyIEcu031AnF0O6z5uQf96kX4S9XhW08qOdyZV4m5uVlnC3gz?=
 =?us-ascii?Q?sCB22zDHu/eUwPuUwtGp7k4C9BYiO5N48dUOGmE58jMqHK0576+YamvfzgB/?=
 =?us-ascii?Q?my3IcNwrD8Y4Dn6WEhmxJPxJF10qCouuL/kC5d+oPgNsbYR2Kx/c07FDaHUC?=
 =?us-ascii?Q?mt2OSyK7ZC1cRBanmLM520/W19hMrkPVoyCoKFfCohCGRFNYWv6s0vFnwdnp?=
 =?us-ascii?Q?DvCDrDLJGnQqx4Z+XDa1GzWWSumBJkNOujptlOoIxkhL+Zb9xZGS7TIe/Vgz?=
 =?us-ascii?Q?g7HKtpS0WDCvDA/VbfCQVw4dHG+CUPspkqgwLRrYuN20vgcZjvtVkGf2mhRP?=
 =?us-ascii?Q?6+m21aUtOwh267KYBGFSU4Is/uci5gSkD1/07/a5Yan713nev2C9sQJqbwYg?=
 =?us-ascii?Q?xVDm/Q0U6j2Ai8c+1gwekUauexjymB1IZ1x+uQJIyIu6vv3POW83hDgsarDB?=
 =?us-ascii?Q?TOoERYHN19dxux7OHo2BfvmJEUXR/alo28LTeiYERccxyz4rZoZLoXxI5Skd?=
 =?us-ascii?Q?cH6nwebbw042J19w+ODBsQ/A/TUJ/oLtWzyTf5l0QLhBsG9jdZi0GKa+gIOC?=
 =?us-ascii?Q?/n0BZy7SRc+1Llvnzz6TiJuXb3DyeK+iS34ayaZEbu9LnOD6dO96di+jqUrD?=
 =?us-ascii?Q?hE8H5GFXjYck0joY+DRtB+rvITe5Ygn6qkYatIcQuiEUedcQXoitpKY4ijDp?=
 =?us-ascii?Q?wMId1HwVVR8I68xhje2nniJU1TrKYe2f459EyxLhfKKamJJVmn4zqlJzIE8L?=
 =?us-ascii?Q?pX/6RctbYspfnxzo8rZv6YUEG5Ujav/nRePOpCeFqQjwb6o97Ia5Vgu8ZUsQ?=
 =?us-ascii?Q?i7Bh14G+pa5rMKGJbr/5rnmWEI3n4UbXRztkUqwaE8VAVAcIMeGsVjQ2Eh0B?=
 =?us-ascii?Q?Ml2FSuVDXQIKCSDkfCMlQSH3AzPj2OBD97IsYAtP0nRRjN/uB+y+C8Fi+xpi?=
 =?us-ascii?Q?PEIfteE1W3r6c6vCUljZPQ1wvK+dXIJeMojLKPj5Q8CYfmIYJaoNRcRDFQtU?=
 =?us-ascii?Q?nH3N9kMDo3+nNcRqoDKFOHV0ElVIV3vDBxY3/EWCxLOFfzSsgl/3RhjmvAYB?=
 =?us-ascii?Q?opRWWq+1Z/+BC/ZlFxfFFKiZttdwtNtIpspfSlA6UES21zu6Vq+lbgYDnngq?=
 =?us-ascii?Q?1QwAXwQ8CYaBaVYqAZAFkH3CfN9fXeTrrS/hRHCtuJwaGOd16JPzTZxOkbEv?=
 =?us-ascii?Q?2zuuA6bPJQY8TZwIpVsKRdwmnqGIDjHpwBHfIXPjIRbvVkgHPpcJeTmJApZd?=
 =?us-ascii?Q?uZDqxS+GhggHjmZUJvvKVVtlv3Oe7gT8BPeEkbWmNWxKGnmN91j5ebhZe9Sr?=
 =?us-ascii?Q?kJvR4VOXVNWtj8xJ6wC91T+esyi7evPK+HeHRPasontidSvAV45Pi6Uc1x8g?=
 =?us-ascii?Q?f5V2F7VQClkzfG2h65eTua3ERju/0WJyTTRKC9smi5mDE0JUx5HDeaoXGbLw?=
 =?us-ascii?Q?SUgR7bjmKXy+Asd+oEct40hCT/bk23X1BkV0B+a1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08e50ea-d705-4312-49d9-08dd6e0680b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:40:36.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUkPwW0Vz4e/7hEmYbL81qxANuoUwra3HG7bgMBKJytZs/qQmXK/UbGSWjYoo4y4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227

On Fri, Mar 28, 2025 at 06:34:48AM -0700, Yi Liu wrote:
> Check if the pasid has been attached before going further in the detach
> path. This makes this path more robust. Add a selftest as well.
> 
> Reported-by: Lai Yi <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/linux-iommu/Z+X0tzxhiaupJT7b@ly-workstation/#t
> Fixes: c0e301b2978d ("iommufd/device: Add pasid_attach array to track per-PASID attach")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c          | 7 +++++++
>  tools/testing/selftests/iommu/iommufd.c | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 2307daad65c0..375dd262f431 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -644,6 +644,11 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
>  
>  	mutex_lock(&igroup->lock);
>  	attach = xa_load(&igroup->pasid_attach, pasid);
> +	if (WARN_ON(!attach)) {
> +		mutex_unlock(&igroup->lock);
> +		return NULL;
> +	}

We can't trigger a WARN_ON during the test suite!

#  RUN           iommufd_device_pasid.no_pasid.pasid_attach ...
[   23.723948] iommufd_mock iommufd_mock0: Adding to iommu group 0
[   23.724532] iommufd_mock iommufd_mock1: Adding to iommu group 1
[   23.724722] ------------[ cut here ]------------
[   23.725194] WARNING: CPU: 5 PID: 1169 at drivers/iommu/iommufd/device.c:647 iommufd_hw_pagetable_detach+0x1e7/0x230 [iommufd]
[   23.725350] Modules linked in: iommufd
[   23.725406] CPU: 5 UID: 0 PID: 1169 Comm: iommufd Not tainted 6.14.0-rc2+ #1

Just drop the WARN_ON check right?

I took it like that, please let me know

Jason
