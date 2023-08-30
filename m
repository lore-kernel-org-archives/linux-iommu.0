Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AF7483
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 19:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQDFE0fgB4N9NniwHBz2XeXThJ05+/FHimt4WHkw1/ytwKG2z3pKiPTVcpBTzksDSaui0XuTm4w3FtX88gXzlN7+i9XPaG25w1gsV08Prokb33UCproE/RBCFYJknmgxbRDPtQ2uDpjdOpeay4khGnudJRNEzY8vm2Y8MvkRNArt1fummBHvQzvMjFhmjRPsZZm8uCJ7CYKnx+HzwxElXN3pBR8hnnrRQLw9QF0V2D2dvQuIOnBVHLB55liKxt76hTbvkTHNBsXIUnlrS+PvXs4EGZ7B2l5RLR6cJpuylLOv6B1BKHX8a9BNvDB4v1P4jfajv0vjdODo0uwN6Z+j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG4UkFbDnYZSG2ZytTyaydE4QxG/+iMfAz1S2UOntrM=;
 b=holz6IeNrk6crT1Eel8JXOJlnPjeeA5sav73dtQ1zdgDaWJX98ygj90fFYBYVTaf2EdiRTPTUJPLngVT3umtqEYQFA082hYdsrGipOfGoPJmYh9IJd4jf0VxwQmAc9MANgFeERh7yepqPTQWRsF/VqhQHfMr3Ra4+llmKet+s3Av2IT7QnddEKlEKIKlSbYz9nq0uqBjC3BXHIEeMcQgT0xm/R3NT+hLyAFOhy7CvuiAwTyiqUzo6UTHNZZ3Bk8e0mww9Z2T9Vr7wHktXZMz+v06xo3pbQYRWvwV5K8ffVmrIyHZk+42E1GC8+0XBtpMaHoC/iEz7Rt2WObgp7d58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG4UkFbDnYZSG2ZytTyaydE4QxG/+iMfAz1S2UOntrM=;
 b=3PVrei4/vDJxfwOTtPj1zBGqb0f+Q67gOVh02Y06Z1MkqUOI4vSPb1vr39k/vPZBCwUHJa9LMHjTA0PtgsmAf3gx7zCwM2+i5rikRhWxqbfiMkteTLf1Ae8RoAH/Z5R8VuEPR6wyU6FAxEYT1m6+N/TCYwj6+j2krbbii9C3In0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 19:00:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 19:00:35 +0000
Message-ID: <7f231d1c-30d8-d30c-8cc3-82179066909d@amd.com>
Date: Thu, 31 Aug 2023 00:30:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable SVA
 feature
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com> <ZOYljfDOgbzVeBeX@ziepe.ca>
 <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com> <ZO93zPITePX52FaE@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZO93zPITePX52FaE@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: bb418a09-6792-4a52-316b-08dba98b6452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xAKYTQI4uX1Ksw2LIrgb/uMhi5hn3WlILLqh3VHMR3hiA29NgZJGNWhLyGP+t7YGcF2tSN+rJFB22W5FGzI8fsCdoo6fFVAC9OwtxR7SJYov/xrQqa8vaHYe72wut+rWkM5nbgoS4NIf3EGlNPhV4gz6hCj9dQrY276CVUjN4jBdpKUvEsQ6Rxm1LIIE1j9hPdqkHUMEMxpZs0xlsVK+UQNe18gdoZYkYbjhnb4Whfk7+l6SVLZ/2GHD03pw2wResLOozKYixRH0cX6zsMaZFDPmgLTpOUBjRGtVg1Bx/fyHvQAXjUV5gPTX0B5IOpZZuyFUcWt/BCucZeULC4AVdam5SfSm1o2syAfD3GBwSto//KpXXsZgJIfGmdZxT4P1MtpHcGkLGEdyey7Uo7aIynC34fFxnvmtonUh3/WdVn3tvqWbxdbdXe8R7XYfGSPoKPOUQbsWioVplBWUpmNxXdk/itIMdzMx4K/avbsQO8XK+0UKgU6bxR54vIJzykTa5apVefcltoqPShTX1pYrLpOV+S9Rfh+r8u6eXE8eUti+Ug856DCY+XDR5ZYoTY3RlfUnEzyQboIqlMx2yyjno1VKWS+Z4AV4oma3YAyDwY/Ybk2yaK6RfHlTDCMITTCWPopsG+1OhNs7HrAhcHmdsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(186009)(451199024)(1800799009)(36756003)(31686004)(83380400001)(4326008)(53546011)(44832011)(41300700001)(31696002)(86362001)(5660300002)(8936002)(8676002)(26005)(6506007)(6666004)(6486002)(2616005)(6512007)(38100700002)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzdEbTg3b3dSbzIrcm5oZDR1RzRyOG82MzVEeEVUcVdtaFJQdzlReW1DWUM2?=
 =?utf-8?B?MDhuRzdET2lIcFB6dlNFZ1h5cDNvdDROeXJiWUNneXc4Vy9vTGFBOTF5bjNG?=
 =?utf-8?B?bk9kcVVJK1IrcGFUcktuWGdVVDRpQ2h0UWkwWTRxbEp2SlZEWlNGYXpRRm1r?=
 =?utf-8?B?MmNWQlZKRXNRa1NSbkF4Z0RaRGhvTk10Q0FFVUpqNDlVdGJCMW1ydjgxMDQw?=
 =?utf-8?B?ajNoVlp4ZzVscVJYWDc4UHpUSTIrYkhzU011dWE2NVFPRXEvUkQrZ1gwOFRv?=
 =?utf-8?B?Q2QyM1o1VzdzMzJzV1lvT2w2d3M4dEM5dU5zWHVrQkswNlNJWkxMMEhoOHF1?=
 =?utf-8?B?RWlvTkpPYWlRemwrMHdZZ1liNjlYNlh1bFVmbzRnR1E5RldBdjRLcmZBY09X?=
 =?utf-8?B?SmY2NDBXS0pVcUh0YkxOK1lFL0R4aW5rN1lsRkJncGhSeXR0YjdqbGdDSFdY?=
 =?utf-8?B?MndBaytDNndsTEFnUmNPcVdsUEFIZmtaMks0NjdSQzllaTFVaFlNZmFsQmoz?=
 =?utf-8?B?TlF4bVpEU0xyUFFhb2JzYnRoUUUzdGJ2S044YjZaMnRZRUhNb3c5K1AwU1RO?=
 =?utf-8?B?a1oxT2pSbGVMVFB5MEhQVVRkbmllT1ZJUkNpbFlHMk5YTGRhc0VQS3M3RTMw?=
 =?utf-8?B?K1lQbHZ4U3Rwdkx4VlZabTZldFBJTGJXNVl4UWxBWjExN3A1Nzl5MVRLRHk5?=
 =?utf-8?B?TmVUekpzR0ZsMlRQZ1gvUDIxbGMrNmVZNzIyUlVFZGVCRTZMREJpMjBabzR1?=
 =?utf-8?B?VnNFenpEYzJFWElZRjhsclA2Y2tpRVRUOHZkQUtzUEp5NGtMek5wTi9SK3Ir?=
 =?utf-8?B?TWNIUjNtVTJSbFMrMUptMzFaZVZ3aHh6UGJ0Wi9waWkrdlFXU25vemd6aG1Q?=
 =?utf-8?B?b0dYOFc1NVhFTjZyT1FBVFdpbUVtSWJrc3FBSXVTbnp2Z3BVTkI3bVFHd2Ny?=
 =?utf-8?B?TzgvRjVObWl0UVE1Q0tzTjF4b2RPNWI4RWgzd2VYeXZLVFJhd3hXNWdmc2Mw?=
 =?utf-8?B?N2hKRFZjelJZTjY5TENaUkNCeDRydHk0K0VMekpwRnFCM2FKWmNSaVdsSllP?=
 =?utf-8?B?NWk4ZTZUbmpraXpvek1GRkNsNGtGMzRIcklnZWRoVGxtL2tyclpJWUViVjhl?=
 =?utf-8?B?VkMwYXZ1elh5SmpScUhmMnVxYXRsOXdOL2RUK1FFcU54elZUbzB3Y2xLWVlp?=
 =?utf-8?B?cC9qTnp4ajNzWTJvT1lGczllVERNTDN5NzJNUlVFZjFxQjRyeXI0YWRoRlNN?=
 =?utf-8?B?Rm1rY3EwdFN3U3BNV2w4MUMyOGlhS1lhaXh2QzJOK1NFK0xVdFNXNGN3eHM5?=
 =?utf-8?B?dkVLUWNtRmxCYWJtNDhmczB2MkROcXNXMXhmeDVUeWxUbTlVd2pOVHcwTWpD?=
 =?utf-8?B?b2VEMzVXNkZXeGpzUVFBMnk2MTR5anU4YW9ZVUxhT0lHZll5Um43MG1Ldm5Q?=
 =?utf-8?B?dW9qZlNYYVhtVGR0U2dwbm05VEJZL3ovOTM0WThhVUU0NGhOWnlpK3NiUXEx?=
 =?utf-8?B?bDJ0QmZxclpKWXBuNUM4amh2cUk5dVpieHNhWVJXQWRQendnanNRVzFlNE4x?=
 =?utf-8?B?SjQwcUNMTjJxUjNZMm1KMEJOV0tSUmxpb2VKVGxlL3AyWU80WlFNZmFmZ2li?=
 =?utf-8?B?T0Y5OXdtZ0sySmNRMlJRcEZidGs5cmZFYVp4US9aVktSTmI4aTZWdE5IYU9w?=
 =?utf-8?B?L28zSU9kRjdwT0NoUE1URmxnbDZ5V2orS0lOTHlIQU9ybXpPUGVCVTRRd2gy?=
 =?utf-8?B?L01EZXhmQ2IwMnUybElYWUZ6bkV0cHV5emRMMFBXcW15eXk0VW5nbUM0YWtS?=
 =?utf-8?B?Kzk4cU9ZN0ZDZ0dUeEwwWG9BS1dPTEI0cEhVcHFxZ0dNdUxNdWdOU0s1d3B6?=
 =?utf-8?B?dUcrWW5vdUVKbXhtNjVac3QzWWhjZVhIRGcyRStXZG8vdUxqWldsRHU0dmox?=
 =?utf-8?B?U24rRTZCZkhUTHR4dTNhYkF4MFd3ZG1LZ3AwM3h0UjF4bm5hS2NSZ0FONkRZ?=
 =?utf-8?B?ZFBzQzA0MmphK0NRZkNqWE83MzRkVDBOMittOHFQSVh4MU4yYkl2OGh1OUt0?=
 =?utf-8?B?T3g1N1dpeEVtSTdmN251eGdBZEZRUlZISHhiRDA5WnprenFmNzN3YzhBd1g5?=
 =?utf-8?Q?Is4Sp6c5VOuD9/9/x50BPaRhO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb418a09-6792-4a52-316b-08dba98b6452
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 19:00:35.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRRO/aZkssx0whEsrXLEjTZWRdxDE1RR47sERKc0O8eKLsb7kbCHHVEHNx3G70b9mmg8Mex4IEkGytrw5CvwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

Jason,


On 8/30/2023 10:39 PM, Jason Gunthorpe wrote:
> On Mon, Aug 28, 2023 at 04:15:45PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 8/23/2023 8:58 PM, Jason Gunthorpe wrote:
>>> On Wed, Aug 23, 2023 at 02:04:09PM +0000, Vasant Hegde wrote:
>>>
>>>> +int amd_iommu_sva_enable(struct device *dev)
>>>> +{
>>>> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>> +
>>>> +	if (!pdev || !iommu || !dev_data)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (!amd_iommu_sva_supported())
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (!dev_data->pasid_enabled)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
>>>> +}
>>>> +
>>>> +int amd_iommu_sva_disable(struct device *dev)
>>>> +{
>>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>> +
>>>> +	if (!iommu || !dev_data)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return amd_iommu_sva_gcr3_uninit(dev_data);
>>>> +}
>>>
>>> I think these features are a mistake, you need to implement them for
>>> now but I wouldn't touch the gcr3 table, and disable should be a NOP.
>>
>> We need to configure Device Table Entry when we enable/disable SVA.
> 
> The DTE should only be changed by bind/unbind of RID/PASID - it has
> nothing to do with these APIs.

Above functions are called during enable_feature(SVA) path. Not in PASID
bind/unbind path. In PASID bind/unbind path we just update PASID table.


> 
> Again, start with enabling native PASID support for UNAMANGED v2
> domains and your SVA will make alot more sense and be alot cleaner.

Currently, the IOMMU_DOMAIN_UNMANAGED is used by VFIO, which sets up the v1
table for GPA->SPA translation.

If we were to force the unmanaged domain to use the v2 table by default, we
would not be able to support nested translation, where it requires v1 table to
be managed by the host ( GPA->SPA) and v2 in the guest (GVA->GPA).

In this case, how would you handle this issue?

A solution might be to allow specifying which page table (v1 or v2) to use when
creating the unmanaged domain.


-Vasant
