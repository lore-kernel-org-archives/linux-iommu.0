Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AD38B
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZwDCRGMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krwTQxBnBdlau+LO0BlEPZZxthbjlQb32X6e/1q2YNhG2rR7B934NCEewMHZQn2nuFG1+froNf7xYOWa4dg8lbZKfjuVeuOie6Ue4QBClVtkns2ZzYc5RaCdHcEj2/P53sCWif9IcWkKZlT+4O6cHl58Dt5eeF0iKa2yxF/mURy7J3t0Z5Do9XKpEo/zcb0pMBvBHUyuXsoaNmmmlkGn49N8TjJ6c8kvDpPq0ztYslFa/CbsU6NgaHRKJ2lK0CtaEJ5RQws6Ng+pFWAehO4jJS1fdtUAKoIAx6vtQhErQ6nla79ZlKQZA80IGk/ttSfjHL1UI6g1AFYMUIL2QjC+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBrC8uFmS9zxRJ7Lq5ox/eB2R/sjsUD4L+o5b/THhE0=;
 b=VJRDeDmowsPf09O2bpbhHfba/FLOjqnUhrfg9Go/0R6xc0cIKkUgn5e/aOKhBZZ8HYM7aZOHD2GkyNYQnQMKI6UyYspkexYkqV8TrGY3hcpXqCGLsVtvRFenQIxmTgqLEQrifNLHiLKtyDN9Tkrjg96JCKlG2y1wpDjZn7F/uvM6dC1jf/bDr01Q0VaZB8wFoxQN8zWwN1sv9zOjYrjmZIt/0wQFGm7pKs8AjGI233iWb3/xx9yKCFgJG0QzoQvi3va4MONZWfpqlc6aUv8B+Pu6Qp8pn3YsxVlt8ttW0Gd3ingQ2d5xtznqzdUpCsN/mF0cnFqxSlECjSnnmz0U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBrC8uFmS9zxRJ7Lq5ox/eB2R/sjsUD4L+o5b/THhE0=;
 b=ZwDCRGMZrgT/9h5ZOt362J1D1Yi5B0rVMyhI9zzbVpxLA/ywAJvwTCUZk6r1wvTZWNppO9R40HkrM92oSJZA+5VSitpO1FhLccLJbLwezsP5+zFglFfc7ukUGw+ODT3cUS4ogyoC/d9MlnXZLmQOOjvIDt8fjI67/ENaj4BPPoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 04:44:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 04:44:25 +0000
Message-ID: <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
Date: Tue, 7 Nov 2023 10:14:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
 <20231106131303.GG4488@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106131303.GG4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 939ac299-dbc6-4379-c6ca-08dbdf4c37c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ip99Z+0SKIKpq3uyzIKEKx58JP6H/PLT/XFoKMqznp57dAXxrAgLw8bkwU3oH4xHLi09sk+Pq4U6Q9+dbHR+lxiP/9x8SvRbUEi/nkwUSqoYJo+iKhGQpM1KAP+c+sdqJN5zEo0hgnZi54zCmL+WS2GXweaQMRLWae1pX5RXDTmbdLvXz4EkNvnW2Ht/ZuDejyPmcqlVFMzN5G0bWyYYdY4vc2rudUwcON2CPBtP5nDE9TKnE2KHX3TQiC5istYf1DzK3S5KDg3/OcEHJ4+IwViTPQ0Sc8/HMdPjd10IqxG/hPZyJw9L6rkNVj4s1OEdA9ok/dO4ijqLX4/aSMZ9qR+HJ6I8htCGe7oIITCfhJE7fw0hVhKNgNCdTmbQcV3QtIAq/ZUXgB1cyTaxBpPnP3jNgyhYWlMwh35hTSiXFBTPzG25tprNUcfLDfVq11bPXh5wzA87mV/+AoeA8pq8oPi7YvAyx/KG+jaoteHGmV4IaZzDrHHQloPuwSuM7oLcs0sqhq61CSNFUWX0TnNy32hwqynrfmilWZA710FT0jIdshyjmTkrkqW7a8X5kjx562f88hfvYBQAWX3mmAhvvj5wsWAeJdBfZ1PaFGjBeD9KLRvlW/3Vf2IjwQ3zuBARlyrQ6TwZmHVpAvNaw8mNLg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(66899024)(6486002)(6512007)(66556008)(66476007)(53546011)(6666004)(6506007)(66946007)(36756003)(31696002)(86362001)(478600001)(26005)(38100700002)(8676002)(83380400001)(2616005)(2906002)(4326008)(316002)(5660300002)(41300700001)(6916009)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkx0WEpiZ1cxcjJVTkRUemo4akdqVlJjN2hBTmdlN1VIeE9hSmNaeHZIU3Jk?=
 =?utf-8?B?YWQvRDNYQmNyTmxKbWpabHhpMk4zTWYvd2dwZnE0RDNPZUJBcXR5bG03c21T?=
 =?utf-8?B?M0c0K3VOWVBZR2x0bnFqLzFZZmtyeE5sRkM5K0UvQUk0Z1dBRW1GTmx1Y2ky?=
 =?utf-8?B?MXpKeklpU2hPOG91TFFTZExhUHlISm1jeEJMN2J4S0VqNDdXLytXOG82c3V3?=
 =?utf-8?B?bUIydjF2MGNnajBYb3ZBK2dLNzhGVUdsRWpyNkdrRXFIYjRZU2tlUTlLVjRV?=
 =?utf-8?B?OEFMZWtsMlhDdGgyZW9hencxNVo0OFhnZ3lTTDVNWC9ud2hBMFZQeWgwQStL?=
 =?utf-8?B?b3FjTk1sT0VLQ2p1elVaNWpUZG5HdlRMcVFKbHJYVFdPQm5hVXdDMzNpNHd4?=
 =?utf-8?B?UmhqN3o5Rk8rdlVXYjF0OXJPYnNCYmpRdHJ1TUR1NjFjeDgzTkNUYkJpQU52?=
 =?utf-8?B?eTQxeDFrVnptUTlKT1hYUnJCdVRLMVcyRW02N1FWejdJQkRpMFZSTGlRRDk3?=
 =?utf-8?B?M3hjZlFiSXNCalJ2R0JpMlNoL0RyVTBPbGFxaEhrNllkRWxCbDE3UlJEdytC?=
 =?utf-8?B?TUxqOFJjWFFpaGFLL3h3Y2FEMERKeVNvR08zVXBPN1dNMTUwWWhreVJKckxJ?=
 =?utf-8?B?R2tnYWNhcWlmQllBbnFjRi9zNnVpYjF3UVhYSnl0MUdmQ0FydGRqdk1oVk9T?=
 =?utf-8?B?RzgrRkg5MSs1dWF1dW9jTHB2ZlVtakJ6ZzlQOXZkT29GTFA0bGZON2JOaWZ2?=
 =?utf-8?B?T25DWDFrUUVuQzlDQ3JYRU5UUklrcDRmNUlpUytrcU00YWZLZ1AzVC9JRUVD?=
 =?utf-8?B?bTdJa0NZMmFuUUhidnRXbnMzakUrTW9YTTdrTkpDYUZBRUlmOXBjK05pQlJG?=
 =?utf-8?B?UCtsUUt6amJVRTZRM3ZXbkNzRE9ZMWVYeVh6emxNUE8yZ2NlakdKS0p5T0NS?=
 =?utf-8?B?a1ZCdS93Z3E2ZzhCR3ZDRVhVOEVYNFhGbFNLcmxpY0FrMSt0M0FEQjd5TVVE?=
 =?utf-8?B?LzEvKy9mN3J0WHFISllUOW5BbUZ5dXZpUnMwa2ZmbXhOempOdmdNSjdkSkZH?=
 =?utf-8?B?bkFuRTJPZ2pMY010dlFnV2FOSmwvdDNsbFZkQjByVTRXdjlUb3pwaHZVaWto?=
 =?utf-8?B?cFBLNHE1empWcFlVdDZJQmltSlJrS3JzcmFJOWxobDhDT1lMZ21MS2RJc0xu?=
 =?utf-8?B?dG1VWjlaQ21NazZmdGl4eUNkUUQ0VDFjZkxQRXNHMlZkUHI3Z2QvU29NZFpP?=
 =?utf-8?B?dUJmbW9WeEsrYWRwbUF4NGdoNmZ5MCtURkJ3dmthYzJCR1Y0dW9xMCtvS3RY?=
 =?utf-8?B?NUlZdVNFLzdvdHoyZHFjb0sycENXUUxvM3NhNVA5M3lrc2ZSY2M4dGVOVFkz?=
 =?utf-8?B?NnhzSEF2ZDEzOHBWaGVoTCsxZUM4dDNEQXozcFpjWmxBci96SFJJaUIyMVJQ?=
 =?utf-8?B?RzY3Sy83UUF6a1RwV0NrVm9KeGIxMFFrWi9PNTVDcEpJcldHUFUxbFJLa2lv?=
 =?utf-8?B?M09hVHBCT1NpTGk5dmxuZFBUVlVrcURwbnlTV0N0cHhtS1N2Ykg5djcwVmlU?=
 =?utf-8?B?QmpZb2hDK2cyc0p2M2RoNlJvRHdHSDVYR0FaU2x4MWdjL3d1c1A0aUszcko4?=
 =?utf-8?B?Q0lSbk9JTm1LVDRlUThkcFhuOHF3K0E5TE9kL2ZVeEpVRUEwUi9FcjYvOFlU?=
 =?utf-8?B?QVZBSEhzSm9KLzMrYWphMGN0S3VDbTlOZW0vanZKS2RrM1U3UnZPU051NXJW?=
 =?utf-8?B?TDhsRE8xVzFZbFJmSmFTQmVYaUJBQUVHdXJwK09WemlUVFJuK0RRT2F2VWth?=
 =?utf-8?B?QXk1NVo0ZDJXRDFhcXQ1ZFlCSlZ2Nm9JMHR6dndGR2xwdElISVZ2WU9LcVR6?=
 =?utf-8?B?UWI3SXVaaGRPWmgveXdKSU1mU3c0SnRsK0VZQlpJRFNPU0pIRmR3RDZ6M3p0?=
 =?utf-8?B?VjJ0MXNLVkI0U1RMWmlSK1pMYVg3QWM2TWFjU29LQThnWko0UlY1T0RSdWZH?=
 =?utf-8?B?NXhkNVFtaW85eTVTb25XTW9aLzVPNFVYYW1zYWp3MS82UTYwK0lLSjhibzZZ?=
 =?utf-8?B?R1RYU3F0WHlQa2VwZGlMTkYxVlhPK2RPT3c1TENDc2xtTkFLWjBDQ1hCa2Nq?=
 =?utf-8?Q?Tb+0XYxbVVzNk4DvzoDG7Qr9J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ac299-dbc6-4379-c6ca-08dbdf4c37c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 04:44:25.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4qTck1id3AFARPoOOEoXLpsOAHscpOBvodCogq7y9Wnn5lErt8Q8TCZ1hQvYXx+s8RzYFXjzqNiOQLdVVMhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215



On 11/6/2023 6:43 PM, Jason Gunthorpe wrote:
> On Mon, Nov 06, 2023 at 04:42:17PM +0530, Vasant Hegde wrote:
>>
>>
>> On 11/5/2023 11:25 PM, Jason Gunthorpe wrote:
>>> On Fri, Oct 06, 2023 at 10:16:21AM +0000, Vasant Hegde wrote:
>>>
>>>> @@ -1557,7 +1583,9 @@ static void domain_flush_pages(struct protection_domain *domain,
>>>>  void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
>>>>  				  u64 address, size_t size)
>>>>  {
>>>> -	return domain_flush_pages(pdom, address, size);
>>>> +	ioasid_t pasid = pdom_get_default_pasid(pdom);
>>>> +
>>>> +	return domain_flush_pages(pdom, pasid, address, size);
>>>>  }
>>>
>>> There should be no such thing as a pasid for a domain. There should
>>
>> We do have default PASID (zero) when we boot in v2 page table mode.
> 
> That is the PASID for a RID, not the PASID or a domain.
> 
>>> not be an api called pdom_get_default_pasid(), it is nonsensical.
>>
>> But we have single command to deal with all IOMMU TLB flush.
> 
> This is probably a mistake..
> 
>> I have a choice of doing all checks in low level function (what this patch does)
>>  -OR- add checks in all API path (like flush_iotlb_all, iotlb_sync, etc). If
>> that's what preferred I can do that.
> 
> Well, you should not have concepts like the 'pasid of a domain' and
> you should not encode the v1/v2 type into the pasid. I didn't look
> closely how to sort that out to say exactly.
> 
> I can say that in SMMUv3 structuring it so that the attach op at the
> top of the call chain knows what to do, and called a bunch of specific
> helpers was reasonable. We know at the op level if we are going to do
> a V1 or V2 invalidation because the OP itself already knows if it is
> working on a V1/V2 iommu domain due to how it has to load the domain
> into the DTE/GCR3.


AMD IOMMU invalidation is based on domain and we have single command which takes
PASID as well. Current code does have separate functions but that made code
duplicate. So I try to consolidate all low level functions.

> 
> So if you have:
> 
>    invalidate_iotlb_range/all_v1(domain)
>    invalidate_iotlb_range/all_v2(device, pasid)
>    invalidate_iotlb_full_v2(device)  // Clean every pasid
>    invalidate_atc_range/all(domain)
>      invalidate_atc_device_range_all(device, pasid)
>    invalidate_atc_full(device) // Clean every pasid


I am going to have separate functions for V1 and V2 domain flush.

> 
> As working functions then the ops should be writable to know exactly
> which of those call based on the op.
> 
> For instance, if you have a v1 page table then you should have a v1
> specific flush op that does:
> 
>    invalidate_iotlb_range/all_v1(domain)
>    if (domain->ats in use)
>      invalidate_atc_range/all(domain)

That's exactly domain_flush_page() does (flush IOMMU TLB and then flush device
IOTLB). Just that I need to fix upper layer function and pass few extra params
to low level functions.

-Vasant
