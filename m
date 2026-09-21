Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C545D5FE
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981869; cv=fail; b=euU7SNI/f1H5JQHA2PGIkt7YH5TRVuy3ye9+4iU4HtuEBHJC5Fr8wrVNWUAK1KA3HSlKSv0Z4Ms/35Lcr2A5uIPXVWF8R6urHivjcu6zQNT1xpwK20UKKHMKMH4BWtnq0ik+8v3i0YGkc4mKqElr6NCQ7WRakywHxvmMpUwGRls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981869; c=relaxed/simple;
	bh=Iv++s4tpjH5gb4LRmzTmyS8sFrdOKqN4jrCwlhmgv1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZQZFoy3YO/A2XrNdipEoCP8GbIBZvRLHt0qyXb26m+bKnqmRJtofi6XHBHdbZPs9fOPxtOPyNmTekSVz9UJHZeRYpvBT/Wf7Yomr7IlsUmh1Mqy6iTX2ZvqWXt9YCCL4TVK5iaXHeK5rx7F3oU+YOsXCfRnMLP8P3gpySPstrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h5UQJKj7; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h5UQJKj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ7eYvosb3syf0egTcQ85NiR0MY+v6HfWmDIfj8n9nV8uQu6l3PBgPBB5GcrgS+hkZxIDNbEXv0uWcU4Tb2uxgdgnv0FTlmaYWNTL6zwL9N4B0OnWxqxQzeB8kU3Wa8BSwxEM3XobYuXjag6OMnOBgMAtVlORo5AQYOLJA1rbGOyJnSx/rRwJwovxrmcZJzg7D/bG4tG26JOmvdnDGq6hXuicZFc+ef+FWLs9B2NxBktgtHbClQFJ/Q61BXNm7vn+VjFXNEtNuUbNHiiu2r9pHcARljFO4Fty1IxNhgKW30fbxOuRakd73uMaTmAt8xmMufhMcSNO1TyVHcKcldMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYnu/SYDdCD8NyAPpEBzU9DVs4wojPHWKLF4IxZppz8=;
 b=ZTTMCquyR2SCXCQPeUHzXONDOeBpJ5s2rFMGGBR26Vt2JT4MuB2aaDUWk6esqdXTqlXMRRkO9B+TefSF2TG2O6LdMGh2UjQJlb64LlrsEnFeYVGO2UP6Hs6PNzftUZJv1ttd1ZpmfoyVryU8Mbk6AjDJMyCxpcqUxeD4m/Vu5DaGF16idWb6TdGiO8SMFwgDnGLsky8+EuCACFPZfEiBcJP5t58+79e+orRcyxPxPmXcYuyBnC/CxFgYi+0DwyZ7S2LtWU5amfMe+TjYJh+fhKdl5hWf0rQwVY5TrF76ydnt7Rx3106uTgqLCh3tbOffz+8NzXNA83shgOCYGeYa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYnu/SYDdCD8NyAPpEBzU9DVs4wojPHWKLF4IxZppz8=;
 b=h5UQJKj726oae4SyRoSgyFATnR916zLtGyqaQT+peXmo3+6QgILly/WbNKa7Gvn626bBhOAo0GdANQ06LVUdC7lw3BX/Z5mOZ+mfm+QasMUWM3uOS9e2OQ3p2kZL+RqRP16GKb1UnR+N0K4SGcgFoDulFUpbFJFZT//pAtCjlA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:11:04 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:11:04 +0000
Message-ID: <8671fbb9-70a5-44df-b89c-c6dcf9f0e78d@amd.com>
Date: Mon, 21 Sep 2026 16:10:49 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/24] iommu/amd: Introduce Reset vMMIO Command
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-9-suravee.suthikulpanit@amd.com>
 <d1f568a0-a273-4e4b-853d-5c826b2af50c@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <d1f568a0-a273-4e4b-853d-5c826b2af50c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0008.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::6) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d56da3-95e5-4fef-7b74-08df17c04309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|11063799006|56012099006|4143699003|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bdWlu6nsc/uK6xO94H6/DgUv5t7Zkv0vuF0KO9DiRU7XaFV127g9HzM7917A9CFwohLzGdAH8ks+Ro5y5q0RQmjjERC/4FlFik0ZpgpvubVj6k6EdhgJ+Em1TXIhOlfykd+CTPVXuEaLQANk09yJAf6z16NBpv21j3XXNaIORHSSJeWieHGHSDTXktLyr+riQWk9y1agrlUzSoRHt1h0RrIZ22Ve3bvlorJfdsWtzbLy3blZRnml+BtjxjDS96tIr7s8V0tli39Lz5U4rlwunsa1JR3LKK4YtLIIy/BDNMMNjhCs4KyLq/yw0aMwOyjytjNvaDqdfCpiSqRf5xkzMttr0SIh4AWJVjt1AxJ1nNcs3oqanpsKMktQMxAPtJECFLpxZgy7qYdBWt+ci8OQKo12xRAbcDjOHqjCeycNMqOlRWfmHA+cB8g2lC6NiCcwJbF7olWf93QeiVkMEAKPx+Kusm0SDtYxlBKJTCNiCcQiS2BuYqX8rqnLHEWhK+8FSVCKnGdIAXZG9dq0cODY34kirSEmtDXsK336ZOTwvr+q+/TLDNBSmmJS3aiXQJlk9/JqGvYAxqMF0kKFDUX0BselilQGZK5bfXlBWMwJOl11sFPp4qmodB91zI2zgtct
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVsUG5tWXJCaC9OMWRsaW9kUEFXNWZvbVlEenJDK3JRbmh5VHhhTHhBTXM2?=
 =?utf-8?B?WGpyQXB5TmpoWGJ3T3VUNjZJamQzWFUyVGwyMEh4MGM5WVBUZEx0QVBlYUdM?=
 =?utf-8?B?cW9YSUQvdDRHME9KeTEwV2k1QTdXNE85cTBCOC9KMTNYMmNrRzlURmMwUDd2?=
 =?utf-8?B?aFlRL2o1S3ZhY0U3S29JdS96bWYydVRBLzhJcVhOSWFqZnlzOTdrOEVpV0JS?=
 =?utf-8?B?RkdCQUlyNllCNWRqYms1T2ZySm9oZGNOT2E4bEtUbkNqZnNvRkdLWG1zbVVs?=
 =?utf-8?B?NVZlalpXK2wvcXpsZ3VpMHgvbk1HbTM4V0picTczeXlrTlhBZktGM0QxTy9U?=
 =?utf-8?B?VVRIZnprQzU1Z29aUjI4enFvTGU1djFiWkZMMUJtbDFtd3ZSNFJVQS9USlpw?=
 =?utf-8?B?WnVud0YxZkF2c0p1WGhMM1AzU3AwcEZvWENRbzJYbnozOENiL1lYaVdTUWdl?=
 =?utf-8?B?aWRPbU1nRkx5dW5ReDNlcyttQWdHMHFQZndTKzhNRzdXWXhQUXRKbmNxU2Nv?=
 =?utf-8?B?R1NSb2JhUG5VTzcrTkZ0aDFGUVkvQ3dpV005ZUJGQzArT2xoalEvL0tLU05q?=
 =?utf-8?B?SmVKV3lKeVhYaENnaW9KVGluU21vM3VsSHpESVFFT1Y5UFU3SnVZQlhyRXRk?=
 =?utf-8?B?LytWbno3NzY2M2FhL1BCU2ZmUVhodWxJV05COGQrMWF3cUhnM1VibTRsTVhj?=
 =?utf-8?B?bWdCUWYxQVdZeGVUelBVbGJIa1RlNHlCN0JFaXN1bjJXbjZuU0JGazhCcTd5?=
 =?utf-8?B?UmFYei8zTGFlSnd5dDE0WmhCT3ZrYnVSUmNOMG5WaTlZWkc2YmJCNmVFMkNR?=
 =?utf-8?B?Um5zV1RPbUlsbW1PYXhWZ0pMaGlhaGhoWXh0UVpNR0RRTndKK3RQOGJLK3ha?=
 =?utf-8?B?aDl2VGJ0MkhvVnlLZ09mSVVKbDk3LzRiZkE0ZURQZGc5ZlVDeFFENTBTMmc1?=
 =?utf-8?B?T1d4MVNITjNoS3JsOW1WalpQQitSMUNKakVJU3drUlRBdHlkSC8vOFhOMUI3?=
 =?utf-8?B?TjBZemkrTWlqOFJUbTNPb1M0MFFTaVpOeXlub21mZTcxUURGZjVsM2RHRGNQ?=
 =?utf-8?B?VjNxY1NmNWhaSkZMYUdhMXJVY1FRdjRPTGtwK0g0VEFqbDU2QXFXTVhrOVlH?=
 =?utf-8?B?MFB4RHd2MFN2RmxHSXRUU2FNSmNxM1d3eHFZdThDUWp3aUtGRnNhZkJkY3Yx?=
 =?utf-8?B?ZWlCQVVEZzRaV3l0d0tKcU1ZeHM1dVNMS1lBK1VFOE9UQVJVSlJDYzk4R2hh?=
 =?utf-8?B?ekxCR3ZtUC93bVBqTkZhVHQ3QkhFaWpvZ2p2dXlRMGp1SXFXQmhoVzVFZUNJ?=
 =?utf-8?B?cDJKU2UvcjZ2R296RTBRVmMwQ2J0TUI5MVF5QVJoYmlFME04VE9xcWtrNWVn?=
 =?utf-8?B?ZFlnbmtyS2RCaEhxQkVzMU9rVGF4UysveDM0ZzN5VTR4NzBUaWpZcUhYSko1?=
 =?utf-8?B?Q1l5VkFmZW1YaWlQRCt6T25kZ1N0MUhaNFFDdWx3QnJ4TXY5UktILy9zLzlp?=
 =?utf-8?B?Q0YyQ3plQ2FmY01uZDJkNmZhOWpCZWYwSTY5aHNCSDh5S1kvb0VTTEVtSkdv?=
 =?utf-8?B?MHNOdkxoNnNUd0RuMGdlQWdYMFZMcnBHZUJYTjFrRkFQZXVXb3BubTd1YjhH?=
 =?utf-8?B?UmlrbzFUVmdiRmpjd2I2RlJocUl0VkEzamc2dnh0ZE1JTGxKOWZRYTVFSkEx?=
 =?utf-8?B?WHBhdEc1Yk5xRGNrMi92eGoyaEwwR3RDNG5nc2RCK0x6alg1eEhlUG9pb1kx?=
 =?utf-8?B?aEtZVTk4eVM3RGFpeDNFaURTZHpSUXVwMHBNbXVtRGw0ZDkrbWo2ejc1aUJw?=
 =?utf-8?B?ZFlZM0h6c3ZVS2Z0U01ab25zZnVka2NMbXA5anBqT2YrdVN1YXFOckZpUEdW?=
 =?utf-8?B?SDB4R29UaE5QY0E4dEJKNjhQdFA5dkJVbjIxdVJ3MEpOTW9RUUxXY3p2SFp1?=
 =?utf-8?B?TFRHOWN2alZMd2l2akg3WUVCQ25TZUxGa1RLQ0hkMzYreGovQjhFai9aYmc4?=
 =?utf-8?B?OVV0V21UK1phcWxXYitrRkIzY0M1L3YveGIzVlZjWE1zWnZCa1Y1aHRPNjM5?=
 =?utf-8?B?bXVYekp2cWtucHJQMUVGQzlmTHhTbzhNeEY5Ny9NY2QzbU11MlB4RWxzYllt?=
 =?utf-8?B?WFJRVVJ2K0ZBODlMZ1RHOHd1QS8zNmdTaC9Ldyt2UTV5dlZLdjZPQ1pqZHo4?=
 =?utf-8?B?dllGd05UZll1eE1ndWdqM2JaT2lQd05SUVY3K1U0Yld2cU5UUWlZMG83LzU2?=
 =?utf-8?B?elZ1Mzk2aENXd29PL09LWGRRb2FnYUhXa2Z1emltR3prcHlLem9zVjltZUto?=
 =?utf-8?B?Zm12azJKSDVTcGpGK0hQdU5VK01SY2RhUjY1RHQzbkxMMzdSNXFIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d56da3-95e5-4fef-7b74-08df17c04309
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:11:03.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBaFvNpQ++okfMF1w+IHzZrKdwL2zFkoS+0E0Z9976fnVHYW3/lUPoBiBvmYDfp3XRHXIm+4kZNnBFakOimKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320



On 9/19/2026 10:11 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 
> 在 2026/9/15 2:47, Suravee Suthikulpanit 写道:
>> Introduce new IOMMU commands for vIOMMU to reset
>> virtualized MMIO registers of a particular guest.
>>
>> Always program RESET_MMIO_ALL_FLAG and RESET_MMIO_VCMD_FLAG.
>> Propagate iommu_completion_wait() errors to the caller.
>>
>> Reviewed-by: Weinan Liu <wnliu@google.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu.h       |  1 +
>>   drivers/iommu/amd/amd_iommu_types.h |  3 +++
>>   drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++++
>>   drivers/iommu/amd/iommufd.c         |  5 +++++
>>   4 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/ 
>> amd_iommu.h
>> index 51e4364e8564..8c298e090889 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -233,4 +233,5 @@ amd_iommu_alloc_domain_nested(struct 
>> iommufd_viommu *viommu, u32 flags,
>>   /* Guest ID for vIOMMU */
>>   int amd_iommu_gid_alloc(struct amd_iommu *iommu);
>>   void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
>> +int amd_iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
>>   #endif /* AMD_IOMMU_H */
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/ 
>> amd_iommu_types.h
>> index 3aaaf69a1e7d..9eb9a0c190de 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -209,6 +209,9 @@
>>   #define CMD_INV_IRT        0x05
>>   #define CMD_COMPLETE_PPR    0x07
>>   #define CMD_INV_ALL        0x08
>> +#define CMD_RESET_VMMIO        0x0A
>> +#define RESET_MMIO_ALL_FLAG    BIT(28)
> 
> RESET_MMIO_ALL_FLAG is defined at the wrong bit position?
> 
> Per spec Section 2.4.10 (RESET_VMMIO Command), the data[0] dword layout is:
> Bit 31     : VCmd  - Reset virtual command buffer for the specific Guest
> Bits 30:28 : Reserved
> Bit 27     : All (IAll) - Reset the whole virtual IOMMU for the specific 
> Guest
> Bits 26:16 : Reserved
> Bits 15:0  : GuestID
> 
> The "All" bit is at position 27, not 28. Bit 28 falls within the 
> Reserved field (30:28).As currently coded, build_reset_vmmio() sets bit 
> 28 (Reserved) and leaves bit 27 (All) clear. This means:
> The intended "reset the whole virtual IOMMU" semantics (including 
> clearing VMVld in VF Control MMIO Offset 10h) is never actually triggered.
> Writing 1 to a Reserved bit has undefined behavior per the spec - it may 
> be silently ignored or trigger an ILLEGAL_COMMAND_ERROR event depending 
> on the implementation.
> 
> -#define RESET_MMIO_ALL_FLAG    BIT(28)
> +#define RESET_MMIO_ALL_FLAG    BIT(27)

As I mentioned in the v4 here 
(https://lore.kernel.org/linux-iommu/20260727132913.22475-1-suravee.suthikulpanit@amd.com/T/#m6d0d1670600e1217b6138fce7d936805326d9bb6), 
there is a typo in the spec, which will be corrected in the next 
revision. The correct position for ALL bit is 28.

Thanks,
Suravee.
