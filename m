Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2D182A5
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 11:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzNjNbHn+trdaV0w6xQGQ/1JaTa8krsQyy9rcmLWFtUvJfEzFYeQXzV/zy2l3Jixdz2TNaVcUAQb0r1nURxRJwzgaQ5OM7S+xMlilXoWWCHqaU9MZi8DqVpFZuwAQTensiCV0TzL8znyBNBHLVXzuhmPBIMzjMkfyFRRIRSvjOjkfaox/mpdj32W99oBwUOmXzYchpEQg/LKFc/nTE4mUngSR/O/2JUVnHIOxMhTM6DmAdaacQiLEikLjB4+injTYx3MwE6pEgwejcn/HyXP4uHyKHDhz0nVgw8yiCHg9UVr6qrLGAC6z7IpJ9WbewGNsPk449HgpZA4au5gUJsj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNqYcU7/rClGB/LkzrYG6llHQazGUSWFZJluQ72jDBY=;
 b=COgb6HczG1RfSS3fvdH9isGlwIbLTHomPqrV3HqfMGX+88GrR7MIOslUAmd8ThRF6+bBfLEwkHc1jG7osGVcOex/G3vDvsDkzM8PW3VTfNgW5VdsAZBWY0Z/0miupTqSDZI4Mw05Mm9srJZ+fwmzxB/CKYReQMBSwkuN2/KaJcsqWFUC7PVoxwbrJG1ZizkiZewdKS76rv7JVpm42BvdLwoBqJ6aay8lMd1QOK+kZmDKkx6rMCoTQ2bGoLfKiZBDXEoKHDFIJjUSDIYfCPaHI9nKAPwYC1yI6xERO8wY4VvKq34+f1MY6QlIUNiGuWkhoq78ADh41riZ4zmIez5vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNqYcU7/rClGB/LkzrYG6llHQazGUSWFZJluQ72jDBY=;
 b=N85glgqpTvi0VlTr0vAYOhOEJguM0cIfKmOZAMqGrIqMHPW33rNu4bG37LJl74LBMN+/iC0ZkTQD54ySeIcN54G8QDCZgfH3UmnzAwra30tfRgqetBBeRmnlrNvRSNwkWlRt1utBvR/oRtURMY5d4BQahBdi5mCzTCbTQQ2z7kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 11:51:44 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:51:44 +0000
Message-ID: <bca37017-24f2-72b9-fd23-e54bce3a6d68@amd.com>
Date: Mon, 31 Jul 2023 17:21:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-11-vasant.hegde@amd.com> <ZMPPrkzm7KnxzLV1@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPPrkzm7KnxzLV1@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f7e997-9f05-49b6-2df4-08db91bc82c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+YzGZLzgDqbNZj+HJmf/whylOehdadYg2haF1PLuHaT3JD59aJ3V2zMLEIHszKk9T7i7W50G6D26/DC/3rC/dffM9UH/PUbcdMGa2WAk/i+vrPFVnzgygLdhgm2qP5XWxKyPE9Av8cMw9XYxKo6wQ7XILcqyUO6tMHA0JhNcHLpxUQDnpT9WkfesVIAIlAdtKkdNgvBl3VG+qZdN1wFyxYDkblZS5wGuzB+R4O30+kbNR84htVwNHmpYv5o7NW6BMABzxWz+z5ijGA5rz6iL19oIvzDWsrSyHpNaLVrrlU4WyxfeZ2HePwT6DjL7N0XV4k42plHXGWgEhCbIpFgPfK/COxF85rHmSkfQ2mnoAzdiHQYOjo1tV0vdbqgTqZUhH4FPZGE2kyooAF4ldIj/cH2My90oEr6BmEJCezpc9j/Pk6iN5g20y+/yl1V1N34JXP0tOdBRLzWhaFNUQcC2ysvLI9Jpy7VEXdjc2s36awLCHHtiy47fL5HFrVKGl5fxVr7zoblXc3RAxO1cP8TPV4a7PSqCO9XpDiin3l4azb75FkY/IXy/lQzZH1ZDyhflHAgLSQ+J97A7QVgv+LQwJ1U2agrMOv+zWuXSjZ8i7Lnw77/UaP/i+xpKlei3JsaYOoLlPzrb2hm7nTRuTKX+bA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(5660300002)(2616005)(6506007)(53546011)(8936002)(8676002)(186003)(26005)(44832011)(83380400001)(316002)(478600001)(4326008)(6916009)(66476007)(66946007)(66556008)(6666004)(6486002)(6512007)(41300700001)(86362001)(31696002)(36756003)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXU2aWxyZDk2MkhRMS9aYWxmVk5xa3pPbXdlSitMcmFENkREOXIwTThvMzB5?=
 =?utf-8?B?N0l4eUpTZTdyNklXcmJsdHFkRC9qT0pHTHU2VTF1RnlQZFdiNENtczRicHJo?=
 =?utf-8?B?L3owRG9wbUdBdHRnMTlhaldzMjNPdkFCamMwOGVjeXJtdGZOcnZ0RkdaUkxt?=
 =?utf-8?B?U1RKWGhhaHpyNUFoVHM1TmVkSk9IZEdYMGdUTU50dnNmazVDTUNyRTRDLzcw?=
 =?utf-8?B?S3RkOGxoQzM5ei9UR3F6U1RXTTJwTXB3bThkMGxoRWxUSm5hSGtGYitQU3ZP?=
 =?utf-8?B?V3d0OUpxcGtPbWFLNTVqaHlzMkNGZjc1dVVPT09jSXFWRzhmSG5Nb2R2QmVZ?=
 =?utf-8?B?c1JYUU83ZlZjckpiQ0JLMndmL002UGVQb1l4cm9VL2M3b090MllJclQ0WUpm?=
 =?utf-8?B?dzBqS05DVW85Uy9GQTBWT2h0MUp6N0RoODIxWW5JZ01UdUhWcmtRRHYyKzlv?=
 =?utf-8?B?YTYwMVdVb2xkQ3F5TmhidVJrcWNTdzc5RFprTG1CNnBCZVlqUlM5VFNkaGpN?=
 =?utf-8?B?VkxNaDF4TC9wQW9oUHpDcHI5YzB0cDNNSG1pcHFOcEQ5SzFxMEprRG5jODB4?=
 =?utf-8?B?am0zWFhIeCtwbXJxZWVZUWdsVU80cG5mYkJlMkd1WlY5aW4xWWJFM29Qd3FJ?=
 =?utf-8?B?NlExZDlLUUJlVFZISE5kcG5YcVJtUUhMbmE0c1VpajNDVFA3UURWenNIajlS?=
 =?utf-8?B?bGZ5dXpVNjB2L1QrbTJEdFpXTzVXdVVIejBvUFdpSHczM29XSWRiTTFhNXpL?=
 =?utf-8?B?ZE1zbHVFTVV1dWtwdDM0SlVVTTVRcWsvZ0RyUUp0Znh0WDdPV20yZytyMFF6?=
 =?utf-8?B?L3lRS2VuUW9EZlpreENIYW5MamZRSTVpaktEY2l1YUxOTHBOTU9VeTIrSlB6?=
 =?utf-8?B?a0orTnlRWUlWeGJ0cUFHdHlWS29sN3MxL0hFd2I1clFocEdyK21DMG9UbkFL?=
 =?utf-8?B?QjEvQU4xdmhmbUxHNzlIZi80Qjh2d2E2WE9xR05CZk1HNWxxZnViRVVYSVZr?=
 =?utf-8?B?bGtXcDJQUWF1c2RJT0ZqRUlyQ1RxNDNqV2tHR1l0akxrREJrcFlVLzJFY3By?=
 =?utf-8?B?d052Sm5OeWRYUkpkclVZVERIVTZIRlZ0TUNuSkdBRXo1Zml2a09hbmdnc1E5?=
 =?utf-8?B?c0VXK0NhamtPY3N0MjM2Mk9GaVZpZXhzSVRVOFJFTjdUTFMvdHRCZWd0UXFI?=
 =?utf-8?B?Y3l1Q2dYeHpRK0dwVGlmNHZMY0lyOTl3S0dPYlo5c1krVkFJZ0hpQko2TE5t?=
 =?utf-8?B?MVhQelZQNEdlazR1czh3alBiZVNlemZOcmpRZWg1MGJOZnh4UGFLdlVVc2NW?=
 =?utf-8?B?Y29WSkFySzZwZTZ0Lzh5RVZhZHlxbnFTWVJFZVNGNUsyM0JsbnptOG4xT1hi?=
 =?utf-8?B?SDZNT0Q1L2pqem5SVVo2OGlWRnA1NnpVdDB6Tzl0emZjWVBHME9YdmRubHk1?=
 =?utf-8?B?MjlsYUdwNFMrMnV1RC9pU2ppc1h5dnJRN3FPcHdEVTlScC9tT3pPUXduTW5h?=
 =?utf-8?B?VjBPdmVsYk02Y3ZzdDd0aE1tVnFGLzJWeng4RVlsa1B0dkpIbFBqaUZURkoz?=
 =?utf-8?B?cW52MERZUFVhaGRlVzFkdUZsMVR0bUU3TmVjalFBaHpFYWZ0eGV5ZmtWZFkr?=
 =?utf-8?B?RlBEZVZKNGpBd0tCVXM1dDlySytwU2lvd2k0VE1PM3lKVFI3Nlg2YW5xU0RS?=
 =?utf-8?B?dXd2cGtXZWxpSWsyVzFpZzdiTTlyOHJsbnVEWEhJU1gvMXhMTEY2V1o5TFJ1?=
 =?utf-8?B?TmtMOHZobFNqMzRZQXZUVXdNaWZQTnhwdjh0eUJ2bDhCaEdjUXh1Z083b1dp?=
 =?utf-8?B?dld1S3Y4RkkvTWhtazh1MnBoUjRnZElIMjZDOFVRMHpmUHdPYlBrTFkrTTBl?=
 =?utf-8?B?VUI1NDU0NmhLMmYzQmpPclZ4K0VISCtDYU14enhaS2l4elFmMTR0dDYwL1F2?=
 =?utf-8?B?RVJZYVZranVTRjRkRFhDRlc2czBURUFCeUM3MXVjdCtXL0FOaG9STzNHS2Nh?=
 =?utf-8?B?bEV6OGdZODhORUcrWmgxbDRsMW1PVW5nWmppeEpLMk9xb09ibHZwTUl6MHlo?=
 =?utf-8?B?N3pHRldZTnV5R2lsQzBhQ3lwZXp4U2dkbHA5eGo0UkNwNWRZTmFhVW9HejU4?=
 =?utf-8?Q?tw158BCB3y+EZ730DLQM+SeT9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f7e997-9f05-49b6-2df4-08db91bc82c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:51:44.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osNUBYaSInE1qT47iLRu16/K6MeXGXqQDZa/2yTjF8IoYYDxv47qG9fcD+Yf5f0dkFYWM3RUWqqym6PNDle+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

On 7/28/2023 7:54 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:03AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> In order to support v2 page table, IOMMU driver need to check if the
>> hardware can support Guest Translation (GT) and Peripheral Page Requet
>> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
>> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
>> features. There variables area redundant since we could simply just check
>> the global EFR mask.
>>
>> Therefore, replace it with a helper function with appropriate name.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
>>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
>>  drivers/iommu/amd/init.c            | 14 +-------------
>>  drivers/iommu/amd/iommu.c           |  2 +-
>>  4 files changed, 17 insertions(+), 19 deletions(-)
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index a0b0deb6fbcb..1f707944b23f 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -392,7 +392,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
>>  	 */
>>  	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
>>  	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
>> -		dev_data->iommu_v2 = iommu->is_iommu_v2;
>> +		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
> 
> This doesn't make alot of sense to me, we should not have global
> functions and data in drivers. In this case I would expect the driver
> to consult the amd_iommu linked to the struct device it is working on
> to determine the capability.
> 
> Eg just directly test:
> 
> 	iommu_feature(iommu, FEATURE_GT) && iommu_feature(iommu, FEATURE_PPR)
> 
> And remove all the other copies of the iommu_v2

Yes. Eventually we are removing iommu_v2 variable from both iommu and device
structures.

> 
> And arguably this can (eventually) be defered to an attach that
> requires the gcr3 table.

Yes. Later part of the SVA series does this. Basically init discovers the device
capabilities, attach/detach_device() takes care of enabling/disabling features.
Finally def_domain_type() decides best page table mode for the given device.

-Vasant

> 
> Also, if the gcr3 table is supported or not should be entirely up to
> the HW, policy inputs like "iommu_default_passthrough" and
> "force_isolation" are nonsensical here..
> 
> Looking in the history this looks like a bodge to cover up the domain
> type mismatch during allocation. We need to get to a point where the
> device is known during domain allocation so the driver can provide a
> v2 page table if the device could possibly use PASID and remove all
> this hackery.
> 
> Jason

