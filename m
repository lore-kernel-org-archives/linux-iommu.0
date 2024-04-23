Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874013CA85
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893529; cv=fail; b=iYJKoYYnPq2zoaXL330aKmNO+L6OV4McehH+HvCdet1QyUvhhpxh+s+XABg9IVmmJuDN/QcfWS2HhFHsXYfnbUgnEvpyKfPsqW7H4mGTLyHLIBvwnu4Sj/awT6l2wYqrQttYP2UWpYiGcG11czl363xB418XnVm4tvxSzjJXdcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893529; c=relaxed/simple;
	bh=zjCvgZSSECl13ABfH1gQmqazadxUARPefPNyyEl1UgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W8FFSD2bifElN763XPHGyHHk34G2e8gMijEAaGwSi3LNkgYzOmGRnivT7oRdeXsV2KJ7bpBYzyVqu13Wh+5aS72JvuwLc9toy15wAOOFNHlph8PxMabBBry24sHB8UPzlz/P1EioaN0RGoSY4+dcyAK6IfteD4waAMmds7VACp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fHtMch74; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fHtMch74"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkr+1OyP4dk1mvyb+MH2RJsJ7jEAk7Tq7vVJGqZF+sWmJfR5jMVuwfWds5WrHHRPFrDSKw44F2r+Wp/iBMJ6+bwfkqvo9GYN8CP9+kIuPd49wPGvmmaCQt/RlKbJ+gHf+e6XCRKzlto0otKgJUxd4gOrXoXh6L+Yuj3GTDzoJKI/xV06CE7dhxtJYkyBzPPhOD0KYY2OVhRVa+2Tks6xx5AkWGh/QFZsTutQIThLzca1ZWrf9Uk40C5QvOV8ll5EOgp9JR/mgRjA6UTxBIedrSflXTBIKn7rX1bpiufUgoz5MjqdYPayQ9hVMlzYh6lAF0gDYUI2ZiO0gzgjs3K1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbW6UMjyMWq4C//eFuhqgh/bh6P5TgAz6PZ8bOwobLM=;
 b=eZgknSi0oV44ciFYGgyvhu5g3/KSehi3VFtJjxY47235YjMo8b2XihevIvAZCGeQYa7EbK81HyKZCx1qNprdyP0PbItFEBLcOXaDqKKmKBqJXwjMRjdLvDiUZvWAGWs46RgxYWixI0/XH+lA3Ahj3sbNoE2WIo/Da5jCGmognJQfLjFJi5V0UYIGgGSud2jT7gOzl7aan5V7ZMua10+YZdgCjPPHxrVxcdjbzzxQNmp3O0aISU0vNaNqMcyQrx0oNjnCPDsYMwy1XSl48TmMknI4C21wT38VrEG+vcrCmcVCFApjpljQQ93/F0gdPmXbwYQ2A+qF9kOBSDaAXqDkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbW6UMjyMWq4C//eFuhqgh/bh6P5TgAz6PZ8bOwobLM=;
 b=fHtMch74Pc2VGOUKh52d4jY+XapLRJ6FI+/oZCrp/q1za8rw6sVYTBVohP7Msa/aGt3WPtf947jowee8Focea72jxroT7aZr4WNJGJooS8ZKQX7XuK5p3eoA8F6caykPp+yy0bKvFPQffXIcaT3ryg97SspEfRJuexxs1j755KMW8BtdH4DkLxC6BCZexgQW0b5n3FeyA3AYZOIwo7A6IltHni0ZI3sbeNUi1LVVHGcNw9MOx332hyRIUr2cbRuMJS6CBLk+VyUgTYtTunMQ817ofIKxzwld4FqqIevKzduHTNP2M7+ayR4UtvdvEzi6ASvh2iOBXuP6k/qf8Akw2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:32:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 17:32:03 +0000
Date: Tue, 23 Apr 2024 14:32:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20240423173202.GB941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
 <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
X-ClientProxiedBy: SN7PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:806:121::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cca08d4-d5e6-483f-ce32-08dc63bb4a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REFlNXllb00xTDl5alFKNlhIMnJuY3RmS0tUZHdKN1VNd2Q3UWVjRHIrNDAz?=
 =?utf-8?B?MzZ5OWhvVFA4MmVVaHE0QWlpMUJSQ1NoWTNONmRtOWlUZTZyVXE4ajZFU0Zo?=
 =?utf-8?B?eFBpL2NwZUUvT0JOQXJxVi9RL1lpcU9WSG5tS21xT3JnQm10aHhHdmtpWlE4?=
 =?utf-8?B?a2lld3FPYzR6KzBrM3FDZlNOR0tKSE9GeThUMDFlUmdUY2IxdTFJZER3Mys2?=
 =?utf-8?B?NmVoTmk5LzlUZldFTXZSL1Z4UW04NkN2eWpHV20xTXJQWW1ZNk11cFlRNUsr?=
 =?utf-8?B?NndQOUdiQk56dzgydlhXbHlIMU1VcjVZdGFYOVIrK0RIeVFWZEZTOGdvMVFI?=
 =?utf-8?B?THBTeVBXRjk4d2hBb3paZi85K1ZQeFdkeU02MVA2ODZhM3hBOEFCV1NYdmdw?=
 =?utf-8?B?bXJBcFptVTJHRm0yMzRXMFgwZVhBUEVnUTZJV0FBZjlMYldaTDhVQXoxV2RE?=
 =?utf-8?B?ZXlRZmo2WnN3NnZzZFdwQXNncDc2aU1IRGVsbXQ5eUpLdVovenl3TFRQVVNW?=
 =?utf-8?B?T1ZkaUdzVWVYMkQ5Kzk1WTBVUVZTMG44UjQvMmlOSHhxVDk0eWdTeG5vbTJH?=
 =?utf-8?B?SGVkbW1jWUUvdmdnZWVZaGJ1WGRack9MTjRmeDdpZ2tIT1FTYk82c0ZPbUJl?=
 =?utf-8?B?RW9lMmhLNGtYQkxZM21YWVhPU2k4MVA3dzZXSmlnaWtLckZhUEt1UnhEU25K?=
 =?utf-8?B?RGFmOThIN1M0RG9aZU5DdDdCSi91YzkwSnptYm80QzhZVW42UEJqZGNHYWZz?=
 =?utf-8?B?ek9OdklZR2szM2pvWWJEN2w2dFhvVWM5dWp5YjRZVk1PQUFjMW9OUjhnSGFi?=
 =?utf-8?B?WmcvcjdjY1N1WWNsQlp2UDQvNmhKZ1NRZ2lkdXZGL2w0Umd2Zy9jM0g1UVlQ?=
 =?utf-8?B?dUdLOWQzOU1lMkJJcmM2Rk5OaHAyb05HMlBING5KcXIvQnczOVh5T1JGK1Qy?=
 =?utf-8?B?b0dueUg0SkdERmd0R1pPMFJGVCtVMUsvdmoxQlIrMi94ODdOZkx6a3d2YTVG?=
 =?utf-8?B?R29qYkVFNmNwTEhZeDZmZmtJUFRTdFBXRDVwRENtRldZcTkrWlJORHRJcWVy?=
 =?utf-8?B?ZzMvWThOWElTd2JvMVZva29Tc3h3TzJTT1FCQUR6U3hPR1lLUXo1SFpDaXFM?=
 =?utf-8?B?UmYrNEs0anhZY1ZoTk15WnFJajBYdkowZEJidEJnV3huQ2d3RzRuMWtEQW5D?=
 =?utf-8?B?eDlBWTZHaVZFL2lGUDZxSXZqZW0vblBPeEpyemFtR1ZyeUNmdWl0U1R2UFRQ?=
 =?utf-8?B?MzBmd0prM0RIWEErWWVwWDM4bzdLWmpkakRIVE5oZmlEZDdBMHhvQXkxWU5x?=
 =?utf-8?B?aVMyUU0rNG05Q3U4QkgxYStSOGZqOWFIckNyREVpcUNkTVR5Q0xDekNJUnlJ?=
 =?utf-8?B?Zk5yQjBNdExIYnBpZG5WeHZDR3RYMWpHS01VZnltQjQwcFd6NnB0NFh3YkR4?=
 =?utf-8?B?aUlXVUo1TG1aR2hhQTAyeHlxV0laWEpkWTJvQWlwRjRnZDZMa3U4cTNRUEMr?=
 =?utf-8?B?RXQ1VXJiS1VvZXpEYWtHQTBBNW9WZTVYK2hZbytiUEZpVXNxUTRkRFpwMHNT?=
 =?utf-8?B?bVR2RXdWVTE1bEdyY1VBS3h0bVc4cFY2bUNoOWJveFJFTytkSlVaeGJWeTds?=
 =?utf-8?B?SmVLcHRZbkZWZm1JQ0xOZTd2ZGJtTldib054R2I4RnhxaURQNTc0R244NjhO?=
 =?utf-8?B?YVRza1BOWkVEYzVhRzhtNXhjY3lmVlh0SjBzNlAyRHhEYUdNSlRONm5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNQS3JkSTRNVTJBTllCZU0xTkxBZWszajBGVUlJTFptdWNWN2ZGRndzelZ5?=
 =?utf-8?B?RWtjclBqNFZGbWFtWkw0M2trOTFHcTRjb05vWHl3QjRHUFd3dlNCUFlYNnY2?=
 =?utf-8?B?OS9pRFRJam41eElQd3ZXNjZPd1VSU2lESXo1Y254V0RDQ3lZYVVZTXJ6RGdV?=
 =?utf-8?B?NlRMWE1EdXoyTW1EYVhLZEdDMHJjWU45WkpvRkI3bk1xUkQwMGwrbm5qMEFa?=
 =?utf-8?B?aUJTYTdMcVBTYzV3dHlWZmNVUUdVWFM3TmdjbzFKYmswUEI3dVd0VnJXZDhL?=
 =?utf-8?B?T2FLNW9PbnFMTU1pZ1QwYjNlb2xDQ0ZOWFlVTW56ektUK0FqUElyazBRMFZK?=
 =?utf-8?B?UjdkS3Byd0U3RDIzWHZLbVFpZmd3eEx3TDNvNlRrM3U4OXA5c2RlVWRRcE9W?=
 =?utf-8?B?aFFkTTZuL0I5Zk5rZmdwenVUcTJxUG5tQU91bjhzUklBU0pIVnhVVnRvcnNS?=
 =?utf-8?B?YURwemVqSGpPd3YrMXpwMjN0SGh2MHlwL0dmVkFmYXpwWUxuTklZcU01bzhH?=
 =?utf-8?B?T3VKRkJOcnkzMnB0K1FXYWxGWGc1YlNQK05ySlFqblU3TFA4aVBpRkpUcTdT?=
 =?utf-8?B?NVBhQ254MzVXQklpNkxqL0V5RWltNXlzTlNRRXVDYlJJeENTUVJ0OFFlWWs2?=
 =?utf-8?B?OTlxUytqOW51Z3NTNElRNU1MVVFNeHBPTHhpeHIvNi8zTDBvUmUrZ3lnNUQy?=
 =?utf-8?B?SU5XRkNFRjVLOEQxdHZFMk5nRzhUd2tyaklOWjZEMTBNV3paTlUza1JWVjRl?=
 =?utf-8?B?NWl3SVZuTmRvOExMaDQyYWM0a0tKV1ZvNzIyWStTRVo1blFyamdnQ2R5L0Jl?=
 =?utf-8?B?RFlpbkh5ckttLzRabjNlMzhrak5iWHB5ZzZtOC81Y3R3K1FyOTBYSGZkTkNv?=
 =?utf-8?B?UG01NVNRWm0rQ0w0SW03NFZIN2kyTHczMGYwcitXTEltSHVxL01XZnFnd0s1?=
 =?utf-8?B?NmtzS200UGZ1cFBlc2lVTEFjTGduejRtUlRzRVpWZDhIc2gzOFJJemUxeEt6?=
 =?utf-8?B?TERBck1QZXVnOGlsK1ZCR3lITnpIM2krU2h3YWIyUDFtUlM4bk1Ba0lkdFdu?=
 =?utf-8?B?Q0pWSEt6Nld3c2lPSFRMeTZzTlZUK3I5K1VKaW5CRUxVYWNlS3hSWDJLK242?=
 =?utf-8?B?MTUxdUtxbEpYb3duZi91UzBxSGtyYnU0b2VIdm81TFUzMkVYQ3lHRG5wODZa?=
 =?utf-8?B?cXNyYVpOUkcxa2ZhTDZjbW5Hcnpyam9TS2tYNnVEYzBxbXZFeWlYc29GUjBp?=
 =?utf-8?B?YjRlNmFZbk5zNjB3eS9qWEMrSHB5a0tRUkVDYm80M1F4ZkFYMGtEdWdQc1Nr?=
 =?utf-8?B?MStjTWRqeGhEMVZUeDE4OFlIVFVGRVZwbHdYQVlhMitHQzU3Wm9hbCtLclJa?=
 =?utf-8?B?RjY3a0t6U2daQ1pteENDY2pHRFpKanZBNnM4ZDFJZEJoS0Y1UE9lYWtFd0E0?=
 =?utf-8?B?bjRxRDRiN0RYU2VwNktaVzM5V3JQMEsxRm8wT3RKZVFRa0tScW14SW05NzhJ?=
 =?utf-8?B?M3BFSmFUYkF4Z0pXUUNGdXcycHo1UlpoSkhPdVdOeVAwbTNXOXlwR2NhTnU2?=
 =?utf-8?B?S2hOZ091QXBWb0hIemZQNHFFbmJjZnB1bXU4cExYYkI4L0w0eW0yd2grRG9o?=
 =?utf-8?B?dTRVd3FORXlpY2pXUGpHL1plVFpxRW9JRDYrN1B3Z3JFTU9vR01KS3Y0cXpr?=
 =?utf-8?B?OTJNaDBiQkVTTVdjaURZYnZHcGFUQ0o3REQ0WEt6SjZib1JXUFVSWEE4Um5r?=
 =?utf-8?B?UkNjR3lGOXpoZTNFVDFROXBTSlNGU2hSalNCQndPN1J4T1VtWjBGcUJmdG80?=
 =?utf-8?B?VEp5UXNZSjBRVThsRmF1ZVdXcDVSclR2dHZ1dHU2Y0tTcy9tOFd6M3FQLzJY?=
 =?utf-8?B?OTE1NXpOTDhhOXhNSnowUkd2eXE1NGZPZVBSckF4OTJBQlljRVRubi9MRlRy?=
 =?utf-8?B?VnhUaGJlVzRuRWorNE9hZlRaWnB2WWRLbDJqc3R5cnc0K25tdUhwNU1EVU16?=
 =?utf-8?B?Tm9YVXZXbm0zMjVhY1p4WjlUZHNJcjN5MVNlak04WHB1YjBseTIvWmpBdzVT?=
 =?utf-8?B?VzVFc2hiM1FMT2QwTU9GZXk2NUo4emZQZW1qeWZGY2J2ajNFWlhCS3MxdmJQ?=
 =?utf-8?Q?g3m4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cca08d4-d5e6-483f-ce32-08dc63bb4a55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:32:03.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4fasVRfipOo1WkPYfCAuBvPs41LdeA/RTMpV+s70lMNZL9jUP24a6zuUQWyyWIf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531

On Tue, Apr 23, 2024 at 05:45:16PM +0100, Ryan Roberts wrote:
> On 22/02/2024 09:49, Shameer Kolothum wrote:
> > From: Kunkun Jiang <jiangkunkun@huawei.com>
> > 
> > If io-pgtable quirk flag indicates support for hardware update of
> > dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
> > bit in the page descriptor.
> > 
> > And now report the dirty page tracking capability of SMMUv3.
> > 
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Section 3.13 of the spec states: "Where translation tables are shared between
> CDs that contain the same ASID (within a translation regime), the CD HA and HD
> fields must be identical."
> 
> I don't think the way that smmu domains work, its possible to end up with a
> single pgtable shared between multiple CDs? 

It is possible. iommufd can link a single hwpt -> iommu_domain ->
smmu_domain to many different RIDs and to different PASIDs each with
their own CD.

> So the driver should be able to guarantee this constraint is met?

It is expected to be done by this:

> > @@ -1271,6 +1271,12 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
> >  		CTXDESC_CD_0_ASET |
> >  		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->asid)
> >  		);
> > +
> > +	/* To enable dirty flag update, set both Access flag and dirty state update */
> > +	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
> > +		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA |
> > +					       CTXDESC_CD_0_TCR_HD);
> > +

This function is the only place that programs the ASID into a CD entry
for the domain, and it always derives the HA/HD bits in the same way
from some immutable value stored in the iommu_domain structure.

Jason
