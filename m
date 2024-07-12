Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948416F29A
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788328; cv=fail; b=anP6FSpfp/qAmFPL2HWijMZsmdfozmujPaQ9qqppXQFk1CFIc5gJAnCvQvhEZ9VSh6Soej/19c7sMPhEpfbvMMary0f5lp9dl+nDQmsm+L03KKz6Gz8Pr0Ap9CQnR5PoVjl3C79wyb0d1d6+paDskDL9mmVY5EKa4oRWVcJAOxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788328; c=relaxed/simple;
	bh=vYto3C4NApZauDFZ+MRTUypDndTOTOk54royVN/YV5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YKyZ3/OpngY1DMapteN7P6Y5sCNoyhEvp01OneuZKwydVdcEylBqx0H4xo9vfAHO1OwlCNFCfGZB8dJY9waRIu3WYV7ctHbh5WHg7e2vClKkuLaoHvD3nbVA0K7KaMkQ7QYacqJYPBsv2K5CXsnYrOa+vtMGTvycMelwdGqrfYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BiM2v/Ja; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BiM2v/Ja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQcGfSQFMZ6K5EMjEwV6oY3m/nMDM84+RVOeecvnkhtUV/I8mgXNiMSJrZayLI2Qka3CqwRmyWgiYSSQklulLh8QdYBE76VVbWuLM8J5Ast84yeJgI0eRORVQUvDrdj3aKTCM2miJqvik4RBR7D+BPIg6nsvdqOET5usaW7NTYaTgExEYhxB2bHY04dq17Ad3YhP19eAZ66CN0Y0S9RuWTf69UJLh6LSK7qwpR2EVwk92gVk9NIyGHWTzcWMoY3dKWH3FBmP0cfgi1iIIkYG9H/jGsUWR4DFGNXXBpvuoALTZ7VQhMnkp1QqhCzxVTto9Sdkrq65xZR4nvWA8mUvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtEZp5mR8IuckxLHjZHCy9MVFwPcX/UFDENLUUIA0MQ=;
 b=biOzHgRXIZp160nuEgm9hrG5/GkoChkL8wQoMyWnOERPLVxSz+mkNjcptZW2+ZJOuk+2PAtmmPmuA75Jo7RgMcNDCnERDWmvWNhjCH8koAiTzMtKPfbBVU8jG5xqZXtTiV2SrTmlElaCVxskh3NIVnpfLhDy1mM8d9/UYarLdOyeKXtwT7Nt+A1WUuOdfEssZY7Wr15yvMqyuYkHJ6B7XkeTE5/UVyGQcCtyqKePeMX5lZuXpcoNSKnUbI21SrfoUFvIr1U1mDHcqziTWsgk4Ew1vQZpDSM5MfPRH460EUi98ASzFXUmpoM8jdlMjD7Ee0KRUTAX34ngErqWei06hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtEZp5mR8IuckxLHjZHCy9MVFwPcX/UFDENLUUIA0MQ=;
 b=BiM2v/JaenLO9KeIL2G2SU8mshqHdu2LOpAOQxhIOr6cNLObUTKQwMRKYzdUiFiDjYRYI0YeWvLsTM0w/UCbT81dSXg3MbBahSdzjZYn+5/8m1wZS6kQALQmGXDfQNkU77QS1z26y9gj93OpnoFVKuO8vr8ED0ouQtVe/9Mc7E0ZbUgXXpGSAK1m42oAAoj7i11w127EzSoPBEy970ZuYnSke9HjeluCJTAnM/VzrCMvRCZBDqkf0MX6Sc2TkPZihPeguI7m1dKTpEyupHbeuA/AmMceux0CaF/ZMkgu3pADQ+S2doimXUOXW4+W3t5LSJeTUI5jqDktBbOCyaTe5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 12:45:23 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 12:45:23 +0000
Date: Fri, 12 Jul 2024 09:45:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, ryan.roberts@arm.com,
	kevin.tian@intel.com, joao.m.martins@oracle.com,
	linuxarm@huawei.com
Subject: Re: [PATCH] iommu: Move IOMMU_DIRTY_NO_CLEAR define
Message-ID: <20240712124522.GP1482543@nvidia.com>
References: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712113132.45100-1-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: ef74c96a-bf22-4fd5-5f1f-08dca2707f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CjDNPaV+P1I70ZNRFMBzMM/bFB6nDhqqfj3p6rEm1Fu1K4vx5vlgRQrblcLa?=
 =?us-ascii?Q?dItwOv+In0H0v8dfTOBDiOmefb0e8ObxzV6jb9IMYaC6P7zLL9XZ6minYGPB?=
 =?us-ascii?Q?yRsbanY/zyCCLg+7TGzBW04PEuC81WJvUUfnE37X5/xylqyxVFh2Gg1wLt73?=
 =?us-ascii?Q?K0CeN/2qQ81xXS31Bkbi+litJga31nLgoq5Ymr1lxkc4E+LgZdzVYQauUL5Z?=
 =?us-ascii?Q?rWPgUqxNEz/XG2AS6vCM1V3FfHKgyeAEoV0TPA7hRxzn6rSvRQM6Zq0HRXvK?=
 =?us-ascii?Q?Ad/eAOE3BYekWXLI5ZEps/ZfzDzMimjze5mVm+lv4UelozR9Eo0XAs3lPYP7?=
 =?us-ascii?Q?ixye3cBXwe/diRtIxdm3m9l3+2URe20UpC1FXwnjIVgR/CfEvXNCDhZxqtvY?=
 =?us-ascii?Q?8+bVXZ6nF1qzgZUkl4H2StZX4zl+f77RkmvrwLj6gLWH17v3EB4sdFlNVCQp?=
 =?us-ascii?Q?EqSIEP6yczbNpEmAmmrgpZjj1i0SSwiksBTlW4M2N+/ASh6aoXWvLhf3yQC1?=
 =?us-ascii?Q?uAhhplTosgYTS787UuI4+9P51/mI6BVt7t0adSSOG3K6Cme8yTpjsZI3TrS3?=
 =?us-ascii?Q?F10wTpl20vFCPd7j0uwBIWKxBDDDp0LLixMcU4E1wRTxHDpV/d7iLQgF+6ez?=
 =?us-ascii?Q?zfPyqPrFT2p2qJvnsQVa1Xt4j9vjwB9ie/gGRxEVjdf63S601zJ4SfMAhKJV?=
 =?us-ascii?Q?OZ2I587lwc8EPq+UEN7m4iYGHnS8quZP0hM1su7+avT0VoshwBnkyxYdMKNL?=
 =?us-ascii?Q?LRCVEgd+8JAg8TODKXX1mm4FeZ/kFfi2qz3V9cpVu4Enu4DikwDucb7TLU4H?=
 =?us-ascii?Q?7Yc77/8RH9Gh45ITerqFMr8nz2LaOoak4Dv6uUr5cSFatLyr+/xe8q4tVCwU?=
 =?us-ascii?Q?Ifn0HwmXXfqh35rNl5RTH3moKOrSe7LoFFqY8xgg5DphqSdR8oqzXzmGkJK/?=
 =?us-ascii?Q?hNgSjoLAq661qxi4d7xzlvdXoGqcDebPhiOuG/bes8x9AKE8/gPKwGsVu0Rs?=
 =?us-ascii?Q?IrWZmP/vHMidxPirJj/evuJaZRGgKMdYweChid/m7DKuF5J/A9xya/tp8NNs?=
 =?us-ascii?Q?RsyYWpgiVa8Ry0JSZkoss99KZRMobaRIMe1GMQjratd23ByrtplAV/bpN0cV?=
 =?us-ascii?Q?D3pR9PiyuhU7Gw6zkVZFsPAPpFvbRxl1BTGVE6XHYWAgrvBKuxfEzbIvVAjZ?=
 =?us-ascii?Q?jWhuHn+ay44taVq9z40UUX3vR8xKjLvmYLkHUrBLh2y/tx+fgD8+Pb/r81kK?=
 =?us-ascii?Q?k6S7VAG6wzwYscNlhT327hnqqLbD37+IRcgcSnfpF58s9nGqc/PrYh4AW5fJ?=
 =?us-ascii?Q?OleyL1YZoIOUIB/f3WytvxIZqcI0jxg+dJcQmxTOMsMueCXJX5wlqBmtr6yi?=
 =?us-ascii?Q?6mqmSi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8p1re/U2CfFX69/vA7r3qdyZQYOAYB9YBtZlU0+nOfOcqsWmyxzWBeOgds3?=
 =?us-ascii?Q?kV0nCxWrX7AiG9672JpK5wHGGfxnX1dG5TAlZzFJ7JXT3j9uuVtrXAUBbyfg?=
 =?us-ascii?Q?x0yT1ca9p+DzTVFQhuL6D/LglLct3rQDl/ijBBtLlTZgU2Lg460YzWZLaV+V?=
 =?us-ascii?Q?Bk+00DnU9BzqNnfLNcHpyPUy0PVyac5pe8wtRfaGq2S3b2APtE3d1uE+OTQ1?=
 =?us-ascii?Q?uoxURtgGjiMtGaF1302gGjbeVIDup30qGwiyZuLm2fkhcBbtLfPHvjiU1kBE?=
 =?us-ascii?Q?e/hVmnXZSbBIjQFxXqXlCOIwF20g1NwVOP/EOVZLlgYv0pZ9s0zHQp1r1S57?=
 =?us-ascii?Q?8UZ7CLpP6inKEUzDkgYLnIK082OevJV98yP5LuWswM8MaU7NkSmFDTVzz6lm?=
 =?us-ascii?Q?ijmirYiB+kn3A6xYafp9HuthlczrZqcx7c1egIrjr/E+rj0IkpHEx+hw2Zib?=
 =?us-ascii?Q?6V4/hwCehjE6/ju6ehdQ7XLU2alfFsMivOcA3aMj4wF4pASf05ViM5Af9B8o?=
 =?us-ascii?Q?7226R2z+KpjpHyr3ukMrR9D68Zhk4f/h+LqFvc7sEsH5R3LmcctHrpkt+FnV?=
 =?us-ascii?Q?puxf5rBGui2N5X2aliEVDiKLN1c9qwGUMAcXxeQJ++tbF2X8z8iV39EKrdtT?=
 =?us-ascii?Q?VrxZQ8SjMqWDaY3Y8DrNlA02Io5zlTEFtu13l9vGSNGHFeyNsBSMHgD9lHmY?=
 =?us-ascii?Q?ADMr6wvxjR6Lf9lH+3/zq5lerWoQaFYCLt0QGunib6kadBF10yRkrZ23tJvt?=
 =?us-ascii?Q?+Ufe4WoBb2b+n1cgT4THcV+26x/5uBbPN2dcu+tiX4AQAtQYcGbwrfl/MKnk?=
 =?us-ascii?Q?85gBeG5rGKEkXUm5qDSxmqP1VAZX9FdVRgzIaRdzpQDC7kFsKdFPs2hdpqya?=
 =?us-ascii?Q?2cAmguOSazIp6gpridEs7CymICux5RS4YrZAJyx3As7yLC28xnxfk21ytXF5?=
 =?us-ascii?Q?wD90Z108wEvYYn1hgfVyBRXpPLb3FkGxNkuMUvjBfoTNFqRosTRW9kN9B9kB?=
 =?us-ascii?Q?zBHlIh2P65zGeYGpjZYGw1NSuuIV7hDyARD4lyPWqLoeBfOJpxntpuQuMwUX?=
 =?us-ascii?Q?4CulZOaA6S9scvlkyWwuxbK9ZBFmDT5GcKu2/JJa4O8LdFVtXve5erigosd3?=
 =?us-ascii?Q?pCn9BlewypL7HqRMiejWmdNI+rS/X5RdHbFTxkMc7iQLHqzzUfAizpY0GH+P?=
 =?us-ascii?Q?Ln9jlDYHbU6NLouhpVdvOVzbGRW8SvS7/pR4dOmLFvl+WlR3OmICp1VLPer0?=
 =?us-ascii?Q?kPZWD8Uq2/yufBFQtuMKKIwKFEeOGzEBLaZuLi3OQkleh+jjP3OxXE0EXjTT?=
 =?us-ascii?Q?EH1sQC8Ha2yKgyfIYk+hgbWJ40KAbRxRm991e98sRsTsvoIAeuROMV2Bj0EQ?=
 =?us-ascii?Q?MOFl71zcJNaTvuqGcsQcPIHIEa6JjNMN/sR8Y4C3A+Qs/CxTYkCS2FTqzc9H?=
 =?us-ascii?Q?Ynp6kdq2FiKsXnPI/i0uKLj2kbw/T0Dg2EkoaqcvqYmlfF+GgeWFdFoS3qP4?=
 =?us-ascii?Q?KQ/ShECg/nyvqMNDpSGn6JwMSotLH2Vx0YufDNjDo74SZgOKDi6PA5KZVH87?=
 =?us-ascii?Q?3t5Tcs6QSXdTLI4ZQqOG0pCjSSQDMrPlvrlX39wG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef74c96a-bf22-4fd5-5f1f-08dca2707f0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:45:23.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpYmYiwLlO3B+l89z9+pfVMrHmNuW7mO2DNA5aOtnXz5xWRp85pubTZVA3wAp7pa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408

On Fri, Jul 12, 2024 at 12:31:32PM +0100, Shameer Kolothum wrote:
> Fixes the compile issue when CONFIG_IOMMU_API is not set.
> 
> Fixes: 4fe88fd8b4ae ("iommu/io-pgtable-arm: Add read_and_clear_dirty() support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407121602.HL9ih1it-lkp@intel.com/
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/linux/iommu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
