Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB353264D2
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405587; cv=fail; b=AIx6YyEFmiNwYqBkkycCtJQIGwOF/uTr/ak9g2W8tNW9SNGzxaT8NvH/UejPafj0/i0IRHUJhiJvj3AlP8Q0DAEP2biu0W6l4Z/Lsr4m17+TnE6RVYLupsNrAc5FmTyEwr87CAUfyuUqR7UjYWW6LIHg0R5hSKcRK6L89BQ1C88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405587; c=relaxed/simple;
	bh=c5vrmPMSL1pR9b5b/XbKBOdaLuCIRSohZEOgEHGxLas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOay0pFrYC5OxgApVneAgsIt0yx9Rn7kjrpDiJld+VsstbTh55sAf8Bose69aWoj9FT/xlhODh9mQ31cC665geXvfzJWkENqodEnMrW8suMIvgS9NMPlb1a47s1Sm/BchEDDoZQ0++eVbNyO4PV2TatMi7rLiHSvBOmpX5hwXyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBc+1AuB; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBc+1AuB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL1NnHWVqdxW8ZZsVP1RvAoG1gLjD/R9XKZDaFF/zLuZqYCyoKZXMCeMXArgs2f3qxqGuXsn7X8Y1EhKvPKVIkj/pnvfoTUSqQezaOuZ/ZXQnq2Lg4GLKUpx60KWgn6ZJXhshRSxq/asID5wz6QYVqHGve1ccuNlqorqfHayuLXcNh7Ct29XtbBFP5qumTiWAW59vrXhJmSRkA3nFdXTXgHI4DBQEeTtFw8D7vCmJ25cC+HW3Gw1tESoLpCB8sUNUdCuCzTMJ6PBnloS0VoNZKAyAI39V60Ptc+vP0lfYX6n0vRWV1XywRuvJWxiascg3ajJnJuKLpwbOH842AO+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0UodQwcfAE5G9ZYk4Vv4XjDyq+1hydbo16NwYZ9YeY=;
 b=Y0PuesOOcifSCNThsS0sJiuVJpFav6tBHTvAOADFqPCAkfiLT7DgbvwgwIW0L4R7LX102sQ2QpVTEQCic/q39YVZnrnKDQfQsB/pTEoSjMy+FR9Or82CDGY5GsyQK0Up42X/cKsyybUmngT0omjZoa5vw4013NXO360ir83waJFtT3dL6q2I7ibWDS4sX0DOn9M5T18rWBf3POfE4PQHURCE2DPVd3GMKBp8JmejVCJLEGsk8pxJselpFbeVQYNucULjnR+GH2n9tDDn0ZD9uQdVd2jztG2aooKH1ZMEJtg2L30LYhdnPkOAiwAkUFukzECqTxl0/DT7YjDPjEhPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0UodQwcfAE5G9ZYk4Vv4XjDyq+1hydbo16NwYZ9YeY=;
 b=OBc+1AuBL5L4dbeW9rcfwJIP25fKCjGXBjygc2uzMKIgWVBIDzLFJksPwAXB9lAiOiBhl+8CE/HZDppzzAxb6SysNSvFxkM6hhrPGd9ZxQJpO/JE3ESXLQeG2fe+ZbihJPvXXhWEZlki3GaSdmDy0iIczB9T9VOmscdpMaWSZ9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 3 Sep
 2026 03:19:40 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:19:40 +0000
Message-ID: <77425a26-412d-458c-9454-fb0a52b075cb@amd.com>
Date: Thu, 3 Sep 2026 10:19:32 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] iommu/amd: Introduce helper function for updating
 device ID mapping table
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
 <6aa64964-429e-46b9-83c5-5b029c698fec@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <6aa64964-429e-46b9-83c5-5b029c698fec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:820:d::21) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9860cf92-81de-4a78-452a-08df096a312a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|18002099003|10067099003|4143699003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	QN9d7A1BUDpqsGj1j8rbDvt2M1TRm9DW6ocrNLCmyq96Tw/G5U3mcxfo3P1Ifw1jOh5aXn+t6T5HuwuYipklEJBby7fqrKNy0Hy2b10L9Rw8FVfUQkah3OW9rec/lrgfMPBO8Gfe7IDcX/0t/UnJQp08/NAwD+q9brlY1UtFb7nop8TVdCpdDtzAyO0cFHUq7p4UPKPpgEjj2tgdjMOq459UbhTZFwK85VsI4d6qJKOHoikjhI8hUKmbR3LW9fh9pHUJ9ABAiXGLymxkjgHObNbTVxtVI4rwiltmeoNPRMa3wTgt07TTBZkjxCKfIrgw7dJEM+2mvGIJ11YfS3D4D/eeBM2J8LRMzEV2ZTMaIKbEKOb81ZlyHdH5mWeq8Hs54IVZDA/U143VYwMAkV7Q6S8cpTlZhpnTs5Thp5wb32EtVz/0b0bFV8PEhyT+Vzjv2x+mzJd3+JaUcnOZrVe3cw2Vl5YJNlf80zm15ynuJ3bPokagiaus5uWgKLoDtk23mLyUCDXxAB7AUun1ufdq/B6KAsAGXCV9g6FBeMFGPJ/SbaZdLesUdNw6CG552gAfXqPE780A8e6Lsp5QcjaZt+AhtevdE4uHQQjyeUm58IFUPE85CmvevGG/IYZpD98aOLWSAGcWak6TDzoxUEbvWIZFgamZT1RIKYcZ2G+2Zns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVMSktZYktMVnNUbWc3ak52SnkxWXBpWmxTUkdlUWp5NE1xT241N3dDcmdI?=
 =?utf-8?B?SWFtTEx1Tjh0RzV3azJQUENsQVg2VEptSmVIUGhLdTZ2dzM0ZkZvN0RORy9M?=
 =?utf-8?B?MS9HWlRSZm44Z0hkcXNhS2JKMzdQQ3g1SmFOR2NnNWw4eEVib0pNOEl3TFNo?=
 =?utf-8?B?MHp5dWtwRm1NelZvZzVYSkVuQStZYlV3VmtUTFZVYzVNQ3lGRjdDMDRmbXF0?=
 =?utf-8?B?SkUvZlRPeVpOWWJLYm1PcDVHbTFDdlVUbGJsM2VxYUlhU09yejJJVitOTnBa?=
 =?utf-8?B?WGViUkZJTnpRb00wdlJSS3dMWXdtam9CV09FVlJDand5K3JMbTByQ1VWdTFj?=
 =?utf-8?B?M2FsSWsxcmtmM05TNFRXWlRzelR6anhRbzhiK3NNb3BHbTI5Q3VjbUQ1L0FO?=
 =?utf-8?B?UlZIbE9pZGtua3RHZU1DSG9IbmIxVC9wQXdzdjJoQVBhY0ZrOUovRDdBL0o3?=
 =?utf-8?B?azRVME5jbU9YQU5TaFA2RmhDSDRWVEVjTVZYSGQ4TEFnU2wwOHg4TmJJdHJh?=
 =?utf-8?B?clc4YkNnZUtNdjgwSTZpSmFnZS9MbHlaTDB3SDhXU1QveWlFL1V0SEovd0lT?=
 =?utf-8?B?N1VKWUo4bHNIS0d2OFkraUR4Z3JiRTZLRUpteFhTdUp4YzhtMXhTMVNTUTlO?=
 =?utf-8?B?NWEya3p3VWhHcDVha0JLY0dlb2tQS25aeW8yKzFLVHBNanhPRXJrOVFBSllp?=
 =?utf-8?B?ckhFUVZpTWgwZElGNkY4dFRqQ0pyUEg4NEpLQXp6dm5FcVJoK0pJZjEyQW81?=
 =?utf-8?B?eGJUSDZIekpSbTVtSU9qYzdhNlRtR3lTR0QwMFhMc2QydWZJc1FZSFV4RHZS?=
 =?utf-8?B?eHd0WGtyZzdQOEZ0a2pDUEZsYXhaRHRVZFZuWlZnTitUaGs1OXZ0bEVsYnlS?=
 =?utf-8?B?a3VLbmdFTmFHTDl6Y2lOUVBabkNNV1gxcmo2VndDb1NMdW1RWUVGZm1sZm9E?=
 =?utf-8?B?elZwdnRqb0tVVGJMZGgyS2lLRWJvN2c1NmlCZi9ZSEhTZGlGSzZrRjBFTThq?=
 =?utf-8?B?RjFPVUtGc1JRMmVZTGJEaEpxV0lhZUZCVUZKQktGaEZSbUZPR0tHM3NtTHY2?=
 =?utf-8?B?SjVRNnRuY2t6OFNVSjhYSStmbkdrazRJQUR0blpTdDJaN2piQnBtb0ZaS28v?=
 =?utf-8?B?Q0xHTUVINk5QMW1Gd1NST1BwQ0x4ZkVIMmlZVU8ra3JLRW5aaEpNMFlRbVpv?=
 =?utf-8?B?OXRSNWJuRjJxU3QxVHUyTjJBYXk1Wmd1UllCUkZ3cU9zM1VxNjlBSm5Ra2ox?=
 =?utf-8?B?cS90T2kyVEFDSXhtZWozKzlwSUQyTVdWZWsyUmQyMXNLK2FJcG00T0UwS3dQ?=
 =?utf-8?B?ZHFZOVZIYUV1NW1QYzBDU1FEdVJjd3JFU3NqdzFBSjBvaVIyczlUTTJuNXVu?=
 =?utf-8?B?cGFrWHM0aTFEcWpsKzA3c3lNdlRkMnhJK3NuRWEwaEN3amdjVXZNbkxobkZK?=
 =?utf-8?B?Y2dDQTlhbi8vRFB5blVHT2lyTk1HeU5vYWRaVmtWTlJWa3pra2h2MWNKUlk3?=
 =?utf-8?B?eVdPWTYvdStrc2k5VjlSSzV4Ukk1dEs4R2N0NjVveEFvZnk3OS9mU1FIVEw3?=
 =?utf-8?B?d1R1NFpCVi9vZGVGRzYzT1UydmZCaGRUQ3dDL0x4ckx4dlJkNlFnQUk2eDZP?=
 =?utf-8?B?c1BQVVFpbHQwMmxmekNZcUVIT2RQVHYrR3lsQkE2ZGUzZVhvcUJWRU9TNGxX?=
 =?utf-8?B?d2tLOWdrTWwwSi8rcFNJVlhVMHNTK3ZaVnBJZHlMRWlHT3lkVlBCeno4bWhr?=
 =?utf-8?B?SlhUQlhYekUySy9GMWk2NFdjV255MWZiNERLQ0pVRmttTHo3M3FwZWwzbE5E?=
 =?utf-8?B?T2E1RFlOdFh1Q1d3OVhmMWVvbHU1eE5BS1V6ckszRnhoMkRadWVKemZZTWpm?=
 =?utf-8?B?QzdVNlFObW10MWZxSCs4Tm5aWnFYWWtaYm0reGd0ZU9SY29XRG14SXp6TG12?=
 =?utf-8?B?czE3VkloWjdPQ0VFUGxNZmVvTElhS0hrdWZCZ2VCcG5RWDNZSzNyeXBJaERP?=
 =?utf-8?B?bE5UalVFeVBJZHlGUUtWRGJZT3hmZVU4US9xc3R5MndFR2NOa0JidGdNMkhz?=
 =?utf-8?B?cC9WWkRpM2FNa1RxMWtDOXZZY0tvbEc5MlM2eW9USUwrbEMyaHozaFhTeFlz?=
 =?utf-8?B?d0JKSnV2eTBvUElrTy9LVnl6R3gzVERqd05RVTBlNmE0ek9sTWgzZzNPb2tK?=
 =?utf-8?B?Y0NpVkJvU2Q2YllINjdNRWtEcjhFTkRPMWs2LzFMWWZ5Y21LZ05oL01EZ0VT?=
 =?utf-8?B?Skgwcm9HRFVaQWNqeVJFVFA3eE84ZEt6L2pmcTlPUmFoWlVxT3NCUm9OZmN6?=
 =?utf-8?Q?xHVca94AEGGnmtOoPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9860cf92-81de-4a78-452a-08df096a312a
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:19:40.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvGq6vDaYaezCsYHI+eczQfuI1DdoCYlZ17LllQbhKtTS8zo5YCbiqgHzoFFcDAlnmUw01NWv8GIJk+yOzHFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116



On 8/10/2026 10:17 PM, Vasant Hegde wrote:
> 
> 
> On 7/27/2026 6:59 PM, Suravee Suthikulpanit wrote:
>>  ... 
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index 708f2c7496a4..eb3f5217d856 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -29,7 +29,6 @@
>>   /*
>>    * Guest Device ID Mapping Table
>>    */
>> -#define VIOMMU_MAX_GDEVID	0xFFFF
>>   #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
>>   #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
>>   
>> @@ -40,6 +39,7 @@
>>   #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
>>   #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
>>   
>> +#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
>>   #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
>>   
>>   LIST_HEAD(viommu_devid_map);
>> @@ -422,6 +422,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
>>   	*entry = NULL;
>>   }
>>   
>> +#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
>> +#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
>> +#define DEVID_ENTRY_WRITE		BIT_ULL(63)
>> +#define DEVID_ENTRY_VALID		BIT_ULL(0)
>> +
>> +/*
>> + * Program the DevID via VFCTRL registers
>> + * This function will be called during VM init via VFIO.
>> + */
>> +void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
>> +				   u16 guestId, u16 gDevId)
> 
> Can we avoid CamelCase?
> 

OK.

>> +{
>> +	u64 val;
>> +	u8 __iomem *vfctrl;
>> +
>> +	pr_debug("%s: iommu_devid=%#x, gid=%#x, hDevId=%#x, gDevId=%#x\n",
>> +		__func__, pci_dev_id(iommu->dev), guestId, hDevId, gDevId);
>> +
>> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
>> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, hDevId) |
>> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
>> +
>> +	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
>> +
>> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
>> +}
>> +
>> +/*
>> + * Clear the DevID via VFCTRL registers
>> + * This function will be called during VM destroy via VFIO.
>> + */
>> +static void clear_device_mapping(struct amd_iommu *iommu, u16 guestId, u16 gDevId)
>> +{
>> +	u64 val;
>> +	u8 __iomem *vfctrl;
>> +
>> +	/*
>> +	 * Clear the DevID in VFCTRL registers
>> +	 */
>> +	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
>> +	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
>> +	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
> 
> May be just call amd_viommu_set_device_mapping() with appropriate variables/flags?

Ok. I'll update this in V5.

Thanks,
Suravee
