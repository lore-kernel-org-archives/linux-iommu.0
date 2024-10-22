Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFC1537D9
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603806; cv=fail; b=FE6jYKxhTmjc+y478Wvd2GfOEq+/R3Fv5QN20UjcI+zz5JG5FbGpzUnpjbDMqGLge5CqsaH5ycrBgnP4ExCykG7GQ4COtw067japLWuDuLyu0bGnxdNYAgw6tFJvsZZExi/OzwKrv83PwIciDvAOAcmS+5HbTK47wWqEEDLCJso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603806; c=relaxed/simple;
	bh=Al2Ex8crbLP/SoblsCZx4wTXb6rveG3e+HJMC45IH9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkxqeQSW07KjcVl/FVmLphwMNxyULNvRP2c4vgCKan3eDATQAoUM1c/vJn69nTpqYYvpOcDSoOKZi7Hexci+jeHbyI7/py/CMKDU2bkd8y1Suu9MeDY0tL/qBZHNyKh0AEz2LdcaQyBTaKTA3+oMM/UZkTDQsdihj1HGE0XF0jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZcJWcoJD; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZcJWcoJD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/1WKbcJ4M5+Y49pnn9jpaDZX3/+xQ+EXk2jCdr1HY6K13MV7XIbvWeRw7WMlan4jxblArAlHS1rvbuP/ngGZ18YVk3uMVQSDUKw91AELdqI8gmmki/3D0F9Gq1yyNFX9onKL4pF6mg9qVqx+6H+1RnQ4S7lQb60a/rTqpGuc5rXlN2xNHOEJYsbXmRiELNUTQhlkfIBHkabIdGR60imHODnvFmRc1t/+oa27zlrwVFfzT5a+c/Ki/9WTQa00hBMWxBjXR3r1oJyISdipUbrU93PjHaVq95So5SijyYUAXdNKGS/+MkAZB4GR2KLhcdUdmjbv3v1fi7yv3AhSGyaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlC9vBxR5/ZEjRCnAsh2Rt3zjPD67HdZzCkYZ00CmHM=;
 b=ASFyqrAi6kZZzwHUsFrfv9wS8U0rZN2ckQHcpUnUJAhloG3l2k3AMT1T7E4G2NJhM3/EoE3/Tbq8hx4zYxVHnEFFOqPkdKL/ONmUi5KJgDXFOzItP7hTdWk5YmlWvTbv9Sg5Q71WUqW0fYv0pxJ/AYJpHvQekBdEHupcmChCCncnfBZ1Mjs1Kvg53+wdkpqmUt7DqPoBL+r1GBP8mklHfEcvzMOyykXAoYKbz8+4aOA6W/1SBQEFTw55sCCtmbQYb6RqrvcCQ9JbJuhcT29NHRzjXBXD+ZsAfgTUm6DCDQVC6eUK1OXQZ+QXB8U/WmAWEOUW2c+xYfR0WMHxNK9Y4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlC9vBxR5/ZEjRCnAsh2Rt3zjPD67HdZzCkYZ00CmHM=;
 b=ZcJWcoJDn1bMDBckpr0ZpFuSGTav6Ku2BN28X3CRg3w7iHDeAoix+6CAejn876ztYVQddcqVO7BtKR4J5WmkCVMsfFxHDz0OfbbkiXAkXaRtBwVeHty4tTWX7F8Fudo+f1Nrnfaps/0Unq160VupIToxn6wswEagbCrkxlplv+ZqwTHQPx8Hu/fj/GHd32r6FUNXsJLoIXGobSMQ49i0VZqjzwLgVmetPoEgpQXGIa09qCa3akdC9rK3UCUHbnVV+1cRTnAtB3cSCmuhh9KL864kocOgc6rvIa2t8FQuAikiSK/olEtxMfLysACSWKXMB+eP/6gdcBXFkI99kNyiRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:30:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:30:00 +0000
Date: Tue, 22 Oct 2024 10:29:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	mochs@nvidia.com
Subject: Re: [PATCH] iommu/tegra241-cmdqv: Staticize cmdqv_debugfs_dir
Message-ID: <20241022132958.GA864191@nvidia.com>
References: <20241021230847.811218-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230847.811218-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:e1::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 509cce0a-0d0c-48d9-5b0b-08dcf29da096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uX5iSDUoU9Bwx7SPfBfGl4SHY67G9TuMTqXv+iDdQip4FY9po3TXDxV+LUAJ?=
 =?us-ascii?Q?5CEFGyyq2MNDVMvcF8R2ewl+Sy0JzFx3LN+/f0As5Hf2JcfpyGtv/hJiWNtG?=
 =?us-ascii?Q?8dUQqzREunYSyJB5J1qzLZ5X+K4zZkFFYzm5egDHFxHK6KhUEJJ4Y3vWmw1R?=
 =?us-ascii?Q?3Z31Mpfl/7oDGXWCVmwhKh/KZj+BJy4xpdkimn+u4n4pPwmpmOOOA9f7donE?=
 =?us-ascii?Q?GUwoCbprb6cpBcn2rvP+tZzcCrQyqLqGrd08bxGXDinyQ8OOcpgarqhGlfNK?=
 =?us-ascii?Q?JvHZ2Bp5BgN9SHfWjr6HEU/j5Kp0IIVDYU+NQ7vpZYYWFCmoFm3d6bHmb2eI?=
 =?us-ascii?Q?Auve/D1W97m8jMGsSzzVCGz1qTyN3HwCm0oXNUp3MCoaOsvQQ76CTmYKOCT3?=
 =?us-ascii?Q?2R8SzQybrkdgHrKu8ByhrbfWT+JI/+m6nhKso3HQ1lcuxtecS2m9QktARgho?=
 =?us-ascii?Q?zmuubVqNBMGjCZg46spPOdkgFZI7WuZmrO8FsUiIpxwA96E336KOKhMvbX10?=
 =?us-ascii?Q?ZFHPUfXkFDkDChtYxcjqQDtGvuznqZbt3QhCtAovJn3CzFaIB+xDmG91H7cz?=
 =?us-ascii?Q?FV+rIJQYsTuiVRCphk9CNG50cSkKqAaHwEbNu4SOJv54poEyeS6ngAcomF+E?=
 =?us-ascii?Q?Pm0Qo9BqI4Ul7z+qW6XYracNnYjrmPIKW7rTBXbg3QEe2iuOQBQawLjxF1q7?=
 =?us-ascii?Q?iGlVu3HtU8PKDcp8/UEv7h0tzVZBn9i50VppBV3t/vlm9S6fu1agxHrJ9Ux4?=
 =?us-ascii?Q?Acx/soaLW0Mvdt2YJaj6vyPVO3+Z4k///ER/FNLW/enJS2vjF1qU429J+DP5?=
 =?us-ascii?Q?pKXWjuFx7YF1FQpIh2w0QQvSI8yxCp+RhevloIfbwkcqfaJ9NmXAT7IQl5PU?=
 =?us-ascii?Q?b+06U0cfLOKK2/T0o70nZhpMc+r1OoxgQSo3BnjE0yUxQpxAke1F86eGMpa+?=
 =?us-ascii?Q?ifWPBYrTa9o/3uVQp+ZfyC9Y//xTGl9zCpiElGe98D5sZK7p6fSswEjoqK2t?=
 =?us-ascii?Q?6AAeyAlrc0pl4Mftt6ftdH76ACsR1k92+1k/CfPXtK6SI7f8gAlB4tD4ld59?=
 =?us-ascii?Q?WW0+jL6gH96jwO3hSwaAgE/nigWuwNZGE4A/qF9UiXA53Aok+4bTmGlbhUbP?=
 =?us-ascii?Q?1IbvA4IQ91SpgxC542uR1h6eGvlSBR+aQ2KF9vC/7DTnW2PmhUA3YrnOXm7k?=
 =?us-ascii?Q?nfYnfsHK8lZdRE6vt7mC1BI7/w0y4fJvOk1MSQIxbCrpKx2u8RwZ65r3mDFi?=
 =?us-ascii?Q?oUx2I+H6iuMIe8G8MknRN6kg6OTltaL5pOJfvPW3WQn40O6bjxvR87y0Sr5c?=
 =?us-ascii?Q?H9ueQt6xy0a0w00dyCzzIhqH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kzdv6721K1Eodl9G64p16WBnmmX6l4A4+1LbaIAKEw9jdmhXm61Ke7beYg7A?=
 =?us-ascii?Q?XclrS9yT8oyE6FcCBbEt9G1pw6BSARJlDGR+EVasXBhkLUOMGMzj9dlAMlx+?=
 =?us-ascii?Q?xXm+pgcQV+G0Y0ylKW9dLH83Lut7hluQmYGKu/1rOxPi8bF95s2Ig18tTTZG?=
 =?us-ascii?Q?3k0cyTOv9V5v+2x6+aYD0GzQoqlibLbGomaPXvvzp7qak7EJxfV3vPG8wgoM?=
 =?us-ascii?Q?avQC0SmGBI8x6g1DiHRj+PlTN4hj+H9j9Qx0xTS9jRDT/btuHbC+4NzExQYX?=
 =?us-ascii?Q?nEn2wnxHSE0BJpb6P/iEwjlGC7vRGCnjwVodokpYjNvJW/ktHi7pdzWQatt5?=
 =?us-ascii?Q?GsQZTOBYi6lC9NBysRwAhk/P+D65Tj7NP3sYmi+rM1p3CSh625Rn0I6j7VX0?=
 =?us-ascii?Q?bU2SWzPs9XUjMxyZKacVbFUOZz3jDiD6SmOru7VJVc4XDbtjMiqbOoipCsfB?=
 =?us-ascii?Q?Wr+ZP6Anmz4fAyBHJLEldwA8CC/vfXhIiB0YTUwNhQ6KwaOTHl93wRqQxd32?=
 =?us-ascii?Q?PSOd74A0B0YYjuM8d7EBQBJnpqvXtAZ8PoiC1XAlhra8j8ltZwSafGcK8FLU?=
 =?us-ascii?Q?SYhlpu4nH2cx8UNbeDl/8NVbQ8CpSeqNAjaIYBR+fgx35OC7EkLf6kc15EUJ?=
 =?us-ascii?Q?elkge8E1yAqzy6cHbe1jrybJS+73VqYeCKvNzM2bVH3fz6wuVhxZRetexhSe?=
 =?us-ascii?Q?hjuohgnpI9j06CWtfZz/OjOKaSTlZOcMPhXShabJBbX8zNHqxJF23fUfOvtw?=
 =?us-ascii?Q?w/ZJxvU81tz7KkQJb0B84dXVP+F5RoRJuP915Vc6LnduCxw9dO9FfnjrbcoE?=
 =?us-ascii?Q?GNSh+FpSJhNfvYs3Oytrc7nVeWNEbLckg03Yqa1CPu9xJ9H4AQYTDrYp2Xod?=
 =?us-ascii?Q?CyuWz7QiuLK2P9dnDRYIfmLQwu7WDtXIuWmS5dxFuat7UshwxNavPX81CvK3?=
 =?us-ascii?Q?v2SQ76ovh1tM4x1peSXqUP9Tqlpujb9F7TAO+uvcGDa+SVo6vUCHpamtR3Th?=
 =?us-ascii?Q?LpJtUfDtB05ZY3f2P3xxT2bo5HJrLAZ2tJv965veSwYF61IJHnv/wVmsyb6N?=
 =?us-ascii?Q?FIRLGA7RPtZKvdzmuLBHcllDvLQeTihpYmlHjug+DmuJMjouh0JDgRxbaY5S?=
 =?us-ascii?Q?hhjaAQSPsKTIFBFsWxPagmNg2LHcInsSnwfm/J7/C/EEFnp6odSNiJEJ45Hc?=
 =?us-ascii?Q?dvWEYTgxbqN8YKUSKk/c+ATr+K2kadg6VJIv0HamYoMbEkeVnWgqU+diWTOW?=
 =?us-ascii?Q?YZ2EMsdfHHtO8ulK1ZHsNFXUMeaKgU87amRB/dLzecKUKMZQqNv7ZmhIl/Ks?=
 =?us-ascii?Q?JvJvB6h+9e3tFF4YOYw/hUY+4l5J3i9p1yiA2OrpjHSdT8ITjwZYeVfhHBjm?=
 =?us-ascii?Q?JGd3KqgETrGcoDOt0hPefdxce89NB1QOEjFzcB2x7Wk61G5jEvX4n7s+niLz?=
 =?us-ascii?Q?FabmxhwsRM6wxL5KIjz4dRTjnZ9gZ5hKAYERQmDF+ep9tXWgh7gOAYfy5TID?=
 =?us-ascii?Q?bGjGrcR0hpBXJfrQUi6m4tt5Bp+CkFmPmJm8IZXDDKGIVipMdDyXv5skdxyL?=
 =?us-ascii?Q?6CpcdKS+j9z84s8n16ZIMuyJRvy05mBggMuaSPSb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509cce0a-0d0c-48d9-5b0b-08dcf29da096
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:29:59.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxoQeJcF/M1PXKxQi+DfezRtQOvIHKFYHfLfMEpExR78T95fi+Fkgh6ulmvm+uw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

On Mon, Oct 21, 2024 at 04:08:46PM -0700, Nicolin Chen wrote:
> Fix a sparse warning.
> 
> Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410172003.bRQEReTc-lkp@intel.com/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
