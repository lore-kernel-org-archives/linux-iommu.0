Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5854DAF8
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084453; cv=fail; b=k6jDIJ6aCpYOmyOoItXhhHllaIxNIbKqZd07f2gbTqJN8Ysqu3TeN4IghFjPfWSo3XqMwiY42c7bFk2X9eQx5/JKKe9QjlZdo3lluDWiIw7qn876E29XdZ4fotemIw5861QXo7nKCK3iNcHjknoKwFDlwbb2ikNQjADc1/EbDTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084453; c=relaxed/simple;
	bh=0R85Ae+VQ4zb/3k7/6nEXQGGkTdC4cVqAVYCdvzaoiU=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Qoi7cYGo6nIosDQuYVxmXcjJwl7Bk6BIjM+RbsbqZ3bjCjKt+3aXAZcFT8dvUe2tx33tVpBmeFI3Zu0WzUHZe04mTvdn6om5Nfz8K9Md5z/RlybzNXFDTh9CaS1M8kKTTa/m1y1HiybZYdp4AXHSxB6NMElV11qPvqJ7UkHNoRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9nyNZ8J; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9nyNZ8J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+RZ1fLr3w/RLl9Tap7J/Kim69CJWwpcpNmp/dck4s1CtElVemDN2V12IY8cm4ibzvfmVa5Hy5zOpuwKMQXVaLBkPwL9xga4rtQa3gTZYmemZ9/iv9Pq7pXSIaifhyDnzluLvnL3agtHwdDRwPGPlUz14Xy74o9Qgz+ukEKZdZUYkwLFKOULorQS5e4KV162npX28GP2XaCk3CmNXelBwl312KhBMWN53L1NyTN08ct9Wna+rPQXqWKKmsoxwK9tTFl5WmpVTPr1QQE2lRV4ktbZNvVp5V3/0tFI/lxhjKV2apFj+Gx9hwB0kfwPu2LUoAasxj8eaccJbM6cDudWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnK5jhluvIBnOujYmDnIzH+QlJdSuUdqfjaArBKAfBY=;
 b=YDZptlXQ5hMdSBtZALxBfk08HIiYNHUn+8S0TkzdEq8VVVRuWYLOPpy54ACd7tz2h43BWD/8xgd6msvTnqie9FeuE64AonE5+hbPkxr4jTfXc1Lkc4P9cpOqwe4TzsBloI3A+RXbdluPsjJkk0wbAYkKD6pbUXHeWsceaAyT5udXqrIdy3Bjb26PBjEI7+Hoo2Qgs8fkiG7fTIHWp+EKb3RC8Rsels/zgp1qNOttpndiP1m/UX20a7+u/YXVtl5BubZiybXn3q7Qjz8WTyoErSvltC3oAJgKjzv+nWHtzciBP7XPhp6F1kcjgteMKeMYE5Q1IEIxONK6w3uy8vInEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnK5jhluvIBnOujYmDnIzH+QlJdSuUdqfjaArBKAfBY=;
 b=B9nyNZ8JU30tX8pKsTy6hSqGjxZ2HlTzeqk+R69UvtD1O3DySt0DDLYO1Y8orjHukoVrRyQAs0TWxBsUyzCXtPKgJe+zmF17HN2T43HsoKVIocp1otnfIVask8Al0nAjJHek7S9X3WPENWs3EXMIvsgJIWJBLbr3T/gT8HUiFARBeYCodVp1vO2v32dH5u47U8GgS9L2PLf0zrsDrwHt1zFee0KRjYM1iF6ZIKXnXm8NScWujtI+uyL0Nb0F3ZdMmU5uejjS+CZdbwrc3ml6tKL84KWzZ7ThuPa+6oLvSJORQ5ygzzi3RqdnQi7E4xJUYLaz9ZAyaCAbHUMoiAOg/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DSWPR12MB999151.namprd12.prod.outlook.com
 (2603:10b6:8:36b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:13:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:13:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iommupt: report the whole contiguous group in
 read_and_clear_dirty
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samarth Narang <samarth.colleges@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <CAAbz3fSE3cnjRXcdQkx9EPuQwarhH+XasQdaEvh6X8eCg+osQQ@mail.gmail.com>
References: <20261013165814.3092559-1-samarth.colleges@gmail.com>
 <20261015003412.GA13920@nvidia.com>
 <CAAbz3fSE3cnjRXcdQkx9EPuQwarhH+XasQdaEvh6X8eCg+osQQ@mail.gmail.com>
Date: Thu, 15 Oct 2026 14:13:55 -0300
Message-Id: <179208443592.4061856.13235317558499274563.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BLAPR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:208:32d::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e21c81b-532a-4522-a274-08df2adfb27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	f+cxfJcX0fC7hHf9GCZOHNy+gnpAVPw4RA94gn3rhvCDwGjqzuz5RG/129oSUSJyVbHr+WFHo3bGiGj+0VRzv8kp2xYQuTW1xU4mzST6JHtdABGAe9fBc29y73oWi6bfuA2IY6HyldrBKiOL7UN5Zh5gQawqOPE811fsNseOc20Na8DImMl1JF60Yew1kB3wZCN1R1+15Az8gsEpjkOx52QeD2XgGT9dzxMwMkSz1WcpK7KAk918gBMBB0TqVqkej1Zg6pBmCOO6czkJAfBkIKRseb4/kBBSZnYoJmJ5AeJkOoZj/C+PROYzHkRBcDH6ASvbC0jXXMcVCczvc/Z/C0H6EUTc1MgEZab7YnUR1rzqjqI6rGzTeWXi/FJ1TOPRRdhGkt61OWESHkpXkoUw+IRFNpQuzFSS83yXK6JheeNn/7Hf2XZzAKYgHQriIHi4Hc1B/ngVhFOGznLVWlOhuUACwxkqLB8G83MT+roHeLom6+MMYrsnQYI7bbEWnsoBG+fGlfiV+AG2U/FNZ7neCchb3IYlyNdjVSEDHVNvGxqY/SpQqfUecDUTCmnZqlv7bkkhTqr2NRFfKED9dna1SNiU2lKkxZB2FnqzSjPKBjyaYnPYv//F5amVBVUS0J0FUheUFV2lFNoBoSv7nD50Y8ur7TsnR9gi0NKUeDeODR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFLdzR5bXB5VmJhaXh4UWdBUUIvbjY5VjZIdVZ6cE1KSkNVSGhld0tEb2pU?=
 =?utf-8?B?WC80cXZMaE4xdjBNbVBaYlAzTy81RXVUQjVlbnZRRW1IVDI0OURMMzJTQzhj?=
 =?utf-8?B?eTF6dlFDZ09GMVNmcUwyK2xxOFdOR2pjMXRPallVMFhKeW13UlJnRkkyUXBL?=
 =?utf-8?B?ZkQ0VE5NRk9od0hVZmgwUndZSDJQU2VJUHplU2hxSGNlQXJMN1dVKzFub3ov?=
 =?utf-8?B?TzZVTkdidVdTUDJRMkp4M2lHRTBOYUNQZWF2OW5HcE9vT0pqTllQcHhDUkMz?=
 =?utf-8?B?U3NyWkY2M1ZjVzAzWnFBaUlOcHFkRTc2QWNQWjBJTEdIVGJ1dG9iaUhKU2hj?=
 =?utf-8?B?Tk1FWmhxbkwrcVo2aDNhUElKY0cyZm12ejhtaFFFZi9hSmFEUWxwSkc4Q21j?=
 =?utf-8?B?RWZ3NWZvU2RrRGpocTZvR1JFcnh3VWwyTWo1T0hTR1NOQXIwTXRQbm9mNEla?=
 =?utf-8?B?aVpwNHYrRDNWTEVoK3VEVDFxaCtxcWJOcGg0Y2NqTzF3QUNkRkJnb0lRbjNp?=
 =?utf-8?B?aG8wdjZ1OGhmUXR1V2JFTGRseG4rcnFjNG93MlQvaEtaTE5UTkhaZkhEMGZY?=
 =?utf-8?B?c0gwN1JrQmZpR2xDaU9mc0VycHhCSXd2Y3ZybDdMMDI0N0pxUVpJdEVid0NU?=
 =?utf-8?B?SnhoNlZRZEFRS3BkZHQ0NHZTTlZWdVdNbFZGYldMbGxWTHFiT3dnSW95ZVNi?=
 =?utf-8?B?SGlWaW1pNmROVHMxemxwSExYbUE2b2RIYVd3YVVtTGdEWXFKQ2JUd2JJMGpz?=
 =?utf-8?B?WG9zMXVzbGthdXBHTDdSVkdOMGpOTHBLdSthVHhyTm5ybXd2MFFwZXJJMHR2?=
 =?utf-8?B?ZjVjSFhjM2FZdUxOWDVFWUxzR2F3TTRQTEc3M2ZJQ2hhY3JacEVYbldlUkJS?=
 =?utf-8?B?WmxmTm9kSkxQTHEvNXE4QVNiVERsQ21WUy8rQUNHcENicno2TzNIMHhZN2sy?=
 =?utf-8?B?LzdTbm9rRWRJZldsajE1VE1XL3duVDQ1WjZkb2hJLzB2cHc2dElrYlpRejdp?=
 =?utf-8?B?ckdZNHNpa0JVODUxVU9CRHcwaFFTOFlDOWl3ZHBBTFdCVjRUQ1E2NTN2UUx1?=
 =?utf-8?B?enJGVzYrRThVc1lnNzNTR1NDK2JIVzZKT3Q3T3dvY1hVRGdlZGUrU0NtalJN?=
 =?utf-8?B?K1RuWkNRVVprZVJTZ3lwYkUxTHBGUEZEdGVXaUlEMWQzOHliYk9ZVjhvYTg5?=
 =?utf-8?B?S0M3dm1iR3NyMmdvazdlOG4xSlQ2SEVuZHpISzNlUDczMlYvdUV6eTBVUWxx?=
 =?utf-8?B?UE9kQktXQkZNSkZPN0pPSzBjYnZMR2E1c2oxSTlrUXZlZFpaWEw2TDU0NDFw?=
 =?utf-8?B?VnJtZEF2WDY0NVFUUFVOZzJRRFhxQkhONjNSMEtlcXRFN1FZTjY3ekhVOFVT?=
 =?utf-8?B?UU5YQUZ5eW9SSGdPMTNDWnlHSnhzRTIvWG5LNzVuMSsvRHgwWDhjMmJEMHdw?=
 =?utf-8?B?bzhFVHAzb2VvM1MyMC91aVRHZUYvMGM4aTEwek9tZklPT1BIZDNXZEk0T3ZC?=
 =?utf-8?B?UlZST1hhZkY2VzJ3QU9qVjFpSDd1Z0YwM3h3UTBWeVlsMFlyK0pOcWt2dkpO?=
 =?utf-8?B?NHNyS2VnYXlwVkFsMkxHVEtub25SSXRDV2g4MUdqMEZhLzY1VElLTEJvQThO?=
 =?utf-8?B?cThSWGszc1dCM1ZWakY1M3ZqUTZxd3B6MzFKaGRnTEFJdEJsSVlnYWtWVkMw?=
 =?utf-8?B?RlA3VTgvWHhxanVuRytXQVRwemFjNzJmcGVzSjlrRHpKR0RTeDk1MTdzck9Q?=
 =?utf-8?B?WTI0M28wSUFCZ1NKUjZxQVB0V1ExMHB1L204VlB6TEw2ajRQRDV1Z0tKUXJQ?=
 =?utf-8?B?ZUFnaW5BOXpFVFVxbUo1Wmw1YXk2anI4d1R6TEVBYWFlMmxLYmpDOUUrdmVF?=
 =?utf-8?B?RDlGTWwxd2hqdEhpZ3FwY0puZXFTN3hFV2VaR0k3RWJsbnFPQ3V2OTdhZ1Zs?=
 =?utf-8?B?SWNOMHZLMmpSRHNibEM5ZGdOUlBmUVJkYi84cEh6VnBkaEZETTAxL1hoeDZY?=
 =?utf-8?B?TmdLdk5NYmdqbVdFU2U1UHJlNWpubHRoWThnN1NhbUZJTHp6VHVWTmhnWjZJ?=
 =?utf-8?B?dGI2ZEF3TkpOc0lHQkpoMFBFT0hiTnJUeTE3ME5DZkJpSmNzbXhCM3NOK0di?=
 =?utf-8?B?U1JEZUdWK1U3eUxvN1RJR0x2dDVtdnF6K2hxbDEyc1UzY1dORlUzbG5DTy85?=
 =?utf-8?B?dExFRVZIbmE1Q0N0RDRtUTYzWSszNzA5VE00NzRGd1JLYkdwQ0UxOE5qWXFO?=
 =?utf-8?B?QWd1TTROc1RPOTlqNEJMa1p6ZjFIMkdLOEE0RkU3NFhlSXkxd2FZcm5UUURM?=
 =?utf-8?Q?v1Dr+kUXSSijROn1ge?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e21c81b-532a-4522-a274-08df2adfb27f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:13:57.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hED9qvkUKcY+o6PV73OtxO9flgNsRsNDIA268dZWCmF1lbAgKb7pUisglosjarX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151

On 2026-10-14 20:50 -0400, Samarth Narang wrote:
> Thanks Jason, that makes sense. If it helps, I am also happy to send a
> v2 of both patches along those lines.

It is OK, I made a different patch for this and picked up the other one

Thanks,
Jason

-- 
Jason
