Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBEB19D89B
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242810; cv=fail; b=F0w2rP/Rf4dJNSzOkm1xxehmFilaXfBBlVoWmFkRXgyNhhwHeCOLT63a7hbsTacWUZgBQSdfgNDZgN/UtYMo84AQRbNfGGM6+NfGVjAW2yiTqB1hsTIoFDaz7lsGpaaD2PnMjVvKUdXyCF/hJEvv3i9pRJ6ZQgaWhs4LX+v4Haw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242810; c=relaxed/simple;
	bh=ildpjdC1AfwelaoOXevrgsuUUFLrdcm1chWm4KJeF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R0L1vRNgb/mckcS+6K029FKx2c/itOEx3HE+OnCVIrqB7SqbRq+9qO1/gl6zPXHwJFJRsL3f/PBh9u2wKPyRv2HpHwXFCpuosRzP8/9hBZqRsZLuBmUfiiW4GCJf6tMNv2+l1pDA1dbjUUTCscCVyNvFNbzRTad2qNuJyfqBuEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e4ZwgCNT; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e4ZwgCNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eICDYg4EBocBboLf96wKnHVoRa3cPTJ/HfbQsYuS8Yhycct1g+e3zLWMmKE0578Krcv+BGOTfLBeuyXKNxz+P5UP306aD+pxZilBj0zfvAye+1//erSlH5eWolsJpCnZ6DKuHo0IV0khQZw7WRysVjQFgAgpvrsaql/D0IxDQwCtzadv9n+ogFE9PQpT2tne9IV2aemMGZYngMuHS61ZkmdZW9HgK3lfCmtjoq0jaBcs8g0Eg4rZzJD36DbWd+xqX5lbvwCIFmchPswJyHlHBtdJHfFtQn48R3Zcj175W98K5zC0pcqBp4JeG7mvXFIMdcWPYA4Qrly7prCToEozdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AooKj1De7LAra57G1ZAZ7Uer+LoCV3RuGKeD87yEC0=;
 b=MvciZGUraYYGDeAqDoaNDVxulqYIZWxMUtJhpNpxr6+NhaVJOa4kFboNsP39GwihOcv5tAFviaE9a7ah7hkorJczizO3Qdm2i1yO+omEvj8ru0NtceFGz7xZTscWAAar5Vzv3wcKxjDHoAU5E+VhKXd+dbBiYve/C1DSVgcKsuou4tIBO7djNi7HpzuP1OYNrzpHMsOSKYh3qbR97tT0Y5/Gt4YQcND+GFXK1m//8NBWEGh6UOE/5zRmfN6J0IYSFo1S1ilWfNeKGXjUIfssbbxzoo3HGdmFPghgRAyoS0msPVxX3pUr1AMu/nLVRk6DOeXyiaxihR7FlhBhhKj77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AooKj1De7LAra57G1ZAZ7Uer+LoCV3RuGKeD87yEC0=;
 b=e4ZwgCNTYUyI1GH2gJ7T8xaeEcYgCtW7Ua6P/Jb3C932u6YQosjJ+8aBGrTO9WdD3FHYsBIKrneLh2nrZ3qZd4066WrXp22AODgq9grYa0LT2m6BgYDH+qPA4fC7TqAorm30UAPjjgCGjFUJLWXgyvMO3BpGi5n1CSMvheWE9fAc2scgLojScwr3faYPWTgRSra/qtwDAk1nWMQJNAGXhEcZR2waisQdsFeWAGVCy2sfGsHDvj+f3GM/z5ks+e/+UVmlvkrbdfZthkFrDGZF+7sl0IQgQIjJY49zAQAwtVYxqp7F2OX0t8woGfjV8SlBImbbGABQGSd2Qq8GVnPMAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:20:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:20:03 +0000
Date: Mon, 17 Mar 2025 17:20:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <20250317202001.GW9311@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6a437cf5118d17e7e4d8002ba61498ebc8376b91.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a437cf5118d17e7e4d8002ba61498ebc8376b91.1741294235.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 249bdb02-4568-46d9-1416-08dd6591196e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y30frTiI36rX3CYaWS12fIeJ4BfkMqrLK6R5cJCroB2o2dRKQLn0qG1w3jdj?=
 =?us-ascii?Q?/DrnXe1FFjQyKsgCqgLmtFTLLyz6COIEzbRTSgvBF3PKKLeAV8WHeO+ujqpR?=
 =?us-ascii?Q?wdSb28yohgOL55fpR7IQbMpW8+lbOjsUljEaODW46SsMSm/cEy0D6l1JYdWw?=
 =?us-ascii?Q?ANZL9+PNeu0YXpTTk7ikX9C1NFF1cmlkmP0TGiGVeLWdM9wH9aM1tO8sUY+d?=
 =?us-ascii?Q?XCYnXeZ+orp21f5xx5iytLayVoBqb0GdsEEZWb1SU2fl/DBn2gPrPUKmTNjE?=
 =?us-ascii?Q?S12tbPEglQrUbYYdv8leD/1F5chPpdCIzmozHyRLPdlpb9ZGrRVID5CkWeah?=
 =?us-ascii?Q?bJptk8ItMGyHSK5apNBr7l15cATq1tQSGIKI3m/YPeS7gk44lbguNHEUNnIy?=
 =?us-ascii?Q?UamJboMdk24JVY+8HjwA1hyF4gZIpYoYbfn88zJOLAIttRzSQeLNG1Y7qK9L?=
 =?us-ascii?Q?87UaqaPk1vBttjx8maU9ZOAs6fsRPNnUiPE+3nqwECYcIxFyCfclx3aZJNhu?=
 =?us-ascii?Q?JIVW9WvMyZlRQi7l5+awmDXrLYvsGZxom/E1T3qZaAMsjz2ScO96Ym8azPNc?=
 =?us-ascii?Q?1jOJZlPG6T0aQRMq264ee4Deh8ncDfsEv5G0lEKOpygSBRU/l3nukeM1mXXj?=
 =?us-ascii?Q?7iqvBRMMmqYPaqEK7wwrjFHjBIRigk1ENGp7WFZ97lTl8WtB4QiP2cFsGrEx?=
 =?us-ascii?Q?dmzxf8PqhohRgr5m73zYpdBFdQcGFuvwzdZVtA7pI5StzZ8+7hPyGl7rVQdA?=
 =?us-ascii?Q?i9VRljqTFSokHaDZoWYaqz4QcQhuQYkmt7zUkAMbv42KHAf6K36wb7Uv1LjQ?=
 =?us-ascii?Q?8zINP/UTR48PoLXZNuUBSTLDqHy+bGu9ie2ykFTFBhg12rxhC6/m7OhbuKaE?=
 =?us-ascii?Q?1T6bReYflg5lJqNfKu2aUT6LPJN1B213Zfrrplg6rUpZHsSviDiFV+WzURZC?=
 =?us-ascii?Q?GtRopgQ8Q9IBxnX3B8yRUKhGY6rJWjD9HZiY22q93XKnt4+s74sywAe1AVNQ?=
 =?us-ascii?Q?p+rKgnHR1l+gMmTlyGCeCHnox1c+zdaMGLq632iGU21THSdy78H3aVhYc+bh?=
 =?us-ascii?Q?CcYbM/cQzSRUjfZ1nSWk0oVcVtv+6bc8ew1mNHt7369sWO6gxrc9IimgGKg+?=
 =?us-ascii?Q?MTPFThbLxHq0yaNwiIlwBpdKgw9gWa7AO5SYcIhYXOx3V1InkSy3vigGSNT7?=
 =?us-ascii?Q?7iiFVhH1EsNQ+EkhH5Q2VCdtDfsbg0P0IlMQsRyDPOhjgv/LVwWdLdNXHA+Z?=
 =?us-ascii?Q?kTnlBVkQGYPx41jNupUnN0dU6Xpl/Law5uFz4gCayae7fp4rALswN75bIOoJ?=
 =?us-ascii?Q?bgmNuRhWdCukteEXw1FRZH8Tp6/6+diUn6hIsSekFwxJTyp1qrRRRPS9m13o?=
 =?us-ascii?Q?H0SDjflFlK3I/LNlSRiVkZYSY3mJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVfHIo00gjXc+zR9QsG1j8q6SknPPbi18qTZ9tjjGeGGJ7YCi1lSB0GvVZdR?=
 =?us-ascii?Q?1y1d/MDwFmmkl6THf8ZK2925O6UG+jqE0niB9ssFh/2Wf9AmLZLosD7qfRrM?=
 =?us-ascii?Q?0R9eUX+yrAWvcMj/XKUiXjj95YX3p2Dy6G0w+2XLiFv3SA4A3RSwuJUCE3J9?=
 =?us-ascii?Q?GIiwK+TVSQ5Uiuxspd0M+McF0ixEoK3D3uKen0hw1CRAcvS2r8u9+jQRbqZJ?=
 =?us-ascii?Q?HqoVBt8BZEX/t8J85+qoEfMNeE5VnYrh7FNB5mtrX8jm32MQjDf6R5H8FvqA?=
 =?us-ascii?Q?tD6cJqzZXJbXoA7Q195iXrdwsECCCz63G6aiQ2id4ghO6vyWqUVqv6t3Nxwv?=
 =?us-ascii?Q?KXT9xj512qNETG2Kmjx62nEvNVfYrgmWz8qFxmPdrKX1t0+Ci+7dXRkcNoC2?=
 =?us-ascii?Q?BLXIXhk3h3TbEGReam4Z0NgT8tUg6FD0iRl5E3HIZVTfh3YXqEuel2DxN14z?=
 =?us-ascii?Q?riMHTKyOCWm0ytj6fO0P0QX3u7hPYdNSooCUS5Or+A/pwuxB2Do0Gg+gM2yI?=
 =?us-ascii?Q?K7TZiGoKE3Bh1s+8sxSeE1hL5XBPS0D5Whmg9ieE4K/4Wa96cgydmhTF2cYe?=
 =?us-ascii?Q?UJ7NqOPZRvwhF2xFUgdtC86jcteGL8Bvw+aYaeNRWkiSU2x4Gnw7Da3uZ2rQ?=
 =?us-ascii?Q?03p4BaIaIKPd5X3Ym/4al0ezBUqFm0rzKKMcMix48sVAav5RQi1KRV0H2geU?=
 =?us-ascii?Q?p62wZuDpAe+heY2SXh0BbcD4V6Im414q+gIuJxEhsxOdGdGDs+6m2QoBCIPo?=
 =?us-ascii?Q?mjDu+/SmSZ5DghmxKLkVpBYD8GOfZ7LhwlvpbitHAaRL3HlQiI/nrAbSZ/XX?=
 =?us-ascii?Q?mJhJMPPDLhPGGMuqM3nDH0LBs2aFt0vc3BS7ew6BlwBI7PpHR7MMjpzC5GBf?=
 =?us-ascii?Q?+ojL6DU8DGbjTLTvmFE8lMHuYbqDJg1IrOIXkGSS91VuGHMIWyYDk9FFXhSo?=
 =?us-ascii?Q?ezevW1w3j8DBPRRKROdrGr7Kxr+G1juiUVvfMqLQDIYeojNUapmtovfBgLX5?=
 =?us-ascii?Q?d4rsRBvLogASR2+zoqQV0YEJBx7ITBe6ohXNyDMT6PpKKZrO2EGQQSQo57T3?=
 =?us-ascii?Q?hpAEZnQC6dI/rbs+GuwaCjRkJntlGPBQ6J155uFHWWwRkiP/XgzIbvaokFf/?=
 =?us-ascii?Q?jFTTdkGsICUcRoXwtLnW4OgEScyPY0TNvAJlJuNMi9oATl5IiKLt+TUqt44G?=
 =?us-ascii?Q?CXvpKgvJ3vScSvjz6FREQJU6veQm3qXk8hsUHXOyi1TM4ZPk0lgUmLU+Cz0J?=
 =?us-ascii?Q?Imb/KNSMBTSrgSw9o+8sMuQrCsg/PdeiQM4tfBKQxFz6p54lcM90pwnvAeWV?=
 =?us-ascii?Q?dgNOyGkmLP5rHiWAUoNN13HwmuIj1x9IBhTwx+TxdCFMkFqkLJW2juzVzIYi?=
 =?us-ascii?Q?Qm4bJRiIzZWbmuaeX9BX3fitPGjjHjZ2Y+7pnXgBHmcaLK3ul9lIf6Cdah9h?=
 =?us-ascii?Q?R/kFT+1Z1xTmtBMn6yTp9I/1sY+HtTBG+aF26h3GJ0KJ7RfwQ1nw3PPSyxY9?=
 =?us-ascii?Q?6qslwslCReZGpp/Olb9FF114QDHP6vQI1in/NMSXvQogbvZu4Yxewrx7p+vU?=
 =?us-ascii?Q?C6iw8fH48q24aGc8OAc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249bdb02-4568-46d9-1416-08dd6591196e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 20:20:02.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVaoYk/m+cgi1Au5Ll411DLYIIj3I2naa9iHEN/DM4iDOZV0M8ZQdF5RnsF/Mzsy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

On Thu, Mar 06, 2025 at 01:00:48PM -0800, Nicolin Chen wrote:
> To provide the iommufd_sw_msi() to the iommu core that is under a different
> Kconfig, move it and its related functions to driver.c. Then, stub it into
> the iommu-priv header. The iommufd_sw_msi_install() continues to be used by
> iommufd internal, so put it in the private header.
> 
> Since this affects the module size, here is before-n-after size comparison:
> [Before]
>    text	   data	    bss	    dec	    hex	filename
>   18797	    848	     56	  19701	   4cf5	drivers/iommu/iommufd/device.o
>     722	     44	      0	    766	    2fe	drivers/iommu/iommufd/driver.o
> [After]
>    text	   data	    bss	    dec	    hex	filename
>   17671	    808	     56	  18535	   4867	drivers/iommu/iommufd/device.o
>    1900	    100	      0	   2000	    7d0	drivers/iommu/iommufd/driver.o
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu-priv.h              |  13 +++
>  drivers/iommu/iommufd/iommufd_private.h |   7 +-
>  drivers/iommu/iommufd/device.c          | 131 ++----------------------
>  drivers/iommu/iommufd/driver.c          | 125 ++++++++++++++++++++++
>  4 files changed, 151 insertions(+), 125 deletions(-)

+1K is more than I would have liked, but OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
