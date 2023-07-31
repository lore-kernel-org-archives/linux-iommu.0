Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380B1FDA
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 07:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7UmwxgTZmIKOVAKdH4bbqnx92NfrR6rnHalR9oSophWG5C9MlnHEx/pzge1WR5yHQGHU7LcEDr8m5ZQW7ivAtYUggVbcLicMULtZx5xjCa80sy8IWDyqjaYSlTR4WSSAtfz5qfrsAux+lT2Cq2Z/crxeLfQN7gVfRGT+lsE5r19mN0BMupX2Bt9ZDikCSVxQV1/UiGsC1JIAYNSB423eRE3iBPVgZ/31rhgpwJnRZsGRGjPAdyK+axjTi03O73PUPYpQmU+q2+up75SQQMF9nmUeIC4WdXvm/T2rVbPMNpPK68WsKPmqmNuQuB5xQTBhCJuVtcrnTQbCb0/74m1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6D4irVWPeYjt9CEBhVqw3SOO/96HqjFF7vcqWhT7pE=;
 b=OEJr35eGVw/T11T9JgNt8BOW+BDz0eOc23B4R2YMUeUKcpSvvpDGzs1KN4J7Ye3wKv+fNxtjsY3W4w+OlrxiZF1aARYeHyiy1i+08Q7yHOSwFyG1jMoOtzz5nKi2vud0jCB7jIxr/SJVGzLfxEooN/ryfFfrP5Qd0mTQVIUxAo7qqKVD201qM6Ul3e2LlGP2fvljgQzJYYsiVQvXsdsDHO3c1X3ym9Vh5qr+Ieox/inJHmlGgFN1ygYHGFPbmL6lk9/H/g2/ZdrS+GRsG2M+k/GhmzPlq1W/vzB+3S8H2ET4C2cvB1AFSJd3crQKOXHh/k+f22d3/khyRYwpWHy+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6D4irVWPeYjt9CEBhVqw3SOO/96HqjFF7vcqWhT7pE=;
 b=eATjKJTLsFCb2gILPov40a4f/DT0S8APLC4/dmVYcemVPby7ciJlRObBRoW4VCpo6C7E/G/UMgliLIbxom8CrVZAl7fshI/nhYmpiOS58jVYPQQiTTVRJyHRfofOrk2v3XnFHAI7HZwJLvvxyQDLYNQNlRHZXISQAzTwoEtmYoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Mon, 31 Jul 2023 07:03:31 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 07:03:31 +0000
Message-ID: <b5bb3e1e-a933-a04c-53e5-bb05c3ad38c1@amd.com>
Date: Mon, 31 Jul 2023 12:33:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 15/16] iommu/amd: Initialize iommu_device->max_pasids
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-16-vasant.hegde@amd.com> <ZMPUufoPxZgFwx0w@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPUufoPxZgFwx0w@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: dd169328-a7ab-4416-1624-08db91943f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ohqqIiaNFBB2r24eDYvK3gxy5bakmtUZt6wBi9b5qf6TNOjXn1VEb+xVitTVt/xNp8F/3CXuVXz7SZ1yAHkmsyOrL9DJFoJ5zwMYO2hBRrn/36L3Mf3XWu/oM/XnMAwOQhjUVTgdmCTjUGlLV7iQvh2gKzknHerr7nOl7lxKfI3BB8vyxLaaIPbtfmIIEyROJTtf0d/mDU0nDcVGBB+NQgjTJjaj2Ovp3ryysNylpaHjM7UDZEwYyRY+GWN/hNBV9XypsQIUnnD05g+13Hjt4SMOGs+JZQ1OlHGJwBo0yStYyFDCx7/AtYUzCZyE9u2rohDKVcTQdeHE66ayAOjgeEBxRozisw/RH5aX8DeSJTy7XFGkcq7TS1jmfMW59j3xcEOC6zq9t0GC+x8cVi2Mv/G5T9UdLQTEuZB8RTvJVu8yCza5u2ZAt+PBkuJEK+i19eJcKc/nMJ0lPvBSKMJKoRs1azJTqfeWSZUdzY4vaeF13U3/8tG4W1r9j8QYaNJt3VpLNZTnp8TCQ3fbGaBya1caBkjni4SJXiBl6HaSEo8V022qTQmXgrB5ksOpAPSp7vPRO2iJXZxGt64UcoGIwrSdMNm3LkQDbuwdCBeoMCfyAn7Y5kIlDVv+jCg6KQGIc5MGe/iviGCoXLnKkVJQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(26005)(186003)(44832011)(66946007)(66556008)(41300700001)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(31686004)(38100700002)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU9sRWxQWHFtb2t4cjBuTjIxajhqaGtuNU1xNkFBbW5tTjRFaUJ3V2dCOERh?=
 =?utf-8?B?Q1RWUFYvbFVmTUlIUG1QTkJ5aEorR1VxUUVXOTlHbFB0UkxoWTk3d28zVjhM?=
 =?utf-8?B?bmJNaTZVd1RNRUVTd1l2YXRtbXRNZ0NQUCtxdG5HdVZ4Q2pyVlNIQkRkY3cx?=
 =?utf-8?B?S3ZGOC9VVkIrQ3ZqTTQzdEdZaGZRS1l6TW9LWW9xV1NhenhkOGR1Vnl2ZkJp?=
 =?utf-8?B?NmtMTDVxeU9TdG1lVFlacmpXRnJjaTdhQzIyMUxMQ3dWeWY2eFIxK05NczAx?=
 =?utf-8?B?RmJ0dGNmWDBXc0lxWSs3UE85MXhsUW4zaFpUQzlyR20vUloyWnJYUVJNeHRa?=
 =?utf-8?B?bDhYM0orWnNGcEc0aDBSa0tXY3pNN3NvV0xpRGtvWHdHekhOd3habkw3aW1x?=
 =?utf-8?B?SmtDMDZYTUJndERQVHQ5T2d1OXlIYnIwOVZWTUN1VVIwWm1GRklRVG81WWNG?=
 =?utf-8?B?a3pOM2ZlaTZySlpBejNGM3ByOVR6bUxRZExuaTd2THJxYWR5TXZ6a241OEMr?=
 =?utf-8?B?N0tEU0tJQ0tCTjZmOUJGRi9VREJNR3dWN0NuanBIcGNZNEJzakMvRkRlSUVH?=
 =?utf-8?B?UXVkcjVYWGdvbVBtZ1pCUFlmVXF1K0RlcWJjUjlzblVsZk02YXJwMG5jeitI?=
 =?utf-8?B?bUlOZHBsTEF4aTdMOU1RVjB2dm1kcVZtWTR2YmxucmQ1WnZMdzRQNnFZSVdJ?=
 =?utf-8?B?LzhmU25ZYUJqSTZaQlNXOE1MSmt3VDVnWEcrb1VIVTZqQ3lEU0tuaGhUNFRV?=
 =?utf-8?B?QlVXYzNVb3Boc3hvTC9WSnBIVzE0S2ZoWFNJbFhwWnNLNXkxUmR0RWlqdmFz?=
 =?utf-8?B?SkRidWpZUHRaY0gxaUFUUmpGZHRnaUc5T0VIaXhOZnhrSjR4a01hSmtRRW05?=
 =?utf-8?B?OFhtL2JWVEUrdUdxUlNSbStXQ1hjZmdDdDJQcUlHaTU3NUltTk1sNFRMTGc5?=
 =?utf-8?B?S3pBekEvSjlkTEo4SGJadU1tZndyYnU4L1lYdEtmL1U1MEZndmRSQmp5K1dN?=
 =?utf-8?B?MEdHeW5kV0hiUnFINDdNUFJBOEo2dWo5TFg3dFR1VUtOc1RkTWpkZkF5blN0?=
 =?utf-8?B?bjZCRVVQb3BCMFB5eVQvS2RXWXIyaWVzaVZRTFhCUXY3TGtXMnB3NEZKZzVn?=
 =?utf-8?B?TWRJaGVyWG5xSkpwVlE2Ujcva1haekE0bjNuaG4xamY3NnF1MCszc0hMMHpM?=
 =?utf-8?B?NDBMMHBlTUJlWVdQQStwYUtSUDhqUkRWTzJmbE5yeU5HaGs1NXloRTVVMlBs?=
 =?utf-8?B?SEtUS05pck4zVXZRRFZIYkNnQTJodHJOVVZyS0FRd1h1clUzMHJCK3paWWtS?=
 =?utf-8?B?M3E2ZjFLdmFkQ1dmUEVmcDRtTExEYXhyQVBZOEpaalBBcVVreWlvWFNtMEdl?=
 =?utf-8?B?OUNVNjBFZDY1M2Rra3FqSnErWktsYkdjZC9iZmtuYTZjTUdhT25NNHdLaEZM?=
 =?utf-8?B?MjdVS1ZzNko5VWxNNDB0cURwZ21PVUF0b0kydnl3djVWL1F4Zk1PTzVyTnd4?=
 =?utf-8?B?UjcvZkJrbWxKY044LzhiQStlUkt3RDB1SkpRaDMrUS9Md1FVcjlaZ2Nka0tM?=
 =?utf-8?B?ckZ5Y3g3eGtWOXh3Yno0SXcxYzJKcEZqOVo3eUdMK21pZDBOa3phRi9KeWhJ?=
 =?utf-8?B?Wm80RHV4SDFvRjUxdy9JWjdPcDR5VGdabkdWbnNpb0cyQVNodFJsOVU1L2JR?=
 =?utf-8?B?eXBzaGNXdFJuRjdsSS9ZR3FMby9BNTg1dVJjYlZuQzlhWnlJb2g0OEsxbkgr?=
 =?utf-8?B?aFBYV3hVaDZiUjlxUitvdk9PaW1ETmczRDdYdzhGT01NSXJZVWdmY25oSndx?=
 =?utf-8?B?VUZydllTLytXRis4VDZaTUpTRzJtSDY0MUNaQnlpT0orMWdndnk1eTg5b01k?=
 =?utf-8?B?NDhmMkFKcFVaM3lsZXZFWGd5dHVaMko0WXZmeXhlQXg0QnNyYkI1Nk16d3Rt?=
 =?utf-8?B?cGZhc2xsUkFhcVd4K3JFUEtrNTV5K3QreEhSakJOYXFvR3Q0RFdEZGNSY0x0?=
 =?utf-8?B?cjFvR215TTZNRzhrUDQrMnh0N25lN0ppVXFDRzRaMERwem84UjFiY1NSM0Fz?=
 =?utf-8?B?VE1oYWlXWG1aWkx2dFNPamFlTUQ2YmJETEJpV3dBNzZTWHQvTCtHb0xEa1Qv?=
 =?utf-8?Q?RAYsxeFPrbpcs9fTjk2hYcW8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd169328-a7ab-4416-1624-08db91943f4f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:03:31.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmfgQirw9B+bUMqzwwjD4aghDoXYf3YcyjuGxvpaEYw/dGFjt609qcOFD5TJCHDfWjjgjHViKM4EpYkg/g8OYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On 7/28/2023 8:16 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:08AM +0000, Vasant Hegde wrote:
>> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
>> introduced a variable struct iommu_device.max_pasids to track max
>> PASIDS supported by each IOMMU.
>>
>> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
>> to set max PASIDs per device (see __iommu_probe_device()).
>>
>> Also remove unused global 'amd_iommu_max_pasid' variable.
>>
>> Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
>> max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
>> as system can continue to work with 16-bit PASID.
> 
>>  		pasmax = iommu->features & FEATURE_PASID_MASK;
>>  		pasmax >>= FEATURE_PASID_SHIFT;
>> -		max_pasid  = (1 << (pasmax + 1)) - 1;
> 
> This can be up to (1<<32)-1
> 
>> -
>> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
>> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
> 
> So why not
> 
>    	iommu->iommu.max_pasids = min((1 << (pasmax + 1)) - 1, PASID_MAX)

Because some older chips had support upto 16bit PASID only.

Looks like I missed to cover this details in the description. I will mentioned
about below commit details in the description.

a919a018cccf ("iommu/amd: Fix logic to determine and checking max PASID"



> 
> and forget the WARN_ON?

I do have WARN_ON and then apply PASID_MASK.

-Vasant

