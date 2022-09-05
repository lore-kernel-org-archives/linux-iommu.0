Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5C7E
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 14:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btos/CKYBwdW5sfqAPQvbzX2C6dMdVUMGeKpMUbGNFwkZ1ljRlp7BQoVxXmaTfM2mB0FScWaJG1r6S5yAnnQ/Fgbdvc8MGYDvHbHAdp/IWlNdhzSexKZpnb9ipfByK38kjtWJTqDSQvHGoAnTu/N+6E+tyISDS7LOZlukqueJKPW3G1zHDkbN2JLwfl+6yc4H8NWbPKIyDQ9wW96ne2UEHIha87Iys/8r3y97Flj+skP8/sWtILC86iIyiPtJt1d5Fecey10RN9/9pp0RLY1KXSGhzVXJM6lyfXqqstqwuUpj2AqyHJ57rvUnVYRerlv3pslh4EDT8cxUZJzdY0Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+TxpYa7NJNIOZjqk+YQ2gOZYzaC1C6C1YNA8pcf5o8=;
 b=WLweeCvCv6laqEPTfPKVtZh21PIC5VISOO/j1FsvCxjJn5PVF8ajV2RR7vBFKvnVazP+f60mIeiq93l/REPTxcxOFBpZsEe3UqE+LH0MrNEEKFI892QVXCPd3io19UfEyPERadvv9FM8dwxQ3VSnzxnI1idvB3DG1h55W08p8yG/aSBdXfLj4AA4PT4c4uqHfUVpk7f7wpNuFrLSBSQbe72lBA94UaZ7G7AIevR8AOYtcTfzTGkC4ucxvl0+B34MgSHXns+4sMe3hOhXI7s0JXWOqRwlV3r6yboMyx9/EXPvCmeJ9vLJ3vyfT3Lj+0uzz+5k3T/5LYZRsUFwyQg6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+TxpYa7NJNIOZjqk+YQ2gOZYzaC1C6C1YNA8pcf5o8=;
 b=apoFQCkAertwl93cMiLKMgG1EoPlYpmN8PuVGyR5u+JRIN9SoyxPUNE5vNCVhuiOzrQdBzuYXcMCoIx4Njv5i7hIT0QTZ8vLmG/UF6SN32+KXvR8vaXONWsBQH79QbfmlrY5rJfWjuDK6d+rks4BCOeyW633UbYjdw3qzNHhc7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Mon, 5 Sep 2022 14:13:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9ccd:c887:5b9d:44f0]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9ccd:c887:5b9d:44f0%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 14:13:57 +0000
Message-ID: <efdd6848-6bbb-8e24-efd5-3b79865a653b@amd.com>
Date: Mon, 5 Sep 2022 19:43:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: amd iommu configuration
Content-Language: en-US
To: Steven J Abner <pheonix.sja@att.net>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 iommu@lists.linux.dev, Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
References: <6JULHR.A756AJXX1SBV2.ref@att.net> <6JULHR.A756AJXX1SBV2@att.net>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6JULHR.A756AJXX1SBV2@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929bfac6-e7dc-48d5-f00e-08da8f48df0b
X-MS-TrafficTypeDiagnostic: IA1PR12MB6578:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y649b0xF7CzeX6NU9AkKPqBAWk+YutqyBr7sbVq7mYb1Y4xceJ42u0Vn+jUtb2cOmhQff1sBi2Upafa2o5ofUaZw4KzFTJ4h3Dh6IxjVKHrwP2Ehd60+uwhw09xw+5yLHgpqHFE9eHBunGWyXnsYXQYVLHHaw6O7HOVodFiKydkx9zmyH0J7jvpkowLlaJrZD1BtX2m7PPm6SK5sAqGZytoAM0LABZ6WhfOdGh0rb7JfrPBAxH99HxZb/TG6rDbnxcVvhpBcyCqq+ViM5cHD2gq/pgMv9Nel5Lb0nqyWERxpb0vSSBRWmg1KajxsECPBFiIJIwzFlE548/5wpdncgJWSwVs6A0kK0qFTMmMbPWvFOP8RMTaReJhOqcEcgNlm0KphVL96+2NMRbuYQqZrYV6sbEkyn0Hm1hABkVadLZgNcyIt96AdjchYqX/1Ry17KKIRamlYmNefiP9lYAyBsSvdtuCoU0Arb/sM6uSCozShzKkA0550mci8T8U3iF3++IGW/Xc9TFEcpADTGtvjOLzWbepRzFtmt4W5CkL7+CLCGipKeJUR4lDT+LMul6SO9jfDAX0PvWSr6w/me2xwdZayx7vPnMzt/2Gpvfj6VOj6h1C7IqErKTeaz6x4fVgQ+68jvPYyIWzFd+xr5OPViJlEs4V3XK5+1WOY/bCIGI5aH89hCpqlfoVBkU6fqbzLCJuSSYDerqPBH7iEFzC8RzFVwA9acd6kUE7/bVp2iwf+IIhdphBBTfF2DDJyHFQlGrTWzJalQx8vKf6bw7Mr4ALAPspkXQLq28mwArOJfMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(83380400001)(3480700007)(66946007)(7116003)(8676002)(2906002)(110136005)(38100700002)(4326008)(66556008)(66476007)(316002)(44832011)(26005)(5660300002)(6506007)(53546011)(6512007)(31686004)(186003)(8936002)(2616005)(6486002)(6666004)(41300700001)(31696002)(86362001)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0N1NlZRNWtXNnNkSzhxQ0VJVjNFcndUNEhkRGo3VUtJMS83SExkc3JXejYy?=
 =?utf-8?B?UStFZ1pnMy9yT2FQcWxGMkhOK0FOSXhMdFYvalBlWlZRRHNDS1Y2NC8wWTFX?=
 =?utf-8?B?cURKSm13c1lobVNtM1g4cWJHOGU3UzFJSnFPUEhBdDFVOXRVRFE1M0pNSC83?=
 =?utf-8?B?OW9ES08xVmREOGRUb29zZkc4MityMU9yMDVKeFpXT0hFbWRCZEEzZEI0TDFT?=
 =?utf-8?B?bjhPbEtBU2RvczFhOHRxVWFnbko1MTQ4ZTJiNDdKZUhwSE04dlJIZEF2NWhL?=
 =?utf-8?B?VHN1UUV4b1llaDVOYUdRSGsvQllsQmh6akNUUjFPUUNMQmVtdEMvM2J4anFP?=
 =?utf-8?B?Vi9YY2tsMi8xaEdyTmorRjRnOEhsYUdycW9hb0h6YmNnU2lQVklKMXlzZldn?=
 =?utf-8?B?QlBsSEt3OWV5M2xXQitSbkxVa0dlaDZDRTZHKzNKZDRpVWNLUi9NZCtDZ2hI?=
 =?utf-8?B?V2RLcFBwdm83Skwzam56M2tjeWNMVmtXTXl6aWtvNDliSTRSaTdzSmtwNW9Z?=
 =?utf-8?B?MlVmdURvN0ljcVFxelRHWlJoM1lmWWs0TlFYR2s0UXdwQTJUNjc3T0JMenp3?=
 =?utf-8?B?V1dSNnlmUzhBVzNqR0oxVlZiNlVBZC94RHRReDVXRmJBM01PZzJzQXRaSEdT?=
 =?utf-8?B?S1NFTno3TUh6aW13c2pnU1BGWFpVbXJmQnZFRXQwOEgrRzFnUi9MVlFMSWM1?=
 =?utf-8?B?aUNGMWl6bm01cE91SGFmMmNYSWx1SGxNY25mMzFwcWo4UDdFZEJMRy8yZEdZ?=
 =?utf-8?B?NWdEM3VScm51VTRLcEN4blc0ZFpJOXZjR0NWbXFuSVQ4L1VlYWFNeENtK3M4?=
 =?utf-8?B?bVo4bkd2OWtjYVF0Zzl4b2hMUk1mVlpOTm5sTkRkcmNUNkJlUy93Z29GZnNt?=
 =?utf-8?B?cFBrWTFUTWtRbGZ1d0dvK0l2b3NyV3NyVVNsVjR2YzkrelVkWm1iQmR3Z0sr?=
 =?utf-8?B?MTlkYm1CYmI5KzRmTFcwS2hmSWFQeDR0VHBBczZ3a05nMVBpNE9EVnJPdm8w?=
 =?utf-8?B?VU1oQ3EwSGVOUzVCTkpmMGlIcFhiVnJCVDRKRi9KU1hOOW1oZmNma2RvUU9y?=
 =?utf-8?B?Z2ZPQnFDT3lPbWFmN0plS2hvRkxxSTZNeXZDU0pPTnh3MFczWjFDWE1oNmJN?=
 =?utf-8?B?OUdiTnNlS2xSaGdxYWF0a1VZUVQ5MGhOcFRBM01kcVdtbTQzSXBFZkwvb1dQ?=
 =?utf-8?B?WTNnMlFVU3hqbnFkMHdqUmg0L3d4RzhveTg0Z3RlTnlJMVBveDQ2NVhLb2Nv?=
 =?utf-8?B?OFFoZFdxZ3lZaU1CNEdWTEFYcG9vWUxaYXVCQmdvNmVLNUxlT0RubnN3UHR3?=
 =?utf-8?B?d0hSWkRobkJVWTVnUUJiVlU3VXRGeHFjNXRROE5TRU02bXpqRURSQzV3WWJI?=
 =?utf-8?B?UDN5ZUlCU3JLWktib29Yd09JMjZmYVg0TjdaWmtuUlZsdXljWTZXdkdJeURu?=
 =?utf-8?B?R1Fkb3B5SmxUV28rQ093TzdFQ2toMk1HcDVHQWtnMnVmbWh0WGIrVlo2bzhs?=
 =?utf-8?B?VFVRcTVsVmQ5ODBmbXVjQXJhOW1hbG1uVHN2dSs5NFdYdXBXKy9NWjNRakpJ?=
 =?utf-8?B?UStpUmdZc3JqT0hHNVdvcGQ2SllxVzdXY1dKL2s1VGpNVU9ucjJGcVpMWU42?=
 =?utf-8?B?WGlqUFl6dTRFOGtwZUZzbG5hUW11Z1N1MFdOSVIwL3FSaXR6Z0c2TDY5TVhj?=
 =?utf-8?B?RTNEVkVpS2RKdXE3U0E3SW8vcGw5bjB3b3daRm5GUjQ5aWFLMDVTYlJ0MmFv?=
 =?utf-8?B?ZE9mbTFSMGw5R2dhdmxwclJtUis4ejV5ckpLU2txWVlJd0ZoZjUrcDNFT0ZF?=
 =?utf-8?B?Njg1UmtKV01yV3dEVHd2NDUvOHBaSHhWK2o4bUpxU1pPWm0vU0l5KzlEcmp5?=
 =?utf-8?B?K0RVOGczL0hLZlBJM3lNMUdnNkFSMFNLTXl1UnlEaWYvSExyak05VnRQNTRk?=
 =?utf-8?B?ZC9DZldMd1ZQdjNrKzJEMXVBb0hhNWVSazVzNkVWZHBMbE9JRE1mUzlGMmw0?=
 =?utf-8?B?d3VvV1kyZ0E1RUNQUW4xdnRMWjBXTHlDKytQQVdGQUQ3VDJoSjBNRG5tbFpP?=
 =?utf-8?B?Zk5ub3BEaHE2ZlFWY1dDNEcreEUyc3ozUzNDbGM3aUVCdkNjWHZDL3E3TTkw?=
 =?utf-8?Q?4Tiw3xLhvW57Sod2VBL0Wpy95?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929bfac6-e7dc-48d5-f00e-08da8f48df0b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 14:13:57.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmIx8EALmKdiwaCcarPxNjyqfPU7e1xVinT4I+gvrMtNHah2elQ/Ur18EH5SnZbmfRvBSK6fiiaI0C6/xiHstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578

Steven,

[+Felix, amd-fgx list]


On 9/3/2022 4:29 AM, Steven J Abner wrote:
> Hi
> I was referred to you from linux-kernel@vger.kernel.org about the following issue.
> Here is as was written:
> On 9/1/22 11:36, Steven J Abner wrote:
> Hi
> Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 as base.
> I stumbled across an odd situation and which lacked Kconfig info and lead to
> oddity.
> /drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 'tristate' but unlike
> many
> other tristate configures doesn't mention that module name is 'iommu_v2.ko' and
> loading should be done by adding to modules-load.d.
> 
> The oddity is that by loading as module is as follows (differences):
> 
> builtin iommu_v2 version dmesg:
> amdgpu: HMM registered 2048MB device memory
> amdgpu: Topology: Add APU node [0x0:0x0]
> amdgpu: Topology: Add APU node [0x15dd:0x1002]
> AMD-Vi: AMD IOMMUv2 loaded and initialized
> kfd kfd: amdgpu: added device 1002:15dd
> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> memmap_init_zone_device initialised 524288 pages in 0ms

IOMMU V2 modules provides IOMMU feature like attaching device to
process. I think amdgpu uses those features if available.
So in this case amdgpu is using those IOMMU features.

> 
> module not loaded due to missing iommu.conf dmesg:
> amdgpu: CRAT table disabled by module option
> amdgpu: Topology: Add CPU node
> amdgpu: Virtual CRAT table created for CPU
> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
> 
> module load through iommu.conf dmesg:
> amdgpu: CRAT table disabled by module option
> amdgpu: Topology: Add CPU node
> amdgpu: Virtual CRAT table created for CPU
> AMD-Vi: AMD IOMMUv2 loaded and initialized
> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
> 
> Note, only difference on witk/without iommu.conf is:
> AMD-Vi: AMD IOMMUv2 loaded and initialized

I think in this case iommu_v2.ko module got loaded after GPU
initialized. Hence amdgpu is not using iommu v2 features.


> 
> So does this mean missing features by not having builtin?
> If not, should Kconfig have hint about module and loading?

@Felix,
  I see that drivers/gpu/drm/amd/amdkfd/Kconfig contains below line
    imply AMD_IOMMU_V2 if X86_64


  Should we change `s/imply/select` ?

-Vasant


> 
> Steve
> 
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to my posting, please:) Not a list member.
> 
> I hope you can assist linux people and myself. I assumed from dmesg that
> it must be builtin. But also wonder if it should be in amdgpu or tied to it.
> Steve
> 
> 

