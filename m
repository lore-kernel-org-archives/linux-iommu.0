Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5D495510
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417169; cv=fail; b=dSWWme8sKki0BZTz/DIeLchBFP4G/Jn0agR1prNuggwz6NL+QEh8/VmAj7pgz18AX1zuajFR9iRWAGrZ4RLhxbefjwZjFPlzH8zRY4qG/QUXSeFlFRV7Dq/j6eEd1m66UO4HNKnXAu7L2AUL8L2GR4oAZnZNxXOahf21qPa2UmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417169; c=relaxed/simple;
	bh=8KmUopJ29An74vGfwC10yIoswdCDAVmADYEO3FEX3YU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQI5ILuts7Wb3JnlBT8buPDiBR4IyGbt/3CZ0rlYP8998+Le67lqSeGFypFvJNqWPs7q5KzAwjKcwL7FevGRsQ8TEfXWZFpc3r1MADOmwF+FbZCERZCtoFnqwJnmbGwsiCgOEkNM7r0MdEPD30lHPwwo/+IZ/s1k6rqgw/I7Dss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zgwy/H6y; arc=fail smtp.client-ip=52.101.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zgwy/H6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYziZp0DfEqCxRXQzOuS1bx4JWCQQ70DZ1X/wKzVlEZNPkFMjEbVmgl8bHV1eIHm2Xk9X/b06mHXarz+RQte+xOVK04EZn0oJ74e8O5LnAbCh++GHMNWV6rnVUdU2kJl2JF820NgyXPU2hS2mbA3Br7VHjRo6i1qeBFtoWwGmioxYb3IrNKFBf1HApRgUUcElTGz64Sn3Y6DC5GLUFaS1HfAwqwlMd7qViJbqohjSV8KIFRQHhmgRsvG7pRDd22co8qbnpbaH4U9OzrRHO9de4qjA0KmEnl1kOwO496yM4SQ/ftOg/U2UWhQIcouRjfgtomndagAnon35dG/HDdr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehQRufu6Kw19laxxbfr6y2QHESby6WlCcyGgm4CfcBE=;
 b=Ov/U+UZme/XvgI5KLbKjyRpG/QjKWTqG11ZNK2xU5BlQpkUaJvYhfQKo9xzLlfcEccWsu2gksTWH6ESVnUsLBCzgbkX485csJT6AJT8YPwU3WM0/uON1CWwNSHR5V7NazX7ISMEHQeUa1LSjZEhqpstRhpvktoMxx9KCcSzJIOisgf3FMBV/ZlHUX4HRDSqIlp4wocIZGpJ3xJiZjP43U/zUg8VoEsmiCn587HVrW0X3QWXN5anfd3kM3gKmppShWOy0eIWMw7gtTzBD32XXySJIGOZzMaKp5OBC0TOLP/Z9bARqoiSiGPwr2afG4z4PWZVA4qGdfp3gyceOZUPvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehQRufu6Kw19laxxbfr6y2QHESby6WlCcyGgm4CfcBE=;
 b=zgwy/H6ya0TjhyKgCJm4xKeoYsm902OorCdOwWxdeEfC0qRpXKcGdO/CjHbfwSSN6etIEkpIrSLkVKJHF3Nh8kbaNwLIfkFiHxuA6uyVge4f774HeLcx6SMZysU/XKBcTBxG664nkn0vgDxJ+tzg6HYzDOCrF8PQofttOgxNYNo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS6PR12MB500340.namprd12.prod.outlook.com (2603:10b6:8:52c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:39:24 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:39:24 +0000
Message-ID: <c9586000-8286-48d9-941a-bcf2841fe79d@amd.com>
Date: Mon, 19 Oct 2026 19:09:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/24] iommu/amd: Store per-segment iommu_dev_data in
 an xarray
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-13-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0249.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::15) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS6PR12MB500340:EE_
X-MS-Office365-Filtering-Correlation-Id: a600c9e0-b7eb-4e09-66c2-08df2de6638a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|4143699003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QAH7hZZLN4JyYhcA7ebp2TiS/qkoWLWy414LXRnLSPtz0xMaSLTykf3mzjm1/8hoWaNfz0MHKo80HLLkBBqNHfSFhoEfw2ZC65Lwm2ZnN/wsBOZvgofAD7rmApNXkkcrzdfPGAY8o4sp6xSaFaew3qD0iZvzA2HJq/SeGboQtNyFlw6X3CPhF+4zQo80GMt5EzZzM8FZp3IrslokrCUi+PM9sWOtuFZhU9tWiAX8CEOtx+cmSvIUROXlQebPMb4mAwfTsdRqMa1vDQ4ts8SK78tBHCzFm8KIHdVwQ8Qz0uxRvjyzqaUYrkRerBXjh22QONc89qyobw5m703i9sVj5jRnCRVxLGn21sLY3Rm01eZM5a9z7nBiXuk0Kg4I2CMQ0AgHvH9d1R3fFSc6yrZ1pXj74xjEo85v9xhtfRq75vfyYpf2eGxbLmdkUJbd2LJEvX8RrlCt/azWj7ADB+Jg47+21cp63Dq4YDSvFjx8QZzLoHu5EsBw5u7Z2SMWty7pB5+lsWkqMnR1x3siWguIfNfefJ+oywwL7CJrqIb/uobumgAw5JUKn9lEhngNB8f2FU+SegxNQjhp3k20tREl0CKrA7fk1KamUM6O57NXy4B8k6T3ckyb3klzUeytvKZHLh3T6IFlNk+EcMH673OE7C7aDb6Oagn5XidTrWTbf4U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmxVVXBvRjVqSHozSzdIR0JrNkxBb29vUnNKazlZWmIram5YTEFUSTJ0SjJs?=
 =?utf-8?B?WkVWNU1kUHpsdXlZN1FhT1dvYy8zNTNyQmxmakdQK1ltTWQ5K1RiY2QxbHVo?=
 =?utf-8?B?cmxhdXFRenFMZTIyTWVhS2RWUEN5cjBVakwyZUR2L2hBei95bWpyT0hQM1FI?=
 =?utf-8?B?d0piT0h1MGg4dkZqOUpMd2dzcFhiVkVSNGFqc1JrNjcvRTVqZk5qbGtXLzhu?=
 =?utf-8?B?TUh2SDJZNHFJRFptWUpBajRFTDVYaW5ndC9Nb0dTLzU4ZHE0S1lmOHBIYjZ0?=
 =?utf-8?B?c2pvNFVXZ0VzWUlIRGlGbGpGWE8vMmpLQWxwU3UyTlRKRWtqcHhmQU1VYld6?=
 =?utf-8?B?TXF1OGZCcXJJL2t5VERxVHpjSE9hcXF2ZTFFV2FuM0Z6cUtMZ0VxaHlWc2lk?=
 =?utf-8?B?Z1dDek1zb0k0eVlPZFZVSnlZaUwyZGFVNDA5Y1FNUnBydjRhWEhoU1F6Vmha?=
 =?utf-8?B?aXZxcGNzUG1XbWF5Tlk3S0pvcW9lZEFPa2lFNitPcGNFb0tsaHlPcEhmTllq?=
 =?utf-8?B?VkhGZHY0aXBPdmtqOHhUeUVVanNjS3lyWEg5elhVRUdlUVh1V09vQm9mN2FU?=
 =?utf-8?B?Sjl6L1BKUG9uZVpxUnRVN0k2ZjdqQmRHSXA2SHZYWWcrUzhzbzhhcm5QaU5Y?=
 =?utf-8?B?WGtTSUlMQ3pEM3U4M1AxTlk5d1VlTTlSVnZkblhKNk9OemtiaWo4TmJxeTJC?=
 =?utf-8?B?TDhzdWN0T2s4RFNlTWxEVU9BV0ZhTU1PbUlpWS9XaGhFZS9mTmtLZjVvWi9s?=
 =?utf-8?B?MUdOVjcyN3Njc3o0bVZURVpDNmYyZ3BDcmhwYXRvcW9OOXp4QkRtRDVDMmJj?=
 =?utf-8?B?SlZnSDB1SXp5dVdRdllNS0ZUVXl2WC9YY2NHVFBhZTE2bllhYk5RMmJxSzZt?=
 =?utf-8?B?WUFLc0xKT3J3cU5DYW9KVC9CR0hpWDVDVWxvSnJoUk10cWRSd09mOEtCVnRn?=
 =?utf-8?B?TnNIKzArbVJVOWtHSmpxSFYzcHVIS1FHZXN0cTFLdTBDUWh0d2ZwWGNRc2Q2?=
 =?utf-8?B?enY2aHMzV1RWRzVSOXBCSElXRzN3VzNCMzBDK1p1VTYwU0Z3NjlpbENtd1ZN?=
 =?utf-8?B?R0hHdFJmeDV4eDZHWUZDbkRsZ0JZeDlFRCtoMHFHT0FXREpweFNLTk1aQXFw?=
 =?utf-8?B?Y3lCa3h3a2NiU1o3RTBPOVZqZWtZT3d5Q083R2h4ODJWSVR5VkcrT0JiMWEr?=
 =?utf-8?B?YzNOK3AyS2FXQWFIcjRCVGxaT3hsNnIxbHBvK1NwYVhDNE5ZbS9iTWxSbUVH?=
 =?utf-8?B?VXM4MHJZc3V3Z3NuK3VXVjFIZkNicURtV3FxRVNjdGhRVEpSK3czc3hWWHVD?=
 =?utf-8?B?N3JuN2ZwaU9DbHhHU3JVKzlRRXluQ1dESEJqSm9DRXh3SGVKNEhlSk9KTS94?=
 =?utf-8?B?R2JlWklOOXlLRVVYWjZlQVM4QWNQZGg2QWdETzNybmJJV2dsYXVsZ05tVGs1?=
 =?utf-8?B?S3JSVHBwdWxFaGJ0bS9meHlZbTRDMWlRb1o0aG1SSEtHOHY5alFBKzg5RDFD?=
 =?utf-8?B?eVR5ODFsSVkwbWdQZHZTQnVUUVU1Yk5jbVBsZ0RtTThkeC8wNzJQU1ArV1ds?=
 =?utf-8?B?VnpFeXdPRGRKek9CcFBNTkhWcGFHYnN2d1dlZnZqVGZMZTZteTdnV2xMbHd3?=
 =?utf-8?B?WGZ2NkcvYlBwSkVBbmlGQ244NkdwVWt6OWxSa25oMUlQQnhHOGpWY0JDTW9D?=
 =?utf-8?B?aFdTZEYyYVNZbXVvUEZ6d1dOQ1pEYW5sZkVGYkd2NHFzQm1lU0ZCQXJoWlcz?=
 =?utf-8?B?blVCRVJESGN6ZitVTTRHL3ZQcXowT2c3U0I3S1Z2a3M1VFp6OGltSzZpdHRP?=
 =?utf-8?B?M0w5THNJZElhRzExZ3BPeWRCUEtMSmVnNnpCcVhHNi9wb2RqM0ZwUkE2ZEE0?=
 =?utf-8?B?WEo2aiszeW1aSWN2VDJKRnZGM3czT1NadXNyU1FydVdtUjJCd2NYOFpUdFVW?=
 =?utf-8?B?bXBDUVYwMVd6UWhIR3dLSm9zYUJ6REt4RXM3UjU3U0xBanpiaVpuamNsVlRs?=
 =?utf-8?B?NWs5dENjQzVYa3FmQWJ5T3JmT2E5WnFERzlrQ1RyS0FsR1JlQXRja0FjWGVL?=
 =?utf-8?B?dWozb2Vxa3NzTUJKODRFbmV4emEyMVZDa1dpUWxRTGFrRHdiUmU3VEZBRVVo?=
 =?utf-8?B?UXlCM2tpa3h6em5aRnNJdndNWmVQL1VqUTJlUHRNdXVNeFhYZGloYjVkUlJG?=
 =?utf-8?B?ZEk4dnBmK2ZwTmlaU1kyM0tKTFpRNXp4aUlDbDB5SitBZ2VFMHlTWjZDdFow?=
 =?utf-8?B?TTZNelE4S2Z3d0ptMGlQOVFOMkxmUklvajhOcDlmQzR3cUxINks3dUZvQ3J4?=
 =?utf-8?Q?rThk+aXgann8Z7tHm+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a600c9e0-b7eb-4e09-66c2-08df2de6638a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:39:24.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHNe704RKsfGO94v8nIzJ214NDVbWPK28qyzdJm3zZD1A04C8kL+Tv9kTbuQYG8uLNNRLrQGhxOH7pLf2kbETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB500340



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Replace the per-segment llist of iommu_dev_data with an xarray keyed
> by devid so lookup is O(1). These objects stay immortal for the life
> of the PCI segment: amd_iommu_release_device() keeps them for replug,
> and IRQ/DTE paths look them up locklessly via xa_load().
> 
> Same-devid intern on xa_cmpxchg() covers replug and racing
> find_dev_data(). Aliases still get separate keys. Intern remains
> local to iommu.c; only the lookup table changes.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 ++---
>  drivers/iommu/amd/init.c            |  4 +++-
>  drivers/iommu/amd/iommu.c           | 34 +++++++++++++++--------------
>  3 files changed, 24 insertions(+), 20 deletions(-)

.../...

> + * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
> + * These are never erased: amd_iommu_release_device() keeps them for
> + * replug, and IRQ/DTE paths look them up locklessly via xa_load().
> + */
>  static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
>  {
> -	struct iommu_dev_data *dev_data;
> +	struct iommu_dev_data *dev_data, *old;
>  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
>  
>  	dev_data = kzalloc_obj(*dev_data);
> @@ -404,26 +409,23 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
>  	dev_data->devid = devid;
>  	ratelimit_default_init(&dev_data->rs);
>  
> -	llist_add(&dev_data->dev_data_list, &pci_seg->dev_data_list);
> +	old = xa_cmpxchg(&pci_seg->dev_data_xa, devid, NULL, dev_data,
> +			 GFP_KERNEL);
> +	if (xa_is_err(old)) {> +		kfree(dev_data);
> +		return NULL;
> +	}
> +	if (old) {

If old is valid means someone is already using devid. Allocation should fails if
xa_array is not empty.

-Vasant


