Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35F1BDD9
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="izgEy7hE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAsDIzIXt5oSPDaZzk39BirAckRYlaW7uIi0sQLyuyUD/nn0jLQw6UiEeY4/061BZRlQd5H9EucWZeso1KEIoiqu4A3htYwYAwgmjxlhRqZVnkBkxSE+9NS64xZhswVb5LHkwOAJWxb+p9CtaDPf5VGP3JwWSr3bXtMxb9li6cy5NgAxhVfvbjWyxCvlZxBYK0l7RxteRP3o6zpqPlcjDdeQVaAAytIMO4CHX/HQ8lNL+2vlUJFvSTYy4rlCeYKX5K1qrtqay9G6uOC8cz1TBwObLxNNuysOBX22wTUn85Kg29fDF+duFf+dumkPTo48av5PTrwuAcRHQ2pjmR3J8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwBEkIn2+IlC4PQjoS39wyHDCqUkhR03c5sbIVeEQUY=;
 b=FQwsLZFWovjNDc1ttj/y33TMNbxXi9JcS4GcYPYQ1rEC1WXT5vQ2qIBS+M1lZTbF0/BdWBh6SqmpRD8KxExazKTj799f3v+1vpKRGCNUU3xgu1jf1Uszv3BBW0geAjyroZu/jSV3YlElGMK6WSUm8Z7fw71NMsgrnprx/8Y5B8sc1GmcQ+AWx2n2jEzPr7JeJsm29H8Sh4mU63ap4dXYm2cJXbzIbXcgpPdJ76sMcM/GHESwPcFN0iM0jKvi8TkZyCBqcMNhB06/oCzm5aHFZOijFmm1Q94rsus1nkVKIKHWNgOc4wdJ7sl8Zp3S/xNsVPNHFqMUEERMHFBsUM1gXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwBEkIn2+IlC4PQjoS39wyHDCqUkhR03c5sbIVeEQUY=;
 b=izgEy7hEHiV0B0rSZxKjuoEF+mI3HwgVBwXnGon7LqO8EbFlSMAdE1EMLar1LX7JEVEQl9Deo5NhttGelNT0AOG+R/YKLoAAk9A1THiYschFrOQ56mBESa3FmWysiKyImizhu9tFjyNS5+46pAXFVpudda/4qbJY8ncp2FwpCMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Fri, 13 Oct
 2023 15:45:31 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 15:45:31 +0000
Message-ID: <2189b86f-903f-0b4c-d0bc-3632639a477b@amd.com>
Date: Fri, 13 Oct 2023 21:15:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com> <ZQHRTwYN4doUte5E@ziepe.ca>
 <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
 <20230927164523.GO13795@ziepe.ca>
 <497df4d9-2203-ad36-a5d1-97570b327a49@amd.com>
 <20231010143829.GA55194@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231010143829.GA55194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CO6PR12MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: 50efcbe2-e6e3-4132-4dc7-08dbcc036e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Iy4IuXrL0byTjuhxFoYUn+x8rtX1Gl4Ebaw+HY51GFzoELwNqWBH34tO7QHwfG0si0B2HB2qaSLIff1eZtO/SYzrbUgLdb5qQdHjCQss1WKoAHYB4NaWCnhyOOMedufFHp5ZAitDvnXURDfI/CfWOMjth3TpHMBRfN1urWdtrshYqXn0nvbjl5UdKGKaaoO2uxlPhLs/XUoteHNDycQOR8q3Ch52j6+++cemTHvwaBLxzUnPLyoxlTxeGgz3UCOSYXwdRHjgfXgtU+TmcJPwgYRiy8hoot5W9qfYYJ72B3WpwehxUrCYzQfSSPTvnGBvFKg8om/MYD0tF+ECE98dQch9rQEF7UpjwHHvWRojY2kFOvB8JbTAhJv585I7nfoESAjy9OtuQDezboLYvSHLzqXDyl/HEWU2Ks5/yArN6MB1fIxZ9Wn39AFF8YYxSOQXqX3XfHihm3YYtK3KIoJFI/rfuWtpxWiJdIwVzQ5lwOpHmPUT0Hu1tbbczzxQ/0XYHGckD+3ibE4H13PZHyNDsQN7NBfBaSR8gF4kgSASwbDOT3Y5QUYYSoJFn2h3sTuajZRao/Mr3SS7L72jtCmNXblJJdOdmon5CfK9o1ywg2dTKXkIenTtSO9dLV2b29Enl3dD2kIUXDg8kj3GbpVI/dMvicxOF0oDAdps6vi9qH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(31686004)(26005)(53546011)(2616005)(86362001)(36756003)(4326008)(66556008)(8936002)(6666004)(478600001)(2906002)(44832011)(6512007)(8676002)(38100700002)(5660300002)(6916009)(316002)(41300700001)(966005)(31696002)(6506007)(66476007)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlJHYVFZSnUySEMxMjlrNC9XbTdlR010YmlhWVBrMWRXYm1EL3ljNWs3WFBQ?=
 =?utf-8?B?d2ZFVXFGVHBrWVR4TGFMYVc2TGxxZllDRGI3Mk9veXNPa2k5TFJudmRaVjMw?=
 =?utf-8?B?eHJKUE54MUY5K2pIdXJ1bHh6a3lmR2NPUkNueGNFeEZaM1UxOEd3K0x0QUNn?=
 =?utf-8?B?blpHbW1KbmNFdFNvN29lV0NWeGRXcjZlMFJ1cnNjY3E5RlNOSkQxdlpxNE1G?=
 =?utf-8?B?enRlNStpeTZjbDdMWHNxd0wyVjRoMUhCcDZPZ0lQWDJZOU1OdG96SGNnVitW?=
 =?utf-8?B?NG5sVy9ZNzZ0eWo0TnhIcDdvV2wyVFI5RGUreUtiOHdFM0labmVBVHl1aUZL?=
 =?utf-8?B?UnZFeW40UnF5dGgvZDJzSVVraklSeDRhVmtBcHlENlBpSG9wV0tnWjRLRVUx?=
 =?utf-8?B?SU45bEwyRG1wbmdQVWZUQ28xdkgycUJSR3dZT1ZKSUt3M1RxcE5jWGFyTUtH?=
 =?utf-8?B?OE1mNEdWejlpQTNoWHNSS3VqNE9JcnFuS0o4KzRIcmUyZEFlenYwckthNVl4?=
 =?utf-8?B?MitSMmVMeitGK3U5T1hmODFGUkFSNnFBZmZUcDYvUXNRTmlvb003anlhZDBx?=
 =?utf-8?B?SXEyM2lYWW43NDczRkk5b3lHY0VzUGVkamJMR0h0bTJXanZ5MUFvelRJWXUr?=
 =?utf-8?B?eWU0ZVRUTnpNODluQ0dkclprOS8rMnk0c1BUUU40VkJrcFphNnJrU0hTcEty?=
 =?utf-8?B?dThiajNHOGswRW93Q0N0UFFydHVOczlsWWZRaXp0WEVDdStFdkEvNEp3R1NI?=
 =?utf-8?B?TktKZEhQYWw0QmNncXorSU1ucGowNFFZTjl6Y1ZyVVo2Q2ZYRjVEamFJem9N?=
 =?utf-8?B?ak1uVmdQYWcvd3YyRURMVHloaFR3SW1zdmlHRUNXeUZHaHJoRFZJa2VLTDdp?=
 =?utf-8?B?b1gzM0NjVUgvQ3Nwelp4ejIxL2RHemM2cVo5RWd5RjJhVVpEVzBZT0l3aXpi?=
 =?utf-8?B?c2ZYVExDNjV3NlA3RFF5anJXZUpaQ3lVWlFtVGFXT3pYRHZ2dkwxL3EweVJw?=
 =?utf-8?B?NUpUZk1TN0lNekFnU244RjJQZDN2QVRqNDB2eGxyRUl6d3lLbDdkRDZMb1Rx?=
 =?utf-8?B?MVh0RWNPMnRRZHUwbVQ3QUp1NTc0V3JYR2M4cGJWRlBETjN6b2NsbnRpbzl1?=
 =?utf-8?B?dmw3bitxQjRLamxVR1p1c25Zd2wrV1pNMUdrbHJsei9XSzFzK0NUUDUra2Zz?=
 =?utf-8?B?dVZnWHZwT0Y3OHhZK0kwQnhkU2h0bmFlWDlrN01uRUJ2eG5WZzNPbkxRY0Iz?=
 =?utf-8?B?bUw2d0FwVUZSQ0luTDczbWFXdi9MMHJPcVNYM2M5cXZLaU5oMkV3WjJDcHJN?=
 =?utf-8?B?ZVBnUnpHTzVZd1U2RjNCeEE5ekxBWnd3LzN4YW1iZDZ3NG81K0pZdDVzMXZ5?=
 =?utf-8?B?QjlTU2tBWjdjdVpZbnNOa1BwRTBodklJQXBtcmxMbzVRV1gvR2VLbG1wazBG?=
 =?utf-8?B?TVo0blVIdG9UWXF0REFmRGNqMTBDMTlMZW9ZMnRZY1BoalIyNXFSWmhyeGQ4?=
 =?utf-8?B?TGdqWWtuNWlWOE5NWkg4SDVXendqMGQ1NW5DaVhwWWR1dGRMSHZ0c2FBamFE?=
 =?utf-8?B?d3A0cmJSbXRSQXIvQnRrYWsvMGUrT2FERGswYTN4V0N4a2NGYjJoL3YxYmJ6?=
 =?utf-8?B?RjRQdVVVYjZvMXdSR2lyMFR5WHhNYVRlVFc2VXdBdThKMk1vN3FDOW8rVEpY?=
 =?utf-8?B?VHNTcFQycU16L0YwKy90WTB2L1FReWZDa2FZcnJnTStBc3hmNmQzVlR1dTNz?=
 =?utf-8?B?QW1tbFRUNXhYeDhmZzIzMkh3Wi9rR0E1OGw0R25qUjVpRWRia2FnT3AxUnc4?=
 =?utf-8?B?NkRkSVNMWUFnQldWeWJ3SWNrU3dlSnFBMTNsQVliNXlhSVQzTjNEU08ydEpY?=
 =?utf-8?B?N1VsKzQyOXJpWlUxUUpXUVJYTzVQODBMeE90emJyMzZHSUlHOU9jYjkvNmhj?=
 =?utf-8?B?bFdjSUc1YTB0ZlJaRXkrQVp5QU9jejlualF3OVU0cm5mamMxSkx5TEZCQi9R?=
 =?utf-8?B?RnZEVDMxNlR6bWdOTWM0MUVNLzJPbmE4QzBkcU1iNnpDNDR1QlNWdnB1Z1Q1?=
 =?utf-8?B?MWV6M2k4dHdsblFpYnR2SFQxbEp4OHVrOWYxOWo5U1RzOTFpcXZ0bnBLYkI5?=
 =?utf-8?Q?hSHyFj7dbYP18nSrmm1c/Kb5h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50efcbe2-e6e3-4132-4dc7-08dbcc036e39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:45:31.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cmT25cs33llJJfa5iz8meQRfEUGepPkq0Q/AaWDJKG+ovZ3VDc3Dqmjn633BLeGUScrjRQQkXpcN4klDbXIDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443



On 10/10/2023 8:08 PM, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 11:32:53AM +0530, Vasant Hegde wrote:
> 
>> __amd_iommu_flush_tlb() flushes both domain ID and all devices within the domain
>> for the given PASID. So it works fine. All these functions are reworked as part
>> of invalidation series. Hence this function is not relevant anymore.
> 
> But the replacement has the same issue:
> 
> static int domain_flush_tlb_range(struct protection_domain *pdom,
>                                   ioasid_t pasid, u64 address, size_t size)
> {
>         struct iommu_cmd cmd;
>         int i, ret = 0;
>         bool gn = is_pasid_valid(pasid);
> 
>         build_inv_iommu_pages(&cmd, address, size, pdom->id, pasid, gn);
>                                               ^^^^^^^^^^^^^^^
> 
> (btw I have no issue/comments with the invalidate series, it just
> doesn't go far enough to correctly support the iommu core's PASID ops)

Invalidation series [1] is cleaning up existing code. Device oriented flushing
logic will be introduced in later series.

[1]
https://lore.kernel.org/linux-iommu/20231006101624.5912-1-vasant.hegde@amd.com/T/#t

> 
>>> Nothing guarantees that domain->id is per-device. It is emphatically
>>> not, it is per-domain. It happens to act like it is per-device when
>>> using the DMA API, as DMA API does not share domains across
>>> groups. However iommufd does share domains and so this is not a
>>> correct assumption.
>>
>> That's exactly why I have been saying for SVA I don't need
>> per-device-domain ID.  Current code works fine. Anyway, I will add
>> this support in v3.
> 
> The threshold for upstream is more than "works fine" in some limited
> testing.

I know that.

> 
> It needs to correctly implement the driver op APIs we have defined in
> the core code. In this regard it does not "work fine", you can see it
> by code inspection that it is not producing a correct cache tag in the
> IOTLB for domains attached via op->set_dev_pasid()

Domain centered approach works fine (not just limited testing) for enabling SVA
with DMA API mode in host. Going to device specific domain ID will introduce
performance penalty.

When we support PASID with UNMANAGED domain and vIOMMU we do need
per-device-domain-id. Anyway for now I have introduced per-device-domain-ID for
as soon as I put device in V2 page table mode [2].

[2]
https://lore.kernel.org/linux-iommu/20231013151652.6008-1-vasant.hegde@amd.com/T/#t

-Vasant
