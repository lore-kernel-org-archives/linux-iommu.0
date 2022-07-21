Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D53291C
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 10:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtOmb8CSiis9WLMqcStcEoZCoSZ12dFGg3kHgfMUVpmlFk55xbWgje8QzX/ZjQrFi2+WCYsk6ghuhKHihGbtkDKQjD2SP3WOaMVrya3KxtQ9K9U85muZfgYUzxCGIR2ncQOZ8J9B5vV5Zem3xFcY19NiSFVMuYwiFRuOk8acsFHxa1zxx74CTJMpczPbnK3HtoyxhKXIVrXNAtSWFBfTV6Y+daiyJiIBvct3GX0Fie1cqDkjylcdGnBmwPPcSfZY83N7Qy7tVyXKSwdHOfspvYarr7OAUUL3iHPvJcqYsGvINUJervj/Kng7ZFV7cmlNDcys4dVlWuy5ZdW1nfM5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg5PHsR7Nj2jj8iNn0TabZs0zkRXpX27ovN8ikl2xv0=;
 b=jJGFqFCsILvf932DH7Yv9k/seozp8o8cNu54GE2yY8PK8K2cPn5EX6oBMFXxtUZtS97c/Rr/THKxEZdLCWvFtZUf3jILqeXtdPvLcmLB4XCM4pVaXqDt8BDz3Pu+qjLssrSobddA2j0AXVcNmo9dCVPpbmY+RicKlurwklONI0/hpThPl7UoRhkAjENMxcklvSGC4LmqQC55fuCXaLUcVg+7cF+0zbgIx5dPh9bG4d27WntFKP0UnSo2T0n/DJiMspFGY8pO2yKNO8k+mOmXlfmnaa40s4hbCj4sRiqs3w/Ysap9BjvZrQA8/SGtiRp/hTWu1at4HM7NbzwWYY3kvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg5PHsR7Nj2jj8iNn0TabZs0zkRXpX27ovN8ikl2xv0=;
 b=Rff5Vjg8S2kLfk6SguqXUrr43w/vkGJIhT543StGOf17VW6CSvxTa8g5qw+PPeMZsmL//mpj5NR7CPkQeiGMy1fHi0j/MNQpmwpADtp2Rwo+AjG1h0tIHkaRyWpxmuqaZaKkbNTLaZ72OxtP9yC+z34ecJjFKteMWQ2O4cTHvhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 10:52:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::edfb:ba9:c2e3:4347]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::edfb:ba9:c2e3:4347%3]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 10:52:57 +0000
Message-ID: <e19166d6-d6f7-87da-bd93-1ec6119e0e1c@amd.com>
Date: Thu, 21 Jul 2022 16:22:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/6] iommu/amd: Initial support for AMD IOMMU v2 page
 table
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com
References: <20220713053034.12061-1-vasant.hegde@amd.com>
 <20220713053034.12061-4-vasant.hegde@amd.com>
 <3d30d93b-ec12-46b3-576b-c3ac8ebb799f@arm.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <3d30d93b-ec12-46b3-576b-c3ac8ebb799f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bac5a4e-6f3e-4cd9-c770-08da6b072b89
X-MS-TrafficTypeDiagnostic: PH7PR12MB6610:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BNaUg47Fl0BsOTe5Bz2XmLS7143s7LFl2BkqlaI4iW6OIDV3woivVH2JDEOiDS9XlaeGsKhQ4mG+pXzMk28Y2TjaipRi0cbrUr7ffEK0S/qjWkxjMkZhsz8LcLstAjI61UiEISHSABIsmYzEVIYqgnAPC9oo1dVZkmZ9StvUYVO6dbrCCA9cq0ppEhn6WQcSE1tOcFSlOz41xZP49zUYFEUaUBA9u7lwxh++D4yx7hH4pa7YwS5EMbUJfpaUFVmXpG/jxVnPMLHiixwqbAv5IurnX5oPkAnsGx+DKKbKonXXjmpoP4yufxWZBLMqhBw7dd4ru5a0NtZ3y7uqD1ByNvDbOmThOtiDwCxzU7uvP9MQ424/kh/aAMN3ArFOI1MeUse8ZKcMJuw0z6in+ADfiO0VbTcjkvlVVOswDPFM+4x/SZWHh5auaRUKurpRdC09Q5SVr4WJzqYUUsWYAPTcWVVtzVTqcM+v0sHYf8BDmanemMn1dkdA4fVxPQgcPNoele+G1Xw+qVqgg4G0dcIlLB/FSLvnIzaH8cEqD0Y+o+Z/xaRTKf1lIAItpNW61cDu0YDZq26V1tQqVrc/i5jksGNqLlL1rt/VzuRaAg9sbj5iWw4yBiruJ4mu/1z+invotR6qDH0De83+VZT5RBqkY4JyPU7xFLbBugapXNB5bWgvlJIYbmjn36JSgl8AlBx/OYk0P8Itm2d97uB1jEj5gnOvuWobor04q5CsQxv/8WugWjshPiHb80iCl2zvNmgnLA4kWV/vc7SwAjZdd6Q9PzJm5AYwylW+8XOkntPaNye0CwN1WwnBd9BwikpmEojzJeR4NUQutnvGRNBKivSopw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(31686004)(316002)(36756003)(6486002)(8676002)(4326008)(66556008)(2616005)(66946007)(186003)(83380400001)(66476007)(41300700001)(6666004)(478600001)(6512007)(26005)(53546011)(6506007)(86362001)(31696002)(8936002)(44832011)(2906002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUZycUdCVGY1M2p3OHEvQVRTb01mM3ZHejYyTXZKUy9hSmRZVzFlMTBsd3Jw?=
 =?utf-8?B?djJIaHpybnNxYWlqOXJXMEQvNjZOUGc5VkhsOXVoZFpDY1lrd0MxdFNMdU5N?=
 =?utf-8?B?RTM2aGcxYmRrWHJ0cDBXa3JmOUxWcGF6TUVrNWRYMGkzKzYvWTRYbEZCYm8x?=
 =?utf-8?B?UHJZaVBZQ0lIa0poRTJmQ0VFTG5LL1V1OUhoTFVEblcvV1ZIOXhlVkRvWXM5?=
 =?utf-8?B?MTVhd3FzWnNSVHl4cEg4TGJIOU9qTXZtR3VwOEtRVm1yQSszR1FsbXh2WHdh?=
 =?utf-8?B?ZzdGRVFkb2Urc1ZpNTZLTkl0QkZWaTNUbkpGaVQxSzNyc28xMWdJZ2lmTTlF?=
 =?utf-8?B?YU9pMDJnSTlGc0k1VDhOSStOemM1bkMrVGJWeldKSmNvSmdpREwwcW9lNjZP?=
 =?utf-8?B?U1RVU011T1dQUjhKMFVGY1NrNWhaRFF4NTFaeUxQMnNLY0xVQUp5enBzbmFS?=
 =?utf-8?B?UXkxYm9RSklqV2ZKOTJyZ1NYWU5SaGFJNCtaczBPNE1DU0VhUlFnbXpRWnJ2?=
 =?utf-8?B?RGlsbTZnaDVWWEhCYnRKNTVKTm9GYlE1NnRJT0l5NHl4MXArbnNNeWwxV2ds?=
 =?utf-8?B?Y3dzWVFXQys4cm5EVXEyMjB3YktYa3REaFpXaDNPUFZPenBIbTlmSFpxK0J6?=
 =?utf-8?B?VlBFcFNCbTJseGRPODVDelQwclcwQmE2R1hIK2g0U0xNcGFaZGYyVmVMUk9P?=
 =?utf-8?B?TmE3NW1YbmRIeUtyQXorbG1qQWQxMkl5ZXBzU21sVDV2cXZNUlZWWHBKdmhx?=
 =?utf-8?B?YkJncTRtSkhZVHJaWjRSSHVxVUZmazRiNXh0Y1Nwa0xqUkZGaGJhQ3VJVENW?=
 =?utf-8?B?ZUhrVXNvZXFrWGpUMlQxRlU3a0szSTZNSFB6a0tWRzJCblRSUHpiNzF5Kzdq?=
 =?utf-8?B?UkhUcFQ0L0doWTgrMi9jazVFaFJ2bHRVUTRsSVVRMHdUc0p0elNzcVZPb0pt?=
 =?utf-8?B?NU1kOGx3aGxodlJ5RXpHRFRlampnWFJNTDlaNGFaK3RXMStDSXQ1cXVXZURa?=
 =?utf-8?B?YjEzZ1dyUUtqcC95Y2drRk1KRHlhV1h2UUNvem50WWcyazB0dlgvV2V1TmQy?=
 =?utf-8?B?UWdySy8wZGVwMmJtZ3FDUU5hZ2x5dW9IRXk0ajExR3hPVjdUS3lmSGVNSlhO?=
 =?utf-8?B?MFF0KzVlNjVIWkZWRHJCc3hhRFBZdCswZjRCWjVDbk5xZi9CVlR1djFPMmFh?=
 =?utf-8?B?MExyZ1JFY05FU3NibVVLdVF5WGIyV0dsTXB1c3c5bzRkbTNvc3YxcE9uTllr?=
 =?utf-8?B?cHBVS24rSisybkNObFVIMVJSemZhS1diQThFaXJsaVlJbHBlRXhtam1kQlls?=
 =?utf-8?B?ejRDRllrdWI2bTNUM1U1REd0NjlGRHd5dmxCbXVGRG5NUm5ZdGhQYUJkUDNO?=
 =?utf-8?B?d1YreGxrNUJHY1pDN0lBbkkwd00zZzVOcVBpcW1XaHlOaHVzVUw3UHFSejZn?=
 =?utf-8?B?YnM5eUNrRzVVUjk2RldlQkp5TlJyMTh4cThaWDdRdjMxQXdvdUpsSkplT3cv?=
 =?utf-8?B?SWhMdVV2MVUyZVVVdklGMDlWSVdvMHNMWCtNUTE4eWtrWkhmT252cnZuTTYw?=
 =?utf-8?B?OWI0UWd2RWhweGNnOHlVZFRjb3RpUGsyWHp3UEtiNHVSUzVuQkdlVndHQjV6?=
 =?utf-8?B?dmRjNGJTY2tUREFvSHU0OUtweGRwbEErZ1AvV2pHNk1OREdTOUI1K3BJK3Bv?=
 =?utf-8?B?ZVk5cjBCdEh3cDdoQTZnQ1NIc0dtN1VQdG95a3MrSXdieDBmUjJyd0tma2VW?=
 =?utf-8?B?d2FYRE9uelphRGhPam1paWZXaTBxTEZxSE9wNUVFSlVmS3o2UitZZjh5R1hX?=
 =?utf-8?B?THE5Vjg3UWprd3R3RHdsdzBHeFdtU2l2OU8xQlo0VW5mYjR1NVUvamtzd3lv?=
 =?utf-8?B?U3hoNUF5NmFYMmJoalc3SHl6SDVEb1I2VWN4TE5QYkV1VGt1SUkvREFlSy9z?=
 =?utf-8?B?c1lMOFV1YVMvbzViT3lHTHM0VzdiQUpxUFRhNVZncTdFejRKTDhseGFWNE5k?=
 =?utf-8?B?MXJrWUZudC96VXFNaG1FUWk3b1RuTUFXSEdsYXNMdWVtZGxNNWFBeVhNeW9i?=
 =?utf-8?B?N2dNNm1nVTJ1VDBqbzRnMGxTY3FkZitXdkRuR1FKTVBmWWdLYUhJRGlwRXUy?=
 =?utf-8?Q?LCIWDj9E98jnT859Z03KChA4j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bac5a4e-6f3e-4cd9-c770-08da6b072b89
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 10:52:56.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II1JfFC5utxhLGDVFx6hEQnvo0UgmpqvbIMKeqYSdCqMOLdfW4wWaQZicc06263ODFs9D5+YL2oDZ4w/wg8Zag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

Hi Robin,


On 7/15/2022 5:25 PM, Robin Murphy wrote:
> On 2022-07-13 06:30, Vasant Hegde wrote:
> [...]
>> +static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>> +{
>> +    struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
>> +    struct protection_domain *pdom = (struct protection_domain *)cookie;
>> +    int ret;
>> +
>> +    pgtable->pgd = alloc_pgtable_page();
>> +    if (!pgtable->pgd)
>> +        return NULL;
>> +
>> +    ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
>> +    if (ret)
>> +        goto err_free_pgd;
>> +
>> +    pgtable->iop.ops.map          = iommu_v2_map_page;
>> +    pgtable->iop.ops.unmap        = iommu_v2_unmap_page;
> 
> It would be good to use this opportunity to convert AMD over to map_pages/unmap_pages - not only for the future goal of removing map/unmap (it's not worth maintaining two interfaces where one is a trivial subset of the other), but also since it should be appreciably more efficient for you in practice, especially for v2 with the more limited set of basic page sizes.
> 

Makes sense. I will work on this and post v3 soon.

Thanks
-Vasant

