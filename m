Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09C1AD9C2
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934880; cv=fail; b=pXHbvqWojNXl7SibjBNBsbSIr8VWxc2+ObwajrnWIjMTlfDaC8feaAeIk76pSZ4OxvyHiA8eNxpX+REWWxtxw+1j8lP+VEbeMuyCW0jBFpCEYfmKQoJQR0noCW4pWbjAKrWr8Wztu2M9DRh621H5SOqQ2rFNGOORf2qknbA717c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934880; c=relaxed/simple;
	bh=VSpdy5Oyg7daq+IZfp4Sa+pqALs+ER5qePhsml6c0lw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JiWnuT79NMnsRyQ+TRxKZ/JDBjwtqCBbUf8c8DcIsiXaXZ+rfheY+haz5LGapagA+4zU+kvD/Ty665YqXVAvVQRDO7KHT9CTiNWO4IcxIGpMSuLRQNWysclWB5htjE2RUQ9lx6U5djSR6yXoABCwdtqNjksgFqW3iMRIQp1060M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xUoCoKV9; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xUoCoKV9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYSmbOWhM3bDQ3rBK7qeFOccz7lCrxu0PuVublTaKoY7IwRbo/Xcotf8Psb+/YBlTqbw6h41EHuGCvSeiyZkVALdi9mdbQmiVsWSBG5qdTIDlx199MvzDNQBAnDCYm9AWEuw8WjRlqV1D8mF1JPhkCo7q9+NBDBPxfKNh+AyJ2xuj+vaxV4/eNrr2K8AUQ0ofIUqj82jEh5fo96UaU8lpperZazcjPDCILo8qccBhnuwFYZt0gazOqe7urS0Zc03Nu615kSxvjWdtPuxvVv5unjTRXxhYk1YSlBMsma3xHEvNEneeFXRu1G4kRfUZ4GH0GhLf5lVlqSABpHQJkbJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EE1Y1UTwSvw6+DG+1T+8FkcsUqCL6EfdcuKI4TcF10=;
 b=wOnrnwh2knlV+ksiS6NzLHuEGSFyYeTnJPz6sru9jzSs1Ll0TzGFskimuEewhSfLabTKKo6C+GKl42ieh7O4xsEoK6XQsT04WVgKxA1WpiHfQ/TxmiGxjj14fW02wt+iSN4hh2iRLLrOkdpjLKSdQWFgupMXx/gGlNKgdKrgfZsrZxjssMiAxqbBC/OYb1vFQQ89+R0mAnlXK+dZ4NWwr2VVssbygbdEdWUxM8+NRremA2ulY2mXeeRwDWSyxiuaX5U2IRF+Qz1MGBR3z1vCUU1KMkndRK/CZ4xUx/A/k2MExKJdiO3PfH8zj1ffQd9SLKCCdVTIS8NXOR2zwETEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EE1Y1UTwSvw6+DG+1T+8FkcsUqCL6EfdcuKI4TcF10=;
 b=xUoCoKV9lghSeTaAmGcget0+YTfCEYsybPoIOqbXbc6fouDqd3tA9SWvUnxwUDb1p1jrUisFbqLypd/b8E5x74PB1MV9/8zTnE4QA6b/eSeBephnJaNeMY2vwoxUKyWwKeCojiJDkuG9wSHv+Y4QmIniSLS8yccrzcRjGjtI+1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Thu, 29 Aug 2024 12:34:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:34:36 +0000
Message-ID: <6adbba52-3f61-42e4-8b1c-d90abf3b192d@amd.com>
Date: Thu, 29 Aug 2024 18:04:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <5fd22a04-ff5f-4763-a93f-268fefabaf7b@amd.com>
 <20240826135615.GH3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240826135615.GH3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 733156aa-e0a6-4dab-58bb-08dcc826f12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3VpNmZPQUQ4bXZIZzI3ZEdQUXIzSWhXNHF5VS9ZUUE2Ty9MV25jOW90Wjhr?=
 =?utf-8?B?N1Bqd1dFemRiMHMrL3p1UVA0MHBDc2ZWOHBLb2xyL1M2aXlMTzFKV3dod1p2?=
 =?utf-8?B?VnZDdndJUnBsQW0zRHhlSXdhNzJqYkJpdzhVd2ZaYllaWC8vNUtiaUZqMlhN?=
 =?utf-8?B?dW9CL0NWSXVlbmtFVlhzcXZNRGZ3RXZBbDRqSEV3WjRjaFh4U3k3dEM3dDBw?=
 =?utf-8?B?Q2ZmNEZ5eWVZQ0FNUHZpeS8wUll2eXBRQjEwRTNXSFV6UkMvd25aeTdFZzhU?=
 =?utf-8?B?SkJtSXVSa2ZoN3dSTXlXb3ZnZHRiMkl4YlNXYVdoNG9LRjFqWTNZd291c3lm?=
 =?utf-8?B?bkZ5YUxWd2hSRDJFVE1uT01IV2lVcmxzZ2xPdXNNazdjSHgwcU4rQVhVODFH?=
 =?utf-8?B?ZDdaOHV0SW5RN1RzRWxvZVF6YkJ1U0J3MFNqK1JtbUNDQUlBSldTOHpzbTVJ?=
 =?utf-8?B?ckhJYjEyaGRPR3BDYmZ2WHlvSVc1aG1LOXJjZ1dWZDIrcFYrU1IzYUx1dWg1?=
 =?utf-8?B?bCs1RWtEM25remMwOTM0WHhrTnZnakxYVHVYQnRiaXBCVThsUGV1VlFPVWI2?=
 =?utf-8?B?dERNUWl3dCtOSFZNbWpDdDNTWlM5eElVaDJsdzJudWR5UEl1Tk9TS0FEYUNJ?=
 =?utf-8?B?Y2lqUW81Zld2bW1rWXlrdmJ5NGZPVElqUUhWWFQyYlAzUFNTc2tnNXN0RXF6?=
 =?utf-8?B?cWVORVJmUmZvTGlNUVlGMUpubFNmRWJhT2xiTkNqS0R4YmxhYzNiTmtxUFhR?=
 =?utf-8?B?WFVzbkg2bjFyUWw1TWlZMUJjYlFRd3dTZk1kcGQyRjBML1I4Z2RkWlJubm1z?=
 =?utf-8?B?dkpvYUp5ZmlTblNxY3NUWXhvNHpiS0d0M3UvWHUrN29Tenh4QzZxeGJmazIv?=
 =?utf-8?B?a3JjV0hPbFZzQ2NHTGYxc3NTRnBzVjlTM1VKYlZrN1FDUGJtV1BRQ05jZGs4?=
 =?utf-8?B?TlVGbzZ1UktNOVl3UWpDcmN0RWZ2UjBnMVY1d2ZmaEVrc1BwdHZPWWFNQzAw?=
 =?utf-8?B?UXMrc0dRU3ErOGxPNzBvSjlSOVZEczJHbnVtS0VjUm9wL0tHVUJMNmU2N2Qx?=
 =?utf-8?B?MURVQk9UaFoxZkVJMGdiSDBlbU1JVlZhNUNmNExQN1F3dWx4YmJLK3FjSXdv?=
 =?utf-8?B?aGwxR2tkRWl4ekJzdUR3Wk5ldUJIb0JBd3NPR0FTbklyZ3gwYVoyb3YvZGk3?=
 =?utf-8?B?WU9lT1hBNFljaXhMU1pSMU9NZVZIdm1Sbm4zTlYvRDNKOWpCckMyc0l5U0xN?=
 =?utf-8?B?QURvT1FWWm1uamFVckZSNXNiSHV2R2FudmdmS1ZrcENFU0ZqRVhYcDBpTlox?=
 =?utf-8?B?Z2N1VUp3ai8yR2d4ajNCOEdJRWdacXpqZk9sWGU4NG1BSUhTemEwQ2RXM3Vo?=
 =?utf-8?B?RzJyUUJKTWNXS1pyWklXS21Jc3laQ1IyQmxNZGI3OUkxblJpVnYwaWtiVFUy?=
 =?utf-8?B?ZWhEWkQxM1p3N3JDU3B0clh5QlgzOEE3eUFWVVVYRmxBNjJVWXdIaFdFZmxW?=
 =?utf-8?B?ZHArYkdTYmpCdkVUMkdnN1BJSlBHVkdmMWd1dis2SnIvUGVuOEVvd01jNlBt?=
 =?utf-8?B?c1pHb05TcThGME5JeGVxU0gxK1BrbDBOVnVaMFduMzJxaHJ3TUl0MjRDUjEr?=
 =?utf-8?B?LzlpRENTU0l6a2xhdm8yUXp4bDZaSzFhNTJOV0VadDdTS3RIV3FiT2VsYk1S?=
 =?utf-8?B?am9jbFpiN3AzekpjVlp6TnRoVXVMMXdybE1URWdmamN3bnRzbjBoVEdCclB4?=
 =?utf-8?B?QVdnUTFzYVhqNFRrV3JkS0k0TDZBOVJJTkE2VEp4NGZSanN1b1NEQ0dkN2s5?=
 =?utf-8?B?WlJyeDlkU2d5SzV5TElKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm9OVU5lZ3dlbDNhRS9DY290SS9kcm9CTUJ5S1U4WXhaSS9FVWRsS2hzSXhS?=
 =?utf-8?B?eW1UaVhIYWlRVk0xOFdTSDUwcjVhU3VDMmJ1NlJQT3dqRFY0dnpDN0VUSFJ5?=
 =?utf-8?B?SE90dkx5dGJ4MDRwRWQrL2JXYlZnRlpxOWhtRVZ0VENFSnNJWTdJMGx0M1FI?=
 =?utf-8?B?clZGb2xRYnFSVE1Hbi9UVFBPL1Y2OFJUZTE2VFZwM2puTHR0eEtBS1lKaktu?=
 =?utf-8?B?UW9McldJeEZWVk80UVVKNkc3RnU3dmw0WVd2eUkrYVVFdXM1akhwcVBqWVZ2?=
 =?utf-8?B?Y3hWanFXOU1NRS9pNjZZdTR3bGhXd3htY3djMitmY1VCeEx3UW5wT2lmN21Z?=
 =?utf-8?B?RTc5UXFBK29EOTNBNWxZOG8vdUZEekhNQmNHTWtKVGgyem9HVDZyRGFRZWk0?=
 =?utf-8?B?KzVFVjhBSng3azBISWJWYVluNmZWVGpqaWRIODVUUEhOR2lLR0kzT0xVTXpk?=
 =?utf-8?B?OXoyRDZlSWNlaWJiL0VzbnZuZHhIK3NvdlNIa2VrVUtmTWszanliUitJaWpY?=
 =?utf-8?B?bkhFKzZnZ21nMlo4WnVtd05UUGZabXVMU1FtSEd3dmR0MmM4ajRXU2prUXFK?=
 =?utf-8?B?STMrU0JuMER1aS9rQU52aUtPQUtlbG5Ec2J3ZW1vZVJHMDlxaUtwc2p5aU5I?=
 =?utf-8?B?Nm0vNVdHdjJmaWVUR0pTNE5MOGNwQmJkRDVLaHhWeFB5TUwxQjc2dWgwOHYz?=
 =?utf-8?B?Vk9ZMHFXeGdBeUFkdVJMQ3oyTXpPMmZrOEl3OFd4OW02dW1LczVCVzNBMUxi?=
 =?utf-8?B?YXozM29DSHIrVVhLM2pub25oM05LR3ppM00ySXhyNklkT2E4UzY0VFRkVnJo?=
 =?utf-8?B?ZlJPYXllclR3V0V1VHQwNDczVTNBVVF1NFFSNEcwU3g3UjFWV3lmcEhMckRX?=
 =?utf-8?B?QStlZ3l2V0pOT2ZGSU1vd3FrYkpNSWxxUzg4Q3pHODhER1RRdWp3eGtOUEd2?=
 =?utf-8?B?bEwvcnFKakZ2bktGay9scVpwVjlDRFVGbDMwMnVsYmJQOFhweW1BdHI2WExS?=
 =?utf-8?B?UGFiazFEYUNraDRYUkVlbE0xL3VzMSs0aDdaNzZuWDdhbnFmVmEvM3ZHaXZl?=
 =?utf-8?B?ejJMNEJ6djFodU8zbFhtUmxRemhqL2I2aHhZTnJEcVJrRVVYbnpVeHZJaEtF?=
 =?utf-8?B?RE1MeW1TSkEveGE2UCt4U2tCdEo1OHZrVWJZYzY2em1lVVJqVzRsMy9Rd3A2?=
 =?utf-8?B?MkRkbytmTXZKWUsvcTRXQWdBZVQyNjZ6bnZOWEN3ai8yUFl6N2NuYy90cFE3?=
 =?utf-8?B?eUdyRlpPL2E4M3FtM0d2dW9tNEhvc0xLUjJiTzdLeW9UbmlvN2p0MGFnNjhs?=
 =?utf-8?B?eWZvVWpxbFcvVzJ0TkdpVHlJc3hlcmtBaEhLTWxkTVcreTBBZHE0UURVQzJZ?=
 =?utf-8?B?NExrWUNwcjYwM2ZPWDlTeVlRdlZ1bklFZzFhYlNEVnZ4MkhvY2Q5dlNkbnNG?=
 =?utf-8?B?UEg0cW4yN1ZvSURIbXpCb2M4NVhTZFlldGFkaFlBeEg3dUd5VGozdTRLMXlU?=
 =?utf-8?B?cnJ3ZHN3aUVtL0lkSEIvZ3hzclRyaXJscmc3SERhRWVCNS9wTGd6cHZucUxG?=
 =?utf-8?B?RjdMZVlOZXJycUJyS3lPV2UrUTlTR2owa0tYVVdFbjh3b0Z0Ums2SDlLYkov?=
 =?utf-8?B?cGJldlQyeVY2d3kxVmZlZE5WUFF1b2RLMVlyR2MzdGg3NnlGNWo2VjRaUkow?=
 =?utf-8?B?dlNUbkJyRmJXRGJrc0VrdzRmOW1VNjR1aDhIZEtXbE5DMDBwUzJlTCs0Z3RX?=
 =?utf-8?B?Nk01K0ZLZkNmN0VJeVJYTzg0MDBwd1dhd0tWOGR4R0J1L0x6emdET0VzWVdr?=
 =?utf-8?B?dlhpOUdSaWlTam1rVmhpQVFWcnpZOWlUeVdRcDk5Uk56SmFIaDIzOUNUcU5x?=
 =?utf-8?B?dzFxM0lpZ25BcHIzL2FBVEFwczJsaFNuYm5SMG1oTnI5THVIbWtaSWx5T0NO?=
 =?utf-8?B?bDNMSEV2K0dvNjFLYklBOU1rZVZubHpkZDhKQWM1TVZZaGo2cjYxZkMyVnZW?=
 =?utf-8?B?T3Q5cncvL3djazczUHl2dFgweGNKSHhhNm9zUFpnQzVxRlFKZzRNSkI2M25W?=
 =?utf-8?B?S2R6a1FFSTRnQzMxRE96WGVzUjI1cklja1VUak55L2lMdGVxZDduc21GOWg1?=
 =?utf-8?Q?IyRvPjrN69ApDHidVrnD1bnjx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733156aa-e0a6-4dab-58bb-08dcc826f12d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:34:36.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+1RPgc7gyGi1aR0jJbSCBciArrJkzmn69Ba8uzITujLOSDfQKc2v28j36j8CHbP0gT6yxtU3J7i+xiua+ZZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

Jason,


On 8/26/2024 7:26 PM, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2024 at 02:06:27PM +0530, Vasant Hegde wrote:
>>>> @Jason,
>>>>   Notice that I have added __iommu_paging_domain_alloc_flags() so that
>>>>   it can call iommu_domain_init() with appropriate domain type.
>>>
>>> It is okay, but also the type could be fixed in
>>> __iommu_group_alloc_default_domain() using something like:
>>>
>>> 		ret->type |= req_type;
>>
>> Sorry. I didn't get it. You mean domain->type? 
> 
> Sorry, yes. I mean the path that knows it is allocating for the DMA
> API can or in the DMA API flags after allocation succeeds and we don't
> have to muddle lower levels by passing them all around.

Ok.

> 
>>>>   I think instead of having separate function it may be better to
>>>>   enhance __iommu_domain_alloc() such that:
>>>>     - Keep below changes from this patch
>>>>       - iommu_domain_init()
>>>>       - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>>>>     - modify __iommu_domain_alloc() to additional param (flags)
>>>>     - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
>>>
>>> My expectation was to basically remove iommu_domain_alloc() entirely
>>> once Lu's work is merged.
>>>
>>> Instead we'd have these direct APIs:
>>>   iommu_domain_alloc_paging_flags()
>>>   iommu_group_alloc_blocking_domain()
>>>   iommu_group_alloc_identity_domain()
>>
>> Sure (For AMD driver, we may have to tweak a bit to allocate_identity domain,
>> but doable).
> 
> Why does it need to allocate_identity ?

Ignore. I got mixed up with global identity domain and this one.

> 
>>> I think the series looks OK. The naming of domain_alloc_user() is now
>>> a little bit weird, it has now turned into
>>> domain_alloc_paging_extended().
>>
>> Ack. Do you want me to do it now -OR- May be wait until all changes settles down
>> (above described group() related changes, this series, Baolu's series, etc)?
> 
> I think if we rename things it will clash with the smmu nesting
> series, lets live with it for now.

Sure.

-Vasant
