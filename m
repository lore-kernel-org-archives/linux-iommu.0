Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6B17F7
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 07:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqW74sYn35FLIrokhB9BAcr8c7Y3teo+OuGhNQMY+IvQsoo1kocyZcetYieWOsjOKAU504UMJ2L2k7miWDDYl4TGw1kRBjLwDm1xnYyc/DB5+39cuA62qWaZnbYxsCl53spicM5aWHlD8Rrem8FfgZQgVvoaClvxW9KlFu5lndgU/DpEbkepRtjjtEdWb16JOzN5W3Q67cwFX0G2O7pMDUMa5uo+DhZNWV5rjrg88Ef/DxDaZdNGIJe/Z4NxZc1tSbHhtmRDEYO+f4hzJquYPClnDAiCOB4xHHJ/w9pFhHLEHnVZs1OmRczWakLcs5DvGPYuJJQ/9PRi+rP1h0DB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql5U7CMR+Jy7Rn+LzljqO+rqaMHD8e2ID/mKM3lm9B4=;
 b=eiDwXQlqBzj/kwFWFvuWewiQyuAoy+KFLnC2XYKnbK9TBmID2XOYTMmeltv10Fx9dih4wntO1GkHdCCHUEtKY4WkHCHogrIBbvXJAqMGXLm5oe9q+4ZVDhh7cKowfTt0tUO7Wodx2VawiPG2WBae/kJxueKOdcuAuJQXW+r3ekQi3SVvi0uwYKCOv+3ilznwtqs8lsrDlaCS4hEXkwEqlSH0QZljtAI6kT12mnu/agKqxWHQtDHseHeGgq2UqZMfjndcis3SPuCYnT2uav1AEnyGSVxIw0BQsxkcNzQl/O4e5FXSIcaj5RfekFZn7YoAKz12tgrJoD2WsF3T4kTtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql5U7CMR+Jy7Rn+LzljqO+rqaMHD8e2ID/mKM3lm9B4=;
 b=YasljG1JM1fdKbwe2Pb4BRnAuYHVBHKHNqXqvkEm4/pQOPx848X5w9yMyAYIFb/pz3DAXw7wBuf7Ja3HWxR9f6yj+gGPXGDVgS/baGwkMdNrq4D9RcuUYsDpv/rhJnF/3MoLJaRD+kz8OiV2Uasw8TL4SUNnSHLlApaBZw4gXeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:22:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 07:22:12 +0000
Message-ID: <30462ffb-272a-78e9-bfe4-062e04cb7b1a@amd.com>
Date: Wed, 16 Aug 2023 12:52:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 12/14] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-13-vasant.hegde@amd.com> <ZNvFQU+OxRIt79C0@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNvFQU+OxRIt79C0@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: b5acbdec-f79a-4b32-d36e-08db9e298254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nWgDHg1dGCQFgIAIieejjMZh00X5xk3qNO4pV515eUzdbuonwII8ksn1tGj0TGiCr4N9mscJYn/flrLhH75Is2UJ8J8AzQKdi6LU5UCsFO0QUFF+s0GuxO6lL7xag07hqORZod1sF88qQtC2OPZkJEbGSoJ64nXSzTPsHqdXbl/vN6m8CeHn/Skx8m93EUDvGcjimhh3FBZiVyNwf9fjgIzaRbmzIs8HfMrgxb8DRY88MlhBp0laHEw5/qbz9c0ykAjJypD+VTJZkPs1mFu/yybd05hUx+mvL/ifZ6cGPlsiMnUnANVgY+uEawFRAl9zHhUiV8EUmwH2C3l4/hOo/FGnMhqHPnq+p1sMzKKMmX7zSENGVtB1xL9uEiXkXWEAJBvAZeJXybIbapSKCCN9hBNU0lIpRYZn5hl+Ev5ZYN3cFTVhMael7Xl1im0HvBuIv3dhn1itDu8J4pgV4Q8XxKMy/n+KhNiiUPyMRNF2btBZkwd8PL4zKkUK8wTevzLETBNGhxcRNde7/X4C8JY2WeeVhlrwWuOtnVuOu+7ckNxIl2AFbtKAs1yQV7bPGlfUai7uG4FtH31nl5AgvHSZb9LFXzsXj5MvZ1QSDroJT050ir5ncN2lI2PKX1PK9SaSmgMJ7I40Lvzir/hiwmqAbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(26005)(6916009)(5660300002)(2616005)(41300700001)(316002)(44832011)(53546011)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXpIVGVzSmhtaWlLdFRnYmNndHJUbnY4NU1vWUkvWnhOVVkwaFpwbTFJNkxa?=
 =?utf-8?B?em9QeHpuNURsY0Rmd2k0aU1na2Ird0ZGZ0hFakJoVWJLZ3FrMEpOQU5hNzU3?=
 =?utf-8?B?QnZPeUt4K2xWMWxnTkpqQ2YwNmlNK2FoS05WcUhMbTRMUkVzaFZ4UE5OOVNH?=
 =?utf-8?B?VGVkWGt1WTMyUFVtSzB3K05GTHNxcllnMElndDVkN1VwYUtTejRPRkRVc2lU?=
 =?utf-8?B?b0RwTUh2enZITm1Ed3BzZDRXRUVWRGFxZ1NzSkxvV1RMaWRuWjUzb25xbUp5?=
 =?utf-8?B?KzMvcnJmS21PMjdSbXlTWnkzYlBQQzJWaXRna2VmVXpTNzA4aktzWWR4amhw?=
 =?utf-8?B?ZFdFem1QWVZ6T2QxQjlBOEorVVpocEpoNzJIZzZrRkc4em9NTVJnem9oZTl0?=
 =?utf-8?B?NjRSN2VOMlIra2U0c0JOM2FSbCtHK3FjampJcGgxZVBsUXpkWEFYME9ZNy9i?=
 =?utf-8?B?SkJLVXlKaUV1dFdrYlFkSDVMNTFyMVFrM3JJS2xMeE5aRnR1WmNvM21CRUFO?=
 =?utf-8?B?UVRpdkpBN2tLb0hMUE9GdHl5c2VpWGt3ejRiR0VVN2xEbDFoS3Z4OEl1aXB2?=
 =?utf-8?B?dUQ3Z3ExMlpBSGpTUlFQMGtuVG8vUVNqbmhpQnYwQ2Myb096clRkU0hRY0Vs?=
 =?utf-8?B?enB3QkZnV3J2OFlCT0xCSGIxK2JuS2RuOVdlU2FaWHFXSHNDQ00vZGxYb2JK?=
 =?utf-8?B?c0I0RC9HTk1oMndCYm9ZY3ZCM09qeHYvWlUxbTc4cGVzV2prMEIvcUJQWW44?=
 =?utf-8?B?b2tmbk9BV0xhUllEemdmRWhPdHhFNlRpZmhOc2hBVXdERVh0aXh4N1pFMGc4?=
 =?utf-8?B?RGl5RkVUTW9ZenNhQ2VoMzdoNlNDcitTZ1drd29CTVcyQ0xhc0RBWjdoTzBy?=
 =?utf-8?B?dlo1WEhwTjRPYk5CaFljNzBhV3FEZkZWcU10RnBldVBxdVhvcnp0VnA2aGky?=
 =?utf-8?B?eDlLL1pKV3RBdExGbzRtemZGa0hmK3NWTWRmY3l4SVVaaSthZmFSWE80K2Jo?=
 =?utf-8?B?a3h1S0F2RXVvNFF1N3d1TWJDM3BWZFBtd2thMFc3RUdoZGo5bnlDR09rTEpO?=
 =?utf-8?B?emlQSU5sajkzVm1IWG1nR2laRFc1WEx1QWNEczg4dGdNSVJ4YWRDNlZYdVJR?=
 =?utf-8?B?OUdiOFlmR253VXJxWCtGRGZzYklIejhPWUFaTFFZREhORlJXN203dERBczRQ?=
 =?utf-8?B?SXlzZEZRTGZrdWJZeHZVNFlYb1FaczgvQVlDU2FzV2dvQTZZU3JSK2pOalBD?=
 =?utf-8?B?SHM3VjhCRStyQzByN1cxS0QvdVdwYy9YSzlWNVFCU1F0RHRKWmgvS2RobFdB?=
 =?utf-8?B?OGlmTUZRMlNlRFM4Z2RNaTV4dU5MRDh1RkE3QzB1MzNaWkUvUjNZRXNGNiti?=
 =?utf-8?B?enpUcGFCMCtZbFNaREUzRGtsQ1FYcFVlQlJqaHhxcGNaK25uZXJjN0locGx4?=
 =?utf-8?B?eGROeG5KSWtIeEwvZDRrU0xuZ1o0blhKWGpGdithY2Y2Rlg5TVl1enQ3OUFI?=
 =?utf-8?B?Y2lUTTVocXdVQktpcXpmeWJLNnlDdmN6TjQ0Qk1EU1E1V2hraVlqYWlxdXhR?=
 =?utf-8?B?Nm9XSjJsSWVnUHVMNENDS1ZUOWhZMlhoWjg5UjNCNUVPeHp5em1JWDZ5QkNX?=
 =?utf-8?B?U3JJcGs2eDZ4K2dyWVBWWHhORUhOOUV3Z3hrRUlxcU1ySzlaR2NVcmVvVEh0?=
 =?utf-8?B?bzdiK0lFajJ3QVp6bkkrdnNYY2Y5RWdQak9RaE5ZVG9Wd2I4MDlKVkFpKzJZ?=
 =?utf-8?B?cm5IeThNcE1FSmJZU2VacEFaTFdpbjJmUktTZzlWUnk1VFFmTHdPYzdwTGZp?=
 =?utf-8?B?R1UrVXl6SUI4VFNkK1hiMGJEZThxMXhuWXB1SGtaUW9uN05wcU5EUEo3c01C?=
 =?utf-8?B?eGRZOHdNaTRmaVpQQjVKMjkyNERKZzN4MDBBQ2R3MkZja2VDVnRLNlZrNzFY?=
 =?utf-8?B?OVhGWXhxWlN2WFp5MXJ3RjJaSWJkMi82S1EzVWlySkl0RnBtMlgxWlNKb0ly?=
 =?utf-8?B?dkgxd1h2YTJqS0tGSnBYYUJESVE5OHpwK3R3VHlIc2prSHhOTGxleEN1dnQr?=
 =?utf-8?B?L2dxdU1JampsaFo1eXhFTVdMdVFYVC84ckI2SHk1OStNcUJEdFJLOFVjeWlG?=
 =?utf-8?Q?ckP0sbpb/9eiPP5/RgLwGHaSe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5acbdec-f79a-4b32-d36e-08db9e298254
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 07:22:12.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFgmWTOck3aJyYzYYchwgDURxgU3KcdwJHaDV/ey8vPfhyPloPcOyURS14zsCO2spqyEoRvlfU0Tr9Dc8famZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Jason,

On 8/16/2023 12:04 AM, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 10:22:00AM +0000, Vasant Hegde wrote:
>> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
>> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
>> independently (except PRI requires ATS support). Hence, replace
>> the iommu_v2 variable with a flags variable, which keep track of the device
>> capabilities.
>>
>> From commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability
>> with all VFs"), device PRI/PASID is shared between PF and any associated
>> VFs. Hence use pci_pri_supported() and pci_pasid_features() instead of
>> pci_find_ext_capability() to check device PRI/PASID support.
> 
> One change per patch..

Since both changes are touching same part code and it was not big change, I just
made it as single patch.

-Vasant
