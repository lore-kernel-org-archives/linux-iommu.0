Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429162;
	b=3zH7abA70BM4wQr8hEh5IWD8Qua6kgrgbQ4XgCl6qXlhPvGnh+4dS2R9C+IxF1l8jpEr
	 gGVD7Fqugz854kUGVc3Jp5dP5WOSbNjkvyOtDK3G/g7nX0ENtKeNFIVH4hTv23WUeDiZo
	 Yd6WkX7sAVBW9dbtgm6tyfz37ua+9+ZE5izI4D/WrMl0lpW3ZlALFojwgJBoQ/TLDjTBw
	 CDf4PG70OtPQWKwnGdOuDhqrPcPNfR70WAbLUo/0bzfaTdllKzaNHvEfRuqtmDRzpxOpv
	 ZXoMVBX3/IIc+66SYupgYOViz5QjbTNMSMvmW3bJOYRs0De6J8TU+545r/rel11WLDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429162;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=Q4aYhkB2itPdq3Ct70W2y+9Taz2ofJkTpwrucY+7bQY=;
	b=dfksw5QCr2ljA6oH03dVjxHFaIG25iYKXRwu8IsTBn3bWE399w97qJFbrR5wEw6aBA6O
	 3VAqmmG4p29AyteuGJynTJJ2T66RhCQS0NphS6mprHZ5fsFzyTQYgqqM64oKme54qKg0n
	 ga84n66H4umnOxzb/tn2rI3M2+5Gkm8yB40KSEz06/oJrNWN7auZBrV0qeTQpjj/fWRNZ
	 eZ7fpSI5Feou4HcGTd00RgVnKrRoHl2BY9UZ4JyBjIwntFgLolEQg5d88ey3M/fN7d3R0
	 GZI0LR2RxUVQvUpp7bYohqQLuhVra9Zn8WCdF1CX0+vy9xhJjvL8NPsy67VifEldSkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="drSwN5/a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.26
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD09606A31C
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 16:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD09606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=drSwN5/a
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZWFarqAAJp3ncSBcsMdfdzoxBDEwoYltA5qjiQx7b2bUR0F+eu10v9ORQPp2koymNJXHxpZUVE7fsVg5okCmVWbPs/u+/exr7h1DpBmV8pbEFpjO4OwosBM+vqjz/NGnW5G+JOG78YlaXheokm1DrAWixeuwswfJmPopP8ff/UJNNDm3DGE44sPSx4c9AO7xYGEFea0IROGkVyu7bGhI5xzlZRk6quw736kcfohy8IVwpkx0VYb/xye2hyNevfixS08EXMULl/d8qQ3EC1GXPmunfEfH0tJLXeN5ZWRUfWiW7L4iBcos6n2prVzmfqTP0DsH9eBvnQz5G7NrF/UhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4aYhkB2itPdq3Ct70W2y+9Taz2ofJkTpwrucY+7bQY=;
 b=jTFqJaNGvH56WAAnzH+w1xd/MwvM1JFpMVtwr0trW7pkvJKaY74NLy0sFC5xkqn2zTbD8FDP9ZYRRpMbAJ1zot0phBMy5b7DNeA+xhBCJQTUE6uL+XgDVJM4fEjB3he4ukljGKIIaXAFhqJFb3Mo9yzh3rjuKDOUzAMIOT33zhcuTS8MOC5Jm1VkeBcOXv8giSHYg6mYEon8+t76QLWLBA/z+EXg5vsMLSD6dNRpSZXOeJtJFRNVWVDnEA27yn8JGZJTgnYiQfJi/zfqgYK7ds1kX67t7tP2a1o3iWuEN0pfHvOWwm8mkYtS2RIkRhdSkoUTgBqo2FlakYDWroxJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4aYhkB2itPdq3Ct70W2y+9Taz2ofJkTpwrucY+7bQY=;
 b=drSwN5/aG6yLdcg63HFx3uF2U9gKC4yVSOLJ8QZQHndJTUJFUEyyWdC/P6Y4NrxRtsLZGcn+qAN5U8FwC5NpubpLv/tWx8zZBcYtvWxF6apqeQauvoOzG37Nb8bKsK1dTVdHR2o9dWsJhWiimD3ppN2qaV6lY/MtcHQik5tRSjI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 19 Oct
 2026 16:59:17 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:59:17 +0000
Message-ID: <99d50810-b040-4162-bf7c-e782beeaac8f@amd.com>
Date: Mon, 19 Oct 2026 22:28:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/24] iommu/amd: Program IOMMU DTE with the private
 IPA domain
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-14-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ad33c4-383c-466a-95e2-08df2e024ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	QT173y2sQlPZUAQFB1J3GC57DK5RzoS2mEG9KhaoUoz4X9Ip1GsaRbjCpbNe2VZBmyYVNa8GtXROvb3HtjEa1GaBFsy5wjWprPQ7ueZFqz4vDXwR8HSiOBKHGn3vHC0Ba9KXNr5UN8gXcSKWnaq7L6gJyus9yG+SI5ZE6M9y+TLnH4FRQ4Yg8yey4HxoaE+upX8WudI9cFRivSnRAsjuuWRS2yl8e36Cz11uVjvL0nO78AubsJpJ+1lJLQ303LRm7PQ/VXfaqcqg9sbqGx+UM3Yajxueokcrp5HO6bdnmGbaxTFobGQYtY4dq172CPCH4q4IohHmOjVuqcpC3oJh2I27hAQD/pfwfarmY63005z3ttEmZPJBYwff1m3cg3xktfMups00EbHuz8/lyoC18H+xxShgsArch5Ra+SuqtxePwHwzUcD2PixfsJOE2+H0A2YdJwKvt3cT/E5zJVVI01nGwqg3p6LF0hlBAQ5070WW9Q/I4OkwoALoHZz9EK18cQyaXZy1XZ6TEagEumZZk1EBJfGAAMfrCR4qIgZ17Z2nUFvFc4pkBHnrsiQCmJ0/zn6xMAQ5v6mi24N3dtB8TY/vZa21PMAsDTqtl0jNMcrrd/S63lp8Grmx7E28jDtM8jUsfmDwnlvAXa/Hae5RS+Mog+/KM2Rx6Hvlra5lKp4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnZvdHBkRThpU0lqbGllL3ZRcnd4YnNDcWo2eGxNNGhZS0tFejBOemlRZlVZ?=
 =?utf-8?B?NGpkbndBKzdBeWF3UUczK3FTMmdOZHRYUmlubE94cjNZcGJEVmJMWTczRmxG?=
 =?utf-8?B?S01aeW5NR3NxVVdjbFk2dDQ5MXNObWh1TEhuM3I2N1l0aVV2elpwYzNGa0w1?=
 =?utf-8?B?UmZUQ25VYUc4R244ZXBrTW9YYllubmNUVHYvVyszaEQ0ZDEzbFpsbktSZFNG?=
 =?utf-8?B?S3o0UmZxVkpZN0s0azdrVXkrSVllbm54Q2gveXl5emxTZFN0K21qaE03Ujdv?=
 =?utf-8?B?cjh6Zkt4OGgydzZlTURldC9zK243V1o2N084ckJTYlZBcmRKYkdlc2ZMekhF?=
 =?utf-8?B?amRCWm9zS3ZLbjd3RzZiWW1SR3A0NXhPMFVrc0VUNXJ5Y3NKZ0krbllpK2g4?=
 =?utf-8?B?ZnBCRjVpdHZEUXdSUGFxck5UQjJORXpOYVRnYkVXRlB1bFRBc1NhQkhxdVVF?=
 =?utf-8?B?L21vdXVZLzhlbmFyMkx6SWNJZkVudHNmNmx2VERTM2VKWnBkTjduR2t3Sjhy?=
 =?utf-8?B?UEdTd3kxdVRwTEdzQnpQWUs5TjQ3ZjRFNlF2UG5jcUFXa1FTa0paTWpPUE00?=
 =?utf-8?B?b0dQRWFwZklqUFVLSzlVUzJ5Zk4zaUQ5dk1MdU9iQ0Y0ZmVwUmRJK0VreGh2?=
 =?utf-8?B?eklLS2c5ZTdIS1IvMTRQWGErNlU1V1ZBWXhMYmFndXFCNVB4dVRzcEhKcmhE?=
 =?utf-8?B?RmRwQ05EY3Z0Y2txRlNLalh0RFAzMldxK2lkc1pWRHUvc0dVRFZwWUNMOEJt?=
 =?utf-8?B?M0p2YnlRK2ZvZGZwSnQ2MFM4bDJBNnE0Y2MycnlCZExnVk0vbnR0UDh5a2wv?=
 =?utf-8?B?UzNZbmticUtFNzVBRHllY1ljRlZURVNLK1BXNmNtSW5paS9XQk9kbUJMd0g2?=
 =?utf-8?B?SFlrV3F4YTdiSHpOcXlIVmxpelRURHBsblUzVEhpODZaZzkvTGpxdXU2ZFJk?=
 =?utf-8?B?M2Q3emJqV1FTemRQWXRMY0ZBbGdub2o1eW5qbHUvRlRLMUpOWGVLcW5zdG1p?=
 =?utf-8?B?Ym1EWmM1QWMxZkV6cWJYb01kekdsaEhtUEswdFBaQmhHemd3b3oyd2xiMUxv?=
 =?utf-8?B?dDJZWW81V2xlNkIvZ01NQXVNU2pNWUhCc0JKS00wNE9sTXBGNXduQ1Q2QjRo?=
 =?utf-8?B?TytKS1l3VDRZS0Jza3BWSWFwaFJqbzNybXRPWFVicjRCaFFwbW5POWxuZFdy?=
 =?utf-8?B?a2E2SGZwUXowbFNRdDUyWCtRQjVSaWJKdDlhMjMxSUtPVDV6RTlmRk51MnJW?=
 =?utf-8?B?RmhQclh0c1dhbkpvMitKVHl1d29rOExXSjVBRWlBTy91eDZOWEJ3Q2lkS2s3?=
 =?utf-8?B?VCtNaDZyQndld2wzMm9kK1NnWW92TU1xbW1sckRZaXc0dkVXRVMvbE5YMU5i?=
 =?utf-8?B?TmdudVpZQy9RRUJraWhYeDVSUVVBYU5vVERWcW80OVVCSjh5R1dIRGl6MlA5?=
 =?utf-8?B?UlVIN1EvK2RaNmxmRVBNVU84aXlPV1FhcVUrVkZNRUdJWE1zaXRhMkFyVHNQ?=
 =?utf-8?B?b1piUGRnV053YTBjbjFrMWNkbDJTbE15L0RTQ1hyK1B4dk5GbGtFZUkzY2Vj?=
 =?utf-8?B?LzgyT1RNUDllZlF0YjV1V0M2TW43NmgwS09nRC8yNGFjek1QS09jUnlXaFpy?=
 =?utf-8?B?MmtPUHpPd09RRFJTTllpb0tqajBjc3BKSEw0aU1naWRKMnp4a2VvZEVrdXhW?=
 =?utf-8?B?WGRENk1hMVdQSllmWHBreVBta3ZzbnAxQVNHTW5CRWdEcEJ6NlJFeW45MGNw?=
 =?utf-8?B?U0hzZFA1WjJZYkFWdFE5aHRGa2ZZRElwbmZ2VHl2Z1ZOaVFKUU9pa1luc0Y3?=
 =?utf-8?B?dmNycTB4MTZPS2U1dDJ4NjRzWSs3T1ZjdkZndDZMUzF0R2VtbjVXNEluYlhP?=
 =?utf-8?B?WE1pY0pyb25NV3RFTGhFYjluMzg5ZE9PTm0xNFZhZmFFTnZRUUpFNGZiWXdO?=
 =?utf-8?B?S1lLbjRMTThWWlhicW9SSTRNNFdCMGg2TGVaSW9mcEgrMngxNUlFVllIVmJm?=
 =?utf-8?B?cmRYTnE4OGR1L1orS1QzSytEZFY3eDNvMWhIZ2dKTHp1bTJhemx6NVZtZVdz?=
 =?utf-8?B?MTVaVjcxZis3Z2M1b3NzVVI5VnUrZmFSMHZKR2pHU3pRbVpZblU0RCswc0JL?=
 =?utf-8?B?ak50RUx6YlFxVTNqb0FDM09ENHVuN3V1WVRYWFh2ZVUyWmR3aTFKQzdCY2da?=
 =?utf-8?B?NHZGNWo1ZGorQ21vVXdLQUN2MW95cVZEaC9JNzI5TWdOVmtTamxHbEZyMW9o?=
 =?utf-8?B?cVRwNjBMYkJNaHh1Y2t3aWJEZTdSTW9MQkpNVGZRYVBNQjRuM0dsYWVVQ1hH?=
 =?utf-8?B?MXltV1ViYWF5VmxIUWo1QVYyR3BpSnZIZE1tbmFKdnZGWkptRmZRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ad33c4-383c-466a-95e2-08df2e024ed6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:59:16.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+d6fLw/lHRjCtIPfBy6gpSS6lWW2UoA/0jCpSTZcSwcQQV/Hi/e/CJVjUAz+ZLZrZaDr2MmWYWFADVn1kgx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> The IOMMU PCI function does not go through the normal device attach
> path, so it has no iommu_dev_data. Add amd_iommu_alloc_dev_data()
> and amd_iommu_free_dev_data() for a synthetic object that is not
> interned in pci_seg->dev_data_xa. Program that DTE with the private
> IPA domain's v1 page table so the IOMMU can DMA to its own vIOMMU
> backing store.
> 
> Leave the synthetic DTE off pdom->dev_list and with no struct
> device so clone_aliases() is skipped; it is only iommu->devid.
> Rewrite it from amd_iommu_change_top() when the IPA table grows
> so later high maps remain reachable.
> 
> Do this after viommu_private_space_init() so viommu_pdom exists.
> On teardown, clear the DTE only while CONTROL_CMDBUF_EN is set,
> then free the object. After disable_iommus() the INV_DTE flush
> would time out, so skip it and still free the object. Failed
> self DTE allocation unwinds through amd_viommu_uninit().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   4 ++
>  drivers/iommu/amd/amd_iommu_types.h |   2 +
>  drivers/iommu/amd/init.c            |   7 +-
>  drivers/iommu/amd/iommu.c           | 102 +++++++++++++++++++++++++---
>  drivers/iommu/amd/viommu.c          |  57 ++++++++++++++++
>  5 files changed, 161 insertions(+), 11 deletions(-)
> 


.../...

> +
> +static bool viommu_cmdbuf_enabled(struct amd_iommu *iommu);
> +
> +static void viommu_free_self_dev_data(struct amd_iommu *iommu)
> +{
> +	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
> +	struct dev_table_entry new = {};
> +
> +	if (!dev_data)
> +		return;
> +
> +	/*
> +	 * INV_DTE needs the command buffer. Skip it after
> +	 * disable_iommus() clears CONTROL_CMDBUF_EN. The init
> +	 * unwind still flushes while the buffer is enabled.
> +	 */
> +	if (viommu_cmdbuf_enabled(iommu)) {

As mentioned in previous patch, do we really need this check?

> +		amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
> +		amd_iommu_update_dte(iommu, dev_data, &new);
> +	}
> +	amd_iommu_free_dev_data(iommu, dev_data);
> +	iommu->viommu_dev_data = NULL;
> +}
> +
> +static int viommu_alloc_self_dev_data(struct amd_iommu *iommu)
> +{
> +	struct protection_domain *pdom = iommu->viommu_pdom;
> +	struct pt_iommu_amdv1_hw_info pt_info;
> +	struct iommu_dev_data *dev_data;
> +	struct dev_table_entry new = {};
> +
> +	dev_data = amd_iommu_alloc_dev_data(iommu->devid);

I am not getting why we can't call allc_dev_data? So that we can track these
devid (including translation devid) in dev_data_xa. So that we can catch
duplicate allocations?



> +	if (!dev_data) {
> +		pr_err("%s: Failed to allocate dev_data\n", __func__);
> +		return -ENOMEM;
> +	}
> +	/*
> +	 * Synthetic DTE for iommu->devid only: no struct device, so
> +	 * amd_iommu_update_dte() skips clone_aliases(), and not on
> +	 * pdom->dev_list (not an IOMMU-API attach).
> +	 */
> +	dev_data->dev = NULL;

I am not able to figureout why we cannot track iommu device structure here. Does
it mess up anything? if we hook this to pdom->dev_list then we don't need
special update_viommu_self_dte().


-Vasant

