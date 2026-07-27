Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA9412C17
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158530; cv=fail; b=fAjCs0FrmZeNGxxaL5MdsrhOoGEwx2OkVoheBSzUoD8bi9lvwhJHyyFU11/quDUS/1AKVqr9Iwn4TH7klor+aoyVlZN2TZxdvJ73JnhDJRUXmRYA3KofypdJcKYY0uBckaYEsHn7gcLFWJc6HrfSXOjBISoenpG4VDFv86rGohE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158530; c=relaxed/simple;
	bh=FXrz2WlxJ7KiTrJG1/olFrtaY3DZGxVhvuShZ1LuWDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FXwAUuzBQ6NlzL8hJ5iJK3m1Lv/h1bUvNMpftVuKEDIefQC4MhtvXylUiCOynOvLr5p72BxhDdZgrI+G6Wkx+I2u+TK9HaAF/8i5nEdD3H/ZVUAjpXdNZBAekevxk0ZTcCxJtgCxJB4HviR/t02uTo3h4y6893kIl8a50Y5F66U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xyYw33bm; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xyYw33bm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEZ/BxFThFukF3d6ztcgvpnSvN7QsOb3PCdrHy0y20f4GlWXNcIOJ4enFL55zXpNeBll8MavSXxmQKfQNnf9i+/cOpkWkxXqPOELuRTBDjaLmAUlvWygebhYkfMa67Q4mtNBNjotm2yi2nljG23YcMgBIyuVOD1m78xZHY6QTOliSxtIAMJlVnxKVqqXEUK9Ls0ilI8qgRHtPyQ+s6RReoTl4GnzObrx+rMNE3CgQ8rYLfZsqccHXCz76OYNBf/ah61UC8Vu8LqI27qjP4UA+4PESnWOB6Ocemd9u0Ie9mHh3/Lg7+yLn1+SJA8V12tFlfIb7lcgTIXqt8tCNndJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZhXIJYi/YtKHkuirw7K8UTldQ+NGHezv5Ck5A05JWc=;
 b=Nfgi0ILEK+EVvGM9ALiRWtlSrU23wzERm7bcHuynpvcZEwWJ5pX0sOyTnmWEuPOl96giR7yTqJVixNFEDTKeE7Y40A0L/3Fl3N/xEePd+pTdluJCoJH9yKTsareggUQXItbIu5rqRDKUTnjkaBApGBeY4aCxliO0Vk7alueoKy3AnV/eogs0SXrv1LxEqBtnoaSK0MM5Ue+qN6djVvnvCTnrqMA/xQTRTwK2A9k7NW8ifqgtD5b1cvXpWvgZs5nk7Gp8ww8N5a8AToL0YzGuz0X/0QgGWsj4ptuoEmZ98IOwyF3RucT9Co5kMsiVgWtakxDY0ijo/ay5gaTVPfl3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZhXIJYi/YtKHkuirw7K8UTldQ+NGHezv5Ck5A05JWc=;
 b=xyYw33bmvsMd+FSQObGwtUqIznJVTC9wLHALGbUpKJzZVQfPeNkQzLMopRGrMzwUnFJGSqx3DV+JWx8SruXChRaoo4PIiMKfix55th5Ok1vUbsAqXBkEIunVdsdbVz323FW9pTuz8Twk1gyNOrwF1L4x1e3eZrY422FDJHdZvW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:22:00 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:21:59 +0000
Message-ID: <322afd04-fca6-4e4a-aa7d-7ea20a50001e@amd.com>
Date: Mon, 27 Jul 2026 20:21:51 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/22] iommu/amd: Introduce and map vIOMMU private IPA
 region
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-10-suravee.suthikulpanit@amd.com>
 <20260707140734.GA220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707140734.GA220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:990:78::7) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 07092975-1c47-4d17-b5cc-08deebe20993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	J3933uJcU+L+CSlUOeDE1UESc4NOhu7CR+x0PF9RRMfGz/4jhFhz0W/ODZftGOK43bVh/+5+PLDEzxM45lAJNE+rRO1K339N0zpsbGUyW4BdTu51EsDsYvgTQ05VIQ67XUwY8qmQuHpxKiWToFzYDyO5gogUo9b6Q55ZfjMUcseVU0i51Llq4J3wM8tgLmtBXgPI6gfyO0kpH6DXEbx/BhVFs2jCde0iae1/H9BnN118uQqmWykUV1dXYxN0QVxYr13bFle2OD7tS07sONp50tTnpepIBtTugdGSFfZvdYKXbupS2L/7lqRXjC/VbAPkxTKzHBPh+qT2IWaKKRw0jbZNG904/DC0JoZzsTYZsGk9EmajHk8ynvnMx0eR9DXAX8CruqCWhFvIZegxp9mjRFU5WU8fhUzl2xHtvUlzqJY2LbgFgV6hpvjqB8JOoyCfYeOg//gMXPAUGLiFhwvn+eEEFoLV6pZcOZgQXg8BwLzxuN9aIUl9XZi1lVaaUFMifDoGF9oI8NtQdY+fmdA6+EEFvo6atnsnCiPrXTF5X0v2SEig2xD9P8u0dDGnNT4IG82xfu8hzE8eRHZOzQII7CJQwJIRVEQSYT3tARo7iNSy3WPK8MizNeUzj/mtRW45o2eivML+ymGbh4twsdlE1N+B9Y1Q+4CzBfGhamLmFUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJET1RhTEhVTVYvQitkS0tkdlcrNkFPNW1uMVhMRzRNQkNwdFk4eXVDUVcx?=
 =?utf-8?B?WjFUL2FaQjdObUE3Q2RUUS9aR29uNDlDWHJsV3RtQ0FGcFk4V0tmVnFxQWda?=
 =?utf-8?B?WGo4eXd3NVV5a240RlhnaTdRK1BsWU9Zc1lpWmhIWG9jRFY2M3NPMWJSZnFh?=
 =?utf-8?B?cXU2NTBpczRXa1FTS2E5Q1VzVTg3c3I3OTRpY1ROTDI2VWVBZ3VUZ2NPNU9Q?=
 =?utf-8?B?SHBvK1o3amliNjlEd1IzYXA3TVJYYkJjTlVKakRyRXFBeHpjYmp0N0V2VE5j?=
 =?utf-8?B?bEdWSWowU1hWR3Rid1pRaERzMkh6MGxucWIyRjNSbTR6a255YmZMSU13OSsv?=
 =?utf-8?B?RnRHczl3L1JkaDNKZnBhVGJqM01nclRxdWpmaHRHdjRNRTJPV2toVkYxdEQx?=
 =?utf-8?B?NXNUV1hPWnJqZXdKOGFzKy9UalFleCtpRTFvY3dNaVJFZXg1ZmVyVUlaNVow?=
 =?utf-8?B?Z1F3MlBJeUkrTnpDd3NGLzFldWNVOVFaRTVOaWxMYTdZazJ0dXlBazhYendT?=
 =?utf-8?B?bXhBVkpNTnhuU3hNL0NXNFYzQm1RQXRJUXFvbTdjMFlyOGFHMWloOGFwaVhQ?=
 =?utf-8?B?cldxTmJkUSttdktoczBDdTUvaGJ0TmhVNERXNmRYRGR5Rnp5TFFjcU8vTS9H?=
 =?utf-8?B?NTNhajJabVJsM1pFZEtFVHJic1NMZWY1UW1YelgxOHVQMFo4b2VIalV5RU1a?=
 =?utf-8?B?eFJPNTI5ZExyUmZIR0svOGxidFp1R1pWVDcwR25ldWxXTlc5cmNYaXlhby84?=
 =?utf-8?B?YVhVQXVGN0p3eU5DQmYzT091YkhvdU1IbFNLUnRSY21xeUFSRStXQ3RXWUlM?=
 =?utf-8?B?cHEvUDkxN2ZwdkZYUG9rVTJzZVh3SXN2WTNDRWZmcVB2WlQrcktxNnRTbUV6?=
 =?utf-8?B?U01ENVkxQkFSbFBTUEpMWUJGcTBoSGtqYW5YZU5HZnhJUFpkMWNVTWxuTXlR?=
 =?utf-8?B?WHd2cW0xa3pjTlFzekk2YjBkVFZYcktXdURkQXl0ejB5RWtOL1M3eHFXb3Fi?=
 =?utf-8?B?WnRTc25HV0FSdDJwSjcxaFpBdmZVNXJ6cnNiTFNpWWR0c2lTUVgrYjVzcGcx?=
 =?utf-8?B?bkVUb1l4V2pSTXVWMmVzL0FpOTg4Y0V5akVqK29VRElBajd2ZnJueHdHby9j?=
 =?utf-8?B?eExKS2JBM3lnamVRRDNvYU5oZkxGdmhxKzhHN0xCUGp0WTZvUmh5VUpCcmdE?=
 =?utf-8?B?MW9NQTl1UUZ0QzNTdkVJWWloc0dTYkZUUXJwRUtxV0FHY1R5OVoxYk5Pb1Rk?=
 =?utf-8?B?bXp3OGFnK2hjTmJyZTE4MHdMNzNZYjlHamdIb0VsQzVERUFSVjMyeGo2VmJK?=
 =?utf-8?B?MXB4Z3ZEVlpBOHRiY2laTDhlam4yVVlCb09MMjN4dHRWUkdteHg1K3E2S3JJ?=
 =?utf-8?B?Y09oRCtnRkVhTC9CdkNzTGt1Ty8xT0RoN0h3RDBYNCtLMStqRFhlOElSek04?=
 =?utf-8?B?UWRwWS9IbHZSaFplMStyd0tXaFpWOUxRTHZwamdWbG5jSm5MVXB3cVlmM1JJ?=
 =?utf-8?B?UytUWG5FZXBtUy9sT3dtWEkvUWlFS1lLVTYreFBaRzB4bjFJYXFLUVVMWGxi?=
 =?utf-8?B?SC94aGJQRTBydmh0RVprRkRnc1RiazV1QTNqblBjYnNnYjFMUXRNdFNiMCtw?=
 =?utf-8?B?Rnc3TlhGUlpHU1BiNm92TFY0U0FhaGFrV1lkY25xK1d2elJlWkMxMFRXcDZn?=
 =?utf-8?B?dVVveTVWWWd2MFF3ZFBvckJoLzNpT0YwdDdHZWNJODV5OU5Reks5WnNTb05D?=
 =?utf-8?B?NXlqZVNKU1hZbEhiTGJvaS82T0s4QVd3U2FHTzNyY3krejZ0Vm1VYjY1bkwx?=
 =?utf-8?B?eDFpbGc4cVljOEk1bmRHdVVkaWRndWkvTytiOUpQenJaSHBURlFTK1RtQ1V1?=
 =?utf-8?B?UGdEeUtnWFlzT1JlSmNVUHo0UWNIeStrK0FzQXkyMVREYUNzVlhpYng2dE5i?=
 =?utf-8?B?eFdPVGhJMG1QcG9ISFNDdkZOb200TEdZbVRFQmlEbkpTZTMwMjNUSHdVYS9B?=
 =?utf-8?B?NHZFWjVkRGFpSDRTNG5rWkJXZ2pueEVGbTFqbFFtNERDUEJFYjNtbGdEVURj?=
 =?utf-8?B?d1QxYmhqdFJ5ZDFPSmUranpoVitwNmR2TmxMUSt3WEN4SG5VTFdkUVRGK21I?=
 =?utf-8?B?RlhSODJ4cjJIV21sNHVKVXNhN1pFWktMa0JRaTcrNzhKR3JtS1ZHQlVIZWw4?=
 =?utf-8?B?SzZ4NVJTRnR2UDRhOG0vTVRRUFU3NGcwcG5FVjgvWHp2MjRqN2UzbVF4U3J1?=
 =?utf-8?B?eDJTMU5idXNpc2tMcEtUcHZ5ajY4eE9zT0JOeUdBRTBpcitJOUlyVTRzSzBT?=
 =?utf-8?B?V3h2ODRIaWRvUFc2dnllYjhFVEtWNHRQRk5SL29uZHdhRUowM3RGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07092975-1c47-4d17-b5cc-08deebe20993
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:21:59.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5M1IfIUyUESQ4B2UWYGC9t+l5ndSC0YjgmD4T7O41fa5QQiijEc6Yiyxz981jJXsgyCo2lQQDZ7Hk658LXnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145



On 7/7/2026 9:07 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:22PM +0000, Suravee Suthikulpanit wrote:
>> @@ -1808,6 +1808,22 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
>>   	return ret;
>>   }
>>   
>> +int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
>> +				      u64 address, size_t size)
>> +{
>> +	int ret;
>> +	struct iommu_cmd cmd;
> 
> Why do we need this function?  iommu_unmap() should generate this
> flush automatically, shouldn't it?


The domain_flush_pages_v1() only queues invalidation commands to IOMMUs 
recorded in pdom->iommu_array. iommu_array is populated only when a 
device is attached via attach_device() → pdom_attach_iommu(). The 
viommu_pdom is not attached that way; it is wired through the IOMMU’s 
own DTE in set_dte_ipa().

However, I am making change to the code so that we would not need this.

>> +/*
>> + * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
>> + * *@out_va is NULL on any failure.
>> + */
>> +static int viommu_priv_alloc_map_flush(struct amd_iommu *iommu, u64 iova, size_t size,
>> +				       gfp_t gfp, void **out_va)
>> +{
> 
> I think the flush is a bit unnecessary in the name

Sure. I'll fix this.

> 
>> +	int ret;
>> +	void *va;
>> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>> +
>> +	*out_va = NULL;
>> +
>> +	if (!iommu || !iommu->viommu_pdom)
>> +		return -EINVAL;
>> +
>> +	va = iommu_alloc_pages_node_sz(nid, gfp, size);
>> +	if (!va)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * IOMMU spec mentions that the vIOMMU backing storage memory
>> +	 * should be marked as UC.
>> +	 */
>> +	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
>> +	if (ret)
>> +		goto err_free_pages;
>> +
>> +	ret = iommu_map(&iommu->viommu_pdom->domain, iova, iommu_virt_to_phys(va), size,
>> +			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
>                          ^^^^^^^^^^^^^^^^^^^^^^^
> 
> These are the wrong constants to pass to iommu_prot

I'll fix this.

>> +/*
>> + * Unmap @iova, flush the unmapped span on this IOMMU, WB, and free @cpu_va.
>> + * Returns 0, or the flush error if amd_iommu_flush_private_vm_region() fails.
>> + */
>> +static int viommu_priv_unmap_flush_free(struct amd_iommu *iommu, u64 iova, size_t size,
>> +					void *cpu_va)
>> +{
>> +	size_t unmapped;
>> +	int ret = 0;
>> +
>> +	if (!cpu_va)
>> +		return 0;
>> +	if (!iommu || !iommu->viommu_pdom)
>> +		return -EINVAL;
>> +
>> +	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
>> +	if (unmapped != size)
>> +		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, iova);
>> +
>> +	if (unmapped) {
>> +		ret = amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, iova,
>> +							unmapped);
> 
> unmap calls flush through the domain, why do we need another flush?
> 
> Jason

I am updating and sending out V4.

Thanks,
Suravee

