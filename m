Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C352F7EFC
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102204; cv=fail; b=VnwDNb2u552KseJULvjnxTOSDJVx16ST0DZZmhA6bXW0vu1ghl1kaSOrNTbDwDsdRdZViljEjmGeb9X51CiuFFhs7nzm90qvh3agzCb0ruI9/6QvOaK2GcuEq7WH0jOH+LdDxLSXaVHAT/eH72l3+pzuXhavoiyDieF3ZOe9/N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102204; c=relaxed/simple;
	bh=8A8OyeSon50EL9OngbThT2NsSsnPYWteEg95FIFjuH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmDNAFbw4Nw6KwoCyYsPFehQzsr5vYa4Kfa2YzbIQf2P12C1fe/SN1SPfjIAWFBa/KmHqr9UoFtJ1RGo4u0gkHUMyOp7Cb/MDrsRnnxx0sZTmTytMb0RdazMqEndmuijKlosdzbE6cEYyUyGKRPV+2mNsTZKJMT3dz3RC6OtMgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMXUytZ7; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMXUytZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuG9kn+JdKP2Jse1Imn5lSBxE3NHhdygJ0316/4DlW7mOMNPwBIFr7jfwraXzQim7KumdiijfyaISm0nT+SbR8XStxVrGBzCO2im7+mNyShCNttbtv65s/+gOWvwM5+35dn2999N6Tz34+OjnwLAOoeVmWlJNsjE2DKjUi7fXrBKEupF2ZxPNyHixYzMKDY1v/7Ae7YHsqhFKF+dAQsMlfA9MjlXE+DgAMawJQLX3rWITb8yf2hTmhgzQ7GRFUMhuHINPu0UTChsTcJ0lvSFG8b0rWNshMNVEESeNRuL00UvxhsjE1citEimkrxo2SJEpSq8m1e/8N34li2FdsUPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOcaUF3lHSdiday1UnNU32D3CRhD4yDKHsFQfnmj3Kk=;
 b=wi6NqMlxuv64+4dsRf23uHAaDyfGV8KuvGL1UGEB7xGB84+32W6r1fqRkDWEidn/FLTQ0Uo9yOcnBPeNGr5oEbjekq+QXRSXlK/8M56JtAOjnQDscGg4K+HjEKEyWLdm0ObHnD8svbSZDCfdDE0j/+7UsniR3RZ794hBsOEAp5iQWXUKEsG0C02vbNieNNx2vK97hMUtbNnj7Uygr+b+ppKhTNzgzYCMUA+wMbG04YDwzb9O5B3zC9LvNW4tX1+o2+DSN0kQhV3jNtQENpOtBw7dCm95Mm2kpEwlqBAd5361kaFYGSV4AinXYe5+BQmO7+s1ABFTroiockcdR5t69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOcaUF3lHSdiday1UnNU32D3CRhD4yDKHsFQfnmj3Kk=;
 b=uMXUytZ7cAUFiaOYPqHj3YaE4Hs3vs9QkeR/uCRN2F0aDoVSLhB8ZRLwZ7fOjaS/l9bp4c6ygLWaDi26/YGFqa8Yxke8FP7+zXlnQTvjtwfVkEosmRbgk1Cr1KBcTRhPxzTahCZq+qe1Jje6zvAFbcAiUIR6hvO3uArbTbaENGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:56:40 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:56:39 +0000
Message-ID: <643d700b-d425-4f8d-bb33-16af645d34da@amd.com>
Date: Wed, 15 Jul 2026 14:56:28 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/22] iommu/amd: Introduce IOMMUFD vDevice support for
 AMD
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-17-suravee.suthikulpanit@amd.com>
 <20260707143148.GD220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707143148.GD220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 344cb4a9-f6ce-42cb-1d69-08dee24699b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xMdHoOHObp9yK+WR0MbuEEfSid5VnxobIWhHeai/s1Gbglcnr1rkk24Fyuadn2HE1BRJOsmCVzyZAcxpj8SfkDqwFdf+vtSts36KwCZyPnsL8r59CjC6gCAgtq8mROm3olgMsul2Wi8PgWCGRGggXzUKCnWdwBkNRtFc15F5C3Gx1pJcveMlsr8+wzKMd6i78Z+uvJqqzy/MnhFKL9BLVKMT08a0q/7uoKjjOa+clIIcAqaV1Qi+yNClq1/ipD/0WUqCq74IvSMrId+OdSMFi8C0e6r1CZc3dnzcQPUrQZZgAdY1jL7RbkO4fU7NXN++TH05D9PXcCZVojFYkgHb8Cp0kK87OSkZoYnrCl9jwYTJdRJBkqpgSXrh8nidJLoGkH0uJgXjj1HTaCf+tAzyDFXXbgF4Wqtjd/KtJtQgweZVW0LgIdEWdy7wgLoHKp8DEYxps6EORUY4Kw9MT/i/+52axBZ6J/PM9P+gXsNMspvrihSTYLckZZp/W9wM4skHo7cIGtVi0EkTUdBfCRdH3Lz+QTO8ptKixl4MvHwHZN7JVWSCtInHFz5htnbcgjhxlYgSIrIfvCPhD+XH732fNaVQk/8XqnZdH2DJovEpXVeSXvC49soe9Akw/WMGEn60bawI9SzzD4qHpVn8MOoxxA4PiKJ7aw4eMdaO6uOOe7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFrRzN5ZzVOMzFUaGRIU3lYTkljN1RKYVR5OXFiR1o5YTl4TXk1OXlzRHZy?=
 =?utf-8?B?Qi85SmNpYTZsMjhjeDhSQ3NtcE5oQXpONzFrbDJ4TE1tMjlQVHhJVms0Tjdv?=
 =?utf-8?B?a1NRendBNzNIZVFPczNnVzRqWjkxWWpLaXN2eDV3bDJhaEs5eU9SZktnVS9L?=
 =?utf-8?B?ejJJcnMyVjNIeDhxWFI2V0NUMFZZR3FDcWM3c3gvREZVbVhrcVB3aS8yZ3dj?=
 =?utf-8?B?Z0pwNW9NRjdGRTJ1MDM2OFIzQm9ibUVwbzl1OXdOT2VLT0lKSXRUWWVZd3Fq?=
 =?utf-8?B?Yk1aR3RXU2FaY1BCamFybjczR1VrcmVHaGg2MSt3UGE0Wmk4bHE0TEFja3Np?=
 =?utf-8?B?MG5USkFrZVpRVVZDNWM3Y3l2ZXlqQUhhaWRmUUdYTjRYMWEzWnpjZFhaV0pJ?=
 =?utf-8?B?UjZ6QlM1UDhDQUJtYmw1d1MzalArRGFOWlBpOWtBak9IVEF6RUI3S0lSbmQv?=
 =?utf-8?B?enBUWlo0c3ZwN0dseXMrRXoxbVllYmZmTDg0bDRmYTY2NXRmRFl1Z2xaNE9C?=
 =?utf-8?B?VG5mdC8rOVl4OUU5RXgwb2NwSHVkb1hqanZvNitJVVZ5UHhLVU9JeE5hV0Zl?=
 =?utf-8?B?YmV0L2xIR1pkNks1U2VaUU9kT1cyeE1zRW5qbGdFZloyb1lGRm9SL2hGaDNS?=
 =?utf-8?B?Zy93aU8zZENMU0I4OThRZ3hwUktOZUYzYndjYmJFSzZOWVY1VU9VQ04ybmgy?=
 =?utf-8?B?aE5Wd1h5YTJZZExMOUdtSzZjMkg0ZjE5dUNZQnlkK3ZjMG10WVcwQXpNMlNz?=
 =?utf-8?B?RUkzbzdBOUVjbTQ1ak5weWUvSml4UzhZbitiT2JJSTFzbUpuNVByVXIvck1L?=
 =?utf-8?B?aC9HWDN4YVJzbEh4cWhIREdabkF6bFJFZW9qWlhRTWJ1NlI5cTBqc0d3dmtw?=
 =?utf-8?B?Nno4WFowdGovd3FPK0cxMnNrYUNzUjdTZ2NxQXluUHI2NTVGSnRzSzZDQ1N5?=
 =?utf-8?B?eTJFbHhhcURuci9Tc0xQVjJlMUlWL2EzaE5hT1FMRTlKWkxCNTE0bGhoUlh3?=
 =?utf-8?B?RW9yQnFKa1pIMjk5OFRVUkprUFIxcHFKeEkwN3JUY0dJTXBlTk9GZUVZQkta?=
 =?utf-8?B?SmFNTHhoUnMydlkzWWw1Vnp6VCszUW8vN3ZQTlFvNUo3WVFiRW8wWmZMUks5?=
 =?utf-8?B?dlBKZ2pQMlZ3VHV6dkZvd3dKK2tEckEydDdSYUVyREdwWnBHcFZqQWxnRUxE?=
 =?utf-8?B?Z2s4T0VjN01SZU5OZXZsV3B0VkFEcVBTWDRwMDh0VStoNWdOeEVJOGkzNkFz?=
 =?utf-8?B?QVpZQ3hLK2dkd3JNR1EvWFNKMjZ5S2hvZDhIdCtHQVdTcW0zRWtXQzA3OWZt?=
 =?utf-8?B?aWJ1YU14UHlacmswRi9kR2JoaXc3UGFqUnlwODF3SmowTlN3UjRPQWxrUGxN?=
 =?utf-8?B?WEdtS0sveEVZUU13YVRWQUxkUnM0ZjByMFA2WjJVTDUxTzhFcnN0U2xBcW9G?=
 =?utf-8?B?UmFha28raE9aUDVjNmJWUSsvdE9MRS80U1N6TXNhY25ObWlTUUErYjNBc3Ex?=
 =?utf-8?B?TjFFcXl2V0dWZE91eDJ6K0NvWTl4SmRFOE9EQVUzUU1WYUM3UXF2UGlFYlN2?=
 =?utf-8?B?MmtqOXFBNjBadmQ0NStvY3F0QmxvamFxWWZvYUZMTnBpazRlTnVPM1c5bkN0?=
 =?utf-8?B?cXJXMC95czM1U1hwZGplWG1JUzMrbGFXdXRSYzZJUnA1MzJYeXh0bFR3dENO?=
 =?utf-8?B?dk5kUUZWK1Q4RGU5Y2xIZ1F4QUR0ekhqUFFvc0xyNmhtaWpDZUJTTzFpYXgr?=
 =?utf-8?B?UTlsYWhROGc3Q0ZZRGpUSGZNWXljTHhoeU45clE2RWFsZ2o0UG53OWFxWmZ6?=
 =?utf-8?B?Zy9TdVJmVDlUaWFKRVpOOE9uQ3dJZjNzVXYzMVo4QmE1TnQ5aXN5VytNVStQ?=
 =?utf-8?B?R3JqSXBCaDlXQk1kVWhjd05kd3RpWG0xWjVLR0Ezd2QxRTI1L3h6TGVDTGhl?=
 =?utf-8?B?MzBIRTdtSnpsNlpVT0RlRjNaSVFGMFZWVkJHNWxJY3NyWDVtbGsyZ3RLelhv?=
 =?utf-8?B?MXdDRGNsdzZ5eHBqVTd4MVVjY28xV1lUcUdod2lJcmFXZzZkeGc4enNaWTJR?=
 =?utf-8?B?dFZSZ3FSWDh4Z25nc3ZmS2p4VE1uaW9zaWRiVnVCWmFaMU80eHo2Mk8raTcz?=
 =?utf-8?B?WUNxUlZER1JrSmxrR0M3cjhSMHNCeXBhbHRRSUxja3BheUNtL2NBSXh1azV0?=
 =?utf-8?B?S0Y3NXRoZ2VobmFqUGFKZGZxazc0MDExODlIT2dXU1NyMXY3OWJPV3ZKMzZt?=
 =?utf-8?B?Um92OWU3UWQrYmRYNTg3VkovWllnMzE2bVJPSy9mdEZZeVJFSEFmL0xIb0lT?=
 =?utf-8?Q?kXqusaXq8Uj64jkFTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344cb4a9-f6ce-42cb-1d69-08dee24699b2
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:56:39.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTlfB3xo8yQpn3I3iti38FUKszYuAYSBKT6vydV+xDLflNCi3KZuVqj9p/j2DRPSGDmrtAhGztxO4M45MqIOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807



On 7/7/2026 9:31 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:29PM +0000, Suravee Suthikulpanit wrote:
>> @@ -388,6 +388,11 @@
>>   #define DTE_GPT_LEVEL_SHIFT	54
>>   #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
>>   
>> +/* vIOMMU bit fields */
>> +#define DTE_VIOMMU_EN_SHIFT		15
>> +#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
>> +#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
>> +
>>   #define GCR3_VALID		0x01ULL
>>   
>>   /* DTE[128:179] | DTE[184:191] */
>> @@ -895,6 +900,9 @@ struct iommu_dev_data {
>>   	bool defer_attach;
>>   
>>   	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
>> +
>> +	u16 gid;			/* Guest ID */
>> +	u16 gDevId;			/* Guest Device ID */
>>   };
> 
> ?
> 
> I don't expect this information to ever be stored in a dev_data? why
> is it needed here? You should be able to reach the viommu from any
> places that would need it.
> 
>> @@ -227,6 +227,18 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
>>   
>>   	/* Guest paging mode */
>>   	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
>> +
>> +	/* vImuEn */
>> +	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
>> +
>> +	/* GDeviceID */
>> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK,
>> +				   dev_data->gDevId);
>> +
>> +	/* GuestID */
>> +	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK,
>> +				   dev_data->gid);
>> +
>>   }
> 
> Like here, the iommu_domain should have a path to the viommu if it is
> in fact a viommu based nested domain, and only in that case should the
> DTE gain the gid/gdevid.
> 
> Jason

Good point. I will make change to get rid of this in v4.

Thanks,
Suravee
