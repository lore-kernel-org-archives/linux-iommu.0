Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEF364935
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931751; cv=fail; b=i4Jpm0Th1dPlmTorLaAN5pQIOnyHHpjHsxV6vQiJs3lZlMzQ33jcaIHsAR90K/IrQYbXRXUm15qyJnLBSfpeVdQMWey8RmwtE29YlFe7yCYoktG9PAxPNdaDBXnpZC6c7te9aK2aEt3R3RMmHNrFXCGpjl/sLhD01JrjPDfAS2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931751; c=relaxed/simple;
	bh=BG7l7lCVnmCz7rQoPyLBpaJCuBcv4w9O6c8DMZW20TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=We1aG6rBwcPsGpPtbhdf2z1suMtM4NoWSo9UoRdkX8Fhjy/GG7XktqrdyPMxC0+mts+Lyz+wvy10K2SRmAOpH6DifTaf6z5UoaR4QbyecQADvJhcl2yFV8uDFM7suhC4QdYJ8jBEXz28R45WMqPaZZXFtxSV8g9DT7KqWWr1mro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M+6TmmAj; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M+6TmmAj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKVw3VKDseIRimNjtgMemrj3FyNNs0XnWu0xW8Xe6jbfzxnczvZfupClKX5bPDvtkU9BYNloVH5daf6cD6FGGMmOKYz+LOh4JgkqoVYxn8+2HOouPWpCEPC++kdXnVE+ClOxeks7CwbxDDwZBR8clMX5NQPjaZ1VXqEM3qj8AP8TX3VeVu9UUlOPwzljRNGO50b/0SyspIWXkVXzIR0AaO2s1rJvgPbwNKdtuQyb4KwxwtJmDRbWBg3iosK3ARXHKGCbVWuj5TXlxtUJBPKtVAWLWqx26c+M8T1zFsQfrn0aysDrgjlVwPoVsSKIDPwyrsYhm0N6Sd6I+AUyjT5Ydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isUbBBqvouZg0YQtv1VWrtnYxouGeHfL4IdwSYUWMak=;
 b=AfyyLZDVBNPNpPtul/lI+tMLOY6Kdb//qrfNklEnzGcCjqSj2+rCr0t8KSepc6rLeBYq3FaL2BeuLTBVhllIdhArCnxMvG8IPMJn/uDYHg5Ia+kNXGrOmVvCJPCtUgNebdEKJWgvOzHqA8so8Xc7Kki93rgmmaT+dsNSH5EkgBbDTzzwYxjx081zXzmc0ihe9QVAnq36urny+0Pcwi+0a3A8QuZlzroLce3v+IwrKHJrwKNCUxe8y05D+Qon24jx8a1Ydn22J/SlH1HQbUOVXJHJK26wg2G4pRp6NNDqgeUhnS7MHA2TvUAgfILUw9uxu7yEd+4278L9Qe4cuOJ+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isUbBBqvouZg0YQtv1VWrtnYxouGeHfL4IdwSYUWMak=;
 b=M+6TmmAjoOZtxyCwi6XQ5JPR1/3SirsTDskuNTc+FZikpKRaALW7HVr5i7Imz2yan5Xs2sm791RAzqTytzooCLUG8EuGKnoq/8vluKtms6n++WpCIYvPE6hgmaHy4aAruFdM2tz8PeqQlek/RoJVsUPL4Yno4YymrNMX+mBuy1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.21; Thu, 23 Apr 2026 08:08:59 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 08:08:59 +0000
Message-ID: <a676add7-fdf9-4f4a-97f3-94a196582f80@amd.com>
Date: Thu, 23 Apr 2026 15:08:51 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iommu/amd: Introduce boot option
 ivmd=seg:bus:dev.fun,start,size,flags
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jon.grimm@amd.com, vasant.hegde@amd.com, frank.gorishek@amd.com,
 thomas.lendacky@amd.com, santosh.shukla@amd.com
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
 <20260420170033.6780-5-suravee.suthikulpanit@amd.com>
 <fbukzk36novjgroplqqzqwfhzvrfb5gklcogfcv772yww6agnn@mlj4hmbhb42v>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <fbukzk36novjgroplqqzqwfhzvrfb5gklcogfcv772yww6agnn@mlj4hmbhb42v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 357b694e-e079-477f-26db-08dea10f926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C6ygdPKDKd3A/LI50DsCzgivnx24EtIRVkC8TiiQbdSQejy7roJ9GzRU5Zoidy/cPsk50NPv4WM3TJYd1iQ/gTVmxBZDIuo3q6VhRXRTI+EfzU5d6Xqq+NwiPRrbXHSsFTD2E2F4C3T2WLJlvv3+Uoo3blKwUavO7TAZCvXcC2nztKPaweu3jOBZikpbuVmiyq8YDRZHNlPiB+xQ7gGXW4TefpXDj4DcL6n7kDHbY7fNb8pFOhB6/aFzRpwKYw+aZxhirCz1uNZRVjhslev6hrE+WK15MwFpzVwnu38bKAu4um3EmuxkhQSyJ5mGPdsKP7Y2G69nJX3iA/CB2VmHR5VYmGie5xVW4bgBsUuz/BaJwOP0/gCaRFD2diczbNXVxbUcYctoJ6Zc0Ih6YDv/1vO+DcPcEGOYsm/NMGZCaGsngqm75/chiJZ9qT/SdHKYIHFX/dpBkiHLuq/zcTgOBJWl6WDRE130SpoInTV4aFGEyEarhJGtlrhGxI5wr2C3PXKg2ZAMEh6wjoiadW1MaKAy2tYCUTsZpd9QaE8gNb0eV3WuiQCFArjB7NnThj8ijYxBwkLN1t3/kpEqIAEWjt2nIs2QVtNvaxVhENWOoW5BMwbdpZO6ekVUHC4IUab9NcE0GCsxbe2pEq2Ugb1RAz2S10GIf59rgg4uRBNDG2Y9YWsmu5XZv8/ryOOzokhgKpEaum0ZUv8WjNDb+yq0AMAIUXHHI4HI8U2v9/PoEkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhUTEJCaDhnTEdoa1IrWkRnZ3VIM1V5dC90c3Q4OERDTFJZbVczeGVTMm1D?=
 =?utf-8?B?SUpDYzd2cVpsU3pHTGliaS8yallCbnBBcVdvSytjZ09JUGFYellmZ0NlL29h?=
 =?utf-8?B?NlhOaTl6WmIzUGlvMnJlczhmZm1xSFNOU2p3YXNIQkFlaGMybmdoZ0RIRXoy?=
 =?utf-8?B?L2RCcWlRTklTU29MUWpDNHBERFh2UG1xQ3l5VXpNRWlNblVlblJFdXVZNGpK?=
 =?utf-8?B?QktaOEpsQ1RZaFZuS2xPckV1d0pEUnFNc1I5bVE4RTdibGt2QWZYYXphTkVk?=
 =?utf-8?B?YnNXMmFXbDRpOW1xWmgvQmFJWnhmUXNLOG9IMHAwMTU5dVYyYzB0cjNXdU5O?=
 =?utf-8?B?MTc5RTRLK0VxTTJUTng4a3pPZDBzK3NhQ0FOT2ZuaGxVQTJXYUZiZUw4RE5r?=
 =?utf-8?B?UzU4VHpWSUtLRnVMQzNDYnhIdngyanhYeitxYlc0VVFtWitia2lldVNvRDBN?=
 =?utf-8?B?N1hDa2tsYm5yMjV0MmpiMEhDRVNlazJaRElRWWlQemRjN0ZpYURZaTNDVEMy?=
 =?utf-8?B?ZHIzY2wrNHZZcXJRVHRlb2RNS1c3TXF4dmEzaUN2TVpyTmtHdENQWEJNdTJW?=
 =?utf-8?B?V1lCZXNzenViSVNGZWpZaWJDNE1TdjZaeWFocXJVNWJEdTdxQ2dLQzdTZlJo?=
 =?utf-8?B?Vk9nVmpsNkhwUkVBbGhMTm5KYWcxTys5eFQ4K1BTVDNKWkVOeG4xdFVOekRJ?=
 =?utf-8?B?K3dUeE9SdVMwRmVLMkdLOHhZaGloNWhsdmtGYzg3UTZRUUhtTm1weitGTEFJ?=
 =?utf-8?B?dEp6emI3WExCS0FSeFNTN3BuVGtKdUdDa0tNWXk4NlhNYm1BbW80Sk9aeTYv?=
 =?utf-8?B?NndFSlBaaTlYeWt1dE1PRFBMSXJuY3Zua0N2ZFJOdHJXVEMwOVdwdWlTSW5y?=
 =?utf-8?B?NHdNTVRGaWdaVEh4eDVUWTNMYzJTbzFoK3dtUUZrTksrZGNqK2tzZWFFTmlU?=
 =?utf-8?B?cmVxTElEckZXL1kxTG9vZkVzdlVIdUtoK0xyWnF1cVlZQ20wVFhNNERQNUhl?=
 =?utf-8?B?cXdjcDRDdk9aL29vVmRRdEFYS3AyR2dCbEh4SmVYR3VNeEFIcTNoYm0vNlRh?=
 =?utf-8?B?UnV6MTdoNFIwenlSZGt0ZzAzeXplMUpzdHg0S0tndEVBRmhDT3NTb0FSNWNx?=
 =?utf-8?B?Qnc3UjdjN0tZd0NLRC9qYVo1dGFaNkpYWndleUZWRjVUUlVvRUdZUDEyalZG?=
 =?utf-8?B?ZEFwQzU1RFE3U3lyNnhkUUF0RWwwQzdXa0RUWUlEbnV2NlVHemZVb1NVZVl3?=
 =?utf-8?B?R29ES0k4Y3IzV3pOVWZUdjFFV3BVN2hBcUMxbXVLTWhGNyttSGx3THdSMjJw?=
 =?utf-8?B?L3d0Wm9iVTY4THEra1lDQTJkbFZlUUdmcktqVnJVcUJsc0JFcXRIZFVSMG00?=
 =?utf-8?B?YnBERGxMYnA1Q25FMFRiZm05R05NcFZ1bFZEYy9OSHdIQjAvU3dJTEdjT1JY?=
 =?utf-8?B?UXdBYVdiYzdlaURrSGRKc2hTR0JBZTRuWitqQUkxZ3BaYTQzK1hQTjRvWUQ5?=
 =?utf-8?B?cWVPQnFhcW5oUFoyb3ZJaUZXU21aZm1DR2tYTVZGSVo5dHBvNEpsbTcyQVMx?=
 =?utf-8?B?MndHSGFVUG1VSDVKQWRHZG1sbGpjWGNjRWx5aEJDQVNuMTJKTjhTL0hGZDE2?=
 =?utf-8?B?QlZwbWUvL2pnV3J2SktKLzZSOXF5alQ1YVg4K095anRVK2ZnMFlMSmhnNUZp?=
 =?utf-8?B?dDVrZnM2bC9VcVNIUHN6L3hYY1VicDdqV25HcUp4SDBPcy9FaXUvb2I1ekxV?=
 =?utf-8?B?QjU0SHQ3M1pVWnkwOGJtZUJ4NFNGaXdQbDlkYkY3eEtNejAvNml5akhUanpN?=
 =?utf-8?B?OTBFWFNJUUhIWUZQSGt6dmV5MVRhTHlMWHJHWEJBOXJyYU9TbTI2THhJUDFO?=
 =?utf-8?B?a3h0YTMvZHZLSmNoaUFRa0E3RTRva2JhMTRMWDlMWlc0YjExa1VxZ250ekxk?=
 =?utf-8?B?OUZiZDQ5VUVrbmgvWTR5SDF0T05XdTNLdDhPV3BvS3dBL29YSkdmK21KbzdO?=
 =?utf-8?B?VVJCSzg4RTJjc3hYaEJla05QSWUwdXc2bm5JNlJ0eklGVFRVVS82NUU4N09F?=
 =?utf-8?B?Z291T1l4L0NkZ0U3VGtxeUJQdDZKTnRkdlhvMHVJMi9PeFI0b2pjemdWMUJn?=
 =?utf-8?B?SGdpOGxEM1M3L1lSOXVMd2thZ3hhZktWV096L3FoL3ZkRmVVakhCMlcyNCsz?=
 =?utf-8?B?YVh1YlN0ckU5OFNBK2pCcVBzdTByMWJNN2FObUNHcytZVkNXejg1cTdxRWlH?=
 =?utf-8?B?amZvNnlLemUxVG5COVluZllNNjdhbkQrTnFGcjUrdFdwbHc5Q3M5cGRqa2dw?=
 =?utf-8?Q?xobGnciyX7yrLF+6nI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357b694e-e079-477f-26db-08dea10f926e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 08:08:59.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QD+hQg8qNxWLbw2YfKAQlN9j6DR5BQbncvyH2hASopr4/BzYYpQKh7FMsym2b+05xSetHz32LaBUNtbfCMahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040



On 4/22/2026 5:56 PM, Yu Zhang wrote:
> On Mon, Apr 20, 2026 at 05:00:33PM +0000, Suravee Suthikulpanit wrote:
>> IVRS table contains IVMD blocks, which allow firmware to specify memory
>> usage requirements to communicate to system software based on its needs
>> or on hardware characteristics. Each IVMD entry may be per-device, range
>> of devices.
>>
>> Some BIOS specify incorrect or missing IVMD entry. Introduce a new ivmd
>> boot option to allow user to specify up-to 4 per-device IVMD entries at
>> boot time. The entries are stored during driver initialization, and will
>> be added to the per-segment ivmd_entry_map so that they can be included
>> during struct iommu_ops.get_resv_regions.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>   drivers/iommu/amd/amd_iommu_types.h           |  14 +++
>>   drivers/iommu/amd/init.c                      | 104 +++++++++++++++++-
>>   3 files changed, 133 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 03a550630644..e680a258008f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2897,6 +2897,22 @@ Kernel parameters
>>   			  PCI device ID 00:14.5, write the parameter as:
>>   				ivrs_acpihid[0001:00:14.5]=AMD0020:0
>>   
>> +	ivmd		[HW,X86-64]
>> +			Supplement IVMD unity mapping or exclusion ranges from
>> +			the kernel command line (in addition to the IVRS ACPI
>> +			table). May be specified multiple times.
>> +
>> +			Form:
>> +				ivmd=segment:bus:dev.fn,start,length,flags
>> +
>> +			start and length are byte counts (decimal or 0x hex).
>> +			flags is the IVMD flags byte (UNITY, IR, IW, EXCL bits
>> +			per the AMD IOMMU specification). Use segment 0 for
>> +			PCI segment zero.
>> +
>> +			Example:
>> +				ivmd=0000:00:01.0,0xe0000000,0x100000,0xb
>> +
>>   	js=		[HW,JOY] Analog joystick
>>   			See Documentation/input/joydev/joystick.rst.
>>   
> [...]
> 
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 4b62bb89a12c..7d60143d4711 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -208,10 +208,12 @@ enum iommu_init_state {
>>   static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
>>   static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
>>   static struct acpihid_map_entry __initdata early_acpihid_map[EARLY_MAP_SIZE];
>> +static struct ivmd_cmdline early_ivmd_cmdline_map[EARLY_MAP_SIZE] __initdata;
>>   
>>   static int __initdata early_ioapic_map_size;
>>   static int __initdata early_hpet_map_size;
>>   static int __initdata early_acpihid_map_size;
>> +static int early_ivmd_cmdline_map_size __initdata;
>>   
>>   static bool __initdata cmdline_maps;
>>   
>> @@ -2653,6 +2655,47 @@ static int __init init_ivmd_map_range(struct ivmd_header *m,
>>   	return 0;
>>   }
>>   
>> +static int __init apply_ivmd_cmdline_entries(struct acpi_table_header *ivrs_base)
>> +{
>> +	int i;
>> +	struct ivmd_entry *e;
>> +	struct amd_iommu_pci_seg *pci_seg;
>> +
>> +	for (i = 0; i < early_ivmd_cmdline_map_size; i++) {
>> +		struct ivmd_cmdline *cmd = &early_ivmd_cmdline_map[i];
>> +
>> +		pci_seg = get_pci_segment(cmd->pci_seg, ivrs_base);
>> +		if (!pci_seg) {
>> +			pr_err("ivmd: PCI segment %#x unavailable\n",
>> +			       cmd->pci_seg);
>> +			continue;
>> +		}
>> +
>> +		if (cmd->devid > pci_seg->last_bdf) {
>> +			pr_err("%s: requestor %#x:%#02x:%#02x.%#02x exceeds segment %#x last BDF %#x\n",
>> +			       __func__, cmd->pci_seg, PCI_BUS_NUM(cmd->devid),
>> +			       PCI_SLOT(cmd->devid), PCI_FUNC(cmd->devid),
>> +			       pci_seg->id, pci_seg->last_bdf);
>> +			continue;
>> +		}
>> +
>> +		e = kzalloc(sizeof(*e), GFP_KERNEL);
>> +		if (!e) {
>> +			kfree(cmd);
> 
> cmd points to the early_ivmd_cmdline_map, shall not be kfreed.

Correct, it was from my older implementation. Thanks for catching. I'll 
fix it in v2.

>> +			return -ENOMEM;
>> +		}
> [...]
> 
>> +static int __init parse_ivmd(char *str)
>> +{
>> +	u32 seg, bus, dev, fn;
>> +	unsigned long long range_start, range_len;
>> +	unsigned int flags;
>> +	struct ivmd_cmdline *cmd;
>> +
>> +	if (!str)
>> +		goto invalid;
>> +
>> +	if (sscanf(str, "%x:%x:%x.%x,%llu,%llu,%x",
>> +		   &seg, &bus, &dev, &fn, &range_start,
>> +		   &range_len, &flags) != 7)
> 
> sscanf with %llu cannot parse values with 0x prefix, which the doc above claims
> to accept.

I will fix the implementation / documentation to only allow hexadecimal 
only.

Thanks,
Suravee

>> +		goto invalid;
>> +
> 
> B.R.
> Yu

