Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0B414400
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000374; cv=fail; b=lASokjak9IjBQ0xgqOhXYR/C1YQtii+Qi2PgIV+dyXDBrZYeoFpuTw04L6Q4JTPJ0oSjHDK+nYHKIpJY3XGMtbCePXHG68Y6Nist/M4x7N3LdrbrfotFN77hOYlB52rWg8Es2kl39K+UjdOZJkwqeugF5Mc+YiqTCy9qvqouluI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000374; c=relaxed/simple;
	bh=wbEDvSItGvzLrFRecvmCgu7QtfA+B9sR+3/bWXYB+a8=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=LIyyRYreTxSCBulyPP0Wu3i79UcF0yRPRO/KbCgi45HItOrzniGlHviJnx9nWSI8a+EMquSWcM/d4TO8mjv/uszjDmbcn36g2ByB1CqrReu/kykRsKrUJIwvZczAYhc3zY4Sec+r+QbxTODwFVE/pqZjoXCZyPmVajKjuZ45Gno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sfuawVEY; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sfuawVEY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHkvf2xEt0mySm3+kAXhlm3IChyhZOfE8r4//JUvqGjn1N6l1Ii4P8nEF8DkM8LnPcnipFQ4OqFMlUqajeRBykwblttJUco1CUi24241Yw/XvMyicwPxKlSAh2nexsjsw5FcfgMCR6pjyFfSGKTJ7kSCu6UMlikN8RdzvoFRdEQk0SmtEdhfYvI3O2X+XmDLvJyxyznFwvgp8ALbR0HDKj40+0BLKy3rB4kU8Y1Na1CZgu7z7FgIWwHe7rRozHch0YWJjeL9g4yRa7kQl+gxKCosHSZg/1qNONWNXi+eIxg0c1cOcRlDEpF/F0DpHNNQgVxTYoyLUA4oW1kjzm1FOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r0ZoB8+yfKVtXhWGi/AzAhr/Gd3bzMJ1kVo1128BYI=;
 b=BJaSuAhbQdK2IUvi1MMw4Te33fWAEpEJdqmSlVvgZ007n+F4sx0tuSId7t5ON09ARapSvYfo7QmbsHrS5eQHkk1WTUbUc4GyqNw14rZ+4DbzN+vLiev9WLtRAWxVZvhm+rx9Xw+PLVoFa4PMm3zTo+UQyzPoQmR9Wh5yt31jHg1iQ4B3j4uwVmpiJJXY4TKBq6qoCn8u7F6rpzeDRg7pf3fR4lF4/hkJ2ze/xxO0ZoJRh2kyrCBp4/Xqtcfvq+luehynVNr4HjUdd6rSfNgz2CmZw9Lng99D9GdoAjUqrV/lHOCMgCjscGjjIkv1Gt17sVkvksZlYrH4jNoKZkbz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r0ZoB8+yfKVtXhWGi/AzAhr/Gd3bzMJ1kVo1128BYI=;
 b=sfuawVEYtW1vkYh6+EtdRLPUN8kyisBgcUExqZWzQfMqsNoQlM0QBvYVx5wPFeBB+BM3oqsAYLwtazE557jkE1tfIwNBeU2LuJ7bnozTgfbpJN/yPx4+9BHTZ8taO8sIN9A0pLUAIbE6n9HVQO8dH1fVmn74/E2KyRadx+Xz97fV8OSkskr8D3zo572vfkxznK9jSTGL+S3gyrwt1tbm8FKLtbcCal9Gq1MYrSuP+SGUW4fslaie+ajHnP/ICszAv6jaM4ci5OTHd1vT27BCkYMMrPWAU5Zo7Aq4U0UWOvDpa3lywTBWpWVN8Ad/pnEXZ7+x/ROC6N2MVb0wrGZ/LA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH0PR12MB7959.namprd12.prod.outlook.com
 (2603:10b6:510:282::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 14 Oct
 2026 17:52:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:52:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] iommufd/selftest: Check dmabuf MMIO mappings
 filled from another domain
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Shuah Khan <shuah@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261008125206.11990-3-parri.andrea@gmail.com>
References: <20261008125206.11990-1-parri.andrea@gmail.com>
 <20261008125206.11990-3-parri.andrea@gmail.com>
Date: Wed, 14 Oct 2026 14:52:45 -0300
Message-Id: <179200036595.15213.9864724554843977359.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: eb82eb0d-c862-4d3c-f7d2-08df2a1bf5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|10067099003|56012099006|18002099003|11063799006|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o+a1a1fOAdPsn33hcKDcVerizAtuHkGkZrojq9K/abab4cOe+/GktSEbyfNbtGJ0hjLY6lf/qEiaRIkuKhdBaK4++T5wdeWoZNyYq8KyWMvPW5Awj45YyNXG+dvFZcGbjPjGAuT/5UyG1rARBNeiS/HgRoQpPW+9xcUpvoF4w6au3S+/cavxwHhLFZqZmRlhdyb2lS/RC5hqSLw8IAcOtSEkAlFp4Q7mE+EsEiYPbqO1CsHspcK5l+G/8YqiwgcjNEi0B02fmt4l/F5QTQxsPzTpbhRreojO9PwVNGhLJ1LKgi7g0zBiD0bHrkJgSpykbGn8V788njC29xO2CA9JssfQiHbTkLc3Gwhrixh6cu9YxsJHxXEoku29IJ5A0xYGCiC9Y5iUZXJZcT2Ta3pTGMj8QvLhxD7ZMljX8vZquhtKWnSPAppZETx2TZOph01yZMGAH60tXNSPxVitPQ4rd2u6xZXPZvQeVpI7+Gtp1R8T4p9Dn0iBXZnCjDb5NbzQVlYgMRucbeY8AYuZqrGw51Ht1HtcCvpMvT0Z5w855lLQHqkuaREAi/66gvGCiohW8uhuXtmQfJr+av6L6W2vwNfLVElN5T5byFO/Il/aUdZZYBiMAW3hoD7+2mxJeHaU7HKEV+MRMw0y95356zDxuuZxFOtxmTAjfBsrec7ohXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(18002099003)(11063799006)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1hzSEQxSFlqR1RWM3dQcjQ1ZmlWdit0dmZ2SmduSGtnQUw5dUtLWU1MT0FH?=
 =?utf-8?B?SFNvbkNnNjNjMWkwR2xpUVk5UGZDZkRTTWgzVlQrcnRCQU5UaGIyZ09UVXZ5?=
 =?utf-8?B?T0pxVzd6MExBdStYaHl4ZnN5M1JZV0YzMjkvYmlISUo1Y1pmVGRBQnlNc1d0?=
 =?utf-8?B?VVhnS0I4VExSU1lCVGc3SVo5aUtGRGF4T25STms2cHp2Sys2NjRoTExZNkJy?=
 =?utf-8?B?NnMzanZCblZpZkh3YXhpclc4Sjl6eVg5Z3p2Q00wUUZTZ3BUeHhXc0l6dVor?=
 =?utf-8?B?bjhoN2cxN0ErcHpjdHY5b1FLTFdQai81V3d2N1c0dUtwNE9SVDdrcUJnb0Rv?=
 =?utf-8?B?WXNWYWoxemdyNUhHeEhreVdDVi9OYzdOUGM5TFJDNldXMkhicHQ5Wmo1ODAw?=
 =?utf-8?B?QjRKY3lOcjB3bU1NWGVjMGl4Sm9EL1Zhb2U5WTc4OVhjMDExRlBneTlTeUdR?=
 =?utf-8?B?WTV5OTRmL0YxSytDdnl1QXdMTXl4RHhBaEJWQlBTSHdTSHIxcTJ6dUMvODJq?=
 =?utf-8?B?ZlExUUtJbUxxbDQxU0hzN0tlV2tjK3BVS3krYVlZaWk5TFY0dWZOejhzSlU1?=
 =?utf-8?B?b0ZvOXZzUVFLUEdlZUVVRFY0MGlobFlraW1CNWhRQnZpREFsZVoySmMwQXFQ?=
 =?utf-8?B?SlZLSWI3Q3BWMlMwWitkQng2U3VCZGRzTExLb2c4bHloWjhKQkhnZXRabHg1?=
 =?utf-8?B?WTAzOExuUW9sVTlDemhMNFRvcEdRNmxWanBBV3N5NzBuZVJ3d2VSYjNGbmt2?=
 =?utf-8?B?TzYxaGlYaWtiYWFKTjd6WXlaVExMNUdVQS9vVHEyZmN4V3ZsTUJFSXZlQi92?=
 =?utf-8?B?c2duZEt1dEh5T0JINWlnNE9nZEdteTZMY0lRYUJLSkZBS2Z2Sm1sUVVNTG5Z?=
 =?utf-8?B?L0lhNHJxL1FQV0VuVWNXZEM4RGVEbFQ0MkwyTzBZd1h4U2ZXdEFCVmh0S3dF?=
 =?utf-8?B?MnVrMGwwc2kxOVJqRXV4U1dIMHp3ZFp3bHRDbmsvb1YrVTJxTFN5Z0pRRU5Y?=
 =?utf-8?B?OXlEcHgwSCthQ2RINkh5cU9oRnFEL2o3WnBqbG9LcEJ2SG1iaUNlNFQ0U2VV?=
 =?utf-8?B?aWhHbFVTWGU5V2x2dTNob3hKRXhUYVlaNzh2ZEhSNmtpWTV2OWxkWXYwb3E5?=
 =?utf-8?B?WW9Wd3ROV3dLYmhEY2FFdWxiUjk0eTdhcENXYlVPaUdpUUtha0pkbmNtRkJN?=
 =?utf-8?B?Q3VPM2J5cnpTU1ZQdWlGRWtTVXRBOFNhdG9aVUxsanlPaE4vRDM4UFdPRXE2?=
 =?utf-8?B?SnBTZ2VocFFFMjcranpOOGM3SlgvS2wxZjh4SnU4V2VpNGt6U1NjVTZjOHdY?=
 =?utf-8?B?Q3pxUW5PbUhTY3lvNzhpK2ovVXBUM1lFd2xJUGNEb1lFelRwMVFZT1hXZHNm?=
 =?utf-8?B?aUpjVEpjY1VCMlhXU0Y1YS9EdGo1MGMxOEliQzJIMU45NXNicU85T1dyRjBR?=
 =?utf-8?B?WjRyRWVNUi9ha0RpZEo1SG9KNlBoV0hBcjA4QjI5UjJwR2lFczRNUE1mV1VV?=
 =?utf-8?B?Qk5lVUFxak94bUF5WEl5dFVHbG1LYTU2T01PSTJVWXVKMGxjNHAweDNqYW4y?=
 =?utf-8?B?MmU4MzUzWDZHb3JXSjFJeTJaQWNHWTVaKzhTZzFjbmpwbm53VVl1QmRSS005?=
 =?utf-8?B?SERxZm92UjR5MFdMOW8yRStaejJTU1YydjJ4bDRiSEErZGxSaFpTWHRtQVo1?=
 =?utf-8?B?YTFaL1ZnZzlkQlZCbmtzMzY4MVJ5NjUzLzF5Qm1LUkdhMTFJYUIyd1ZOdG1J?=
 =?utf-8?B?ek5rUU91TWxaZ2doNzE2Y05qQlE5UlZzcVQ2ODVWOER1WFBqYWxWaHE2RXQr?=
 =?utf-8?B?WlpyWWJrSEZObEVBNERsTjRKNVNmMFpYaDdhLzI2b3NWWHVrK0d2QWZNdWhs?=
 =?utf-8?B?U0p1SzhZL3V2aEVxVkhBeEpqMldHZXdmL1pwejBLSkhLVk5sWkhRQmVSWFR5?=
 =?utf-8?B?N2lYK2Q5dDRWT0poY3hjTlRWcU9JeC9pSURHWEc1SEUvQkZ4Y29EbnZoSnpY?=
 =?utf-8?B?SlN6VS9IUjliNEhhUzA2QnZvL3hBWHFqQ0p1SlAxRHphUGNjMURYak5QYlhi?=
 =?utf-8?B?RFpIbUJqQUpxbWhKczVFRG11VWJ0cC9uc1phUDJaSlgrekU2cWl1SlNlMDBz?=
 =?utf-8?B?WktJcThNb1RFcEpINUU1c05tTzEzZjdnejB2SzFubTBQVTRvT00xYXNGNVZs?=
 =?utf-8?B?M1lwZEsxKzNCcGk0V2gwL0t5R1dwdTNOVG43MFVzaWx4SDEzV21qTWJUZldy?=
 =?utf-8?B?ODdJYjVhTVNZU0ZCc2ZBT205Nk9yY1p0RE9SU1BOZ0g2UjlSbGtTc0hPSVg4?=
 =?utf-8?Q?ZqpdhnyB3ui4z7WWOT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb82eb0d-c862-4d3c-f7d2-08df2a1bf5fb
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:52:49.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YletgOflagWlI3li2dp0hyZuUHB0bBkDK9GOmwEqTl6kxVPiVw3BOcthi5Zv2oAl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

> Add tests that a dmabuf keeps IOMMU_MMIO in a domain that is filled
> from an already mapped area: a second domain added to the IOAS after
> the dmabuf has been mapped, and the domain of another IOAS the dmabuf
> is copied into.
> 
> The mock page table has no memory type bits, so a mapping made with
> IOMMU_MMIO cannot be told apart from one made with IOMMU_CACHE. Wrap the
> mock's generic_pt map_range and unmap_range ops to record, per domain,
> the pages mapped with IOMMU_MMIO, and add IOMMU_TEST_OP_MD_CHECK_MMIO to
> check that a range is recorded. The check rejects ranges that wrap or
> do not fit in unsigned long.

I'm not keen on this, the special mock amd domain is just for mock
usage, we should probably just add a mmio bit if we want to do this
test.

-- 
Jason
