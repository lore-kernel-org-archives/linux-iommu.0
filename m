Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E772E9726
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586767; cv=fail; b=ZIqQzdeVUrkJorprZk5poATXyLYa0MB2mxyErXP8yD9N/XfQ3yXcIujED/LPerSnI2LSLPr4qjeUtjpU7+uXdORmrBEhXSR6QhCHXihV4j1LdHFQ/9fAyOPRG8WO6Pf32hpUvgIAtKeFP0OS8J6vJvqAuJfRCompDBJz3DpiLjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586767; c=relaxed/simple;
	bh=kohWxW/4+Hz08AvbRWH20IWkZ2kYyyfa8S9RzDv/ZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=irtxyn4OGFDGhewnTf8pDbeK13wU1RQESgynKJda61iFPD4oOw/rS86oj5BG6lbzblObyilcyiHa41LrDwjUrHb9JzwjXkplGRGXfgIRMusxx4ecj9RugC3Ihe/OnPAjCO3APKo1ytldnXNYzL8aM/AzB+48+1ZGI2UZ+mS5aZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umryAZhV; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umryAZhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5Sgq5GRUD37M9N5Umj1RcwSjho8aQChR1f2iCDUSm5xGUme6AxgFdXlSpl5Kvga2cKVm0rKrHqbgJ1MkvzkrDNoIylGXkUELw1RpUyZLp5UiW7/5lCz/Wr0Svae58aUo3aMCaP0/DazswG0m5xOQVXWvSGZYTSDACJz5CxLUf1FT59AYn8uHWYDtRRXnI6vtMF38lH3VNcVZ/8kq1c7WPxX8S+IRm9HUCXS0eatGb3eXngxJRrX4BQCJTsVfeXedB07HRk3kqkN1wv3+V/F+ivfGfMtEiG0Xop5qqvkYnc4DcNBnac1/3UItIdWOYYDaxxAFdSGXZHi5D0qtGhfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ntv1XM9tqcLKgMqN6uj29t1t2VfoqwCQg7+d+BFvayU=;
 b=HazJA3cM1TflCxAoekbV4LtSqLt2fzvHuYHKzYwtvDTGgH1JnZPaH5T61RDwcup0XLok+7e9M20EwcOlb5zIZ2wnzIJJk1/1LHrFWJiGOo4ICULFWLNUpfIRXIMNOJsn1186uXA/2uGXrPZzKg+7KAwwc2F7skK2ctl8+0W3NF4Y0vcvuHHw9Q1G2AWTKH0lj+CZ2zs5hZ0LCRP2b7o2VjpQiHubHaibsatvrWXIu5RW7+ZNQ7An0llxPzyrlO1OkWuiluLo5RuyvBBJx5lg891LNZ5c/Lu8k+VKDhEAAoN0EUr8t8+PXDJxGl/c0zSTrkBxDqkMPuWws8g9h+CzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntv1XM9tqcLKgMqN6uj29t1t2VfoqwCQg7+d+BFvayU=;
 b=umryAZhVSyQjQb/jqghd/7Go5udjLIaLD5WRpZLOQFx/w6lJoeJFZKMAA72nbq2X6BSZmka5AuMBh7v5jRddI+qpeVleS1HQkAUKxEiejaGh90fg3PAv9mCk7vEctte1vOdfqOfQQVPtNtvErMbQmQFLavplgycR/GGBRvW48xEIHPZfkv/1jPAbhmhLpye/1Xi6T7S11CnZB27vRc/ZTebJLcqff74+oQJ2GqlOWvIJOnASj3rdFgVUW9+rR+N7HxIc2mofJe3t0hwxXpWVHElP8YzlMfhZH8prmmhk+7B5bCpBYdUc3vaIObakdKHriaVd5tCCEejUBIHQxS9qGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 15 Jul
 2025 13:39:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 13:39:22 +0000
Date: Tue, 15 Jul 2025 10:39:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 8/8] iommufd: Rename some shortterm-related identifiers
Message-ID: <20250715133921.GQ2067380@nvidia.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-9-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-9-yilun.xu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0fb7e6-90c4-4ec9-1109-08ddc3a501e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zz1lQ1OZU6b0P6D2RWMBIF58PWXdr8S74Uscu/XTBCwAQulXh5xYm6almex5?=
 =?us-ascii?Q?RjC1XUr4Urvgr5zipODnoy06xcRiSrNsDQv4/85SGOOByyi8YE8UjJNvcr6Z?=
 =?us-ascii?Q?UlVsRxoJW6IsfZLIkIZ8lRAnlRVZAwCURCQDYYWpEDpCTI1jkx7rVRUum3NT?=
 =?us-ascii?Q?Xm7syCIGXY7KkkoaBJ6XKxwZa90TjoPKzRgbtYZ1pIE4vLoCvWFDUcMU+s/r?=
 =?us-ascii?Q?bt0JO3C0Vdl3ulywynVNvQsgyEedMjRUvJ3a9cJ+hrXiuY2F3y7Ef1SA0vQw?=
 =?us-ascii?Q?kNRHJfCSP42xujqGb8sNxmsYQDFAURzcHuEqGyBnTwOKw+WHwHvNo9CCkfch?=
 =?us-ascii?Q?Al3URFUif4IeTpcAa6UU8ArwSCjfSFYNm4Xac4DUSygHCGAWWFnmuyak5iCl?=
 =?us-ascii?Q?S7LqKG67Pn2eWzWrYpKOftzh5KuBpetxhOA4NAKwcr7u/eXMrMA9NGCqbklL?=
 =?us-ascii?Q?RW2/MmNNCWMn7xSjfb3Av+9vaDOrNiThsPEcy5Tzw8p40/CmtiC4bT7S34QN?=
 =?us-ascii?Q?JWPQ8FB88Tu7E7esWC+ojmSSodYvBfkdqA3iQ1ilgm6P+I17rOD0AaKdy3Hq?=
 =?us-ascii?Q?sFcKzdyfo7dTglUv95CX15B1FpdeeKowAFWQeSqxg8hleFgJdJZVsXR+f+r1?=
 =?us-ascii?Q?PcXBo1cN233vTY4bLQff//Y/oX5d3XzjyLvqW1QbfTE3kqBHriLu/pFYQsYV?=
 =?us-ascii?Q?tZe6suarwCS+lNCm9DlhCVFACbSA7VgyHLFtIA7PIfNVdgmr6wEuKJOOEBWM?=
 =?us-ascii?Q?DCLCP+5syu/mIrBmiSgeweZioFiN/nYLGA0HNhVCa7Iu3MMlXJMYAzqyd0Zd?=
 =?us-ascii?Q?Ik3in8gbi7n+sRQFqGCY6j2JbM2//PJmI6etySswiY8uK4x8HrSXKwXz2fx9?=
 =?us-ascii?Q?5EAAtPUxa6vhh5BV7GQJ0IajInqKHlRUcuEmAoY58v1StVqNbaYXghdGWwwb?=
 =?us-ascii?Q?Bcv1qlZq3Tyy2z7/R2CU1XNJ9KHMc9rH72v+41N/cqhF2apx2oGwqhtxu5lG?=
 =?us-ascii?Q?zJBJISBnQAVoK0OcYpmeon9UYkfbXvXLGqJ+tG1MW/G7UQCRuYq3SeZ76CDI?=
 =?us-ascii?Q?zdKAZeY9iruRSFFRRUd4P3b+8oeaQ6d8Kmap0Djy7Ms/WhahR0XrJGjPgvIV?=
 =?us-ascii?Q?aw4dKXH1v6oq3Q2toRW7DvkVBIAQ331Ngnf07oI9DxzDOE8Tfp7rt07Ryhky?=
 =?us-ascii?Q?BVWo+Qqk6+Sh2K8y5E2mKJIl9gX5IvqjsYLd5SkpABlNoHuQs4Y7Lz9RpSxr?=
 =?us-ascii?Q?0e8Nl9Uf3PyZcRxao7KQVf88i3sKpUxtagjQzJf+kwE8DQSB8aDjFEBhN11n?=
 =?us-ascii?Q?APvvuYzU1QLnEdrbE8nt1A8Vkgj7/OdvbQU5PLqKVrHQoaYpgVbP+2DubCJd?=
 =?us-ascii?Q?RJ0bv9eH/XRnna93n0d57w9TBuN93t9IiTt7TpzLpQoD+o3m08Ca6sT7cXMX?=
 =?us-ascii?Q?IoDKVoijT/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iw1a3m5/81W/wy5cMk5Ch4d+XUkF9GVGQkuph7E03rV87AiDeZd3wPTK5AGs?=
 =?us-ascii?Q?jBkfeMtTMt8GrtDKYkQ75e2aMAWLzz6mXUDe4PAedbY2Xq4PCsYXwdEqWK8G?=
 =?us-ascii?Q?Zn6CpkDDX+/NyZ4Qi2qR28RgG5hmPLrDYHyIwIcMKYRO3F0olTe6p+Ib5Vwn?=
 =?us-ascii?Q?SCw8lalQ91jyWtoH8dBVPFri9xDcnzn0xMD4ejU6x2xTV6duzt/8yW8qT06B?=
 =?us-ascii?Q?3mlVLZ2tvPUlRFq4MjzybtAdOMno3U4eppLH/EUC8HcPdPU+oFR/h3maobKi?=
 =?us-ascii?Q?zLMcaSYXw488YLf3e873b8aQRRm3uwUzXEtwQTOh4wkhuDzbp62KG94wZAGC?=
 =?us-ascii?Q?iyK2WO2fNBQC8Qt+7CEzsgmTrlS248gEeB2OEnc9/+0UXY+P+gGWY8bs8b+V?=
 =?us-ascii?Q?eHq7JyF49OodEpCvfd8wB1iOHIExg8BIh4Tb+aOryYsA6Rzl6jwm4FSNjjs9?=
 =?us-ascii?Q?MCsj4yiks6l67W1lj86hsF7+pQbJ0EqVRvRRUwxscuVZKT20DkGKYhGXPN8b?=
 =?us-ascii?Q?cTBNd/FZ6wbYntbhSAbG1z6kf+5kfe6Ff96FiX0+Su2K4fkrqTV5jGcYT08v?=
 =?us-ascii?Q?pdd1Z1LY/DRWL3AwqS0Sgj0oK9O7A+OavFMHqeR1vxUj4dIs95aNaHjH4arf?=
 =?us-ascii?Q?C+S3IA9nyjmZKL0TpH6d8cDT+TVoanRP0btWAvqy2SHXVbmGmsFAaj+EkqsG?=
 =?us-ascii?Q?ZJEf2XfyHyet8TjGz2GU1Q7fGrYN1XQgIu0ARV6CmSXEQHJ7lMnfgkeCFs0z?=
 =?us-ascii?Q?eZDZk7+Zu/LnOPsRKGsfmtNy8Ud3r5IPVgDiUShMeKbqQOQ3UZLPTMdgjhjl?=
 =?us-ascii?Q?2rbA7uBAnAARznRMxLcp1hpNnEw6Ctdr1+llXYG7JDTtzAH5Xz3KellMmcCq?=
 =?us-ascii?Q?viDsH6imcblfoq6c7Qn4hqioEZAI2IDniYr6g4XAIoqw5qAq01NA8z/yUtH1?=
 =?us-ascii?Q?QDH8aVzLgkPAed33dhy3KHFD/yqX4OGDYYxY316WUNOM/kMlqCVXIDXayISH?=
 =?us-ascii?Q?U4SQJ06SIQqOe5vaps7pcIWryFdkGxbFB1zwlmo9ScGzKiKccSG1WSzXRv5t?=
 =?us-ascii?Q?ZrMccrBVBxT3IxSQ705146Lbenz2rv7duKTrujYMiQ8WTNwvQnwFu8ssBhqZ?=
 =?us-ascii?Q?GW9DFPQn9nSSsL6BPwhlca6rW0jaMe8hRcK8k0KYJ9Btgwyg3QunetQHUjTf?=
 =?us-ascii?Q?JLLTfeNpv2DUrRZHAxJP/2Wfi2AyjSTc5ADEdaYG4x8o8YSTvbLC4NJdXrR6?=
 =?us-ascii?Q?pqlkKtH/azjzyXHdXUL+qjXbcXT3eR49PRZWUlb/RaoJ+HcDriFUo08V5Z/g?=
 =?us-ascii?Q?bh3ebOIO5KGV3ZTz6AZbDWgMQXcOUJ+7a2NWv2FNnntDinz0c2U+ieB4TuJX?=
 =?us-ascii?Q?gORX2k20K+qsaeTaFSlCwOpai1cHW5TkSNY82v/2wwn5zY+nByiBM3gCK8s5?=
 =?us-ascii?Q?hxN08+zBrjWxhpBDMcvVJCaM2KnGOQZ5TzcRkzsWMuwSQvnjX/1JsuM+9sOO?=
 =?us-ascii?Q?Gp8XS9SoAZqrbljR3G8BcAzWZnkVWaBWcFnaKXj4Mhce87RmcRgCNTa8YmPS?=
 =?us-ascii?Q?L9Uj+7uwa1L2dL3ijDSocWAL/cjLCwGle46GgLYu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0fb7e6-90c4-4ec9-1109-08ddc3a501e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:39:22.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeI6ecilXUe1Hb6teaTR532fS9o4XrlIx88Wtl3fEbeOZbiloFZsRjmYSYQxJ3iM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

On Tue, Jul 15, 2025 at 02:32:45PM +0800, Xu Yilun wrote:
> Rename the shortterm-related identifiers to wait-related.
> 
> The usage of shortterm_users refcount is now beyond its name.  It is
> also used for references which live longer than an ioctl execution.
> E.g. vdev holds idev's shortterm_users refcount on vdev allocation,
> releases it during idev's pre_destroy(). Rename the refcount as
> wait_cnt, since it is always used to sync the referencing & the
> destruction of the object by waiting for it to go to zero.
> 
> List all changed identifiers:
> 
>   iommufd_object::shortterm_users -> iommufd_object::wait_cnt
>   REMOVE_WAIT_SHORTTERM -> REMOVE_WAIT
>   iommufd_object_dec_wait_shortterm() -> iommufd_object_dec_wait()
>   zerod_shortterm -> zerod_wait_cnt
> 
> No functional change intended.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/device.c          |  6 ++--
>  drivers/iommu/iommufd/iommufd_private.h | 18 ++++++------
>  drivers/iommu/iommufd/main.c            | 39 +++++++++++++------------
>  drivers/iommu/iommufd/viommu.c          |  4 +--
>  include/linux/iommufd.h                 |  8 ++++-
>  5 files changed, 41 insertions(+), 34 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
