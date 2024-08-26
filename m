Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CAEAEB
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652556; cv=fail; b=NTo0U7j40f7uoiSjOglL3YZhjeIGoYCYILFI5cF+80nRhUh9uusetCwj+gel04Luf/0wNdNLxfIWnG6D5sj08aoUxJoNDldIEBZuw2tFwRXEetLR9URSuLZsRV+8iwzkauqsyVu81lKd/sbfCuDXb/y+9tZxzdgARGL3VqvnEB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652556; c=relaxed/simple;
	bh=ndiuMf6fc+EB99n1jdRqgGjYY8/o/MQupAtMp8ZQG/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJ8ksN4pdNOWCqDi6ZC0PRrg5NspxvTvLBiEQOooDwOykA4KuOvh1ramrVdRqisSNip91qTuffi9+zfVIQ8rSKFNyLRHkhesisshfqBTFdH1oevP1i1GTDpgpSboqzp5Z1VlFMI8B62qdbg/G91ojhibzAd9ap2ohOtXVxNEqtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W3SIkayr; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W3SIkayr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeWkc1pmxCRdubD+LSQceGLL0xlQToFZBwz9dHzcZ3pwtq7m2faq0IFiKTJ5NVzQb1oOlvf3k/Z5eCiEqvd+441yR1hRkVdvgXksCpF1kiA96TheqyaMFmOufILzo8c+jQL3vNZu9OzzJv4SxCR9uxlBy1VIsHv83zQRjgUDqgkaeLrOzpdlGdkS5dm4EhNXkgLzUJSf6IqQPH8JDLcGIIAGvNFkZ4KsK/J40QO8XlSDN5+T9xfff7uuTZzJWE3vLO8rfEKAP1mO4Z3/eEEAVelDhDkJBSDKX3qaCXGBGjlQAb2eoZTF6h8HwRg3OIEwdMyOYvPvcVZrrQS/05GW5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/auiSubqPggPGZhRsQWkRVi+qbzst0eOjBwCtkOTB0c=;
 b=ptdUMsN6di1Tzmhr2rXnx9w5Q67FGRGVy71F/LV7/nc+q9OfWFATxi/8P5FR8YoGevs45GUDcrsz/8XjadtqYCMjjUz4MLg/yrjt7Kn298LkFEcEh9xesYOTzVCYuOBP2qfQwFtGvmPDaVPpjBFacD2xlnBIHuVqGE19S09N75mpHQ2LcsKWzoS0ZpdaobULTMUBbKjJhWmp6bG9/ik/5FfRKeYKSgww51uni9Fh8aiUOiRU4dMbOeJYYsH1rmLlo0ar5OgoGWbt3700/ZJnxnMWL1MQzw/Hfgv72GGHX/V9U7VNYjkypsvjJ99thkTdtI5TKmjXwR4Bxwqn9rDCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/auiSubqPggPGZhRsQWkRVi+qbzst0eOjBwCtkOTB0c=;
 b=W3SIkayr6IQsbXnDZAFLTmcRX/jWFBO66v9AcW4tQ74WlcOv1UtSe46tqDEwxUn8KEFSIRHpz349ED7UGWeHdwyG87PKd78b30w5wZ+G8h5vVOQS7VLkLz1XxoN1OYLY6DuwkYwbEqGmUCUnC4RerFR3nAhkL0so53T8q1Uors0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Mon, 26 Aug 2024 06:09:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:09:11 +0000
Message-ID: <c997eb81-9614-447c-8c25-432c3c9ef9ba@amd.com>
Date: Mon, 26 Aug 2024 11:39:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, yi.l.liu@intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3d8c04-4a1a-49e7-2b1d-08dcc5959a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlkWkwyY3VDa1RSSGhyUXVVZ3czemdtKzZHTXNiWVp4a2V3eTNwdFdrWTFG?=
 =?utf-8?B?ZXJVKzAxM3A2NTVtZGtGTzFhV25vZysxejZ5K0EzRkdPM041QTljcnl0b3kv?=
 =?utf-8?B?VVZHdURLMWRSaU15YkJlOGhFVVV2Mjd5cVg1YzZvM0h1dHVqY0ZrRlpPWFRk?=
 =?utf-8?B?aWl5eXJQRHRvbnhiN25mWjFDY2JZYzZkb1pvUkNNcVB0VDRUU0VkTzIrVlly?=
 =?utf-8?B?SExiRy8xb1g0YmZEWm5Jayt5MlF6dk9IV213UERFMWZ3cVpFaXZORmV3Ti9l?=
 =?utf-8?B?dTJ3eFhGMDE1cGsxY0FtV3NLY3dKUlk3Q25UUURvdXkrTGUyTXA5TFVzMVhy?=
 =?utf-8?B?eUVGM0RMS2hxQlZMOTVGdGQ0UExQMys3aHdld1JySmZYS0RxSWI3T1NGMkxu?=
 =?utf-8?B?U1ZOMnkraDhUaFQ3TTlzZGNBcDV5RlJGaTBBc2FVaGtNRzl6UndEWGhSTU9v?=
 =?utf-8?B?MFlTVEJYVXk2Zy9ZWVhxT0hMdm1DanNzbzZKRTZnNkczM21KR2g2QzM3bEhs?=
 =?utf-8?B?NnlZMGpjSFJZQzU4SXhUTVUvbmFoZEdjQ0paenFsczY4dnVJOEJHSGxmbjJJ?=
 =?utf-8?B?bC9oMVJEZkJNNlVrKzBxWWFaUzgyOG9abzdVRUlCR1NNQ3JGL0lpQmVuL28z?=
 =?utf-8?B?ZTRaVzNKcWQ2eDNVTjZYY01tZXFaaWdCeXNxYXROQ2pNYXlIbEZWQjBVTksw?=
 =?utf-8?B?czgwbHloZ213SllPUEI2bmJoNUs3bkRHTkVLeHJkRXNGYWtQM2lVNVRzbVdP?=
 =?utf-8?B?dlJLMjhSR1lGQzh4cUlqc3VEMGtxWEFzaFBxWnNDVmJ3d3NVbUNicmI0d2Jt?=
 =?utf-8?B?YTcrTW5SZVI4YVp2VUJoTTZudkdiTTRVbE9UMWdlVUxiQmhOTjVTWDRVUjh3?=
 =?utf-8?B?U216K3RSM3dQcFZKeGlRTkIrTS9NbXlrSzFRWnpab0l0TTY2c1VKelhQT2t3?=
 =?utf-8?B?RTIyTVZyMVlJTjgwOGtxWXkvRk15d3lralhVT2xOenNpbWtHeGtCWklXYmRu?=
 =?utf-8?B?dDExckpnRll5QkUzY3lnOENiejdZakd0aDhYbnhpeG1ENkNsQTZER1dxTzFv?=
 =?utf-8?B?K1dVQklxRkk0VnVUVm5PblZJNFRpcFdZMnp6dXhjSWpKTm51SXJINXk1ZC9W?=
 =?utf-8?B?VkJBbVk4ZkF6Q2s1bkhTbUFwZXE2ZDVubUFXQ3pobm5vVVNvU0hkYW9yZmEz?=
 =?utf-8?B?TmFKZFpuMkdqbWU0Ty96alY5MkNyVEpwN2h3am9henZoczJaSy85NHNXRndG?=
 =?utf-8?B?VnExaGcrWWhqaElSR0k4ZVFQVDVVS1k5dGt1eGk2OG9BYURyRzhUNlc5Uk1P?=
 =?utf-8?B?Rm9JQTJNSnhZTWJsbUI1elNNUlNBQ04rS0RaR3FCYVIzZld5R2E2Wk1kaUho?=
 =?utf-8?B?OGlIaEFxcDR4NDNkWm5uUnh4SWE5emk2cnRsOE4zTVFGOGNXL2R5RVNjMzdS?=
 =?utf-8?B?SjRsV3hocllLc0FaaGR2QVJZRExMOVY5T1JxMzY4QmRFcVdkdnlaeHAxZ2Zp?=
 =?utf-8?B?c2RjN0d2TkVJWkR1T0syRHl0bFJUYWdVelpuTWEwTEt3ckVZR2kzMEZUQ2Zw?=
 =?utf-8?B?emxHYjlQYWJxa0x2TU1QWDRxNWRFakptKzJqay9CQU9CTXBvYmVLVSsxREY2?=
 =?utf-8?B?aklvcFNScVhLRTVOVnF1MmpOZDA5L1hHcDhUbzhXZGRrU3B2S3hVVU82VXBs?=
 =?utf-8?B?ait5M2NMY0VwQnFMaTNId1ZyUkNWaXUyT0NLNWc2TEdaT25mazYxQm5VM3hK?=
 =?utf-8?B?Z09YZTk2VmhqczAraysrNU82WFJndm5HMWxBaVBsR2FmbGhUWUFOSzRTU0VP?=
 =?utf-8?B?VCtCaC9qWEZDSCsxMmRqZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDVrN2tiOW5BUktPL1c5bUcwS3d5VFNYNjRzRjVCdmtJcm1tZ2NSSGVHbEp4?=
 =?utf-8?B?L1Fad1Z6eVpjVTBsbXdDSjU0RGNmaDR3NnArZEo5cmExVU1MeWhYelJGa3lj?=
 =?utf-8?B?VFUwRDlGbmxaTmJJRlVkOTBTVVlRTGdjSit5cUZDcGVHdkFlMlVXeVZlL0cv?=
 =?utf-8?B?TFY0NFRhZ05SeFdMbXVPTXAzaFYxcjB3SDhJcXNvSTVLTEFJY1QrUWowcFVF?=
 =?utf-8?B?eWd6U1E3ZzZST3RvNzNKZHRYelJlY2N3aHJUTmdSd3VQYnRCOC8vUnZQQzJn?=
 =?utf-8?B?bW9lSERUcmI5dWlJYU4zQ1JNTXVVUG5Oa1hFeTdJbTgwUWY0U2xuOFpkMzBF?=
 =?utf-8?B?SlpscXFZTkd6bTBJN29heGN0UXVieWlVL2hNVXozUnRjeHRaL1pKVXljZHBU?=
 =?utf-8?B?YUc3Q092RFVvQ3dTeEtVcVVmR0VxNGo1aE9Ydld3VFVrZWJuZFp4bUJwbngv?=
 =?utf-8?B?QWFWZWdaWnIxaWdhRk53TmQzMitvRVBXT0o0VzBMd21reEZOb1NaY3VKRU1i?=
 =?utf-8?B?T3E5OVNYN2pVUFRBQk1aZXoyZXQxNmRLR2pQMlgyckJxcGZ3ekZXTHkrR0ZX?=
 =?utf-8?B?dThFT0p4SnM3Tk1PMWpLRzBHQUxidnlMYnJ6SjUvamo2OHRtRkJIbERxYzFL?=
 =?utf-8?B?VjlNOTdtbXpxRWU0enZFTUgvbmN2OWtIYXEzbXRIMzRiNm9oT213UFMzVTFr?=
 =?utf-8?B?aEo2VkJiNzVjdWNwUmFCWWxHTjRScHJmN2FpSXVMakhhVjROMC9COEpzMHFK?=
 =?utf-8?B?M015V3o3NGtrY283REVxZ1dtQ0ZGaGlob3R3VGY4UkswNjZQbU9KMzZsQnJN?=
 =?utf-8?B?bUtyUDJFd2VhTmw0UkhRUy9XOGw3TWlOay9LRC90UmN2aisyVjE0WEU2eFg1?=
 =?utf-8?B?emIwNXdpdUNYSUFPaTN3bmtTSFhEd0tUZUc4aUdpMGduWFRibnNWcWR5aktX?=
 =?utf-8?B?bXJOTmZzVEJadXltODNwOWF4eVpsanExbGpNSzlNZHROa0ppaGptbXBNeEZy?=
 =?utf-8?B?SkRwYjJuWFVXRklhUitvd0ZyRnZtN2p2SHRraWpFazVNZEVtTXg5RHZGeHRj?=
 =?utf-8?B?cmdRaHFRM3dBOWdwRzM1L2lEUjAwZUxISmk3bHE5aTNoVm5NT0hnaFZnNU5H?=
 =?utf-8?B?NEY2eDFyYTNCSDYyaHdVMnRhNGRQdEZPb2hub1JQNnB1UGtrS2kzeW5lRy90?=
 =?utf-8?B?SVNnUDlKSkt2bmhidTlXN1FzVVdKQnBHODgrYm9PYVlIWmtrWDl0WCtMeFF6?=
 =?utf-8?B?VHBlSUVRZDBlSThlbzVneWQ3dGlWL2ZtbzRqbkVuVFZ2dlNYMk5SbzdTZnVz?=
 =?utf-8?B?WWYxeEpFTHZlY09UdDBZdzFBbHFRdEtTbWRKcVRMcFJkYVVOM3A2cUZYYXU2?=
 =?utf-8?B?a3pwSnN6YUhRdGkyNVpaV1ZNSUxyZk5wREZaL1dWaUovNERWa2pqS3JoeFh6?=
 =?utf-8?B?L3hWeTVobWhJNytKUWEvb2NzWFVWNjQ2SnhNOVhaNkU0eGV1akF5amNKQnVr?=
 =?utf-8?B?L0xaVlI0MnREellkZUFTdkFMMEtZdWJudlhJMVVRMUw5NitOekI3WWRqVitY?=
 =?utf-8?B?RGhjbHZPK1Y4K0dXN0JlY216SklGOG1qODRnblBqRmhiSkIvV1kvemJkMzdU?=
 =?utf-8?B?ZTFZOUQ1SDEwSjV2MDlIYkxvd1pUVjRtZzlTRGRFYnR1QlpWYVRsa1FlRndI?=
 =?utf-8?B?K3NOOGRmdWhaU1VPbDdNVDZlZEZTT3ZtQmJRajhUUVFMMHRsdUlGSVY2TFFo?=
 =?utf-8?B?UU5BMHMvK2lHM2s5RkpkYlBLdGl2UGhPc1NrbTYvdHMrV3IxTkZrRkRJcXJN?=
 =?utf-8?B?TGlZNzdRNmNJMm1uSlVFd3NiUkpvWVV5aGh3WE9DdVl2SGNuT2xoRFI1aTVh?=
 =?utf-8?B?aGVpZXkyMXRoV3FKRll1UGFDQzE0bUN5VmFxK2V4VzBrN0RLZEdDY2lFZFMw?=
 =?utf-8?B?Z25NTWJMclZyaWw0WGFlMFFTVVRWcWlRUVprb0RDSDE1alIweVpxVlhUdjVI?=
 =?utf-8?B?OEFpMDQ1dzNVbGRRMkp4VVhBeXFkRkEwMEU4S2J4Y3BiL084N05ESThpN01Z?=
 =?utf-8?B?VWVjNGFXeE5EZDgzWFJkZFVpY2JpeDJSZkdhSXVNbUNNMGxUdVc2S1BDMU13?=
 =?utf-8?Q?CU0M+xXn2bFiHg8DNunm+ZHsl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3d8c04-4a1a-49e7-2b1d-08dcc5959a81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:09:11.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bl9V+2KJ7M06ZD1f6mvGEf3ujBq4oJPJaVE1jQx9BMaxQJFopUExhTD0F+YIM2nIwXPM9VIDwkH7R5tu25KXzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

Hi Baolu,


On 8/22/2024 7:08 AM, Baolu Lu wrote:
> On 8/21/24 9:35 PM, Vasant Hegde wrote:
>> From: Jason Gunthorpe<jgg@ziepe.ca>
>>
>> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
>> UNAMANAGED domain. This is not sufficient to support PASID with
>> UNAMANAGED domain as some HW like AMD requires certain page table type
>> to support PASIDs.
>>
>> Also domain_alloc_paging() passes device as param for domain
>> allocation. This is not sufficient for AMD driver to decide the right
>> page table.
>>
>> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
>> parameter. Also update default domain allocation path to use this new
>> API whenever device is PASID capable. HW driver should implement
>> domain_alloc_user() to allocate PASID capable domain.
>>
>> Finally introduce new flag (IOMMUFD_HWPT_ALLOC_PASID) to
>> domain_alloc_users() ops. If both IOMMU and device supports PASID it
>> will allocate domain. Otherwise return error.
> 
> I would suggest one patch for one thing. This will make the changes
> easier to review, especially for those who don't have much context. It
> might be helpful to split this into some smaller changes:
> 
> - Code refactoring with no functionality change;
> - Introduce new domain allocation API;
> - Introduce domain allocation flag;
> - Code refactoring afterwards.

Ack. Will split it into smaller patch.

> 
>>
>> Signed-off-by: Jason Gunthorpe<jgg@ziepe.ca>
>> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> 
> 
> [...]
> 
>> ---+static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct
>> device *dev,
>> +                               unsigned int type,
>> +                               unsigned int flags)
>> +{
>> +    const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +    struct iommu_domain *domain;
>> +
>> +    if (!dev_has_iommu(dev))
>> +        return ERR_PTR(-ENODEV);
> 
> This check is unnecessary as you have already called dev_iommu_ops(),
> which assumes that the device is iommu probed.
> 
> If you are worrying about the caller passing a non-iommu-probed device,
> you can make it like this:
> 
>     const struct iommu_ops *ops;
> 
>     if (!dev_has_iommu(dev))
>         return ERR_PTR(-ENODEV);
> 
>     ops = dev_iommu_ops(dev);

Ack. Will fix it.


-Vasant

