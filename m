Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644017D1
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 15:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZTsoLaIPEzEBTL5ushQrsYzJDazEKKsNCMIi83YefEUQeiC5K7xsFkNPUCS15rwvbRfxJnI6ShcKAf1Cu2MpzOS9ya05QgPP44Oz+CI0Wp1I5q9AIh5gXtg9SQ+wWKX+rwazzBlD+VaPwlGmYuHrDO/BznQTNNrJmWoVWXI7OBMMZMA6XpKp8/ttbfifIw3ip8PhGfTEM27pPuDHxjaRRc1wuiBtO6CQSRf+emRMrTCUoq+LKf/eoeJdlr+jcfmew5ERNWyMlx2wrQSTYL5fQErk0q+4R2Kj0+loYd+z/7h6KdjHPcOgCNYegYj2vwc+fzZtxa4IusvtvQ/ANb1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t455Nlr1CYNMOaSNP/fOqG4pZnB0QFnz4zWusW+Q1vY=;
 b=GT/bbMNj2I6oDuW8ONtjskVmup64FpN0F9QKzXMVd32dB1Wbb1ATLUWvdrATVx4dfxgBcgOo59XRUbHB9AkrhDw3XZ4HlzsCXLJdohy1RGMt7tX9+rFunVVCpPJlA3pbT1L+KxgpSH8R2lagcbkEkP1Txvyl6+iAGx4wUbd/Htes9x0TKTGWQdVxsqaWKXs/fdn+k0E57TISPPk2JZUbwGxSbqeLIsBqISvgzeBd1MbZttGXdAACTlYX9Z1y/JoTy0wTXH2ocFMaQSNyaqlG8vwyw0VbkwyuAHKjRjWcp++KgvVH2j1CqXrfiSPgIlTY53osuqcrV3Qyo/f+RZfkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t455Nlr1CYNMOaSNP/fOqG4pZnB0QFnz4zWusW+Q1vY=;
 b=VZNRRs+tUc2iBRuy/Pc1S1auvIqvN4dQph3GSMw0ivYr8LdcmmDG2Fkzb/9s7ZhvMzvueJE966bDm10gx+OeQCouEsscuXLhuIXIK6XdZrcmdmdMVQpX4C4js7sS+QvU5a/QCDj8yvMKRE9tXVcEk69U1oe675FqU9x/6LBbnNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 15:42:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:42:02 +0000
Message-ID: <f0898091-da6d-a4ad-1846-2a7eafc386fd@amd.com>
Date: Tue, 6 Sep 2022 11:41:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: amd iommu configuration
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Steven J Abner <pheonix.sja@att.net>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, amd-gfx@lists.freedesktop.org
References: <6JULHR.A756AJXX1SBV2.ref@att.net> <6JULHR.A756AJXX1SBV2@att.net>
 <efdd6848-6bbb-8e24-efd5-3b79865a653b@amd.com>
 <54c4ec3a-a9c5-c920-bcb7-d737a63c5d1b@arm.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <54c4ec3a-a9c5-c920-bcb7-d737a63c5d1b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78e4325-2399-42ac-99dd-08da901e579d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AZNPHdhxLcEU/e3aIg5bPuRyc66xxlQ6s/3H5/gakL8BOjfWH8cwRpzi2zb3F+h4or0dUDPSyX9TVNCxuNsvVR0IhlKTMs0OloFcBQNusDSZxz7U9PZ+VZH+hSdvMUwdJLW/CtMVKAjlkfTu3AzeLMFFIZ7cNtz1siy/hEPqyl5Z9vmve93JA4ZYpgtpUVmScTiL9hR4Gm5qmBtG9SwouGjBOHZMXZZcFT/z4kxy3vp7SOO46bKutCa+tYr70cGF2wi0W09tBr5981RyeY3zYBikCSRNcsIB7xScW+AB9epo7Ahgif+RwaPw0LBw8EeMrAWU5fX8evHc3rYkaBuOcLOgdIlLnaHhnLhP+Wq3LHNoq1D4NG55YJHCqA3XPfj/D8jeQa6MOnjh5Wu91YV/CC74AhyXX5Py6jmwAWw3jaQWnw6n0kmgqwmC76qpyN1JRh6TrZ5ml5EcTBFo9JHOrf+zTU8uOWJhPpq83JHXmX+byuFLA8y4JVNOxsFhJ8+ri+DzGpi2DG/vyN8IZ5q9lib/rgaio9aCbZXddYcHrqYiyL8j5WAUjfHOKL+4jmvBMksZ0ws/ieR7+0hibMLKKDK8RuSK6s9q4Vss0c33KzRnuIBa1YXiZo/jWDhiksLcV9J8pkxKIU5KvcLmt6WP7r8wouv1nbO+3JdBIEZY1C107CVRCPagq2WlGcSdmjnCP/J/3Vjxv5XerP0nyOYc90UUIGRjwxYz26VIx+LKvfX8asDon1mDJeiesiq4BboOtweMVUiG93DWs1uDOrriapw9jmfGpYxfSrwql77iuLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(31686004)(38100700002)(66476007)(31696002)(86362001)(4326008)(7116003)(66556008)(8676002)(66946007)(36756003)(83380400001)(2616005)(3480700007)(36916002)(53546011)(2906002)(6512007)(6666004)(41300700001)(26005)(478600001)(6486002)(6506007)(316002)(110136005)(186003)(44832011)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1p6d1liNUVkMG4wWGttWkNlUjZDRzNNN1JxS0hEaUVPS3JqWk1ocjFpdlFO?=
 =?utf-8?B?OGVtVFhlLzF0V1RRYkd0cDR1SDZDbThqRXZPdEdoSjVyeUp6cGNodVAzSTlx?=
 =?utf-8?B?YSs2UjZ2aU55MzY3SFBDOFpEY3lrc1pyTi90RDJER2xUMkpGZGtzN29OWkZs?=
 =?utf-8?B?V1EvOTBrVG9FS1VlN0Fub0I5cHF3endxSnMwb3dCZ2RiM2wwZEM0RUphRGJ4?=
 =?utf-8?B?TW81R1h4NE9sZGkrbFl0WDRqb09NY2txWUZSdmlYK1BsS0E0MTYwejFTS0F2?=
 =?utf-8?B?U2pOWkVQa2N1Z1BNNGc2N0dBTXFXcUpBeDhsV0xlRzJ0UzNoZnMrU09qYkE4?=
 =?utf-8?B?Q2ZJalYzVFZlK25QbXpaYWF6SERyR1pzalUzUlloOEVYK0JtcXNzWGVGRlpW?=
 =?utf-8?B?aXV0OWlSTnJyazFpZUlCNFRtT3BBeThYNjZjU2RFTFRuaDlMTUNpUjZhRG9j?=
 =?utf-8?B?SUpIdThENDdHQ2JyYnRqSTNNSGFJNTBLUEYrYXhwZms5VFJET2hUR0RUWFpX?=
 =?utf-8?B?eDhIb20wY0VjdUFBNTVMcytBTWtFWmlSd2hsQXEvQVR5TllRMXo5enBlTGJW?=
 =?utf-8?B?b09tc1NMYjlMUjNZYkdNeldLOFlscGIwV3JVajA5c00zc1ZhaC9DNHpCNGJu?=
 =?utf-8?B?bmU1SGQwR2RHMUllclB4cDJwTnovUXl1bC9KOUJEUi8ydVBjb3JjcDlCVHRM?=
 =?utf-8?B?aDNzbUZUbWNJR1ZITFg5MEIzYzFEam4zTWYrRjdnbENCeGdUdHIwNVVoM1Yy?=
 =?utf-8?B?Z0dZUlZnVHpVKzBkYVpGMjlrWXp0LzhXbFFReWdSdmU2YTlpNHNNWmpKMFND?=
 =?utf-8?B?Zk5tZ3NCQlN6bTNZRjlrZWtwQmgyVnNWNXpSR0FKeDVRUEZFYVhoRmJlbVU5?=
 =?utf-8?B?LzFRRVA5WDZhTG54VThabitWZzJmd2dWOGl2TWpPcUhOUkZ6S2RsUk9nU0Mx?=
 =?utf-8?B?U1FjVi9SanUyTXd5QTJOSjBJTUFMcXpCUktjR2J1VVRxVUgxcnRBS01vU3Ri?=
 =?utf-8?B?ZWs2TU10ek9ta2FBcUpMYmY5U1p0VmxSNW53UHVOczRXVnRyTTFnYWZJalRm?=
 =?utf-8?B?cFE1MzlGcmVLWEVabVI2WVdKWnhCWGVVYzB6MmtTdFp1Z0p2L1BJUTdMKzVi?=
 =?utf-8?B?cDRZL0k0M0FjL1h3N1NxNy9nazdYOVQ1a3FNQlJVRHFHQUw0VHdDck1MejZB?=
 =?utf-8?B?UmR0cDNMcmUza2c0ZlEzVVpZR1pBOWxHVVpJa2ZjK3F3RVhHSVY4bTQrL25T?=
 =?utf-8?B?dWdlY0c5bEFtTkkxZHFpbkZaUWVkYjlIUUxCRWFuSWJsUGIyU0RVc2lKd2VS?=
 =?utf-8?B?SjhNRnZ2dXM1QjNJRjU0NFd0OUJUUVI1bTBMbXU3L1hOd21vdHF3a3hPYzZL?=
 =?utf-8?B?Z3QwV2lGendhSVJLMXZncUVoRjlUaUc3SUdQekdWM210R2o3WEY4V2c1Zk5Q?=
 =?utf-8?B?bnJsT2o3U2JNd1lyTkQ2aEdEbm5WQjRSZFFrdHhXTXZyRFdTTWg5TThDaUNm?=
 =?utf-8?B?OHJEVGMxb0JxRTFiOHJLdXQ2MUxwUS9GMnV5ZUhjcWI1dkMvSWsrNnpZUWdo?=
 =?utf-8?B?ZXpkZmVzOVhsN0ZhUlgzSGVjK3FxU2JoS1FNZWV6ODBEdFJkWGxlU1B1S2I2?=
 =?utf-8?B?cERnUGtGZXY1Wi8vTmdkUXZuWHBJU2ZpV2l0b0J6OENCeU52QzRtZDdzN1hX?=
 =?utf-8?B?bjE5cTViYTVqdDJUQndqdjUrZ054MXF3U2lJSXZFeU9WTkJhczk2emk5SElD?=
 =?utf-8?B?SjNneGxFdnkyQkJXM1FiOUNsTllTT2w2aFN0SzJrL3YwczEwTVV3d1M5Wk55?=
 =?utf-8?B?RWhkZXorREI0aWxpbE9NeDVLbWtocGQrYzRYZEJMUnZuM3phQVlDNnFhV2dX?=
 =?utf-8?B?NVIrWXhNWTFXTnAxWkNiY0diUzJDTDk4eWxXWDJtUS9MSDI1WUVVQldCZnI5?=
 =?utf-8?B?QzlteW9jS0tHVFZFeW5JOU1LWXg2VFV3Tmkrdm9CWVpwQmdmb3lURE11aWNW?=
 =?utf-8?B?TTg3YThtSXhCYlpGcU5hTEJWUVdiZmFpRVBObjY0Ylljd1lrb1lmWUhXK2hW?=
 =?utf-8?B?aUVrQ3hNcStQVEFyRWNKZDRUbERzMzFMaG9IMVJZUXdVU2ZLU0xldmkxL0xt?=
 =?utf-8?Q?Bkce/f+NnmzAZ0RgAa4gfpXZc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78e4325-2399-42ac-99dd-08da901e579d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:42:02.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/6YK10JTobchiqBpdoXC+epxuzG7HY7AeAG+7jDLklN+wNIjVYvSe3GycTwTCOhCCJZdF3hfxDvLgCOU0Ifhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088

On 2022-09-06 10:52, Robin Murphy wrote:
> On 2022-09-05 15:13, Vasant Hegde wrote:
>> Steven,
>>
>> [+Felix, amd-fgx list]
>>
>>
>> On 9/3/2022 4:29 AM, Steven J Abner wrote:
>>> Hi
>>> I was referred to you from linux-kernel@vger.kernel.org about the 
>>> following issue.
>>> Here is as was written:
>>> On 9/1/22 11:36, Steven J Abner wrote:
>>> Hi
>>> Building a kernel tailored for AMD 2400g on ASRock B450 using 
>>> 5.18.12 as base.
>>> I stumbled across an odd situation and which lacked Kconfig info and 
>>> lead to
>>> oddity.
>>> /drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 
>>> 'tristate' but unlike
>>> many
>>> other tristate configures doesn't mention that module name is 
>>> 'iommu_v2.ko' and
>>> loading should be done by adding to modules-load.d.
>>>
>>> The oddity is that by loading as module is as follows (differences):
>>>
>>> builtin iommu_v2 version dmesg:
>>> amdgpu: HMM registered 2048MB device memory
>>> amdgpu: Topology: Add APU node [0x0:0x0]
>>> amdgpu: Topology: Add APU node [0x15dd:0x1002]
>>> AMD-Vi: AMD IOMMUv2 loaded and initialized
>>> kfd kfd: amdgpu: added device 1002:15dd
>>> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>>> memmap_init_zone_device initialised 524288 pages in 0ms
>>
>> IOMMU V2 modules provides IOMMU feature like attaching device to
>> process. I think amdgpu uses those features if available.
>> So in this case amdgpu is using those IOMMU features.
>>
>>>
>>> module not loaded due to missing iommu.conf dmesg:
>>> amdgpu: CRAT table disabled by module option
>>> amdgpu: Topology: Add CPU node
>>> amdgpu: Virtual CRAT table created for CPU
>>> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
>>>
>>> module load through iommu.conf dmesg:
>>> amdgpu: CRAT table disabled by module option
>>> amdgpu: Topology: Add CPU node
>>> amdgpu: Virtual CRAT table created for CPU
>>> AMD-Vi: AMD IOMMUv2 loaded and initialized
>>> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
>>>
>>> Note, only difference on witk/without iommu.conf is:
>>> AMD-Vi: AMD IOMMUv2 loaded and initialized
>>
>> I think in this case iommu_v2.ko module got loaded after GPU
>> initialized. Hence amdgpu is not using iommu v2 features.
>>
>>
>>>
>>> So does this mean missing features by not having builtin?
>>> If not, should Kconfig have hint about module and loading?
>>
>> @Felix,
>>    I see that drivers/gpu/drm/amd/amdkfd/Kconfig contains below line
>>      imply AMD_IOMMU_V2 if X86_64
>>
>>
>>    Should we change `s/imply/select` ?
>
> "select" might help when KFD is built-in, but it probably still wants 
> a MODULE_SOFTDEP() to enforce load order when they're both modular.

We don't want to make it a hard dependency because only a small subset 
of all AMD GPUs use iommuv2, and we have fallbacks in place for even 
those to work without it.

Regards,
   Felix


>
> Robin.
