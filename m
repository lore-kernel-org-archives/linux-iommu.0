Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C142F693D;
	Mon, 20 Oct 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962354; cv=fail; b=AK53w43pB70aUyb6DQq9K5Zd8WCRtGWW5ZzH7FEqufgY6qX5AVTGnvZD6QigaIJwhvNnKlgXuYTpl8WF+ofj6D9MKwyvLWL/2GoMF9CLIHaE/mzL8xeAQmVp3roFJYEuI4MkQeBftHm6wI0QVJivKRPkcIC0sva5KUQwyvyKYlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962354; c=relaxed/simple;
	bh=NoTbEgiLHtqTcH7s0/DXzpHFKRpQB7euV8ovOzdheUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I2SoggvzLjAtYsL59GM1cz504GGVlEZXxtDb5N8m8Q+3O2rijrVhZ/+cZLSlwStDxCWAF5tLPvrCJS23v9brPAiaIo5WMtWkq88o+qBnd3Jc+kC1Nt7ThyQYFGAlfQnjjnwbTPV2XQnEbpTvmnZL2FBi+7OkScsHxu1rE+UOg00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snpfilPQ; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snpfilPQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks/csCaaZh7pyHqmtPwmTS030cl93VQqoo7q7qy/zVLNWIUKZCSo4zjd0oIX1y3SAPQBLbHiMnj7oMsbDFymoXhkShiZdC3tW+EAZnT6I0+EVGRLqrWHfWbXwaJ2JY0vfX3d5Wm1CZ9j34KzCrfxelmXJ9HUbGpqtX4H3UceYAlIlOqwhPkG2J1HhV9P5cCYbSa5u2FCs2tisnl/USRwffgYJuDc5EbtF+qGJ6nluZ+3G2wcFDTxjYNQAl9wD2/GQA0o/YSqqmp4lsbGEbX+Sth9mnR3hx7e90LdPl51pxHYNdK0hGBkLi1TLARWcCODYh9nPj6RpS+lVpCgNGREoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bxjB334lq2cwp/dJxagqzzbGZudoVRk26pRjV3j57k=;
 b=CNHGIrA0QVMeGx7x0NV5olHQ0eGG3J4NXao2J0Cn1fr/DPUfzrcDXtMAt4MC2LbQQIPvRhsVVqO08hK60u0m/w+rRYTrs67LBuADj9+SPQ0B7R0CInlN++dtGE5oV1aDB38bQ1hka6jKzR5JnRICmkt+qzXNbBOV11nQfDTfDoB2N4ToFfAQAWlzDr08lDKiEbU53bgFEwUXmsNTfpxWz/RAYXM12Bk/DJNR21tEwp32OHiWQP621yDEsIIj2v3iRpnkkAGaMPmnqB75D4nuB52tiez4wJeJUfuOwGC0dIod+hV8uNDiq0hqhb2/bzk4XuN9jv9UTXQXEd7wlRj8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bxjB334lq2cwp/dJxagqzzbGZudoVRk26pRjV3j57k=;
 b=snpfilPQQTlhHlZ7hFVkJKYEz+WT4eeXpH5w+9NcgceNTGeA8n8wRe8G/W+r/mNHO49ZnjlmDJrJwRjUUr/eOFuBFDsZJ8MjccacLXTLKI9yT/iIoqDq3lhOWA/WZn5FNAF0wBAK8P2Y2D4ZsVq6wEUdeXcUxiQEiTNTlg7yxpV7UNjD33r/05AC0I/83x4qLhJ9ykP/srKytLyQO27hOkyIugaEpVLn6Im8jaag2u9juTtbgquuoF2FqrFDpayHrlRTBSvc6cvx/IW6dvMeF0FkkV094CO7GKn11RIdvUPT+wzWziuoOoIi42Z6JQdK1x+OEb5BV6mx4ItMte9RfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:12:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:12:27 +0000
Date: Mon, 20 Oct 2025 09:12:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kernel test robot <lkp@intel.com>, will@kernel.org,
	oe-kbuild-all@lists.linux.dev, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251020121225.GK316284@nvidia.com>
References: <14d76eebae359825442a96c0ffa13687de792063.1760555863.git.nicolinc@nvidia.com>
 <202510172340.XyneWIPI-lkp@intel.com>
 <aPKxBh14fxnVIXK+@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKxBh14fxnVIXK+@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0478.namprd03.prod.outlook.com
 (2603:10b6:408:139::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dfd62a-3d28-4f62-350f-08de0fd1ef3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MagpK7QC+4Jm0qof2cPDSJWP/Hyv4A16rpiCJR7prSwzQxC4U4wOI7ATi36K?=
 =?us-ascii?Q?9f6iWXKqqbi2+mY6uMVlY7Qc3AxikTwbmPzmlnSonzaKbuikmoi5BhQtQI0l?=
 =?us-ascii?Q?qT7vDvrWD+0Qolh0V0brayKPsfrSZEyZMFjHLxTV8ay9ZAloijfy+V/LFlXn?=
 =?us-ascii?Q?q1j/eYfNC0VrTT35k4xAG9TjTrjeW9skdvg4TinPN/HigU0xgYjx+2Z9v1kF?=
 =?us-ascii?Q?UpCz/Qd5uwmE+f9QrWEgnnBov1NZOON3/CLulqxoqtXMYXW4UIVJXNzrpY9S?=
 =?us-ascii?Q?cJ78OsDrrAvOhHaw2s1FIBO/cMCHnH9NUOfqHp0OUgqYxhSSdXgtVbcSNOCn?=
 =?us-ascii?Q?9Lu1LPU25oGIN4wCiE7/GiqvFA5bDaxBqWDiqZgdzd1zjo5WpbutgG3ichNc?=
 =?us-ascii?Q?Y0WF4S4ghNfxCWTAQYnh/puUK5hbvaC7SJRytHl3TSJXgLauU0Bt6luGOFQo?=
 =?us-ascii?Q?/u3r81TaMiGPAo3MNWHtGn3aJMDbHJD3ZKndAgOHJLAHZV3lrrRgZCwGLqku?=
 =?us-ascii?Q?5nGssjgeSkuZkW6iQP1AIOjPazFJ/Nj6XHgAaMp+z5mmYteXyAZngpTkqM67?=
 =?us-ascii?Q?YOqbtgDSWG5gU59Wg8Z1dd2IBwf3w1nB6f8Tcjsw3BSDl20qqCtm789QbCBu?=
 =?us-ascii?Q?mEKq81oCPmc4KQFk6evv9B2/t+3Xcjv/+bVuxKCNoWxi2p/ADkh/zMPVs4qQ?=
 =?us-ascii?Q?eLR7LFCCtrF2vta4/r+l5zYXfRWJZChAugIMLwSeY9dRtQDreTzMl0nZ8AWA?=
 =?us-ascii?Q?Bb8tEvq/A7kO+fBdl/pD3K3Bu6G9my3YMDJQ3eWEW3vx0q22fG/f347BGpdA?=
 =?us-ascii?Q?S+Vv00xY4MfokPBfvmfs/TestahAr+PnRo2OxOVs2PWSnPC2IrqYYmxXAC21?=
 =?us-ascii?Q?exdgwe5JTnZDUyn3ZG8AyWl55AxHlo4sStzOVUr7eD19nmeLIkSBCtpjRMlf?=
 =?us-ascii?Q?1XhsPBOdYs5y7hJOV3eBok6R32dlJ0HWfnodAM+IYQ1eiWJqTPUfBj00qAiS?=
 =?us-ascii?Q?ReNMnvHITpnVR4oAl1nbNrLWKe053aSYDJC/X6zcK7x9hwoBPLzA4lWh1Eg0?=
 =?us-ascii?Q?X8OLF1/YZr4a5TTYjSbal29TidfFhpgd/bWWLl5u9NdLNk6VQhWsDFNWTGif?=
 =?us-ascii?Q?QbsouCMFx1Ga0Rt62v9CEuXJbECkZ2vcOBXMju/4QBdYVBnIVodv9phzY0g2?=
 =?us-ascii?Q?w8HMFCACm4nwDYPAf7TCIz5WF1IRvmebNlFrn6K2tbeHxMfDpxaFikA4sonJ?=
 =?us-ascii?Q?npLyE9SPzfux//npkv9UGU180SeYgU0s0mB0ZbRLcGpAGh0u5cpsUfhcXRRP?=
 =?us-ascii?Q?59r5p9KX4CrXwD712rjW4InMLxRgp1oyJrJ+hZNFEWvr8Q2r3q9l8F79p9Bb?=
 =?us-ascii?Q?XXvlX1CSughtlgPq6w8vo/UwxXFRBZrSAtaQa6Wh4c4QyMNovompk5oggJ1k?=
 =?us-ascii?Q?lZIKx2T8oW3Hm8XxkMQHNTo+RlEujhzP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQc0jB32WRlg+Hnnv5gCZI2DEAHLQbg1VkKoY4Cn17hRCL0M9TYu23dE10Cf?=
 =?us-ascii?Q?COjYFhJPghuDnuEZ/c21tDQmrWh0i4UO62mAeGiLv52/CsWZHW9IYL3xaJbi?=
 =?us-ascii?Q?94TGsbxNj0ItCre6FABVDFYfOhY5nphB2YEJAtWNGFRVsZRJT3jDzZD0B8Pr?=
 =?us-ascii?Q?qnxcPdRONzJOkEHwJaT2UBImsy9atga+qL8NeinUxawIkF5R1tiUmKmuvk/B?=
 =?us-ascii?Q?PBcH2SMM1Iyn76Zecx3TdXL4YPVFpeMSdJUSavCSfRlKnHh6wub/+J011aRp?=
 =?us-ascii?Q?msNa5eZxTYKGX8wYCxiMU60Q46Qi8a7FfCQI1vSsKl7tNqRavwMAEusOVWDZ?=
 =?us-ascii?Q?AeWnnQ7eMEn9Tf18Up4cFsIOkDvj9tepqptpXv7oOXWPKuBNDI6yrUWDpkRh?=
 =?us-ascii?Q?3grfvgDn+OfgsR+mwIbSR9p+K0qxzEye74WVmvwPleNb2P7RK9iS9WVOvrEq?=
 =?us-ascii?Q?oGaMDbdzDZJKPyFC/AGb6H1a8UuClfat+HpRw4xn8EYqzfe5x9YMpfLzHLjn?=
 =?us-ascii?Q?HiwqiJE6iicCGa/zt7jO4rUG4pRK9RPoToLOLgPCUJAs7eFglQXKyyoEB8rv?=
 =?us-ascii?Q?iliHgp8G0F6F2D/Ho2pmaaatirmZnL4gmrs14SwPpSVjgJ9EX21Aknfc4m8C?=
 =?us-ascii?Q?4OfT0Au+7A+8jzfw7/zP9RNk0srUeoY8QZxpDrVcbNsBx1uS3rYuqGKAaBoE?=
 =?us-ascii?Q?XhaPRUkcjLPjErW6XmXFBEhzFnOAqIhonWQ4iUO+vpXg64JCI9hkVQ51Uk4O?=
 =?us-ascii?Q?yr8xdeQ3ZaSG0wtxmOiDtIl/wOaxLy2ZJDxT0bmqbfT1zwhnQxld8Nhe3ep0?=
 =?us-ascii?Q?9mbF57z7R3gA4HTgbgCkHyw88EvKAGEeBUkkr6gMMesyogsCfhXfOv4HSu8x?=
 =?us-ascii?Q?OnvdZAhUVp2JYzD52HmjRE8KwYRJwYofkBmuUFeMMf7aLXPwkU2X28ztyaEJ?=
 =?us-ascii?Q?i3vzdzvpK//fy4GssocuOBUXXLKgA1WBsVgucpwOiW9VGS5rPUHq1M/3YYOJ?=
 =?us-ascii?Q?eDuOypj/nTOj7nTfspGm951nvxvBuVk67z0ItAf70qcfTl5LK9RtVPvrtqTw?=
 =?us-ascii?Q?O6lYbTNlYFdEFEwbQ25ZmpXTEi8QAL1wtlNJIO22ehkUaFXZKPIXtKgIvCvg?=
 =?us-ascii?Q?kuVHPGUZCUQt+Kzvp/rW3d3XRfGMl5OoHzQBexULC89b26V/rkKDIQ/hzn3U?=
 =?us-ascii?Q?yiS68+T6xtZstNj/AArjcG2W/wSu1pYUeFLZOsCjyQVy9uoXF42MjXRfFh1p?=
 =?us-ascii?Q?y99wUitXhi7Dv0GrQuQ+b7cENwtUA1KCLs5yG3hYSwuZmEk0DhaWlz8s3QLN?=
 =?us-ascii?Q?J8lttNdtGu1pAt91lt+rjZj6viUEGSkDOR4YeUZHNWLvzTMeh+RWE8hLZKZ7?=
 =?us-ascii?Q?KeCnEk1P4tBVL9rHzEKUd44eIrxF2N80MNWdql3WhkI4XYk7T1wlJ8p16D1+?=
 =?us-ascii?Q?cIWc54OaiXXnMAgk56vjFuWtW6D0tCgByn+GXu6z1tzG4NC8gjiKat2WB3Ut?=
 =?us-ascii?Q?7Ozk/hMAPVee65B7YfkoaPLZYzsC/nsbCokelJ7nQx/pZDmRhAmyJub0clUt?=
 =?us-ascii?Q?CWoVS/Lz05IL7c7+PKPJMkfdsNT3uwvJ4pF66oHA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dfd62a-3d28-4f62-350f-08de0fd1ef3f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:12:27.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyBIVAbQcQ8RABOjTodi0gi6mqtoS/+3h7WeDBFEZr7YmBa9nZ+vTbvDvmscjpcf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

On Fri, Oct 17, 2025 at 02:11:34PM -0700, Nicolin Chen wrote:
> On Sat, Oct 18, 2025 at 12:03:27AM +0800, kernel test robot wrote:
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct arm_smmu_invs **invs_ptr @@     got struct arm_smmu_invs [noderef] __rcu ** @@
> >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     expected struct arm_smmu_invs **invs_ptr
> >    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3208:33: sparse:     got struct arm_smmu_invs [noderef] __rcu **
> ...
> > > 3208			invst->invs_ptr = &new_smmu_domain->invs;
> ...
> > > 3247		rcu_assign_pointer(*invst->invs_ptr, invst->new_invs);
> 
> Looks like we need:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8906c1625f428..398d8beb8f862 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1105,7 +1105,7 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>   *            to_unref argument to an arm_smmu_invs_unref() call
>   */
>  struct arm_smmu_inv_state {
> -       struct arm_smmu_invs **invs_ptr;
> +       struct arm_smmu_invs __rcu **invs_ptr;
>         struct arm_smmu_invs *old_invs;
>         struct arm_smmu_invs *new_invs;
>  };

Isn't it:

 struct arm_smmu_invs * __rcu *invs_ptr;

This is a pointer to a rcu controlled pointer, not a rcu controlled
pointer to a pointer..

Jason
