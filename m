Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C51C3F
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 05:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TW8cy2Ca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpNmG4sqQSOeboCFENM287GZ90NwySr2ScFQS5PPG4F73agGuw80/ffwzAdhaCgQJ35yZcogwN4gVM1EDBat6K+qRzUsHW+JYyeLj5RBBgGSuwoyBfv3e6MthVbQV7etXcbhqjGN0EWiiOsv3Cs4Ov+6aEwH1Xmm0GmUpSLPXjflU5iE2e5zR034Vxp9pwGC1fJvaQAELeVULKu1M69AxUQYkxA3gOfD81E0k6CEhPsWrHw7POa8VDo8wKPRW8Lx2jCVdeeaXIitCrtwDLJr0pietQ8k3i/O+hNXo6oahocQUygSvduER/rSCfyaEfBHNGMEAdqVb9G6SHD6dETP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEyShyTA3cjj2Zr9GCofQFkp8687MYT0pXNR86sLigQ=;
 b=F6jwTkukvWiBkSnBIrjR6D30SuiiAwSwAB2xyNBNGpn6e7lhEoqTMCi0En7EN3dDipS0sKn/iUt6CUMf/6W1iHF2l+jgasdA8/cLeaivxg3SU4zjRxVbmk2TTk2VD6kG3ZhIv8x77Gn/v9txk6yHwyCIz0dWX7z8vpQHVyAYJnW8Enxvl7McCgQBzWQNTAOTgd5vlyO6zV87KrYMm7Wk5GIz5nGkNvmxPSw8jTriR4SgQHYabp6HCXeM7HA/wiD+bLYRrBSDoju0Z9sY07FpySuYs8RmHEDjGJwDu9yvaZ3SWJ9wQ4qWOR2sq5oOytiFHjmt2LEBM0FIbqmpUH0ZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEyShyTA3cjj2Zr9GCofQFkp8687MYT0pXNR86sLigQ=;
 b=TW8cy2CaDA1isG1biBiR9Tn1J3XWvUAoPQjVP4gWcRbjDT4p8paCcLvkpIx8GvONBBJI0XvPCr9Ya9lVLQ7jvRl3VsLlxEqFuwACRAajVJ48l+2tHMmlugBnh0YeLGE3Um29Yx1VAEk4R7Dtag/fmcBGyKlktJoU7JKjzpW8T2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 05:28:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 05:28:36 +0000
Message-ID: <c952fa4d-6a9d-5d47-8572-4a107e8bd198@amd.com>
Date: Fri, 10 Nov 2023 10:58:27 +0530
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
 <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
 <20231107130917.GL4488@nvidia.com>
 <875d1c5e-05ae-7248-3823-38a5e1e2fecb@amd.com>
 <20231109141056.GG4488@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231109141056.GG4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: a500e924-ded6-4451-76f2-08dbe1ade30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AIZWggDyrCEH1s7iPRLSM0/wZCOjFqnFc7Cspe0E7ZsP7BzGi4bCCp52z3rbRBW5lFW9t9scBiz6DtZc8XcKaDZ84tDXwtENqmx7S13zdeIDFaPFKt2EOW+UuvoZUZnUlBybJUgBkrYXwlOrAWt+xei5b2m1I7Q7PSosuPlpVLqB56Xgp1B6lcxURgMo2axrex9m/QcTNCU9r+m9yvaRsx8wiUWnt7ohcmg0jeEQ0GhfoMVqNEMzY7urHAWdzW7OKjlqrnBi8yaBqZxbp1ZpgvYZkjrNm6qowHNUaSSFyc99GFRcdZY7WXbAKf48sPNmJaPhgf7NUr5jUZFqsP8qK21uWhZpoRu9tEAX8r/uWSsoP36cjXTzgE4JVJFKhCwHFJIKszwOYDMFn9Txofb0MsfN0V5wwwhpDsd5OZNJ9sS2UIRW3bXh97+8rIE7LjFpxih4D0VHwj92FjBmlRwyc/hKoFcrPPUPX40XfQp1XxTkGZlgN7wY/ZdIBjLP4N8AN8RjS8Psxdwn/3evploZBd3f7kKenpmWWzkvrM/i2ElRt7PRpZtvyLrj97x/SGr6nvIiYJfDK9qGNfuH/gEIjJlvvZ1ssStIdhRhtmbr/RFwzlL+gj62F6/huR2+czHO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(966005)(478600001)(6486002)(66946007)(316002)(86362001)(31696002)(38100700002)(83380400001)(6506007)(6512007)(66556008)(6916009)(36756003)(6666004)(26005)(44832011)(4326008)(53546011)(5660300002)(41300700001)(2906002)(8676002)(66476007)(2616005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkpJa0JWdVpEVjRwVjNtZ3grSWFUZXpXd2xwZzFOQzhMOWQ5NmlQVXRXMXQ3?=
 =?utf-8?B?SVBTZlkvUk5pZko5UDRlMzhNMDFQblJRUk9SR1A1ODJUVk1VY2VzbUxHeUlF?=
 =?utf-8?B?b0twWEdwMFhyYnlha2pDNW10Si9hWSs0ZmxKWEs4NlU5UGZTOFFHd3VDTllR?=
 =?utf-8?B?Mk5HVCt0YVVDRXZybW5NcEhuaEVKcmkzcFNoQWxIaWxvUFY3RitWd2dvQ1B3?=
 =?utf-8?B?UGZ2ckVZRVh4bjhrVGV0cmJwYzJad3I3d1BWQlpmRzdvblJBblRTaS82VzQ3?=
 =?utf-8?B?aGV3L0Qrak8yMmROUzg4dVZZVU84WTQzS3VkbHNIZzFkUjBIVnY1THpNVlVl?=
 =?utf-8?B?elpmRnF3d2JlbytaK0lGQ2V3NDM0aENaRVB4U2N4RlJKUUFCcWNYSDc5dThI?=
 =?utf-8?B?L0d3Qllsd0RRRVJQcHZlb0NIU0lxU0dkYzNBWjRmaE5FeGtydFBXaGlkUmhZ?=
 =?utf-8?B?QUZHdFJaTGRVNTBOY1lkLzM1TnQ5SFpBTnlva1pWNGt1QlhPVzYvSEF5RnRl?=
 =?utf-8?B?ZkpCbmFsY1ZyMmlWSUpMaFh5SHVjUHgrd3Vla3pyM1kvaXpHcVI3UzZERjRu?=
 =?utf-8?B?bFFNSGNsS1owcG5mV1M0Z2VqaWFwYS9WVitCMnIyQVp3RGg3TlZjT0duR1VT?=
 =?utf-8?B?cVlkTksxNVZKODRPK0k5WEZiRlJiUzBQaHdYVzlETDV6MFRMUGw0S210MnFq?=
 =?utf-8?B?ck5HajNVaFZQWmVKTG0xYVRMdnF1N3FuRUJ2ak9tc2F4MFE3L3FxU2lKeU1U?=
 =?utf-8?B?SllpTkdGcGlNYnZ1bEN6UFVtMVEzNzhvSWQ2cDFIR0ZUTldYUThTWEdpRzFY?=
 =?utf-8?B?ZkhkQlRmQWZET0xOWFFCdHphN0dMdkRqdGVqWG9OZTFyeUI2ZGxmVXZBb1BR?=
 =?utf-8?B?YUs2TFA1eXZibllJMWsyRTVhUllkT3owZTZWWGZDOC80b2pRdUI0alRSVzAv?=
 =?utf-8?B?TlVrTTdvWmc5YXJQODRQcXBxTVJMMWFQaUpmV3JWdlZ0eCsvVVB1UDUvUjhO?=
 =?utf-8?B?QmJBcjFNdTk0bjU5N25sRllEWTN5WmRDWkFhOEVRbjVwb2Q5TVhPZW5rZC9r?=
 =?utf-8?B?aWJkNElqcndLTXlhWUI3RFBYWmxlYVBnbTFJUHg4QzFmbGR1M1l0RWhaa0da?=
 =?utf-8?B?Y2lmREdWSTMrb09BdFVzcHlvUVJmZE1aY2JMc2dJblpFRDFJbmZxVVN4ZFZw?=
 =?utf-8?B?enlwVGovUE5XWTNlb3h3YWFJU3hRZTgwNzJGTmdWSEY1SzFTbDZLWDF5dmFs?=
 =?utf-8?B?eElrWm9ObFZPaW9hZWNEUzhNQTYxcjlITEJsRElPMWdUS0JZSitjQ3V1OXpY?=
 =?utf-8?B?SnFaRlZTNnBiS0Y0Qk0wM0UzaW5FSDR2RStBNUQ3cGJSY3JFbHVndVVqODND?=
 =?utf-8?B?Y0N1TUdFRm1Dam1DMEd4a3UrMXBKb1pLcXhrS0Z0ZStyRTVpSWdtNVZpVUc2?=
 =?utf-8?B?TFVvaDREVzhrRDAvMUxQU2JqR2NIdVE4cDk1bisyRWdjOWlBbWR3Q1FiMVNy?=
 =?utf-8?B?WkVZM3Q1MXJLdCs1c0FTS3g2bWJQZlR6UnBFTWtJb1YxbnZkNUw1TS9Wa2pC?=
 =?utf-8?B?ZndNc3QzM3UyUGEvV3ZuSG9XMi94NkRQTC90eVhRRGwvMFliN2x6dG9YMElD?=
 =?utf-8?B?ZEFOTmNsdXlKRlk5cGVDRXNpUmEzMG1Sdk5YYTJMcGpzdUVlTGl4SG9vWFpq?=
 =?utf-8?B?bks2aTVEZlI4ckpGbXlIV0kxZVRqZ1hkS0g3azVlczdXZzlaOWpqbU1GWXBp?=
 =?utf-8?B?akNVam1RNnZMTllqc0JVcmxlc3B0U29iNkFrVG1mZ2JoS095YkQ0ZGp3K0JV?=
 =?utf-8?B?K2RXU3F0OVZOSDY2cGdzNENWMEdGNFZldHU3QjNzVUl6M3Y0dExsblRTcDdE?=
 =?utf-8?B?N0t1OGpuN0gxalRDd3M2ZDhiODVjT1FWRWR6L3ZTSjFjRlA1M3RyMjlHeDda?=
 =?utf-8?B?TmVYUEZpVU9sVThhQ2p5QWZrd1d2dUQ1bHFIUVNaN1BWaG1ESkgyT05UQi9R?=
 =?utf-8?B?TkU1akwvZ3dYRnE0WkxHZUpyTjQxR1AyR09DQWNxS1NVU3lRcXZ3bGVrSDFr?=
 =?utf-8?B?TG5LeVJGektaYnZKYklSVDB5aWhvcU84MUhhdFNwU3FwblNhMnlVT2d1SkRq?=
 =?utf-8?Q?2AxC2cSXqjdMHcqrXSwq/YO7Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a500e924-ded6-4451-76f2-08dbe1ade30e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 05:28:36.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAxZaYj2DCI8KEZLdSGUl+ELESLZ1cLUDlW2Uk1UrJN8SXEGTTue0VqtsT4m56x4L03Fba0Bezsn6BEAJXlQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180



On 11/9/2023 7:40 PM, Jason Gunthorpe wrote:
> On Thu, Nov 09, 2023 at 07:22:09PM +0530, Vasant Hegde wrote:
>>
>>
>> On 11/7/2023 6:39 PM, Jason Gunthorpe wrote:
>>> On Tue, Nov 07, 2023 at 10:14:17AM +0530, Vasant Hegde wrote:
>>>
>>>>> I can say that in SMMUv3 structuring it so that the attach op at the
>>>>> top of the call chain knows what to do, and called a bunch of specific
>>>>> helpers was reasonable. We know at the op level if we are going to do
>>>>> a V1 or V2 invalidation because the OP itself already knows if it is
>>>>> working on a V1/V2 iommu domain due to how it has to load the domain
>>>>> into the DTE/GCR3.
>>>>
>>>> AMD IOMMU invalidation is based on domain and we have single command which takes
>>>> PASID as well. Current code does have separate functions but that made code
>>>> duplicate. So I try to consolidate all low level functions.
>>>
>>> It is really not different from SMMU, invalidation commands for S1 or
>>> S2 tables are constructed differently.
>>
>> I don't understand ARM completely. So I don't think I understood the entire code.
> 
> It is really similar, of the three AMD and ARM are almost twins. VT-D
> is completely different.
> 
>> Looking into https://github.com/jgunthorpe/linux/commits/smmuv3_newapi tree,
>>
>> As I understand you have S1/S2. I guess that's something similar to V1 and V2
>> page table. 
> 
> Yes
> 
>> arm_smmu_tlb_inv_range_domain() function basically checks for S1 or S2.
> 
> Yes, I haven't touched that yet.
> 
> The function is always called from an OP callback:
> 
>  iommu_flush_ops -> arm_smmu_tlb_inv_walk -> arm_smmu_tlb_inv_range_domain
>  iotlb_sync -> arm_smmu_tlb_inv_range_domain
> 
> And in both cases we can arrange things so that there are S1 and S2
> specific ops that already know exactly what they should be doing.
> 
>> domain_flush_pages_v1()
>> {
>> 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i)
>> 		iommu_queue_command()
>> }
>>
>> domain_flush_pages_v2()
>> {
>> 	list_for_each_entry(dev_data, &domain->dev_list, list)
>> 		iommu_queue_command()
>> }
>>
>> /* Invalidation based on domain */
>> amd_iommu_domain_flush_pages(pdom, addr, size)
>> {
>> 	pasid = INVALID;
>> 	gn = false;
>>
>> 	if (pdom_is_v2_pgtbl_mode(pdom)) {
>> 		pasid = 0; gn = true
>> 		domain_flush_pages_v2()
>> 	} else
>> 		domain_flush_pages_v1()
>>
>> 	list_for_each_entry(dev_data, &domain->dev_list, list)
>> 		__device_flush_iotlb(dev_data, addr, size, pasid, gn)
>> 		
>> }
> 
> Looks logical
> 
>> /* Invalidation based on device */
>>
>> amd_iommu_dev_flush_pasid_pages()
>> {
>> 	iommu_flush_tlb_range(iommu, domid, pasid, addr, size)
>>
>> 	device_flush_iotlb_pasid(dev_data, pasid, addr, size)
>> }
> 
> When does this happen? There were only two places in ARM land where we
> needed a non-domain invalidation:

This is for handling mmu notifier callbacks for SVA.

-Vasant


>  - Flushing a PCI device ATC in an attach op callback due to a
>    translation change or ATS enable/disable
>  - Clearing an entire cache tag before returning it to the tag
>    allocator
> 
> So I would not expect to see a range here, or to have the ATC in the
> same function..
> 
> Jason
