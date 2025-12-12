Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5623B615
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522827; cv=fail; b=Mn1gJKBKWMU6r3oMK9T0ndnF0AIQz6l46qaU9potRpQbvyUKwBokyKFnM8MvH574yxxXP1Bi83DMa+ml9Z3QvHoyXVJIUD6k4EvkQqhO7f0qw+CeckOhc0lS6RdTiim82Udfelc9vLaiMP6xRHZaB/bcIQLZr2SP3q9qwETSws4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522827; c=relaxed/simple;
	bh=ALID8cLrS9It1wyfI04zkeQeNuByzUh8GubHJS65P0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nNxB32+OpOLjkb5MwM/nCThA0P2gsalOwPHSFPfNUYBjpMNtIocuYGdAKr/37gq0dac+NHP70/26PiqN21c/dxr7hht7FVndP4GqSDjdoZe0f547GvrpI/BIIoqVZ/UoKsZMEwCPt5ELDkGuSSarIwgJ9JaYujdPpiUusmQp3KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=crO+kPMv; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="crO+kPMv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYHb6OR3QYWqbayuIIENFYv3FVCsVNyxrb0viox4vqDPKy/IgoN7RBNqGpJZmDpRlwPY2GIIC3BdipQPK1pwe9ZXuQ+3cu1cuFaeBKdJYiEZEwewDTaOmr+my2PK1z5p3GAP4XQTQBPBRb8SNK8oq3W7so10sGZahfGCSjRgdFH4xZJhDBOapPp2Uf2QgTvNkY+5nwYh5IiAE+ws2mAEu1L0C+MmovCDkn8dqdMkZFbXhdO+FgGHRrMuR5PdpOM9KCrHZBHYQFApiOZ1RjWLk7vJchj8GYHdUh6DWGpqWJtlZRh8iCsP/cyZxPvqUOi8X5jo+iuZq4fTBmlXP5xFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v32YRboRSmozgoJrmmHy5Q/q7Jr8CUgk8LuU/6azTwU=;
 b=Y7cn++juNkNpJupSBJwILsAauyRQ/ttVxHjOBYdNWLeA2rRS9qcWj1zHnmA0C1oQPr1xSXVNvl925ACjanzair3uFAi07bzKfdu4K8SZmNcGlc8xgmdy8dyUUOhGFmKVd1YtINBqyLOBqxgADZt/SbMK2x61EEUAKoDdagOOPqYN1CVRGYFVOwEm1wlFMmBIErkgJ27zw1S6bh2rvSOZA4CgfFjDrIUluEZxu/8Mzq47N/LE644ZxWJdf3jWO8fTW6U19TWAKrcgRnQg+EE0rpQEajn87H/B2hDTth/W9abBGGfqVIUrBtkw/vRYPGCNCCwd5hR2V3Ppc4Q2BheXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v32YRboRSmozgoJrmmHy5Q/q7Jr8CUgk8LuU/6azTwU=;
 b=crO+kPMv5QzLxHdFuVKHPe0LBae6AWUlmZf9RazgtiWIwdKVMRVBRDV3GPqZVgguKHEj/lo0Y4ucTSQifn4jWyOF1RrrzEiDDuqhpJETIK7Ii0+sctf1EvrG0YIDbdNuK69vfZ7wMg0U5ynl11XN2o5aGH12XkTjOlXqOrWj/97BJEddlPX7ku05TCQtE5xNkvVFAYCyEA07gYtsgX5gBD40EQSbyfY98jqvbleJuSD2iHadU8BnI/72jjpvwp/RUfcEgXcqwerrScCrS3bD7UvLBrhQkmJVT1L5LZxTWhXK4bsXw509J4CUf+hrIzmSFkiCJdkgJhzFBANaWdiCaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 07:00:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 07:00:21 +0000
Date: Fri, 12 Dec 2025 03:00:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Wei Wang <wei.w.wang@hotmail.com>,
	"alex@shazbot.org" <alex@shazbot.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "aik@amd.com" <aik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Message-ID: <aTu9gUxtvWsmG+WD@nvidia.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <BN9PR11MB5276D5D7338261F48FB863188CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D5D7338261F48FB863188CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2740e0de-aacb-4bd0-764d-08de394c1e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4Cx+dNvoQrnAIii92r2SM1L4cuPEFx8ib4LnVh6d+qvfgYLB3iN5n+n0Cet?=
 =?us-ascii?Q?+fxCtEWB0InnffR66R7gUsDp6CnPZIIUI2VpFEhdkh28wQ4XQZtBhIlw/pnF?=
 =?us-ascii?Q?ikd5rcOMhVuAOEh+0f527lNEiuQ+BhMg0x+e4d5lAMAaSKa5/kYgq/oVwo1t?=
 =?us-ascii?Q?nu93n6a2tgDJrQ86okVZWjsRf4rdWUfWnt4AABKT7F9vvIHvhF6bX1TYjbfF?=
 =?us-ascii?Q?LGpfC6bumTUwkMLUaHPZvT6/4Ym9XgCIj4LTlPqzrV0j5bTVb7LMPQMaHHkv?=
 =?us-ascii?Q?lDTbWakxKxCqd2UVuVcHBT8cwsEf4/9Y6aotMof8ueF07O1cyUwoOv0kOQSc?=
 =?us-ascii?Q?3f3cCUaiT8M6Obtke9GezTbzJNjndWyER8OOP5GaRHnX7foAubBeXk0+vKoc?=
 =?us-ascii?Q?b1tUIaZK/wi9RcQx6zuforXzzBc1ioegWI287GXSy14+OjxmknL1dhErLDdd?=
 =?us-ascii?Q?sohUjrxrmD9iclrjD6BdrOY+/zP3fj0qR4PCN/nt4MhypsgXhoYuzb6zKHcn?=
 =?us-ascii?Q?bl6qR7diBSufj6RHbbR6QjjeXgpEogGXwmNuyEXuUW+JsIQKq8/5uRd07KJT?=
 =?us-ascii?Q?uTvJ8s8F8jgHtjx1fFfxGWxeh8fumvISUAOwnRz8PuVIXrNzXG4osJmk+ksK?=
 =?us-ascii?Q?VWGkE03WBotKUHlItdfuCotsBAtNYrTP5IPqc+4/pexiWewmko6MV2EaQYzU?=
 =?us-ascii?Q?YDSgrKDZAJfN2YmCW29RB1NIzHHRO8IYQ37ffLoIrVjzmmEMnRRtYZ3a3XVO?=
 =?us-ascii?Q?VYZw0GeiCdI4B5DxsEySTkKQxTmae6IOQNrgT9Pb654f+UQU8ziIG6zReJwE?=
 =?us-ascii?Q?xDKKzBXIBCX0kN+QluF0o8rkoqIiowAKjITNN3rXLIY+9GrDmz2IaepZUe5c?=
 =?us-ascii?Q?QTQL5Y20e6enccy1GY/vA4cFZTNGdpmmY9J4zWKCfjxp2vcn8hSRzPHdqgTl?=
 =?us-ascii?Q?GayC21XCulMb2mN0WqZnp3qduFe6I0cW3N5qTREky6NFKchT928T4R1jF1x8?=
 =?us-ascii?Q?lAILKQKePf4u8otPwNvOH2gnjJzEb+8akG/bs1BrVTnWysRpFsfH19hATGeY?=
 =?us-ascii?Q?4RE3nZ2rMdm5Wmxts8RklrN19hnjXj9EgVJfA6dUivJ/iUgieBlcMNuXt3eu?=
 =?us-ascii?Q?QoGpH3dZUROvcGx3RHdPRFXFwSqVRVxpMswPX+a/HiWj1+pm+ejBEBF7pNAr?=
 =?us-ascii?Q?2aX/OsxHvB0PF3Cz3RDccvcHTyHPOCODm6KSNyLZXDrzYB8NWedWGdh7cMdc?=
 =?us-ascii?Q?g1kkklFk8aO8sshx9nxFb+Znh+7tlTAN3cyB5KHYdjkOqoDpsSZJFHhHG640?=
 =?us-ascii?Q?bBulYR6AcEnDjMGJ+dGNHz8v13rZ/zs6CyxvbSeK37Qq6ygVJ8GtL95ceP01?=
 =?us-ascii?Q?FtW0euS2ZNlVTUcWvq1392cLC4LO5iU+DdBXaCJv6D9i8Eg3ExwvRzmvJFCS?=
 =?us-ascii?Q?de2RBMrKMYGAOFuQRi+JIuNRgrVB96tO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?25pnQhS53/C1GSj9rmSeKfj/4EUPMbK/VEposlHd9NVQoehpsdx4sNijlymX?=
 =?us-ascii?Q?ZyPK5EkhoQ5cQxtA2ud5psQWqCbajh90vFuelOfcSBclcbE2JYPpYUIeg97P?=
 =?us-ascii?Q?Qa+nEe6HEq/PUhR/nJ2crzHIycZxAFooRJoaeObunj2BVqyaqKMPXii6WeE5?=
 =?us-ascii?Q?gWNkwjodJns167xQahy4/YA4l8wfgrNI3dIZT06hBs89ZSYzw2hFATYhcobZ?=
 =?us-ascii?Q?3606+F00WkbFYB2vz4kge5LDEeFLd/Id82L1AiI+VGZwHyT9WElH3JtFrJKo?=
 =?us-ascii?Q?cfu8qJO5FVVPrXBoQ2IEJkgryLefoQ0ofKoPMwEAecJG0jo7JQnHg/ibYqD8?=
 =?us-ascii?Q?H0hCvDmXj8G+eRjuuVn7JnEP3ap3aaUhAe/o3G2WEHRtf26Z0oZlMcv3cOcR?=
 =?us-ascii?Q?/0Rz9O+idQUv/YNt2rOvz/MW1jkm0vCJJS56zoOu7wtOGD3a9hJbbLaINDgV?=
 =?us-ascii?Q?v0sbQCNil9KfGM4al9zTQULH1pKpZwXmI7U8CZRXyZ8a56pFwiEh+E82pUEh?=
 =?us-ascii?Q?UiMOYNMvJ2oI6Ca29PM1gpTAoOYt1A7tvYFme69bEKz+Q8Jh8gYm6OcpeL/z?=
 =?us-ascii?Q?ymhpeRRpFnalMhSY7wL15XGgkKgGzMSS/Tny8izFBu7KNP/7CEWBmCvCYcrj?=
 =?us-ascii?Q?h7IxfsdW5KEHWXc0ocX19KoZuFW1yjUWg6EUXEuhGZCfO1EnPVP/0SN0+rjI?=
 =?us-ascii?Q?uDc8N/NwzVAA//hLlwWj6w/uUgb+zfQsNIqZmgycndntHuh0rDzBYxT6cMnj?=
 =?us-ascii?Q?2PBDHJ8Aya11ARR2X9KPlATWaLeLcCTvfPeNCKd1cLSkIPppK55RvU0gkkdP?=
 =?us-ascii?Q?M2f+1Z1LnFQ+xhHulAAMf4t+JrjyIBu+cMmODHrka8+A7TcrtsxTT3QgHw93?=
 =?us-ascii?Q?uIQoVp+/fSKbseIfJxHGE7pSjnNFfa4URoul3fd6WYmOX8Z394x60sWCvdBI?=
 =?us-ascii?Q?MrkNh3kp9YMCvRNGuDCVwbdGfFRxdFYebz9wC07bkrdRJCNDGTWwj5MunLNH?=
 =?us-ascii?Q?4Vg/Yfy5pqf0ZEEwJFK6OtqpREqDyAz5DH2n5VBVhXjF/qU6f2ZQUySg5PmR?=
 =?us-ascii?Q?ApxZjjPw8w+Is25awkExWrVVuGNWXuOpEp2XJQsijZlgcr4TNR85CwQr+DfP?=
 =?us-ascii?Q?ZK/uLQttsQARdP+zhyyaur9z0NIJtGPkEpRPPpgfiu47aZ4Crop7+nRFPYgH?=
 =?us-ascii?Q?OpT51m3Ggjh9EM6RdqE2wnz9qw+/VTGE1GCf8CMHYLdn+BYN2lJ5WEjOcqU4?=
 =?us-ascii?Q?2uCmt8KISn+RaExrBpmrhW50HY6cWB1L3fYQoyxdN+RnVugCu+eIT16gaBo7?=
 =?us-ascii?Q?oYMhpDF3l4wQh6uKTTD/SjELJ639WjRDKmN0Qa6mOnpTU6KL/kX27KiVQuvF?=
 =?us-ascii?Q?Z+y8WqNB8TDDQD5SQYgZAMP1dcbbhkRmKJ11iQS6Vqx9x+eqb6CLN1lpThsQ?=
 =?us-ascii?Q?cADg9ED3sPF9GeNaRGctG35W6QhOwRUMfbqevYxJfNqwxA6qgozNjKsCbw0s?=
 =?us-ascii?Q?XHOPxbTEwxxV3gHiWJbwSMYgSma3rnGsgcBwruiO1HVyThpxuF0F+FNb+z2l?=
 =?us-ascii?Q?eLyMq7YTkzEyUCeHdhRCgRT1GUcX5yBThIOBS4gs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2740e0de-aacb-4bd0-764d-08de394c1e00
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 07:00:21.8481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJha2PHe55kHHxmauYjN0OnNehxE9BhbgChwDbPBYaGcIwziU8y2DStiAFE6Y/xC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

On Fri, Dec 12, 2025 at 02:36:46AM +0000, Tian, Kevin wrote:
> > From: Wei Wang <wei.w.wang@hotmail.com>
> > Sent: Thursday, November 13, 2025 11:54 PM
> > 
> > @@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> > unsigned long vaddr,
> >  				ret = -EFAULT;
> >  			}
> >  		}
> > +		if (vma->vm_flags & VM_IO)
> > +			*prot |= IOMMU_MMIO;
> 
> move into "if (is_invalid_reserved_pfn(*pfn)) {}". it's pointless to set
> it in the error path.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw another alternative is letting userspace set a map flag explicitly
> e.g. introducing a new VFIO_DMA_MAP_FLAG_MMIO flag bit. It's
> not considered because your use case requires existing VMMs to
> work?

I don't think we should do that, userspace shouldn't be able to create
a mapping inconsistent with the rest of the kernel for security
reasons.

I think if we ever need a cachable mmio through to the iommu then it
should be wired through the dmabuf mechanism the same way vfio drivers
wire the cachability when they make the mmap.

The nvgrace is the only driver that creates a cachable mmap already,
and it would be more correct to have a cachable IOPTE, but the only HW
tha driver works with does not care either way so it has been left.

Jason
