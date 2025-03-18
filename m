Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DB20C484
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301556; cv=fail; b=FL19TuJT3bVmpvhhwk8bBwNvO+yvUTi64V/RKNKkQbg8ubkCMfi90uyiyHAGfG4Dvp/NnUYkrwMzjyZp5IObZQQ9izvyjo8svF5kz1ujedRHS2Tog1jJNN/u1Lh2nPqlIZTPlM05whBT2BY03T+pGNq0im9Eq6i/T3rRBbznC/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301556; c=relaxed/simple;
	bh=LGsbfeNYWrqynEOIdzp3b3q2uFaMFzSXniS6+dNUFaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QN2hZhoZU/0107JyN6H1TS00Yfw+q8CBglPtg/DGzmLV+ZEBFvLdOtNQnHGAQipN/dRV3waRyyjqwkscAZY+epcPUsQoNpOMNekOk84SGXfRVV1hXEtazAABNIfPaOFXGwkugdpuxA4pjf9YRdDooeV36FE1n54Hde0xeEYlt4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4a+vkQY; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4a+vkQY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSo6lo74OPMkrHX8LRXRpw3Qy/Dkfx/vWEIvUGrcDDRfVXm6nSMsnhddVk/iCzlqGUH55ZK68xlTi4EYBnE6leB2PzyOq4TAQdlrRAySw2dNRdsZJ/yBEnqlivqTR7tBFblprQyRPQipPNyiVkvl4jKu4wBJWtldWC0bcF+sE2nQljn4qi8uWdUPZv+TK43+CdT8SkPcSEUCgK4tCKWyE5Z7lQqzN3hkKmln0VjwkjzB+4opHVwxigHJWv34GMUKY32oDX4KwxxcvETFgEmPU6WhSClMgdms69tVdIg9bGfK3EPIa7XXPFoy6LOsRdyCHKTROdG3OeTMPqAFfRRFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGsbfeNYWrqynEOIdzp3b3q2uFaMFzSXniS6+dNUFaI=;
 b=FZAxRJSirrzPrYN1WHLhgUOAAofoX3r2HDic/+r8fAK7G5SBIosv86pzDj81Kvz0kwvwIMoZXHIrOH6Hj/DZyxPHZm7W3GmFwgqFu+vmERMXgPTTqy9N54M9/iwTvuiNjJzvLxgHsQyUI2GzGcregKA/5XzpyTSC8geDULvJGP+F4H9M6u/Wkft3wkPA54eX0GWIU8IQeKGoUgXZ0sLo/P3oT9+hjgWCYOCRuaurl1TY14vGqf3x1TeBLoRdeDSoE4NNyUa1up1UVf7zZN0OU97WGcDmGMu0b282h5j4DkkcSksgBjKn9mc9xNGtyzWPD1o/MmXkNfhUCUzeROIm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGsbfeNYWrqynEOIdzp3b3q2uFaMFzSXniS6+dNUFaI=;
 b=Y4a+vkQYmptDyztCxfZifRca/FcJlhExm94maJFvOSGnl8DANN5gIxXwnEpSC43hbWpc1si/dBg5Qnt2cv99RN/YhfxAGZ7D4ELm4cUUlu+/WQLBjIOzT48WZUcUYGX9tysXDGiuEVdTOuNXwcWbWSpfdgwdAKI/gMXTWzimRtXeXozu+O/sGpLTs1G1xqGN6Xdt/F7C+s3bcxp9IYN+p99GhwVCp1G+CHPKi8fzsPbkG+OS19NPObymanEaoYmNXAN2Oi3y0DiUsHSk64dPTIY+gE3iTsmohOaRj8nA1LsyZViQJZ0el3GUPTbwyqHZIrcaKKQS2FNu1tjFTp96lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:39:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:39:05 +0000
Date: Tue, 18 Mar 2025 09:39:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 17/21] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <20250318123904.GM9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-18-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-18-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3fa93d-cfd5-4ae0-14f7-08dd6619de97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ub0Fx8Ss/f/bhELETA3n9x7n2lnOD4Cpv1Qchh9lLXzlVOcNamlqJhkmKzcX?=
 =?us-ascii?Q?uLMf5DZldPQNqOrua1ehRhZp+7+Cgu2LcGvrjzO/1LX4l/tZ5LnEHxzLrSNr?=
 =?us-ascii?Q?CRziyukpt5zpOLD5Gnrf58YGN3VBnPGOVHDqMBqxDyS0uFYXOo2lfPx6SUQY?=
 =?us-ascii?Q?MERFpzs5Q92Eqk8LpHqpbJHkxIqeEmjQ4/m5bd3Ka1JmGoJ7Kl53AR/hzpPg?=
 =?us-ascii?Q?zI6+3mwNyxIy91HTsqSoBZv+B3H61k/sC1fKZB70UFCsPugyRB0np/1S0Wph?=
 =?us-ascii?Q?8fUuXumPf9rv3rDoTRhTGXQg/Bt0+R95eptXrhKFBMVm0lKaZKN+aA6hPQ/f?=
 =?us-ascii?Q?GSG6O95TmPzmjGprG10mfW6G0X7JLiEHPQY5qvJHfeMw+lW+astnZtKD/J2p?=
 =?us-ascii?Q?O2E17NBp1lEJlgzRSuDwsGpXlTwsFnqv95oDULgducxACyAM5cyIXaI1BOnd?=
 =?us-ascii?Q?+QPJZfsuJzEXMNzDiGBPHmdDwEsE0hKGqe3WI8luPabViP/AHZNW73bMFHb/?=
 =?us-ascii?Q?AjeG8w0IcOei4D3YiYoq75Iq/5LCd9jx6N1R3RYk0ghnnX+jKgopmH/zP7Lr?=
 =?us-ascii?Q?CSutJie98kWdS4xF93XBxLW/BESgZsBIJ0x5bq8C8OcHw3aCi/G1pu29DYTX?=
 =?us-ascii?Q?9FqQb9JGyhEaTRP/iOe4rfMrD5mzJt7RilCWPnHmH0DhLzf/4liPGViT0Vyn?=
 =?us-ascii?Q?x1409grQofdFOo33g7iZ1Z9YUTfEu4GY1W4HCYl+wq8iCRkgTCYZ3NUORt6T?=
 =?us-ascii?Q?UWI3h8DeOLgGTGZYWspGJYgEJQMoawKr+ThessYsQFRcxPCwvCxREfOceEvc?=
 =?us-ascii?Q?uMGUsnQNT1MWpNf9FtmXW/UhHlLSLA4F181xXSWCyr+l3qwCaDIXr/nHC9v/?=
 =?us-ascii?Q?1lKISQpNfcQHEj29EO+Y2BaM2dLFyXnZ8z9D8kBK++e6yXbEHZ1xCMLN/1Id?=
 =?us-ascii?Q?MUzgxlZrbslrByadFZZNt4fGYS/3rbipIiYBcftcTIhLZEBGmMxI18MUzJ5i?=
 =?us-ascii?Q?OuNEB60OTwr63i4vEj7gOqtvcLyu4HG6mTZFst3dWSChsObFbWAR0ETgrXQe?=
 =?us-ascii?Q?nvsM5ROil4KaSYpnMtrbXReW+b7kfrEkeZhfC0iefwk1eoVDxe9xgRCVE9Dl?=
 =?us-ascii?Q?7OONQYIXVIlfeuqLzThxmDoR59KWGodT64t37g40QWlcQs6N2jgkWneyV3lk?=
 =?us-ascii?Q?l/t//KXscG2kZg/MHiQ7Lxp1HaqZc0NctftmcD/5cmEkG/z9/fnEOO7J9zpe?=
 =?us-ascii?Q?sH50l5I3WGZWris6RfPg87pC+Sir560LYylyHTRYLXqcdxdL3RgNDNCo+EP4?=
 =?us-ascii?Q?5mCUdTfNwGpfRdeskKYkXSWyN1X3jHMgEtCDAbCsI2PX6zwj4WvznsSoq8N5?=
 =?us-ascii?Q?sLhnBXdhiaMLROPiixa0gNVIUBsu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7l9aVoGs4/fbiv1dtOEAFxDMRwzkWZ4nmgPoUZVHH/YLOkejLAFW7DV2qTuc?=
 =?us-ascii?Q?O4tkEDZbb9Cvz6T+eQGCCC1gn2I9OCZAgXAqJyrrFRXHlErZkAVF0qZ5eO6r?=
 =?us-ascii?Q?MdCZHHU5lGT8ms/svQ9EFz68yxPMQsNAN1UYQVRzujJMgVBLw/naxGleZ+97?=
 =?us-ascii?Q?h/t3mK0pNp5X2Tvwqg2XQ1LGa2fg9sq/gq9tbThA5W4FF3EAkd+tYBKvWpFf?=
 =?us-ascii?Q?LRMR2mYlqCPnF+WcBdc4q/bttdC2YJnGGCAq6NwGRhfxSTwNDHmVWoXysDD1?=
 =?us-ascii?Q?ceL9zwBmfPPo14iphgh698tthjP1crTXrYnz9UPo92PnPX1pSIIH7p2VsShB?=
 =?us-ascii?Q?EHF2eeniTpxTn1kY6draZGe17dEIWIHKYC4FsRRQjuErHaHTcEl+MxhUcASD?=
 =?us-ascii?Q?i8oOalQFxkSKBj1kQrFNG4AnyZo2jv4BRkeCYvGHwkCvi7GOMrlIJ5saub10?=
 =?us-ascii?Q?9Dc6UDa7InsPmT5D4Jm+mlmNVYmdm6mAY9V8zeh6L06Y+CwFETV8vu+Q6B/w?=
 =?us-ascii?Q?G6CO4tZ9W2n3CrslYdS8cOF/qBFWJF6UCKfCHepnLQenIXsi5LPEEdb0W9Qy?=
 =?us-ascii?Q?f1FekXjQ9qi+Il61kEXAAp6QWwRYBeRSTf1ABuJnbfJo1T1Sa7Ir4awu8403?=
 =?us-ascii?Q?V4dhrCsD+1D6MAJFusDvGtGIafk8YZtXwULxdeY+CBcZ3AvyjP0Q+itqFwlD?=
 =?us-ascii?Q?z2aKqspemDYAC1ZZBOSQjh8Mc74zcCOKANhDmsbpr7L7eSgrfczDmNS+6U7P?=
 =?us-ascii?Q?azazp/YIpoKiZEe+lB44mEuRJEBFAtUD7/10PU40Jc3tw26l0zQqmJtFqECn?=
 =?us-ascii?Q?YU30vwZFBKD91q7OVL4eTB2NsgMMTAwmo6IBzt3MLAgZe9YOJJ3ocgWF27PR?=
 =?us-ascii?Q?PSG4m2W2B45C+4OSxQ3iB/8a3gqSKGnYWt30bpP027Ykr7DzD7hEgj6Txu5l?=
 =?us-ascii?Q?+r+I0OaYEDgcVGKw7Lhe/D2yKjKdznltHI7GMIDyWVp7dSsMYqmUmzdVORjQ?=
 =?us-ascii?Q?AhQeNyOqv+WILdUyvrr3kRs0GJLpavuROQn1/y+u7PyGt9VAlhaYj68ritdh?=
 =?us-ascii?Q?fInZWgGDTADWBtFl+zIuEsKsQbKAfSikSwQT2witNsbOwMoSz4+NOqGwxYDm?=
 =?us-ascii?Q?CgW9uErshucVifftiEwo/KpyT2ldBPW54hZKLpSfMiaxU5LGUIcDmevh2GDg?=
 =?us-ascii?Q?v+NSdxwiwxlliJCI2AzCgnao0i9HrEBf22tSUysEFv4bprGDEUre9eWk0e8R?=
 =?us-ascii?Q?NWhpZ/JM4gPmF++DMF6sESt9mGtrAUI02ea66fv829UY4ROwCttEl0Kv55iC?=
 =?us-ascii?Q?NwaeUNxAcrUvj+R9OwH5onrdWHtPWHKFkKzbYd0WNrKQgHyMdYxHupSCPISf?=
 =?us-ascii?Q?tPZeYu8F8MRiJ01GqD2O/5s1ehjutzCOR4KSeqIT15C7RX75WayBHN2EDGnW?=
 =?us-ascii?Q?o9oYkBpfTaQ3fwGCXl1nyjM47EB8OOn7hw0M2xDLc1C2dHV+V2O0b4gER3X2?=
 =?us-ascii?Q?VAlCj8s43T+Au/OnzKh6gisFrllZN50u4KDJ+LxAe+FPOX7eedjVCC3f9aJf?=
 =?us-ascii?Q?YYTpU4VZxk0F6MXZNXNAdmlm8xGHKJVWTe6ExsHl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3fa93d-cfd5-4ae0-14f7-08dd6619de97
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:39:05.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGC78vCYH7/x0lkg5W1DoN9bWFBuVr3ETzOVOlWe6xerYR6FpDsK326lT8a9twAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On Thu, Mar 13, 2025 at 05:35:28AM -0700, Yi Liu wrote:
> The underlying infrastructure has supported the PASID attach and related
> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
> extends iommufd to support PASID compatible domain requested by userspace
> or the PASID compatible domain allocated in the auto_domain path.

There is no auto_domain path anymore right?

Jason
