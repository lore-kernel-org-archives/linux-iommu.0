Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71313AA41
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730345685; cv=fail; b=pblSC18I1XLl9y4VkmzxStm57CYusd8qn6BkUh+kgv9eeYhWhvSZefVztnr+vmsnOHvvD9ziAb2D8PF6AaS5o9Gvtc75Jo63k4eVRHF5PbsvDjdUwH5G0Ar3zSJ3GOSPlYOJTYcGxvoxJctkjyHpQ0JcuTUMLCf9LFSDu7bFR5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730345685; c=relaxed/simple;
	bh=mLWbDA/ce88kiFvC3YrDYxkeDfBciCjzjbf7gN6G6lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbER6ioha4GQsufmGyZKvgAj94SzyNqEUJKth/g5myEqMz2FWw0uxH+rw5xY7dwuMagUS63oii2px9H6dGXnQ2UCInyyY65QbRWBK0h1yeDF7pT6iG86ZsNnc+IEaX1FQEgidfJKr6BSUn5yQEyalnoui5YJ7Hw32fbmuXe4hEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BPRATSWU; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BPRATSWU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC4YiFWCotqCoMkmUv/yErhsmwOBJbcpeJUm298YqxtaELw4knIS2JbOKkKARvNIIccrECExxh1mWDtLHHkCfiEYwg+2FNvTIw9nNmC9O7A8qI/iEiMvwlIGi9PYHfVYztov8r3/V4HK1Co4X/ZVmTXiHSwp4V1l6M0ACdmiRmPE2sE0v+1y1XSLOr6GlcMh3RFOrovx4XvbDdyYlwx0/88hnNsBaAgz+meTr12+0c+5iibg2H+E9VjP7X47yJ8WOj+a4PwOWWUy3Eyk8r+6UalZyfL5iXAcEKS1bfX6F4H2WmbA4xDXy8n3IV7JyqZjplnPufXQP33GhYOCJvcHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KekNDGjZ30iFo3PMUjNs9zfyAnj5lXari2yJzrmSi/8=;
 b=ohjhump3GbZWlLQuWolR3t46ew1bvQO2v41r/9doOVj4xC+F+RIhX8Rp9YuP3zeWjVvuFSrH/XRYwAU5Ttsmno8HtShxXbihChYqRIQJNgQPQJR+Lbm6Qjric9akPK5Zef/ZZnM0ZUbzQKrBrI0cUOd8xrqNvDBLuHZdrQt0YjEnAVvaEJDze+olpAMpY1IkWQZaZexAP1ebvE7qpUQud7oRbEbZHcH+wWYzUB7WsectNEBjgxC7/0DmZ3rOqZ2lT6hRYj0cL4Qpdk6t4z7yu979uHmUPvJnGb7skQQVXvGcSyf53dmStv/YFn4Cz5o4HZTvgCQQp3o601YsvNaCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KekNDGjZ30iFo3PMUjNs9zfyAnj5lXari2yJzrmSi/8=;
 b=BPRATSWUccDVBOr8B6l5gy0p3HHHMdQ4dMxSCB4l+Jtfhbw0Q2h6Roqr9xF49ibpCkhLczWn4TL3w7iNIEXeZf2EA+nZbhJhkIUB3UpX88mfiB4mPWkvPp3zsS1pqIV5jtxpG6n31WCLrwtwkat4yTV5YGI9LDA4dJ0Tj1JwPbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 03:34:39 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Thu, 31 Oct 2024
 03:34:38 +0000
Message-ID: <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
Date: Thu, 31 Oct 2024 14:34:32 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0159.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::17) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb8571a-ecc4-4271-cb93-08dcf95cf2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T044a05ZaEVMcjdiazBLZk1keG5aeGM2b21OSVFIdjlrUmVON08vS0Y2ZzRi?=
 =?utf-8?B?Z1o4dWpNTEo0WnJ5ZE9Fbk1iSkZCU2VSVFh0WmxvRWJTUnpjdmZyVnF6V3Z6?=
 =?utf-8?B?Sm5PRS9jdG9DcStvai9WRGpsNjNFL1lIUTVocmZqM3JlSGN1dVNNcmtScU9N?=
 =?utf-8?B?WGhLbnFCbTNYRHBxYlBWY1o3QnJla294ZThiR1IwUDNNdTVhTldnbEEyWW9y?=
 =?utf-8?B?aW1FajI3MktlME04cVlpdzFuZnVWeU54RnhFRTVBbUlqTnFBbkxxNUtRQW13?=
 =?utf-8?B?dXl1T21Sc0RaSFlzRXE4U1JpSFl3bHd1Tkl0dU1keVc5V1I3bzdtbkRCVGlX?=
 =?utf-8?B?SDZLMW9qSW51dFlNd21DY05kWXEvc2FsWGN3Y09IK1kwbG9tZk1CSUphSi9H?=
 =?utf-8?B?QWswR21LZkJSbFVLelFaYzQ0cTczQjVDazVHQktUdWpnbStaa3R5Y0lJd25C?=
 =?utf-8?B?WkN1ajNMSWxZWXdxY3BrREEyZHJjVEY2NXdKTXVFV3Y1T1pSVmZPajYzWkFo?=
 =?utf-8?B?Rlc0L0RXSDV6djZKT0tyZElPbEROcGRzOWVpb1RmNlMrQWYrdm9rZlJXeEh0?=
 =?utf-8?B?YzFYVnROeXhmTUpOM05aaU5ERUtaQ3JNVUFva0JuYnA2RUp3Z1YzNmVodFR6?=
 =?utf-8?B?WVVFMnV2VGVKVHpRV2poMzVOWGpKOFpRN3lTT1RJQzlRUVFlTUVsVGVWeTA2?=
 =?utf-8?B?aGd0OU1OdmhsRzRBblFBblF0K0xpSGs5MzJtc3lYZUhDY3N3ZElGUFg3TW9P?=
 =?utf-8?B?ejZwSVExak1SYmU5WSsweHN2Vkw4L1M0ak9hS2dwVEZ4ZFdqejA3V2g5bGts?=
 =?utf-8?B?RWlsRHAvemk2cEpqRTVDRUhzMnJ1WTZVd2Q2RG1pTFR1ajF5MG4yYTFiWEd0?=
 =?utf-8?B?bWp5dnh6cjlja1NBazhkSDBPdk1tV1BRK1RHMEVEVjd0aG5PZGk0L25KMUcz?=
 =?utf-8?B?QzF1YUVvWEJ2cFFYSEw0d2hXd1VDTC9tUTJnOVFLa0lJeWREa0xrWks4d3A2?=
 =?utf-8?B?REE5U0xUZ3dxU3VxMWMvTm9JMk00TzFseTkvOUNXQXJnNEc3aWZwKzhkMHVt?=
 =?utf-8?B?akJyRE1hUWlxbk0zL0dtUzAvUkVVZ0dJYStIekxtZjVNYXQ0OFBrRUVRR29n?=
 =?utf-8?B?bkNyd0w0NFNHVk9WTTNabmRHTGs3TVQxZDVKYTh4L1c0NFhWUDVnQWY1YkZB?=
 =?utf-8?B?bHlqMW9sMzIrY1J0OVhIWHdnZUYvK1BrY1lmTlRQNDFuZkxCa1B1bHl2aldv?=
 =?utf-8?B?Y044TVBDaTRMdEc1Smlyc01WeHJnL0l2SzVtZ2UwaFB2eTI1TGhaYVdKNHVX?=
 =?utf-8?B?VmEzdTNEWkE2Tk9PZmhZZ1NaN2tPcWxRYXl4Yk1EcitCNmVGRFE2S3R5enYz?=
 =?utf-8?B?NHdqditSTUttZlF0VEpEUk15VnFINHJtZUJDa0FoRFg5Q2hqZi9hMU5meWtx?=
 =?utf-8?B?amFnK3Bhb2V1Q293MXoyZm5BeGprdE1kL1JwZUJoU1R1RHBjTUNSY1lyR29r?=
 =?utf-8?B?UzJhTytRdjlEQWFTNUVBYXREY1h3bjBtM3ZyWmZnNkpIenFJM0poUmpBb0VB?=
 =?utf-8?B?SnNicWpyZmhWdE5lNTdkQk5JaVJZZXN6YVZJMDlQTFRUNFpzZWxRL0tJUUhJ?=
 =?utf-8?B?Z2ZiSkNhREJBWGhXVndyNk8vbmpRN0pmekM4VE05MnMxN3RUYlF2ZDhYZm9B?=
 =?utf-8?B?NCtPZFlKZWswMm5QbXJ1VTgzbnA4NkVaN2lPMU81cUJETG5nQlBvS3I1Rm5M?=
 =?utf-8?Q?Vtt9SbBXQaEjRzHLYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFVbXpKK0RFQlZUaVhwTEhKbENpVk4rZC9PVkdSeHEyS2xHb1BQdE0wb1o2?=
 =?utf-8?B?c3ZrdUZZa3J4WkUyQ3I0MjhjL0pjcUdpUmRJTjgxTWRoRjcwcEhQMjdmeUxG?=
 =?utf-8?B?UzM5bHVTdjlSbko3Mmh6OFlhM2FyL1RLL3p4YVp2L2tMOW5aNWllWWxXcmUy?=
 =?utf-8?B?S0JXQmc4WVQ2NU5QeHc5UC9oSGk3eGNiTS9aK2piZ3NlSVZ6S2MzQzYvV0Fa?=
 =?utf-8?B?VHUvck9ncFhJUEZCZjZPdDFoL3FQYTE2c0thNjE3MWxUbGFQMDFDNTVpZTBK?=
 =?utf-8?B?YXR2cTF3T1U1QVFaR1Jsd0NNR09IWjFXd3hPMS85Mk9ycDlJbE16bk1iRS9Z?=
 =?utf-8?B?TE1US0U3NmlWVVBHL3BaaWdXWGxhbUpIWkJUTW1aN1RLTUdneWdWUDFieEta?=
 =?utf-8?B?QjNFYUhGU25lNHV0Znk2d3hkc1g0aTZYdHNVNzdmTW8wd0twNE5XSkVCK0lQ?=
 =?utf-8?B?bzdORjZKNHV6MFRwQjQ1ME1ISFFXQ0lOZkNSalV2Qld3OUU2c045c25zZXQ3?=
 =?utf-8?B?OFRSb0ZRSFhYWmpML21GUkl3dHhPQ2dkeEdjKytQcDlKRXBITVJrU2lnSkx3?=
 =?utf-8?B?UFR4bCtBdm5zUlhKUkVsTzNjeFpyNTNqbmVTWDdQSkNxaU5qWVdvMXpyQ1FD?=
 =?utf-8?B?Y0pERElLMTd2YmFhYWs4K3dzc3J2M1dQUkF0TDdCdlVyTXNHbWZQUHF3R2ZX?=
 =?utf-8?B?V3c1dWluSmN6SThhb3g4bllwcjdvNzUwb3UrVWQ1WnJ5eXZSd29vY3I1TXI1?=
 =?utf-8?B?UVFoTzQzajdZWnBRWENwbzlrOVAwU1lpZWtEYzByRkpaYlZ3Vk4rYXpyNHdS?=
 =?utf-8?B?ZzNGWVN6MWovRnArcVJsaHdnZ1laVWlDNkJIZDlOTGtjUDNkNkhldSsrR250?=
 =?utf-8?B?Zm5lc004MGpuOWZrcDR3QzdTa2IySEZYc0xrYWpFSkJCM0I0dmp2N1dWOXZ3?=
 =?utf-8?B?RUYvNzZMY3hBMlQxRkJvRXFhNDNpaFNNUGNtb1V4TFlYTktRMzRJZzJQZzB1?=
 =?utf-8?B?dUtaZ3I0NUo1YzBTbUk4ZGxwazdlTmJwdHBEek1CMndwYWw4eVNHWnRuTzZZ?=
 =?utf-8?B?S3lORjIxN1dNMjdVb1g3NUZlYXdYK1RtcHZqU0xVNE4ydFlUUE1LSjdCUE9L?=
 =?utf-8?B?VWVlRDAzMU9UUHV5dlZLa3VraTdpZE9uT0hINVhmUVBSNHRzUHY5dEwzdHU1?=
 =?utf-8?B?dDk1V0JTK3ZPell6cDlLbmEwRDNEaFMvWDY5UEtEMVMrR0dMSzhZMklrTXl3?=
 =?utf-8?B?SnR2bERZN0kwcTAxUCtyK05hMUE3MXNET2Y3Nk5ScVJzVW42Q1QrbG9Ld2t4?=
 =?utf-8?B?TlRMTEhvUm9ZZG5aYjQrY0F3Nm82MnVGMUJPaEs2R1JWNWozUGREMkJoZzhL?=
 =?utf-8?B?N3BsRzIxaEhjWG1lZ28zMTZlUFcrKzcxRXV5ejFubHM5dHZmOHpBOFRUZUcx?=
 =?utf-8?B?dDR5RDlUNEFLc2xLeE5jZ0FQWVBWUmZNUmRRWEdFOE90YU1iM3pYbEFkb1Er?=
 =?utf-8?B?MU14elhObFFWbHZWWUNaWDdBL01DY3VFWlRJL0MvR2dMcWlvanphRGszd0tL?=
 =?utf-8?B?WWcyV1ZPYWxQVHd3SllmMEREZVk4ek82MFhXNUhUb1ExTC9oMC9PYkVXOFVC?=
 =?utf-8?B?TEVJdVhSd3gzWkJERmZWQld1YVJ4RHFlMWk3ZzRFY3VldEpwenk3UHRPQlVD?=
 =?utf-8?B?VlNvRkplT2RhMnVEeXErc0h0RCt6RkFhMDZWdmdzalkzeUMraHNod0FWVlpZ?=
 =?utf-8?B?dkNXTFNaTFVta0JoSTBEWC9WNFRvU3ZTUGdIWDg3cEFUUFpBelBYOEJLVHdh?=
 =?utf-8?B?SGJxblFhSy9CeFhyZkhtcjhUd0h2Wll3UUZVVVJyWjhWQ09CaW05Z2JEa1BI?=
 =?utf-8?B?bmFvYVV4VTFQMXdmbGJjdVNhelpyMTJLRjc3REcreVhxUmplSGd4Y0dvamFL?=
 =?utf-8?B?OTRKa0JTdmtoYldHZWswUUppNGZhS0plbmR3Ri9WaFZTZ0NQMlByWVFoNUd4?=
 =?utf-8?B?RllnbmcvQ2REQmpzVFJOT2l2Z2ttUjB5Nzc3TnM3UWZmbDBWd3NFYVAyK3Rh?=
 =?utf-8?B?V3JzMXF4Z3h4TkFYTC81N0JWcElLU3luam53T0ZTZXQ4OWhMTldodWdiMVZl?=
 =?utf-8?Q?CyNaD4fiURwSTN7Wxex/epYDm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb8571a-ecc4-4271-cb93-08dcf95cf2b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 03:34:38.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: albkcRkHY5K4EKhenkXKqn903DUHUxahc0suJLIGELabD1lngQ5WvkHElTPtmaIl2akSZkkEjqKusVHjNz5KdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

On 26/10/24 00:11, Steve Sistare wrote:
> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
> Repin at small page granularity, and fill the batch from folios.  Expand
> folios to upages for the iopt_pages_fill path.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.h |   5 ++
>   drivers/iommu/iommufd/pages.c        | 128 ++++++++++++++++++++++++++++++-----
>   2 files changed, 116 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index 8e48266..5ac4eed 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -177,6 +177,7 @@ enum {
>   
>   enum iopt_address_type {
>   	IOPT_ADDRESS_USER = 0,
> +	IOPT_ADDRESS_FILE = 1,
>   };
>   
>   /*
> @@ -202,6 +203,10 @@ struct iopt_pages {
>   	enum iopt_address_type type;
>   	union {
>   		void __user *uptr;		/* IOPT_ADDRESS_USER */
> +		struct {			/* IOPT_ADDRESS_FILE */
> +			struct file *file;
> +			unsigned long start;
> +		};
>   	};
>   	bool writable:1;
>   	u8 account_mode;
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index aa79504..5f371fa 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -752,19 +752,32 @@ struct pfn_reader_user {
>   	 * neither
>   	 */
>   	int locked;
> +
> +	/* The following are only valid if file != NULL. */


Are "struct page **upages" and "size_t upages_len" still valid in this 
case? The code (kind of) suggests they are not... Thanks,



> +	struct file *file;
> +	struct folio **ufolios;
> +	size_t ufolios_len;
> +	unsigned long ufolios_offset;
> +	struct folio **ufolios_next;
>   };
>   
>   static void pfn_reader_user_init(struct pfn_reader_user *user,
>   				 struct iopt_pages *pages)
>   {
>   	user->upages = NULL;
> +	user->upages_len = 0;
>   	user->upages_start = 0;
>   	user->upages_end = 0;
>   	user->locked = -1;
> -
>   	user->gup_flags = FOLL_LONGTERM;
>   	if (pages->writable)
>   		user->gup_flags |= FOLL_WRITE;
> +
> +	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
> +	user->ufolios = NULL;
> +	user->ufolios_len = 0;
> +	user->ufolios_next = NULL;
> +	user->ufolios_offset = 0;
>   }
>   
>   static void pfn_reader_user_destroy(struct pfn_reader_user *user,
> @@ -773,13 +786,67 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>   	if (user->locked != -1) {
>   		if (user->locked)
>   			mmap_read_unlock(pages->source_mm);
> -		if (pages->source_mm != current->mm)
> +		if (!user->file && pages->source_mm != current->mm)
>   			mmput(pages->source_mm);
>   		user->locked = -1;
>   	}
>   
>   	kfree(user->upages);
>   	user->upages = NULL;
> +	kfree(user->ufolios);
> +	user->ufolios = NULL;
> +}
> +
> +static long pin_memfd_pages(struct pfn_reader_user *user, unsigned long start,
> +			    unsigned long npages)
> +{
> +	unsigned long i;
> +	unsigned long offset;
> +	unsigned long npages_out = 0;
> +	struct page **upages = user->upages;
> +	unsigned long end = start + (npages << PAGE_SHIFT) - 1;
> +	long nfolios = user->ufolios_len / sizeof(*user->ufolios);
> +
> +	/*
> +	 * todo: memfd_pin_folios should return the last pinned offset so
> +	 * we can compute npages pinned, and avoid looping over folios here
> +	 * if upages == NULL.
> +	 */
> +	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> +				   nfolios, &offset);
> +	if (nfolios <= 0)
> +		return nfolios;
> +
> +	offset >>= PAGE_SHIFT;
> +	user->ufolios_next = user->ufolios;
> +	user->ufolios_offset = offset;
> +
> +	for (i = 0; i < nfolios; i++) {
> +		struct folio *folio = user->ufolios[i];
> +		unsigned long nr = folio_nr_pages(folio);
> +		unsigned long npin = min(nr - offset, npages);
> +
> +		npages -= npin;
> +		npages_out += npin;
> +
> +		if (upages) {
> +			if (npin == 1) {
> +				*upages++ = folio_page(folio, offset);
> +			} else {
> +				int rc = folio_add_pins(folio, npin - 1);
> +
> +				if (rc)
> +					return rc;
> +
> +				while (npin--)
> +					*upages++ = folio_page(folio, offset++);
> +			}
> +		}
> +
> +		offset = 0;
> +	}
> +
> +	return npages_out;
>   }
>   
>   static int pfn_reader_user_pin(struct pfn_reader_user *user,
> @@ -788,7 +855,9 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>   			       unsigned long last_index)
>   {
>   	bool remote_mm = pages->source_mm != current->mm;
> -	unsigned long npages;
> +	unsigned long npages = last_index - start_index + 1;
> +	unsigned long start;
> +	unsigned long unum;
>   	uintptr_t uptr;
>   	long rc;
>   
> @@ -796,40 +865,50 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
>   	    WARN_ON(last_index < start_index))
>   		return -EINVAL;
>   
> -	if (!user->upages) {
> +	if (!user->file && !user->upages) {
>   		/* All undone in pfn_reader_destroy() */
> -		user->upages_len =
> -			(last_index - start_index + 1) * sizeof(*user->upages);
> +		user->upages_len = npages * sizeof(*user->upages);
>   		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
>   		if (!user->upages)
>   			return -ENOMEM;
>   	}
>   
> +	if (user->file && !user->ufolios) {
> +		user->ufolios_len = npages * sizeof(*user->ufolios);
> +		user->ufolios = temp_kmalloc(&user->ufolios_len, NULL, 0);
> +		if (!user->ufolios)
> +			return -ENOMEM;
> +	}
> +
>   	if (user->locked == -1) {
>   		/*
>   		 * The majority of usages will run the map task within the mm
>   		 * providing the pages, so we can optimize into
>   		 * get_user_pages_fast()
>   		 */
> -		if (remote_mm) {
> +		if (!user->file && remote_mm) {
>   			if (!mmget_not_zero(pages->source_mm))
>   				return -EFAULT;
>   		}
>   		user->locked = 0;
>   	}
>   
> -	npages = min_t(unsigned long, last_index - start_index + 1,
> -		       user->upages_len / sizeof(*user->upages));
> -
> +	unum = user->file ? user->ufolios_len / sizeof(*user->ufolios) :
> +			    user->upages_len / sizeof(*user->upages);
> +	npages = min_t(unsigned long, npages, unum);
>   
>   	if (iommufd_should_fail())
>   		return -EFAULT;
>   
> -	uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
> -	if (!remote_mm)
> +	if (user->file) {
> +		start = pages->start + (start_index * PAGE_SIZE);
> +		rc = pin_memfd_pages(user, start, npages);
> +	} else if (!remote_mm) {
> +		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>   		rc = pin_user_pages_fast(uptr, npages, user->gup_flags,
>   					 user->upages);
> -	else {
> +	} else {
> +		uptr = (uintptr_t)(pages->uptr + start_index * PAGE_SIZE);
>   		if (!user->locked) {
>   			mmap_read_lock(pages->source_mm);
>   			user->locked = 1;
> @@ -887,7 +966,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
>   		mmap_read_unlock(pages->source_mm);
>   		user->locked = 0;
>   		/* If we had the lock then we also have a get */
> -	} else if ((!user || !user->upages) &&
> +
> +	} else if ((!user || (!user->upages && !user->ufolios)) &&
>   		   pages->source_mm != current->mm) {
>   		if (!mmget_not_zero(pages->source_mm))
>   			return -EINVAL;
> @@ -1068,8 +1148,15 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
>   
>   	npages = user->upages_end - start_index;
>   	start_index -= user->upages_start;
> -	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
> -	return 0;
> +	rc = 0;
> +
> +	if (!user->file)
> +		batch_from_pages(&pfns->batch, user->upages + start_index,
> +				 npages);
> +	else
> +		rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
> +				       &user->ufolios_offset, npages);
> +	return rc;
>   }
>   
>   static bool pfn_reader_done(struct pfn_reader *pfns)
> @@ -1151,7 +1238,14 @@ static void pfn_reader_release_pins(struct pfn_reader *pfns)
>   		unsigned long start_index = pfns->batch_end_index -
>   					    user->upages_start;
>   
> -		unpin_user_pages(user->upages + start_index, npages);
> +		if (!user->file) {
> +			unpin_user_pages(user->upages + start_index, npages);
> +		} else {
> +			long n = user->ufolios_len / sizeof(*user->ufolios);
> +
> +			unpin_folios(user->ufolios_next,
> +				     user->ufolios + n - user->ufolios_next);
> +		}
>   		iopt_pages_sub_npinned(pages, npages);
>   		user->upages_end = pfns->batch_end_index;
>   	}

-- 
Alexey

