Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA932D0E9
	for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561985; cv=fail; b=b1dMpbwydNcU+Qe3y6tPkzXA26SIN3SNM3WhZWCXF2MROEeNiIeCf0cQ24ZwKqdkGG5cjeylL8aNRHlxD7ZlNyzWHYwAY0mvHlTrQicxymtbyl9mLolEOx8vr6pR6U5CNic+7I5EyFBatIxgykoyO9d+HP+0D/PSTwD9TfXxDQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561985; c=relaxed/simple;
	bh=h2GtNG4fUovqOorSkgKeokGkP2Zg57Ge1TlUS3W5CIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NnXLVGIn1//n+DngcOU9jL5n9Xo5b88GURThpYWQ2YJvkwQyhVJF2gGf+UufuSaRVsdtndsahmcDP4/sPfY01WNDBSbTALkf6YqwYZf4GOTBVxQpv+zzSWUzbGu9irjEuWG8ls6jyQa9y52ipI2I2PfxK3dMU8qu4kyTW0pB5no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fg+lnA5U; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fg+lnA5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ctsbp0iIIapQZ62IFLXYLfI0oLEazDdFEph/687IBwp0Ze+Z8uTP5Q1U+OO3LVV5ibCxGXsIJw0lFAEQ5fPz25YyuwkQKo4vxghqrQe3/egecxjzpJ+rOxmUul3K6ld0K9yUDwBBOLrB0WBtlxNOjsevDi0EZNSXRqt0q12ZM5VDslx9QPdV7ckMnXF256hbVn9zGfiCw5FstCgHsQcQ0GAJx0WgdjP61DE8tehUAf5zVDyRB+uQ6uYxh9ZljmltLl3tN+InAi8CBbuNGLoQiI9jcxACj8mHYSWpKVNnBYmvCtWnl5QCSsvrcTre4nCdqQQpIVBm+QJLQc2ahosoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxnuMJuS+LERCVigoLeJucbReRcozSsux6wxNms+Qto=;
 b=p6jRoT1A2GlnsGHRreAMsg+hqvZe71XyINkZguIc7qDPLSf1KkwTuKnoQ8A5PXyD0X1aWDbjI2nw7KMKL0arwM/vJrvDTNHPgNu9dFHY/cncNRbFakMZ9b5LunQMf8qPNocPrcPr//M2kk1uUX/j5vQrGBcX8mUxx3TPHtRYH99baHBaQ2q5MZSO102lNzxjRuf2G0LAyLc1V3Rez76lxL67Ni19w+jNdPgX1pBgLR3NL1y7NKNFsbWETm8Zl52q479wXojB5IUWLHG3sxIF5xVyenNA4GLu3K7G01xrefhk7aCeupHQ8rYYWg44OVpE2upUkuV90iIpZSOowRTNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxnuMJuS+LERCVigoLeJucbReRcozSsux6wxNms+Qto=;
 b=fg+lnA5U4vdSQRbXWMDRBH5fwM7DGLtlhAsJCGjiHrcIiMjXqMQgnbIjHeoIM3YKIqieqi9vJt53cQybRPw4vd5nNz5CS/28QGCcuHjf6drlHFUEGJebunyGYzFl8c4ZGX4MhEMSk0c2QYoaU8kXz/jSpRU+gLZ8anXdVxGyuh5ELMnjIIQ3pf94JeMA2wfGSy3ZipYyPldsxsLZPtRj253znf/2fAuHbP2KMoc6NG5bLkPSfcnxTxSa1Zkx/m33/HJg4XWGK073MJviRopAYhHJfe3lkBl2pb1uCh/YaAZ0yFHqDDNLLhM3Zo2vloeO02C0vuyBJdihnCleVQXF5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 07:39:39 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 07:39:39 +0000
Message-ID: <6afc3e46-489e-4741-96d5-8a2f72a8b431@nvidia.com>
Date: Wed, 24 Dec 2025 13:09:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Daniel Mentz <danielmentz@google.com>, amhetre@nvidia.com
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-7-praan@google.com>
Content-Language: en-US
Reply-To: 20251117191433.3360130-7-praan@google.com
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20251117191433.3360130-7-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b917666-f6a6-42e2-df3d-08de42bf97ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVk1ZzJJUzZOVnprMzdJc1paUDk3cGtBYzROQ0Fka1VZY09PQ1ROUEVEb3cv?=
 =?utf-8?B?V2llZnhsOEhmSlRGQ1FJT3YrNStpaVBZeDRlTm5JZnV1WmsxYjJIemh4OTQ2?=
 =?utf-8?B?dWROcjErcFhSTGVpMGl4dCs2bUxkMjFtQ1grSU4zMlpCdTZ0enFPMjdFeFFC?=
 =?utf-8?B?N2hlcG1zZUZ1TG1ZNVk0RjZiZE5yWi9TdWtRSW83aUFaMS92dXNLRU51MEUv?=
 =?utf-8?B?VGJtcXFXOS93eVc0V2pWWC83RUtJODlJdmVNSWVPMUJybEx3WDdyT3dBckQx?=
 =?utf-8?B?Sjl2WU5pdUNDUVFnUUxHUE5ya3B4TEc4QTRJamZGdHo1eEwyMW14Z3RKSE52?=
 =?utf-8?B?UVozQVFDd29lL3VOK1J2SzFRYjFBYWN4VVdYZ0ZBZVR3MTlJUG9HOVJNY0hp?=
 =?utf-8?B?OWN2L3E1emxWZmVMT2RQb0F6bkxRRzRSWFhwbFg2alV3aVdMZHRKZ1B6d0pU?=
 =?utf-8?B?RzJZczdqb1JVOGd1d3U4NTJjdUJvS2pHRm1VWnV1KzFtL21wWEE4TmZnRHZ5?=
 =?utf-8?B?VCtYbFl1b3dWMFRFZkJKN3MyTkxJMkdwRlFZbWMwMTdGelloclNUZ1E1TzBi?=
 =?utf-8?B?UDdDTmQ5SHR5Y1UyR0pNUEw0MldlMkxDb1hhR1k4ajJPeFBlSlVybXhTNGxy?=
 =?utf-8?B?cU1SZFJESGxqNnpic1Y1U1labEZ4RVorTTNIMkVacXBQQWVhRk9GZ1pCM0dJ?=
 =?utf-8?B?bElLbzExZmlnWHN3VUlzWXJhN3VJOXZsU0NWazVsam9ES3lsRG5ma3VrOWt1?=
 =?utf-8?B?eDFtSWEvMGg0SHVZc1BWR2xRWS9FRUVuYTZVeGxrZC9Ub0RzZmEvMlloWW95?=
 =?utf-8?B?OTBXb0M3VjBuRzE4R0k3ZHFWdUtDSHFHYloyLytxMVNtVUFRa3BVall6RHhj?=
 =?utf-8?B?b1VKTWRiWXhTQzZab2pnaW9LWTJJbCswUlhDdFhNcGZzRFB0eVNsRXZWcU9p?=
 =?utf-8?B?aHVZbmFrekZFeVFRVmgwNUN2cHhQWmJBbVlEbjFKZGc1TlpjYzIvQkZLK0Zp?=
 =?utf-8?B?UTZONFY4WHQ1Qk5NdzVyaS8veWVYSXpSb3FOMTZlTUNZa0IvRHN4dUt3SVJM?=
 =?utf-8?B?enNJYzBOTFlkNzVtVTIwT0Q1Y2pFTVhUeWV2dmpCWjd6dlBQQ0llaGhMeHdq?=
 =?utf-8?B?M3VnUXZlbklJaWRHYjBYNFRSaVJwNFE0NS81VGRiam5nNUNzaGZhcytFbk9W?=
 =?utf-8?B?ZkpQNmFLN1JVaUl6dTl5eHpoZEVMZkdNOE1jKzBXTk93NTNCRzZldkluTDk0?=
 =?utf-8?B?U2Z4ZnVpYzhxZm1LN21IR3pDdHZCc1VQaFNadGZtYnRYV2hRMVRhNmQrZ210?=
 =?utf-8?B?MDk1YzZlVVNERkQ2eXlaTk4yS25yRHhGNGJ6eFRiMUNxdWdxZkFaMWpIcnE4?=
 =?utf-8?B?NC84UzRIa2JFcmFNVy9JdWNMR1N1dERxOXIvWnVXVXlDc1YxRGNPYTJlZkQ0?=
 =?utf-8?B?ZlBtYjBQSUZaM3Y4dlh6WEZBWkc3TTRTSVpmR1ZFUXZVTWtYdnlmdUk0OWZZ?=
 =?utf-8?B?YWU2Z2dJUlZEVC9JdkJnU3k4dGg1disxcks4NUJiaEFzd2FrRXprUWVWUDNH?=
 =?utf-8?B?Z3JJazFXQzY0SmNVeGhoaGRwcjRmclYwUWYvV1ljVGZ3TDN0UXpoWmRvQUNj?=
 =?utf-8?B?NlRNUEw2ZEkvNHJIM1ZjZDlmZ1JXdUNMY0NqQ0FTK3d6M2MrTmdGc1doa1hG?=
 =?utf-8?B?WWlRamZXQ2V0VmwyaUlNbnE1TGNnWEhieE4vdWJRQ1FNSVUwRHUwRTVveHF1?=
 =?utf-8?B?ZDZXbUR6ajU0Q3JIVW5SNGJXbFhUWnVZb1oyQVphRGJpd1NrRHpEZGJZaTd5?=
 =?utf-8?B?bkdvRDJ0SzNUaVFPelhlazJpaWN6NXNpTndNVXN1ZUVUQm5qc0hmRXc0c0pU?=
 =?utf-8?B?eW9XN0dudkNwMUNMTUNXY05zZ21sQTNqR0x4NmJIdVpqcnFxSVc0d0FCYmgx?=
 =?utf-8?Q?XQw1A400luJ3kM49PegEZg3kcVU3NfXQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhpb0MvWWJZbEFkN2RRMDVMSm9ra2cwbWNUdm5XVndscDdjNXgvb04vVkJq?=
 =?utf-8?B?S1ZDYytxTkhUQ2c0Q3RzSE1BSm9ScndEWU9LRjZ3NGpxeC9vR3lKd2lLdVdQ?=
 =?utf-8?B?YWEycVBlcVY2T1dZTmR1WlBYZVJpcW1UZ1FsRU9HMFViQ0NzYVdRM2NVbkZr?=
 =?utf-8?B?a2w1WVIzeFJXSjBDTU1ReUFiWm1waWFhWFBFU3c5b2pXN05TZm1obW9PWllN?=
 =?utf-8?B?bjBUQnlIK01aN2g3QitvYnZRZFBOaDhFRGh3ZTVTYVJMYnRxSmFNMVllNXU3?=
 =?utf-8?B?OVBjWEdDcHFxRTVyWDNZcVJFbWpwYStaZ3JUQ1hoU0FXUTZxM1QxaWIramNw?=
 =?utf-8?B?MjJCZUg1QmdNcHkrUWI3YU5BWlovdkNBK0JrRXBqVGtGRFptUWhucFhzV3BH?=
 =?utf-8?B?UVoyaVB4WXlRdmFyT2t2MVVkU0thWTRuOTZpbkc5RnIzOWVqTWVPaHRHQU1O?=
 =?utf-8?B?dHRCaFRkbkVXUkl3bkRySHl1dkRMaWpKUkN1c29TWjZkZjlxalhYL29UL3hp?=
 =?utf-8?B?b0Q1Qm5RcXEwM29xajlGb0tuM09iZ1ZldUZEV3VSTW9FRXNGWFhFNlBlanFH?=
 =?utf-8?B?WjBLOGtiNWRnc3NiYU1GWDh0OEIzbi9oNkZRZUhoOG1iL0ZYS0FhY1U4RjVo?=
 =?utf-8?B?REhPVEZ6U01qTmJDdTZWNmlPZ0tVSUI2SVFyMFNyYmZQOGVzaEphVVYxSktP?=
 =?utf-8?B?SG9nTFRyNFNPUk42R01SVmhlVWd6R0dXSHg1M2xkbS85TFhyODN6M1NUQzl1?=
 =?utf-8?B?bjJVM1BIdUhrbjdOcnRTdHppMnJpZzd0MWd1b0FScjJpVkdGaGhpUzFSdGtv?=
 =?utf-8?B?SDhOVFFjbVFUbjJRQndmbXFJR0p6VWY0eUE2dEhkVDV6akUzbFJpQ1AycjVt?=
 =?utf-8?B?Q1o1T0wwQmQ4cHJReU0zUjJXWjRoc3hYWndnL1owVFl0OG9qQ2ZnY1lJMHR4?=
 =?utf-8?B?VEh4OE16RU12WGZ4OU1NbEMxMHpiZm03c1hJNTEyN1RNYVVtSkhpTml3SStz?=
 =?utf-8?B?ZGx6c3BCdWtleEtEMHdBVnI1dlhvUGd6QzM3SXBpajRqU2xwQXBIVkdvWlBu?=
 =?utf-8?B?UStVaGUvVHUxaVdBL0p0OTViUjltZGllMXdDR0tTRWc1UmpUNlNNeXVlU1RM?=
 =?utf-8?B?T0dQVlhiRVgzandVZGhCbzNzdDdudHRZVkZCbmp5bjE5VnpuajNFcmJmZmUy?=
 =?utf-8?B?N1NUdyt2MVNKQU15bWExdCtwcWVqeUNnM2Qxdng4NnU1eDRkMU51Ky9hSkd4?=
 =?utf-8?B?K3BpV0NHbjJPdHVIUW1KeFFKZFhtRWRycW1yUGlsNlN0V1hNVnk5U1lsbjNs?=
 =?utf-8?B?emQ0OU43TEYxa1ZSeDN2WVk3eE1mVlhTS1Brek9iL291NUtJRTFZbm1QREk5?=
 =?utf-8?B?OUlRRW1wSUFkSVZKck5ldkNWb0lCeUk2WjJtdjNLQ2dEcEpwSDlIUEtoZzdJ?=
 =?utf-8?B?L2pleGovVk4rcVE0RXcvMmVmSTZhZWIwY2NjdG5ETSt0amRBTDE4dnkwRmdG?=
 =?utf-8?B?amZ0UEV5NzRrUGExdTF2djgwaXl0UlBMNEpBN25qR00waFp5RjBOcHVXNTM2?=
 =?utf-8?B?YWYycjJyV2tQZm9rV3IvVm1rNFNxc09EbGtiWmRYY3cwMGlVS0FxaldmSDd5?=
 =?utf-8?B?NlMyNE1ZRlFjQXd3RCs2cFdrZzlYQjN6MisvcDFnMDMvaEVFemN5ZUx4dEtO?=
 =?utf-8?B?ZXpGa1hwaW9qeURrYlVpcXRTQ3FVQXNQeGYrNmpqZVEwWUw5VkFzbnpqWGpa?=
 =?utf-8?B?S1h4UklKdG12NnUyenRvYjgrTzFqa2hQbm94bGJ1NXFjazZ3VmRhWEVGMHZj?=
 =?utf-8?B?Y3BqckpDZXREZG9PL3RaSjg0NjIwd25TOTZnVVlFcVdKa2NYMmJzVldIemVE?=
 =?utf-8?B?VlFJd0dKNlc3eStEa0xkL2pJWWsyUENSVk0vVG4yeWU5RllBZlltMzA0cldU?=
 =?utf-8?B?SjhGVzhqSWtDajZDY3NjR0NxOTZlNExJN3RuK2pVQkRxM3JFRk9KVDYvb3Zz?=
 =?utf-8?B?Z29OL09XNWxWMk1SOXF0dFJtNnAzOXBpWXJQSzI3UllnNW90V1lubDBFM0oz?=
 =?utf-8?B?Q2tmamkyZWJNMlp1T0psSVIwaG1YN1RBemVHUFNRdXU0MnVFckNyQmtCNitv?=
 =?utf-8?B?WU4wUmFKRElZb1AzNWVEb202cDArRk1BSnpDYW5nK0JMWWY2WEpmMjEvd3Bu?=
 =?utf-8?B?cjFXUlZ1KzArVFloeFVMRDJKMXlDQW9oNEVLRzJyQTgzWmZPL1Vvbi9nS3VX?=
 =?utf-8?B?Q05iei9yTTFqTlA3ekdkU1F4L3VVV2QyT0wxelBUSk81dHZIQm0wMUFzaHR6?=
 =?utf-8?B?VmFkZjVKd0RtcmFKKzZtTW1wT1p0NjBqaU0wMFViSDAvUGVKVjk3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b917666-f6a6-42e2-df3d-08de42bf97ef
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 07:39:39.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABKVw94hRznQNkFJldwK08nBns+0v+JNF3tNGwD4L2qABkxcPvV086pAigtlpFg2hLLGXH0QoIP9M89NohGRnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597



On 11/18/2025 12:44 AM, Pranjal Shrivastava wrote:
> Implement pm_runtime and system sleep ops for arm-smmu-v3.
>
> The suspend callback configures the SMMU to abort new transactions,
> disables the main translation unit and then drains the command queue
> to ensure completion of any in-flight commands.
>
> The resume callback restores the MSI configuration and performs a full
> device reset via `arm_smmu_device_reset` to bring the SMMU back to an
> operational state. The MSIs are cached during the msi_write and are
> restored during the resume operation by using the helper.
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   3 +
>   2 files changed, 112 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d6e75d1646d6..44875c526183 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>   #include <linux/pci.h>
>   #include <linux/pci-ats.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/string_choices.h>
>   #include <kunit/visibility.h>
>   #include <uapi/linux/iommufd.h>
> @@ -108,6 +109,33 @@ static const char * const event_class_str[] = {
>   
>   static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>   
> +/* Runtime PM helpers */
> +__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_resume_and_get(smmu->dev);
> +		if (ret < 0) {
> +			dev_err(smmu->dev, "Failed to resume device: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_put_autosuspend(smmu->dev);
> +		if (ret < 0)
> +			dev_err(smmu->dev, "Failed to suspend device: %d\n", ret);
> +	}
> +}
> +
>   static void parse_driver_options(struct arm_smmu_device *smmu)
>   {
>   	int i = 0;
> @@ -5005,6 +5033,86 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   	arm_smmu_device_disable(smmu);
>   }
>   
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	int timeout = ARM_SMMU_SUSPEND_TIMEOUT_US;
> +	u32 enables;
> +	int ret;
> +
> +	/* Try to suspend the device, wait for in-flight submissions */
> +	do {
> +		if (atomic_cmpxchg(&smmu->nr_cmdq_users, 1, 0) == 1)
> +			break;
> +
> +		udelay(1);
> +	} while (--timeout);
> +
> +	if (!timeout) {
> +		dev_warn(smmu->dev, "SMMU in use, aborting suspend\n");
> +		return -EAGAIN;
> +	}
> +
> +	/* Abort all transactions before disable to avoid spurious bypass */
> +	arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> +
> +	/* Disable the SMMU via CR0.EN and all queues except CMDQ */
> +	enables = CR0_CMDQEN;
> +	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
> +	if (ret) {
> +		dev_err(smmu->dev, "Timed-out while disabling smmu\n");
> +		atomic_set(&smmu->nr_cmdq_users, 1);
> +		return ret;
> +	}
> +
> +	/*
> +	 * At this point the SMMU is completely disabled and won't access
> +	 * any translation/config structures, even speculative accesses
> +	 * aren't performed as per the IHI0070 spec (section 6.3.9.6).
> +	 */
> +
> +	/* Wait for the CMDQs to be drained to flush any pending commands */
> +	ret = arm_smmu_drain_queues(smmu);
> +	if (ret)
> +		dev_err(smmu->dev, "Draining queues timed-out..forcing suspend\n");
> +
> +	/* Disable everything */
> +	arm_smmu_device_disable(smmu);
> +	dev_dbg(dev, "Suspended smmu\n");
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "Resuming device\n");
> +
> +	/* Re-configure MSIs */
> +	arm_smmu_resume_msis(smmu);
> +
> +	/*
> +	 * The reset will re-initialize all the base addresses, queues,
> +	 * prod and cons maintained within struct arm_smmu_device as well as
> +	 * re-enable the interrupts.
> +	 */
> +	ret = arm_smmu_device_reset(smmu);
> +
> +	if (ret)
> +		dev_err(dev, "Failed to reset during resume operation: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
> +			   arm_smmu_runtime_resume, NULL)
> +};
> +

Hi Pranjal, Nic,

I tested these patches on Tegra264 with CMDQV enabled and 16 vcmdqs
assigned to guest. I found an issue in resume path of CMDQV.
In tegra241_cmdqv_hw_reset() function, the PROD and CONS pointers for
VCMDQs are being set to 0 on resume. Because of this, commands from
VCMDQs we not being consumed post resume and I got CMD_SYNC timeouts.
We need to restore the prod and cons indices for VCMDQs on resume.
This is similar to what is done for SMMU's physical CMDQ.
Also, current implementation uses pm_runtime_force_suspend/resume()
which requires runtime PM to be enabled, but runtime PM is only enabled
when dev->pm_domain exists. I had to use dedicated system sleep callbacks
that directly call arm_smmu_runtime_suspend/resume(), bypassing the runtime
PM dependency to get suspend/resume working on Tegra264.

I got it working by making following changes on top of your series and
validated that after resume all commands are being consumed and SMMU clients
are working fine:


 From 8ead50a7e2fbdfa30fbe2c927c47a440b447c864 Mon Sep 17 00:00:00 2001
From: Ashish Mhetre<amhetre@nvidia.com>
Date: Tue, 23 Dec 2025 08:42:31 +0000
Subject: [PATCH] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
X-NVConfidentiality: public

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Signed-off-by: Ashish Mhetre<amhetre@nvidia.com>
---
  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 378104cd395e..00ec684fe3a4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -483,6 +483,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)

         /* Configure and enable VCMDQ */
         writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+       writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+       writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));

         ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
         if (ret) {
--
2.25.1

 From 51a11812bb40d341e11233129a01ce248957bd25 Mon Sep 17 00:00:00 2001
From: Ashish Mhetre <amhetre@nvidia.com>
Date: Tue, 23 Dec 2025 09:30:04 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Fix system suspend/resume when 
runtime PM
  is not enabled
X-NVConfidentiality: public The current implementation uses 
pm_runtime_force_suspend() and
pm_runtime_force_resume() as system sleep callbacks. These generic PM
helpers are designed to bridge runtime PM with system sleep by forcing
the device through the runtime PM path.
However, these helpers only work correctly when runtime PM is enabled
for the device. In arm_smmu_device_probe(), runtime PM is conditionally
enabled:
     if (dev->pm_domain) {
         pm_runtime_set_active(dev);
         pm_runtime_enable(dev);
     }
On platforms where the SMMU does not have an associated power domain,
pm_runtime_enable() is never called. As a result, when the system
enters suspend, pm_runtime_force_suspend() effectively becomes a
no-op, it does not invoke arm_smmu_runtime_suspend(), leaving the
SMMU hardware in an undefined state during system sleep. Fix this by 
introducing dedicated system sleep callbacks
(arm_smmu_pm_suspend/resume) that directly invoke the existing runtime
suspend/resume functions. This ensures the SMMU is properly suspended
and resumed during system sleep, regardless of whether runtime PM is
enabled.
The pm_runtime_suspended() check ensures we don't double-suspend the
device if it was already suspended via runtime PM during normal
operation. Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++--
  1 file changed, 18 insertions(+), 2 deletions(-)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b1c9c733ed8d..4707adc63d86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5180,9 +5180,35 @@ static int __maybe_unused 
arm_smmu_runtime_resume(struct device *dev)
         return ret;
  }
+static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
+{
+       if (pm_runtime_suspended(dev))
+               return 0;
+
+       return arm_smmu_runtime_resume(dev);
+}
+
+static int __maybe_unused arm_smmu_pm_suspend(struct device *dev)
+{
+       if (pm_runtime_suspended(dev))
+               return 0;
+
+       return arm_smmu_runtime_suspend(dev);
+}
+
  static const struct dev_pm_ops arm_smmu_pm_ops = {
-       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-                               pm_runtime_force_resume)
+       SET_SYSTEM_SLEEP_PM_OPS(arm_smmu_pm_suspend,
+                               arm_smmu_pm_resume)
         SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
                            arm_smmu_runtime_resume, NULL)
  };
--
2.25.1




Please see if these changes make sense and squash to the series if they do.

>   static const struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v3", },
>   	{ },
> @@ -5021,6 +5129,7 @@ static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
>   		.name			= "arm-smmu-v3",
>   		.of_match_table		= arm_smmu_of_match,
> +		.pm                     = &arm_smmu_pm_ops,
>   		.suppress_bind_attrs	= true,
>   	},
>   	.probe	= arm_smmu_device_probe,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 924580610ce0..eefa5853033c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -503,11 +503,14 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   
>   /* High-level queue structures */
>   #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
> +#define ARM_SMMU_SUSPEND_TIMEOUT_US	100	/* 100us! */
>   #define ARM_SMMU_POLL_SPIN_COUNT	10
>   
>   #define MSI_IOVA_BASE			0x8000000
>   #define MSI_IOVA_LENGTH			0x100000
>   
> +#define RPM_AUTOSUSPEND_DELAY_MS	15
> +
>   enum pri_resp {
>   	PRI_RESP_DENY = 0,
>   	PRI_RESP_FAIL = 1,

