Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DA2594B3
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947360; cv=fail; b=rtraa/TRGHl8PBiwD9jSA2UT88IpU2bwvgMePZyvOCsTYfFyioFlIO4Ts8HQMHCL1r+Dwv//yETJeC7/UsSvtiX8pbKPRPqRMrz6dxIWyMQNAkxNqsBaFBd1w/LDCp5jcwHRCg4R12Ik4RC45Ud5JHbh8/xMIdv12sXWPEZ84c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947360; c=relaxed/simple;
	bh=/wh5jCh2w9G2a32N7JADGaIPl3kqJHwucI2/D/Hkp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XpZaHMeM/8SFT+TS7iAyFsNbLWP316GUxwsMMWAl60rwQ60LMxuS3eaqT86+oOmwB1OGnQlEj/paY7/ydVfXo6ECeE+atJYxmrZW3bTM89ZOgXpdywrHlXQP8fVmH2HKljYH6x9xWLOLfs9hy4DS83oWwt1JhA3sohGmF8UplfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJQcW/OQ; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJQcW/OQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHfnfV1r7l4OPGzS7L/eARt6QuHHl3UuixB6mMi+cXMhhcfyYW3Iyhh3lz+96SzqFBhMtQJeeOdw3loRNV8lWNu35KukOpQByoq0KLe6oZcbK5ruj1w2yBe+WOjlbKSvf1e8aMYdpCiFRTnMbNpm8dfX5Noyi4lxgjZQ77E8jaowE18hOrhEKxEzbWSM2p4kb+2T0AB/vJTFUKfghfGLS+UoqYKdbFVq2pF7VbjXsV0l3N4MTsmih17I2fpNaXh5Oit2GEtjXnqL52l1Iqaed95D15iyKnvKNzEXafznzdvgzL22r63dO83EYzEphWbbv5USlBbiRi6E2153ikQqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12+s8kPX3VfQTyxULxkxthhH6Qv8aHCuKeWHlJLzWiM=;
 b=ScFOwbxZ38KXUvo7fVodKcapjRuP2W6uHl5qOShfhm7jKeEUhp9J+eLeSKvJYDFKcXlsCYC+Yh8EhBaSGk/MjFDAHyWc5m325CLL8DPb82LZE1kw0DUP6dBmMa4W4b3NjZgEmlgun5Myme00v1nzFazGDrhTsThado3FCdroh2OiLMcASYXfDjD/n10NxMQT7IO9W7EDH4u52rNGRVh0pgOZn7iDKOscNt/esu8Fmhh6E27OzKdc7TAGTm+nDF0KUHsTei9qG6w87H+QtZeoyhjCsX4tMIgApXk5F7Ye1mGYMlFO/5YC+MxBvJeA8z1cMHfZ/y0bW/Y0qPw03KAtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12+s8kPX3VfQTyxULxkxthhH6Qv8aHCuKeWHlJLzWiM=;
 b=gJQcW/OQBIQG8TrFSUpgKmZ39gvuqk/Bkwp9VAf08rgXScW8ByWow1PHM59/lyGTv9d2T3OXScUp722QT036d88f8bV9G04LAuXWwHM1l4dagU4WYuUl1scrv/XLrwxHq5+4OkzrVkhhYnjseJzZUhfsl9frXaZ/fIZb6wwgmMmh2nRJVsnedEdrqDZfOAkIWfL+8rT2t8DTyXaBdNspfmZ83oNajA/TebrFLIPv3rMu2hzGiRw+8Gdfp35ufaC+WygL8FJYZEmHcukq9oQ3PqaGVgcPIteMk5SaBdeQKwK4egZvpQTdrsVcI06hOCAlm3FsWEd8RLC6v1ZVGty6VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 20:02:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 20:02:33 +0000
Date: Wed, 11 Dec 2024 16:02:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Message-ID: <20241211200231.GQ2347147@nvidia.com>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207120108.5640-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL6PEPF00013E09.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdc3c74-959b-4f93-bd06-08dd1a1ebfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pSCQtcuS+c81Jif1M+uCIGVnBMCMKLcAT3wwBRuRvofIP+am3oe5C540asPi?=
 =?us-ascii?Q?9AxwVOBvLjrYRSW/OE1+R3Vc4vJx3KqytQio9b6uVNu249G4e2/tThpgmN7E?=
 =?us-ascii?Q?Hz/Qzk0OUeaj8sKkbHCKxcSGjiQ/ziVaBp+OpihbB1k7iLvnE0O65rqrYGTJ?=
 =?us-ascii?Q?IbDTdcxEJTBvo/ZYop132marBh4ezmPr+X9YFETXtI5YxD47MCc1ygJ0Uxpt?=
 =?us-ascii?Q?30QnhMGtc81dvFoOtN8N+eNGCXQYB5Afq0u/6KRVcWDoH01MmHitFzozlJp5?=
 =?us-ascii?Q?U8tHacX4QkJF7jLutcuhdNd3T2Wvf62E2qb1HaCFj10YJoVhyO+i0t3UUYjg?=
 =?us-ascii?Q?vCqu2MBLgHhnDoyqbvUYYC68GzSNNiBYOj28TsBFyeepEGO+y6p8h5Pms7I+?=
 =?us-ascii?Q?lfafZmB/IVTAa9y6Ux85eYbDFsesl6ThXAMR6BYBQe7r/TI8Sf5h+z7vR7ZS?=
 =?us-ascii?Q?R2dQyalBHWIRnrhLlbTVSC5g7AiDhhQ7ff5t6J4xXBLE79GqfXkt16n8qsns?=
 =?us-ascii?Q?HTC3gWefdvL1Jx0afqd/w9zJjb9CvH9IaXlUv4sLVlgB2gKvJeFgJpTLD/qW?=
 =?us-ascii?Q?qczXYKP7EChJgsTsgBum6GK5b2HBxLk9dt/0dqcQCexMDgR+SH8qdw9mICwS?=
 =?us-ascii?Q?MBq4+zY7i50Qh7CVjF4kD1aIgg8PBWMS7rHCG/95oOGqB06K57Egs1WcOO0p?=
 =?us-ascii?Q?bsx6FEXVH+Cd+7705Zy9yZ1fqYzEDCf3VSK+YpLyyIMldX95fDq/34XDUzeQ?=
 =?us-ascii?Q?USG5qdqMulDtTLIqnI9ZZpyeNtQG9RKrm64DZz9Zx+9ylkZg/oKWaP1EWDKl?=
 =?us-ascii?Q?1ylD9witcH6Wxqw4528fYQYVCohGL6npEz3jO52KoFmx54/Dl0nS6AcXP0CZ?=
 =?us-ascii?Q?XfUTLN4K3OVhGeKuEVGwVIYzYsMt8DHAuP0e9+zC7bPE7jlOiovzmEHwqmg3?=
 =?us-ascii?Q?JQVbjsINfrFd+/VO0Bn28FxlsTN6zQ7bzBL45IovuEpZ9JhffSMHDeYcM1Tb?=
 =?us-ascii?Q?D4bmmdcHFutNX6PKRCjNQwKy1hbNEJGOc4YQJQ9aWqzr7Pj3lHWXyYhcXOIu?=
 =?us-ascii?Q?QgKLG9vROBDmTAToMRVwncBPsdJuOhAifGtbNnEVeNfEHpPcCAFbdiNQQTGi?=
 =?us-ascii?Q?w0f+SkEJV969Ye59xoOxABNVt9UcBkKf1VkGire5YHINI9NUaRRGAlyBD03z?=
 =?us-ascii?Q?YDfuAjco6WEzOfyELL7K2u6LuYvBCUu3nfDfumXL/Sxyvq1NrssFCVmQLOUm?=
 =?us-ascii?Q?YcJFp/VekUMSkSsZ/MLZa/WBL1RiK/V4APLfL7MW/IEHlsocEu80DU2uKpmj?=
 =?us-ascii?Q?F2aJpZLd8il/7DeN9IscZGH4tQHbjyvNmEOZXszAukB1MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avn8xERPG/EB3Y1l+SMm7tdJRIfdb01HDmPCYaBeRqYFy7u8fitf4EGoEwDn?=
 =?us-ascii?Q?sBo494qEMqCiTbsK+HQvV8bgNaqc0f9WzKXgJl/CcQS48XYT0sNPSbOUjORQ?=
 =?us-ascii?Q?Pz44h1hROc17aiz6WXrbf+h+UwkItmfZ+TlgKhq0yAaR0E+JYjvJK3aJ5SEX?=
 =?us-ascii?Q?Ia701QMwXIRB4V5+TrFFwiXqXv9iVEd9OAse0wn8nPw108bwo9tqhErgqafv?=
 =?us-ascii?Q?uppACm/oEznjXdkw0EttYMF4oaR51scVj9J4yJXS0UH6MmrkQnQL8ytK6hg/?=
 =?us-ascii?Q?AEh9ftmQBsaMO0jRVpV3sfCySmm+itI/2yjW3NYjaBu7xq3+lzuzpVGCT3Uj?=
 =?us-ascii?Q?ZG2FJlQsbDgJ/SGqGafTKraixRs8XaUSOybd7gBAA3aUCfTnsVDTUNBMNolJ?=
 =?us-ascii?Q?n1xhgLOBKedg6z948dFdY5kuXOW7OV7f9Wg45I5RpKdLiUoVutUadk4oG8dg?=
 =?us-ascii?Q?egdmZ/Kp9E2BCT7CQbzIG3Lj/XnHzW/3AMZKdBGvnxc4KI1dAt+ru7K/1qQF?=
 =?us-ascii?Q?H+p1ejEkqHLaPmmq202YYSOZ37oR4q9dxPIrHiPEKoVzSWrBzPhY/Wrlkkqr?=
 =?us-ascii?Q?kIY1h5Yb7NzoTWBdPPBuXdV+B9xXDovy1iWbsJ0kkkBgWnBlh3HpNRPO31Mi?=
 =?us-ascii?Q?Vdan1ny9LSFyUdH2fHvXSU/mkEYGliYLYdyLX+nnEP8I6roa/DYq5ZWl2eph?=
 =?us-ascii?Q?CF5dIac1c/rwi6N18+LLsl9+PnZQ0uBYG/98jHL4oycjmF0zBQ6Rzw5U+6KR?=
 =?us-ascii?Q?8t2SPO/CwitgfzBc2QSEKatpTvqN08rZRYYvqvaRWGIpTfIuTCH1ViF9wDNG?=
 =?us-ascii?Q?9UCclhsQCGPXmmfDUFU5WioAMZiHtC0KmcxbmWT5RS407Ul/VfK9wFhpak5k?=
 =?us-ascii?Q?7ArN0Gv+25zCxDegfDptHy8WoK/buzYDrmtutcI+8g+h3BPU14FChDoz46TQ?=
 =?us-ascii?Q?gOZ16iDquIVhriNru8niYlTnCVbc96t12MjgkiNlRaBrVjvjg8cehCsQ/drX?=
 =?us-ascii?Q?3i+oXXsMjW2/KMYuKYxPP62hRciTEYR32OuuQf00OmyyfbRvYBdO5ozXxI98?=
 =?us-ascii?Q?a6T+RYBr9Txaq5YkQX2699o57UYvbVimtIIPIoYJagEptYMguvU8mnxApS/y?=
 =?us-ascii?Q?eiNRNrEHlrtr+PYPZCOgWpKyBgfd1Ee0AkPfeRkQd5/4T1gnqlkH1/myyqIb?=
 =?us-ascii?Q?YDrlxHSkBBA1cKoMe1AtR1bJcWRRyNiRAQkBgPilzUo4jXnRZArcxPImnMci?=
 =?us-ascii?Q?tTZKKcVfdHI3x6zUT1n/nZWvbPioZsPqaHNuwA1Vqy36SKq/5cz5gB9sq6V+?=
 =?us-ascii?Q?vQl26EeLH/MOeoSj8z5vOxAKuQwaDKwkHlHiltgnvVYzSNu24Gx1aSUG9Ego?=
 =?us-ascii?Q?F+2rrhJ7FRSfcuPrk6GT55+60jovcy6+uHYXDgwWUkc7b4mbs4iIuCFEGzit?=
 =?us-ascii?Q?cArYu38MOAzBqOFK5dTkWU6917LIGK4V3b1K33lyMGPalxJVjkxDl5QDtAM1?=
 =?us-ascii?Q?sLp4Hl+6aCS0J287eD1REPGWRzvXN46Kaq/xlSjJrNwhk29Jk5Qi1N6XiPrx?=
 =?us-ascii?Q?CVZMIKr0EXKlpr0mr3s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdc3c74-959b-4f93-bd06-08dd1a1ebfeb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:02:32.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMFqsnpEd6SGUYZ4+MOlQoOJo/RdXylutoPVTKBLyDWdhEcF/GqsTJzCbdvefFgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

On Sat, Dec 07, 2024 at 04:01:08AM -0800, Yi Liu wrote:
> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
> the iommufd core, so it makes sense to sanitize the
> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
> before passing the user flags to the iommu drivers.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  8 +-------
>  drivers/iommu/intel/iommu.c                         |  3 +--
>  drivers/iommu/iommufd/hw_pagetable.c                | 10 +++++++---
>  drivers/iommu/iommufd/selftest.c                    |  2 +-
>  4 files changed, 10 insertions(+), 13 deletions(-)

I'm going to take this, but there is still something missing - drivers
do not check domain->iopf_handler during attach and will happily
install these domains without any HW support for fault reporting.

Not sure this is so great.. I suggest adding a flag to the iommu_ops
'supports_fault_reporting', as just a global flag if the driver could
*possibly* support this. Core code will fail attach (and maybe alloc?)
if it is not set. If it is set driver must check domain->iopf_handler
during attach against HW capability.

Jason
