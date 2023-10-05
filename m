Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613E12B74
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lONTZZOO"
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2h5NNz8Zbvj8X+kLBk/9QpRW6SZvWVw3PPb5/JNkZYhZ4iyWM/t+hpHBTOdculh9Q0D4XEGVqUJGW8NESq9c5EMcxvDUZvcM+UD+bmBYaDV0yNOe/SbpRhGdmDKJHvihmJYoCQ/GMJ3NyMik9KXa5MQD6ksErKaBz7VyDqhE4WZ/Jax4nVso6vZGLjIeBnFZ3QuPMsxYRrVa9Bc+Unx8yaMSzyvYqv3WzAnlh2UE4iGIm6DtSJQUr66qcuPdurnG1Hr7XRV+Xf7fKMDEvcsSgOsVZravVoHDfhKHXoC6S09Ys4was98ucSjUV/ttOCxrF8/wzHfkUvIEtx2bnoMCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+m/foYoCaVBQ1HmXaH/Yrf1sVRnvma29906YQoGH7Q=;
 b=LWk5GlMMK5EqXQAuOiZZzdGeGCVxJAtidbFPLM/wL32cLdQr+309uogkz3FpKJgiiZ8paBPLJJWrT/EXv4Jw6pPgiSYoSm03NMWlcdpqqLMrY2X5LK0Sll+8aolr9loiw5fNBwnHRc3Ttb6AZaJUJhmCIplCdx8AZG4p1EW0KWY6P6U479nU+zfZkWKFo1sdjLJS16df1CK8WCxL6mylz4g9DGOEXo+hMEQf4zm+51XAH8yYsZKbIcv5rBBiZRFGYTmo+ShVI/B3YConVfSaNZfQWY6Z4CE8eRdibNW0KGL0Ub/yXPiuoyRsgpTQWlzN4M90mxcEIhePFGYcus6/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+m/foYoCaVBQ1HmXaH/Yrf1sVRnvma29906YQoGH7Q=;
 b=lONTZZOOBUC/I90Nu44Z6S76SsDZYYrjMY/ya2ttCesrOY5Qs+98r7aCzrQzYP9C2pLp8E064vmstg9j/aA2deIw98o8S85rvWnvslBaPGyC1OKAnkzYA8plqo2sY4dMf7Mz2Zpo3snSiHpafT/yzoqftv07Idi6IFIrl3CkM3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Thu, 5 Oct 2023 11:29:40 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 11:29:40 +0000
Message-ID: <2ed081f7-36ff-4a56-5a8d-086386d7fcfb@amd.com>
Date: Thu, 5 Oct 2023 16:59:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
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
 <BL1PR12MB514488501F04049C08CB71DAF7C1A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BL1PR12MB514488501F04049C08CB71DAF7C1A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd95934-24fd-4978-ab60-08dbc5965cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yMsxHbVS86VBlhCZ1mcHmaoGIv0RR4r6DFonDADsPLXyFnFnu9InwGp73T+/ZBWEqmSm/1Gv3SCNEJyeKZYq+HthteUqTPRog97T8ICE5TCSHa1cqXVZDf+2dizxY8mN6qrTbFniomM0PCHUYAAdwa5n1oki6q+RRR5tDWTFoNMj32zPBS3NqBO8FTAElJvgGmixLtxZ/BTV8ucbR1gDtGx1hCnzP3FrSpcH28oyQDaLK9Ligo1In3rhwFxzVM5EHt9awSE2hKX2jXwBRO2/f3d12ZAqkklJm+Bg61/K07cPmPHrKCVY9FEYJsgBvLwxiRZMVZRRX2wGsI1jRwp4PU5uQqFcbK8MgAXPju6yaVldNwpCQrlKDGri8UwKVkjKuTWrW5u3IUNgglrb/LIPm7o54puzsKdguqwVXU6VubDBqGrfXBtJhsOvQV9ZRAchVhZSOHbPXMAOUKjjBYJrZxoMBcOrTGKItvCNDar+v3PrmhjPjRRaMObONuO8FOS5+ImtxzaNhLY89gW7N1LBDNhmWRzacYdgyBBAQkpyEv2AsVdFFTI1q4AxCnUkdLRJDoH3Aol96FA3/cSLRVGh2eZ7ptgeRR0dTsjeys11BD82v71SZjB/NbBYxniHSWYSQ8UpZ0pOnrBQAZDc1PmoCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(53546011)(478600001)(6486002)(6506007)(83380400001)(316002)(6512007)(2616005)(26005)(8936002)(41300700001)(66946007)(54906003)(5660300002)(66476007)(2906002)(8676002)(4326008)(66556008)(110136005)(44832011)(36756003)(31696002)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFhCUFZveW1uNU9jUXNJOHZDMW5PamhHVFE4OUU5NXkxTUJlT251b0ZaVUp5?=
 =?utf-8?B?b3FDMUZ1Q3FncU1TSHVsR0Y3U2x5SGpXdFdteVJFYWo4dlZHTVlHOXRHSWFS?=
 =?utf-8?B?UEtmMDdMb2plMXhSVC84WWFNaWRyNkwrN3NIREp6UFBWbEdZK1I5TzkzVTk5?=
 =?utf-8?B?MU43b3ZzS3ZySlJ2clowREZLYzA3RmswcXNSNlFLc1NZaWNkbENQSWt5eUpv?=
 =?utf-8?B?VnQzSXRoTXd4Y3RkNitRNVZxSHk5cFdvNW9rTVBOdEk1cytPMDhraVFnZWdH?=
 =?utf-8?B?NDN3c3IvRFZpSzg2SGVvS3QvMnQrMGd3Q2lNY3NnT3YySkpaQ0UrRG9qWjEx?=
 =?utf-8?B?SUpkWHhqYWFVWkVLcmk3YVFubllFT0lUWUdOUjkvaWg1WFZyTEFNYWEvYm9M?=
 =?utf-8?B?SGdhSTI5NEFldUkzM01tT1FKT0U2VnhZeWhJN2ZlRVo3RVN0Z1ByczdpUjQ3?=
 =?utf-8?B?VEdFUzRqd3FHZXAwYUxFWS9vTWo1ejV4bnNsVzR0VGExQVVyOExOMjZtcTNx?=
 =?utf-8?B?S1lNSnp2dU03bEs5S3lwYktJbmgvVi9LRWV5UFhRenZZTDRqU2J3RHRYSXNw?=
 =?utf-8?B?SUcycWFkRlRLNk9ZWVJzT3djUlFLLzFhRzBJeVcybjNHelpydFR5MUNYbEJF?=
 =?utf-8?B?LzdIMUh1NnlpTlNIM1J5V3p2M2dvRXprWTR6TnZ5M1NuaUN6SDhQb1VwVHZm?=
 =?utf-8?B?QU1NekN0dThXTXNpT0UycDhuK0h3NzZKdFh0SDdzOStQSHpoQjBUVVFVd3BM?=
 =?utf-8?B?SkxCWEVuK0FKT1hjcWpkS3QyUXBjRFlOcTlQQnI2RmE0MmY3MndxOXRhUkJi?=
 =?utf-8?B?WjdBcGZKZVRkRER1V0pOS3UycHB2aHc0WnNFYkZkWWpLalpMRU50cDdHY0Iy?=
 =?utf-8?B?N2Urcnl4Q3F5Mlo4cmJ5RnNRMHQ3U1pnWXYwNFZMRGM1NUhHTFIrdVlWOWdi?=
 =?utf-8?B?amYvamtKVGdUaWgrZVd2WEVMZHRIYmVYcFhPYkMyVmVyQU5EUXpTWHg2Ti9Y?=
 =?utf-8?B?SUVOTUJ1Z28zZXpTV0RtZWtFMzNOa2haTlBYTGZmcnRiNnhoZCs4dW1rTHN6?=
 =?utf-8?B?SmxYMFBVL20zVk9JVmxmaHlxazBtbzRsME9aS3BpUUkxUUd5VzJMTWNZUkVZ?=
 =?utf-8?B?RS9XaUwxYmphOW1FS3lFMER6SmxiWXpqRHdYZmtvNHA5clRiZFh5UG9zTlBu?=
 =?utf-8?B?emtYQ2Q3U2JlbmpxZWlCRUs0aUxJclhneGtFR0lrbG8wMDFzckpqempMOHcw?=
 =?utf-8?B?dWxQdHQ4a0o2S0JXRnY4ejFFNVR3a2YwV2loSDJDR3h0THRVekxvVk03eFhl?=
 =?utf-8?B?eEsyajl4OFVLOFJQSTZJL1ZlL2pyeWNRTnQ1NXk2cXFNd3ovNkFFSWUzeGFu?=
 =?utf-8?B?TnoyNkZuRnRXNE1ud2h2cVI2SXlzTGtFZUZHSUVRTVc3UXZGWnpiVDZ0Umsv?=
 =?utf-8?B?dUNaMGc2T3ZZQWR3Q3V6aUJLdVhZSm0zeUhCUkU1eHI5aEVHTU5oNFFnYVdZ?=
 =?utf-8?B?clNIcWM2Zmh3eDF3YjdDMTZwODhVQTVNN2E5M3pmWW5qZHU3cEh4NnI4amJ0?=
 =?utf-8?B?R05iRUFlcnAveVk0L01RNFBqTVk1Wk1QOEtZZFJIZ0RrQUZGSEtkL3ZEMlFJ?=
 =?utf-8?B?Wk0vT3pQQUFsRkV0TGNpWU04anoxVkdkKzJERUFZTzRXYm5xYVZycXQrK1B1?=
 =?utf-8?B?SUtFTHRaU1RoZnVGa3dlZGJReis3V3FsMGhxRGxvSC9pUHQ1L0lyWURwQWZv?=
 =?utf-8?B?VFpYT3hOc09YWDFGTU5keVgwQnljanhMSFJGZnJ4YmlzQVVFY3Y4cWI5WGtG?=
 =?utf-8?B?S29xcmgvZ3Y4WnJhd245ZWNuRDhwa09NZXZoSnFKYmhLd3FFL08xOW1HTjA4?=
 =?utf-8?B?RzZIT1kreE9ienV2T1dndWJIU0RZMGNuaTJCU3hKZmlreTVJQ1BPUG5jSWQ1?=
 =?utf-8?B?cks1Z3NoYlRlekw1a1U4OEZ0cWxpSWxPcXRJMDdtdmpOSXNWMUdzajBnMVNR?=
 =?utf-8?B?RnpuYllnRnh2NFlkOXFwTjVBNDVjUDMvK2ZjeFNWWFhxNHZKS0pRMVFOZUFa?=
 =?utf-8?B?elFWRGF6UmlvZGdjTWV3QzlZMFNEenJFcllUT3BGSi9NK2ZIQ3dZL29sVUR0?=
 =?utf-8?Q?bKC9EB/gFlygipq8VhnqQBG3a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd95934-24fd-4978-ab60-08dbc5965cfc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:29:40.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1nKIuDOCYiiIbp7z2ENs67KjjD3U10NAB5FWHLYz7AKDg4QftOtl3Y3Uih/iGEB0xdCwEx9ayHqvj6E0SFdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

Hi Alex,


On 9/28/2023 8:22 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: joro@8bytes.org <joro@8bytes.org>
>> Sent: Monday, September 25, 2023 5:05 AM
>> To: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Baolu Lu <baolu.lu@linux.intel.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Hegde, Vasant <Vasant.Hegde@amd.com>;
>> iommu@lists.linux.dev; Suthikulpanit, Suravee
>> <Suravee.Suthikulpanit@amd.com>; Huang2, Wei <Wei.Huang2@amd.com>;
>> jsnitsel@redhat.com; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>
>> On Fri, Sep 22, 2023 at 09:18:12AM -0300, Jason Gunthorpe wrote:
>>> IMHO iommu drivers should not override this.
>>>
>>> I think it was a mistake that iommu drivers could override to identity
>>> domains. If we need quirks then the core code should have the quirk
>>> list, similar to how PCI works.
>>
>> Sounds reasonable, but if we transition over to an iommu core facility for
>> quirks, we must do it in a way that does not cause temporary regressions for
>> existing hardware.
>>
>> That being said, Alexander, can you please test this series for regressions on
>> the older hardware to make sure nothing regresses there?
>>
> 
> We've tested this and can confirm no regressions.

Thanks! I will add your 'Tested-by'. Hope you are fine with that.

-Vasant

