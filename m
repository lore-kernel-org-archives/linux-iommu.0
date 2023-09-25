Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9F7489
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 15:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR7MxuJSEETnxybSscV3VK+Ok9UBqTJEf81BO7OKlPnkPGNitnx+dEXXrcdl3VL62oKoLZmdE0YOZUn284VQ98Yuhxqjj6pgSn7a7GNVojOiONwEZI01GVpWd1U3vImyNfCADk9fm5I6RLtz1Wrebt0mz1vQhUAyrYwO7+mYH1gFvcuh+n7v/SLh6RCOPIPeHpaLmG9xJOjmiJsJCJPsM92vvyB12Bfnhq7SF0yWXegKkY+wUJhv3ErF7XgphZOavLP+HmClnzdpx5wVq4IyeHletbOCgEy23FYVevhacbyzkyJULF0AWsItBlQrAacvjzZ0D2ElJQLUbhfcLWMHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siLRGHXpA9vRoW9BiEdvhuLU0RdIDX5mQzl6PDVCETE=;
 b=kk6XeEWVCBB/7agpimLcrj/t+bPt7/vlIJMfdrh38ygNdtj2TtIRj9UEjG2Ea9JhNoqThaqDwpAmt8pJUMQ8x2ehzH+6WoNB29Lqs0GOqeMWnoDKrfmHQz5/hKfqWIyng7hvrkjQ1hDY4SkKNNsrHoAKnAx5lfVk27VenNY1I5xENnBaBjgn8Q6lHbPH4U9ofEQNjrhigXVXkeRQEsuDcK1mAOPyxdj9LMwgLHdoOGR2300VDQ/I7YKZQOX+XBTL/YGQIOlMv2QcJgmXc8pTd1Weml9ven4GSdCKdT11cIru7bNn52kE8LxlaJBq52/HUiikpFNOs90UQeq+LRfwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siLRGHXpA9vRoW9BiEdvhuLU0RdIDX5mQzl6PDVCETE=;
 b=VEmS1mKWfSogva9d/S3VonHGX9W9dJksxN1KhyNQSVvlXGCAgSoOVHWGPUYz9SbjqMHOnRtHD3GZBVOBWU8VJrk0bRHGHFu2/ycBDQr4PBMq1fNMuE9MvnPPueUr47ordnW7w2eSjvQyHlQZe3kAUzYgbm37EZ5OuuaI16VOg1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 15:41:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 15:41:14 +0000
Message-ID: <67a19022-5583-ae48-aecc-aff64b9d0c2b@amd.com>
Date: Mon, 25 Sep 2023 21:10:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: "joro@8bytes.org" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
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
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com> <ZRFNIsHmKpNmmOc7@8bytes.org>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZRFNIsHmKpNmmOc7@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: a50417ab-67c7-4a64-708d-08dbbdddd9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TrzQ0EsJFSY+CXnBYkHGAuhHZszO9mfFrFQjDk30+qTZ6e4DWXt2hviXLOzTxbfMf2fLtOU1nvFlnE6yFJN+TQwvuzRrkkEhpmfvIX6ZjFv75NcbRqOny6m+ffKQ5ds/eW1SLwyN5jqmi3PMUAleuVoCkXm9vm4JJ9uWtrAk/RTBe4HEu04pwEtzUYGRNz5kK7gJeB0qz7WpUFhJa3cSy+vSp4rv4fAhFcfZMMeslKYGWj7c4Y5RpEkqDBMyDLcUizlwtUOEgs3O3BvvV5Xco15cgwJzyc3V+p4t9yFMtAvEzNChPrsup9WQoKI5SdW2enAZkDSK4+m5T1D2ofcLTgGBaYcru5EG4HSHvv3kk/EwFZsEfGtxtN4hNybQXEjh1SeEOZEmWFmklFZyKYyy+lohj0p5kuq70ngJp1nK72vtF64MeFf5Fo9i1W4e9Y9rnutj6YAcf6AK6ndnc/0iFm1YtYeh+Qu0zlUF4rOOo01h7Ngb1mWfvTU5dSfF3DD09Iwbd+q0XO8YmxNSQz+z+8AL6EFh6fhKbIK6NlHBuxXRR7OtHup4n6ofs+t8lPnD6N2vvzOvi5nUAbjjxdaGSfIvJGr4JpWCuEzrQrv18arAmFA5U+FYjZS9zHSMQa9WwrtS2VhiaOc7zcN6+9I1/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(31686004)(6512007)(66476007)(316002)(66946007)(2906002)(110136005)(66556008)(54906003)(41300700001)(44832011)(8936002)(4326008)(8676002)(478600001)(6666004)(5660300002)(38100700002)(53546011)(6506007)(36756003)(2616005)(26005)(6486002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmNvNzlqU3VVTzJ4MHRzbkNjeTNmM2hpQWVRV0JzWVplaVRUNmFVaG5yNlo1?=
 =?utf-8?B?ckV3dFpkQzJSNTluV0hEcEdaTGdtTUpSL1F6WE5rNG1xZGoyYklwZjAyaEoz?=
 =?utf-8?B?QWpsRUN2U3huQmRXTFVuYlByaElUMHViSWJOL3R0Rlo1VHd5SlBFeGM0M0pV?=
 =?utf-8?B?WmI4cGZ5S1NLTG9aWE1FZ2dSdThZbXhmUDNwL2lrdC9mbHhCcVJDNHVIKzBl?=
 =?utf-8?B?d0JwNGhTa0xZeXVCRWxneXp4SWRvSnFqS2RoeXN1T3V2ejRRU2F2ZnlpRTR1?=
 =?utf-8?B?dmh2clFFamJBTGhaeGZ0UWFjc3RHb0RReGFyRjlnajREQmFQTm9MWkc1cWsr?=
 =?utf-8?B?cENCYXdYRTM3b0IwL1ArSmExRFBPd04vZExQNldpUkFZbnRNTGxCKzBSTEhV?=
 =?utf-8?B?R1N2bnA1OW1PcFJYQUxpTUV4aEkzVVJaT3NYZEd6N2RNUFErRjVXcVNnYUR5?=
 =?utf-8?B?L3h0aUwyakdBS3JiK2tHSEJwdCthc2d0Z2JYNWcvdVpCUGZlb3NEQmRtbFJy?=
 =?utf-8?B?N1EyamVyZE54Q2c5TFVsQ25IWGJsNXdFanBueFlTUTZvSkV5Qko4ZnBsRmRs?=
 =?utf-8?B?Vmp5K1R4bkY5dmlSQUljRFk2ZTR2NFk0RTVKWFhjZHpaaFc4SitwaXJ2Zk5v?=
 =?utf-8?B?T3lFQ1BrT2JkaGJ2YXpCRmlNeHhyUkpTZHpBcU45QVBJOExMTityemY5aVBO?=
 =?utf-8?B?N2VaMzZNcWRXZ0tkeEs4Vk5Zcy9EZ2ltaTkxbDRKYXgveWgrNFYwREVjWkVQ?=
 =?utf-8?B?S1hERGNQRTFZVkdXMEdvcHl3WWtMMmw5RWdUbHlqR1dxK2NaUUpmTC9nWWdG?=
 =?utf-8?B?SittUjNOL0t1MWtubWhpa1RFZm03MmZzcVZFb3dVWDRaeVh5QlJJTXFFQ003?=
 =?utf-8?B?QXhSc0R2aXBvY0w1WWJjTWV1d1o0WDd6cUZ0bE5RYjdzWDRobHkvcGk5a0dO?=
 =?utf-8?B?S1NTR2RaYXVIVlA2Uk8zTzNoVGRCSEZZRTU2eG1UUy8xRThNbkdWRUFUK0FJ?=
 =?utf-8?B?U3hKSngvSEFRK1p4WktzVEo3RGZFZFo3NDgySjlVcXg2bStGOTZmOGNiSkQx?=
 =?utf-8?B?WlI2bVNjb01XMDFMQTFReGpKU0pBMXFiYkRQdXdMdGRFT3JyMUNSMEZueDhi?=
 =?utf-8?B?TUYrUjhGYjEyQWZ0OGkySXNYZk1DRm5WUzVHUnZ6dmUrYnM0eW9UcDF2TjNj?=
 =?utf-8?B?QmwzWDBqc0V6Y2ZqKzNlUXVVYWRUZnFWUmhQQVBRQ2VSaUF0L2N3VzZUWS9s?=
 =?utf-8?B?ZzVOMStWSUVXMEgvZUhSMFIzUVRDL1dUUE9ybHgwZnF5ZGFUdmI4WVcyV04v?=
 =?utf-8?B?YVp4NTN2UkVtNUV1SzBIMkV6eGgzUGIzc2FGMHNaNVJpQW5WNlM4RGk3SWpK?=
 =?utf-8?B?QUkxRlV2eGhuR1dPTnd3WkFLNHZ2blRPbWxoRjIzaHBUNU4rbmNaLzlMZVdv?=
 =?utf-8?B?ZU4vSzlHYVNDQVMrb1pRMDZQSUpla1p3RWg2VGJXT0x2Syt0TFhIaGFOVFcy?=
 =?utf-8?B?MTJzTmZFeVFGRFdoTUcxc3Y1N3U2Q3FWM3BrbHptMmd6L0NFUHR6Uk1LdFNr?=
 =?utf-8?B?anFDNGI4aWV3VjcydnJaNkdaenoxemVRSUZCNElaODVOU0NiZjZVbFEwVFFw?=
 =?utf-8?B?a0VBU3cvQ01qdnFjNDlqR0tYYVdIdzdZOXZHYjZ2ZU5aQnpsVkxsMkdGdFpC?=
 =?utf-8?B?YjV2RUFWT0tSb25mS0RLdTNoc2oyZnI0VlJsUkFhTmFZVVdsV3dXVUtweVNB?=
 =?utf-8?B?d21XS1RXclJlRHhjUVdic1h1NEcwMFkwUlI4a3VHMUlqT0dyNURxL1BDRjBK?=
 =?utf-8?B?QmdHZlhaNWo3ZjhOQ3R6N2FpZTNRVFlYRHVXRnNNTWl6WWFxUkZ4RzNjRzNP?=
 =?utf-8?B?VmNLOWJOZmZTYkVkYWdxRy9zcTBEVEJOTnYvOXBKU3FpbFhPN1ZWanBiYVVI?=
 =?utf-8?B?S21aK3pZa3IwRCtYeUVRVXdkMzltL3NZY2FTbkRsaHRyaXhYUUFmNG8xTXhZ?=
 =?utf-8?B?YUFmcWdjSFNTL0RJaFloMElPR0VuUHJMdityWWlUTUxxRUw0dnBtMXBRUDd3?=
 =?utf-8?B?KzVXdzJQeHdlNGVUenZyUk02WWFrbGNISzVGdFdSSWUxb25Hci8rYlZzdUFB?=
 =?utf-8?Q?n9OTC1IZNS0KlKmaq5+mUiQVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50417ab-67c7-4a64-708d-08dbbdddd9de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:41:14.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JidiDNK7qwBEOapSdEj0LESln0mDYbqR6g43gIjNNtGexqQIHBnklH2yPeB87WyjGtJGcoq4eF6ilg2sKVwsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

Joerg,

On 9/25/2023 2:34 PM, joro@8bytes.org wrote:
> On Fri, Sep 22, 2023 at 09:18:12AM -0300, Jason Gunthorpe wrote:
>> IMHO iommu drivers should not override this.
>>
>> I think it was a mistake that iommu drivers could override to identity
>> domains. If we need quirks then the core code should have the quirk
>> list, similar to how PCI works.
> 
> Sounds reasonable, but if we transition over to an iommu core facility
> for quirks, we must do it in a way that does not cause temporary
> regressions for existing hardware.
> 
> That being said, Alexander, can you please test this series for
> regressions on the older hardware to make sure nothing regresses there?

This series just removes iommu_v2 module related code as we don't have any
in-kernel user of this module.

It doesn't modify how we allocate default domain for devices (GPUs with
PASID/PRI will be still in 1 x 1 mapping irrespective of boot iommu mode).
Hence IMO this series should not cause any regression.

I understand Alex's concern. We will work with Alex and make sure there is no
regression whenever we modify default domain allocation (1 x 1 mapping).

-Vasant
