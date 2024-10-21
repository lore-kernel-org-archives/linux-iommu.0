Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFD199239
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532102; cv=fail; b=HNlzaWwEhrw8aM4PTR7zPa7e2yg8uP1X83Nb36UhK6SK8VSMErxWn6jyQiNYEPPsNGkChC3rL8udqhfbfOzRfr8wYPETEuircmM3pOHQKwTkjO5zX0eyuztOL23e9XRUrZxII3SJyR1Ulq80GLA3x+K2/JhCkXa2uLhCna6dEAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532102; c=relaxed/simple;
	bh=Iv+VZZPQOuRLvsjkLzc6RQ1o3hh6X+dPdkCeRp3BVWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPTgvrocapjU4MD2iWggxuogSFmH24+lfh7pmEB8Bpz/i+2Tsnu19gmWc7xRyGnVgIMvqyHF4n90uAO5smKE8R7P/6BiNE+xkKbIEqmEKWuLRg/75kBSV63VzvWpCUPwboMdBB+Bloa45gzB/sAOcJjNiRY6dNN4EkqOb1jQ6Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L2XEp9tT; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L2XEp9tT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBy/UDNEzdG2moEKI+6Hkj4xxmwaB5ZLe7Bui9qgYG6XSLQRc0qRT6aL756dJVynn+NOTBWDOj7xY+JiLosfmUV83PU7xQ2eGozfNcG8hh8xESPIz2KOlvCP9I6ZK448ZiHi26SsJpq9OZFdgn2shhQ/RmkZFUcRAkxgAaIcYEDS5XrG6v684GYLI3ABJYACOgv/XTWB1VGOhuEnVpONmbbM1jJ1hSMI4GW6c/VyivKJDhJO0oOsTl49HoAsDXnn89v6Qmxwn+2OQ1wh5ugIPArXA2QoYeUiM31a1WJ9EbGcRxJNgyruAlZ3zPROrPO85xDz9fi05GC74QuF0o34zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2yECWeUYbNiMd+JERTSOUyppUrEdkr5jbkXs+1Sux4=;
 b=tWH2Hqd0+qwhc/BQK3IrUvll17hZVQwIFq/3NGOQs092KybA2PPgJZqtvsQgN21FhYM6WK935MASXigILuXawUNtx54Ijth3NBZ6cjPpKb5IRv2It33ysYB0E0b5GanLdM1buCQi+ML+sQVUCawXXHIrPlVLBL1VHWaRGo+qKlPH78QxQFjUj2iHPouF6dy1gK6mgu9nNH8pLPu6gByghx1NFoOXhqRAYh72BTSV5NyMTfNOmwj60RrcuRtXyn+4mUojJglwCm3EEaeQ9GTh60i2zzmwvSJRdLqQrqbrGrzga19fa2r+O37i9EhuR+QjGdgZw2aqQc9YSqQLwqudjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2yECWeUYbNiMd+JERTSOUyppUrEdkr5jbkXs+1Sux4=;
 b=L2XEp9tTiHUh2OnYlksSw9U9sW9nDPWdaSmJbZnivXZsquheVATJFbbSdNggWh0mwoPFanQDpplBVio5H2fTytkkgcWCv7YCGTvwBiWs4e32HD/EHqi21sQQSUp57+Zw1kRWztebSUZtZbby+F4x4M+T7rCJUYLlO2713toelP0tSUTQjHpBmIH2RQG/9pzYEZLtnsz1D7/iwIRgCukUjF8vr/oBVvQz0KHcbkkkegyFswnG0myWOf4GQaviRs4vW/Xlu1SInFp/qmF3XD+E3dkT3KBxc6kAzAUZVyN9ZFzf/jTFywEAyvmFbnyZpcSuZ3H6h4S8tQfhOZAYsQY/pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:34:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:34:53 +0000
Date: Mon, 21 Oct 2024 14:34:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V4 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Message-ID: <20241021173452.GE13034@nvidia.com>
References: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
 <1729286856-127844-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729286856-127844-8-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:52c::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a20ada-ecb9-453b-d10c-08dcf1f6abdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F5YjkLJ6uaZThV6U71fd307f1GBv/7oJ2DmK46AIO+usk5wMZpfZVaHMCyep?=
 =?us-ascii?Q?HVjeCCuh88MkP2FdN/DwvX5f8B7Ku7ffWtOO5yeVYOFLGlWdZo1p0GGK3n+R?=
 =?us-ascii?Q?koFlAUcLx8yHy4bTjZhbN1eTaVjk6DYazckfxGg1dgitSe9k7BvrKXz3YK95?=
 =?us-ascii?Q?kWPYfMR+j75t/HW9Gdm/DimS5FZFfv1BCAYF87vsdf1D3JfOVTWYVxiElJ7Z?=
 =?us-ascii?Q?ZpSdzA4Od5KvSjrfne3Hq7yt8aDWCUxX8hY3EdFEmSEG16Oc/S19FvxH8iTE?=
 =?us-ascii?Q?3AhTuMl6m4yG74K2QnWlmoxEg1PEeMIRT1twU5Eve+Z1W+o2fQ6FtGszXEho?=
 =?us-ascii?Q?nqA2yCv657myZaBcGtqYw/moAIuj0mpNfyMaZTHtiluVrmpq65dSZh1fK1j5?=
 =?us-ascii?Q?xYFDbyEz1ptd+8/siRevnnnan0gnaCUJgmauAu5ZI8UCUDp68Di7QCIJstjL?=
 =?us-ascii?Q?UN/32VkR8l9beqkB+x4syFJkNOrfmvzJsccYbPilJG6ct+zhXfhQv50TqVYo?=
 =?us-ascii?Q?Wdn0LiGqC40mKqmnzcUzed34L/UfN8QUkIfBy/21Jy/rIMsjY9TAba8EoVJP?=
 =?us-ascii?Q?4X3wV1plMDJpNFMWBxgcFRl79xuLk1cL/MOd8v+YMaVn0CrChpIfEZ/DouPA?=
 =?us-ascii?Q?WQ1PXSgn99NsJQY+7wqd35ZT3oH7Hv98XNQu+7Iu9cMRfJlCgbmYftirViiK?=
 =?us-ascii?Q?UHeYT4+dTFTG2Mw3YAGsc3/OO+O3gr8OosFlpvYCuFkdOOjFAcgwqqvFgQPj?=
 =?us-ascii?Q?FIFEzNeWbhHPWXWTVs5OdcL+NCUwvKy9Inz3LWhszwvEJVk/1XU64i9Uupjr?=
 =?us-ascii?Q?TiReOwSyRuCNmPBRYzzTquGfyR/iI7fRCZ9aRCFJpvacZ2gMFVNsUq8rYmCu?=
 =?us-ascii?Q?M/sdbd8qCwHvVPP71Mq12q0xPUAwsp+X5RrC4kM92w02S+VszSUBnToZUrMJ?=
 =?us-ascii?Q?EgbUsFlp60vqBvSvEjf9yVKA1HMENoBbTHu7FnF+225iRvljMzC3TEaAHSp2?=
 =?us-ascii?Q?19U/ZFo8vuf7UcTOdL2dGbxSX0BdlkijdsPQP5wSg3zIJjBXPgT6Nf7XrZIJ?=
 =?us-ascii?Q?OvE9pzwFe6MdqK7y4iztkwju/YnbUtQ/ZvTo04ftMvmopEzJU1i0J5wcLENa?=
 =?us-ascii?Q?nIeUBcqWU9AStRY4kmXkNGJgpW8j+I2jQ5NTTOt581DKcvFRLGCvZimROU8i?=
 =?us-ascii?Q?oIaCMPpvl4M7ALg0aEMOBfSLv4TL1oAE1v8lQAGbeE0XQvbsCfz0CC/f4t0a?=
 =?us-ascii?Q?F85LejGTLosw5BuN7u4J/sTRYD6lCtvMDV7NP06VYqm3calDSPaDqFqd30Q6?=
 =?us-ascii?Q?SSE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zhixu3qBeMS9tn7+wHbQUdmR4i8VPbG9/REPOqfKWiYgNSd9hRjIeiDUc7Wj?=
 =?us-ascii?Q?vnqF3rEiQJQ1U72VnBKCDR2L7GD4Yaqp/T44MiqntglCh/xsGrgzZzboygPm?=
 =?us-ascii?Q?3fZZuh/euRIreEchpT+LHhvGMLvFGmzNeeV+lxcNubE6hiYPoPznxNb5fDkd?=
 =?us-ascii?Q?8hRQa9bxEk4ea7daV14bcoGerYgFEFn0mblBk1MlhBRbR9TQY14P3q2SgFUl?=
 =?us-ascii?Q?7Wf98YT1oBn2/2JPsodipJnhx01CSCmqTQSv7JvEPzmfm6r1wnn6DUvbgXPn?=
 =?us-ascii?Q?7MB3fNwypYmWb4Q0aPyambOc0VOmX8NA+daCR/rnRHBEF6YJFw++EE++l5NN?=
 =?us-ascii?Q?AL6MX96/LMOxTzEpAjcnktpmNNU4d94AdngNLI5Mz3IEWgSQ+mjSwjd/saC7?=
 =?us-ascii?Q?GOTO0ZU3JWFSKadzV/DGL79JETE2mIcbLMQXexJ+AZ2oSyw8GgNu5HQb7IWH?=
 =?us-ascii?Q?thuQ4R9y9LtmzLxdDXVGYp2AYNWXGlRRtJBbvXNsAlJ5TlvzeRMPT+hpoPvz?=
 =?us-ascii?Q?aY/rooVdDCTbkhqOXVBWh+yql6o6YbgvNRa7KzhxfWbDXn3wf+J9UB6EEy/o?=
 =?us-ascii?Q?pdETnpn/bNUqK4cxLx56WXMCCwmwo0m5kOClb7Zw3rmib/XqTL7LyOrTGelR?=
 =?us-ascii?Q?LbW93kyriZD8poFJxr4an41OLgI+cmhwRGliSiMYt9TpRSApEARrY9E5+emB?=
 =?us-ascii?Q?YFFdPe/BmjjV3VCBlSfagMAkttKauIVgxt1OV8TpYwIBYol5uyUa16KIEroA?=
 =?us-ascii?Q?lZUriQ/w2tbgW+7+hEzRmnBdgPcr3eumeKjawniGQKmfhlmjB+zuKVNKafbc?=
 =?us-ascii?Q?LOW+4BnKAZYBRxKqqM4pFEl34S/3CmUaYvCknpMEdHDKK5Uyy/+y0gGEECAq?=
 =?us-ascii?Q?0umkdDlPT7R0YZmR9HW7eXZYnlVRiWP0IhiRUzuyqslnrS8YNxNg11t09iOq?=
 =?us-ascii?Q?OzmvOuub3gFLvQ+VsRANz1wH+4LTXZYkvRa+eQV6yWsL+CUworquQa/Z66iI?=
 =?us-ascii?Q?dIPkm3OIxqZESwn/JfD+cGCwow5vAAO6+X9Wb7ENxSJ+Wohn55O00I2dgptu?=
 =?us-ascii?Q?TunvSb+K/QGPLsFxhWp+sgx302cOOiV5KGC/Syo5mXR1F8Y2eCxzvkjQ8C8q?=
 =?us-ascii?Q?qh5Sr1uGi48U0RL9Ig5A0HDyO8R0YZG5otemLWDDbz4Ws47Mo1GN30IZrQhK?=
 =?us-ascii?Q?0ng28IHgIqnVCSv+L00UjEDAS73PSAn5PGH2OUNAiGPvsM+MyRKfzl4h+rQk?=
 =?us-ascii?Q?w+h4/qua+qdyY7pUdOq2hKS0m9gjIlZmwXKvYAMvDJm81R5GEoDQfbznQlIg?=
 =?us-ascii?Q?0cBUYZZ8GUcK5yuNs1kdRAYM3uRqI9bBhZC4K0RdLpdAqzZHLBBciUCNjd/U?=
 =?us-ascii?Q?6YohSZ5c6ma3Lpxqw36Q0uQ5oyAFDt84aHN2pnsctQ8ElGNlk5A/5q5UU/4t?=
 =?us-ascii?Q?Q7Wk0/ZrXjLfdGNyIsdlmytCKL6WcBbj1ys2/Ya2vpJwBf152sNVf7PBf9Eo?=
 =?us-ascii?Q?xlh0c0ChWoHLJLTgYJFeQbMm0s1dxqEZLxSu/fj/QkCkfMkhwtYgfkrXu4cH?=
 =?us-ascii?Q?D4gM2bHyyjh2LlPWFFdRszAw2lWzM0X6e7vPSBt+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a20ada-ecb9-453b-d10c-08dcf1f6abdc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:34:52.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyi7fdBX6giBE6DXKaBx1gvgfFTQaseP/ZlM0kz9TdULvwYl8y6v4kguUh/vA9bA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

On Fri, Oct 18, 2024 at 02:27:34PM -0700, Steve Sistare wrote:
> Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
> register memory by passing a memfd plus offset and length.  Implement it
> using the memfd_pin_folios KAPI.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.c    | 36 ++++++++++++++++++++++++++++++-
>  drivers/iommu/iommufd/io_pagetable.h    |  2 ++
>  drivers/iommu/iommufd/ioas.c            | 38 +++++++++++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  5 +++++
>  drivers/iommu/iommufd/main.c            |  2 ++
>  drivers/iommu/iommufd/pages.c           | 23 ++++++++++++++++++++
>  include/uapi/linux/iommufd.h            | 25 ++++++++++++++++++++++
>  7 files changed, 130 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
