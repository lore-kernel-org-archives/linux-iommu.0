Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5491BF31A
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586268; cv=fail; b=RB3NZSUCCkIgrfCQTZfIJ2r+cw4l712dRe0zuDbvytFr/UN3rVs2jYpkgvyNbvPhBXIpE79/njGzygCNV9jZGiNHMkhVeZfn81bl8iskNxDdcvlTO+DldkUVZqPuoKZGgfgS4rGXALcpNxnIs7c4GnoPmkh1vo3aJ1hLxOhd/lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586268; c=relaxed/simple;
	bh=4d1AERmsu/CgSR7jbP7zutGoPFqzocyaYPTmh7UzAbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k2oKk+qwiUlihtHwkRBAqSxf1Mlf2yj3JET4GK9Qd/mw3XEIMQse+e5bBUT8JGrEeWrBidbudS1Iqg4WU7iscZE+lBBub5y1SmaxqJQGW9vW54dyHrpLEmRjzjVu8WUAPQBFbnVGoP2RHU4q+aQeJaByCOxFS8HB992vyD0dAYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8o7WNQ9; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8o7WNQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUmBYOSgiVhUdzR4wywZ9RHmHKwOwpBQHPTyGfb+7t4Qf1yKrzSKdhDSBmR0qdnqBzRlM6t4m38zZ2OpsTBZEqZ5MBYSvrqE5hCGDh9e1eiuzQTuDzpPOWCTZI8tAH4MwjfCz6OWb/s1A22/2I06W8g7dRcqB8XMo54aY50Ftc9vopNKJD2pFJxBNMEuC+yJvkzmL89I0YWpaxXerK7anFOFiUEfdKVJYhD+Nr6SRjH73TfE6lScZ3dMploiJaOMZNxN99SENwumQI37dDub+4n8UzLYgPIZq2+h4j9UGyDfi6kETtyWpB03PE0Q/aTd2wd3AB8a/HYAXL599fRQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7ejmTVxNDYVXbaeurzu4FPXufCWwu7lvz0lgbtAsEg=;
 b=LqGn2Tfk0aYkGKeUxZFbMrFW2VBz820WI4n7Khrhy2MvwyUQkXVWkXXhwYKjoJsJF/q97UL9DUzeW3k02GXEjih56kp+MqpHlVUKlwWti5eN9Vy4x7vzVtIdFbrh1fKN/NdPd7xxkDxzLZcZhZ2HbvO/XkWsNDUgOQX7qNpHXFa9wp3Fri3f29S9IJw917OXpNKeHbRJMtLpLhLwM99ywgZWelb2IDdf3UBVW+X3bztzGFQGHTtjlTPRIuIh+vx17hMPXUQHbWbifHFq27k1DpR7GZQTr2cfqnXco9i1vFNkKTBbLGY/WQe/IdIlfnkOvNY7oGQNbS//u7aiPVJTMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7ejmTVxNDYVXbaeurzu4FPXufCWwu7lvz0lgbtAsEg=;
 b=c8o7WNQ9Ec2U1L4gQfCWTf6ug/MBraVVMgbGr1OurFIVK7XjduGOKnCpEHoom1coCYSOxTy2B4n/MqbNpNqaDGVbnxqhg5zE990ICSL2zaKqbhMOx6py/2n0hDAK2ucVYhJQ74EC1erCnY4HTZx34ZyxSXGXcEA5NEYpoSyGbiI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Fri, 28 Jun 2024 14:50:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:50:59 +0000
Message-ID: <6df92d7e-6042-46df-971f-732e0ad4192d@amd.com>
Date: Fri, 28 Jun 2024 20:20:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3c8530-b1bc-4aa9-f40a-08dc9781b8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejNvUWRtODQwYXU2WkVrWkNYZmdISDRPUHBCUmo5YXg5NFlWMUxzSkFPckRu?=
 =?utf-8?B?eWVCT1ZDRGJYeUxud0NOc2R1NzA3V1NSdFFzTStlaHF1NHpDT3QvQzZCK1dp?=
 =?utf-8?B?YkpEVXRyclNwK1BkY3QxSDlIYWhRU2tzc0x2TWZEM3Y4MXNrOEtFVldBUFFj?=
 =?utf-8?B?Y0lhdjNVL2FFbTB4UW5nakJiYXpWZ1A0VzJPNVM3UlFWbXlEb21kSFV0VUpx?=
 =?utf-8?B?d0ZNRmhOeUcwdDV1TXJZSnZPUDdXcjRLbXlPa0Z2MzduNjk0ZDdldCsweTF5?=
 =?utf-8?B?UVNZSWxPN1pQa0laaERpTXlvdWs1UHFoenFYclBKdXVvQUF1ZU1QV2wyd2Zi?=
 =?utf-8?B?cTVheCs4OUVpRStocGFzSEZwMG5oK3lFbkZEWFRJWVFwZ1ljVXZ3U2dNblBx?=
 =?utf-8?B?eW5YSWtYcGRpc2dpTHRsblNYdHRDcmM3R3REVDdnQlNMS3ltalE0Zlc2b29U?=
 =?utf-8?B?ZkZDRElxN0JWRUwzZWM1SlZPbkRab3R0MVlJU1hsblAwZWkvaVJXbXFmRzMw?=
 =?utf-8?B?SVRja2EwQWppSG8wOElScE1ZUWpvY2hKWjlmWDZLT0l5TVFXZ0JDRjNWOVVI?=
 =?utf-8?B?Q3o0WWhFNStkRjkxOXFVRFh2QzdyY25ISElqK2YwalVhMjFXYTNQSlRYTStv?=
 =?utf-8?B?WVNSTWJPb3QyQnNYZHB6WnRaOE1pZHNvVFJQTElyd1lNK0hlWVlZWW0zU1RQ?=
 =?utf-8?B?N2ZoTlBsNVNyQ2VaZ2dWMUg5R2M3di9jRHYwOXlocFRXS0l6Q1NNRk5XdTRn?=
 =?utf-8?B?T3NNSjZJV3VXK3BrYWxPZkthNElsb1hpbURGYitCQS9GTnJVa00zaGhhNmtQ?=
 =?utf-8?B?U1JXbUJmRk11VUpMMlU4STV1ZUZzbkQyVHlBMy8zeHkwSFlxWGpPT0poQ296?=
 =?utf-8?B?dnVZU3dxSDhRTWh1TDZMWTJEY09hWUdtazRWWnFwSXBlV0JiQys2R3ZpeFI2?=
 =?utf-8?B?UFp5OEdSYjBMVG5UWUdwY3dHemh3b3ZxUEl4a2I4alZVd3ZoR3gwcjE2NStT?=
 =?utf-8?B?Q2VXQVBxZWczdnVoUnZEalkyOHNHdE1LTGUvQ1dVQU0vbjBPbjFYWFBZZG5j?=
 =?utf-8?B?RzI3cElUSEhQaHZHeHFDUzRHcW5oNXRXR2VVdkxxRjlkdHQ3OVhDbmZPMXQ1?=
 =?utf-8?B?OTZuRjNndUtxV3VkT3VZQXVDcDB6a08ybmFWY1R1emM0UU5mdVczRnNkQXht?=
 =?utf-8?B?WUI4UG83d0M4NUxkQWxDVFZtL2NrTVh5VVk2NU42YnRMTGFweU82TzYyV3Jl?=
 =?utf-8?B?aDNHZGVsbHFQdkJiemF4eStDZVFGSFI5bkYrVHpod2dDVXprVkhUVzA4UDRG?=
 =?utf-8?B?WnhtVnN6dnhXTENEcWNmRS9ONnlJa2tIOFA4Q1pXMHRPVW1sbklwTGNHUzZv?=
 =?utf-8?B?UHNGazdiK3htbFM4Uk95Q1NxWnd2UnhXRXB5ZE9uK3JZejV5TFdoWkRxMGJK?=
 =?utf-8?B?dDRmVTdLSDR1bWh1YSszNm5vem9yK2VxOG40a01pV21NY0cySmc5LzAvajB2?=
 =?utf-8?B?NnhyTFNEUVh6NFVNcFVLdjIvaEw3ZnRoWDA4cUtVZXloNmtjMzMyQzhEUG9h?=
 =?utf-8?B?WloxYXFQSGV1R0p6ZFBKZW0wOGlWejJRU2w1WUNTUXY2U0J3UWZZKzgwNUJU?=
 =?utf-8?B?UGZxbGNFbTRGRXViTkM0eEQ5Uml6aE80c3Q5S0RBNHJYTWV3c0NXT1BlU0JW?=
 =?utf-8?B?bHlpakpZWDEyUUpoOG1XWVhscm9FdHNaUGVwbGxBUG5pQmsvRFJGcFZPUXlS?=
 =?utf-8?B?QTdNN1pIa3g4YXJQOEk5SW9UaG9BYUk5RHI1c25ydlJQcWVXbk55akhrQ3ha?=
 =?utf-8?B?OHlvSmZTVUJHRVVKQnlQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2FnaG1IbEhOaDNaUHBXdkhUaXpGTkhUV3NCcG1tSHBQc0J5WWNiemdtOFBM?=
 =?utf-8?B?SHBIQkNTU2hBOGdVVGdTdmhWRVA4MG9ZM01KV1daSGE3YmRSaFpGbmpueVRI?=
 =?utf-8?B?MFB5Y01EcmwzdjJSdGtwY1JPZ1ZrNG0wSWV5UFpBaytFTVJPUFQySUtDeU5l?=
 =?utf-8?B?NDQvWFhpalZOLzhOSFppYzJzSlBIL1BGZVM3QWZwSGtaS0NybVhQYnBUNVB5?=
 =?utf-8?B?ZXFnVDVQTUs3cDhwUmk2R2VMSmgzY21GRittN3dUUVVHa242NndBNXVSNVZr?=
 =?utf-8?B?MW9WZDllNFhuTk1qNDdhK09OK0V4R24wK05FZ3oxODh2cGNIc0hIbURTV3Bz?=
 =?utf-8?B?eUFrdjg3VXo5NzdYcFJ0MkFCUUFtNWxVQjZwODE2Uyt5YlpySllNa3FOQ1F3?=
 =?utf-8?B?Z3kvZFRzMzBLcjdvM2hRaVNCQU52UDhESnc3UXhQL1o2Wm1KRkhPRk5vWExU?=
 =?utf-8?B?dUs5dUtCS0JXS0FheGQrR2xrVWpsT2o2S2dHeDEwMGlCdEcrbUtEK0hxa1Fn?=
 =?utf-8?B?N3g5OGN5aEl1OTY1c1B6YTVZeGhjYmZCcnNOc25PUDBpMHFhT0VLZWpETTdM?=
 =?utf-8?B?YkFwdEhYYjVhdnAzSFRNYkV6UEVuMUdpZGJqbkpCRVB4V1pGdW0zb3FiZ09I?=
 =?utf-8?B?cVc5TEVOOTkySXQvRURBaEdGRHFlRjY0WlNzbUozbkRPamFPaitrZ21Wb2ti?=
 =?utf-8?B?dzlPYjlGZG5rVFVMU3ZjWnZHMVRxdmY3TjhlQ0htVXFQbzZKRzNXNkhnQlVm?=
 =?utf-8?B?QzhzSmFzdlVGWitKU21KVTFsNDQraldlSytONG5GWHZiT3dqbHNGNEVFNW12?=
 =?utf-8?B?WkNwbGFCYnhrWEl2NFlQQWlHS2RaWExORXZzbFpYNEhndlI5UTFWNEtOUm9v?=
 =?utf-8?B?UGlnVEhUUTlFckRGaHVIRVpFVG5kMEpDTUVhNzhtZnVEZ0wxL01UMVlrckxC?=
 =?utf-8?B?Y0xyOFFndlNCcUNzSWp1QWJZNkgxdG4xeS9DcW5VVDBmYVNyTEtnRG45V0ww?=
 =?utf-8?B?T0dMemtZQTlSTGZuYVNENUZHZHVPNWx2UUhxZ1VITzE0V0xzNHFNaUp4b1pX?=
 =?utf-8?B?SU5raWo1VkFvdmlRL1Q1R3cxSTErbHNEU3hYQW15TVVYMFRvajZpTkxCT2pU?=
 =?utf-8?B?RkF5UWs1UjdiNlN5ZytDUUpjREQ1SkhRRTh1bXVYZ05zbmhYb05CcXJIbDR1?=
 =?utf-8?B?RUxweXVZamptY2JGTGprUkpJVmtxOGxQdDN5d2FXbFQ0OWZuVEdFS0RNSkFv?=
 =?utf-8?B?bnhZSnE5bUsyVmRtQ0NHQ2RkYjJJRzBEK0krSmZBUk5FWnlZUUIvLzgxNXBu?=
 =?utf-8?B?MkRyeXNEL0VEalJwMEFoTnRaTDBFYS9IbHp4VTlOWW9LN1FYSm5vWjBiTXBh?=
 =?utf-8?B?TkFpYzRaaXNuRisyY1c2RHpBUkFpZ3FBT3FWdEZub3NlWTFTQmxzUHg3L0J1?=
 =?utf-8?B?Nm1NVlY1REw4bjBydi92dGFSYk5SSS9tN2VyOFVaUkpPZDB3SlllN1dnQ0Jv?=
 =?utf-8?B?NmZ4ZEJZbjZSR3g4UWRwK1VQYThlMlJEczZkU0xWZmxiVlcwbFR4UTNRRXdj?=
 =?utf-8?B?a29MK2R3aGZVMFBMWU1NdmwwSjNIRWxTYzF0UDUxRXJZZlR1dk9KYjVKMDgz?=
 =?utf-8?B?VTJJakE4U1ZKckVlTVl6ajdJZitqNGJjZG44QlFPcnM2WW9qSnBQajJUdG8x?=
 =?utf-8?B?dGZwR2k0cHBkTUxqOXcrVGZQeVhEVmgrUVFodWdqN3hDd0NoeHNYRzFPbXJI?=
 =?utf-8?B?aDE2V2VJRnQ0Q3Rtdk5OVUhjdE4rZ243ZWhUN1RHZVR2WTI5OW9TRG5qUnp2?=
 =?utf-8?B?eHN3NTkreUhtSkZCMWo0bHpFS1ZtSFZnbXp3WkxsbjlrY2JFN3VRZ1VIQ09B?=
 =?utf-8?B?Ym04L3hjTm1JcTFvd0Jzb1QySnA1S1dLV3lMaHU0MGRtcU81NldQbXNqNlFM?=
 =?utf-8?B?T1NBTnlGUkJONGhFcC9vK21Qd2JyZWJ5QnRsekRSMVMrdmppalVxZm43NFMz?=
 =?utf-8?B?VFd3NG5uRTdudFlYTUFkcWtaVjVEMXMvNmV6Si9RZDMyZFI0T2I5UjlzL2lG?=
 =?utf-8?B?VWcrbTkrby81ZTUzR2crUVpDMHp1aXM2WGpjMDRuSEp2UmRsQlREVGFKT3By?=
 =?utf-8?Q?r29VZPlBeYYPf5jVFEyrkPZvF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3c8530-b1bc-4aa9-f40a-08dc9781b8e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:50:59.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPI6bL+Nc2s/HAe+PQ+ti2nlFM+1ha6jg9P2AzEW8IWPTZCbeKjG86XEl8AKgbSFwzEwwycnmem1zz7BpOVIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

Hi Lu,


On 6/28/2024 5:53 PM, Baolu Lu wrote:
> On 2024/6/28 14:43, Vasant Hegde wrote:
>> We are working on adding domain_alloc_paging() support in AMD driver and came
>> across below issue.
>>
>> BACKGROUND:
>> ============
>> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
>> (guest page table). Only V2 page table supports PASID and PRI features.
>>
>> - With V2 page table we have an aliasing issue. Hence we added
>> per-device-domain-id when domain is configured with v2 page table. See upstream
>> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
>> TLB aliasing issue")
>>
>>
>>
>> PROBLEM :
>> =========
>> With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose best page
>> table based on device capabilities (V2 for PASID capable device and V1 page
>> table for rest of the devices).
>>
>> But we would like to continue enforcing V1 page table for UNMANAGED domain. As
>> in terms of IOMMU caching, it performs better than V2 page table.
>>
>> Also while adding SVA in AMD driver Jason mentioned that we should support PASID
>> with UNMANAGED domain. As I understand currently we don't have this feature in
>> upstream but we would like to support it in future. Keeping this use case also
>> in mind, we came up with below two options :
>>
>>    1 - Pass domain type : domain_alloc_paging(dev, type)
>>     When we add PASID with UNMANAGED domain we need a way to differentiate the
>> domain 'type' (See below attach sample code)
> 
> The domain type is not enough for the iommu driver to differentiate
> between device or PASID. For example, a domain of type UNMANAGED could
> be attached to either a device or a PASID. Furthermore, SVA domain is
> not a paging domain.
> 
>>    2 - Introduce new flag for domain_alloc_paging()
>>      Something like :
>>      #define DOMAIN_FLAG_UNMANAGED    0x01
>>      #define DOMAIN_FLAG_UNMANAGED_SVA    0x02
>>
>>      domain_alloc_paging(dev, flag)
>>      For now we will have 'DOMAIN_PAGING_UNMANAGED'.
> 
> Add an allocation flag seems to work. It doesn't indicate any type of
> domain. Instead, it indicates the required iommu feature.
> 
> Something like
> 
> #define DOMAIN_ALLOC_FLAG_PASID        0x1
> 
> means the allocated domain requires PASID to support on both device and
> IOMMU. If the hardware lacks this support, it should return failure.

Sure. Flag is fine for us. We can do
	domain_alloc_paging(dev, flag)

But that means:
  - For IOMMU_DOMAIN_DMA[_FQ] : pass DOMAIN_ALLOC_FLAG_PASID
  - DOMAIN_PAGING_UNMANAGED  : *No* flags

.. and when PASID with UNMANAGED domain support is added, we should pass
ALLOC_FLAG_PASID.

Is this fine for other drivers? Do you see any issue?

-Vasant


