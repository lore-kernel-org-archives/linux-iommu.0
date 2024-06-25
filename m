Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09449629
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329272; cv=fail; b=cpLarYUm1/58RUphRzTBFpPGwFTlzyYH7Xbz0EEYaVFOO0bIIIZN+0dmXnFwVY+z35M6OyAox3gmLx4z3tZJCwdHUAM1CXnux3KjLVIc2vmslUekUJbX7HH87TVvljfjw7UW7ytZDqxDe/asf1dR7YzzZJqLMFe63BqysvtIiaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329272; c=relaxed/simple;
	bh=uMexkAHY0ZSdqFQJY3oevxSIxbktNjAdh/QsRbNk7yk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EAAbTGx4Rt2xYRu5RT/mKGhei2Eit/EWxZDZBOsCAUo3CW0BIRWW2KuJEI0LPwvXJ3I1rXAz9FJ5iDD1tCP9RLFpN6ho8rR+/x7FINNrM4TEYzk0oO/I2ciDCBxh8M/QY8Tik/tEgg06uxjrFNGM7cOjCWACRvv6mjUNMpMlIN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SMQTlgR3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O4zViW5h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SMQTlgR3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O4zViW5h"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3XlB021031;
	Tue, 25 Jun 2024 15:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+tZyqjzV0W4g2JDsD5q2fM736wzuERh8EN1T8uduMsg=; b=
	SMQTlgR3pMfZRSwqtb74XWcN1MR5ncZQHmCOlyLC1LUD3IduPSRDYdOe/AuEQHlh
	FTxBIPI2dUy2yVsWwypKd5tXT/UhyKoaxkGAT2FNPKpg8+971cjBt7+sMuctHKY5
	Au5Ma8hHRlAqk6jr3YPpFjCU6Yo9PBvndmJ3a7VQGCzR3besvSf70CAw2GWWYOLj
	SA0pIqBgqf5Z/Tru4DyUE4xGWQXMG/0Qnt5tPqmpdhikARIdDsQlbdh17l3Vv4Qo
	K9QBBw9UUB7goIEzz93WpXeDRc/7H6+GArL6IG9u2qQNAgtvXq2khUgVFyW8HVfp
	46XUBb4iY0Q6SWGy9J0yag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb132j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 15:27:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PFPoxq023314;
	Tue, 25 Jun 2024 15:27:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2e8agt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 15:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrRvoKN4ARYcJzeR161YKlxaAUw+djcZM2nDocvMI12lbAyD6iEJYZywWSgoRpQGv9+KMlchcVZ6YdUGFb2EizuqiPLjJnI3hKgP0Q4O0Nk8F0bIBN/kuhvMy5cTVLDVNHwBBxBSIccpo2NofEkmAFOtLzzX+6JBF0Sz5lGlDq5Sg7Qy2IXQ4v36b5NJAnakobHRlGXW/waHnFSPwQub4Axo+liLnvppIKC3WnUEb001KGk4OUeqpRcQLzDH4JX6ny9WEHznhFygeq3GjviheHrTFDGLpAUE0hdjildsUXewrehnYmZvtlClApMeoLlMlAckkhrieIbY1ZRBU4mKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tZyqjzV0W4g2JDsD5q2fM736wzuERh8EN1T8uduMsg=;
 b=MRHjJvHHXqaAk0UqBTGPJYQZo4Np3AgCvb9XaiL3W6uwv95B5g3v9GAEzeULWor88p6rbiFs9TIj2cogd3hYG/U12tgPxXsze8k1WbMry6JElqrMRdKcCMKnlHhIv/N0mZk3DYtkq7qh4I2Sinr+upLNcfc2iNIsfupmE0N+RSqKWfpSA+f3u8uwTjWtCj7GgzkQ5u/ziKUC1KhWj7bXfVLlPpRv+kmsmXHhqYDRoLREZNsjuxXYEc+gbYeBop1czc7/Vh007D5mAf3oS9qa7O8GFzPQpvwUFrvu0kpPn4KB3QK6JEsDTcht02FiRnICNojWMfeTuhHeDs3udETkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tZyqjzV0W4g2JDsD5q2fM736wzuERh8EN1T8uduMsg=;
 b=O4zViW5htqIGzFiyIe3adolWrw3HfUxuSxADtnsHcqX+tDbl8A/DRoigFfru1A5ZpNbn1JZvHq/SZRTRyi9KkUvvHxyGCmJxj92DSGpvHqWSboDJFd4AF/js33wv9ZLVPcG6P++d6j6dGvc1RRfXUDbz8lbeZunc60gjoD1hNOQ=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Tue, 25 Jun
 2024 15:27:31 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 15:27:31 +0000
Message-ID: <3f4a80a7-9e17-43e4-9bc4-c1ca056f16fd@oracle.com>
Date: Tue, 25 Jun 2024 16:27:24 +0100
Subject: Re: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
 <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
 <20240625122745.GY2494510@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240625122745.GY2494510@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: f818b44b-6baa-4740-9fd6-08dc952b547b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3JNMmZBWk1VTEhwNVNjVUZsOFdzTDVEZ0Zmb3ptVkNLZ0lXRWZrKzE2cjJV?=
 =?utf-8?B?WnlrUHZnTUZMMy83SUdNWnpmR0FNWnAyKzVtZFd3WU5lZ0NTUU5DSitCZ0l4?=
 =?utf-8?B?UVl1WjBSUTN6RjhKKytqY3N1eXVCalZDVUVuZHV5QUg0U2RCd05pM0V1RnBH?=
 =?utf-8?B?V2lIZzlhL1dWc1dIeldiRHdIdjd1V2RJaXFvVTVUU1N5SnhnTTZlT1lERklZ?=
 =?utf-8?B?NWExSmRTZ1JOVXF4OEk5THkvZ2J0dGhxcXZEV1owcFZSWXpYSmxnM1dvUzN6?=
 =?utf-8?B?SmtVRTltTE1tTnZPSHRnT0FUMXlGSkoyaWtRTjdiTnM0Yi9GMjZtWkZHTHND?=
 =?utf-8?B?OTZGUC9hbkRnV1lRMnBPOUoyYlFDZktZRzJFeUZ2ZDJrbDgxUFJuOThIY29O?=
 =?utf-8?B?eWlBUmJTcUlhZFgybDkxVVRoWEZvcDNWMUJMcGZ0NWsvT0lJbXB2V2ZDeXVz?=
 =?utf-8?B?Z0FMejJMaHB1NG5qNVRFVU1adWtoQkpCMVM3bjNQeHJySTA1OUVnQTFvZWN3?=
 =?utf-8?B?M2NSNWtqZHRkSGJsZHBTOGxCcWdJUFd4WEFDZ2dkamRGR1hDRFk0aG9oZ1kv?=
 =?utf-8?B?R1phVnhvZGp6S2NkWGlHYWp0M3laZnFjWWkrcE5mb1pzZXZUczdLOFhXc3dR?=
 =?utf-8?B?WDhkWTh5YzBuNmxQMnZQa1IydCt2Ni9xWmFabjk0NTFMdkUyR2o3RVYxR0Nh?=
 =?utf-8?B?Q01qU0pIbEl2dzc4MWlIUWlxZWdWWitBZ29EMlNCenltMUJKWENEL1hhWE5B?=
 =?utf-8?B?N1lOUXRMSmJsMmJFRFZHL1N5cDVZdkJSTDNMZS9SczVPd3F0eTM1T1NVTGlC?=
 =?utf-8?B?Y3BscXFqL1RObVZJbW9odkFXMFJPKzJKOWpKWDNGbmhNTUkwdHZIeE5JOS90?=
 =?utf-8?B?ZDdBWWpvSHowVnZ3eFh6d05qcG5wSW84S2RiNmNrQVlMWFcySUhPZy9XNW5Z?=
 =?utf-8?B?NEhsMGhKRmFlZ3Roak9vZktUS09JbXhlOGZuOGFTcGZiWm4raExLMWdPM21j?=
 =?utf-8?B?Q0Q5ODBmTnYvR0JLVlljOHhQdHZUUTQzbXBDU0tVd1NMRHpXcWlYN3NXaERo?=
 =?utf-8?B?Yjl4MUF1OXA0c0ZtMitJV3J5dk9hZkkvV2NxeWdNYkNxWDUrb2NpVDJSajd0?=
 =?utf-8?B?UTVVSnU4UTJ2c1JYQWxNK2RkdTM5MEdKRWxETjFaTEY5UWdBL2UxcHQ1b2lV?=
 =?utf-8?B?bHZoMVF1SmxRTGJJdEFUbWkxYk5JWWkvTnBLS216WHVoNEpjaWRGU1BQcUFt?=
 =?utf-8?B?V1A5ekozbUlwWXBNb0IySS9CVEpRTjFHOWZMNTBSdEZUMExXV3NuR3YxWWRl?=
 =?utf-8?B?NXNlR1VYSVQzcUNneHZtV29BSGJnWnF5TkpWTmhqVjJlQitpQm1QQTJUekdq?=
 =?utf-8?B?NXhESE1teW9zKzVaOWQ3YlBLdS9yTXZVM3hFTk5lNGd5VlYxalNWeGloM0Zj?=
 =?utf-8?B?RWt4U09HTmQ1V09QZXJXWWNGZDJSbDJUZ1BFdnFVSkFJaHZXMmFTSVRwcEtL?=
 =?utf-8?B?YlhwL0MyLzMyMWpaK0liSEhxSW9PdWJCQ3BQdGMzanJxVmdLQnlNckY1ak94?=
 =?utf-8?B?K0ZiSVh3YVNBV1BKd0U2TDcxUnBRcGRHWGpYWkF6VWlxT3cwSklJeXdmaWVK?=
 =?utf-8?B?aVhtSkxyZWFZSHhkUjV3dHQydVJkSGpZV2FMMzNGWmNFUFE3ay94Q09RUk5T?=
 =?utf-8?Q?Fkr6TCsfzpsvLPoQoeJs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5876.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlVqblJlQ1M4dUFOR3dFS1FvcnNlUTRrMFBJclVvZDI5NmlHRVVvcVZncWx3?=
 =?utf-8?B?RGRaTS9TaEFxZlZTUnFmL2N1RmVRL0ZlaWFYTE82cUZpYStYNTNrRzJmWUtG?=
 =?utf-8?B?R1h4OEJwQ0d0VXRWSTBjRm5BRDdES1huYmFvSHVsa2lwNFFUNG9tbyt4NU44?=
 =?utf-8?B?SzIvM2dkYnFubFdKeFVMRUdmUVpzakhQMnhvcXVpeVF2QUZSbEE0YmV6YTZr?=
 =?utf-8?B?VE1PMWdpQldxbHJwek4wdDVpWVE3OFFGdE82OVlzZm1BRjhVT1ZWajZFZ0J2?=
 =?utf-8?B?WW9LNnVXVk9TMjhGR3FXSDdkclBYeWhwM0RnbDYvbVBsTTBqaXJKTUNwbnJ3?=
 =?utf-8?B?WDdqcGJ6eTdLZFh0bFZOYlh0cXp5TWRtU21VeXpzaXlpZjFyWERjOXNDRlFM?=
 =?utf-8?B?NFJDcHpVdDIyenhVWXBrKzdpSWFkRitHeEFxMm16Z2x2SWIwOXdRWU9HbzZS?=
 =?utf-8?B?WXhHR0hMZEVkbkhEbGQ4NlZWNXkxU1RnZEs2MlZxM0JtcndtYStVblRLRzdO?=
 =?utf-8?B?bzVVVHJwMW9wNmcxdWpvOTEvZmZWSmN3ajVHTkJmQ2ozY3VJYTNQTDcwTUI5?=
 =?utf-8?B?OThCdk5WeTNXTnZvNzA0N3FaTCtleTVRRXdSVGxWV0NJRjdRME5qdTRWOHNI?=
 =?utf-8?B?L2NISXJxV0paTTNNYlJKV2VoZ09aQ2c4L2s1THBiT1Q1MmQybWF4UkFyTzgz?=
 =?utf-8?B?eWpsK2xacklzZkNqaW1HK2xEWmcrcXh3SFFuMUtPSFYvUWI1K211ZHp1d2lu?=
 =?utf-8?B?dCtpV3JoVXF5bjQrUVh3czhSTDlvTGd0SnJuRG1IWUVydWg0NE1HTkVFRTlI?=
 =?utf-8?B?K0RpOFdUU01Oays0TnpuMFBmOVl4WkJ5TSt4NFpyMEQ4eTlIUlFkNm8yc2R0?=
 =?utf-8?B?K2EvVllIVDUvZ2cxaDhycjZ5cE04M3h5eXViUUJKQjFUd3dRQk5QVjlydmlI?=
 =?utf-8?B?anZtejZPbnA1VXJTaEkvN1JJZFhYN1dSQnZPWG95d3dzRlI0aHIwUWdaOVUv?=
 =?utf-8?B?NkVWVTc5V3RKNU1pVGwvYUcwUU0yYzZlSE1RSzE1YjlVUm5Ta3NLQ0s1UDMw?=
 =?utf-8?B?Nmk5aDRRcGhhendvY0J6ZWVuMXcwaW54bFIxY3g3MnNNYXdvdFZOM2JmMVRB?=
 =?utf-8?B?d3B3N29YY3hDWWE2dThYampNSTh0SkpEdWNTamZNVXRYeGpya09ONTdyV0hm?=
 =?utf-8?B?dmpJYVhtQVlLTTZJSmgyU1dWc2U2RUd5emRnSWV3ZTlkY0hKZFp3Y1dUVnUw?=
 =?utf-8?B?cFVlcTRiK2c2RFJnSjE2aTBVcytkWi9sa2JwTVJMTFAzZ1ViZmEzV1BBMmsv?=
 =?utf-8?B?ellsQlZsaEZ0SlpBdnU1ZTZCdi9pKzlpZTNQYkRsWE0zc2psdGxvWjBWRmYv?=
 =?utf-8?B?QThHUG1KNFBPNDZLSC9lbFhTOW1XYlNOSFFrUmREYmtsTUswNVc1N1B1YmQy?=
 =?utf-8?B?K1RWcEYrY21RT3N6dkhBdkpDZnhTamNQOGNjWERiVGRUc2ZlVXA4d0pNNU9r?=
 =?utf-8?B?WmdzUkJLNGhXK3M0Y1p3Q0Nqd3FLV2VSRDB6NkNJdU5YSmlUeGlObXhmcFJx?=
 =?utf-8?B?K29OTGlqa0hhS3ZhWXJ2THNTYTBjc1prN00xSENoeE5Id25pUXZCR2wwcVBB?=
 =?utf-8?B?UjEvN0tjNnZpaGVrd01LYUU5NWNZL0IxL1NMM3VpeTJFSjRQdlNPYTFFTVY3?=
 =?utf-8?B?T2liM2ltL3VCQkhkczlGRlowYnhpSVdSQ2YyRWFOdFduS1pKT2luK1BSR0Fm?=
 =?utf-8?B?YnprWG9BZnRrbjFiaVFENll2ZkpCbC94QTBISXR0V0hPUnJaUzI2S28wVnZE?=
 =?utf-8?B?bEpOZ0hwZzFoY2x0bTNwVGFBbXd0MXRrQjlDS1dlWEdpZDRVZU9FVmJvSjI3?=
 =?utf-8?B?ODFrV1pZN0JJYnl1eUNXRzVRQVM4aDBvaWlQTkhHcS9ranFra0paSGpXYnlC?=
 =?utf-8?B?ck9ENEZHemJnTHhHT0ZQMkxLS2g2azZjUDRPUGZrUEo4U1V1eDBEanl2R2dr?=
 =?utf-8?B?YjRUeEN1aldoWlVPSzlDZlJyRExSQ1BvSUpaYXpNbGtPMTJ3UWIzamJDd2V2?=
 =?utf-8?B?QnJ5ZEViSjlhR3MzUE9kYjJYQld3d1ZDRFYwWTBEMTJIcVZyaUxFdGNkaDRQ?=
 =?utf-8?B?VHRhbXpmSEdHeTgyaVdVSXlGaGp6Wnc5U05ibUswZWlLbHN1ellaRnF5MnBX?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AFXslSIhk9OrGJ1RXosaf+buFxTFoYOhTU/SJP/8dX8elaQQJokbLX2w3Ojm0hmn2LCGvA27Kzfm4EFcgai0mLMgF5HejfcGzVwhXHdk28k779VqH2xA9N+sD5/pcqbofw59J9Dwc0lKXuKRe6OCofHzo1qkawwX/2dLmMyUPSHRu2Ap2ud9xFHAdbyEXf00EEyGuR36EhzE9jPM7Ac3rwf/M4l8kqqS4RQ0zr93+DCmpMr47H0BKp1rshW3cqGdtX8XJIAQVnkXh9G2XFEchsoQ2CclafGlZ/aYD4VcDMaB9x4xDD3jEldPIyd8ZjSAMNt7D1AC6tfTJaM1cykqPQUVuVGVCeByf1iga14AkFujPFLtQmgQUfYXEK26Yt+201poQyZmwnENNkiJiKD/zwkEmYwTHefklS2pXIDhL3Krt2CvhpmOaBVlNAO04kHUx/rO5zLx/he/sBQe+stllcsUdHBjgpzXRm0t1V520iQF+t53xrX6H68XAQGMJArfH8deBi5L2UJDxDHmXADNvzW8DCLYWoQSHy16jrI8EkKFYPLkhVBm/kGe/MHB+iBvIWu5QXsZPBCPBe7QfFgPcM4BGuF4K9ILUPVNpmwrP2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f818b44b-6baa-4740-9fd6-08dc952b547b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:27:31.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmlqZ0igtM3qXHYGkR3T1Q1ydzld9FsUvtP3kr8zyPOcvgA6pejS27HccPUoacarUPA9PPHyspSr14m8Ip2AP/nEuCvaXgtDErbH8yXinX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_10,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250115
X-Proofpoint-GUID: K0YKpDq1GSPIiHZ3jxrwHHpUSJcUq3Ut
X-Proofpoint-ORIG-GUID: K0YKpDq1GSPIiHZ3jxrwHHpUSJcUq3Ut

On 25/06/2024 13:27, Jason Gunthorpe wrote:
> On Tue, Jun 25, 2024 at 12:13:15PM +0100, Joao Martins wrote:
>> On 25/06/2024 04:38, Tian, Kevin wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Saturday, June 22, 2024 2:43 AM
>>>>
>>>> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
>>>> ed54f1351a9a@oracle.com/
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> missed a fixed tag?
>>
>> Technically it is:
>>
>> Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped
>> pages")
>>
>> Though I deliberately didn't add it, because we need the patch afterwards to be
>> fully fixed in iova_bitmap_for_each() callers. Not quite sure what to do in
>> these cases
> 
> Add the Fixes tag to both is better than not having the tag at all..
> 
Right -- but do I propagate that to all the dependencies? That was sort of what
I was wondering. Technically it's patches 6-10 would then get the Fixes tag.
Though perhaps I am conflating just describing what it fixes versus how it goes
into stable tree which is a separate thing that happens to be automatically done
via the Fixes tag. Part of the reason I said 'not sure what to do in these
cases'. For just classifying the commit it fixes, then I just need on this
patch. Putting on the second one was more for stable tree, and in that case it
would actually be all from 6-10 not just 10.
