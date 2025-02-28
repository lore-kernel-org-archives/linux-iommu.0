Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCB25A2DE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736503; cv=fail; b=lZpzwTnp2g5lVhjt4VNO/0GoqjmYXDBrTg1Gs8r6v2MdB0f8+HaS6fbQJ98D96wK2uB+dyfusDEFrdnoE7mE9COHK6PLrCLaPGjNDCu1fowhtezE+cqo9lKbDEgKbDCPfu/QZCnz6TZQ8JQNuY/GYi6YUAsO8GADCUCLq/deyYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736503; c=relaxed/simple;
	bh=Be68lCtBPU5o723S8l6QJHzdcZ8vZPPFzuBoJ8x+WJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4FIW4GwuniVg20/P/X3ZGiqIEKTcdHrfSPsf1cIZFks3rRxDpLFXeqxFIVOQvKgCw1pUxLvDiA3mUazlR/uvjAV+wHJuihPWQWLC8qwCEhaC1I9VZctlW8Y3fI617XMcKGkPKBGO29svnyBuFcDRimH9xadfXuLjfpEJLqIzps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QyDo8YVh; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QyDo8YVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqotZjcwNcFaBo4j519m66rUQWCwPH/PItHWljbfVn/6FMwplX218WbZLdYKpGwEl/nygRhJcIcXkSLHJNyOT8rQ4shT8dl/akgpQnDeCQNyo/pONa9+4hTne0ZmKi7xXGX4McetA+zlWQIELUl+3Xu4VVrIbuesLVFc2Lh6v5aYNLNHy+1E6vSBUAvExjID8kc3IrTazTlJjBDKeeNs+uOsyfjBZs+mHLOJBO2LrlrEi7T6SRsFUWDBNW+2tb4b8KbYcAD2uxeH7Z6buhD12Sn8kK9AsENxhmeEKKu2Jb5L9SQzibJ8AkWr8/jecux0OLCWhSAlZIr4g1uTvi8qMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIUS+5J1h7oqJO/ZWkPVSWVmTiIbN9knMDHtk0OOC94=;
 b=Bsa+XtYAqfCP/iFTx8+7/Isyb67wF28m0W9l6kkHoNsj510PMhN9SXICpqHknlvesBfYJrFBQ/UrKu0ybK24XU5KyEWiIcksxz0N57uvekeZPomYkNpAFw0ZdhmifM1i5C8GqV/YEgEu2Nu2P8gA8YkH5rOnk24qV03/J5GInAumCxHawg5745AL/hpmJojPlBEXlunx0uEOhNHD3FTkm7vtmQJ77vsZvEE8n88EmPmxo5O/KjteRXKQznTUgGuBEgqYU2nTl5ZkmhoCI39LlVImg+CYWSAGT+Ai9Jzm54lAWAVgWF1i5xBGWD7GMcnSmzf1CnmyOv59HKvJp6Y6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIUS+5J1h7oqJO/ZWkPVSWVmTiIbN9knMDHtk0OOC94=;
 b=QyDo8YVhqtISjXsfpIVNkoF2bD5iZZyW4uN/iHTg7VK03+aQNVA8bKTwf0taKg/aKNIgDyLMWLMgyulLy6+9uEwjeqBiFgRTiabcTiV5dBvxCEX6Lv2maVDMZ1ZeswGV4EH4dZelXVUGb0rzuumeoCOAcn9p6+P9BhaiR7Hl/vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Fri, 28 Feb
 2025 09:54:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 09:54:58 +0000
Message-ID: <f95c6afb-0adc-47b8-b3da-b6c24b66cd8a@amd.com>
Date: Fri, 28 Feb 2025 15:24:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Jason Gunthorpe <jgg@nvidia.com>, dheerajkumar.srivastava@amd.com,
 sarunkod@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
 <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
 <20250107180146.GO5556@nvidia.com>
 <b3ed5d5e-4b9d-445e-8d2b-3b315322ff2e@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b3ed5d5e-4b9d-445e-8d2b-3b315322ff2e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7b0597-dc3f-462c-02ce-08dd57ddf61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZSMFUrVzdueWdzajkvRFF2dE4xR3NhODhNVEc0N2w1c0R4VzJJR0p4dENS?=
 =?utf-8?B?bjBHbWEzU2VScm5RSnFYczQ0bW1keEg2YmJUVGRVQTd2b3Q5dFJhNlJVOFJ4?=
 =?utf-8?B?ZVVvQVJ5enNnVEl4L1pXbWF6Vnl5Rlp5LytGRU5ieEJ4VVVSd1F2cHVyM0hR?=
 =?utf-8?B?aGM1WUJVYUFHOWVWdXRMQUVSTDJRVFFWdjYvNTBIUUZjZXZjTmNKY3pJZngw?=
 =?utf-8?B?U1padHp3WjY0eXNyZGgrRW9GMTYySnptdUNyT3BHRGlXOWdydG9hSnduZVRI?=
 =?utf-8?B?U3pQTVNMUzZDdEljVS9iclBkNm1tdVV1L1NQemRGTTJUOElUWjNJdmIybW1J?=
 =?utf-8?B?eUhMUDg2bzNpd3FSRlpwVUpPNkRPNUxjTklwZm1sZ0hRWXprK3VnbytoZ1VV?=
 =?utf-8?B?d2ZDZjBXbEZXbEJ4Qm8wM21DNUhlYXZPNUxIVi9IZ0VWMDJBbGRrWUhsbUhy?=
 =?utf-8?B?QUU2V0RSa09wYldML09aVmdvYjR6dDVDQXh5T0pMemI3cU9hcWl3eFBXeDRa?=
 =?utf-8?B?TVlDa0ZSbmJhQ1BodGt5NldXUWN6S3Q0aTlUUGdIWHVZSnRjYkNwVExyOWJi?=
 =?utf-8?B?SlpVZjhYbDVkUVJ6c0FwWlF6UzVNV3FoNkFlc3M2TWJXU1B4L2FlNnJIY1ZC?=
 =?utf-8?B?RHVtZUZhMm9pa291ZUFRZ3ZmMlQ5RnhFeCt1MGpDZWpQNncyQnNBc09LR0FW?=
 =?utf-8?B?aGpJemdpQUZVVGVHeUF6SDVaODA3UXZ2QnRMd0xYVU5JU2dnZXpKV1ZVWnRM?=
 =?utf-8?B?NEJEZC8xTmhPcGR2cG83SEZ3Q01TckxFaXFsam9OUkNnZitHODdFa0lGQStj?=
 =?utf-8?B?Zk5NMmZZNHhGYUhuelVjQWFCN2xCc2dvcnJjd05iNWtCQzNsTVQraWlieGJW?=
 =?utf-8?B?UWZMYnFqWnQvU1FDM21CMDlpYjRtazdUZ2VMOGNwbU4zdHQwRG1XQW9PbDVF?=
 =?utf-8?B?eGhpdW9wdU1uV2c0NmhueUo3ZTdRUHkrRi9QMmNmU1NJLzE2N1dBQ2ZkR3Ft?=
 =?utf-8?B?SzhEem5QMkVWVTVrQkFoOExVTVpsNm92RFh6RVVHREJFMTZHK2RNM0lwVzY4?=
 =?utf-8?B?OHpkTXFseW05Q2hCaHNFV0FqbnNXaDJkTnc1WnJFMDZtSm8wWDZ3Nk5EUiti?=
 =?utf-8?B?WTVDNnZlNXo5VWF1N1RqOXZUZ3EwYUdBRldOeUovM3hGWU1aRkkxdW9CdHlq?=
 =?utf-8?B?NDBnY2Y4VW1xWkgvd01DT2trUmUzZEFoOUhJNUxXbGRxTXZabTRDVTd1K3NO?=
 =?utf-8?B?eDNPeWpTT0Zac2dDdjNFZW9xL2xDdk50eUVqSjNPbTh2ZEJjVm5PM1ZFcnN0?=
 =?utf-8?B?Q0lTQm5tTWU5UlpoMUNYU1ZYZ0xYV2VBcTZCcXU3VHM3NVJOVmVpSjdLNU9O?=
 =?utf-8?B?QytlOVpXSGlEcHFmQVdVRGl4RWMwbXdoS1FTSFY0TkNtdzYvZTJWVnFXaGxq?=
 =?utf-8?B?bmFSbFl6Q3dPWUtPbXBXYmFOTWkwQWM5RFMyS0NOZUU3OU84T0x3anpjMjVL?=
 =?utf-8?B?Y1h4M1U5Z0pIN3dlVldWWWpESHNGaEgxbXFXTk1TbWNsVlF2RFlkMWRqODla?=
 =?utf-8?B?bThWcTVNM3pBWS9ZMlBHTWMxL2FJZUNhb3JaMTcvcW5URHFxbXMvOTQ5WXpS?=
 =?utf-8?B?WC81aHVvbVgyd20rNWdHcHMyMHRVTXZJc2hsR2o0Q0psNks5aWxrMTJ2SHY2?=
 =?utf-8?B?cjdBcUl2bGsvTFJsTDRMOHlWTmVCa0I4SWhaNkdSYWQ1Y2pWN0I0SlhxbHhp?=
 =?utf-8?B?dTJ0bFZ1YkVNeG9tbGJhY3pkYnRxR09nWjBCdktnTCtEdmxnbmk3MVhxQ3ho?=
 =?utf-8?B?RnZuM0E4MmU4MUR3SEZETGRPOG1ONUFSTTRsMEdUVjRhVFIvREVDOVJNWlNy?=
 =?utf-8?Q?TTIfaLlUPtX2G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCs3cHZacWJPOEdzUFMwcU5VdGVGT3VpT3VueTF0Y2JheUs2SnAwL0tQQmZh?=
 =?utf-8?B?N3FZTjZPNWVnYWsxTHNnZzFYV1dlc29uWjlwdzAxMjhEYzN0RGxhcUlPN2lN?=
 =?utf-8?B?NXpTSjB5U1ZweHZXWDMxeWNPS0xzU3l4Ri9oM3ZMQVpFRnFMakZYUWpWWE9i?=
 =?utf-8?B?Q3o1NVFuNVhlMU42bi92WWEzdGN5N2p0NmZ2Z0tPVVIwaUg0TFRWUUtPSWdG?=
 =?utf-8?B?VnJBQysxb0NFQVYwaEppRVdqcGFZc2V1Q2Zxb0NIakFiOVErdlUxZWptNmRy?=
 =?utf-8?B?R1A2SlgzaE14ZTJuVCtGU2E0RTVCemlFY0NTRGJ5dzVaanRFTWxrU1NaSm9y?=
 =?utf-8?B?ekxBalRPZ0VqdytJc2xUVXFCKzlIc1BGOEl2dlRBTG9kb09sbzhhU05rTk9E?=
 =?utf-8?B?TGJ2ZlJpY0w1YkFPUmhLWDJxZm5ieElEUGthZU81clZjS2tLR2pVYlpoc3Za?=
 =?utf-8?B?RSt2d1BTa1BDczJNWWIxMVJxQmVrQy8yYVNxaWFHVlBMTm5EQ0NvNnNXajk4?=
 =?utf-8?B?L09Rd0xrWkdXdFZWTzE2NDFyRXdrbGhlUXVNNkFSMVV4bVcxRTcwOWtLcHNw?=
 =?utf-8?B?KzFPakdSZzRQb08yaXM1ZldVdmRxSHJhSDFjWTNGYmxFcjdmcGkrUExsM3JC?=
 =?utf-8?B?TzFxT1locHFjOXByK2lOWnNTOGpMTmtxMzNGamRZQ05ubHBUQ2VtVnM2L1dU?=
 =?utf-8?B?dHJMdXRyU2VuaFRRRlNBNjlTRGgyUytKMWdwVkZTZ1pOQTVHRnpRWEh5R2FY?=
 =?utf-8?B?S3FBMit6blh4L0RaY1RVZEd0bnJsMU82QzhtNjRMK1hLNHNDekJWbE9ndktr?=
 =?utf-8?B?NlQxbiszM1QxZlkwMS8vUW9pQTlQNmV3NXVLZlk5ZFNxOVpPMzhkaGoweGNv?=
 =?utf-8?B?dVJYTStSYVNadGhkZHZnNzBtUkZMNnFHOXNVVUM2REVObjkxd3dFRElJUFVT?=
 =?utf-8?B?b0ZuVUU2NE54V3BCUHd2QTU1Z0xLLzJrZlJ5ajdxUVdKNG1LV01nekF5NnRG?=
 =?utf-8?B?K2xPVGs0Y2NBenlKWEx6TWpHL0FWaDhHY2lZWVMvNFMySDF5YUUya0dKRW5X?=
 =?utf-8?B?dDhQWnpteklPTXhsUVcwV1FrWTJsR1FlalpDaE9WT0tkaElCTWtKelozRmZL?=
 =?utf-8?B?SThGaWtjOXZiS1dPdGNIY2U3YkFFQnhRN3p1N3hLYWh0d1k3REJRR0ZZYjZY?=
 =?utf-8?B?WXJ2YWlTUUdJOUxaaS9aeFVZenF1OWdtZGtQQTRBU3VicTdaVitqbHp3UjJU?=
 =?utf-8?B?aysvWDk4Zmh0VHdES2VhT2tJWC92azRRelRmM3k1Ui9id2VzVlpGb1FPUWFO?=
 =?utf-8?B?ZFhaMWVWL1hEL3VLemhoSmNxaGVMNVlzU3FxUnd5ajRFcjNoT3hmR0tUUXRh?=
 =?utf-8?B?YjlFOWtRL1JWYVNLT0I3S0p4Rk9UaFVZNjhaQ2hVeW1Id3ljanp6SnNrT3FU?=
 =?utf-8?B?WWNqazJCNTA1bVpVdGZLNkwrRTJsVDZjL29OMDB4Ty9mKzRVdE1USUo3VTRL?=
 =?utf-8?B?YWxGMEtxcE9NeGRURlFNV3JRRG1OUnJtYU54cHVFb0JkQWMxT0FYWVJCeXM1?=
 =?utf-8?B?TkFubHZIcmlzRDlTdlc2SCtZdWR0Y2crSEg3WW1GU2VGeVM3VkVOa2hucm1n?=
 =?utf-8?B?MWJuZDRHTVZxTmQ3ZVpVNk9CZlpVdDMyK0I4VmhySWZxZ1BZcWkwdkFNczF4?=
 =?utf-8?B?Y3VnQThndEFWUVhYSHlCU29JK2dzeVZqbERJSndBaDh6b3hGSlAvbXJaZm9C?=
 =?utf-8?B?dzVINTZCMVNObk8wOVVNU3RCVURVOXpWYStJdDhMSTFod2Z0WHZ0N1N6RHhs?=
 =?utf-8?B?aytvczFaeFlwT1E2NXl1UFQrV2hpMkpxS0tVa0pYQkVNZWxlN1R1UXljOGxI?=
 =?utf-8?B?dnYvbUd5UUQ5UmdNa0RqcEc5TmhsYXZ6RDRXR2R4dHFEaThRSEIyOTR6VzVu?=
 =?utf-8?B?TnErbFpEM0xVR0MzcU9hcHFWbXN1MEk1blVVUDZDczRneGJzRHNiMVRUckUz?=
 =?utf-8?B?dWd1ZGY5RVNMemVFdDVqUVl1YUdHMkNUSEhzc21DbnVkekdUUlFLTVBvOUwx?=
 =?utf-8?B?RnlOcVdhUEZNSlNVT25WVS9HNWp0VndZOVhrUWdLK2R2bzRwNUFVU2ZoY3o5?=
 =?utf-8?Q?qRZ6WkqfK9+PsaOKPId8FFs7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7b0597-dc3f-462c-02ce-08dd57ddf61e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 09:54:58.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRyY3qPqgYX54pCoqHPyY7wMyVpYK/MOvA8qunQtIwrXLHpp3Rbe828ycEdi8zGDu9oMA5M3R+p5cjaS0iiU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027



On 2/26/2025 9:49 PM, Alejandro Jimenez wrote:
> 
> 
> On 1/7/25 13:01, Jason Gunthorpe wrote:
>> On Tue, Jan 07, 2025 at 05:45:38PM +0530, Vasant Hegde wrote:
>>>> @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>>>       make_clear_dte(dev_data, dte, &new);
>>>
>>> This fix is fine. But with all changes we have done in this code does, do we
>>> really need make_clear_dte()?
>>
>>> How about removing `make_clear_dte()` and moving DTE_FLAG_V to
>>> write_dte_lower128() ?
>>
>> The V flag should just be set by the functions building the DTE,
>> write_dte_lower() should accept a fully formed dte as a matter of
>> layering.
>>
>> I'm hopefull Suravee will come with something like this:
>>
>> https://lore.kernel.org/linux-iommu/20241016142237.GP3559746@nvidia.com/
>>
> 
> Suravee did say he would implement the suggestions above in the series for
> nested translation support, but that might take a while considering where
> we are in the cycle. Given that this fix is straightforward and has been
> reviewed by Dheeraj, are there any concerns with merging it in its current
> form?

Ack. I think its fine to pull current patch for now.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

