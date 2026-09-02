Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223F3D9532
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335377; cv=fail; b=XAOtW2aP7lwqrfgJwN+u0rtRmm/LbT0BuCYIvKKujDeOW0bimThLo6hD9L4HQzxBIXxln8Lefg70DCb06nSFhQKspkRmd+oCJrLDeBCkAV4F9Rp8qDIvlPNv1V2gdXLtHaEDxwjI3tt7Og4WRZoVJEYaTwkjjjl8300IMOdmU5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335377; c=relaxed/simple;
	bh=K+A8Dk3QvdlIf6L6mfUyevkkBfnrIOrNB4N/4S/PcLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghRw8p44wPJXXhiqfnDOJDHR+rh+KjESVO245IxWLAHHuM7CuhEB5ms8LMOQ0o5Xm/w7wagBXeWXqOXV+3ph+VoYqov5c3WXoYSrm3wHosgtMGVEyqyMbxYyUofejLhLbIFS0wjpHpJnsvwq44/k0awaw7TGbYmPtjU0o6IK9v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AkCVyieA; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AkCVyieA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHyTF4B1lHpUx5bB5R5DeuZv+l74LwhhPQcQTk3vLqFWtfEwa9dfHih7o1cLiR/jpy5V4TJPRjhDqLqV663PROwQV3/4jC3qiv1luWQ5KWuK2zGrz224sB+ceF5wXCPJdtzH13qhkaCX1Y2hziWA5g6PyLK/koaraID1G1OuMAW/3As3l/skZbaIr8ELWli15mqaZG+dyDFDqEJMVil9FbBPnidKMkmzezX713imrRlg81+afIBsQkRW1J1aw4siuUZfUunAr8OynYIkl0Jo0CfSpgqV9WJgeCR9MfmDYxhizfId6tBOvVMvn0WH2FXgZSipQuligotXEs5e5rZsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t4xtcj0UJKj/IIvy+FXcn6Op3Z0C1e8/gu+WkNWGx0=;
 b=OhZhGpgNQFTonblqBdSEOBhAjnduTumCdSRMTtnFU473nntvaOkEVi2vKKjsKJofaVsUsoiNr2wSdhNDT1uXIEaKus4O/TVJaUPMQynzcD3OdpiEz7Ax/1usC0holJT0TqYiIK9UAPjgQJltyBS32thn44Y2lNBGVwNe7e8K09nel+4BhJQuUY8QH7JhWpbwQ0aoCqIOFoQwOvwRO2q0P0cfGjSWc+o0SBri20AEHiXp7ucFK32Q0lLzJWxwZDc6VHfj6bRjI3HaHvIWwAnKrjo8aDWmmr2DGFi3F7yEKCpcWREA0sNae4kncyU/1PS1TB90HNX7+Ay1EuYKEYZFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t4xtcj0UJKj/IIvy+FXcn6Op3Z0C1e8/gu+WkNWGx0=;
 b=AkCVyieAtUPir2V/YLQa0eTfpsPx9HeTOpJ/PJhWhmdJpbMxKc7GujZ2MMGzmZqtDAYOTWv/bHJ/K1KQt4RYVncmwjcH8NQfK6AA6iHb/nB5feeWi+JDAeyKw5b3TgkHH5difsx0iJAawgs8mUPif84tPvPAoRDVQ7dYzozQel0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by CY3PR12MB9703.namprd12.prod.outlook.com (2603:10b6:930:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:49:30 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 07:49:30 +0000
Message-ID: <63fe2fd5-61aa-4e69-a0b0-59b67038f6b5@amd.com>
Date: Wed, 2 Sep 2026 14:49:21 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU
 instances
To: Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
 <7a9a2703-d4de-40da-8724-ae9ae79c358c@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <7a9a2703-d4de-40da-8724-ae9ae79c358c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0020.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|CY3PR12MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 512e53d9-bed7-4089-820b-08df08c6b85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|4143699003|10067099003|56012099006|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	JL6Nus4dPoTd5cAecPgif35SZ+58Bq3ClxFDW6gmLcdSdD8AU2ngaMeel0lxv8h2YyhzgEZJL5fZyvKwrxtsKTjDp4mWV2ooqZGL2kJEMaAmtHaBJe+5ALrK01NWBt54NB64MQbWzgaBG2/SoEPzqLkmlhROZgFlBapT3PXZHpjccqP0OtAurJp7TQe/QFP/ZqYmLSQyoFwrJcj+CSNC0mFY6vciL8nJgTLkEuBsb2upnwjYuKBAft5ZREEyhlBPMcr6Xkk7ZF69OHlhNeWgY5x7QWUWsbbyieZ2G6fg+ZBltQ0IyaqcGGL99t/2p16q/ALZ2EoIJfA4PLDuMNmqGtY62WK/F/S5bWO2FNmxSjOic6YLhTAX670zesEDzja4ktaDqUmw4prDcYXfHs0u/u011zH/nlItk/PuAEN/MI6+t0f3WuIQCCNw4Pu1QKHepK5bq7UJ84JBsLHmMERY8y1HV15SUPVYrF5jGb9U13iPoSfOLMWXWTdsUWDwZzaJAsOgwystReCzf5MA30cXmCpVO2nWLYhevGJG0OWq27OO+M2Ax62rlh+k+oNJ0G8YRudNvXzUYsKp+g8qb6fOChKIYdjc6Pknr4tor0x6UMp6kKy86EyKAu6lBKC2vBQWSrxvxtksvSVtC8HKrskhy5/32tSvcSV7JsBGqRCHyVc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNJTEhsYVA4eXFMblc4TTZmaVlhdzU3VitUVGRiUndGVk9ZMVRXZm1VMG8r?=
 =?utf-8?B?MjVONTNFUHlERjFxcVljMXhwK2dXRjFIWHJDdGpRQXlZRFoyYzllYVNQQmo1?=
 =?utf-8?B?T05wUmMxOG1iYlpLSlNBUEI3RU4xS0tQZzE0V1Q2bUMwWm1kdzFldEt6UnMx?=
 =?utf-8?B?aEtWYnBtaWxxeVNzN3h4N2RDZnBjaFltcWZReGhlcC9ON3JwOXJNK0dUNHFI?=
 =?utf-8?B?Y3lGczV1TnVLOCtTQU5xaGs4UFBrOXluT3dVMzNiVGZiVEl5N0owbnAvMDh0?=
 =?utf-8?B?d2hWMS9USVNnY1VjZWl1V2xnV01ZWldweGdWVWk0RzJtU1czcFBhL2VjQjd3?=
 =?utf-8?B?S0ZkNVhHOG1ZMXNmNzVHVVhvWnJ5MG5BV1FOTXdoZjZJOFBFdWgxYUhLemJY?=
 =?utf-8?B?OEJWRFltMDhGMVZDRDZpNEdIcFVIU3dQZ2pIT2ord2UvQzlLZU9MNVFLVDBh?=
 =?utf-8?B?dlhZRitGczRwTGJsc09iWmpSTVBjWi9uUHJRS2l1MUc4TnhXUWF3MXR1cmMy?=
 =?utf-8?B?SUZsZDN2ZmVFT28yUnJueEtTakZGR3RGS2xvaHJxb2krWVIyWXRFQ1BNT2Nu?=
 =?utf-8?B?bU4xejlEbUtKZ2VWNjBweXRWdVlEVnFDbHF4TEVXSkpyQTlNYk1Gak8vTk1Z?=
 =?utf-8?B?UzVuWENsZmxtMnRTNE1KRWxmbllFaXFyaUkxdzkrQmpvYWJpVDFYMklVU0NC?=
 =?utf-8?B?LzNqd0VJWUhDU1QwMDhVK1p6cVhleUgreUlINkVPTnZONHpnMGVaZ3Y4cFNs?=
 =?utf-8?B?MFhwODU1alo1OW4zTzBqT3pYZW1lVE1JNzVraDQyTDk2bUo4R1hUbEhHMk0v?=
 =?utf-8?B?ZHE3TUtxUE9NaUFrd0xXV2daeDVUL2t6N0JXVTZ1RzVab0lmVHZQaW9NZnRU?=
 =?utf-8?B?UU5GaXlJV0dab3pkSS9UcFZ1SXl0b2VYaGF4L2RMUlhwem9KRE0yS3ZLY1Fn?=
 =?utf-8?B?dElVdjY2b0g2TWExdVRvdWFlekFkZjJwUmdDMlhTTVczWnVMckRqVjdMbWZR?=
 =?utf-8?B?eElubFZ3c1JLeDRwaUJKOEtGRUdMMnI4ZG4ySmlHaDJOaGRITFVlaWNTU0VS?=
 =?utf-8?B?SWgyZWR5MW43a3dOUFdOVzJRd0pwRGovWDJXb1dKSGVPTFBaWTRsQTJROUg2?=
 =?utf-8?B?VU1lYWQ4WXZtUnNmODRvVkJMZmk4ZFM1T25LZ0ZQbFp0OUVOekxHa2k2cWFI?=
 =?utf-8?B?bjlyTVkra1laTlZweFhWLzdEYTJ0K0xPZGR4WDVkU0JUMTB4dzZWTjQ0OW1V?=
 =?utf-8?B?UHUySkhwSGxtRWJ3eTYwWm93QnAvUkVXSFliUVhxajM5OWJlWlVGM2RUUlNN?=
 =?utf-8?B?czRvOWdrM2IxOUlDSFY3Nk9TOVZvNERjeWZGaUx5YlJXSnFUWjJzVHNWNXF2?=
 =?utf-8?B?eEFvQkZvVFVqVnlmMVpWUDNBOUhsSW9nczZwWmtGRVpxczJzVnZyMFdlU0g5?=
 =?utf-8?B?U1kzSWZtOXo4dkdpRjV4QWxmQzRib3BlWXo5anR1MVZyTnZLQmVOcFR4aFVI?=
 =?utf-8?B?VjVlZzdzc3M2UjFPMkM2YTQ1MGpxNmE5cFVLY01GSGU1a0kyVTQ0bWJYODFE?=
 =?utf-8?B?UXZNbWNTK3JmRFVmckJpdTBlOFV2MDZMYXRvMFJEcHYvVVk0ZjFBQ1dWekdh?=
 =?utf-8?B?aVlkd2RJK2hYMzFVMlBUcy83b3lHcWMvamFsb25GaW1mZzVUOER5d3R2UXJQ?=
 =?utf-8?B?aGMyWUlaVzRQakFGbHNnUlFVN1pRMXY5Vis4eVprU3FhTysrVDRxOEpnM1pO?=
 =?utf-8?B?NEJGOGhYS0lja0ZjWUoybEt2Mm5YUnV4VzU5MzJuTHYxQ2R2TnhuTVFaSFlK?=
 =?utf-8?B?bW40TGRUM252OE1MVTIyRk5WbUZySlBiOHdMT2RDKzBoaExJZHZ1WHVVU3RF?=
 =?utf-8?B?cVZ6V1d4cGNGc2NZMS96SFkxMEFSdFFSbjRuUTJsK2h0cjdRM3paWWxQelB5?=
 =?utf-8?B?d2s0TVBmZC9Fd09lR0NRdVgyWG1KeDdla05iNmFtK1FlR0NpVmhZV3Q3RSs0?=
 =?utf-8?B?NDZKYmFEbDFUVUxpRFQwNldCWjJuWEIyS3I1VDRHM1JCaDd0NU90bWF5VFQv?=
 =?utf-8?B?OWI1OHhHemJYN09HeVg3NE1Icnd3RXVpc3YreGRvUkhha3MwUVpvUUpySEZj?=
 =?utf-8?B?NnJ1Z2NvUmkxYUR5SFlXS3lRcXpta3pBc3dXWUdlcWFDb2h2TGpvOGNOdFNR?=
 =?utf-8?B?eGc1Ykw5VUIvL2QzNDUrejI1M2tTa2Y5QjJnaG9aNElRYUVzWmN5b2lHQWth?=
 =?utf-8?B?OXRtd3RNVWsyb3V4RjJSQ0pmckpMTHp0WTBBMVNuVW1vK0tFOTBkcEpyR1V5?=
 =?utf-8?B?aFh1NFVTakdodzBkdDdNWEFNUWxtN0wyeVhUeE40d3JaeTdJQzhWZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512e53d9-bed7-4089-820b-08df08c6b85e
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:49:30.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC1uYowhl5MPugE/r/OQhsjLH6HtS10oenuyRtoxm6EaDcsFU9VXz2VFZlo6mMo9Hacvm536nq9NtIRDPD3P8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9703



On 8/10/2026 4:21 PM, Vasant Hegde wrote:
> Suravee,
> 
> On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
>> .....
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index b5327bf6814b..00f964d5b149 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -21,6 +21,7 @@
>>   #include <linux/iommufd.h>
>>   #include <linux/irqreturn.h>
>>   #include <linux/generic_pt/iommu.h>
>> +#include <linux/idr.h>
>>   
>>   #include <uapi/linux/iommufd.h>
>>   
>> @@ -413,6 +414,9 @@
>>   
>>   #define MAX_DOMAIN_ID 65536
>>   
>> +/* For vIOMMU, the GID is 16-bit. */
>> +#define VIOMMU_MAX_GID		0xFFFF
>> +
>>   /* Timeout stuff */
>>   #define LOOP_TIMEOUT		100000
>>   #define MMIO_STATUS_TIMEOUT	2000000
>> @@ -509,6 +513,7 @@ struct amd_iommu_viommu {
>>   	struct iommufd_viommu core;
>>   	struct protection_domain *parent; /* nest parent domain for this viommu */
>>   	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
>> +	u16 gid;			  /* Guest ID for the vIOMMU */
>>   
>>   	/*
>>   	 * Per-vIOMMU guest domain ID to host domain ID mapping.
>> @@ -768,6 +773,9 @@ struct amd_iommu {
>>   	/* IOPF support */
>>   	struct iopf_queue *iopf_queue;
>>   	unsigned char iopfq_name[32];
>> +
>> +	struct ida gid_ida;		 /* guest IDs for this IOMMU */
>> +	bool gid_ida_inited;
> 
> Redundant variable? May be remove gid_ida_inited.

Ok

> 
>>   };
>>   
>>   static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 50f26c8123f3..73fba8be40d1 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -252,6 +252,25 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
>>   	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
>>   }
>>   
>> +int amd_iommu_gid_alloc(struct amd_iommu *iommu)
>> +{
>> +	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
> 
> 
> We know that top half is reserved for secure vIOMMU and we have to construct
> that differently. May be restrict max GID to 0x7FFF ?

Ok

>> .......
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index eee29c26169a..ec3c14e18c7b 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>>   int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>>   			    const struct iommu_user_data *user_data)
>>   {
>> +	int ret;
>>   	unsigned long flags;
>> +	struct iommu_viommu_amd data = {};
>>   	struct protection_domain *pdom = to_pdomain(parent);
>>   	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>>   
>>   	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>>   	aviommu->parent = pdom;
>>   
>> +	if (!user_data)
>> +		return -EINVAL;
>> +
>> +	ret = iommu_copy_struct_from_user(&data, user_data,
>> +					  IOMMU_VIOMMU_TYPE_AMD,
>> +					  out_vfmmio_mmap_offset);
>> +	if (ret)
>> +		return ret;
> 
> May be move this before "xa_init_flags" ?
> 

Ok

>> +
>> +	ret = amd_iommu_gid_alloc(iommu);
> 
> Looks like you missed initializing "iommu->gid_ida" ?
>


It's being initialized at host IOMMU bring-up, from amd_viommu_init() in 
init.c (early_amd_iommu / per-IOMMU setup).

>> +	if (ret < 0)
>> +		goto err_gid;
>> +	aviommu->gid = ret;
>> +	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
> 
> Redundat as you already have pr_debug inside amd_iommu_gid_alloc()?
> 
> -Vasant
> 

Ok.

I'll update these in V5.

Thanks,
Suravee
