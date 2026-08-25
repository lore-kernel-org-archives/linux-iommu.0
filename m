Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E968339372
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675781; cv=fail; b=d6leHh4MZ1X910oSEowDAq8T5rejzJsuVvIVsI3Us0w/uZgqrEQpe/HS+qZeNfNZnskEzDa257dUMkJyFdwR8vktG0yc3irhGk1JYsixMTuZpU+/KY+F9CZXWrpcIIBy959z9jX4NJ/7UidQHGVFix0+tcf62RtUGkHOmw+HR+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675781; c=relaxed/simple;
	bh=BlboQVr9cyWLnyMxOnUTR2z2V8rLZ3gfcnk2i1Wv0hk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=sO0MDg2UFHoA7ZyZ4ElxmoWRWd80iaxtPLU+x+gQOc2zSLcOUs4I67wqt4MzTJ/u8EFpdFzcQWzOHM1QTR5zmLLKzVb9Oq4fQZaSa0RYTA4Ry6kRT6YB//MxWjq8Z06I6wihe8rez/LfRVMTQ6/3p025yCOvBwPXTGEvpFUIs0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYtNK63s; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYtNK63s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCw2IX7d8fxX5tY8zrdnb93OgusciDAmQAMRWMfOkA9850rafCKpWOFEhQW2L8XhhIxTm0UbGcwnfJpJo7HhTFdrDemDVgwkJH2oskHMfNwQY5XvsBwlkblweNyGjYVxwVI7pJ8Ixtv6N8sl+7v/S7QDRG9UYhHxPVe59yTJBbqjbg3qxIgQ0ZSRZGxhgtnWc9a0GLlLo0nX2VjKOQIx2Z63lomJ57ssgDZkxcnG887DvAAyIwq7fgbEkPnPY+JWcOJvpw6NUWV+82LzLDtKnHXtx8orFdyulYwm7Kqw6IjGzrcZAPORkfSSh2R0tHanIunikjcrvDT50aZoaip8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQC/+gb/8pVjQl5/zn/RKcy0Dgn+IwOzcHQS8E2tdwM=;
 b=j8lcb46Xwd7GHqt7M/AceAfRVOi0NkCeW2LSXavoHVG643yACdah87voRkFxFdrGTcJkZZo3s88eFdXvZuiNDkY03oEEg8gO0fomnAlJGkX31OCm1h4fCRp54fS/W8GoIuG3jugSUq+2VCMdgalMLKY4EGw7VEnnm5gKw8WdQ9uEkpfYizE2z+bLk3harxQff9rN3Er542TV40r7J32KHtZ/yChZzl/0vY/9egGKNPhLdnPjnQP4TFFP6j0FSJ9XUSVzz4VuWQRliuFEwbphmEDWE68yH+sRraQuhW+Nv1jgwLquKIbb6xIoldZpIGTLc88z2w3bf8/iKNqMvxQSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQC/+gb/8pVjQl5/zn/RKcy0Dgn+IwOzcHQS8E2tdwM=;
 b=gYtNK63sUTKiAnjXclZWUTiNa13FvLQJALgEuq+k46Y6SDujREqRtsBZM0vklzMJaJ/CC9Z+D65JgNhESqPmemZM1lkyf9uHIBNNjvOoLKOu7t36Pp+2fZXyVxBk189xa1CRdkQK0eHt6+zrmaPp22bQNU2BJE3JavNuI77XYH4m8fj5OWBC887iD11pbUnNT6g84wwu2m+W5L3+rVeMiCvS15wte0uZE7LMs+ByaJwKeEeDr6lGaNGmFgTttGdWlFNPty6S5dBidCYeBdRXymCUPR1m539zrdmM5IylDr7x4/ATZk/9bKNIOip9hZw7NoHB69oMR1JOUZSj79ijqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9466.namprd12.prod.outlook.com (2603:10b6:208:595::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:36:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 16:36:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 07/12] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260728210928.1050849-8-praan@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-8-praan@google.com>
Date: Tue, 25 Aug 2026 13:36:11 -0300
Message-Id: <178767577113.3356902.16348370784507904981.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0f0685-e7b4-408a-489b-08df02c6fa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2/U7hjgi9MyAOC2VjjFZM3T/PM9WUTE771P7bPzGmdud85/LBM+7vlu6Ydz1szk2iVbH9vtMO0M5LLh5EtxZo1BVKjtXMXmgrs1ItQBxtqP4IOC0R4aVWZVDQ4YNcuvhHSeo7htJz1x643rrBaHbp2xFJjayI8RqBXmA/msLQYPdbkQDMQduUQCpnRlMIZntXd09cnO2T7nfTWi8udoLdM+VqWVTVwtP4KjIzsC3fMoscFtJPF10/GDsoUU0TAuHJbH2PCxRJgcAarVG+mCpQ70LQczTHG4oMUzRgADlT3npsqt5KVzKHZuifSDh+Xjjxxjluee8WjXeSEFRgGhmpdEtLF17+bLS8rNshksfCJqXFfSsWPicLPeErMrQnnVq4n2bAI5gOhxqF+9Ygx1SVfCEg1CQxaGVIu9D53R8d2o+l38Et71Q526/p4IiKmhkkxvpYLgYXT5BSZAtCPp7QFD6ThwCNUm+BnSgGJ8RbQY3aJmJ1QqlDRr2uhKWyW0qBACSvuge/WB+7zenTTaahd5V8I9bb0MoY6doX1hx67aToMmOwMRdcJchSPGPwG1uLV4OjmA3GzfHDoxg6USTDMzyAV9eXu8mWAV3L48TFC6Jir92E3VJerHxD5ceCfp+SLDy7lGtX3aJtLxQBzvqZvVFAnpSqxrbY7+dKJLZQ6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3RHVUcraVhDdlBpNjJtQWVETEJPaWE3TXYwM2dSTUJJVDk2dW9VbVRmUTJ4?=
 =?utf-8?B?RUdZZ01UaCswamRrcmcxV2VDdUhQY1JPNjFmZzFzZjQ1R0JESFBuWk9HcGs2?=
 =?utf-8?B?czJ5aWdBZkpDcjZJSzMxVjhxejV6KzlvK0FuYm9sVzduc3ZKRlM3Q2N4bDNM?=
 =?utf-8?B?OVgyNldKT2dOT2wxdjB2Tm1HcUJzZG5UeHJ3V3BWZlRwYmFBZzk5M2N5Uisy?=
 =?utf-8?B?YkY0WkltbEFjTG4vUG0wNDF0UEJSM09OMndDRUsyZlJyNERQVG40Q21zUDdY?=
 =?utf-8?B?WWxVM2pBcXFseDQ3RnMxaExOQU5FbUx4MUd0U1UyTkZ5ZXdjdXgxUktSTjZR?=
 =?utf-8?B?UmkyM25XcGdTaFZXNzQrRmpNaG9TQ1E5SlhsVGtvaFJGQ3VCWmY1Q1RoOUJq?=
 =?utf-8?B?bmJhTmROVTBzRktmbm5Ebk9MZEhQS2k1WXNsendqYXpYUXpMVlBWYVFVVFpn?=
 =?utf-8?B?VTVEN1NWaGduSWIrb0ZPUE5ma1ExTUNmZHR6bkdTRGVVelkvYldHb2hjdHhj?=
 =?utf-8?B?aElLL0xUeVhnY2JnTXdiYm9sT2RqejdwRm5ZYXRmOVJ1WjU3d0V2STArMlpU?=
 =?utf-8?B?SFR5cXU0d2poTkFoMWJVWGh2cHdPclhnRTV6ZWpzZnUxakF5V0VzSlVYME40?=
 =?utf-8?B?QjY5Z09iRU1nU1BoRVRCNnk2RHc1bFE2SDJqVTFueXQzNXBOcGdRclJlclV5?=
 =?utf-8?B?T0lqdkt5U3VDcSthNk9QWnlDNUtjZlJ6QlhDSmRScW45cE82WUllQzdOSGZU?=
 =?utf-8?B?d2xJQ2d5bWpjR2ZQUjF2cTlSWXZHMDQ0OTFHTjFNK3NYVWpVejhrbE4rOHUr?=
 =?utf-8?B?SHhoSGxoVEMxRkcwSDhZN2x6Skp3dDRoMjRxN0VRa2w3KzdTbGl0bE1MQ25x?=
 =?utf-8?B?YnI4Z0RaN2cvT05Nc1dnNXlqN1F3SEgzNXFybnljblZxbkoyRHdXall4aXky?=
 =?utf-8?B?QXBYTTdxNmdoRGZTb2lUM1FISjVtL05vRzR6eW5BejhnVWdqdUk4d1BHeUlS?=
 =?utf-8?B?aFpmMGhpdWV2dUVjQ3Z2TnhpaStQMHJDMmZyekFFa3hibGxkN2oxNHV0WEZz?=
 =?utf-8?B?elExc21sV01wTk5CVEtNVTRtR25kaHBWU0YyL2RNcmpLczliOHJuUnZQMEtx?=
 =?utf-8?B?NmdQTjljZVFGUlhSdW1nM0FvTFk1bi9qZFR0enJrNk9PL0huT2R2czV2OGhz?=
 =?utf-8?B?dExKUVJlRzJ5S1JVUG1qVDVUcldzaE52VnlxRGtobE14Sko1VXRWczRSMHZh?=
 =?utf-8?B?WnpMSFRlWjVqT0gvVWtHT3UzTkU4ZGpTZDZ4L0t2cGs5SHpPalVZZGhIU29n?=
 =?utf-8?B?ejFPNlFkNGx1VEhRd3dGUFpqRnFEakQ2QzhEenNYV0piNTNOd1l4N2pNbFVJ?=
 =?utf-8?B?VlQ5MUxMMU90RG0wbEo5Tyt2RXZmZk5RNXJ2aStlTHNCcHliQXlQeklNbWtW?=
 =?utf-8?B?T1pFcFBSa1ZkUDEzZFA5enZ1ZzBROXFLdXpINTdkVVd3djZ5QitCVm9IYTJG?=
 =?utf-8?B?WlFUNm5URFh4Q0NxUjUrTG9yQm5XWWdka0xmNGVxRnBrc0tXbGozcHd2TVpI?=
 =?utf-8?B?TThLSVVYRmlrcmQ0Qk1kOFE4SXRKdm5OemxFV05GSkN3bjFrSzU2Y0M0SC92?=
 =?utf-8?B?cm9wOWkvQ3ZRbmtwRWdEYU5YRlQ5ajVSRUFUNmpzcnBiU0RVbnZSdVhjMWJL?=
 =?utf-8?B?VnBtd3hJZTVnWE04N1prTU9pL3JleW9CYzYzdXhiS0g3TDA4Q05va0pxTUxW?=
 =?utf-8?B?SXA5cWJtYXJtS2ZleWRMNHVnYWFXcnZ3blRNTmJNcUtWNkJXTHl2R21MWFE4?=
 =?utf-8?B?NUV0aDkweWRLZHFwTTMyTm54VWwxS2JyM0pnems3SGlWY0QwM2RSQUVqdFhm?=
 =?utf-8?B?YmZiVkc2cVAzdVk5clozNzNaV25kZjFnQU1lRUFPaEx2NTVCVDdmQzVlRzI0?=
 =?utf-8?B?bDRwQVRDa2VvQmVLcUVuTWdoQjNITkRqeUkvRnByQlh6L00vM2pqQTFCYjhV?=
 =?utf-8?B?aHBJL21YZHZ0dDNrZWJUTExDOEQ4K2tMTWM5TTFSVzhhQVpYZFNmNDJoQUIw?=
 =?utf-8?B?aDE4VkFCVWZyc1Z4WkFGUUNsRjVReHBCM0FPQlM4b1ZUYmJZbndwNVA1ejJw?=
 =?utf-8?B?Qm1KZU00aDREWm1IMWJseUpGRVdNdFdQKzRmbm9SWGtnbW42UTd6emtJYVgw?=
 =?utf-8?B?b0dBQmpqdFBvVklKaDJ3UlpobFN1QTdPU0t4aFBHY09YenZmNUxtSStwUDJz?=
 =?utf-8?B?R2hYSFE3bmxiSTJwc1ZNVTN5UkRGRlFMbzJoMU02R2ltaDZPaDJtdXpGQ1dq?=
 =?utf-8?Q?A1phLsXP0J+pZxfo9V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f0685-e7b4-408a-489b-08df02c6fa5d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:36:14.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTwNRGF3aiYzf9RPO40zBYfpQVt+26ai3FlhrvyLIlzV7zztOs/zOv3ZcJ3pOE/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9466

> [ ... 52 lines skipped ... ]
>  		while (!queue_has_space(&llq, n + sync)) {
>  			local_irq_restore(flags);
> +
> +			/* Avoid waiting for space if the SMMU is suspending */
> +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> +				return 0;
> +
>  			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>  				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>  			local_irq_save(flags);

 [Severity: Critical]
 Can this loop bypass the Q_STOP check if a suspend happens concurrently?

 If a thread enters the while loop because there's no space, and a concurrent
 task sets the CMDQ_PROD_STOP_FLAG while space becomes available:

 1. arm_smmu_cmdq_poll_until_not_full() updates llq.val with the latest global
    state, which now includes the newly set STOP_FLAG in llq.prod.
 2. The loop condition !queue_has_space(&llq, n + sync) now evaluates to false,
    causing the thread to exit the inner loop.
 3. This bypasses the Q_STOP(READ_ONCE(cmdq->q.llq.prod)) check inside the
    loop, as well as the Q_STOP(llq.prod) check at the top of the do-while loop.

 The thread would then successfully cmpxchg the new producer index with the
 STOP_FLAG set.

Make sense to me, having arm_smmu_cmdq_poll_until_not_full() reload
the llq and then not loop again from the top skips the Q_STOP
flag.

-- 
Jason
