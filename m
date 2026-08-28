Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4E45FFC7
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927272; cv=fail; b=aCGkkGRiMgk+QxisoKVSIa8UnVt/vG7g96e2Ao7q3AWbzSc4PCIAep6AoKo4hBF2H3UZW5VtKXWf79Pl0IIOvbgcRKojEI6ooch5MrWJN4E8sBPusZ87OPU/tq1ZFyXUt5/OVtD6FU7XgvhX0UPKqhRI2CQrO90PLQlaNUYkN9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927272; c=relaxed/simple;
	bh=62ugXoML36eSf2Pp3agIb8zisg2zhpVknwMc/b0N2EE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=fl2HMWLvOERsw3mvryFkQ84eWiTFcHOEZs+lXcLhdIj2QN9bRxM/WsmjKNH4eP7UKPYzKUf76HxMKsSwRTKfJpuI3uhkYI2QH+EvQH0z3z3eHE+GBh+iH4ncAbXQebGSRYdNqd1kKczLBkNKiuj9caxGOB2YhMSvJkXQjRsR7LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCZLQOVk; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCZLQOVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtIOECAFa6CnrNTMJookasLnLoqGwFqxmZ7AATnbFYaspHbqaS4ZMtK95Hk430IbjS9xW0PBcazflbr7vqoXuZLeqRu0/Zy7LjQlHTc4E+Pm0R/CTD5afjhoE5xJWU7CicsCMpwsqMECIoSCta5HKS7oZYAVqSjIp9ad2a+DZkan3BUXqYuUS3/Nf25ssKbNyj1lQBs/Mnt+9pg9RALlo0P52uq529LPimnJXMfEhyOA0u5XV/Dla1O+UTqFMUlLI2Rd81FsU5FqlqKyQqMKVjPTN4z2IJ/byGoBZCR2tZa49rImQqZLiBiXfEcGbyyM6YzVnqnmNUlxFPgZ9bPb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNsTxVdXXQCNVjx8D5HEtN1tId9wc6VixiYnPmDzUg0=;
 b=HRr1mACzgT0xsatVZWDtG0R7fVQie0FEdmjq+SsOeiKXJGmUMkpy16KqFqaW0vLXIKkynek8eIhrzoiowGyDg0DbQIh85e3+526gR5xhk8hnRZ/l8AwQYwrVNjFjsVwsa+dsq2Dh3ZP1dBKJZgrZwPicRNp8ADwHUXP7abISJpJHomxK/PHIopWf7kFOT9sHURPwIuV2am50R2h21ySJtf0JponLEV//tMhQ47bIpCXRGtdHqPExcLpHNm5gtuBYJoxfo2ducoyubAY4+ND10k39srkGFz7Yo17ZqNes+JXGvGfSn/7jLjylhk8v+sZXgwvSiU+80FSOyuIN8szJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNsTxVdXXQCNVjx8D5HEtN1tId9wc6VixiYnPmDzUg0=;
 b=lCZLQOVkZ0rFz753Ne4XwVcyaWK3Q68MsrZ5VFJ9OsNp0L2M7HfUXv0ALI5Evv+rQcAf8sMSrvbrZOWNdjoW6k9KO7BWK1AAnRwteaGgGnVH51nsArnzzSYCYsfPKBYaX/LNiAAmpiAxo3cEe1G2F4ukQxRXNLm7ejztV/YaCL9qSoJZ4vjU1CYZFkD8NlV82pyd9dtVehd5oj7jMerYvAIMLNIBzkr1jGLduGhjj/EP3kHp/CXo+ws4+UH7XhSC0DoUgzzQm/jLM/K7DV6bStv2EMHC1ouXd6l4tc434yrvIPEq4p3G7gkcKHQDR4I5Cv4XCDOCTGEyLynNBlHgKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 14:27:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:27:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3-test: Add missing error checks
 for inv array
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260828125409.1921538-6-smostafa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-6-smostafa@google.com>
Date: Fri, 28 Aug 2026 11:27:22 -0300
Message-Id: <178792724271.3808739.15472225478426952013.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN9PR03CA0984.namprd03.prod.outlook.com
 (2603:10b6:408:109::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf0f178-6688-4344-71c6-08df05107c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nJ8XwxxZQ9kzHw1r7saAT8vG/45ATvsCTMCFqktqE6xVd7FIm7ZVovyM8S/OQQOeyr/lYhzjXmuqOyYeXhZdOstQLGISxMkHBeBiPHAOmtB00Gvy65iBmTfMC2NNrUTTsBNW3CuyG2UcwPbOSuOu3rtYCwwWy8WakrZ6rXFRBTbC7c7AvVc6KgcHY1JTEBBpTyuOKFR52NYVGwEDzZR9xcpmQVhQgonZ7kzfi+zto+AYpkIIeV/8O0xn8oFlNDtxwaSyE58UDzY8msw/TniYRvxk5FYyyDwK/9ukXkKrSvdR5HGxGus/M+/L/rs2zIOnSatVRsV3r9BIe1njEAJi4aCXO6kTUntKyCnHeEvkAZf2VSA4pOOl6sQXRA+653LiT84S49dzD8RufVciJXk5Ij+mzs9XFY0qgD3V14U3za7yttHYa7lVzYI/I94Rll2VFIGoeFFRBTnzlCjDJvA8OeZ53ssSVEPsWW8ATueUoy/ZBsXInUM3Vmo5zD6aU3gF4mkmGtlKYq9XMpSRLLY6iHTk9enenQOx+zuNvPp5MzRaPbIsUwVQmwrs8SqPfiHminrMfIeH8/YVTwJ9TbTM8o1JJzDHetnCSeV13aIqzCfHISemYnKlfNVH2RhbdNE/Ylf0V+gjRVnGgOXxmStamVsQKIaCurv3YVRvRhR4JBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWVYdUw4Q0hnS1lKeURMTmRUVUFTUnI3bkp3S1EvRUxxODR4SEpaZHV4V0xT?=
 =?utf-8?B?VVYrTHFjVmg3WXpWbndSQmlzZWR4aHR0TlVWMmNxZHJuYmJCZ2xZbnArSnRP?=
 =?utf-8?B?UllXNFpGYTVHd2N5UFhzdjJDdkJKRE1tckZKWlMvcUgwMDlPNGxlTFBac3ZO?=
 =?utf-8?B?ajJYU1ZhN3VEZ0QvVS96SkJncXFOdVpZcU1peXhQQjJhWU4yZ0xnMWNVTUhT?=
 =?utf-8?B?T3A2UElIb3JzSVVUUFZsWDRoeTJjRTB1M0c3L0NoR3pLSnNuT0cyV1phM3NU?=
 =?utf-8?B?MDVTMnZJT0EyaFEvY0l3eUJEUmRLV29uQ2pLU3ZkcmRYUVg2TlFiY2drQmZp?=
 =?utf-8?B?QXJVcFJQVEc5dXYyK1JLd1FBcndGcU5CU3kzRklRT0dqSEZtTWErUjloeHJv?=
 =?utf-8?B?R05UTGJiZ0d2NHRBd0xUTy9SRU4xQVlYU1ZsQ0U2dDhCMGtEQVdoK2toNk9u?=
 =?utf-8?B?NWM0RU52NkR5TGdWa3ovVTJkNkJYZ2pCSExEZmZFNHlJcXNYMUtRRW1YSUFT?=
 =?utf-8?B?U2oyR3lkUk1WeE5udVNqbFE3Q2tnMzF2MmFMNTEvalVyK3k4cWphSWxETWZh?=
 =?utf-8?B?WmdRb2FlTmlMWFcvMXVzNnNmaVlFRlBkS0VtQ1JwaHlkZ1BndW9ENTBmMTNo?=
 =?utf-8?B?WU5malI5U2EyVjlCRmhpWWhlYW1uUVB3QVJ0MEhqZkNNNlE3S2poNE85QUZS?=
 =?utf-8?B?dW9lZlBpeU0yYXBSUVBIaTVYdTZCNEU5STdvWjJYbDVXZU9BQzJaaGx3TFhu?=
 =?utf-8?B?VTZDeTlCd3JJMkw5V1RxV05ocmh6TmhweWVycTV5K1JBamhFNjM0dmlTaURI?=
 =?utf-8?B?cFBSNndueE9PTFFsS2dWWVFvT09reFVUR3lTUWhTOThqSmF6Ukd4NWtkaW1D?=
 =?utf-8?B?NUFzYjN5dE1YVWxTSUVMcWlsYk9ZTHRMTCtaTjdQbjRnVitQbVhJZUl0UkQx?=
 =?utf-8?B?VDV2ck8zbmZoK3FlK2M4NUV5MnlqYmNDQU1TaU5PNWE5b0tKV3BWaFN3U2hQ?=
 =?utf-8?B?K1hOVjZobFBuVTdOcWVrR3ZwVzZnV3Y0a0VnYWRNNlpKT2E2V05pUysvdTdN?=
 =?utf-8?B?a3o1Mjc3S1lmSndJZ2o4S2RpSXp0OElTd3BNQW5hR1Q5S1BRMURxOEtjVmRw?=
 =?utf-8?B?TU9jbW9MU3BlSENSVkZKaTFMMjNvRW00UVh1WGoyM3FpOWxtbTdycm1MY3Fu?=
 =?utf-8?B?UmZ6WVR3ZkxTb24yV0ZlN0k1U2hRRmJqaGorc2VBTndsd3hnTm5LRUFTVnFK?=
 =?utf-8?B?a3IvOFBMSWxIRHhpTU9aZm9OSHpjNVU4aDlhQzFUa2lhNWxSTmY1NVBTbGh4?=
 =?utf-8?B?RVNLOUdnNGNOK3pIWUlSYTREVXgvRjF6VitsdDh0dk84WVVLTzE4aEdRU2F1?=
 =?utf-8?B?YzdHSDRpemVyRHNabm42OUxvODgyWW1ReTExZHRIWS9IVGFaZ0JuVFRoOFpM?=
 =?utf-8?B?TUt1eExtem1RMlB4UkZsekRpYXgrMHlGZWQrUVFhK0RvT0dvaG42Uit5MUJ2?=
 =?utf-8?B?SlJPRkJaZVF1MnVwSmt3V2Rib3czc2pSMlRVVzVxR1Z3aGxISEdvNnFwWTN0?=
 =?utf-8?B?djBXT1hCTWVwbTk2Uk1JNTRoNjEvemVVUFNzU3h4ejV3MURuSXdJdzF4VnBW?=
 =?utf-8?B?WGlFWlpkelkvRkpuMEpSZ2hkVFUvVDdJNmJNZHRTTmM3QVdFbnBldGxhV3Rs?=
 =?utf-8?B?N3ZNSmI2cGN1RWE5ejFyL3lNZzdabTB6a3h0QzhDdDFwZ2FBZkh2Ynp2SkVT?=
 =?utf-8?B?TUxwUnNRMVQwVzlkM2MwYVNRNVpwejlvdTFOMHphVWxwK1UrTldLd1NIY1ZS?=
 =?utf-8?B?TlV2R0QxNWRBSUFpRDJTb00zVW93QWtFVVQ3eGljN3lyekQ5andleU14bk1l?=
 =?utf-8?B?ZXIraDFVSTgzNkpRRFNybTdTWVlkVkp0a0oxQythcHBnb29HOXBRK3lBL2pF?=
 =?utf-8?B?NFZrQXRMNmdERkxadFkvZm9EZ0FwT2RDOFNZV0lWVG1oYTJQVWpSa3JDcmxG?=
 =?utf-8?B?cjJ0cW5SRjVwNjU3U09ET1Y4TDZuWG5icXpkcFNydDZEZm1FUFdRY0NjbmZI?=
 =?utf-8?B?WmhvbkdnTGx4OGhxYS9nOHdiMTBacldZSWdRZHBUbHQreHY0N0xwRjRlaFAr?=
 =?utf-8?B?MmtGdy92Qy9UanJhQmxEcVRGVzRTTGpWVWdHTTZEck15YzhkY2ozQThWdXFz?=
 =?utf-8?B?eWdBZU1KbDFCd1BsUVc3WEo3RkVxUk9VeG1mbTdzMjE1enhlSXRmY3VMMmY3?=
 =?utf-8?B?VmdQSUxWajlEZVBLeTdnTjJwS2N3N21IQkdqYWF0MUNEb1pvdjQ3aHRsc3A4?=
 =?utf-8?Q?X5eGBn/q4vXnF9vOOq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf0f178-6688-4344-71c6-08df05107c06
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:27:27.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRScBQxb4zrd9DuDkSdh2P4y/iBY4uvILTOnfWlFeJuHKt1zYd/I0Ai0Z06erEwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

> arm_smmu_invs_merge() and arm_smmu_invs_alloc() can return NULL or
> errors which are checked by the driver but not the test.
> 
> Add KUNIT_ASSERT_NOT_ERR_OR_NULL() after calling them to fail the
> test instead of accessing NULL or ERR pointers.

I've generally had the opinion that if kunit tests hit bugs I don't
actually care what happens next so long as the bug is evident.. Many
tests can't clean up when they get longjump'd out like this too.

So, IDK, it is fine but I also think this is in a category that maybe
sashiko prompts should address instead somehow.

-- 
Jason
