Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFC84E17
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554388; cv=fail; b=Z0nhlbdDHWP6EOFhpTqcuavETdvkF9YbT7DTcpLrjKrBuuoztdzP8Oyvqmw6HOqMbIRRAbonrUpmjCeJYUfOpn/3Y3yYPoYIRZ/Y6lGM9Ktc9aEK3qCMF0R1RkQ0hoAGIn7qf584N/t9DUll9xejoIx2vS92TJbL4flhEfiT5DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554388; c=relaxed/simple;
	bh=ALqXJJLX4KnEQHj/Vp3yMdHCo/QbEpLyISjLsGOx0Zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l66qkY8FwVBwvOP8PRsD5bRbAI1lnhoaip4AQPdGFnP1FWhRi9SYsXP8pufAwvV/CQ4oagsW940k86e7GbTeOLrttmQMV4XHIrzNIaupR7kFcO/A/z9wc1Dr6b22vbO6dSaIQ9BpaU/+44RBzy7xwyRUmpxkdn15wVkOJ8hGuu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nw4lbf8c; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nw4lbf8c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlE3kbUCkWkvKZBFIWUTMglk55TAgD3t5gZNoUwMcMMe0HpDtg4BUzEa6/c2viyx/Z/NQ7UWqnGnkRCVBrtfw6mzRWMrhoug0WM+EE1BLcZBzQk+QtxfWm6cdXW/lP0Ip5iwegvX/eGNL+2BDSRFnNFYKdTEsUhw9GEWMoX3/2GpIVm8cNKXCoR1GK83R+gKaQCkluEN9fMaNpOureaai3rESk7jMDG65FXlyJhrahKEvJecx+AuPrcdpBasGtMzTNz5yOcns5R3dMid6jigOMdwgHPGWpKuNDTP002C7D/6HVpgZWXGT5NADWDkYONpxlWsb5XbZU04LfUG0pSzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHRD1soQQ0eUi1Lo2jj/c7D3bPfXgbWqs0zCGU0SCxU=;
 b=Gr30JILAN4JEU4ynMqenvhFbevzf9Eoo6mVRX/Y2PjPZmtZr4mUESSgmR/H9ZrGpWc9HwfWB2m0CWPUMqOAaBLr5a+71xGEinejfJQ05aDK0SD6hhS5WL6AR7t/Y7KdLMJeA/UAMcuVreSPBRotSU9rjGjTA9vVJyrO4CoGzB3Ew/l99e8dwtrojrt+yT4Ya/msk0ft47iSIaAz9Y9vSY5lPo1qMztBG9VK6HaI+zTEoWGCJNUJEDR+sx4A9vu52sjuULbG0u6XnEcSyhQ9BxdPttAAQk9DPp/qW37/45jJzGF5dEz0avf9CplG8aZWupahBfnN6kIeJj6zEKFK54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHRD1soQQ0eUi1Lo2jj/c7D3bPfXgbWqs0zCGU0SCxU=;
 b=nw4lbf8c03fBt5PMRjFXwFZvbci1PZl7rqzkAUuG9jLv4ayddDRB3zojBgBP6mnuLVh89xiECk4NlDJNresfCjbAdq4ofAji2HeVAYEvCfAf4J89H+0B76o+J9789G+uDWYGZ7bER+Hv9UxPxAcv+U/FWpCOjlhMZ/fXsQCD3B9Chib4NdGVojI4mf/kT+exwlsvBMkg9bW4xMK21V43QIIEuz+WFfFMXO7lAkPc1lghJQRmtyiow2yww5KIe6MohKaljhsDX3Rmj+YYWtItVa16To8TNHe5fDt3bj2hQPq0vyNXRd/2UkkMhA8+GKF2yVINZHwoiB/LObawa5rHyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 12:39:42 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 12:39:41 +0000
Message-ID: <2a349725-72cf-45e2-9ca2-5a8b153a6fae@nvidia.com>
Date: Fri, 24 May 2024 18:09:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: Optimize IOMMU UnMap
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: vdumpa@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523031935.90856-1-amhetre@nvidia.com>
 <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b229d7d8-207d-4f63-3ace-08dc7bee9517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNsVlFZRlZRZHZlVWp1cWw2WHVLd1VDelpmMk9vQk14a0F1MFF3TkF4VzBB?=
 =?utf-8?B?bCsyOCswRGQyQVlhR3MrcUVwVm9uS1dLMUhWQ1lNYUcwYi80eVNHN3plMXgx?=
 =?utf-8?B?UEh0aWxid1FlRFREOUZRV2hWUGxyWWt6Mzh5bzZDeVp6TG8rSGtEZVZTLzhR?=
 =?utf-8?B?Zm9XZy9yU0RHS0ZHYUthQmdCKzZEZmJuOEs1RGtuUXgxNHRpRWxpRzg3VXNk?=
 =?utf-8?B?SDE1WVUvSGdFODY3Unk4dVltNlBpSjlaREdISWZaZTYrYlpnUEY0bDR3L3h1?=
 =?utf-8?B?UWVlZVJsZ3k4ejBhSlp5ZXQ5SXpHa2xYM3lXYWJxLzRWV2RneFcxMlBnaHYy?=
 =?utf-8?B?NXVnQmE0RUgrZnlMTUNYZ0NhMW9LWG9OWjFwbzVNaTNhSllTZ1dvQXdIOEZz?=
 =?utf-8?B?QkxYN1N2NDdTQXBwbGVYclRiZ3ZoUEFBY05FNW5OZDhFOXQyekpzb0NCc0tV?=
 =?utf-8?B?bEZ1ZVd3RElqT1RxdEc1bm5ENXBtTEswTTg4T243cHQvTFh2UlJyWFFteTNw?=
 =?utf-8?B?cHNsSEhvYzBjV2FYM0owMGpvMFZZWS9iSlhocEhWVmUxcFZpbGRFQzVUTGNu?=
 =?utf-8?B?UzFGSzd4Sy9MUGlXZ0hSYmRjVmhCbHA2MUdjOG5xRFU2a0ZvZktnVFk5ZC9C?=
 =?utf-8?B?NHpUbEFpL3FoeFFudWduUWM5Z2U4OUlkbmwwVlNqUTZBUVFaZmk4OVBOWTg4?=
 =?utf-8?B?WTlWOXdTQlo5bkFwTXBtUGFkeHR5amFTOHhwS0FJQmxEQjN2Q292Q0d6Kzln?=
 =?utf-8?B?KzVsaW03V2krVTRqR1FxSEtNSFlEUUJOanJBZGF4SHVRNzlhM1F1ckxFL3Rk?=
 =?utf-8?B?YlpNUm1UWWhjVXdLZlFtY0F3RDJncWNuVjJRL0RIajJjL0pLSkNNWlNqSk1W?=
 =?utf-8?B?QVo1VjZJejFWSitOOGFVTjVWa293MmFORnBpSXBZTWJldG02K1FTRHMwdzI0?=
 =?utf-8?B?d05DOUpqdmdNaXM3RzN6MnJ0eEZ5MDh6VFVuaUNReHlrQ2lQYWFEMlJwWnBp?=
 =?utf-8?B?a20xbjY4MGVHZ0creWVXT2ZrUlhrYzM3L25OZVRSelIwaWVNV210NmNiU2ZP?=
 =?utf-8?B?NHkyR1hoa1M0aHFIVlJQNXRUanNoZm92VWxmeFRuckhlSEhLQ1pRMGFhNnA3?=
 =?utf-8?B?R0pvRGFFV09nN3IyKzExU0JYeTFvSGZ1bTBqSVVLOHk0UEpRaFRjUjdvbElh?=
 =?utf-8?B?K0pjVkx3VCtxeUdGd2VtUTY1ZXZhekNpaGQ5ZVZtT0c5TmtsMFl3c1BVZlcv?=
 =?utf-8?B?MWRvekZYT0Z4ZmhHVTV1T253QVY3TWJyWDI2TlBxdjEvNXFUV2V0b0puU2lr?=
 =?utf-8?B?ZHl4RVNwWlBkTGgzeWc5d292OE1haG1NVmJUZ1R4ZFBta0JrUVNzUU1pSmxz?=
 =?utf-8?B?MDJIZGtUd0tEU0R6d2FLeExKUm9NenZvcUgvVytReUxURmlSVWl6ZHIrMTFI?=
 =?utf-8?B?SlNpYlhvN2lMVW5GZk1CMWQ4ak0wK09tQUR2a0NmTnNXZEdWSDRQbFM1RkJG?=
 =?utf-8?B?RVJycnprRnlDR1pzQlRiVjhBMWdaZkZRUnoxdlBjaXIwUGVFK0xycDV5Y3VY?=
 =?utf-8?B?eGFaeHExZTBSc2o2Z0swOTFpMUhIOGloUStiZGFsb3huVmxkajdPMVc1K0th?=
 =?utf-8?B?elJ0d1ZZZzc3Mk1reVBFZ05CaGJMOXlTSTAwVUx1NDhlYytmbnF6TXd2bEtK?=
 =?utf-8?B?YWN2cHhUSXRNWENSbVo0czBSNmIwSjZKcGlLTkExQ0tDWnZ6cm9kY21nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU1ad1NrUWIwU2dHOFhTZU92TGc5ZFVtVmREZmpIaG5JeXpWRml0bEZsbHMw?=
 =?utf-8?B?R2JuaHl1NUdBcDRhVzNISGc2OWdrUnlzMTBPRmhsbVlmMnp5NktCdjY4Y0t5?=
 =?utf-8?B?ZUlnVGV1V0JoVEFNYUp5a2hTUnpsSzF4SEx4NkhzeFBFOCtXYkpEc2QyNlFU?=
 =?utf-8?B?R1QvQTQvY0ZGZExndmxuNVUzUmRjMGJ6SzhuUzBFaU8zVmRpWDEyUXE3UUQ5?=
 =?utf-8?B?RGhhaUVDUXpnN3hYUXlwWGxaK3llcUdTaG5qLzBVMEs5VFZkTUUzNDF4UDd2?=
 =?utf-8?B?eEZjYjZGV2pRbXlaSmJtc0ZaNDc5NGltNFpBV1VtYjhvUURTRzk5b1dXbWty?=
 =?utf-8?B?ZGRIMnNkRUlhSG9xM3VRMmdvTjdUalB0dW1ZSUhFTXNJUFUybzY3cTNYbUdR?=
 =?utf-8?B?VFlCZEZ0Q2xLaDVza3J1Z2ErTERJZkpBMy9MZlZQOEVMUEY0czU4bEtFTnIy?=
 =?utf-8?B?cGF6VU0zQndUUUEyQ1pBRkJRYWl5akwwVUQ1RGVITWV2ZnBIQS9QemZkMUQv?=
 =?utf-8?B?TktMY2tOVGZkNWRwZXhGYjF4NlBHVnhuS2NJTG1IdWwxb2VjRUpiYXN2WEFR?=
 =?utf-8?B?N3VnWXIxdzVFNnpLWXZhaDU1dUJTL2JxRHRndmtDN0xEZDl6a3QyZ1dqaU9T?=
 =?utf-8?B?eWRYc2QxYlF5SkxvNm4zQVdYK1Z5dUxBeGxoaGYwVU5QY3l0VzNTaVc0NTJn?=
 =?utf-8?B?OUdKQlNGc3B5NW9EYVZxQUdFdEgrZ3AzeVEreXdPWnhVa0NNN1Z3NDRqaVdM?=
 =?utf-8?B?empRa0ZpZUNYMjM4OFJLcGUrY0RxNElGcFNuaUF4cngxeENMU0dveEpZVUdN?=
 =?utf-8?B?bWdMVkxRRlpEOEpLU2dkQVJVa0prQnc0LzloaWdaYkFmdFo0U29CRHpobnRJ?=
 =?utf-8?B?S2ptaWpVekpwYmhna2dqNmtPVGhjR1FIczByemp5Yml6VmtYYlcrV2FNZmoy?=
 =?utf-8?B?TnY2Z2VZOEFIeXFoVjlKeHhMR2s3MWM1UzZHYTZWQ0ZVM1JBb28rREd5b1RU?=
 =?utf-8?B?cWN2OVJ4V1dmVDY2MzNXY0FINjNMYmVKWExKQ3k2Ymc3cmhHc0ZMN1RuSkxh?=
 =?utf-8?B?eEV0b2hTWjM5RDdzMlNxd0EzaUNNUEdDZi96cXRkS1plL2VlZExSN2ZWVzMr?=
 =?utf-8?B?MTczeVVUS0JUZ3MvVUpHem9WSEdqbmVHanJBNHRDU1dTUzhhRitpLzJhUHJK?=
 =?utf-8?B?UkFvR0Z3Q0tjdEhCN3ZCK3lBTW0wYXRzK2dTejdwQ1lCb3grSDVyb3k5d2Z2?=
 =?utf-8?B?bkF5cTg1clR4WEJIeTQrV1J4NDRBeWNMQVYyNVZHeEpCZ3JmUWtlN0p0Z3FR?=
 =?utf-8?B?dDl6NzZ0bXdxc016N0Q1NWJnaFhVdEh0QWhqcUJscFM1dWpjSng2REdjRVFP?=
 =?utf-8?B?NTNTWUZ6d0N3OHVGS3NEb1E4b3l1NktUd2FEaVUwQTlQa0ZtdW5XM0N6WXR3?=
 =?utf-8?B?aEhiUGhkSW5heHBESFJDTU9GSGlucDhaTCszTWphWjViTkRXa28xcHc4bGZU?=
 =?utf-8?B?bEhGSUNXdnNodzdNU3N1V0R5bjZ1Vi9KVVh5bzhYcnRQdlZVNGZWczUvVmcy?=
 =?utf-8?B?ejRhSXRmYjBGWTE4cExqV0c1UWxneDNjY0RuOXhBYmpZL0JwbXg5eEVxei9p?=
 =?utf-8?B?YXM4Mlc5enkrckdtcUpPYy9LMG9IakRJTjU1bUZBM1BLR245czNDRkxSU3Ey?=
 =?utf-8?B?dyt4UzliNXJ2UXdONk9nQUZibU5QeHZhYXpuUnB6ZDBpSlQxSFlxQXpxVWtx?=
 =?utf-8?B?U0FMbUVnMHltSythTzJnMDFJMGNHODNaUXlzem1acUUxRmhxdGZhc0hob0NB?=
 =?utf-8?B?ZXRsOUNrV2s4bFFOUFJ1cnBmM3c5S05MNXJOSmxZQnRrNWFBZ1ZQV1Q5Zk9r?=
 =?utf-8?B?ak4wM0dIY2lqQzRwRmhwaW05dDdxVFJJTE5FTzEvdWNFRXl6VCtqTVFhcFFN?=
 =?utf-8?B?ZGRtdnh6T3pFZWF2NWVPSjNmaUFZLzJKMmwxK3pXUEhkUkJacWRUZ1hZMzFp?=
 =?utf-8?B?bnZrTkFwWjRTUC9kRTNoa1RkUVdqKzlhbGZYdFQreTNZRkJuWldrQXY5QjVj?=
 =?utf-8?B?bXR5TG5ScHRkTXU1SXpNMEttaUF0OWlKR1pPU2NMS2dQTkgvdFpBRlhNU0lw?=
 =?utf-8?Q?c5BfyJZubkTfTpBnTghzgOYjT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b229d7d8-207d-4f63-3ace-08dc7bee9517
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:39:41.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+b3XVCG8t2uHxm7aBJ9SCBxDVxrbAySDVd4OTnZYuWsa4yl4GrKcmNLfQdzqScbXOw0vb5El1u8IEGGEQsTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417


On 5/23/2024 7:11 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 23/05/2024 4:19 am, Ashish Mhetre wrote:
>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>> PTEs after clearing them. By updating the __arm_lpae_unmap() to call
>> dma_sync() once for all cleared PTEs, the overall performance can be
>> improved 25% for large buffer sizes.
>> Below is detailed analysis of average unmap latency(in us) with and
>> without this optimization obtained by running dma_map_benchmark for
>> different buffer sizes.
>>
>> Size  Time W/O        Time With       % Improvement
>>       Optimization    Optimization
>>       (us)            (us)
>>
>> 4KB   3.0             3.1             -3.33
>> 1MB   250.3           187.9           24.93
>
> This seems highly suspect - the smallest possible block size is 2MB so a
> 1MB unmap should not be affected by this path at all.
>
It will be unmapped at 4KB block size, right? The 'size' passed to
__arm_lpae_unmap will be 4KB and 'pgcount' will be 256 for 1MB
buffer from iommu_pgsize() unless the IOVA and phys address met
conditions for next bigger size i.e., 2MB.
>> 2MB   493.7           368.7 25.32
>> 4MB   974.7           723.4           25.78
>
> I'm guessing this is on Tegra with the workaround to force everything to
> PAGE_SIZE? In the normal case a 2MB unmap should be nominally *faster*
> than 4KB, since it would also be a single PTE, but with one fewer level
> of table to walk to reach it. The 25% figure is rather misleading if
> it's only a mitigation of an existing erratum workaround, and the actual
> impact on the majority of non-broken systems is unmeasured.
>
Yes, I forgot about the workaround we have and agree that without the
workaround, 2MB unmap will be faster without this optimization. But
for any size between 4KB and 2MB, this optimization would help in
improving the unmap latencies. To verify that, I reverted the workaround
and again got unmap latencies using dma_map_benchmark which are as
mentioned below. We can see an improvement around 20% to 25%:

Size          Time WO Opt(us)     Time With Opt(us)       % improvement
4KB          3                                  3.1                   -3.33
64KB        18.6                            15                19.36
128KB      35.2                            27.7            21.31
256KB      67.6                            52.6            22.19
512KB      128.4                          97.7           23.91
1MB         249.9                          188.1           24.72
2MB         67.4                             67.5             -0.15
4MB         121.3                          121.2           0.08

> (As an aside, I think that workaround itself is a bit broken, since at
> least on Tegra234 with Cortex-A78, PAGE_SIZE could be 16KB which MMU-500
> doesn't support.)
>
Yes, that's true. For 16KB PAGE_SIZE, we need to fall back to 4KB 
pgsize_bitmap.
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index 3d23b924cec1..94094b711cba 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -256,13 +256,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte 
>> *ptep, int num_entries,
>>                                  sizeof(*ptep) * num_entries, 
>> DMA_TO_DEVICE);
>>   }
>>
>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg)
>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg, int num_entries)
>>   {
>> +     int i;
>>
>> -     *ptep = 0;
>> +     for (i = 0; i < num_entries; i++)
>> +             ptep[i] = 0;
>>
>>       if (!cfg->coherent_walk)
>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>   }
>>
>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>> @@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>> unmap_idx_start;
>>               num_entries = min_t(int, pgcount, max_entries);
>> -
>> -             while (i < num_entries) {
>> -                     pte = READ_ONCE(*ptep);
>> +             arm_lpae_iopte *pte_flush;
>> +             int j = 0;
>> +
>> +             pte_flush = kvcalloc(num_entries, sizeof(*pte_flush), 
>> GFP_ATOMIC);
>
> kvmalloc() with GFP_ATOMIC isn't valid. However, I'm not sure if there
> isn't a more fundamental problem here - Rob, Boris; was it just the map
> path, or would any allocation on unmap risk the GPU reclaim deadlock
> thing as well?
>
I am using kvmalloc() here to create an array which is used to store PTEs
that are going to be flushed after clearing. If we don't store them then
those will be lost once cleared and we won't be able to flush them.
I tried using GFP_KERNEL instead of GFP_ATOMIC but then I am getting
warning from might_sleep().
Is there any other alternative way we can use here to store the PTEs?
> Thanks,
> Robin.
>
>> +             if (pte_flush) {
>> +                     for (j = 0; j < num_entries; j++) {
>> +                             pte_flush[j] = READ_ONCE(ptep[j]);
>> +                             if (WARN_ON(!pte_flush[j]))
>> +                                     break;
>> +                     }
>> +                     __arm_lpae_clear_pte(ptep, &iop->cfg, j);
>> +             }
>> +             while (i < (pte_flush ? j : num_entries)) {
>> +                     pte = pte_flush ? pte_flush[i] : READ_ONCE(*ptep);
>>                       if (WARN_ON(!pte))
>>                               break;
>>
>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>> +                     if (!pte_flush)
>> +                             __arm_lpae_clear_pte(ptep, &iop->cfg, 1);
>>
>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>                               /* Also flush any partial walks */
>> @@ -649,10 +663,12 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>                       } else if (!iommu_iotlb_gather_queued(gather)) {
>>                               io_pgtable_tlb_add_page(iop, gather, 
>> iova + i * size, size);
>>                       }
>> -
>> -                     ptep++;
>> +                     if (!pte_flush)
>> +                             ptep++;
>>                       i++;
>>               }
>> +             if (pte_flush)
>> +                     kvfree(pte_flush);
>>
>>               return i * size;
>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
