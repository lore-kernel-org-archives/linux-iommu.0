Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815F19D892
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378431; cv=fail; b=Hr0CcKMPB4WfKiX25Pux3utagk/2ce7K1beikxAifnAkt9Vn1CIRTwhEw+go4iPvkWxhQh09nB6GLJ5sybuRrK0ocxPdJfQhBkGe+X1Q++CrDQnNVg4P11sMqhLshrX6B+xIRM+9xsnr2d+mMzPPRGaL8p7BQQdosjdZOrh46i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378431; c=relaxed/simple;
	bh=PoMChbTybJLaP/SQ38R7oOpcfGwLYrjB73loLo9uDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0cw70jNvYjZTrsHM94XJDstpECgW3Mdzv1I8G3urfRQvBc1ni05ol7BmC9Hvjra1gfCzKb4V7rR4KMuTDaOGk3+Ik94G0ZlarSqsaFpGnO7qVbokQD5NOcIAC4R4Ot4UBAFJfN6hMdyx7OOA6kzVxfYoBYWmPG54k9PcfxnO5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/hHCvY9; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/hHCvY9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my5KIwEhmdVwZAS+pGMsNJhvD6h/KeMoinSBJxBUKiHe6sRaqiTagYWXsEF+1/U8JSEFVM/FB7jfhkuUHvvrCTVwvxSjtA/8lTkD37aaR7ju30/AG9fvsZQ31YzdMoxwyjWCkSb8xJjY+L3APDuFckmP4pch2w6drSpSfDN39VPEfp96dyZFZtVZTurV5zShhRJy/bptH56BXteJujinQdm3Ou2ul+l01tZLRaGA3mCwqc8jM0/6DeIDcVK3iC9ZmtlkFkTOYwtJfYwsaRkTGEy3ceGNpDQo/SjaEhfg2XGWwGrO2H3k7kv4rkR08M/6t82B1ml8BptSKzxl0rT56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgtpFH/+ixAJIPoq/+vYan8Hr6cJ/2L7GHF9jJC5jW8=;
 b=jlcqR2EBH5xhoTT9GtkdeiHBdzf+jxQHFRaqoBYI3qdl/olO6haSl8BS1bbOmtlDpz5iOwQAW4vR+EE66jIUUdFt++ohQDdE7+JyYghDUCSzZdqdvufB4ZingOFxS8DtyZ/3T+DD3er9UaGnEiWjqoMgOP/3c+7MuBgEeXTK3zPmoBNnXOcl22FrA9hqSYHzvZlhcF6hbI2bN9JjQKkEueVmpGSi61Z4cTFygIbFjtlsgsTKfgiAgkPEX4MfYyN4WQEQVTQaeOAPQLFvssAPjNyC3hkBzN0WCZNsVpfdhiG0NXLi5jy/7x8wTeJUUF1h59KjU9EEW3S3N6SWm03ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgtpFH/+ixAJIPoq/+vYan8Hr6cJ/2L7GHF9jJC5jW8=;
 b=p/hHCvY9FEeyXk6NeYDCLPU92Bulo27WroO4JT7TtZcVqp5MQHQkZu8S8C5u7NxllBBnFg5dMTng2NRWgMwoNEjeOWPZmVXQErUnZN9k8ojpEI1C2TYvCOCp2LVX0is43r1dFR4DOaPhYUA3sygMxluYiiznVLvBF1Pj+gpMZ2/xxfFIwwckIZstsYoGVU+MiEaObznTdZgqTUKW+4uLPWvDWHVRNF3OV7YXlYZQPbS5JKhj24+jsVmcQWAfY2nJU+JYIvIyNGjjr6nEiU8rRAqDrFH6ApD0TPa4nLF8TxXidYT8/oMhHd33w4cHjoU6M9aQh1zL0yV8qukrQZVDng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 12:40:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 12:40:26 +0000
Date: Thu, 31 Oct 2024 09:40:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v7 04/10] iommu/amd: Introduce struct ivhd_dte_flags to
 store persistent DTE flags
Message-ID: <20241031124024.GE10193@nvidia.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
 <20241031091624.4895-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031091624.4895-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:408:f7::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 808323f1-837e-478b-14cf-08dcf9a931bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vb0xROwMeV5xADjq7dOOwXMX/mghjRgv1dN6uIjzPzK3TZpBD4+3/AEaCsit?=
 =?us-ascii?Q?oY/Z9XLtpp7oragmEjMPfB31rOVQNb4OtaxVoIYWvJGwPjA/kG4jLoKEOmko?=
 =?us-ascii?Q?1vqmBlp9nE5T///uHeI5JTbYQra3d/lJffiLYoPXhKbDQCQeSFkrVjkgMvGK?=
 =?us-ascii?Q?b2QYhl5FVM1uPFcFfsPaxaCq5YZWW8pgBdsCT0kfO2aFnQCMMnq/R8rkW7kF?=
 =?us-ascii?Q?9RpFNY4Wk+Xz75znB1s7ptKLgSdAaoGbu8asmky79dTHC9orvOSsqFX3UD07?=
 =?us-ascii?Q?hUzoW8i1/vK0AdCFY1DHTENp0pfCog8HuNR3XUo9KA0A9tqbVkH7p6nj47Ht?=
 =?us-ascii?Q?xVOUFIUIBEnKKPfKBJGYtV2Hq6CkwFow3plGDG/V0jC9Fx7o+9O09EinxPsV?=
 =?us-ascii?Q?SVew9fBF3jNIgnkI8dMPsAPrgded8aNnlkWqgSlAcjhTm3k6sixDdXyQGOTN?=
 =?us-ascii?Q?+4+mOih0qPkKDHoVPmtMkJJThZ89Qju9mu3oLzXZF7U8zhw2OLzJos0xBbu0?=
 =?us-ascii?Q?AusUJup9TI7d5NO+2MkPASW41L5J8AkQlxaR9+5nDK1ALQhBpn0jlEVbvf9C?=
 =?us-ascii?Q?NOq5cMowLohBKmR5YgU+dQLjLgq1bZuZgH8Bca5vtiv5s3db/DD5Sc70c9kf?=
 =?us-ascii?Q?uys+B7fcmkLsj9bZ/nLedI8Yy4PcrcKMpzIy+3s5ai8M/NL6lDyQJej2kH2v?=
 =?us-ascii?Q?l3aHqMpfIRmiHVkqQtlTUmVgIBai9NBaLO0prHsEF7ieR5R2KSYHfzQ4XckM?=
 =?us-ascii?Q?HsAQGGL+O8xNpQ7FaUKaWRVK01bn2CFPNXw8ppxm31RJbxfxIb1xcBq/OY/A?=
 =?us-ascii?Q?nBx6zQUmmyFLvSvDQaT28mNHz44KlEz+oQ7UFQBsrNDe275uQsaZSpMgxkax?=
 =?us-ascii?Q?a8kS9Sr6IcmfRzGZod0ChScH5Kxr09ppRwVSVGU3RZQ7GHTRa/ZeQEIYd0Cb?=
 =?us-ascii?Q?0g+a/REQl2QHH9n+5qsbRnoyrXFMkl08MtVWYMQl8JjX+UIVmBhxpWrXl7ym?=
 =?us-ascii?Q?mRTQ/LP2nhcL6eum/FBVZaPd8K+KBE8tOr8nMcw4yFGkNOxRGRQ1c1EtaA1V?=
 =?us-ascii?Q?D5yYz1ZkZpPg5x2YXKTXYbNrZ5aOoD+v6qBRGIziyKZKZjO0rSfdtQRFEGKJ?=
 =?us-ascii?Q?PPYxADj1rDhH5oMZPjiXUkcwwBXcZivwLv2gQbW2Rp9zrXnSBjAnZhc2tUe/?=
 =?us-ascii?Q?uRuvKHnhI2hzFSjJ/qsze/3c83v7aNZmqUBveGfBWR4R8Gm9ZeY1I7foZ52M?=
 =?us-ascii?Q?g8rIymmbHqDrR2vfslp2c04i7pbgb7TFTql37P2h1fukwuy7tRs/D/+RS0lB?=
 =?us-ascii?Q?/+7lS3sqMEbieUP2+uMxPtle?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOF9DDK7UbxuE4P9NH6cOPy8K5+QHl2NPkRUeNapvVxuNAQVMNp20Ci1y0Dr?=
 =?us-ascii?Q?bbusIhx+LzZCbMTq/SfMWufDLfC844Jtr+P96cun5N90Z8S+P7Ju1bCQL7oy?=
 =?us-ascii?Q?0R9h49kgmdrusEt1IT5gcHbHeZ9kBEjerDTqP+t8+PfMjyI497Hpe3nxYDPh?=
 =?us-ascii?Q?TFnDxa00E03M30ec+PyplrVluX2KV/I4Cot7+MBaYmLqaQDjjKLPr8ZMz/Le?=
 =?us-ascii?Q?3RvUVYkZcKcd82SfclCF3SE6/olUJrQKERLWKkDluP8fLcp2mthKKVW996PB?=
 =?us-ascii?Q?2aA2CHz4XFKFn+FKsb0pJXLbLgwvHdqqXNVdnV3GNW3izdSWU/9lQsY+OZfc?=
 =?us-ascii?Q?AGRq+wwyh4rJ6M5ThslK2sWqbySskIqEWbXxSm3Vr07Z7OesmpFu6sqEZXc1?=
 =?us-ascii?Q?kkZAqce7cehp/kKCdFCivPGFQalmCgsP1URoMJ5mjPu6WNsLbAieqYr+64qw?=
 =?us-ascii?Q?cuLhBbj7zg3qfA5M2YQDw0Q080wO0J6EofN/mjF5PsecQWVV88gPowSZrBpP?=
 =?us-ascii?Q?PJnEv5AEmMLU1F2g23+7v8IVGGHLuWgWjMaPgXEo8VKZ9TmuysaTvICwj8QL?=
 =?us-ascii?Q?xBy/sFwUoHuvMS3yOuqAC53496coIN+UdjQ8ykjpUozXunHb5a9snYafufq6?=
 =?us-ascii?Q?DMN7wy8a6mA6zr2VLLkYV0Z3bujARooBjZyZtptE1Jx8amV2cDuEWswgvldy?=
 =?us-ascii?Q?GpItiO3aoiKYhnN4SfT3+ClIyK0XXLBDskW2xEjxquOjC+GEwqZYLi3sfTsh?=
 =?us-ascii?Q?Uz7gi9ZGAGqLetYI2Qv3WI4OvHF0k+TeqJNefUkXgYOsZc1qn1WlWD6kpDwA?=
 =?us-ascii?Q?C0dr+4GAoJiWK4oavgu5aU6nn+GNoi2yqENBGthl+rgk6sgKUsge15saL7jc?=
 =?us-ascii?Q?39w/Omp+WBS3JzGxd2VfJItcn9S1vlMxQaRXGDXM/nIR70yRw9flS+X/gnB5?=
 =?us-ascii?Q?M1HK+hU15Tbx8PF08jWd+nZgeEKihoRHIiWV2EH/p7yXLaoKrhw3kS4PjrT4?=
 =?us-ascii?Q?sVrKichcY8zl9v8tYz9xFj9B7NeW/mqHBygzHtsfDrS1+CC6OL6odFlmtfj/?=
 =?us-ascii?Q?AtOKBM6TMLtBnRJqdzWm8mX96QT78ou8Uaw+jPszRJcNL6cXM3o1qeTM9Uux?=
 =?us-ascii?Q?rm58g7hbS4f/O4b9vCXTbXLby3gC8JGZPdwndaHBeCeYhG7r25aNWyAeJeWB?=
 =?us-ascii?Q?pt4Awln8PZlTC9rFtZ9FdQBwH/aM4MhzVMUY/V5MdneaBnLgMQY88PFXUVk0?=
 =?us-ascii?Q?0QwHWNwZ55wv4tyZ8fVnzCB7A5BtAb4sQjiwktfC10E7c/q5u9VCDjYsKt9x?=
 =?us-ascii?Q?FX01PLsV/YdZnaut26Nv+zJ2AcT3YhW7e8hQ5g8zmhsg2adJhYqLWUVAjANb?=
 =?us-ascii?Q?QCfi1hI1FUVtKu9FjrryM6wECOEUDyjkuXGTSpWSjqrPyymPMf6b8LO5UWyE?=
 =?us-ascii?Q?yyIUToTLnT61Fb3SLXVKhwkNKl6TxuxiKaE9A6T5LvgoxALZfPrka1OUmrnn?=
 =?us-ascii?Q?4w8jwcdiUaCFBXx7wXgti/yJ+T7bqq8Lm2LERTLKl9cTJ3hK/R6kQDEEYyNL?=
 =?us-ascii?Q?zRcCamiyNSZC+U8TDdE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808323f1-837e-478b-14cf-08dcf9a931bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:40:26.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+0F3O+hPdmMQWKm4MLDaCYuO6jX6JS+Uhx7zyEjk7v2RDtO9IMp2SLtuGieWrlk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

On Thu, Oct 31, 2024 at 09:16:18AM +0000, Suravee Suthikulpanit wrote:
> During early initialization, the driver parses IVRS IVHD block to get list
> of downstream devices along with their DTE flags (i.e INITPass, EIntPass,
> NMIPass, SysMgt, Lint0Pass, Lint1Pass). This information is currently
> store in the device DTE, and needs to be preserved when clearing
> and configuring each DTE, which makes it difficult to manage.
> 
> Introduce struct ivhd_dte_flags to store IVHD DTE settings for a device or
> range of devices, which are stored in the amd_ivhd_dev_flags_list during
> initial IVHD parsing.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  15 ++++
>  drivers/iommu/amd/init.c            | 110 ++++++++++++++++++++--------
>  2 files changed, 96 insertions(+), 29 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

>  /* sets a specific bit in the device table entry. */
> +static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
> +{
> +	int i = (bit >> 6) & 0x03;
> +	int _bit = bit & 0x3f;
> +
> +	dte->data[i] |= (1UL << _bit);
> +}

It would be nice to see the remaining DEV_ENTRY constants harmonized
with the DTE_ constants so there aren't two schemes for working with
the struct dev_table_entry, but that is an idea for some other series

Jason
