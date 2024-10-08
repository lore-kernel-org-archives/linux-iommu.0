Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759D18C93D
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728382119; cv=fail; b=LA8EndJHglxzWShxgbS2fitxObqlRInTp33JcCd5XtEV7PUyLh7I+NuQmeN633tEyJ8KU/qoZmJQokli/kxA54pK6f1JTnB0wPrPWseTNF4eFDc2GlmKPOkJMrzJ4W9KNtr+gnijQMi0AiDWFDrOEecuijzvcaKLKXRnXB9yTEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728382119; c=relaxed/simple;
	bh=LjbrUCXRGhtpHxFpsExmhblk8I8dX/VQcDnKagmsu88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pQ++l1Q56E6m60ZtdcSCRcsgl8dCno6JRwk1z+4c0oCuTLh+qGhpQX2nnC1pi5dSJeK2dSu/iidJOWwO0uzE8Uf8fBqKo6JewQHZd5bpUkaGXYb685K4v7LaTokAlwPo+M2lFetvz6Gj0gelo4iFpcRZHCjBx+RrOAd4rAJaRzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LUzgQD2i; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUzgQD2i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfSP80dhW//tgBHgc23lQYNFT5xBmi0kJLOodDF8uKJgVM8F0AgxG7Zwl5FFvGjkZhHbxdGdbA5DEHKZTVmYjNjPxYAcwuJ3iPM5auaAT05b99ZtbOCZryeTlBUG75R3pMZr/Gb6q9JXs67RZZoFU/U3NFw9Q6ci9xt3vch/5gFanfNP2xM1sGeewn8yYajnPRo76I7iEltpSyqoRqv1DfOcsrdnsUQ4rdrqx7+hO8IP2dUSKfbIL+fGlocLbf9Ommyf/H1rXiipLUfkIVrBGWARYmZ9rLgmO1b9ulSQuQk5HzodYqCs6SFhOpMiek1SsPbDbgMOneU1IQKDAP/zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6h9gg/5X7wKDsUcVh7qiFwFcLsqylqhPqIlseKBA6c=;
 b=o245+nNG4CkTQttN3CqVKUOkvuUPFxrvCNF1xVBVNxJwoGmkcsiNaPc+9y+Hok8Ea4pwYe2gr7RW3dYcvtKI19er5LO+NSaaYNuKPe2eu6teQJEJWv8qPbRy82MUlDov9YxbOXQXM+yx0XyWW7kGgnsKWikLqN5k8hlSKstYjLzJaK9jjs2zrourSfc1Z6+3Q3c4Uk2fEV4joQTiOLcrW4X4xFdYdSStb8YPn4ZbNujNDHkyO7S2nYSxQrOD2+n2ghhmnSqdd4Fxamm6jnkdjWwSD5baHPQ4enrxM+OIm4UbVNuwM/9BAXRcawIzsUQldpy4EPVJnvVBs30LyfiYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6h9gg/5X7wKDsUcVh7qiFwFcLsqylqhPqIlseKBA6c=;
 b=LUzgQD2ir+ptEo1j7NBqEb7B26AMt4qDs19S0cLPqUb6zjizwf0vsKFKpEJ1U6LDXbXeUR3xxkqFg3j08lHPnm7wb1Wjz26RJfTS1tsygECCwIpfn8ETeUmhiS4cCQe3H3RQulAgAfVIPwDZQhV8stzxPAWxS3E/u14o+VHYqxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 10:08:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 10:08:27 +0000
Message-ID: <82c99d4a-ce86-48fa-9f08-f24a23f83a00@amd.com>
Date: Tue, 8 Oct 2024 15:38:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
To: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
 <20241002193345.GR1369530@ziepe.ca>
 <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>
 <20241004125606.GH2456194@ziepe.ca>
 <a604541d-6de5-49f4-a8c2-190e68356acf@amd.com>
 <20241004153144.GI2456194@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241004153144.GI2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ae44fd-2d67-491e-1354-08dce781274c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2JucWNuVG5za3hUa1llNFlaWlhYMDdHazAzYmwydCs0Rk9LN1c5RU5lZTN2?=
 =?utf-8?B?dVluWlZOK3NWR1JNNlJFRlBrR1N6NXU1S2N2SzBrVUx5cmszRmkyWDRLMEMr?=
 =?utf-8?B?aTFtam5YQXVxWHlEQ1NhejE0eE83YzNHTzVkanYxVTZUd3psSUdmZzFzbGxH?=
 =?utf-8?B?NGwvOFFNUVpPU1ZQandtc2xLaUpMWURSbmZOeHJBTkZlS1ZvVGlrVEQvcDFq?=
 =?utf-8?B?SW1aUUgvbmh4U3crUVJPVCtsZExyckZMRkliaGNEK3hDQTRXUU13dzBVQUtI?=
 =?utf-8?B?eGVSVXVibkJTanU4Um1WSzBWNjNxWXBCTWwveWV3ZVB5RnlqSWxPM0k1OERm?=
 =?utf-8?B?TG00M29UZjlPRUhWR3FVY1pWNTF4TzRTV2twbmpYcHBhUjBNSDIyM0xrRm5l?=
 =?utf-8?B?RTNUV1libm5TSkZkYmIzVzdjS2FsYWNiTFpWQ2p6bjlhMDVEOE9UbDJVQ2N5?=
 =?utf-8?B?Z3ZSSXFjWThtUVdoQjE4bXYyZTQ1ek5aR1RMSzBrdFREK1NTVkhCTUplN3lz?=
 =?utf-8?B?UnZ6aUlXOUhjeGhOcmlRSENiZWwrdVhCek5tVGo1MFAycWxGaVdKR28zU09p?=
 =?utf-8?B?R0dyZ0xtR05seWlSSlJJbFJWY29SZTJta0NTTVpsdUljYWZESlRNK3d3dUkr?=
 =?utf-8?B?UDJYbEdNMHhPZWRMNzErYlcwaCtabmhLZVlON3M4MEw4YUdFQmM5NFV4cTgy?=
 =?utf-8?B?aktlK2ZsY2QzQkxJcUU5Zkp5RHhzYXdkZ1dHQU54bkVQS1NET1BOeitpTmhm?=
 =?utf-8?B?N0RoOWJoS3h4eGJzU3dnVy94Z1JMWitFVVNwcjFrclBGK3lSQnFHWkFaQmFV?=
 =?utf-8?B?bGRXSmJ2OWtjb1E5STE0L0wrWmorb05ldGxNUW90Z2x4cUNlVk5mNm9BM3d2?=
 =?utf-8?B?VWtqWWxmRTZiTDBIakJMZHhqaHhpdnlieGU3M1cxS1ZHM1g5QzZzL2o4UG1O?=
 =?utf-8?B?T2xoQUJoYTRsS3BsZFI2VURTTGd5djkvM2ZCMzVMWVJsdEdnbUxTRU1ESG8z?=
 =?utf-8?B?bElOSGFrZVkxeTZuUFBmQXVQcE5sdU8zNEdBK0M5UU01eTF5SHN3RnkrZnJp?=
 =?utf-8?B?ZmJkb25hSXpzVFpFSThtZFVOVFp2V0RSSWRDTDNNQ0JnL2VrVGFvWmhtUnFR?=
 =?utf-8?B?QmcvMEZxdlVLMlB1OTR0cnZCcVNzQ09GcXA4SUJQdG1DbGx1YzNyRE5wY0Fv?=
 =?utf-8?B?QUJnS2MzQ2tnNEwrKzJINXZTSHd5Tm9IblVOZCtid090c0VCZXRRb2JlbmIz?=
 =?utf-8?B?T0YrQWJCV0pubUNkY1hlTU13NE9FVllLNWdLUm55WXYrVHRWbmh5ZjN5N1Q3?=
 =?utf-8?B?WHB3SGZoOHNFM2pRY2J1Y1d6TTdIRzlDUHJCejFRd0hyT3lXU09jMXJlS2lC?=
 =?utf-8?B?cllHbHdzYlJEcFBJQ1VMZjBoZkgxUmpsaDJjTU85Yy9wL2VLTnkvRkI1dGJ6?=
 =?utf-8?B?YTZsQS9zaXlUZjVWbGhOMFRZY2NwbEtWNTkwNDhkS3pIVzJCV2JGNWpxaFAv?=
 =?utf-8?B?UVoybzBsZmQrcjVGSXNqOHRkZ3ZmSE5uTkF6YmNVd21JbTdKZjd2N291MWVw?=
 =?utf-8?B?WG9yQzNBajNsaWtzU2VFajFrbjhjK1BJYTJtc0J5WTJQWWFFMkZ0eXE1M0lv?=
 =?utf-8?B?V0F2bHVIYzdXTUFVZi94TUtNOFM5cHMxNXlPV0JYb3ErdWo5dnRJTkVmVTht?=
 =?utf-8?B?RzBPNzYwYndta3RKZ3VvSlJrT1g4V1kvM3JrL2ZwZVNQcnltMG9hbVpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjArSC9PRUtsQSt1NENGZzdmMTJnQ0swTkhZaGpZU1RKd3c5Z0NPWnZwQUNs?=
 =?utf-8?B?ZU1jcXpwN0Q3YUlESEp2Und6eTJwNytiTGhZN2ZlWm9UY20ya0V4MHhmVkdZ?=
 =?utf-8?B?UUc2TDR5UkRIbm8zandRMUx6RjExWG91Z0MxTmxnc042am5CRGljR3lWYWQz?=
 =?utf-8?B?VHFIakRpQXZCdytCVGFrM1RjY0xEbllZM1hWMDQwT2tCQndLMHFJcVN1d1BR?=
 =?utf-8?B?c3o1R1NadnhTVVNtNUNXRTVJMkdFa1RQekxpcFNzUlM0SjR3R2JzVnNnclh2?=
 =?utf-8?B?YmNBNjh3QU5NMVhRcWtZWjVQVFdtMVlEMFRsV1NOeENnRzhZYnhIWXQ1SSt0?=
 =?utf-8?B?YVkxWnRZRWVqQ2VkdGpvZ1NsNzNWMS9tS2d3TGs3SEVFTnFGMEtBckFxMkRy?=
 =?utf-8?B?cXdVYlJsUytPTVJSaWV0aG1ZVi8xWXA0Mm5XNFB1bGdqVFp3and6ZGNUZGdN?=
 =?utf-8?B?SFVOSFVHOFJlWjJ5QnVobmhrRUQ1ZE5yYzVuT2VTRXJWYkFrOG04QXFIYUoz?=
 =?utf-8?B?SkJNK2x1WlRlYUpMTWExM1RJM0NQVEwwbFU4NmJ1MU1VdWNLMjlEQ1E5b2ll?=
 =?utf-8?B?cWRpR1BNK1ptSEExbHIweUVoMmd2RjhuMzJUaUtFSFQ3R1FRa25aWHZvVHJ1?=
 =?utf-8?B?dFZRMHFlTFQxZDF5NmpBL0NHa0p2NU9Xb3YzNmN0Y1QyK1o0S1U0bTUwS2VT?=
 =?utf-8?B?VWZzS1N6clBLZjdYcTZ0cjliampHdHZOWkczZkgrei8yS3hmSVhGVmZ2TmVO?=
 =?utf-8?B?ZW8rMUxXV2lMK3FsTm92dkh5YldBdmYvU0RxTnplUTlpc3VpR20yT2pwR2x6?=
 =?utf-8?B?MmgwSjRrOFkvUW5SNTRHcEoycy85bkw2OGswQXVpbmJJZzRmeG9TRFM2QWlF?=
 =?utf-8?B?SzMvUFo4eE5EYzk5WEdRdlZwZTV5SmJzeWpnYUNQOUtzYVVFZ2JFVHRhS2dE?=
 =?utf-8?B?bEZnWlBYcGF3cnBaSzA2TVI4SXVqRHFQcitPU085Q1JaMllBR0xBY0lXZ29x?=
 =?utf-8?B?aUxDV084Q3c0T2NnUEc1TUdoM3hDSU5rNWJLeW83UFFlVzlhZmRtaVNkdFE0?=
 =?utf-8?B?WW9QM0V1ZnlMbzRvVnZWU1p6MlIvWlp2QlZRTmQ1Y3R0MDQyNERNOWxmNDFn?=
 =?utf-8?B?MDhEaVdRMmZ0Uk1lTURCdmxDS2g1ejc3eDVvbDhadHRHNWhLMFFHdllIM2pN?=
 =?utf-8?B?VFU2KzVSTW5xeVF6VWUvOXYyYXhjQ2ZoWmxvVGV6ZTZvenkxN1Uxa1lvWmlN?=
 =?utf-8?B?dHJGM3l1QkRCSkJGSFg4aERZZFV4YkQ2YlNIQ2VtRWQ2b3FSZGcwR04yM0Fn?=
 =?utf-8?B?UHBReFROeG11LzB6WDR0ZVpyMzUzMU15ejUvVmhvSEpEclI4YklmNU5tYllD?=
 =?utf-8?B?VUsxRm0rTGRxTmlkNE1XSmpFY2RjUC80c05XTHdveEZNb1BZUU5OTkVhMHVV?=
 =?utf-8?B?dE1IbURoMzJNWFhYMGRuemNBZEZ3N2Y2VWdpZUszZncrZWRNT0J5NVg1Zlg3?=
 =?utf-8?B?bWRLVW5ObzZBRlAwM3BUYlJNWkRYcG05cUMvRG96V0lIRGNkZUx1c1pnTlRx?=
 =?utf-8?B?SGxHcEZkdUcvN1JwTVgxZXNOWk0yNmtwOGx4d3gycW1qL29vaTdXSWxEQVkr?=
 =?utf-8?B?bGIxQktTUVVlNStHOXJwdFdKUE9QNjlwd0ZMUHlnZXhHaHB2eksrVVBkOUFG?=
 =?utf-8?B?WEJqV3pnV1huTkRtRGVKSk16TjVsZW9rNVVQYUxDVmZiN2ovUTJWczc5WkJa?=
 =?utf-8?B?dmp6WTJJRTdLaEVDeWFrdFdlbHFLRm9XN215dm1KT0cycmc0MjRNZ2RMR3Rn?=
 =?utf-8?B?N1BObFBqMEdwcnVkTXhkaXVyZlZMK0xCTFh0cWJFTHRSZDFSOE1weUprZFdz?=
 =?utf-8?B?QkxxaVZvRCtOQkZNK2ErNEVsemIvNGpDWXd0UVFxb2JnSy9oQ3grczJGS01V?=
 =?utf-8?B?SkRNdytFbmlnYkNXdkNWVXhDaWVVbVc3OTVudHNyR1V4QmMxd2ExTkd6VDB0?=
 =?utf-8?B?RzhsNUNicytJNFc5a290cUxRdUIrWUlrWlVvWE1lVEQ1NVJpU3BibFBPUCtu?=
 =?utf-8?B?Vyt3K0hZUG1wcW5lT3ZYVDE4ZDQxRWp6d0FMTllESUw5cXZ4UDF2d2d0MnZM?=
 =?utf-8?Q?5MHdY+gp5cd0Xmlvl1pL4OAO2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ae44fd-2d67-491e-1354-08dce781274c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:08:27.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcZuBNnqqi831DrJYiuE8NUBcMuO2ga3cr5S2oPx5Ar0EpvtUnDLu4qBOgwSMxS1Q1vaT0Vq+FxfS+VHAhJtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062

Hi Jason,


On 10/4/2024 9:01 PM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 08:00:15PM +0530, Vasant Hegde wrote:
>>>> I thought eventually we want to remove ops->domain_alloc() interface. Hence I
>>>> introduced domain_alloc_paging(). I didn't remove amd_iommu_domain_alloc() in
>>>> this series. I was planning to do it in later.
>>>
>>> We do want to remove domain_alloc
>>>
>>>> If we are fine to keep ops->domain_alloc() then I can just drop this patch.
>>>
>>> But why not just remove it and not add amd_iommu_domain_alloc_paging ?
>>
>> Because we have __iommu_domain_alloc() which calls domain_alloc_paging /
>> domain_alloc().
> 
> Oh, I see what you are worried about. __iommu_domain_alloc() is almost
> never called now that most of Lu's patches are merged, and it is not
> needed for any x86 platform case.
> 
> Here are two more patches you can grab that will remove it from the
> remaining core cases and then you don't need to worry about it,
> everything for AMD will go through __iommu_paging_domain_alloc_flags():
> 
>   https://github.com/jgunthorpe/linux/commits/for-vasant

Sure. Will pick those patches and get the v3 soon.

-Vasant
