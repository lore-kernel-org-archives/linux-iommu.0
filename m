Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAF29DB9A
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251320; cv=fail; b=BLKe7DyCe6zmzkjipILgYgVq5D/DARL9JXok6ezAozF6PCgPQbydMRg8dsOrTyLKWvQ08imTmeaW04RTIzVkbe83UUQrIx0kZh1qRglknNKEAWc0QJ6BLY91FT4A20VStfwBx7sBbvMNEkEtREcbYJevtfykRTrj+iZpuT+0ptQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251320; c=relaxed/simple;
	bh=WMuY+QO7o5CaUdnN57nQb5SUeOm/XPQ1uMBJmTb4RaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sfnj0O9cfvycucMetlpKi//d/+nWJCEo+aLuvv75no0Tx1Kg8zFVxM2QJQw8MRZMqMz6LhFPANHcaLj/aK5MhnP37X48uXBXX4yQXR2+ahlVGND/BTSmSrtXFVSMIS7ryxFHnOSAXHbjyDc8sI8kuXTgcZk+MpEq7rugsAU+D0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F8wwlFsD; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F8wwlFsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGwISEUlA0Bw28hSFhEc3JohG4Rc8AMVL6Tm6c866x36L9FB5x4fN4qLWVB29/QFjcKGXwFj72/1DbIPSdiRIcg1nTWJhVTFG2EewrAI+Do3630fj6I74utyxL0j0l4kXitcTNWcsr45RO4IPbeJsE+7ubRru8TJmXK3wwdFamBNa7zGeOEOO7Z6ylVP8t1QwfNGHSKv+V+Q3UNssUVb2xL5O6FyiQOvwswR6niuzGf6NBQBxEFGTbIu6OXCsirHLbjO18sqcCsvuB/3Q9Ez6+IUDEmL+RCZou1qoEPzq89ib2WjpLEWEgL+c6HQLflm3i5/0srYFsrLb0hjzmxelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MmQoteJJUf2WI+y5/E5IaoYp+uoSucBOmiDZNseioA=;
 b=y8qCCm5zgbAsm7J9+iqM4JYa/jlk5cxWzUNmfy52tqVGwUFtOLqwInlJs/Ia5CaGOdmOPA/tRjgmb0UVObf5BqlXDc3/2jrvQD2f08awRDn9D049aVdFu7ZSCip7assHCEB+wKxLHpqF34h4nf4yt3NIZJVCJMvJqgQRt5dYoY5SlK8HoPol8PZptnbAK1PVu9ZXcJU4VzYyiZQ4Q8Wk7yK/vhACLewh894LjAOsrotew/j6mUy/izoKl//1uYgirUKorkDCylQU0DuH72eH3HzmtA54PvYH7HLYO6yn1lkutR/wnEnxNUJ8cKWQrq4uk9CnV7XxRP3/hl2sdoiJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MmQoteJJUf2WI+y5/E5IaoYp+uoSucBOmiDZNseioA=;
 b=F8wwlFsDsiRyWIhhJ+9qxM/UZ86V7VLAr4swi8wFHXQJZk5BpiiTIE8mHCVsFLfgEz158dWdIj9lJXfwKuMhdt+F2kkMhTwkX6JVhknnGdEOBrLxHrclWxHk+Ve4E+gw9lcekuO4JbdUQ2AOHJ6ZDVcz+OzZhGyEMZ+a1N0tK0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:28:34 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 08:28:34 +0000
Message-ID: <6dc11f18-d03e-4e53-9f46-60882ee4b2d4@amd.com>
Date: Tue, 1 Sep 2026 15:28:26 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] iommu/amd: Introduce vIOMMU-specific events and
 event
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-3-suravee.suthikulpanit@amd.com>
 <1f2011b3-350c-46dc-a21b-69baaf059af7@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <1f2011b3-350c-46dc-a21b-69baaf059af7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:820:f::22) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: dbab5c25-2c59-470b-7507-08df08030338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FZORUDwpUBV899UWHcR7rnRofXRfpVtS33hzTk8mOM4Q9YLzNvH3uZKK5KoRJBMLMdULNiZD/MCEZUQJehCc3pW5Ytub58ZDUPBuYQTBmqZy3krkg3M90fWqlZ/2sBbJIkvUndfvyKweZMJJrEEYGba7zn/T5skZrMbtUWUKj8FSGSsG9Oe/jbCD6eIqS7W/J6T+XquzDjQXt/pn675b3Z7/3piAdoMtGFEtYusT2utob3S/j8EuQwRXvgXbvtu0brnJti9x1e2qmiQiGHlik26L9otIb/TQBdni6PhN++tqgiUL+dCaC88StvEIGf05f/bHfzMS52WosFUUFBDoyZmDeI7BYCAjbdNmUtOPiYA71kMrVVUH7vRf4Hul7j1pL8+N/PTJiE46e/o1VRaITJFQS0CCSwaEIIz1XW7Vc16xb43Xf/IssWOeK4lakZxJMpC6P09AORs5c3TAvfv2iY+P6/j5VD/SKyTXkG6+79B/7CiyM22+uojDwuuR7lT2/4F8/fFHcFdPsNFnFnAjLzCuBRXCJ5KwulrjSUsr2k89Jziz7xwQj84+aq7/WlWH5Z9gmryfat4uamMqev2UYKFGVzndszYpEd0RaZQBeJJ8TsDaAk/gm3wZWkG9yDlRdkRkp1mBLnngm9xbpV+zJeqiUUYs+TGOt2MRp9K3cPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFyd0hHd3dBK3VMVm43SS84akszaVp6SGYzVXRHeWdGa2xEUWVNVkRkUU1F?=
 =?utf-8?B?MFQvRDVjU2tHaU1HY1B5UjV2MEtvWWViZzZKREk4bWsxWmFvdG93LzllSVZh?=
 =?utf-8?B?d2EyM1hTZExyZDc2TjFmajVYSE9tK21pZHJTK0dGa08xSCtDeittOEgzWmQ1?=
 =?utf-8?B?aktGbGxvVDNkY1Vnd1FSTU1zVVIxdjJqVlJIay8yTjJWL2RZcFJ6WlJYMWVw?=
 =?utf-8?B?ME1GMTU1WEV4NXFPb1AwbmIyT1NuMVprbkZ2Rlo5MjRiaXE0aGw0SmNkbjdx?=
 =?utf-8?B?S2EwYWtucUJtMGVtcHYvaWx1SzFCbUQxcjNzT0x5Z3c0Z2VsZHI3ODZ3eldq?=
 =?utf-8?B?OEZwUi8xUzNZa3pXS0VJeGN5ZDhtYnZHaWtSNmp1aHF4R2JRQjB5ZUllOWxx?=
 =?utf-8?B?bTFoVHRFZDVFeW1velJYeGpBR2FCVGlua1JZUU11MUZ2aitvVDF1K0IvSTR5?=
 =?utf-8?B?UGs5VXptYWQwc1NMZjhWSitRS1N2MXVYRjkyTm9WOUdZTjRQelVUcWNoZkt0?=
 =?utf-8?B?SEorTEF3UFpUeVdBMm51ZHk4bDU4dGRhVjJVMzUzaW1SZ0M4bzFuQTZ3c2lC?=
 =?utf-8?B?RkhsUCtvMXpxcDFNRWw5eUhpZHdDMW5aZHQrSVlZNEdCN0hvTTcyUG4xZkhW?=
 =?utf-8?B?YTRYaERtbjlmUWVjbXlHV2Zrc0puSkErZU80UGNySy9zQjdFVGc3aytndldH?=
 =?utf-8?B?RGFld3QzWmhYU3UzdmhXTjN0WDB4Um1VejBteTNQWmpaVkZld0haSy9MV05E?=
 =?utf-8?B?WW5zMXpzaVc2MStyTndFcDB2cVpvaUpXcjVJT3ZzNTdlZlJIRWovN3JoQ0pp?=
 =?utf-8?B?QnU0UXZudzlmcjZzUEpUdjgvd1IrSnVMcjlMKzBHNVVWTktUTmMrNGVxZlpG?=
 =?utf-8?B?MzNpYUs3U3dBKzBjNXllWERzVG1rKzVlK3BlUytHakZubGlhL21ZMXdzWmZl?=
 =?utf-8?B?TDZrLy9ZNTBkdW5sMmZSaWZ3RmJhdi9oRzNrWlNFVmZ2NGQ5ZUNCV1h1YU9N?=
 =?utf-8?B?dGxPREVPS1dTc3NpMktyWm5zalhsYmRJcjV3TkMwcWZKRkEzazIySWZlS2dO?=
 =?utf-8?B?TC9WUjI3Q3JGcTIwVy9tVHNPUDVuNG9WbFVGbWN6RjhCYTBEYmZMdlY1WWx0?=
 =?utf-8?B?ZmlVR2RMNWRMRUtIZjYxNUhHckZCbjQ4Z1RQMndaTmF6L3NLdWIrTjlVeVZZ?=
 =?utf-8?B?Wnc5RWZUbDZyL3NHQWdtZ0xzdGhsM3BKMmY1enJQbzJpalM1QjBFQ3VoNmRE?=
 =?utf-8?B?TUR2ejM1UUNqWkdKeUFIVnBxYm8yK0kvODJCRElKVXpOc1doSTBDTlIxZmxK?=
 =?utf-8?B?SnY1VTVjOE44OEZrRldGTkNLdzMwa2thQVRSUEVvWWNiVTRNYlc5R2JpSHBS?=
 =?utf-8?B?TlFqaFFuclY2MWdQSXJRN3pSS2d1MWVjTXg3NGQ0WjBQWTgxZVY1Y05sSE4z?=
 =?utf-8?B?bUxvL2cvTTQvRFR6UVhwL1Nxc1Y5bjJpQ0VjVHdUTWRQbFI0UWlFRXUvVFBt?=
 =?utf-8?B?YWZDWnpqRUFVMGRXayt1VUJvMXR0SFN5Vk1qdUhZYlIxdlBVQXZFUXhETE1T?=
 =?utf-8?B?REJpZlQyTGRRNUFYKy9raTMrUlVCZVdIQ2JESzd4WXlWZlpneTBsR2FwN2t4?=
 =?utf-8?B?d1lKVk4vR1JwcEV6TmVHUDhDclB5L0tVTWtmKzh5aksrNTd2ZWhsbVNBQVdt?=
 =?utf-8?B?V1YyK25pVzZOVnRDK244UXBRbk9pNUIwdmJRNFlHemU1M0g1c3ArUGdOeXhq?=
 =?utf-8?B?dmlCYjFCU3dBVDlNbUpHWHhGSEo1WnFZQ0dnQ2ZsUlhuNE1PQVVDSGd2dlNG?=
 =?utf-8?B?QmFpTVRFWElySndBNlJOTGF1TjZzREpSVE55RkJhZVN6dnlUZG84MW5ndzZY?=
 =?utf-8?B?bzN6cUtwUkY1ei9ETElnL0lWUW42c0pHdmtWUFE2SFdBUUM4ZkIvOHFDY3Nj?=
 =?utf-8?B?cGRieVRUTmpjcjNJaVZhVnhzSnJHT3VlUDlyK3JNNlJ0S1YvdUdIelFZbHhU?=
 =?utf-8?B?djduWVhBemQvV3RCOWFseVBMVUJjbFhDUFFRaVJxWmNzWHEwZ3lob2VQMlVx?=
 =?utf-8?B?N0ZyYWdNOGd6NGduYmh5Z2c2cVErUXc4Z3pPSzljbjJMRFpuaWw1Vk5jaFRJ?=
 =?utf-8?B?dnc4YnFxOTRhTkJ0MmI0dGpXUHE5MEgvenY5UkFLTXdCL3lLd01zamYvVE1X?=
 =?utf-8?B?ald0VUhCemhBdUVJdFZoSmprMEJWbUluS0VERjRaZUdjNXhCUHR4b0ROeTdU?=
 =?utf-8?B?bDVkcVFvNVZkSDF4QlBLSktld2JpNHkxOUM5VzBBODdJVTliMHcvOUdxcW45?=
 =?utf-8?B?NEsrSHRCT2UrVmdGTi8wY2ZJeVY0aEIwaUdmcGRNbFRiYnluZ2orZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbab5c25-2c59-470b-7507-08df08030338
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:28:34.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T81h5jQCiXwLAtK/NYDUYOtt80IbYn27Wtv5ByvlDf7ItfveONT3GNxcvNWoBvvZxghoFYIrsC8jw0rmjD9AHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409



On 8/10/2026 2:12 PM, Vasant Hegde wrote:
> Hi Suravee,
> 
> 
> On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
>> Adding support for new vIOMMU events:
>>    * Guest Event Fault event
>>    * vIOMMU Hardware Error event
>>
>> Also, adding support for the additional vIOMMU related flags
>> in existing events.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h |  7 ++++
>>   drivers/iommu/amd/iommu.c           | 58 ++++++++++++++++++++++-------
>>   2 files changed, 52 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index d2c64e2e9f05..4df6a50128de 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -149,6 +149,9 @@
>>   #define EVENT_TYPE_IOTLB_INV_TO	0x7
>>   #define EVENT_TYPE_INV_DEV_REQ	0x8
>>   #define EVENT_TYPE_INV_PPR_REQ	0x9
>> +#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
> 
> Better `EVENT_TYPE_GUEST_FAULT` ?

I want to keep this consistent with the IOMMU spec "GUEST_EVENT_FAULT" 
event.

> 
>> +#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
>> +
>>   #define EVENT_TYPE_RMP_FAULT	0xd
>>   #define EVENT_TYPE_RMP_HW_ERR	0xe
>>   #define EVENT_DEVID_MASK	0xffff
>> @@ -261,6 +264,10 @@
>>   #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
>>   #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
>>   
>> +/* Constants for IO_PAGE_FAULT event */
>> +#define IO_PAGE_FAULT_VFLAGS_SHIFT	27
>> +#define IO_PAGE_FAULT_VFLAGS_MASK	GENMASK_ULL(27, 23)
> 
> You mean  (31, 27) ?

I'll fix the mask and remove the shift since it's no longer needed.

> 
>> +
>>   /* Constants for PPR Log handling */
>>   #define PPRLOG_ENTRY_SIZE	0x10
>>   #define PPRLOG_SIZE_SHIFT	56
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 4b4dd20ebec6..50f26c8123f3 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -854,7 +854,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
>>   
>>   static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>>   					u16 devid, u16 domain_id,
>> -					u64 address, int flags)
>> +					u64 address, int flags, u8 vflags)
>>   {
>>   	struct iommu_dev_data *dev_data = NULL;
>>   	struct pci_dev *pdev;
>> @@ -889,13 +889,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
>>   		}
>>   
>>   		if (__ratelimit(&dev_data->rs)) {
>> -			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
>> -				domain_id, address, flags);
>> +			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>> +				domain_id, address, flags, vflags);
>>   		}
>>   	} else {
>> -		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
>> +		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> -			domain_id, address, flags);
>> +			domain_id, address, flags, vflags);
>>   	}
>>   
>>   out:
>> @@ -932,29 +932,42 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   	}
>>   
>>   	if (type == EVENT_TYPE_IO_FAULT) {
>> -		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
>> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
> 
> Move this assignment to up where we extract all other fields from event so that
> we don't need to repeat multiple times?

Since the vflags is only available in certain commands only. I'd rather 
keep them separate for better code readability.

>> +
>> +		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
>>   		return;
>>   	}
>>   
>>   	switch (type) {
>>   	case EVENT_TYPE_ILL_DEV:
>> -		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
>> +	{
>> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
>> +
>> +		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY deice=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x vflags=%#x]\n",
>>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> -			pasid, address, flags);
>> +			pasid, address, flags, vflags);
>>   		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
>>   		dump_dte_entry(iommu, devid);
>>   		break;
>> +	}
>>   	case EVENT_TYPE_DEV_TAB_ERR:
>> -		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
>> -			"address=0x%llx flags=0x%04x]\n",
>> +	{
>> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
>> +
>> +		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=%#04x vlfags=%#x]\n",
>>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> -			address, flags);
>> +			address, flags, vflags);
>>   		break;
>> +	}
>>   	case EVENT_TYPE_PAGE_TAB_ERR:
>> -		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
>> +	{
>> +		u8 vflags = FIELD_GET(IO_PAGE_FAULT_VFLAGS_MASK, event[0]);
>> +
>> +		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x vflags=%#x]\n",
>>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> -			pasid, address, flags);
>> +			pasid, address, flags, vflags);
>>   		break;
>> +	}
>>   	case EVENT_TYPE_ILL_CMD:
>>   		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
>>   		dump_command(address);
>> @@ -986,6 +999,25 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>>   			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>   			pasid, address, flags, tag);
>>   		break;
>> +	case EVENT_TYPE_GUEST_EVENT_FAULT:
>> +	{
>> +		u8 gid = event[1] & 0xFFFF;
> 
> As discussed offline, s/u8/u16/. Also may be add a macro to get the gid from event?

Note. Fixed in v5.

Thanks

> -Vasant

