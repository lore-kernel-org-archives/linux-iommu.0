Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8C19006A
	for <iommu@lists.linux.dev>; Wed,  9 Oct 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467609; cv=fail; b=KqRPH/8MgH0uthLQ6Pcw0hBZx2PVLHTTgoPN1/gUfqJZwTH3pVYUqukRVVo4cSgA1ezyn218QGQ/A6OKJQs4A4GVyOGwBAjXeoufv+8QUYRi9WxfJJq+Oo+xhnfgTqiurJhJuCRMYCV6ToEj4/MAgK+Gd3XofNwL6lEXUPuRwSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467609; c=relaxed/simple;
	bh=guWSXSrVCRMnzsK40O4ZW+MNEcOLcTt2zfTMa3Ofg1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUSjcISVwE76r/piGyOdYg5uKwTgpqyr/bFMtSHr/pbcdARkTUIQEwZa9mTwDP4J0e9YTOgqZMO3F/P4Rsf23Y6KqDbqMs56+Wvr5DzXOcytB8GjUQ4Kr+X6JSnau6dxiKtPcS2h9K129eMGovc5vf5zjjbVURH0HKVqaWw+yHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xa5Wha+g; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xa5Wha+g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhpxDCVZFnWGH9E7ewwm3mX9sbaR9W1LUKsNOoZYqSv9l5xM71sAcBj+8auxOc/YohMa+mWpMTHQ7wOLvrqL2nIuckHgWOu5nquhWJrjIouFouGG4nbOFOzfsAAQnVg/V80CiO4PLCEVzTutTgn81bIRZO5B2dAjv3S8elp8cZVMUXm2A1i5krGCssdNZQ2TEmjfatf1Dx2W5t8h5JszEnBhwL8I2Pmnz4AwBHYcvlCIVWLr8St9KcfN8FXCQ5ZknFMAKWHSNH+BPTPkCQW5Ge2WkVeywmRAi+YGBdft9RgmhABYRQmU4bRKB7AeGbm71Qgq/1hzQv2EWfZUlMctcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe5giQhwWJ/VPn1B5klZCdI/oZdjp98k0WbnOCyS9zw=;
 b=RQJFWrXPHxlGLN1rOM52QKMCvGkxhemsA0L1dRl0JgsKy1uRYZ5c9MKroG6yXq+eqhXv5PV5n7jgfdxLwjfhj7hC3+72maW9gtsU+qW7LbjkjWspG4SzJRypmrzdycwgTRH+w2SUjvPVXpQhFv8BB/GQ8H7+8HwJcGqiEL40ZP4OdNOqE65O3ZGhg+UVLSyrsIU0ltJUCi6gZ/pia6JnYL9KW04pbfJxHDCQZuZhPuRyijeiid7BHDHgJvLp7XDRwmEtIdxvBcLnhu/OetmLwagkqDEi9unQ4OQeMclFgafKd7x4IuVG8SOpBRmY2xUaMMW/p8B9IYjRjPqtW2jmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe5giQhwWJ/VPn1B5klZCdI/oZdjp98k0WbnOCyS9zw=;
 b=Xa5Wha+ggXA1fIkg8bkJhEz+ZewRD9ZI2wiS4AkAdZy0xr52DqadFRbmGGsdGCsn6ntD+gZ/lslPQMX8foW7x3jz91qrVYQiLw9iuPpblDcy/m8vl0WV3r+zkmT9D9Az68lfhZW5Afpk+IECNbAUwcgrV6ZuFkgG4I7cwBaiXuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 09:53:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 09:53:25 +0000
Message-ID: <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
Date: Wed, 9 Oct 2024 15:23:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 yi.l.liu@intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: f480eb87-f718-444c-bd78-08dce848379e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnNuTGNUbzlGTUVSVzdDcUZlU1VLZHlRWWxaVFlxaTVQRVpyWnVZVjQ5Ti9K?=
 =?utf-8?B?UnBqRlVpZ0xlS0hrdVVyZHFxc0FGZWdsTXJyelpRVHk4SmRGeW9CMU9UY3h3?=
 =?utf-8?B?RHNVL2E2VERPZDVXZGhCQXFZTXFnTUFqYVdLUjNlbHlHaWhLN3dFcXFyYXdw?=
 =?utf-8?B?dHFLVC9yWkg5R2hDLzFxSjN1QkphUWlFQlVFQStwZjVRZ0hIUXhNVXhXZXNk?=
 =?utf-8?B?aEdXSXVGSDVIcHJkc0hvSE1OSFZQMy82ZEs2QUdhY3NoekNqMUxrUnFpV05E?=
 =?utf-8?B?QjBoNzJSUFVIdEY4TnFrdHNwR1d1UUFqKzBPaTloTE9URUcvMjdFTGtFVVBU?=
 =?utf-8?B?c3hSRFJZZDFoOHZOZEN4VnhRaVBtdVc3VllaaU9ISndBcmJnanlLU3czL3ZR?=
 =?utf-8?B?K2QxQmxETEZQSzRuMUZ6R3l2Vk1uUU9qd2hsV3RhRjVIK1RMU3g5elJyZ2E3?=
 =?utf-8?B?UHZ1WlV6MGRSS2N0T3hxOWFKM3FZLzBoT0VHWkwzMFZUaXpUQXhZaHpJNkJZ?=
 =?utf-8?B?QmVTRmZTYTZZUk8vL1VlWjlVRHlWWEgwSUpERmpjRjZYZkhVVXlDUncxY1U5?=
 =?utf-8?B?VzRyK3dzUlVMbXJ4UnY3YWlBOFNpeElwaS9hcTlsRkVEaitBTzZ1MGtrdTND?=
 =?utf-8?B?WXBwY01xWnJZcTVhdjAvUlp5NjNhelN5d09xaXdiOGxJbjM1ZDNYRURrckc0?=
 =?utf-8?B?ZkZlc0tvSGFLVDQ0QkxFV05QMWVXZmxYTnMyT2R3YTM1Q1JLSmFXREZOalRR?=
 =?utf-8?B?T1JVeDBrMGZmT0lmRG0zemFta2p5anQ1cFZZSGZTNkh5RDBSM3pzeGI5MUVG?=
 =?utf-8?B?Y1BDYVhMYkJ1MUpmbk1PTFlWYTVNZmFaNUJLVXFxazI3M0tXc0lsa2JLTmla?=
 =?utf-8?B?UXFFMFBhbHJVaUxpR3l1UmNVT01TMU11cGlZMDBXaFRTUlorQ1pyeitpRStC?=
 =?utf-8?B?am1mRXkwQUJKN0pjQlBuMDlzbytoUnk0N1NFdnAyOGM2MzRCaUxwZWhQWkk0?=
 =?utf-8?B?QnpuR2l2TUovS3B2YWRpeXpmUlNWNmRqTjgwQXFJM1M0MzhGUWljZW1UTDZs?=
 =?utf-8?B?TXZuNWlGdVV6cm14b0tGVk9mNlRLM1FXQjdNZGxxRkdOdGVpNmErOWVqZHNH?=
 =?utf-8?B?N2ZxVG1Hbm13SURwc1EwYzhIc3U0cXRKMEU2OHhQMGRWd1FNZW9MSWpnc2xx?=
 =?utf-8?B?ZWNCdzJNRzZFZURoODJValdVMFMyVDcycXVNNzJFNVM0cjJMYTVvMnNhdXND?=
 =?utf-8?B?S2xMSFpFK1NGcDZPajI3L0wxOUFqdlVBL1JqVVVSSVVlcnpYT0VOQUQ4ZlVk?=
 =?utf-8?B?REhaUkRGSEVuRWFBN3hCbU16ZUQwTUQ3Ty80NUlCdHdiZGtxa0dUYlVqV1do?=
 =?utf-8?B?Y1c2MG1GWHVQUzlHZzR4L2lWV0hlcThGN3BoR1RXZ0s1R2pIRHArblQzVDY1?=
 =?utf-8?B?amlJWERSMitzUnZWd1ozZG02aHA0VThaM3RNNXFIcXVPWE1KZXZ4VUE1clZF?=
 =?utf-8?B?WDBHOEtQUEp2M0ZIVm82TFZGRjZFZmd2WDhFYlhsSDFMLzkxTWlUK1lucWR3?=
 =?utf-8?B?d2w1UjNpTTZwSmNNK3RYbUs5d1laWmwza0Y0blBVdjBmMjR5bnVrUTlrV2w3?=
 =?utf-8?B?ZSsrak5PaHdzdnZ5S21zbmFvSXVzbWZVQ1IybGJ3OTRUUFloaVY5c1A4ZTI5?=
 =?utf-8?B?VFdyelBUMFp1RGVueGw4UkEramVGQWpsaFY4cTVObXZkZFhuZHMybkVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzlyZ3d4WXZ4TVZkS29pLzAybWU5OWlzN1JhWi9jQW5DYmJvQlR0aE14M2ZW?=
 =?utf-8?B?aVZWZXZHYTRQWVRJaFRwSDZOYzFEMW9CWVdNY2dqVHpmZ0Z6RzVLK0pwOUEz?=
 =?utf-8?B?Vy8wUnZZZFlmT2JZZmU1V0hHS01lNGtEdVZWS2xLL2FHQWRFMWtsUEN2TEd0?=
 =?utf-8?B?L2Zkdk1pOEhJdFR0dTRLSjB4aHZkRHVoYXowNHdLY1JDanJZTmZYMG5jbzBC?=
 =?utf-8?B?allVR3VhTVNvV0E1SUc0bHJ5Qk5GNk15cDZnQitiOHlPdXdqL3VMUGFGL0sy?=
 =?utf-8?B?SzdyWWFvazFiTFF4clZPcXVqeE5YaVNGU0ozQ25iMVFQaE1kUmkzdGdHL0NN?=
 =?utf-8?B?cTVSSnhnU0VucDd3NGdlSVJNdTRscmZNODlyMUQ1RTFSK0M1cGZZbnk4SE05?=
 =?utf-8?B?YjF3OUUzb1c0Lzlzd1ZWMUhyQ010Z0Y3Rlh3a1VubjBERElIbHF1RzVoU1Uv?=
 =?utf-8?B?bkdESjNSbDVIRHBLOWV4alBPOXJkazhDcTU5a25NU1I2bkFyNE5RQkJFS3Z5?=
 =?utf-8?B?VTNMZTZsTll6SVgwdjNiVkwxemJkYS9JTGVGY3RYNkltTHNCY0JNNHJZellX?=
 =?utf-8?B?eEg5dnlIeEdadERCMGxvZnZKMjlkcFpEV3BuaWRxMVhwWk02cGdMSERMbFdS?=
 =?utf-8?B?WXNhOUkzaUZGcTIzRHVlQ1BicE1BU211MzYwNFVDUTlacjZGdFlXMENITEpU?=
 =?utf-8?B?a1AwWHdMU2JwUllnMnpsTWJmNDZKbDlrazMwSWo5eGlGNkJEMlVSb1Q5VlVQ?=
 =?utf-8?B?aVgydkptakd1VlQ1LzNsdTFnZ3lWeElwNDA5ZUE4ME9xMXIrcWpMYThMckEw?=
 =?utf-8?B?TnJicS9GRDdpazUrdFd4T1FueE83TzhiaXFOVHo1QUQzdVFHQzBTdmRySEQy?=
 =?utf-8?B?VlhxMEJKL1c3Mk9xNlBZRldyWjNaSUpESzRaMEdIR0JtOGc1aWp4d1N6NERz?=
 =?utf-8?B?YVpwamFPQU1BblVyT2lsN2VYYnZIcmxSejVJc21iK3RSLzhUUnhDRUNBdVhK?=
 =?utf-8?B?aU5LZWpNaDBHcGRtVHVkbnJ4OUE2ZkpwV1Fwc0xRK2JEQXlCc1BZZER4cHJP?=
 =?utf-8?B?Q1NUWk9hMndna2NVNDE3MkloRlpVenRzUTNFUkZDUHErSlRNQmdOWVFMcmY5?=
 =?utf-8?B?aU1sbjJjdmhrME1ubC80dHVzY1BhdHNiVkgrSjVsOXVDOGhLUnBqS25VSDYr?=
 =?utf-8?B?KzRxc1Q3WHVCMFFhamRXWlhackE0RllYTm1sU0FXVDhZNzFsMG40S09hcmlJ?=
 =?utf-8?B?azMxWVg2cmdsRnpJMzM3NXFsakpVQmpSM1lxSlpYbDdqc0lsQUVTVWFPTGM3?=
 =?utf-8?B?dlgvMjBCRUNYcGRHbjVJK2VzamNUYmhEeWRCc3FpSUNOejc3bXJxSzJEMFdS?=
 =?utf-8?B?MEhoRUVSMjFySVZ1aVJNdE5JRWpwYW5lWHdlcG8wd0VCN0JCYXJSdmVmOSsv?=
 =?utf-8?B?YnFZbHFrenNsUS85d3hzWjhPSjkvenFERUloUFAyVG8yb2xWWHNWcUt4V09B?=
 =?utf-8?B?VWRRYTVGVE40K0xCS3QwSlhIdnVWOFRGN2hSTnVkY3Y3MTMzSjR4WXNsMVZX?=
 =?utf-8?B?L3JvbEQyR3pJWUNlOEtrbTBYWmJ6ZTc1K3pMZk56QmxKeVNkNEo1RjFHaFdF?=
 =?utf-8?B?NjVmY2htSlRsN1JrNW84aWd5Z1c5WkNodElOcllkRjAyWnRvOHZxeGMxN2Vp?=
 =?utf-8?B?Y2VPRFJUc0V2Q3YvbnNVcXZ2N29OVTNwSUI5d0ZtL3hvNFhsY090NFdxdG82?=
 =?utf-8?B?TVdKSXFGYnFUR0pUWWlBdEVtTS9KTjd1TEpvT0FYL0plMktUZExySnEwR0pM?=
 =?utf-8?B?bFZKek9mbW8wYzRZZmh0RTM5QzRoZzA2RlJibjRTcUFDU3hrdVk4RXpOcUJt?=
 =?utf-8?B?MnpYT0VDYWh6NFczVXNhaURYTWxybSsxSENqamVTVFZWUUpsTzhrR01DQVFM?=
 =?utf-8?B?UDFZRVREODl5M2tITFMwdEpRZkJ3QUsvaWZXeEVHYVZnc1l0RHVaaXZNUFpN?=
 =?utf-8?B?UWN3RzIwdC9ERTB4cHVld0czMnp5Z0U2SXdXSzhwcjlsK3VBU3c5WENnMEwv?=
 =?utf-8?B?c3M4NVZwcXdpNEpqbVFkWUk2ZkxjZ1RJOHhVaHA4WmRsSVc2UCtpWVJmY3kw?=
 =?utf-8?Q?tlFPXBDtqin4qGuJ+Kdzkuy4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f480eb87-f718-444c-bd78-08dce848379e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:53:25.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+wpbnGkT1I5d5CYH/dQl0O74Dqlq3NXj42+fqu1jzrL56E42MK97aHsroK0AhX60V5OzltS1b2FWIbRKHqKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

Hi Baolu,


On 10/9/2024 8:17 AM, Baolu Lu wrote:
> On 2024/10/2 13:30, Vasant Hegde wrote:
>> On 9/11/2024 3:49 PM, Vasant Hegde wrote:
>>> This series adds iommu_paging_domain_alloc_flags() which takes flags to
>>> pass additional details for domain allocation (like domain with PASID
>>> support).
>>>
>>> Also updates AMD IOMMU driver domain allocation code. With this by
>>> default it will allocate domain with V2 page table for PASID capable
>>> device and v1 page table for rest of the devices.
>>>
>>> @Baolu,
>>>    With this changes (patch 1), to allocate PASID capable device core
>>>    will call domain_alloc_user() interface. Do we need any changes to
>>>    intel driver?
>> @Baolu,
>>    Looks like intel driver works fine with this change. Is that correct -OR- do
>> we need any changes to intel_iommu_domain_alloc_user() ?
> 
> I still have a question about the following change:
> 
> https://lore.kernel.org/linux-iommu/a3e09a90-0b63-4332-9e25-a5832d5ec8b2@linux.intel.com/
> 
> This change might cause a functional regression when it comes to nested
> translation. In nested translation mode, the user page table (e.g.,
> created and managed by a guest VM for guest kernel DMA) must be in the
> first-stage page table format. Then, it can be nested on a second-stage
> page table managed by the host kernel.
> 
> Currently, the kernel automatically selects the page table formats. For
> example, the Intel IOMMU driver always uses the first-stage page table
> for guest kernel DMA. After this change, this assumption no longer holds
> true. This means the kernel might use a second-stage page table for
> guest kernel DMA, breaking nested translation.

Hmmm. I assumed after discussion in v1 series you are fine. Looks like I misread it?

IIUC intel driver wants something like below.

  - Host : DMA API Mode : first level page table
    (PASID is supported in both level, so you don't need PASID capability check)
  - Host UNMANAGED (VFIO Passthrough) : second level page table
  - Guest : first level page table
  - Nested : second level page table

Is this the correct understanding?

W/ this series (domain_alloc_user() interface), you will not be able to decide
right page table (second level page table) for UNMANAGED domain. Is that correct?

-Vasant
