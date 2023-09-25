Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAA1D522
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 15:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhhgew5NnyK7tisRabEAUKXrwGaKYTFXAf4M3nBaPzyyceCDdFwV47s1HFCM/CVf2MKYVVOme8QcOzjrxeD0lcmp/wuVTV+rg1B3Qy/xO87wkJ7y9hjJygcfkGoh/KyU9leG/dWIuEJbatWWRAK8dpaIVeCHR48Ile/v4aUu7EVHL5Mk3pOmDVU1/MSeYNL0xQtP45klzl5xRs6stTdZcmORsRGwtxonxhEcdBboUYGZ2P9RiyLmCY9Z/A6tKB4F3XSLiJugRJIKkCMret/1/xnNwm9nAXbgvSkvaIR3ZVcQua0oOXTOe9jQOgoVELciRKYAAvraeBmvTTxDcvT8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcqfoMHWVHxCLPKq+KsheCVL4XRGCOdOy7hksr67zQ0=;
 b=VdJTeNPZKMmJyReZbtCldcWuY/TKupTTg6D38hLxFuCfNzqdlGs5qxn1nrUlvgfbgP7qXxcyviCErqrbEkym1wfn2eLLki6sTHcBXBRW2UKOvThHJR8/9dCvwSFbRZvAAy0Bf5mEv2xO8FFbcAYXwXdzWoyFWL1ovWTjZCYI+BYO6vaUAgVW6TBlgKYyXfkfwmwLgWvrr43aYHT9pJBqPF0Xw/ueUbsKJOmknqWcxqqv1yMraeOjbS+zneR3os48HgykyPrvLajW7ViwtJd9xA0eP6jvp4COj5qLUmKQyVLPAj2uol/XMiulTxat/+h1i8DoSMhVCZPs2/zFhNYqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcqfoMHWVHxCLPKq+KsheCVL4XRGCOdOy7hksr67zQ0=;
 b=MgAopcree9+uomsWHUKSSTnn+xx6IlIPccORjVPCRQ7aMgBBvWSpasXbyCF3gygD3hOSAtHe9zLeb7j8aqq1w8+nnvZXdbNcV2PPwOO9i6RPcbVkT17SQj4Piu95ztgNOJB2SYsYJ0Sd9qHBqQuN24rmZ1XJOmYOs9nvBkdRmdw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4971.namprd12.prod.outlook.com (2603:10b6:610:6b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 15:11:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 15:11:52 +0000
Message-ID: <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
Date: Mon, 25 Sep 2023 20:41:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
 <20230922120002.GJ13733@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230922120002.GJ13733@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa43a8c-d623-4b80-a264-08dbbdd9bf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ANnP4zWHqOwA1RhvUcQRtRMtoOY1yXtYTkXCuI33kgLPqEIGoIPUEkgyes9gSGmzz+zyFa1WK3atwCsfQ618CWNv7VIhwpLLuF/DpaDygdy4Bw1iHcYzY5kFxHoTnQI8jPUNsvPDTyunuITOYvixwWyMY9bH/0WsQ8Ri02wm/I0OVWtb1yV6WpAyVKMj1ZFdhg1Rdy2eCUNw93OqrpfJoNQtuK2U7DgvAx+I+kdlNy58BHphnPe3FMafGca9D2ueOM/gyu1jb03ezbl76d68Pmddc2PYDc3KKZHbo5nqtm7JOKTLfRXk+hxIabvYjuIB7t6wTPoK32K+KWrYWO6XZuxA9Ww0Z6mFf84IhoH962UV6qH/jeVn60caOKyGUkLuKmXZrjtonjiPKzbHRCG+XH0EIoOvf8ZnJF4kKR7rsQj5RNBQT9J9LEhc1kaeRLWEEsg598zYBO38qBVGHM7p9ocdUv1AaOuiS5zGR2TknI2EfRHti0FWHYJuZcLLoM0/CtNZv5Gs/gBwqODqHRgzUnXoIrnQU+8nQt1KfQqmRj4ySqk6koywC5VmNKrvraBINc8RL3r6KmXRndRLPc0xIHiz8IdsITOTiBpl+I39DXVQg+71LvAo8NtxIKv1OhpO+9R462rBJSO3toa8oo+zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(6916009)(44832011)(4744005)(54906003)(66946007)(66476007)(8936002)(4326008)(31686004)(6486002)(6666004)(6506007)(53546011)(6512007)(36756003)(2616005)(83380400001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRvUURyYlU5VjZycy91YlRzMjFkTzF2YUJZdHdBVjkxcE5NRS8vb3p5dHBF?=
 =?utf-8?B?aWl3R2Zyc2NvUjhhTm5DL0NDenVxYTZySlE0b3UyOU15L2wvaE1VbkxpRjBZ?=
 =?utf-8?B?MDcvbGVWNWZkVkQvQVdXNTJyaUhzZmlHMW1VLzk4L0VYNzY0N1lyMmwxdXlV?=
 =?utf-8?B?c2JPcnNuK0ViT3RKUHpYWnJFMVpzZno0Ynpac0p1RmFzM1lIV1p3blZrbjVN?=
 =?utf-8?B?dTZJOEhIbUdWMXRXR3FYRGYyY2VkMTdHRzJtMElIb3h5Y0E2b3loSkt5T0JY?=
 =?utf-8?B?OGgwK1c3cHJsZzJZMXVFSHVYdktaaHBvZFJEcUE3djV4V2ZXVXJKNGpaaVp5?=
 =?utf-8?B?TFFkYVBla3VMSWQ4VzhDdHZYTnpLQVJYaE5nWmFKYUJJU1kxa0dWcWQxWG9u?=
 =?utf-8?B?YmJ6a3IwMVJ4NkJjTGFhdlFHM1B5ZHJjOVFRT0cvOE5QQmhjK1c2OEN6ait6?=
 =?utf-8?B?eFhIUjBkUEx5SUtGd2g1Qk1FdGlnYWYweDlWakhUM09FTnhhNzZCMldCQzk4?=
 =?utf-8?B?ZW1qeVpCajZyU2drbnlGdjFhZy9nVFZMbytXSUd4bk00L1h6azdNOXRiKzBF?=
 =?utf-8?B?S3BoS0ZTV21DYXFLbFpaRjRxVzVKMDFaeUljV2RLTFJnYjk2QzRpazJwMlEr?=
 =?utf-8?B?NEhjMTlFdUpUTW5zN2V5aHIwZ2M2NHZTM3k0SmJ5eGVGc1FIU0ljYzRvMXUw?=
 =?utf-8?B?a0tYeUU4dWlENXJPTXVEbUxzdmxhNGIxQWlWN2poaHdFVFBsOGViSjVidGd0?=
 =?utf-8?B?MGFXb2hJT08zV1o4S1phQ0ZyZmJwcC83N0RyY0hMTUNlN3ppbk15S2NLaDhC?=
 =?utf-8?B?Uk92MTlPQnRQcFRuZ3NuUk0rVWFKalZGWXMxeUF6SVp2QUYvOGd5L1NEc2Rm?=
 =?utf-8?B?TFU5SWZEVHJqTCtNaTFXQVJkV3BCamF3L2Y3Z3d5OXp3ZmJxT2FIQ2M0Rjd2?=
 =?utf-8?B?Lzk0T3RXbVZQSFYzYXkzRXA4QUxFd25BbEZXVTI3ZmNEWjBZeER3cjJwWVZ3?=
 =?utf-8?B?cER2RGlIOXJxU0xYQTFPV1E2Z2NseGFQS09ZY0hJMnY0c0x3SGFQaGdvdkdS?=
 =?utf-8?B?WFpuaTdyUzJabjRIaUs0Zzh2UVdlL1BtaEpLakFoVmNndFZLcFdQamY2KzFU?=
 =?utf-8?B?QVJYTy9ZZkpTMk9qSGc4akVGMFpWODh2SytiZ0ZWSWY2SGdIOGVaRHcvaWVH?=
 =?utf-8?B?ekZCNkhkNEdIMWVBanhtVXUyQlQ2QnFRVWpDZUdxME91K2RjaXZkUEh4MVc5?=
 =?utf-8?B?SHNuUCtIU2JFVnFXZVFmWGFEaytmYlc3aVo1cjIvdkVEaDZ5V2lXdmZlSUx6?=
 =?utf-8?B?Wk54by9ZRDJHeDkvd0xKUEo1NHRiRzNZenZzWi9jSllkbmJibUJHamN5UUs2?=
 =?utf-8?B?TCtPQjBhc2ozelBKSWpXR0ExMFhGQjB6bTljM3ZxR3VtVHBNR1hMSm11enhD?=
 =?utf-8?B?MkRwY28ycUVBbHo1OExQWXc4UmNIL2p6ZjJxTWIydGdjZDI1c2NmeEJ1Yk1k?=
 =?utf-8?B?VGcvS0h4YisxaVZJZzd0VldaUXo0UGxVMllNekFNNE5xREsvM0NhRm9NRkQ3?=
 =?utf-8?B?MXljZUlUNjlsc3dtUUwrb2gwL2VrKzBTdmlLWit1UkN1bTZ1d2ZKZk4xVXBr?=
 =?utf-8?B?Z1VQTGorUndWUysrYXVWQ0haUDFkUHRvWFNMUEprb1hLVCtsaGVkKzllNDR6?=
 =?utf-8?B?ZFVRTEdUMWtvVStIdy9IWkI3M1FoK3F3VjhFMlVUZ0V2N1Irc2FuNS9jWkEx?=
 =?utf-8?B?QllMZGJKZU8vSFgyMFFwK2Z5VG5nSFQyRndJTmJ1SkhaQVBlMFM1ek13OGpT?=
 =?utf-8?B?VWt5VnZKZUR2ZlJiTEgyaHBxOWpmZDNxWnpKbG85YVpjOTNQNG9XVVN1eDZP?=
 =?utf-8?B?dnBCYTREczAxRC9JR05tMkNOQXM3N0lpODM4SHE0UFRIYzFlNFh2STZwbENw?=
 =?utf-8?B?V29yNFgvdnB0TWRLbkpNR0pxamErbjNTaTZOWkRzR3Y5THhKQzhYS296WjFy?=
 =?utf-8?B?MmVjZ1hlcUZ3L1BySDJCQnJRSEpZeTluSVJQMGNBN3FrbGkyVkJyNUM5dFFl?=
 =?utf-8?B?RG9lcElEOXV4K1BkTy9DWENldklwRDJHaVE2dXd2YTFlRjZGb09sbVlBVTNu?=
 =?utf-8?Q?s7R6WE9biv1whqEdAf9cFfusN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa43a8c-d623-4b80-a264-08dbbdd9bf1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:11:51.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH6AsZDG3z8gmdoa1JsgXOuqMoPwmZpGpYOT1YbiQhPEHo0NhmaSoWTUyRWktjWFu7ttjSRTNM1/wXtlLUB/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4971

Jason,

On 9/22/2023 5:30 PM, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 02:22:11PM +0530, Vasant Hegde wrote:
>>> 2) PCI device supports ATS and PASID
>>>    In this case, ATS is required for PRI, so we should enable it even if
>>>    the default domain has been configured to PASSTHROUGH mode.
>>
>> IMO we should enable ATS along with enable_feature(PRI).
> 
> Definately not. ATS is valuable and importnat without PRI.

I get that. But I am not sure whether I understood the usecase when domain is in
passthrough mode. Do you have any usecase to enable ATS when device is in pass
through mode?

-Vasant
