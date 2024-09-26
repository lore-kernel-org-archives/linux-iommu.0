Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60B1AD3E9
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347405; cv=fail; b=CcYBFsd1zI5cQRXm3b3MJ+vFVcxZC4CVDTnTUYmy1gA3TT3cqRymh9NjbT/KuGIAJ3Rj3ZZ5pqfvE6kXYY6PhbNARDxgG9Z1hzkGFnrxz21vUUnXU9wwocH7SKSmbbpRnWWPBL5vaGGu7uqev5x/Y1Ovdce+H8rmT0/XswhPjcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347405; c=relaxed/simple;
	bh=65mnKoMbblD1iPG6cfMVL41YTFFaRFzZWWZLU3VLjUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CrDkRlGNrLI6Cxu3agtOEI/LXN+t3WGP2UVHpZ1xBndzsYExSzCPDZ3ldBBLyp74sCklPbE9iZ009FkzTanLvt7C4vGp/f2LvKeYk4qdc4OnFlOgcwZynf0Y+B7x4edtMoARVBdawbCdfLElPcZvcLBm+yMXXIlRrrfqTmpFvOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdIX+SjL; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdIX+SjL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB+ng7x5jRvjJ6PeCVfhzmhCgbQMaSy2Z5HD59ExcSr+lgG99jOyun2MViatT6lfl6yHZaFQVsTM3ZMcYAxRzlX8mLWpQgNdsVSNr4vGHpih4dnDT45mcUPTvayqtpEu17O4FlJz9QIIgE9IJYrDCXPBsIXOcTyCmgIJWkyIkAoP4QL0LJCSibROmBEzgcibg6Vgey3qzVHgBJK6UYupfzoFNwneuQb6Sh6z9sQ7xMPaPw0mqW51e9cwUvSIF1V2B6KeAeSTwSABAywgJaAE3UMu3EeRXLVy+TfIih8wI9kFGhx9rG/yLeD12BsZFQ4MmWFkUE/K9AXXC2lFNg4lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/z8LRTzgqikWz1VvoZjqHrFhhm5UHz37CO3Y6yFC5E=;
 b=edGxSRmr5XDnEAuaholhMAcKIBs+soEdnb8q3WTZV1YKX8/inwty6uizy7XtnDf7jxgNnYzgvuievkrUzPeszUSwj1scwwvCT2LCPJ8KMXa6A0PO8CSrndN1JumQ8knFY8J+U/FD2bJp3RN3HndqCoZPSx6BSzEHa5m0q0E53dDS5zfeQpQJ6tESWirs7ySDv5zLuui5RVyfGw4EMbsaeCkgDHfM3U51VGjVOY0szvhSqQoUWzVt23Y7CDRB4ykTzTuCXjGEsBZMSbpFoT3mJrXr1El8Zorymyll852hccDd6TlwJhq4t4FKvGnH5eyQ8GqxlB+qL2iHqhfU5s8xOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/z8LRTzgqikWz1VvoZjqHrFhhm5UHz37CO3Y6yFC5E=;
 b=ZdIX+SjLXiGJS59qMzXz50FsnVv0EHgqSTtV3poLwG2N1JqIuWGhuqpn2SQ+HQZpr1dMxVcmVLVpXKqslRzZ1vOqzSs5BTdpt+rN1TdErHfEqALLh6OrkH0pbW1rGXPCQ6PIP10WWVZ81mJ41pafKsibp/lQwd1adFMEAfTjWZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 10:43:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:43:19 +0000
Message-ID: <91ad0a4b-6c66-451d-9d8a-dd88598dca6c@amd.com>
Date: Thu, 26 Sep 2024 16:13:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, yi.l.liu@intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
 <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 44fe5da4-c36b-447a-7e9a-08dcde1808d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUVVbzVWaEljRlhZQmhsYkJHd0psQUd0ZWR4bW1YTXlIU2x6dURnbVZCOU14?=
 =?utf-8?B?WXNDUHVYc3NCMEtqOEdnMEQ4UW5CcTVhWGUyN01jcjg1UVY5cjlmR0NmOUJt?=
 =?utf-8?B?ci9Yay9mNVl3c1k2VEtGUng3NHVJRTdhWkIxMUYyUWM1N0QvSm1KZVNnc2Zr?=
 =?utf-8?B?VWYrQVFXNWRQUXFBVkpBQWFmaUUwcDRiNll2MUtFL1ZyK1JPdWVCQUxKMmd2?=
 =?utf-8?B?RTZrL0thTEJ3aHpYQmt4cjJYcm53c0V2QlNBSmVYelgvR0ZhSW1YUFJZVlR3?=
 =?utf-8?B?dVVOSGFieFgrbHhqMUxxOUxXU01ZbkpPcUlhcldXdU1hZk9QYVMxblM0cjJJ?=
 =?utf-8?B?VGZwUUFZUVZkUmVVa2x6Qmc1cnJSb09ybUkyY3ZvbWNEM3FoU0IxbVZEcEVt?=
 =?utf-8?B?Nk5GQjR6dUJVakgxd3U1THZBUmFheDVZS1ZCV21qbFRDVXpsSWJyaWlYTExv?=
 =?utf-8?B?dStqREo2cU5uSnlmTGx1eTR1bmYxME42d0dCNVQ2OXoxQWVRTkVEWTBkTTQz?=
 =?utf-8?B?T0VVQ3RjMzdZTmZxMER0N1dyS3gxTVNjV2dvNUVOaEFyNHpIVlJhTU9ISDBr?=
 =?utf-8?B?SHI2YkZBbElBS1hLQlhQQllReXUxMjdQbUdTUVNGdVk1cTFBL3JxVHB2SE8y?=
 =?utf-8?B?SHhiV2FkNWFuZWgvVkJJZ3VqTEZ2dGVaTEgxc1N1Zktjb2hIVXF1QlJWU3lI?=
 =?utf-8?B?UGJuekFOZVQ3anZaRWh1N1U4UDdhVE1XSDkwMndINUIwczQzdHZTUmgyaUFQ?=
 =?utf-8?B?ZWRpL1pDQnhxS3VaeWt2RnRFUWxkblJvTTZ6YXNPQjlIckprSkF0WWJ1cWx1?=
 =?utf-8?B?NHRRUlVlODE3cVN4MWJFc1k0bnRzRkRkcTk4ZEVjRnJIN3RReU5ZeGliVnFR?=
 =?utf-8?B?ZVdxSXZMdWR5Q1R6M0k5NHF4V0IwOXViNXdueG5qcXNHSTk1QlpQZEVTaHg2?=
 =?utf-8?B?Y2d5ZzV4RWZpNkdEVVlKWURNN20wd2JXZXdTN0o3VlEwWXBiWDU1SjVweGpp?=
 =?utf-8?B?czNFeHdrdHBWQ01hOFdCNFBVdzZrRzRCMEtOK2ZyajUxQzdCajdUSjI3c1dQ?=
 =?utf-8?B?bFNaS3NTQkFmWUd3bUxGU01aYmxQem9WZFdPVjRzOG51Sithd2I0V0pmTDFy?=
 =?utf-8?B?VUxhKzAvbE5VcmxzWXhBYkd3TktFZ0Jla0Frem96NXRUUWhCVURuTUtYeDNy?=
 =?utf-8?B?c2o3alFJU3dvZVJMeU44UGFJcWU0UUdpVi9mY1NuQzNuRk1seEk3TmpIWlpQ?=
 =?utf-8?B?bnZVQjZQb3gxM0FQNzVTSVJLeG1BcTEyRHlBMDhieWhLVzJpMGc1SW1zOTRs?=
 =?utf-8?B?ZVJPWEppQXdJaWpNZWVNWVlPYzVHZ281OWw4cVhlTUZWQ2oxZ29qYThjazl0?=
 =?utf-8?B?ektxa1RUNXRVNUlBRzNrRHB6SmtmeVFTYWRWc3VLY2dsdDFLUXZtczhuL3d0?=
 =?utf-8?B?a3UwQU9GUFJhaGlRVG5pbGdINnRZV3gxQURNa0UzR0MvdytaZVlRNGhiYkpK?=
 =?utf-8?B?ZnVCa2tvNXh0dklPb3ljdzdkblVpM0R2YmFKRWNlTGJoN3FyYURXS2VWUDJQ?=
 =?utf-8?B?TWprS05HYjJIVjZYcStKcjl2UHNIRFo0bnkxbmIwTWZiTDkwKy9PNlhtTWNr?=
 =?utf-8?B?OVhzeUdCWEpUTjIzaGlTWUN5ZGx1T2xrMC82Wm1tWXRydXl0ZnJyNWVtdHdK?=
 =?utf-8?B?Z21QMk50N0FaTG9YR3dPREFQQmxYK3RXNUVESE9xVCtZRFZ5V20wSm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGRtWnBlZjhzYUpQKzB5RTNKSmczZmdBYlpCQTdNQXB6bUlHLzkvVnVBMVpi?=
 =?utf-8?B?b3cvOVlLMXliVHgzbUV2QlBGOE1tNlIxc1l5SVBQSkVGNjRuOUJyTVg1dW9Y?=
 =?utf-8?B?cTlEbDVycmlRamlwc0FJUGxGbXA3QnM1TGlZZUJia3A0bEJOR2NoMUNsYXZO?=
 =?utf-8?B?SmZiNEwxcG4yZ251Rk9LN25Lam9lR0FzQ0FNRUVCYS9kTW9aemxwZzVNcjFX?=
 =?utf-8?B?bXVGazdvK0lBMDJuZFlEY1FySzR4RGMzQ1BFMDVoODNWZGVleCsrcktrWGZj?=
 =?utf-8?B?bWc3TmlUd282WWx2OUcycXh5QzUxTU84T1lNZ3QyOWQ2VU5VSmxVWjk0bWtY?=
 =?utf-8?B?VU9RaWE4ODN6Z1hlOXd4bG1ESi9zTkRZSkcrdExVb3hQRVFEekRINlY3eGZk?=
 =?utf-8?B?cWp6eUlyQUFHMjIrL2J0U25vOUdlRnVrdWxlaWFWbFYzYTFld2RKNlBneUNi?=
 =?utf-8?B?MS9CU3ZOeWVVWFZJbnpGMEoyTEkrc1JVV1MyZWlvUVBXbVNWUDc4aGJqSmI4?=
 =?utf-8?B?SStBMW5mRlVKWTBpSjNZbWNreWlxMjI1TlVqZktuZG1KWWRpbXpFVkh0UGdn?=
 =?utf-8?B?Wk42alJYbUN5ZGtoWUJCU056Qi95YVovZU5NdkdNcnpkN0tmZ0I5dWRYWmhD?=
 =?utf-8?B?blpVanBrdHpwRFFsY0hteGZJYXBuMGoyeTBWalQveWtTS0F4QVRyMUk0cWVI?=
 =?utf-8?B?OGM0YzM0dHVmVDd3RVE0dXh3b3JuNmp2SXpEellUYkZzcysweVdxWUJBcFdJ?=
 =?utf-8?B?ZDRkNGozQjNnQ01ibExOY1VhQkoxSGhzR0s3dFlLY2ZxWWZ0dTdDY3ovdzNO?=
 =?utf-8?B?L09ZajE3WFJEY0xzOXAvMlNidktySktWalNDdDlJSDhzWVpXUXdhQUdTckYw?=
 =?utf-8?B?UXJ1WmcrVzhaTFFhY25GVUJidVA5QTRtOWwzZS84UzlLNGJ2bmdRRVEwUXlh?=
 =?utf-8?B?SkI0V2cvNHQ0Ymg4NGxhUHVETXNCd3F5N1ZydWZTNi9kZWZ4OG1sL2RQaCt6?=
 =?utf-8?B?QURaWTVEVXYrNE9DaUpTSHRnYTlyanNhK3hUek5KeU9QcTU5Mk93SWwzUEVx?=
 =?utf-8?B?aHZNZk9SbDZkb1hjdEVPZVNXZHJPZ1plL2t2M25MaG5iQ3dTRkQrZldkNVlG?=
 =?utf-8?B?UW1URGc0UnFkcFFrZXE0M2lPOENUbENZZWlwL3BFUGJ3NC82dlZCeVBLZ243?=
 =?utf-8?B?TTNTQmd4enNtVGJqWDJ3VHF5aWRXNkhGQmZtZGpNdSt6VE94MEd4RHhpMjk3?=
 =?utf-8?B?YnVnUEoyOEl3R2FmNzBjNHlDODZaYnM1NGZUU0Q4Ym4ybUFpeng1dlozT1NF?=
 =?utf-8?B?d1VuSWFoZUpRMFRUejVPQzFxU3FCVlVTbERVcXE4VVJRY3lXWUlPTWVycFJF?=
 =?utf-8?B?NENramQ3bDZkWG0xeXNvN0ZzQWlwREFIbkk4aElNRkhIYTdYZm41bFA5NXJU?=
 =?utf-8?B?OEZlbTdvOFRwSTNNcnE1and6MUNMMTFCc05lMGZnTmJVZE0xciszQlZYdWFr?=
 =?utf-8?B?ZG91YWMxTzFvTG9yZzY5TmdiemRmYUUvWm5kVDRvU045dmM5d2hiM2NNV0I2?=
 =?utf-8?B?SHc3L0o1dlJsYS8vVTZyeWJJODY1VVVyWmFLSDRaOGxuRmVQSEtnNFhqOWs4?=
 =?utf-8?B?SHRiVmFxQWo2eDlnRzJPcW03QnVoRGlHNEcxQ2xEdmo0WFJQTk5SVWp3ZEtv?=
 =?utf-8?B?SzFVWXF5NGZabEFLZ1ZTajIvNmJ6WlMyZ0pNUjVCb1hxYVlDZ1VaczJ6MjRO?=
 =?utf-8?B?WDZwQlNmQkk3dzdwVVdNZ05vejM3UW1RZzIxWEpKbHRBUW1vdm13U01iVG9u?=
 =?utf-8?B?VG9OWldPUUtzM2Z2UEVZaWlYN3NmdHFxYVYyNkhTL1lQVDVLbVB6U2ZIVWFW?=
 =?utf-8?B?MlNyYWdOSXArOVVtOFdSK1pKa1ExUWIrRERKWVVkRzFwV3IwZWhra1NhV2F5?=
 =?utf-8?B?MzR6dXo3aG5NaHN4UUpWRWV4VzZrU05MKzh5YnRFUTgvM0hOTW1TYlRRYS80?=
 =?utf-8?B?UXlSZFJlUjdaNnVRcm01UDlINmE0L3YvTkhPUUxqQ3JsZWRGUXBtVVhTOTZ5?=
 =?utf-8?B?c2huaWpHWnNabXFwUytveHZXUFFvK2h5U2ZPTFRGUmpZUlMrbkVBZmRZaXE5?=
 =?utf-8?Q?0IjvGdSLb10ImM09BEQ8qlxrU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fe5da4-c36b-447a-7e9a-08dcde1808d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:43:19.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE5u1z15QsvSnRTIOuN9rlQHVvuDM9p4Di/MOYLiPGqxBIuS3BP7SJMvmgHvzlsnrNowSyt1CnAmXLXj0KTusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127

Hi Baolu,

On 9/12/2024 9:34 AM, Baolu Lu wrote:
> On 9/11/24 6:19 PM, Vasant Hegde wrote:
>>   /**
>> - * iommu_paging_domain_alloc() - Allocate a paging domain
>> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>>    * @dev: device for which the domain is allocated
>> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
>>    *
>>    * Allocate a paging domain which will be managed by a kernel driver. Return
>>    * allocated domain if successful, or a ERR pointer for failure.
>>    */
>> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
>> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>> +                             unsigned int flags)
>>   {
>> +    const struct iommu_ops *ops;
>> +    struct iommu_domain *domain;
>> +
>>       if (!dev_has_iommu(dev))
>>           return ERR_PTR(-ENODEV);
>>   -    return __iommu_domain_alloc(dev_iommu_ops(dev), dev,
>> IOMMU_DOMAIN_UNMANAGED);
>> +    ops = dev_iommu_ops(dev);
>> +
>> +    if (ops->domain_alloc_paging && !flags)
>> +        domain = ops->domain_alloc_paging(dev);
>> +    else if (ops->domain_alloc_user)
>> +        domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
>> +    else if (ops->domain_alloc && !flags)
>> +        domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>> +    else
>> +        return ERR_PTR(-EOPNOTSUPP);
> 
> How about
> 
>     if (flags) {
>         if (!ops->domain_alloc_user)
>             return ERR_PTR(-EOPNOTSUPP);
>         domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
>     } else if (ops->domain_alloc_paging) {
>         domain = ops->domain_alloc_paging(dev);
>     } else if (ops->domain_alloc) {
>         domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>     } else {
>         return ERR_PTR(-EOPNOTSUPP);
>     }
> 
> ?

Sure. This is bit more explicit. I will fix it.

-Vasant

