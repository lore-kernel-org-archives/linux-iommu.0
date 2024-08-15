Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3831714A8
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726993; cv=fail; b=ptgIIw7U9KnARUHZ2ipaBmcGnFlltAvV/ZCSV7oXJ5n0fhv0oNGBt888s4H64NIQYnNUt0yR/ILqkKhbNtRi9GbTVfTh0v8xKwymAduHraAPqAtKWznyNcIBw8H5Hi+RiVS16iRrieuqIF3InR6h+dYlVvQRDOQ/DEoshg4sY4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726993; c=relaxed/simple;
	bh=Rmhk2Nnw0rOpRBAy04+sOcvqa6y2SlS/q0Fj7Bc7/kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RTaCy9/TXE88VTkUp/rWEz2BdtZrecVH11BrNDBgxWj7PTxbAxznTZrV7CBkPw1g8BUh9dRBlCQk/+ZZ/4HxQPR8+vfB+X54CACi5ngZhx+P/hGEWVgiLrWcXIC9/j/yp9XPOK/1B3/reImO8Wt0cjXjaZqSxG0Xq6hhtzcEJ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNTFv7mb; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNTFv7mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuyv+oLK+FgXFOWQVBjoFORJpIxDHymv93fgGf3fDEYLglsaAjacXE94N2tQZaFnylmhIwEfy1f5EFOMYOJWDuXLQyKlpZgwDhXgAsqJLtPOkQJTOul4hm1sBisrL1qtugZRnN/Jisj0AWMR5Hb+mNeW0j+Vi7LqOUUijJj2u48UOf6yz2TceNr5z7gqjugGdUD85dHQhiPtMEHyEFN1LU64LrEPUWJDGwWTb02Pstyrgym4IeE+VlBAZZsKdA9XejqcLDQfBjg/uwHKNsMosRhQd3ITIVdITZS04cjG+E3lgjn9+Zrm2I0r0as0JARdIM8cL90PHclHqfO5dNqP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngZNIEz1bKEw4Geh4Kz2TIHr6dhsfUU0+h3voWDshYs=;
 b=SayqMcpYvnZERg1h0Nd8+n13aW/WzliItHpHYy5/EIHK7g5ehKcyGzCjWrQl49RhrnOy2+k7DOcbDC8UEAVCGlbKGVcwllm8lgZTnHHqOBFqnUH1s6ZFRP3AaoxklDxPTbySVNIzpJwxxHfhFTK4hsbcr+B3/LI7y+t5JcvY1/dvGOY4JjT3hjkfKJuAs+kx8TnhbbEvutwdJeWDN3lDhaukBJ3HLbEwdG2OeYZAoyo9cjuoQhpgZqnK2vtkjGq7vbDYDQYQQz0pI9n13YR08VnL5lKh0J8HzCLuADRJ3+ufTqJOYMGYt3CnY+iDsO2O4OhojAVtZlPwJcPVHD2jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngZNIEz1bKEw4Geh4Kz2TIHr6dhsfUU0+h3voWDshYs=;
 b=JNTFv7mb0xKsDhZ+JN+dyRAzGjWPyZpSfDrQKDnX/G6aYZWMWMx6cPgUM2/ZM4giv2S/1dVNvBiu62czgFc7T2uU+TORe7uRzDwkL5HlAa+Pcf7h3FO83culIKsiE/GH+5NqxSQaisPSZRvX+OxcLZLLMiOncvM5tvp+EqumrZEZ9T34GLqptdtwWL/LflzL5lDhCS0G751IF8aTiHyLhvVbqsgq5YiALkxOZUGLX9C2tFFzwrNJsOW7YQzXCI2XX1E0StUyxUsIzjF6lsPJxD1T5UlFXArG2nk41E18jXjrBGwsdcFemxF1GpodFigeHiqKKt5kpXaj2cQ31Yv/hw==
Received: from MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 13:03:08 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 13:03:02 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 13:03:02 +0000
Date: Thu, 15 Aug 2024 10:03:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH v2] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <20240815130300.GG2032816@nvidia.com>
References: <20240815124602.65439-1-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124602.65439-1-praan@google.com>
X-ClientProxiedBy: BL1PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB7763:EE_|MW6PR12MB8760:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a45aad7-bfcf-4e77-67b4-08dcbd2a9817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VLGUuPtMnxpbBJV9eF/cBpWyChYtGPLwYC77j1J3SchFZOzdmFtBDzpyT6NW?=
 =?us-ascii?Q?ElPKfSOVwUsXb06NHL68cCCASYCXfbXD9zR6FTWeWxILWTWv2XqwIpZd2uol?=
 =?us-ascii?Q?g3IFuRAkbBsTzFKtpZlEeyJoBMKlUEERIJI3TyMTgb28QY4KvXYcdf5y2OhR?=
 =?us-ascii?Q?8litlL+cex0Jkjyz/q2Smwl4f48prJFmYGlpdgz5zPst4axwYdzFivBAuKHV?=
 =?us-ascii?Q?MNxtZUnA8grbC7obnvTvxf+IoOdYRjv+E8eUyAytqThYiklNxTJkKW8BErKG?=
 =?us-ascii?Q?bau9ay1McaY9QWrJvnqZJRGztMaO/T6n5H5qKpEaY0FQJD2+eX4q9dsmZf82?=
 =?us-ascii?Q?dwduezrMizvZV55bsZWmIqwznZ38u9zXz6r8bRduiUIS7bwBFKkIpiIdtINi?=
 =?us-ascii?Q?Iv8FY9XVw0e2te+IihF/DRkKzRWThrBn5stxrXO0W8cByzBDHz2aCuThQmJw?=
 =?us-ascii?Q?Jo2sgeB2UUre/kWUmpELVx+ebD9V64JNRc74YvHr8DZ6rYUc3DDh2DVR4i9a?=
 =?us-ascii?Q?NRcj7iPPB07hnNtcP8l7D4j66lhmPF5ZwFaJ6i9tUFJmHFu56/B2y4LY5WX5?=
 =?us-ascii?Q?9uPoc7lOdA8B7FAQKwaF8OVpUf855BYJS7FMQLYMjmButnCfwVXwOJQO4t2a?=
 =?us-ascii?Q?SSlwkUMr3MlcVXxk7gV8K8UT570XujwW1HsXlvqgdM+RTqeIYZmpy2ugrJ0f?=
 =?us-ascii?Q?UnAdEBs5/QB5QaxcG9LHBfqDtgKq7fiiw1u3AQgny31N9wJdkySIRxXmXrRe?=
 =?us-ascii?Q?tV16Lr7TjOoHugzJ9DseAMaCDaMhdC16Ug6EHnsgSJySdtVn8jFnU8LcXuHf?=
 =?us-ascii?Q?AmXO4T6oRfvY9RjOOWf6d46ZxoaygaAJ6SFfjfroU0tAfeOub29tO0Uah2i5?=
 =?us-ascii?Q?XE9zM1p99bAL13az4MbCX/MNE2UZmLooU5xlm6owOf+fwB1VKPIzkL3Jortb?=
 =?us-ascii?Q?6Kq/aMUDndW0ed9sBJr61IYxObhZCajzAb8IXwabd9QjkWX+HIE9m3ckwmv7?=
 =?us-ascii?Q?vm7L4iH7ttP4QCFXLzLDcaTA/FfXlRKzaTu/SFYwSA5iXYQ1oxZbukTK/Mc9?=
 =?us-ascii?Q?saKqjLJqr1V59qjB1BdAdi0c6p6yMdOisflOHnrYg95kxw+7lf2S+SEwlBmk?=
 =?us-ascii?Q?kd1zTN6z5yLY3hPaTgAqDKJdU2Zt6xIqHDaBJkwNC9iwmULKAHuiNhqrf0hB?=
 =?us-ascii?Q?Vg/FOGGgG+bi+NX1MWdu5vs+gOcHAQMSq6p1lqWWLlqUG80a6kmrajQ1ToEi?=
 =?us-ascii?Q?WoROFwe736I13+565Awbynx832kRFyIbln3NiP/mo3T5Au2ZKhQ+K41vq1Rb?=
 =?us-ascii?Q?ha1MNo20DMg1qVMfG9rJicJvE4jET4CIHwak8+bNPn4iqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8760.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+sXz9BsmPLO5vkJ8NU9tnX3Ja3gO6uDbMngGOwe0Oaa42Rh6R5h7VIwFEPG?=
 =?us-ascii?Q?DefiJOXug7HdRkKStZlhkSpowDIuEaWcxNJxhLuW8pm2Tpfvg3nauYdPCN8h?=
 =?us-ascii?Q?+Jp2pctM2xnu44Fp8keVcoOMlYa+erRnhsXvLB0vAWvr7rNe7mAGKpeS0KtB?=
 =?us-ascii?Q?BEPYlfqyMbqdFOmhPHjdTKzSPonFJLNFDygCE2IVI0cSMkqjwSit2tKKv6w7?=
 =?us-ascii?Q?jCX4AjG5vT8QozRx9PEQGqY4rSXAo2H2nDY9oTT+Lr9fn9HfLGxybeUlsz0e?=
 =?us-ascii?Q?Mtdpqr26NbMlUoTkpQHSr2nuvbh+QWFhLiNHXGC9ibReVMo20cnLgK9gPK67?=
 =?us-ascii?Q?z7o1tRlAr+ZiLwAfhTtfrHoJA7I0wt+Dwf8IgLaEvAmdHwdRzTpa+Ey5bpuI?=
 =?us-ascii?Q?WuKRdXDpF5QPLVd+w+w9T2tc6OhBKoW8Oo/nQtaUZ0rKh2Qg4460YUBrnCEG?=
 =?us-ascii?Q?L4Rr/+mkqOqeMOgyVBJ+vaV/u5acDzY83GqynED/jYlsVxWmyL3d1UnExUWw?=
 =?us-ascii?Q?ulT5v2UQO2BApRyouYGk1ifz6cRUBu416XAR2PQ4R7N7ZPe7MmLhHb4hN2Fg?=
 =?us-ascii?Q?8qgM21yHLVcqUjywo+EQ8JTEzCoIDcRV1Zi2yZAfT+rKq0wVyPWltK3mqwo7?=
 =?us-ascii?Q?028RNy517V2WHgmWH7snq5p2srLBQQ+zMQVOOAPnwNJV+DlTDHNy1FePZrc0?=
 =?us-ascii?Q?QDnAFJjiTNMit6XnLUWe0PsEiJjvb3dO9ZsebYMpSqll/u+EtVm/WJrSyxAU?=
 =?us-ascii?Q?kmAgnFkOlYpt3Zfuk9/B/HGB9mf/06txxRHZK77LThaQV1EGRlvRBwOhY+DK?=
 =?us-ascii?Q?rrVbk99Udcu/QV5TVwPT5zBNR8FNW41hsvOBU+lcKBMvX5VerGo73Va0QQSF?=
 =?us-ascii?Q?iWTMtGBT0YqZ/oQmOsoSlNxjFknmbVBY+b4W6SpAp2GGEXTZM3Z2wsFv2f6s?=
 =?us-ascii?Q?jsxsO3jiLypaP+5u1FBqpAJtzbiQBr08IWn3E3hvDvv5ewpg2H7n8+Tfnhhx?=
 =?us-ascii?Q?dCZUpB16TVx8Htp1JZ1vGhgGEbbpdAubWZhReJCCzTFwoIQuOo5tHt+daOig?=
 =?us-ascii?Q?yzxp3/0AzS49+x5yB2wMJQF370fcXA2581GtQ/64T7Oivn0e3ENtowwRlQxj?=
 =?us-ascii?Q?9Hmn4jqraIyNrKXwNgKrYUQNQgYKtn8g3vgLQ7EGC7pS4M8kW4Fdiu3enIZ9?=
 =?us-ascii?Q?Qk5eJrdXT/1uaTWFoOZy61Z4/fgQSBpDgNkKPCTfhR3R0pHBf3gxsEQirt0m?=
 =?us-ascii?Q?Me+UDc/1vI6As2fOv16ywu4FRq9v8L8VGdR6tqowUcO/UHHw538HiTrMRUg0?=
 =?us-ascii?Q?8hbPbj5JGV1U0IEGZXS2Gcr+tIt2xsnLnKa8FVLxNVCR1MPDFyBEXB5pL4G3?=
 =?us-ascii?Q?b3eW2qpJsRADjwK5JOaWRltW92Max8S+onwbmZ32AkX44YaBqAh7WfFeBjVB?=
 =?us-ascii?Q?Fci04lmSxkwZU2Lbk1BKFIp5t/rLZitLtWR9W95XaMf5a9MnEgrMlbla5LyN?=
 =?us-ascii?Q?PJDaefL29/IyDJIuBs28465NCy16wceIlgnleUAiGV7odU1lc5sju9UEkjJV?=
 =?us-ascii?Q?WvlP+izifohlDqETS2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a45aad7-bfcf-4e77-67b4-08dcbd2a9817
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 13:03:01.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQELbMJe656ack5YryCpnlB1SgshXQI0CzRzcmhOP7TB8OITlcsfBCL5kx7r85vX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

On Thu, Aug 15, 2024 at 12:46:02PM +0000, Pranjal Shrivastava wrote:
> The iommu_report_device_fault function was updated to return void while
> assuming that drivers only need to call iommu_report_device_fault() for
> reporting an iopf. This implementation causes following problems:
> 
> 1. The drivers rely on the core code to call it's page_reponse,
>    however, when a fault is received and no fault capable domain is
>    attached / iopf_param is NULL, the ops->page_response is NOT called
>    causing the device to stall in case the fault type was PAGE_REQ.
> 
> 2. The arm_smmu_v3 driver relies on the returned value to log errors
>    returning void from iommu_report_device_fault causes these events to
>    be missed while logging.
> 
> Modify the iommu_report_device_fault function to return -EINVAL for
> cases where no fault capable domain is attached or iopf_param was NULL
> and calls back to the driver (ops->page_response) in case the fault type
> was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> to log the fault/event as needed.
> 
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Closes: https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Pedantically these two Signed-off's should be swapped (I wouldn't
resend for that)

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
>  drivers/iommu/io-pgfault.c                  | 121 ++++++++++++++------
>  include/linux/iommu.h                       |   5 +-
>  3 files changed, 87 insertions(+), 41 deletions(-)

Looks OK to me

Joerg, this would beed to be for-rc

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
