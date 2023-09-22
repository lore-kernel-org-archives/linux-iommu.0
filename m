Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799624433
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 06:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y69bUZKud9ZAfZAqLov3fXfjVhPQcKVtjuZgy2LHFREa2SSikTgnulObcMjDMWcs2uEXk22hXwF5btVvSETp2S7G23ttpiqOEz8r6AZzPseI6kU8QRBbGmFuo/PXB4gNGjZcKZbQdGYdVNs5KQT233HNiFgP1LYY8tH5p+NPbcDDgPtpbZpBLyte9T1g3MLsdyBAUCAsSM/yVoiHS2G6eCvnnKGAj5bt2tGKmQgdBwU2NcpagJcvhOSh02xP3KxDHdiEepXSjJ0CXrknHcsA8pByzFrz6FeZXlsHEk2fh+hGdwHL/xbwFcl0qn0vbzvYypGoBvgrN1QpwYlGdW7VZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI/sUaIfwCDwMtkfCP4b44aHRuz4PKACIqFZ0Wdw4hI=;
 b=KA07Z/onOowivDKvTnDIWzIEhJzFLuBJW+giYptirzFCxdjBnur1BHw7wtsCzI//0+hwRBpwq8rmBA6r2KX/MTkoXQRFfquULps+860aVLdZV97YYTUs0n4PWumhZerX8KRgOjxATFKOpat3IEyA4uQjCjZ2GHwiQ2W0ow7NoOZrMIotdrwYsvuQkVawmfGPZ2WKMgIzathwxowi2vrH1EC9e/5lCG3oRNFB5ZhepKBaTvZm42blk7b9FyKvpL7FLU9KJEQDtHNz+lg+d5l9RtkbnYDi1pz2BrtCP6WKOSVZgEiEeOLoVsq+Ct3/TYwdEcoIbHQeOhkw/ORoQj/N4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI/sUaIfwCDwMtkfCP4b44aHRuz4PKACIqFZ0Wdw4hI=;
 b=oFljHxMv0TnXr9UTQ5DMvf9jPZBK0hSbGS8i1KAjqe7PNsEoV3QKAymN5MU65eWqX5zXXdJRwRdaFDzawsSLqvYkes2TdRISU/qQSJ5IMWQhzEsNLgExgNlI/KcT7vMgJb1Fynn+8j8Lsj+vDTZIun+sXYYg3fKuONd+Iy91wtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 06:45:13 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 06:45:13 +0000
Message-ID: <8d7a8fa9-020c-2b0b-1bfe-0957bffb198b@amd.com>
Date: Fri, 22 Sep 2023 12:15:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1ce993-5043-4888-cc76-08dbbb3778f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DJAemXZm3WvPZ/csThu9QOcsMgdoFB/jRd5Wrbpuhu7+uCUHWDKRxwkIFHW4kri/4H0Zi87A80J47oRIx5OsUi5pFJZU6ziyKOuJUYmclhPOkdxelFWh8z2fLWHu+/z+TADzYjDsbqDvUpo0oytcoJfQdhImEvv2ZBdLZ6Fw7vFrNU4w0lOS5BrjX7sFwPDQqs9CyWPoCLFpJHgnXKsZIBKDcfSNBUUv+VX9dPeTpngVMUQvPA8g0O3OqQswx5AgSyMSpkl/mt9HqESl/m2rI9bCJ5mJNjmyJ1Heq6+D6dF4QPQGvnj042LMUUG/nQ8fGwuXLGpkCm9lwfVbtwJCYGFlxkjqZIUP84FlKche2HU2vF2YuHcw7Zh60DG60pogUhPcBcAJzngsVNBvePr6Z0CTsbUuXGITJkvC/1C2hSW0dxWmVyoj3uAYmnrB7DQmiho9tYalsSr43Wg5qaGdUxsQynzCLZkzTC/S6xdPEABk4ZsOoh/df7fhVWTCkdFVUetufprIHjODkrGh17hM7FnLSAHdNMg8Kele25DHVBjaHHbH21EnTFfJIrSdVf0YEQjeg+YZXBU3hkno08cWtsmJIS0X5A8hG5jQVGK+GXAPYjcJfLupL9cEtsz67fN0XII2Cq/rgEcE1NJEL9/Hng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(186009)(1800799009)(31686004)(53546011)(6506007)(6666004)(6486002)(36756003)(31696002)(86362001)(38100700002)(2906002)(2616005)(478600001)(6512007)(4326008)(5660300002)(83380400001)(26005)(41300700001)(44832011)(110136005)(316002)(66476007)(8676002)(8936002)(66946007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3hTcHJGK2UrODVrK1ZDOHNIeFNnWHUrU0Z0S2VVOTV3d1BSNEVTR0lMbE9J?=
 =?utf-8?B?RFJHMWJ1bUt4SmdkT2kwc3gwSTB3OGhOaWExR1RCdDdiMnNWd3NFcWp3OGlO?=
 =?utf-8?B?WFN0YUNHMzlJSm5yMGtZMGJsQ284a0p1elliMmVaUVRCd0FCWTJwRFVqazlQ?=
 =?utf-8?B?MzIrSHpuZTBUWk16UDBKUTlaMGZYU2dLcEZRa2hDRUYvelRxU1hnYjl2Z2Zj?=
 =?utf-8?B?bzNuOTdKNzR0MllRbUtsYjNSQ05SMzVKRDJDRTRtTERVMCtwQ1pEVm00TUZz?=
 =?utf-8?B?bG1OY0NIWlFGdXlNOG1pSk4yNXVjVmlPeGloQ3BuWDltR1ZtbG9ZOVVBMHdX?=
 =?utf-8?B?RmdhQWowVjZhOUJ4RmxIUUhiZXlOeWlpUHRhUndqbUhNS3p3YVZCV29mUDdv?=
 =?utf-8?B?eGJzVno4czFvY0NHemoxa0dJMTArR0wyQlMvTFNoQWNBdnc4ZUw2ZmdIYjFB?=
 =?utf-8?B?cFdqYWN2c3F0eE1IUDB4ZlV0ZXVheTFLZWptYkgzU2xuazh4R0w4NFBXNE5Q?=
 =?utf-8?B?QTdRNkV1ZzdPUDIwcitGK1pBUWdFNDNrOFJzOFZScnNPUGZWSXB0aWVwWWtQ?=
 =?utf-8?B?TmJKYmRPSmJ6cVlHVUhaT2QyUlZudC95TkdKVTFXQ0MvTjNld1hkQUtmaFRZ?=
 =?utf-8?B?SWxkN1dZNWIvRStEcTFmRHNyT2twc3g0S1I5eWJiMWZBSmx5b1RxcUVtMjJ3?=
 =?utf-8?B?OFNiaUQvVGNUTERhWCtHdm5xUGp5Ynl6WWRuT2tDNlZtOGFGZDUrVi93QzZN?=
 =?utf-8?B?c3NkcjMvWkk2OG9SbGhVaGlUTTBsZjllQjRaVk84TE8wMWFVditxZFIrQk5U?=
 =?utf-8?B?cm9Mb2N4SFBlcDB1ZStqbEJWU2xXZ0FmYUdqaDJoa2R4NGNibys1UmhyS2hW?=
 =?utf-8?B?em92M1lpTkk2L0JmOFQrMlE5emFiK216dmY4S2cyTHViazE1WGN4TnRRWXEz?=
 =?utf-8?B?b2IrVllPWnRiZFdWTS9iT29GVlJHMVAxUXNtWXE5c2Z3Nks5VWppM3ZIUU1B?=
 =?utf-8?B?NkErSHNHUFQvV0NYZllNbzVBVmVnR2xQZDFKUzNFZDZjSE05ZW5FUnpLdE5s?=
 =?utf-8?B?TlpRV0RicUN4dCtNUk5vRUw3RDNWNkRpM2dkZmNtaXRpRjQ1dXp4V1cwdUhp?=
 =?utf-8?B?dmlkL0hDdmNZM2lnaStGSzM0ODZWbzdoRDg4MDlrazlzTXBCcytHdmFBYjhh?=
 =?utf-8?B?VVV1ZTVIdW12YmxEendGeVptdEd1bHFCOS9vREhCeGczcWRWN2dNYnBMclJx?=
 =?utf-8?B?cHBna3dRMWZKV0hndXpmdFd3QW40MWFNZXY4NUtFUmdLM1Fpa2xRVVJJRmdE?=
 =?utf-8?B?Y2xsTmgxQ1FNQ3FuZUZja0hSZWVVMEE4dkY2VEljdWpFOHo1SGtvVmNKZnho?=
 =?utf-8?B?emx2NHE2ZGtmMjdXY0w1VnlPOUlaQWhNdUo4V1p3U0N1QVpMTW14UkQ5UklC?=
 =?utf-8?B?UUZqSUorKzFQaVlsVmF2MVd1MGRnYTAwbVNOL3FwVWxqQzBkVkJzY1daMkMy?=
 =?utf-8?B?R2NQWjJEYWZaSUpzbktlU2gzYU11YWNLWXRkcVBPOWZVTHFMSmhMRnZ4Um5D?=
 =?utf-8?B?MnI1NXJERGJHT1pwMzZWNkhjc04xanVMTmdSZWVoaHR0SldHN1RuTzM4cU43?=
 =?utf-8?B?UXBNWktzaWNCbEg1YTJGU1F0MzYzSmlIVmNFY0QrOG4vbWhkOVdOZnQzWVBo?=
 =?utf-8?B?TlZ5bCs1REplNEkzTXJDYzJzUExBUExocFRxSXF1SzRaeTIwWTFSY3ZNUHY5?=
 =?utf-8?B?bnlyVFl1QlgxZXUvL05DSHE1dDdOVjltWW43TENPUFphamNaSHJKUVVuTFJV?=
 =?utf-8?B?OUUrTXp4bXU0ZXNPcVJldFJTait3K2VENjZzaTdScU82eXJCNVljWjUxMU1T?=
 =?utf-8?B?Vm9VaVpWZ0hNWUd0c3JKbWliSU1pbEN0ZDlpOGlaK3hvdFdZdWk5bzhTS09n?=
 =?utf-8?B?bUhBOGhialdkVmJHSUxmNW9VV2xOckpHNGpjOEdJdWtyQ2tpYWhwQS80dktX?=
 =?utf-8?B?ZzNRVWw0UEJ0RzloUXhObnVzOENkVG5jc3l6RlhIam9sL2lSaThrQktZRjFu?=
 =?utf-8?B?R0xXSFgxeHRkZ3E0a2g2Um1iQ081SWd6QWVJaEtCd3BoWnBFVnFsWWhocFdS?=
 =?utf-8?Q?TNeBZpVYDEuhc0OkumkD7TiK0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1ce993-5043-4888-cc76-08dbbb3778f1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 06:45:13.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCDmCcAgG6rWWF6DXAoXvVeuyqkS4BNxSuFcey03hS1+blyAonVuTINpZ0CmRYHKdz3LVZtBL02DHf2a/BSFGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

Hi Alex,


On 9/21/2023 8:45 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, September 21, 2023 10:14 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; iommu@lists.linux.dev;
>> joro@8bytes.org; Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>;
>> Huang2, Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; Kuehling, Felix
>> <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>
>> On Thu, Sep 21, 2023 at 02:05:37PM +0000, Deucher, Alexander wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>>> Sent: Thursday, September 21, 2023 5:32 AM
>>>> To: iommu@lists.linux.dev; joro@8bytes.org
>>>> Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Huang2,
>>>> Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; jgg@ziepe.ca;
>> Hegde,
>>>> Vasant <Vasant.Hegde@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>> <Felix.Kuehling@amd.com>; Jason Gunthorpe <jgg@nvidia.com>
>>>> Subject: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>>>
>>>> AMD GPU driver which was the only in-kernel user of iommu_v2 module
>>>> removed dependency on iommu_v2 module.
>>>>
>>>> Also we are working on adding SVA support in AMD IOMMU driver.
>>>> Device drivers are expected to use common SVA framework to enable
>>>> device PASID/PRI features.
>>>>
>>>> Removing iommu_v2 module and then adding SVA simplifies the
>>>> development.
>>>> Hence remove iommu_v2 module.
>>>
>>> Does this patch or the following patches make any functional changes
>>> for devices?  E.g., devices which supported ATS would have been put
>>> into an identity mapping mode previously Is that still retained?
>>
>> Huh? Why would we ever want to do that?
>>
>> Policy for the default domain belongs in the iommu subsystem except in
>> extreme cases, the AMD driver should not be doing random things like forcing
>> identity for ATS capable PCI devices.
> 
> I'm just concerned about regressions in random devices due to a change in policy in the IOMMU driver.  Previously the IOMMU driver would put ATS compatible devices into 1:1 mode.  Also some of the earlier integrated GPUs require 1:1 mapping for display from system memory due to hardware limitations.  There were also a lot of sbios bugs in the carrizo/raven timeframe because windows didn't enable the IOMMU so lots of OEMs had bogus IOMMU ACPI tables which didn't cause problems when 1:1 mode was used.

This patchset is not making functional change to default domain (it still puts
PASID capable devices in passthrough mode. 1 x 1 mapping). But I do plan to make
changes after SVA and invalidation improvement series gets merged.

Couple of things :
  - If device supports only ATS (no PASID, PRI), then we don't force 1 x 1 mapping.

  - If system is booted with SME (mem_encrypt=on), we force all devices to use
DMA translation mode and iommu_v2 module is not supported (no PASID support).

  - If device is capable of PASID, then we force 1 x 1 mapping. My understanding
is device wanted to use iommu_v2 module (enable PASID/PRI). There is no easy way
to switch from IOMMU DMA translation mode (V1 page table mode) to PASID support
mode (V2 page table). Hence 1 x 1 mapping was enforced.

Do you see any issue if we boot these devices with V2 page table mode (it will
go through IOMMU DMA translation mode) and don't switch page table mode during
runtime? -OR- older GPU's always expects 1 x 1 mapping?


-Vasant
