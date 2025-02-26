Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30B3FE4
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545258; cv=fail; b=OvaG6nG3XdOI804YVJIOr+cOKhdWBCuoKtkJrFAViGPG01mvOIsCCMoM0o3WExyNtGZtZz2Yyb8xcvVvCaJMxng3KkkaHPSfcbT3vbH7QRHG3mQ8BPtCcfPysZG3eAzW9sGSrqqUvCkWLPn65tNRe7BA6x4bWaj2a0wFxfIXlOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545258; c=relaxed/simple;
	bh=XlUWvGBx+fSx9XI5OOjp40L8P/6l8UD9HVbb501FS/4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mEYxZPukmYTSuhjFqPNtDDLC3qh7icg3okM5gV1CMHzyKx+vPpUPjt7Sc70Bfl5MeZoWB6P5lzYREEGyV4Lv0t0SpLCHoeX/KBT8FcaZI0GzTXXFJhb/YtIaSAUwdH8CnpeIlKLiWJBzpeKdG5ELzejocDVBEYZJgP5A+79W0ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AdrGFJbZ; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AdrGFJbZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqKzfznbKiAm0wxngWkazOJBMGJcHSE5LMbpkMYpaSBjDVkzndUhct0AwQrY3bKHyhDQUyFWmyVB6zISdki18VH4xkSMlEaQ6fboQw0TWFawoD+nNAa1qAjtaPoVbFkFZbDrSMOYvdvaVWp5C4vVOvX6OKJ7rE92Ry6VHSoTac6LFxmlPuaGitFyJADxRpuRdRxBZiL9ffareS+2WRcScTvaFCX2D/MFJziN9xVHh+beZ81130GwydTYPEx/U0UrXZKiLpBmXZLRC6F4S7SoljT2b11jdrnk2TLsYpLnT2r8Fhk5W5o8591Q1QkZLGrCggr2jYSgB+XrSkwBfiZ3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1ClksGB8Ke7TZeAnsY+cgBzss3lAw4Iad+3qDCvsUQ=;
 b=BrrnDgmC0OFwhlPdNE4MJeZiDAryhLG0m/MpZ4AG4lilqrsg48En9o8dAyNu4QSOqwuShdfx3AH9Ul+K+aekU6wK+mcHUBQUfcXyVm0wIsk8brKPfIzLBGNSvCIPZgeETz3cSfjbdwbNSVqH2imBkW44/C43cXpBSp6FVTW7K+yQI4zOF4/UY7pZJbGNET811RKJdt3j7gJe9pJBGDw5+F9OWJVxitoeEvKBZ+w6fSsOOb/LhOAJfGIW5X1UFv5RKylNxVcmCrVU7KYiPd9OPOAjJHYg+bRphqUo8+kxIjzvNG/Tv5/L+jw/8vX8ghe0Jv1rTUVK8JtG1naILbmVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1ClksGB8Ke7TZeAnsY+cgBzss3lAw4Iad+3qDCvsUQ=;
 b=AdrGFJbZ0K3rxx8tSaqSnS5tpqfO0vPxuh3b2xt+FUn+FJGu38mgIbk+hrFr/Dzt4ZYZjk9pSkhLPZb+bjHxeaNQK4AoR5icazhrhulGopkiLbccuua3FboNFmBB7CKi0BqWIZCvjGdqlx8kpN0ES0q64LWSm/PiR2oNPXXpXw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Wed, 26 Feb 2025 04:47:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 04:47:32 +0000
Message-ID: <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
Date: Wed, 26 Feb 2025 10:17:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, suravee.suthikulpanit@amd.com
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250225145518.GJ545008@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e51f9a-f71e-41b3-ed59-08dd5620ae6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXVnczJxRHVMU3k2T04wdC9ONUFSUUd2ajhpRWRzZGRrRmQ4M01NQTNrMXZS?=
 =?utf-8?B?ZVkzTTJHdVIxanFUaGpOdDJLT3NBcGhFbVdZSk9kNlRlSUcwMng3TjV1ZlNI?=
 =?utf-8?B?ZVRmQUFBdDFSV0trMjBvVGxPbVliNUo1a1lnVmRxelo3cGl4YnBTUmhlWWZL?=
 =?utf-8?B?aGx5cTUwRTcrT0NwWFRMV2NOd0w1alJjdkdJYXdxNzBPVVhBc1VSNGpJZUdB?=
 =?utf-8?B?WnZHUWRESG9ZclY1M3lTeEJWNklZZmpieG9GRkJkNW1YU1llUzU1M2tqUkxI?=
 =?utf-8?B?eTJIMmoxcjhxOFYwWUtvUU9NeDd1RnV4NzYrbjU4S25EOTlaVjV2M29PUG9S?=
 =?utf-8?B?cmdLQjRra3V2bEdOTjVCKzdwOGJHTitXWDFLVGdwOVFSLzBQRTFQNUhacHY5?=
 =?utf-8?B?aCs2eHFpK2FYemd4alJYOUJadUhTb096ZU4zQXd3TUhGcncyamxJNzNkVEIy?=
 =?utf-8?B?VElIc2Exa1dxWjBLcUxlMlJDMUdnQW5URE9hcitDZmdESis2QnM2dnY1aVZ1?=
 =?utf-8?B?dGloRXlSdFBpZU1YRHdiUUxoWHpJcXhFODNrSzBUS21lWFF2UHZSVk9NQXpW?=
 =?utf-8?B?ejc4cnkwNysrV2VrVGpudkU2eGJTK1NWbG5FQzQwVmgwYy9FVklhb2FwSFlo?=
 =?utf-8?B?aHNQY1o3WVd3Q3J5TllaK0RMSmpNd21pRURBOW9kS09wWGRnT0d0RC9MU2tZ?=
 =?utf-8?B?bERUckJFQy9EUmJKRmpBaGNxMzNwcFA1d0Jacys5SnpKYmpYcG91TmZBQ3cw?=
 =?utf-8?B?SjEzNHRyODVQbHBveU4yV2k5WEVCZERad0Q5ZFBQc3BEUkNnM2Z2WDNIbTFY?=
 =?utf-8?B?QUdiYmhDYWlITHU0TFBTdTVpOXRjRWplNU9GTTNwcEpTSldiRHJJQ003dGow?=
 =?utf-8?B?RU9pTkZqSkE2ZmtvVU9lWU85Vk5lcDNUWVRBcnNwb3hEdURGOEVYK1RxUUp3?=
 =?utf-8?B?WXN6L3hweHpERSt4eVBIU3o0RDlEZUx5QW9sYW9nQnFOUjRMTDNLbURBNnhi?=
 =?utf-8?B?NGdkU0pvNy9DVE1OTFF0ZU11QnZDTkk2VE54Smh1ZGt5RzYrRkU3clNpQ1Jj?=
 =?utf-8?B?MlFSVWk5MmFDYjQ3OHZyOEM4VzRmNHEyUWZ5Nmw2RVZuNlhiTm82eitLZDBS?=
 =?utf-8?B?YlphMCtnRmpZVVJSNUhNT2dDQzN1Qms2ZXp4QkZEVXZ2UU9yWi9ac0txZU1R?=
 =?utf-8?B?RW5qM3YydDJqOENzdmtacUVQZ21uSWNMMHdpZ2VMMElKdFFkWk55OVJ5NC83?=
 =?utf-8?B?eng5OXlnVHFUUlJqRWt4c2xzb21iVEcySGdxNy9ReSt1U0RJcW9BRlFLZFpa?=
 =?utf-8?B?ZUpPaVpQZXc3VjRtQXNlck5Ycm40RE5ZMklndGZwZlRINVBwK1E3TnZrWC8r?=
 =?utf-8?B?MkxGc2RLQXlYelhhVzBRelZVM29uakJnTnI2S2dCektDMTdRM1FTWFhkNGhU?=
 =?utf-8?B?cGlYZEdRUGpvZTdkb2ZPSUUvZzd3eUFwUFFkVFAybXczMDdMaVJwSXFjZ2NF?=
 =?utf-8?B?cEF2U0lpaUtyTkdMVnpQcDB0TmJiYUw3dFBRR3U2cVBvSURtb0crUEdkWTVK?=
 =?utf-8?B?NkhITmM5QjJrNlFUWkdZL1hVdXBQcWQ1bHFXbjBWNVprelBMMEE2cGhneG1s?=
 =?utf-8?B?K29XTmVXVXVja3o5L3EwdnM2cjAvUytsUWkxWVdVaEVUV1dUK0JBNDZaMmUv?=
 =?utf-8?B?MVUzWkNrN3BoSnhucnZIemJ1L1lQalA2eGk2d29hNGhqRi9VUkd5S2FTV01i?=
 =?utf-8?B?WmZWVzhIYVlFaXVueHdFK3VaVWM5bnQ4Tk5PT3k1eUxNaDYvR3U2WU5ETGhx?=
 =?utf-8?B?UFVDTDhpQzJLUlBuL3k0aGNsRGpyVEcyKzV2Y0RXdE14cUZxeDVmbVI0eU9D?=
 =?utf-8?Q?x454auSY1zPbS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGRmbGVOR090Qy9OaVRlSTJsQndtTFFqNU9iR0NkR0ltdHpkUXE4dWhkTnJG?=
 =?utf-8?B?M1JZZmxFcCtaa2luK2czcUhxMGs5RVdnbkRUSTNTYnphL0VmaEl3SGw1aFVL?=
 =?utf-8?B?eGhGVFhvWkNFeUFKS2xQS1M0TmRsWGdXbmdxV1ZqMGEzZ2M4NlBvVzh0RVpP?=
 =?utf-8?B?UUljSXgwMmJ1RitSSzRDOWt5dmVaZElqN0hvMFcySFM4dnN0RUhnM2EybmRO?=
 =?utf-8?B?VGlNR3RNSDh1aGplYllGbnNPSGpWeDdUejVJVGQwQ2JBZ25Fd0Jyb2FOSlkw?=
 =?utf-8?B?aWtUSjQ3RkVxamM0MTNQdVkrNE5aUE9haERheDNjNm9XZFBCTnFsVFp3bzVI?=
 =?utf-8?B?NmZpbjRuOEVkdU41TzhscTB4WVRzMTl2ZnVDYnlSa1hNSWZPRUs2ckZVZU5l?=
 =?utf-8?B?NW9HT2xmV3Y4OEFJVHlVbURPSTRhejg4MjhDVE1VMk9hdVpJREtuTUhRQVhp?=
 =?utf-8?B?dUZDMFVPOVgxQ1d6WFBmL1I1d3pWa2w5a1pWVGNuL2tCdjRlMFJSK3JXUjVY?=
 =?utf-8?B?ZXpZTlRPdlFiOWRtZVpjWWViVm5yWmQ1ZFJuL1RLV002R2R3YWIraEhHS2l5?=
 =?utf-8?B?QW9teW52OGJUVFpwdUJaTkpJR01qTXljU0tlSXJZbFRnZDN0S0dIOGl3Umpj?=
 =?utf-8?B?N1VSSUpVamdqdE1zeXFBWGxlYUh0bXlQNjRlcmxuUmpCZ21RZTc3TEs3dUw4?=
 =?utf-8?B?N0JaR3AvTEtDS25EWDFBbnJDWVFsSndUWUlmUlJ3bHJRM3JhZEhNaWgxSERN?=
 =?utf-8?B?TDltV2hINmQ0VnBNVmJPY2x0NEw3OFJKV0NCdUdNcHdIeEZXNjVwM0NuTDE2?=
 =?utf-8?B?UFd5UG1wcWFCVXBhOVBxVkpMM0NPOGJUTFh0Q1VKb0VJKy9rOUU4YzgxdGFz?=
 =?utf-8?B?NGFDVHhsMjhJZ3BDRUVMUDlVYmpocW5Ic29TUVZsRlZ1cjVueWNWT3RDWGc2?=
 =?utf-8?B?a2ZteVFPc2ltRWw0TkVwdXcvUk5LSXhsRGp1d3JHYi9GeGFMdk90bWFib1NH?=
 =?utf-8?B?aVk4Y0FPWUJWNGxKN1RLMWRjSHZlYnF2UTJ3TTVIdkhHUXJrcVZSS1JtbmpQ?=
 =?utf-8?B?NG15TjJXam5HMXBRd3lZVXhSY29rMm5uOXhrNVZMT3VYS05wQmYwdVEvc2xp?=
 =?utf-8?B?TTJ2TFl3ekJxZ1FsaVp1a3JLdnlpcDA1SFpUYjJicXd4Q3JtOEU3b2RkNnJx?=
 =?utf-8?B?VGdXb0M4bGNCdk84YVNQRzRseGY0dzVrdDFIaEJ5dXNuUDM0YU81UUYrV0hs?=
 =?utf-8?B?ZUtxWURTSjgxY09BQmNFeHZHTkpxOWdhcnA0b1RCRlgyMUhLOERTd3NFNjIr?=
 =?utf-8?B?cDdsdi9ackhucFJBV2xwZXQvWi9PcGVzYVFudCtQek9YTGlhNjlOZFd5N045?=
 =?utf-8?B?NmFPNGtjYzROUmhuQWFRSnk5OUtydCtVOWd0bUw0c0VjRGpZUmZMWVVpckVr?=
 =?utf-8?B?Wnp3ODVYRVdkaTBXeU96VE1yd0p4UkQ1VHpNTEh0OTZWcENGVXF2cCtHbFM3?=
 =?utf-8?B?WG1JbDh2d1B4LzlpWEpTSVRsMjRyMGVCdHc1UXdNSC9CMUsvWVZPbjExcnUw?=
 =?utf-8?B?RW1PQlNEdWpZc1BhVHFaRi9tVzV6YWFSTzgwSEFYa3lkbWlyc1J5eTRoSE1M?=
 =?utf-8?B?YmI1azRiQTMrR3BOUFlvdlp5Sm5jOFV3TzBJQ2RDNnZGMjhmZ0ZDTHNFa0RH?=
 =?utf-8?B?K0tMMk1ZVFJKQTBDR0pLTDJHMG1RcGlBVm5DL01Za2FBK3pLM2poOG43dXBN?=
 =?utf-8?B?UTg5eXZsZjQ5L056WU5xL3Z1ZDY1ZG0vc0UzL3pxYUxTRk90UnF0RVJucWx3?=
 =?utf-8?B?bFkrRWNrNHZoTHJxdEFRK2k3TWo4QkR4bmEwSU1nT09KcW9MYmZkWGtPTlpl?=
 =?utf-8?B?M2FIUnRqKzRkN1lqejludnRVc2dSRS9Jdk4yOCtwVzdWcVZXVmt0RFNiaUNR?=
 =?utf-8?B?b09US3RTV1dxbjVLeU1tdjhqKzFxdVY3cFBmNDJEN0ZRYVgwWlJIcnZsK1I5?=
 =?utf-8?B?a1V2c1dtVnBCSllrQzVsRlk4NUZVVUJTMU5sZVl2WlRLdWtGNmNsaFlseTZU?=
 =?utf-8?B?RzBhbW5iQlhwRWxTT3l5YVppSXRKVHA2dnVGWGszNFQyd2lLRjlPNDNtY3hk?=
 =?utf-8?Q?DtTx0dBOrHffx/iGDE0UmTuOc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e51f9a-f71e-41b3-ed59-08dd5620ae6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 04:47:32.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSTvvtQ73a8t9GeDZ8kTvZATmnaIqoIvwu6XLuAdFIXf3vSvx9kua7CjPm4YCeexAKfNmqP/fHDsAx0wOfOd9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Hi Jason,


On 2/25/2025 8:25 PM, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 01:18:43PM +0000, Robin Murphy wrote:
> 
>>> My thought is to add a flag in iommufd_hw_capabilities to report the
>>> capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
>>> know if HPT is needed when allocating S2 domain. Userspace attaches the
>>> un-trusted devices to the domains with HPT. While trusted devices can be
>>> attached to 'normal' S2 domains.  Will to send it out soon.:)
>>>
>>>> With Secure ATS, for ATS requests IOMMU return GPA to device instead
>>>> of SPA.
>>>
>>> I suppose AMD Secure ATS only works under nested translation configuration.
>>> is it? I guess admin may want some flexibility to opt-in it. :)
>>
>> Heh, and in SMMUv3 we have both options, with split-stage ATS for nested
>> translation, and our Device Permission Table for full ATS, so it seems like
>> there should be room for some kind of generalised capability.
> 
> Yes, lets not have another driver-only command line parameter but
> somthing global managed by the core code.

I was not aware that intel/ARM has similar feature. So introduced AMD specific
option. Since everyone has similar feature, if it can be done in core layer and
satisfy the requirement then yes we should do that.


> 
> What are the options here?
>  1) Translated Address (TA) is a full physical address and IOMMU does
>     do anything (today)
> 
>  2) IOMMU converts a S1 IOVA into a TA as a S2 IOVA address and the
>     IOMMU runs it through the S2 to validate it. (ARM calls this
>     split-stage). Requires nesting
> 
>  3) TA is an IOVA and the IOMMU runs it through the full translation
>     to validate it. ATS is just used to signal non-present

Yes. AMD does this when Host page table is configured.
But in nested case, its slightly different. It would have finished guest page
table walk and sends GPA to device. when DMA request comes it walks final page
table (GPA -> SPA) again.

> 
>  4) TA is an full physical address and the IOMMU validates the full
>     physical using some kind of permission structure (ARM calls this
>     Device Permission Table)

I this this is similar to RMP validation on AMD.

> 
> What are the three HWs doing? 
> 
> I see #2 and #4 clearly in the SMM spec. Is #3 a special case of #2 (a
> STE with a S2 and S1DSS bypass)?
> 
> I think AMD is doing #3 from the docs.

yep.

> 
> What is Intel doing?
> 
> A domain alloc flag to put the domain into #3 mode seems like a good
> start to me. The core code can decide to activate the flag for the
> default domain. Suggest starting from pci->untrusted.

We need to consider various scenarios. For AMD:
  - Currently on baremetal, we cannot enable SVA and Secure ATS
  - Currently when SNP (Secure Nested Paging) is enabled, we have to enable
Secure ATS. So driver has to enforce.

Also what if user wants to enforce secure ATS for all devices? have kernel
command line option?


-Vasant

