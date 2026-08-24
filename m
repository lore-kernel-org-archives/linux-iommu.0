Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA84503E1;
	Mon, 24 Aug 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593160; cv=fail; b=LztX20VJBBl1fV8MJ3zmV/6g7faC/larHGPuMzv8Ld83H52xuKW0ojIvx5TuWE5aVkBkxK+gZWGrFK/D1m8dphf6poJ8b+mCPQHs4FYhfmOEXWMoQ0dAbNfqFavgCCvTZTIFt3ueAyecxMR8mKovkdnoS+FKb9yQbegTIYvxXnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593160; c=relaxed/simple;
	bh=ICeYNK8OEAgCTnfgaY+sVojSD4dUnxxYKfgXYcByzCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+SCttBZKuwNvBhSudxPmhIGFhswR3T2FBjopO6dNYTL3u33L7r2R624+hd0oRVshl3FfZZlsOdO4XcGQ7sPlBPAtex02IMg+KG/mFezhfQyZlaSGVdrGQhV+9yLgLtfEzM9jCXEnVnQ18epWfEPd2JLaWJLU49UPlYrIT4upUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4joQT0f; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4joQT0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBY2do8eOa0QczoeQroYAysK/OTGsIZylu5xmdRXXIdR1YR2OK3tmb0NoEOojocBNxdf9ob3DgVeFrCLTg4rYXZX2A2rOr4yyuG/B+OlkQmQ0Z+Pl2917dBDrYLxWwygJYl2Wj6HbHgkvv0LQi1UTdlORkBA+56wMfDCzanmYusQgFGybNrZHv/laqoaJrZKDc0BOCCtjzE5/2WUwkqXKYFi6uLJHwDHk9SAoHz6CpYIRWuwQSHf1tEqSIIGs187pUpImMCydZIruHXv3m1IAmfpR9INVi21Tn/V2TB6fVJoSlEpbRup25vwN+PnbuI1Rv98trnlCO6ur/nK64GCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tsU3nw5kjp7aJaKjsJuDmpxw3n74pbsFtg9sIu9ARk=;
 b=XLUApcDSRr89ElzlpEkZP/wcYp4FP6sUTY/zqjA2rKroFqgFdTv0hYscExIGI1/H5ww8dkOvVOWwsWgxY5JinLf7EvSGIl/RBADaiTBf9SLNr048ZcZ4cgrMd3VQWLdAyryyY7jA9fTizMf2L0ti+clJ0gFkPtev/hLI1PstqNiPUVRoc4KJDo+9nMGNEXCVzlgNdovrEA/kK2YwXZ/GaOjsp+arEzEVGo49WNeTYl4kZ539gdodcqSApbyk1tNcI/P892ExxF+hA7ay2aVbCJZfeURp+80ah6ibirYTtSjR+Cpy9rZKbwJXBdeyKE4F+smXzsVwN6/c0tfqXejP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tsU3nw5kjp7aJaKjsJuDmpxw3n74pbsFtg9sIu9ARk=;
 b=n4joQT0fDs3FPhgD8tz4wbS5bk2ALTnfy2rQNEu7xMWVlhuMMKxS6F6JwenWrW4y7dci/6Ze4+Q07NnYMACl2WQrkIqVRdFM7KJQWlGBGGKLr4/E/6zHfZHszmF3MCLccSy8yObfPk/3aWWVdm3mi4li07eeh37o+FjRoZhWyZvW3+ZTTRnaFLUvx/eEXsx28+keZPLY+PRfzX+LPq/SYIY1+Z5o8aAcTJrGhdLQrq6dhAtlqLzJXiBd1/boVYDyBZDZhPUkmNRnUK89EDl5olHxqMZpG9YSZ+saE42f7nCqdx9hGxeshL7KHu0a9gJLBoC0ni/9w+WRPtm54AUcTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:39:04 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:39:04 +0000
Message-ID: <3bb55e7e-b16e-4c0c-8acc-756ad0a87f61@nvidia.com>
Date: Mon, 24 Aug 2026 19:38:58 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 5/5] swiotlb: Implement RX nocopy with fast recycling
 eviction
To: Luigi Rizzo <lrizzo@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260824152932.1583506-1-lrizzo@google.com>
 <20260824152932.1583506-6-lrizzo@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260824152932.1583506-6-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e96e49e-5d10-4868-d027-08df02069734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZREjKmos34PsavJbwmGM/VMvMK/FbR6RJgGyMdG+yAnK/8S2cQd424c2AMRnZQLta8pW8MtQcNmWG6CpYyEvRECWDtdq9sHBja198+ZGyGUakw0DbVbGqSxvhe3QWQbXOA1vjSQoXbbQ3kOcxEszqkppVo2eWgaPXXY24Esah9nRobddd+Yze0YKMvDT6f2x/nTA+8keUfpIYQh9ZwsW5OLm7HJCgHLakiyfYh1Ko8cnIyluByipwU5uRFns33gXYQIX2478CboCAYfYnoKatlOa1gHv8hyULqyascUnZd9JkOgGdHLovwHmZ2eaAiHSXUpF241zoWiXAKCsJ7MwMd96ojPpdVOWdwqnjfJWjJ8RpKUd+ae9Vum8Z1T3/iPvqQaX2GLwAU/MEwT9rtNOXltzstOpEuDnUM45OCOVN19j965nH6s4W+rmTmNGFXDS8LrJXQuCDCAAzeSLmulFe4veXrG66v1nTrjGCg7ckLY5ENxngXOtPAAetV5ixV3YogBpLD0SBQedpEKKUauNBpiNtP48VdXeMOSoFtFxCdMPDm8otN27/+dZi81ONCjZQ8Pq1zD68HxIX+iIRQE4wjzepLqBTw0j3T/506944bcRVGWXc5beMJIaSExrL9rshFov2NkWEtomx3Ut0WmGj+aiWnYXcg66MQmRt25kqfxCLiPYgoj0NkLCzQD2hHQWoE1rbaLJcwqcsD/h7U/KVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01LejBRMGRzU3pyWFRQUzJsUXp5STQzSGI3MkpZckorNW1TcXNsM3M0UDBG?=
 =?utf-8?B?UnlPeDd2cWk5SzNPbTVXbXJSM0hxUC85MFRKMzF3alBLUU9WbDh0YlQwcE1W?=
 =?utf-8?B?S0RYQ2V0ai9YWkEyRHd4NnBDa3VKYnprTFNWU0R3ZjRIT2ZxbzN2OWpjM3ZC?=
 =?utf-8?B?VzR1VlJ1Rjl4aFZkTHFzRUMxeEk2ZmswYWNvcGtJMmVNWlVVYm05dytzYU9B?=
 =?utf-8?B?bnZuazBuOXB0cVlBSWJxT3NuYXJPeXJRdENsY3FwVW1FRFRSWEh4ak04K3ZP?=
 =?utf-8?B?SFVGTm5LZ3ovR0hneGNxL2ZzbGsyTmpNQVEwSWl4ekdBMDV4NmNnT1JDbjkr?=
 =?utf-8?B?MStzdWE0eHZtcTB2UmxtT0c4aktRY3krM2dyZjhGbVdjMTFtMnRDZnN5Mi93?=
 =?utf-8?B?ditBZnNhMGY4WjE2a3c3c3paa2FLMUxydmNhUkF4Q3phVlRWQnF0em5KVGhM?=
 =?utf-8?B?QndpTm5zRGg0N01YTnlDbkZBYWc2MEk4S1h6SzM2dU10OFNydk5CaEZhVUVi?=
 =?utf-8?B?bVZiQVFCQmVpRXhIS3JFdDJHVCtibVpYQzZoWm5zbnB4NVA2R0RYUFZoUEdK?=
 =?utf-8?B?TGk1NW9tdWZ4MmMwY2swN1RWZVNtd1UyUTVibWU0c2p1dng1dytYT01Pa0hx?=
 =?utf-8?B?QnpYaHZUSDRZVXVMN3lOc29LL0RISVlpMm1rOXJhSFk3MTV1RlhRYktIR2dN?=
 =?utf-8?B?V1Vsdjl1RDU3ZWMxTE93eWJZVjZTTC82dVNPUEtGbFVMYUtMQXZKNzdyTDdN?=
 =?utf-8?B?dlF6TXFCUkJJRmZ1eW5heGNvTUQrM0FScTVjY2dXU1hzd1MrODdkRlhjbU41?=
 =?utf-8?B?OGdrTUJ1QWJMNE5keFYwV0VDM1g0SU5yVFY5ZitEcER0SWlMdkhqQU40aldP?=
 =?utf-8?B?OWxFYi8zNmgvOHBlT2NLK2wrcWpadEtEakdXOElKWFMwM1ZkNEFWY0p1TUJx?=
 =?utf-8?B?VUx3Rzd5bnpoa2gyenY0ZG56aFlEU3FXMXlHNkhrek1TejNTQ0tuTGR4dmh5?=
 =?utf-8?B?RHpqQ2tvaE1LZjdNZnZjSFdhZVE1MGJ4aTZ5TkMvNGM2ZGQvR3FWTlY4YUNX?=
 =?utf-8?B?N21uc0JqS1U4MjhNZmlRVUdFR1ZqRndzN0hMenpYWW8wY0tKeUw1TmVmaHNx?=
 =?utf-8?B?UVFqa0ZIUkFsQWZ4VS9JK3FUK1J1MjVmT1pJMDg4R2NMZzMrZmVQcm1kOXdP?=
 =?utf-8?B?Zjg2UTVQZG1nREtvZWFSN3JmRDk5NnhGbVpPQ2c2SjhwUERUYlVRMkZjazh3?=
 =?utf-8?B?TzgyaUQvOGp3SElSZVp1TXUvdS8wUnlmcGpvUUUzL2NoQzV3eXhXWVBLQkR6?=
 =?utf-8?B?QnVNOG92S3ovWTczbFZ3aU1pOWZOc0RESmVzdkRMRHFPWFVkdzhuZFFJVnpX?=
 =?utf-8?B?a1lITTJSNDQ5cE9OQytrcWhRdjExVlNkMWhxQVVmMGVQNkVFKzJIOU9BVUV0?=
 =?utf-8?B?T0FNK1hmL0NFRkNlWkhHLzFnRllDQWFUUzlZWGdScnRJQjdXNFFxYVBDOTVD?=
 =?utf-8?B?Tnd1RCtMSlBuaVpXWmNXTUw4RjMxM2Jud2E0R0RScVIzUUx0U1FPNC9XNkFn?=
 =?utf-8?B?SU5MdjBLVG4zWG83TzZVT2NWVlB5L004Y0NjZDB6ME5ZY2RlbUk1d0hKQk1I?=
 =?utf-8?B?Q21wTGQwcnl4YStnNUExbGttYVR2QVI2d0pQT0huemNlNmFaTFg2S0w5aFJ0?=
 =?utf-8?B?MmFQYTdqVWw1QklvcTkwM1ltWEJqK2g2c2U1Sk4zMTZCZkdObGhkTnlsNUho?=
 =?utf-8?B?emNRdHVYeG1rbmhPQ1dXQ2dtV0FLR2c3amV1bERDNk5OM0NreFB6azk3aUto?=
 =?utf-8?B?TlUzVFZrOWppNFYzRVVxNjEyV2pYdGthYkNzSVgwQzFua0RVOGZHS24vZXJ3?=
 =?utf-8?B?N29Pc082eHhYYXZ1c29qTUMrRVBwb0lKWEM5d1pldkJ6MWR1Z3R4eE1RQkZk?=
 =?utf-8?B?SVVyWTN6UFJwQmpMbEZlVGJqMlFXM0RvdU90YVZBc1lVUzZ2TVJmdmNZU2lp?=
 =?utf-8?B?c3RCMVRPc0R3UTlEZkdEVjdPWnpwbUZvUmIzNFJFU1hod3VPbXlwWVRSTGh3?=
 =?utf-8?B?RFdKVXRITlFtbjFCbHJMSXRDbkRNUS9nY2hFQjRVNDYzQk15ZzYzK0t3NmFN?=
 =?utf-8?B?RGRLSGtRUTB6UkRUVzdYa08yU0g0bEFZMURWdUYvQjVZVk9Wc2ttV3J0ajZy?=
 =?utf-8?B?cGlNWDE4TWQ0SDVsd3QyRlRNNjRnMTlhaFJHL0M3TEIxN1pabi9TaXV5VzNk?=
 =?utf-8?B?emFhNFRGNDdIc3owRWRGWlg2WDNYb25VYWZzVVdVTG5BRzh0RnBlRUZncW1G?=
 =?utf-8?B?Yit0eWJUVXhEdkdxMXpYMFJTV2YvTUdqNENaRHlBd2xQZzJ2VlFwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e96e49e-5d10-4868-d027-08df02069734
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:39:04.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsEmRCcdIODUIbcgYgeIkNy3R8ZANou/JPiKpciuMigfbaw8eUTOgNKDPdWUv7fMB+S65+BJx99v37/3D+o1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820



On 24.08.26 17:29, Luigi Rizzo wrote:
> Conditionally divert receive buffer allocations in page_pool
> to the SWIOTLB page allocator.
> 
> This only happens when swiotlb usage is below the threshold set by module
> parameter swiotlb.nocopy_rx_percent (default 0, range 0..90).
> A value of 0 disables the feature.
> 
> To prevent existing DRAM or SWIOTLB pages from circulating indefinitely
> in the lockless receive ring after changing the parameter at runtime,
> __page_pool_put_page() checks residency against the active parameter
> state. Mismatched pages are immediately evicted back to their
> respective allocators, achieving rapid, lockless mode conversion across
> active network streams without requiring interface or queue resets.
> 
This could be a separate page_pool allocator. It could be similar to
how ZC works: pre-allocate some coherent DMA buffers and allocate
from there.

Thanks,
Dragps
