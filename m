Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B61CA87
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424910; cv=fail; b=mTEKe6K7Aow5kSYXei+6QGUcGG7N2SirucbGiwdcGkuo8DvM0P3T7IcHyxgOAhvpkamUG+MN9UZ0e3RaTgzv1DNm5VRGQNqARn1Vx9InEk9xYV4VZ8ZjX6OSmd+2oyRyPlQ/OzjeShpH9H2nj9fiarPsh5/12akF83tq8e+1M/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424910; c=relaxed/simple;
	bh=RnIsRlo3/At7Cv4a406SAxLxwzfn8svePvGx30KwoT0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=LvHOdhGNPzoMrAqDhdS3FiXECel+owzNqUSMG8PGqPsF7f1917/gXIo5cHSZbNaKUDnoVLs5B9IehXpPspdj+VGSXlQZX3Re17yYH38XWuhxIwn6kChgSAkCs4K2g2v/OQBMy9T+/aQnKh9CVYM3V8zSBB6p64NCaTrGiYhgkts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PHUB4gW5
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PHUB4gW5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN5BzYvLl3ETDQ2rtNH/SjfDREwBb+e2ZD+8OMO/KEmjznbbLxlyMgXOYvMgDUuFmQYY0NtxlxD5li8a8xqQkr5AO3K1ib4Z7GWvFkILyf9Dwn/5446TU7JVEaM2UP/FVx5L7qIT071H6Ju+nJe0CSz+d+UcRBhpR+0lYlX23/vGc03g3rfCW9R2Y+e7NGn7EmJI1ecRQI0ppPaC5XbbxUGw+ohJrB0e4rQ464MdyzTPE1n3dRXeaP7k3NzBQp8B/rfSnxwSqVGFKDHWKcTbO/ZMAOZWauA46D9Odc/lLmm8t2LJ2yJNQbBQ88Jh6g379ie52IXzNqFAaQaSam2gaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZjeLEOY7Tl2RBjBweQm1h8D2XFZBdfPqA69MJAreis=;
 b=O7geIlWp/BQWOaL257V9xtNP9lSJtTzfNu/R07PJMI3odeHdEVBm1RXJqocoxu5R7Sb/WchaGTwfeXBaHYV8oIaz01Hff89o+FyIklEMdxAj86cleA0akkAQsPoWfdq90XK2Kd64D6gU181BrEEClXh0aJxvIlyRowdJm1E7Z4tr7TGsFzrtycCUCeE/oiI8+kDSPENk4HMUzkMGrlKUiBAqgLvUrVKLgP1RKUWG+TOSHTC3lqagGFydhhbyPmEJH5iVGgtTXegMj14q+dUKBu2tS2775tL/NESpT8l3Sb7LOit3fWDHAwZQC20UKExCHSM6O6mpab0ge1MEQntC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZjeLEOY7Tl2RBjBweQm1h8D2XFZBdfPqA69MJAreis=;
 b=PHUB4gW5O4mGXqXVKJG2ckCFzjsikq5ReWEj7o+5kEVAnizpJD7HzoLjXqjR7E8t3VDARBh8ANPMLFT8kZMK8lvPUWkE93wys9cU8VYFwxcW4P+Q+1bmieqXj4dNlQl3rbl8WSDLTrRQq7/Avdaj/2GmC5m3X94I1xAqDokdKdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.30; Tue, 16 Jan 2024 17:08:26 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 17:08:26 +0000
Message-ID: <2fa63c4c-28bb-246d-300b-852db447a3c7@amd.com>
Date: Tue, 16 Jan 2024 22:38:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com, Baolu Lu <baolu.lu@linux.intel.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
 <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
 <20240112145934.GY50608@ziepe.ca>
 <5d0f4146-fb57-d700-1263-881e2ec3ded7@amd.com>
 <20240116140049.GD50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240116140049.GD50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 651308a2-540c-4929-db92-08dc16b5c0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7GGddSdlNlPXdZHdTGxffx+FrdGtaNCsSZpfbba64vWm2XB7vtTIyDIarrXhSC6SLXOtdTU6Qyt437Ckkl17LjsOKVQkN5520lbsjNXMH9Fyg25pa7KnD/Oj6isqt00n1CC6g94YPPwQnsm/z03UDTHlbDc+FuDttHfZ6/+yp8sFl4YtUcoqIBmI1HXcQcLz8IEy4FsWl0FVAA8HwfLSNuCmXLLXmvKra114jdaBb2E3U1IZrqQ/Kqg+6GQAFykA5W6PDF7dwaroeKExD+XnqfjwPJn9elzzpnjXZsHQgp4sSVX2LNO0dXtcE0TLMFa7mbdpBBfuWbCx4ETB5Vj+7i9bJde5J3h4ZFTLDJ5pdvX8fYn15PRwAwV0f6IelU+Q5NKF3//rWMzppwPnMCXa22sj2lEfMOI7FsRKZJTEL3gaTY1J6oFErner+PKOgVHRTYGdL2mq+6XurBetMRVCnJhgwPLStCCED5APwhs9JLYLbkb951U7VxlyJ+H/dDKUtbUxd75wo0+uBpx1kcj7/+VDbDLFEJ0Hh2yLDP93EbB1h/nqiNtRbAQ5sotWz8rsvJW50u9gZaDmUISRG/naGdE2Skemwi+jNvxusAGLUBYUZ20cVnDErKnsKfreFpFTnbGpLs1K7mFFjLfOu8669A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(26005)(6506007)(6512007)(6666004)(53546011)(5660300002)(44832011)(4326008)(2906002)(8936002)(41300700001)(4744005)(6486002)(478600001)(316002)(66946007)(6916009)(66476007)(66556008)(8676002)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEFuaE9reHg4TkRmT0huSjFWN1lPL2RjWGloR0ZsQzZrRm0wQU9VWEZKQWpK?=
 =?utf-8?B?bVo0SVA2VStUT2QzR1VhRXd3UnZ1U1ByVkp0RjFYZkpDeHFIbzJMV2g0QzBt?=
 =?utf-8?B?VndVSFQ3OUV6M2N1VWE2MmU4S2N0ajB2R3Urd05DVkdpK2FrbEoxNFZXRHZo?=
 =?utf-8?B?T1VsVWlPeEp2VGVMOEYzVmxzTnQ1OXA4OFE2QnJXNldnTmZuenErT2JFR0FP?=
 =?utf-8?B?bWY0bm1WVDFwMW1vcllSQWF3d2NFZi8vQzc5U1c1TVFpN3VMd3lzUml1WmdU?=
 =?utf-8?B?ZkI0RGlFUWVvMDZETHNJa0o1dzJ6cHpmR1NqaW1lOFFUMUtrMzRyTGMzbTAw?=
 =?utf-8?B?WkYzdGhqcmNkQ3VlOEV4WlJ0Y3VsSm5pN1FpSnNDL1BmN1Qydkg3RjJUY05r?=
 =?utf-8?B?aGxmTFZHMGFldDhYVWlvdnFoSU83QjN0QjhxSzR4N0NPZmJDUWZSS2RLTVo3?=
 =?utf-8?B?MTNKWWl4QW1WWGdORmdNbU5RZi8xSnZOMlNOdWlTSlNzdmppdWxvc3dDL1BB?=
 =?utf-8?B?SW1kZ2ZFdkk3U040MUJSVUkwaVRXc0tiKy9tRk11WmYzeUxpRkw5SHNnQitO?=
 =?utf-8?B?WUtaQ0xZZmhUMGlRMmJXMUFZRXpXS3ovbGZlWkFYZXh4WlJJaFgvRUFWY1Nm?=
 =?utf-8?B?SUE2QnlvRUtiRnpoeXJIM0p5NlQ4VmFzT0dIbEUvY2hMQUJ4TEw1ZWlReGlF?=
 =?utf-8?B?MXVkOFRlOVZLRzliNTZvN080bHlkR25vSE1qSkRiSDU4TjJtRzBKYnZ4VkRs?=
 =?utf-8?B?MjhmYTZnNUFGU0J4S1RrMnlMUHhQUmJUblFFZ29zczNQVS9FT2FjZXF1bVNj?=
 =?utf-8?B?dWhuNExtRng3aEZsU2RweXl5UmlEcXFjYlZ2eHpMYzZYZ0VBMUZIZThpS0Fh?=
 =?utf-8?B?OUJ6cEhITzRVdmVDNnBWemZUWTRMc1JiTEEvWGs5aFNnbmpTNEhjaUhEZ1Nm?=
 =?utf-8?B?Z2ZGM1VYRTVFYlkwQ0pFMGNPTStPSmNLVzhKaEk2dzY1dWFxcUhGTnF5a1BT?=
 =?utf-8?B?SzZiaUdEWDdoZEVIV0tiYkZaa05adGR4aTRMVjRRMGgxdTAvUGtaZXBzdWZa?=
 =?utf-8?B?bGNVaGVUOEV4bEo2L3ZVYkFyT2RFQzBhYkkyeEtmRUlTYmYrL1ZINnRwdDND?=
 =?utf-8?B?QWU4eGErcmNaYmpkdTFWRW5lRmZXakFlZEdFWmROSU5YY2VsTHZxRVZvSTNn?=
 =?utf-8?B?ZnBPWUkwc2R3bkxHdXVLNmRGc1lRMXNFeDQyaFI0YUVVQzd3QjFEMGNlNmw1?=
 =?utf-8?B?Q0lFejdIcFROU0JnZGZQS2crajBpTWdTZFMwbGI4TGJIekJWNFN4L0pXNnMr?=
 =?utf-8?B?RHJ6cVpqQmFVYnpmdDNETWtSVjdaQlVwWVNYUVA0azVCNWs1Vi8zQVdNZ3JE?=
 =?utf-8?B?NHN4RU5MeWYrU2R2L1dkSHJDd2Y4TjN1emdTNGpzM0QxTlZJN29nVllrS0xF?=
 =?utf-8?B?L04vM1VTeTRONmI2RUYzd2RWTHV4cytFRUtRelQvMDFNTHBvOEhvTVdVTGFx?=
 =?utf-8?B?YXNTUEVLRlZDODRBMkFRZEUxeXQybHA3dmJkS0QyTGVVR3laTUJrMlBsLzM1?=
 =?utf-8?B?S2pNeTRmVm5iS2pHWkhHT2NBLzRycEhkQ056RytDVW5ubXRMZGNyTjg2MEhx?=
 =?utf-8?B?SHhHeW4zYkt4RmVQRFpza3pkaXlETEd0enJ3OHJheEoycGwzQ3pCcTdtbFJL?=
 =?utf-8?B?aVovMWcrWkZtVzBhQk1xNjNzcTFBeWRBYmw2TWxVWHJWOU9lUGZVeW1acFdL?=
 =?utf-8?B?bVBrVE5tYXJuT1hFQWowdEZSNzladFdUMTJ0RGtDN2p4cXFaSkNuSmNqTWUw?=
 =?utf-8?B?YUpKOERsUU5ZRWxGMEYrMUkrdjdpOXdHVExzS3RLbUdCVmhIbnlrVWZ6SHVz?=
 =?utf-8?B?aFZuNUc0RW9EK1BaUXZzOXBrT2ZINmxscDJTTXpaeDhMZjhQMEVlWjAwbWpl?=
 =?utf-8?B?MlRoc09sZVAyUlVBQW5lemZyWHUxdVFLRUZsSzBEb0ZVNUdtOFI0QVp2QVdJ?=
 =?utf-8?B?SzVyUWRQRkJNR1FTZW1ndWJKS3NRcmIrdm5lVmZMMnRZTkhNdll2a2ZqMVpI?=
 =?utf-8?B?R2dxdEl1V3czZDNvVWQ3bStoT1FIcXF3QU5kRjVhMkRzV2Vmbm9lditFSkp1?=
 =?utf-8?Q?TBBOl7ejwsdSNNdeKhQOGJ6IJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651308a2-540c-4929-db92-08dc16b5c0c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 17:08:26.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG8nGxoEpg0yIjed5wXWS+ID1UD7RtIuBhQvIcU0kEXrm4KRxLk0sowA7M4wcXOZspx7rXAPfWP0xtNzOokDxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547

Joson,


On 1/16/2024 7:30 PM, Jason Gunthorpe wrote:
> On Tue, Jan 16, 2024 at 04:22:16PM +0530, Vasant Hegde wrote:
> 
>>> The *device* has a list of PASID's that point to iommu_domains. This
>>> is stored in an xarray inside the iommu_group.
>>>
>>> The *iommu_domain* has a list of *devices & PASIDs* that can use this
>>> domain for translation (ie that it was attached to)
>>
>> IIUC domain will be having device/PASID combination something like below:
>>
>> UNMANAGED_DOMAIN_A with IO Page table :
>>   - DevA + PASID zero (say non PASID capable device)
>>   - devB + PASID <M>
>>   - devC + PASID <N>
>>
>> We will *not* have same device with different PASID in same domain like
>>   - DevB + PASID M
>>   - DevB + PASID N
>>
>> Is that correct?
> 
> No, all combinations are allowed in the API.

What is the use case for same device with two or more different PASID to point
to same page table?

-Vasant
