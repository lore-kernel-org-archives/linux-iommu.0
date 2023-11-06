Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA0182A1
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="22CZ7RHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXSrHglZG/XHVin4LRuT05aKqel7cj908vswb+vjDnwlG1EpgY0SnuC6B80VXC8B7f6SLFAkP2V5V5ucFYVN7jeAklHNAF0GY7Juc02WeSFCqkuIyKxzOgdtDxOhpYxgTpxEWiyvCLYpiY5CBKOLCxHyepYMWAUslal7lL+HJxLtpZIDoldMZrltLZQu5u8Qb2HDPwdl2DJ3LXh6Dse2ym60dxC4TJm6Z1G0wHgcV7ar8APBAOwFZbYhCBYB9jOVJQ3mdsWlIDPNemmDD0U1Iff6PHdrVQS1nH4kEDq8BJDPvxh59Vo4Wn4YEvf9xUL/5SW1u6K1Ia0b5HQLBu31qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJFIOMa/ntgtAtNpI4GUMg9UwvtmzqYd481fR7iD0no=;
 b=NkVovXMaKQqGkKtrPfwnSZ11k58PmSzhNOzHooqkRaGrHAVTpiZnQ2K9GHNzaFHKiFsvyRoXA6i6HnSGzua5mupTjVuvOl8SbBfSv5iZbktWDmyCEIZj/ex8CB+gxS+YCog7tBej3U1paDwbBU9gJrUli2VRKM2+9R706rBxmbEED+/AxcGW6YYmllD5jwfLV0ifCpYLz/EtL+4f7aPJzSg3baQqxu0Zri9kXnl+eKUhp11xGJq6m7TesuA0L/aRURfN9n8QUFDYHVh5XChXYCC4Ipx5Q61js+woTQjsPWDjwJrzDrlL2/mgGTEldf/tLMShlJGC5BInwO1oT+8+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJFIOMa/ntgtAtNpI4GUMg9UwvtmzqYd481fR7iD0no=;
 b=22CZ7RHCwgRdj4iCZ6cTBb+yVOrIC7nONodQpXQPzdYQOchOoSfh/88NXA16kuRmN6TbALYs7dSNfgR+HB2zMjJn5eO0+k7WLbMCBBhqsllST/UFfSxlufwIr5tl+nycVrPZuKy1rW7fLmsc3BJd9bPD51Fa6NDU3HRSnsDovDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Mon, 6 Nov 2023 10:53:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 10:53:17 +0000
Message-ID: <e4f69ac2-579a-ab71-653f-81af3c3bb3fb@amd.com>
Date: Mon, 6 Nov 2023 16:23:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-10-vasant.hegde@amd.com>
 <20231105175228.GI223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105175228.GI223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbd9163-5677-4300-8678-08dbdeb6955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/YlyriKxHqfxg2Vi+1KkNH+B2/1DNoSTL5oLEcmSkZhZ56vm0vejFUnk6hTWDeI3f2LxW9It9r0Yp7mLYxgZE4CcJt4EjRBGQL/JdRS211eyFM3j0YHdLUQVcHt/6Op89BxUoD/IMLwaC0ehCEmg1GvBP4opS9aGrfIYhKu00kzvEdv6HXwV9S20ddUAeT6IAbdrMKR3G+SOrWWbtPo59VCPTqG9JhlKQsjFqCmaynL/o9vOVYtIRTUzkTbGm0Ji4zABifokrbxMpB0DQZsat7FQJp8xHQGFjeQBXzbmtEtf6Fm+c2l5yWzrrcJsSYdufhYiaJ59W1dx76az3idRZ4gSptaO4ZIUwSTy7Nuh+G5Xpp4ba9GOVI26FqV36VJNyuF7fsj0wJFcs4rEWGPGr8Z5AcybVpcEKvVz+g9I0rmZUU1bfjjbekLyi0f0kodZZMM7ym0QFRZDIt6PK09XvrquRGR7lbanTPlp0jywqV2osHHV5Plt6xsFPYSGhsVYS9WkdR2R1wuBeiJIZiX1cvKh1ye8GwjWKh+aWF1VWABkKj370DBBbVCosh8rB40+fZELhkmwvJ+dEx+GKHM7caVxeIFp6cGuzaDxoKNIg2b048vc3T5VncCZ8fWDo0/1EOZ/UCtDziFEvLv8j9nvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(36756003)(2616005)(6666004)(86362001)(6512007)(53546011)(31696002)(38100700002)(6506007)(83380400001)(41300700001)(6486002)(26005)(478600001)(66946007)(66476007)(31686004)(44832011)(66556008)(316002)(6916009)(4326008)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFaZ0R2aURuNGhKUStQL3FBdHM2WkdFZjhZMmtsT1dLQUV6Q1AvZGR4cjhZ?=
 =?utf-8?B?WENiSVRQay9yak5TVVdzY1ZXQjVndGJwWndIUUR4WmlFbzc0K1YwY01oRnBh?=
 =?utf-8?B?MERVQ2cyVWpjYk9hVFprdEJzaHZZNkI1UWlaQVBobVZmOG5aRThtajJKK0Ry?=
 =?utf-8?B?M3RtSEVWYlN4ZEY2UzZmODVuN2l4Sk05M0M4YjUrNktMN0t1Z1hxZkNWUkFE?=
 =?utf-8?B?Qm1PeTZQemxDQklWdEF6TXl6RVZxU0hub3kremU2endoRnRlRUNhelNYMll6?=
 =?utf-8?B?dnJrOXpNUm1rUGd1SjNiMFNyL3EybEVDVUo1UVVCb05WcFM4ZnFxcCtsRlNz?=
 =?utf-8?B?U2xEM2QyYTdIZUtIQnJiZFNBbFlNUFlNamFNL0ZzSlh2ajdmMmlDK0xDQ0tS?=
 =?utf-8?B?THdqc2Zaa05yc3pYVVdSY2tjT0d3cUtGTVIyV0czL2lQNXhsa2NWRHFDa1or?=
 =?utf-8?B?c0JpOEdQNUluVUZSOTVkN0lqdUFrNnpUNU5KeTVMZWxpeTRMVVpCNGlNK3px?=
 =?utf-8?B?UkFaQmFFNklWZldOZC9vb2FBZFhlekx6Vzl5UVJhV2c3US9RYmR1cGN6SHI1?=
 =?utf-8?B?eWVjR0tQa3VxNVp2cU4vZThnWnRiRjJJWnlUTTE4TkI2QmhWc1RCM0QrdGFD?=
 =?utf-8?B?SFRCWVhVVlBtZXVESjg5c3A1ZDVKbGZhNHpQT2ZMSlAyK1V1dXprTER2b3do?=
 =?utf-8?B?QmN3cmhXbzAxd3piSk9BYUFqaExOeVNYYm1IaVhnRUJWbE5HbGpHNk8rQnR1?=
 =?utf-8?B?bTdReUxtdWcyVVNSYURHRm52MVRYUmZNNXJ0NEZsem5jUXFFMElFSU1yK3NY?=
 =?utf-8?B?S2Y2NDlNK3BVb1B0MDREaEljMkhkMUhIc3Zxd3dCSkUvN1laVFB3bHRYVldU?=
 =?utf-8?B?M0VWOEErWmRPYnNKMWc4TkxaTFVHazVLb3ppODhwSGQxcXNEQWFlTWRkNnV5?=
 =?utf-8?B?ZVNkdGo2TFkxY3FUdEN3NE5OTWlOVmRwRWNtMnBDRGF1Ky8vTUpLc0FLaVZj?=
 =?utf-8?B?NVRpdWljUUJJZnVmV1daQU4wLy9yQUhCOWVTNmlWejFjdzBjUVZnU2FWTmFi?=
 =?utf-8?B?UWEvSnVhR0NDV0J5VGdndDU0YW96QmN4d1VnMVFlNHg1UG5lVW5UZ1cxSVNt?=
 =?utf-8?B?UTRBSkpHZS9WaGxhLzNGNnFQWHFqcW1GZmM0OTNzTWJ5MnNzQWFIaFZkd2w5?=
 =?utf-8?B?eSs0S2M1bng4VlJxTmpsNDVsZnZqUlZEbVhodjg0dTU1bm9pdlpkMU1HdmRJ?=
 =?utf-8?B?cE82aVRQek1jY1VMQlVZa3gwOXVWdVlXZWZoT24rRmN3TVVxdWtHVlBBRjdy?=
 =?utf-8?B?NzNKSE80ZHI1KzZkUTZUU2dpdXZyQWR1VFU3Tlh6TmhnWHJUTzlzYTdvbXFn?=
 =?utf-8?B?TGtKNVR5bmgrYzQyd2t6UVNCWVFiRzZJTFVtVStiMmVtc2hURDJ6M2JwQjZ3?=
 =?utf-8?B?dHdDcjR3RWR4VnV4RFllcDljZzBaWmRJalErakFvcmxtZkdYNDBXdWJUTFJQ?=
 =?utf-8?B?c2hCUzhGNWdJY0xzT2dYVjh6bk90LzhUdUVLcHUvcmVSbWplY1pNWGxuc3g1?=
 =?utf-8?B?YXNpUXMyVTFpc1NGN25GUWMxQVpmb09OeHIyclpHRFF3Vmswdk8yZHpNMm5t?=
 =?utf-8?B?S3IxSkZCL014YmJ6SDNZR01BV1hXeGJHdjcvelNnUXkvQUJQUVVDOHRFMjk2?=
 =?utf-8?B?dExSL0MyelRFeXF2cWsva3FHTWF0bUVVQndZay9MQXN2cDVhcmROK3cveU5C?=
 =?utf-8?B?bHNsY21mSkRMTnUwWnkyRThycFFQaUlHWUJia1g1SmxTMFZib3V4cFMrTFZh?=
 =?utf-8?B?M0FQR0FSdkxCVitVS2U0QTBmMDU3T3BJYnBoZGtYYWxPNExkSml5RE01emxh?=
 =?utf-8?B?M0tPSGd6Vmk5RWF0bmtzd3hXR0MvVHQ4TWwwM2hmcXpKVko5bFUxV0dKc1V6?=
 =?utf-8?B?dUs3RDZNdDdiSkdjTkVxR2ZsOUE5VHJiUUIrdSt6QmxOc0d1Qy81MG12UzhE?=
 =?utf-8?B?NXNPMVB2TWJMRElieWxrVFVGRHBGbHg4SG5XYzBHMEw1bE9SNndVMm1jVDVz?=
 =?utf-8?B?YzBuSmlrYlIzQ0R1WHZUL2dKSFR0eWdnbDlsUERlUHhob1Q4ZWtoNEpFY2Jr?=
 =?utf-8?Q?DR7NYelawO+bjdZfkNMCFdaOv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbd9163-5677-4300-8678-08dbdeb6955b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:53:17.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Kovq3E7FMrUZdGh+oxofxeq7LZoA/4YUZ5To4emcn1hr69ADJVRlSbxH9VcpSUh+qYHhoXhUjYKgHZ+nPSM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419



On 11/5/2023 11:22 PM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:20AM +0000, Vasant Hegde wrote:
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 1f695dd50fec..c30b08e2a939 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1553,10 +1553,18 @@ static void domain_flush_pages(struct protection_domain *domain,
>>  	amd_iommu_domain_flush_complete(domain);
>>  }
>>  
>> +/* Flush range of IO/TLB for a given protection domain */
>> +void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
>> +				  u64 address, size_t size)
>> +{
>> +	return domain_flush_pages(pdom, address, size);
>> +}
> 
> What is the point of having this maze of functions? Just rename
> domain_flush_pages?

Later patch adds PASID check to this function.

> 
>> @@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
>>  	device_flush_dte(dev_data);
>>  
>>  	/* Flush IOTLB and wait for the flushes to finish */
>> -	amd_iommu_domain_flush_tlb_pde(domain);
>> +	amd_iommu_domain_flush_all(domain);
> 
> This is weird.. The cache tag for a domain shouldn't necessarily be
> flushed from the iotlb when a domain is removed from a dte, should it?


In this path we need to flush IOMMU cache along with device IOTLB. That's why
original code called domain flush. May be we can split this into separate piece
where DTE update path will flush the IOMMU TLB and then in do_detach() path we
can just flush IOTLB. I think this needs more investigation to make sure we
don't break things.

Given the amount of changes we are doing in this space I'd prefer not to touch
this now. I will add it into my TODO list. Will revisit along with other
invalidation improvement that I planned to do later (like re-introducing PDE
bit, etc.).


-Vasant

> 
> ATC and IOTLB flushing should be seperate. The IOTLB should be flushed
> immediately before some event that causes the cache tag to become
> invalid, eg returning the tag to an allocator.
> 
> It is a minor point, but it does make things more understandable if
> stuff is done in the right places.
> 
> Jason
