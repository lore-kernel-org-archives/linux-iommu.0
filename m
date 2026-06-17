Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EA3B2FE5
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676633; cv=fail; b=ZKzp9ZAehF2j0y6Ea/PLaWTjHt7PKpJ92q04DNqlsrre057HdXf11hsHCuzy+Pkrmvvb7ekjLRwP8PzEJJsziIvgOdw8aHj1pxjERIyK1LXC22BFkI9h3siCV88IWb3fLqBrx+Jx6xb2Ck01yIj3WQEwA685ZPVhbz0NzC6xMC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676633; c=relaxed/simple;
	bh=db/Of6wtJoW/VFcbmxjHwx+ZDG6Jfswag9Ng6o4J/ho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2zYzSisJfT2zpTJFmSLd+/Xx5O+V5UEN+qSn2tmilJgWC5oth17AEowDQsgEY//96SlKQrUWCzdoj4ZeUV7GaSICLGPNxwXP7XVXrRljg2wb+q2rqLub3mP/H7ERg84hVk1r7TDQupUlBiCavVtRr06VoJ3g3ZNuGvAZel//8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vplZQbpz; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vplZQbpz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+wu0dSJLeWY3ffLgXzv2DSdUBvnJhN8bN5fEhakqH0fjdN5+iD3MW8UeT+85iBlKVU2Lo2MgSB0D9P2hdFaAHJBMqlZrEzCyCvZzR8vYbeBYPsBQd6P6YjB6lWeVnx/ixR9DDStnO/VSU1QujS/HB67QHzN30RGu31AQC3azpF3VVZGzkupwcmv+KmMgBZtQs4brqvWSm/aDq4zo3xYKHr/K1C7cVvHw6+OTrCRfTOWtqdg2ln6IwXoVG2PZ3EMc5wQH9lZogAW+/B27Ni80FX3SLboxAH9KfWs6mJyhm8ewKoslBmlV21UVPZyyubTOYeUJvk6j3m4IrNYzfznLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig53fdkyPJaBm//h0UrASdh/QIeoS5/uCe7wA2JouBw=;
 b=vNaueXAbS+SovyBuk4b70Oq6SyLm46OgMfNhVKgn1nq4pV3wydX8Nz/l4sp+4ZGjThl2XPL0wkPIRCR/Kf56YMiugv/NEE23S6NxX6cJ19xPS2pNrcJ+PY36e5rAQZE0Fa3RADyr5bYVtScDDRCptBicplCtjab2p590O4Wzi4l8Tqq9/NODkz6Zt89yjc1/JhRq1AGGb/DjRkacHmSjnisAyy90xf4P9ZENGoC8/PMaavFe7EPHtpGy3X7SSCHLq/++ZbRYnxLK6jj4OhQ1C9CBqTxv8uwf971psWZXiSoH9c9nzI8a8bjSzX52seEUilNRw6SNGsOP0msXNHpdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig53fdkyPJaBm//h0UrASdh/QIeoS5/uCe7wA2JouBw=;
 b=vplZQbpz+LaCZHuPr1VAQQvWjczVtTCYxsBHWJvu71b9Iblzb8BL5GujRokakmg1NQuTH6QE5S37KBt8cwCRBAg+NMkjH44LbrLqBCqxb7DQ4yG81yyqOIUAj4SDzmiOou/2iOE4tdlyqDDXZaI5opR0eVu+1mimBGS549ZAYgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:10:28 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Wed, 17 Jun 2026
 06:10:28 +0000
Message-ID: <ed92043e-0548-47ab-bdec-58d2ad8c3b53@amd.com>
Date: Wed, 17 Jun 2026 13:10:17 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/26] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-8-suravee.suthikulpanit@amd.com>
 <20260601125130.GJ3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601125130.GJ3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::15) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a28ab5f-9a10-46dc-9a69-08decc3720a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vnL6zB2Q/mXAjTD64+canELE7hQVQi8Bf6xQJiDMc2s7baKiBJKqrjfQU2XBHHtYQhGgsHEr3gJrv9zmIrx1KzWiGCdwgmUiYewRf6B/XUTe1wPdhToV3LEiF7d2jfHovY0+3x+rD4pdEBXjsKYZvtM/CNcnKcM+b8mhaIL9do1B9UmGSv7pQ7wcPlKWCthbVd9EP0y/hme5cLobDk/Ff0ivzwfgJli8B8oq95KusyWISZWNUnxtqcoIgvx5uhG+z/qoVW+K0+qxVvrVKDkb+87EkrQoDVW6z7v3rMI7AKzfs8X8j+i5JQ8PwUn25vXBt4Bdu1m1C8ZjoVn+lKZffI63VllMPHDXZPTATEC/zORwMEJfYiJZhyEKqirq6U9y0TZIADm18tkpGRryPhL2vZApGoCUVMzNJjiApxwd3VWeUZ31De47kUYkOA5sNC7tfPZ5Ot+9hX5aVB004GfDMhMowGdYqv0+HxUYMHZjBxBGDvjjjzWDP6By3HTMXa5qKxgzjT86mv0HcrJwSO8Ogp6s3enxDUUUtFf9RnkuNe4hJSKzlE9bo/rVplYTZZQXN8oIGZKPH3ugRUaJmJWUEYs8XQYjoMvBSgEPXL9EZ4G53eX0snjHW7Q0a+T9fdhuosFXscig8gJuvv6sdZ7fgV0GPhDRYZM1RyfoMloJndkZdMUvgTw+1Bx6OJpuGC6v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHhvWEw5TFREMUVFTmNKVWtmL0pzUTUrMXc5WUx5MXRtZmJUMC84Rnp5ejFC?=
 =?utf-8?B?aVAxV2lQaE45bWovS0lPdFQ1UGR5MXl2Q2lCQm9aTGFiYUtnNEhzREpFZnJ4?=
 =?utf-8?B?MmtQSWZUL2tnZjZITkYvQThmUHUwRkhLL0U5VmdFUkg0ZXlvZXdyaWpjNlp0?=
 =?utf-8?B?K0hUM3RXMFdKYzlENU9WZzBXOUQycGl4Um96bkpCWFZPd0pDSy9GK0FIdG1J?=
 =?utf-8?B?azg3b0cyY0x4TjNYNDBSZ1BPSm1ReVJ5akRCYWR5UGUwaUhNMndJNSs0V2FC?=
 =?utf-8?B?clZZV2FHL2UrMUVoNmNhc3R1WjM3cE82bVhyUVBhbDBzNDJ4dmZRd1Z1RXRh?=
 =?utf-8?B?YmN3TUFXVUdMWHpxUk0yRDdpSjVOOGczTEg5eWJlSjArZ2Rjb3g3OGpVMmJt?=
 =?utf-8?B?WmJPeVpiMDc5UWY1Wk5vcUhvbW8yRC9MNjBaY3VvdDNQcmVWbHNEZ2llNktz?=
 =?utf-8?B?SUZTMGpNMDBPT1MzbnJzZzlzWG5UcjhtUWM3WlNEejlBTDVWZVp5UklhNXht?=
 =?utf-8?B?N2kzMXBVQThiMWhCbzlKakVBSndNZ29ZVmdsU1lsb0pzMGRRdSs2Rm1oK0hT?=
 =?utf-8?B?cXMxcVZhSFpzTnRoaXJuVHlvajBsVmQvdjAyeXBUQjdueHI2UVI0KzBKZXZP?=
 =?utf-8?B?andEVmE0Tk9QcTZNU0d2S0RLSGM5YmN5QUFPRWF1b3I3RFdmOUdZUlIvYi9i?=
 =?utf-8?B?eGVBNG5mT0k2ZW05WFpzdjYyai8rWHdseldqWWtmT0grUWI2UmZQQjlnT3FS?=
 =?utf-8?B?R0NoLzRYOFdQZnUvTzZqVWlib0MxSGFDamV1NFhOWDVKdnlUTHVvWGl0Ujg1?=
 =?utf-8?B?RzZ6OVNINTJxdmZKanJXTU1HTi9SVWFJTlNNUDJDbnJXRHFhMEF6bHNMOE1N?=
 =?utf-8?B?NHRYYjhOREJMbVNnTHVqNlFObmV5SmliM3crWWdtYVZNWSs2N29NZW10MEFq?=
 =?utf-8?B?TjNUNHErZ1BnVGhKNFVVNFBsV3h1Qlh0RUNjUFJSNzluN3kyaHZUa0czcVYv?=
 =?utf-8?B?by9QODBYVTN6T2poSmVWYlRva2I0S1ZaRHdzVEovVXR6czAyMGpCZmh0dldD?=
 =?utf-8?B?b3VoRHlURTZTSU1LTEFUSEl0d21zWmptdXFkYXZCQjcyRks4YzhVOEpWL2pn?=
 =?utf-8?B?VWhqbnN0cEdXK08wSnFCMjNRdmxvVXEwSFdmOFlvVHJZL0Jjb29tWmhzcXdy?=
 =?utf-8?B?dk1RTVpiaGVxSEwrTWFzMy81SVQxeS9wa0pKc3pyUmlydGs0S3VtUDdic2p4?=
 =?utf-8?B?YnpHSjRWV0NJdWZQOXJyTU9KQ2VrREo3MjlId0NPUnRBL2hnN2F5SVVpRFdZ?=
 =?utf-8?B?bEtmZGtXNEdDNXc1TS9XSXozNHZaa1FvM1o0Z0NSRWM1YTNpdkoxL0QweGE4?=
 =?utf-8?B?ZE1PUVVUd0FSdXlvaWYyY2tZUkZEWFNKODVscjQwa2VmYUhRYkQyMTRGd2Fo?=
 =?utf-8?B?M0dpa0M1Rk1LZ056N1FsQ2lDWjVTZEpIc1ZhY3JMUktPMzJiZEJZTDcxbzRr?=
 =?utf-8?B?bTJQUmlJWkxRZEE3MTY0ZmQxWTRwc0psN1pxbHQ3LzByanNhQ2Z3MWIvd2hQ?=
 =?utf-8?B?bDlYeVdkWXg3Z3BqaEJPN3VVRDJwZ0FsWDNqSHIza1hxalZuQnFNclFZam4w?=
 =?utf-8?B?M1hlTEtQUjZ3NHlxOElmYy9SSG42a1UwbG5FbG9qY2xLckRSQ1NRZUlUbjdk?=
 =?utf-8?B?WjZ1L2lWck4xVTZJT0QzYzk0WWgwU29McUNaMVZRbmE0NDRheW4zaHhkR3cw?=
 =?utf-8?B?ZWROcWIwaFV3UzFnSTgwLzl5bllaTFlCQTFIcThhMlAvNXgxZjV0Tko5SlZE?=
 =?utf-8?B?bm0rbEFFbEhaSDYzNTFjT1lsN0p6VFVUR3RlOEk3RWFZa3J0NEZmQWFkUkkx?=
 =?utf-8?B?QkJ4MUQ5YkdDeGxxUHNodDN2anJDQmtlVzhtMldEZVp0Sko0eG5TNVprQXFm?=
 =?utf-8?B?VWZpQUoxcmNQVC9TOFVmRkZpczloejhvRW4vQTdxVHlMbm1RMkx5UGg2elp1?=
 =?utf-8?B?WTNtNlFTZWxqdTZJeko5OFlrY0J0emlyRk9IU1IyL1RmbUh0NGhpaC91Sndo?=
 =?utf-8?B?MVA0cDIzQWluTW42R2Z6cjM0QytpYkpxTG5GRUVMMTVnZXowNnpROTdMMXda?=
 =?utf-8?B?RVNHNFRwWTM1Q1JuRHdzMTJVNC9SR1dER0JzM1pSSjJYY3NsbkF4MW9kekFN?=
 =?utf-8?B?UnBSSksrWXkyWkh4R2VpUVR6ajlvMFlsdUJMK2tKUTAydVdya01mZVozbFJQ?=
 =?utf-8?B?TXF4SHpZS2p1RzFRZXlkOFJsbTVtU29HN0N6MS9RdW1KeFBva3hYR0xuOXBP?=
 =?utf-8?Q?b9R3+R1glmR9FfPRl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a28ab5f-9a10-46dc-9a69-08decc3720a0
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:10:28.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALWmAa0ZJcdpIFqRSxdwVIHmR+dnXlOIafcbmouYGhdciDbmOhTL9Lv0Upe0OjDQVer+0hy4VZA3iWLW3ZYAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101



On 6/1/2026 7:51 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:19AM +0000, Suravee Suthikulpanit wrote:
>> @@ -68,6 +70,16 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>>   	aviommu->gid = ret;
>>   	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
>>   
>> +	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
>> +
>> +	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
>> +					page_base, SZ_4K,
>> +					(unsigned long *)&data.out_vfmmio_mmap_offset);
> 
> This should not be casted like this.
> 
>> +	if (ret)
>> +		goto err_mmap;
>> +
>> +	aviommu->vfmmio_mmap_offset = data.out_vfmmio_mmap_offset;
>> +
>>   	ret = iommu_copy_struct_to_user(user_data, &data,
>>   					IOMMU_VIOMMU_TYPE_AMD,
>>   					reserved);
>> @@ -82,6 +94,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>>   
>>   	return 0;
>>   err_init:
>> +	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
>> +err_mmap:
>>   	amd_iommu_gid_free(iommu, aviommu->gid);
>>   err_gid:
>>   	return ret;
>> @@ -100,6 +114,8 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>>   	list_del(&aviommu->pdom_list);
>>   	spin_unlock_irqrestore(&pdom->lock, flags);
>>   	xa_destroy(&aviommu->gdomid_array);
>> +	if (aviommu->vfmmio_mmap_offset)
>> +		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
> 
> I guess mmap_offset could be zero legitimately
> 
> Jason

I'll fix these in v3.

Suravee
