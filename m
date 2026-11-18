Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027833;
	b=sTtskqyg2Jnk7MSuvouKje3xA+y1yIS6uUPYkQaBtdBToEYni+jBDlcQc25VQu9yET4h
	 JVcqdFx80q//MEpI7qoeqZv3OkOcRX2+bE+JAAVVY1RhCOEn6nn+lRtHFsy0d/m6iC7tI
	 +rnlUM9Sh4WhOnP84MEj4ZyD7wCxhBszAyPXsPSt2BZ+0j2gJVS+LKpSFrBTK5/w+xWz4
	 EscsuhBIaeAFfXNiu5hnkssspzVQXlWp8zxuDfvxsLhzFC8DmPvK4F1tefIu1bVFNpG5L
	 nh8BxWlpL2lQglCmiA7cAKUEB5uDey1NqUb0qRyS4te5wfnDP/a5XILQvy08WmpCU6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IytfHhpYkbABm1W3RboUx7Sq3ywg1sdenypzRazfjU0=;
	b=5NvKTvWUPP69lPhDdJYi/vAtFatUN51j9p2JbA9N2BQzBwAobe/rr7N8Y5T82DoSmRcA
	 MnoGrD0GHETOq1W9jOaUtpyJtiUBHtfYmbhV+xQaMXGLkYcrSIPwyXZnPzc6VWd0oZ35K
	 399SooVh8YzZDLME/RZ2Vg1l9+WgxAQgf29oLx5ptLugm5B/4OQnrCJ+8N1hVI6G9majq
	 57030oXBoX8Nm+KwbWI+7EJbTGA8DSw4Mx7EMFXrl670EP4IUgvL6xRl3RzaeiOPrkimn
	 eqTYHwYNgyXBo81WuvYfeX1PU9OUpjeiHO2BLfCDq89QZvETomzVx3vczl6b3+r4ZRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cvJXM+kI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0984606A337
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 18:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0984606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cvJXM+kI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCwFPeh6lTJF5o43vkW3X5YiPtoDuQkyJVY/3KSoba1gZN59lPq7SAHCv+94NOiG743ZBUB7a1LGTRyxA4O+sggbzl/zk264AKhTUZTF95qNS3cMPQrMNmwRcyWED+Lj1gV4Ptnhl9DOoO78XZaC7+iSjmqaZDKLcfCZulmN0Ms3vXuEtFHqLiGDsv7UtJl2B5BzLl9CiusOfA76PdEtFqUYGQmaDwaR4aIYErrkvN+ogV068sC6icG5cOTdKFSlBLdzi4A2CDfWcTWEfdoqqWKAfgAsy6XRGsjlMLAzh5Ui7PU8ammDHMhKlKoI7alOHcdU5l3luR9EMyJO98JNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IytfHhpYkbABm1W3RboUx7Sq3ywg1sdenypzRazfjU0=;
 b=kG/tyeGktI2I7AXBRKFwzQoFvGlsGnjyUTuQP7BiVKVUXh+zN/cfmblJlX8o2GXFVZLAVtp4fqVp13QLU2EuLv18/NXeQGXBKDcOd3Ha4Ib3zXwv+uVskET/ZNUNNLhz22wjnibpa+HgM9uPENsnA7af/TiFROWlBte/8wKN4RdkmcKVMeQfZmEUXyIxaPJUwC7JkjYyDw2B/l0kRLMwZpTsUJSo+YZTH7GkiBCIz4I7yvVESqSRxYylXdf5bOBuDWs8qi3UZ3D9428/zz5We6krXrDAwuJ8Dkl9S7MNoQAxjcA7NwLcAIVOc4ISnqjnr+5KDu5J4GTymm5I7mMW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IytfHhpYkbABm1W3RboUx7Sq3ywg1sdenypzRazfjU0=;
 b=cvJXM+kIl13FpTy8NsWskOcgEx+mRz6dktaXTZmFu4oHLRTXL2qw4JP3flTo78eWZZo/zFHtqpytTB6amhCT3z4ery5GldJmb1CfnY2IeRZtGK02p94CEMDf18xcsZCLA22gZuRS0cUz60HOTqPMC/3IMcSy1PFsufvWkeeEvJa+BWp0rwc5PUrVGI+g8vfZBMYTT4rUoo6JMxUFb3gvn6dEt2p4pTwGi6B/S94+PJPg5mpFv5s99E/1ZmPUTvF+9B6xOquRhXvOEQE/3+wctCobJRVR1QxTM04Ir8ivD/ho94rVUTcLbFYDx+hrlkSOa92ctl0akgq7qQ7CGTvIdg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9192.namprd12.prod.outlook.com
 (2603:10b6:a03:55d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 18:50:27 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:50:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] iommu/amd: Enable PerfOpt automatically for
 integrated GPUs
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev
In-Reply-To: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
References: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
Date: Wed, 18 Nov 2026 14:50:22 -0400
Message-Id: <179502782208.3845434.3028303849229899926.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: b4652c8b-68c7-4dc0-e25b-08df45a4ceeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261102130727099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|56012099006|11063799006|10067099003|18002099003|22082099003|261009223027099003|6133799003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	Y9rBuaC4i+1JjIb0gE0Rsf+JaWEwJ/AwSzzHg8ANzeZFG9BXW2076ez4NKfYX7CVqpoDhf2y/XUmQFuulv2jNEpq3oUItv8RWtlNDF2PDAhzPH7K5wBgjL1nygQKU+MIaU786nAq3816wfJc5JS4XTJFMpudqcrlbhKejbFgsa+3Xv85ZLLzrk0mU8RpMHm2OZOhs/49CD/d+cikbxKGaMNOfvp3+X9eaNlTsFkdfdd1gK/N5tlkbWkZyoHPLRMnK1s/vEOCq8Cmk4XWdmCIepLOezXkbNuNoLeW+Ad8yAik8wYTjzSK10zzHv1cSM36ig+qu8UuPCXbHbDua2ksSUlsTze/g98q3EMMoy0nBy/uPNTx2EdFvNxcFKIsliGHAwdUfLRurK/9mP9fUqWjqk7s0+LnAJtNgFnBIpyp4oF+5dkAAjNdFf+t4OJ11e/zKDD94d0wvfz5VlNJsmn4w8LmNzIGqtKRzwfhPW6AA2IcYtsfKpUBibqHLFkj2AkznFrNUOvpKPBGP9via+pVE4HKTrUkor6q7OLWv+2VM+l7ScE6yLlaNESPr8dZQvs6EmIPCmZ7y258Mc5ZpKm63525zkh6r4/XefQnPRTmd54rjhViYbIVvsTTnHUNZORKFaBQkVwarJSXJgkN7Voe67w5aAqtFmIx0VdWMF6yvjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102130727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(261009223027099003)(6133799003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajN5SUR0WXZnT1U3U2tmQ3ZORmR3VjZKWlV3b2h3dTRNa3JHTFRrSVNPRENy?=
 =?utf-8?B?cTQwMEJqaEIyVGR3QURCejZrUER5VjZGQ3U0ZUY1aWtRSG8ydGY2ZjllMkND?=
 =?utf-8?B?NkVWWFZXeHRhSzRJVmhUT09sbTliR01VQkYwVW5vdXBtMElodG5USDdKcnFM?=
 =?utf-8?B?VEc3NEpuVlRGd2FTQjh5UnpHZnYyV1dTZXo5Ly9tTU9RWXBjanJ1dHFnb250?=
 =?utf-8?B?b2RhaW04eExDMEZCaVd6SGpub3RZbWlvd1hjRFp2L2VXZThCS1lxR3QwOXdo?=
 =?utf-8?B?ZE1LSkI1RkZIZ3FrbVNpNXg5azRYcWFCcEZXaHp3QzMwNk9hM21kanpvb25I?=
 =?utf-8?B?OFlMTzF5eThVSTVlTnJTWG1CNkQveElueGFIWDhWc25WOThxWWRxSVdScXBk?=
 =?utf-8?B?NVJ2L1BzRFQvN1F5blVKaExXOWQzWTZPalZSSW9zU3NyKzJGTEdiczZaZ1pu?=
 =?utf-8?B?NXpBL0Z4M3JLZmJLeHFyT2N4elBhdkpacFNsR0xNRkluN2hnR1VCUU9ZZGhM?=
 =?utf-8?B?V2F0U0ZtNkpiUm5xMVFkekpJYkEyY3QzTXVBMFNOSi82V0VKczdmR1B0YmMw?=
 =?utf-8?B?UW1YaE5ZYWNuc0pZSUc0d2Z2RUN2OUppSVNDN29IVDNzSkllM0txemxBcUEr?=
 =?utf-8?B?dVNSOWlMNXhYZHpsM1BJSEwwMmcyS1R2VW1QYXJTcHpnNkZHSmlUaGt2MHVI?=
 =?utf-8?B?QzdrTktGS05ZMUNtdHdFelVlS3VCcG9LZWMzSlpVVmtPYzlEM3czNnVhVmdT?=
 =?utf-8?B?cm00d1kzZ1F4YTc2RFMxNFh3aEw3QVNJVWtodGpBUE1TcjRnT0M1Q0JOYVl0?=
 =?utf-8?B?L293a25qSHlQNUNjSXNqVjMxY3RxcXM3L2owa2pIekZYblFMNDNncHdFNFNZ?=
 =?utf-8?B?Qjd0QXJQWjV0Y096T21jS0tTbEhicEo3bk8vcUhmazhRUExpNTh2bGdDTWNv?=
 =?utf-8?B?bGFhOHBNWlYwZ2FCYmwyRFRQa3Z3WTltY2RYbGI1T0c1a2k3YWhzOWpNL2V0?=
 =?utf-8?B?SkxETDBJWE42bkRvcFdmcU1jd3c1WUpCNE5qMHB0ZnpZWTl2NjhTZFNVcmIy?=
 =?utf-8?B?Sm16WUNZVDl5S2dPOEV1dld1dnZXNXhQdHo3QkI4MFRqaWhQZlhGaUVqS3d3?=
 =?utf-8?B?eWV1azc4a3FlUHdhaVRERkVhRGpNVHQ3OUxCRWgxRWt5bVZyT3FWZDNhVFBX?=
 =?utf-8?B?VXliWURMYVZXaC9WcHl2azZmeWcwTFdlMWQ0MFJTL0RHYVFFZFBaTkJDL1RO?=
 =?utf-8?B?K2NiQXFqSlpHVmsxa28xeldFUUtOYUJlcmxQbUFmZ0t6L25yU0w4dXU1dnA2?=
 =?utf-8?B?N1NtTCtmLy9JdXNkOUdHL2J4alpJY1gvYXd3Q2hrUnhvK29TUTVXRGN3b3JU?=
 =?utf-8?B?UU9xbEc4clJOMlZIc2RKd2FpN29kQ01jOUV4Q3dDOCtweVRoWGV5QlpKZkpK?=
 =?utf-8?B?a09QMngzcmIyYy9SSlFxL3Jnbm5ESWZvN2FreGZuOWdSK2hsbENhUnRGQnc2?=
 =?utf-8?B?SEIvamt1WW16ZkxCRk1iSkFhZHRTVy9oSFEwaWRkS0dkSlNNam5nS0syeFI0?=
 =?utf-8?B?bUtUNDFqd0tlUWgxeis1Slp5YTVrRGREZkVmY0JVODJWVzdLZTN0UzZqU2JQ?=
 =?utf-8?B?cFdZUEc2SlhHL3A2TDRPSndXRWNKTmcyYStZdWlLZkVTMzVpbUpielVkQnN3?=
 =?utf-8?B?QUVhelA2cmU0YVdyektYalhqOEdVZlhNV0pOOXNyenNqNzFJMU5XUVI4OWt0?=
 =?utf-8?B?QVc0SDVKV2tadzV1bE4zV1ZJL3p2UWhUc3d2ODZVTXZIWmRiRUJpQ21LK3JP?=
 =?utf-8?B?WFJBbVQzSkFCZkFiTDEyUTk4aERXLzlnazUyMkJNM0RLR1JSZXpyVkkyR2d5?=
 =?utf-8?B?MU9BNXFGN0hBMnJYWWgydUQ5VzdhNDNoV3hLQ1BBajNzUWRnTUx1TXlobTZH?=
 =?utf-8?B?bDExMzJCb0lWSDF2aXRvd1RpOUgvUVBaZ3pOcTFUdTQ0K04zRHRXWThJUEFT?=
 =?utf-8?B?UUhJb01xVTA3anlndDdYQWtkeDNjWS9ISmtoSG03aU5HZGRvSE1PUkRSWGtP?=
 =?utf-8?B?aVZUZjY5V1hnZUdEaWQ3VFNjL3AwelVrdEVEQ0ZkdGpBUjg4ejFWdEZEbzlt?=
 =?utf-8?B?aW9PL3hZWUc0RWpDZE9hSzVQb1ZkcElLWGlDTy9mcGp4OFNQNzZqZ25TQkNk?=
 =?utf-8?B?eEx3WWVwOXkzZldXMzZLRGx5VmlNd3EvRTUyQzlERTBPb3hIVkhmdGJKeFFD?=
 =?utf-8?B?aGZuSU5sbFQ2VkdXc04ydWovVC84TTN0OHFXU1NucmNEbkZ2Z29HL2V1disz?=
 =?utf-8?Q?9DHn8ww3SbSw3KmBoD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4652c8b-68c7-4dc0-e25b-08df45a4ceeb
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:50:26.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpM0ZyAAFYUvvP51mHngQXtzEMcSsBLPv/hi1L6xIb1YrIQDCalRSLQkRwUOZHtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

> PerfOpt is usable by integrated GPUs in identity mode. Enable it from
> the IOMMU driver's domain attachment paths instead of requiring an
> amdgpu policy knob and exported enable/disable interfaces.
> 
> Mark supported integrated GPUs as PerfOpt-eligible when selecting their
> default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
> these identity attachments, then enable PerfOpt after installing the DTE.
> Clear PerfOpt before attaching an eligible GPU to a translated or blocked
> domain, including unmanaged domains used by VFIO. Propagate failures to
> clear bypass, but keep a completed identity attachment successful if the
> optional PerfOpt enable fails.
> 
> Clear inherited PerfOpt state during initialization, including when a crash
> kernel reuses device tables. Read feature support directly from hardware
> because cached features may not be available yet, and stop initialization
> if the initial clear fails.
> 
> Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
> boolean under the IOMMU lock. Preserve this state while clearing hardware
> at suspend and shutdown, and restore the bit on resume only where it was
> active. Do not enable PerfOpt unconditionally during early IOMMU
> initialization.
> 
> Remove the amdgpu parameter, driver callbacks, and exported interfaces.
> Translated attachments retain their normal device capability setup.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> Changes in v5:
>  * Enable PerfOpt after identity attachment instead of during early IOMMU init
>  * Clear PerfOpt before translated or blocked attachments, allowing VFIO use
>  * Drop require_direct and retain normal capability setup for translated domains
>  * Replace refcounting with a per-IOMMU activation boolean protected by its lock
>  * Clear inherited PerfOpt during init, including crash-kernel device-table reuse
>  * Read hardware feature support before cached features are available and fail
>    initialization if the initial clear fails
>  * Preserve activation across suspend and restore it on resume only if active
>  * Keep identity attachment successful if optional PerfOpt enablement fails
>  * Link to v4: https://lore.kernel.org/linux-iommu/20261001182410.1525285-1-superm1@kernel.org/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
>  drivers/iommu/amd/amd_iommu.h              |   3 +-
>  drivers/iommu/amd/amd_iommu_types.h        |   6 +-
>  drivers/iommu/amd/init.c                   |  91 ++++++-----
>  drivers/iommu/amd/iommu.c                  | 252 +++++------------------------
>  include/linux/amd-iommu.h                  |  11 --
>  8 files changed, 95 insertions(+), 331 deletions(-)

Vasant are you going to pick this up? It seems good to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
