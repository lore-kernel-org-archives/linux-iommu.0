Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536833065D
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018229; cv=fail; b=LEnSPa0IxJ+TTqAYZYJMVQAxYhzK6STwbfgNUC7ZB6LjOmW9/4kghp+s2nvnnfQ075KL1nMHwGqnfjnEIu6+I2GLKuPQ+RRaBfJHhf3hZFFj/ZMP+2eJiJErykn+fDu6NIzprjjkCTnjWdsQwnYoLlOqTWxWPcyeddFqyaJHh3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018229; c=relaxed/simple;
	bh=CIcYUZQ8eHjGRCOdXlUs3gYgoDd+NuH7yrUdZWs1weI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VHg5oUMM4SltFQVH7kmU68Y7P3cpBpXvxTJj/MAkDp09fweS42IdB9u9JrGQvjuLZCG2A8Svpgb5RmBG7hT0aAPb78hxShZZJ3l1MtQF1SY68q+S+UUAgEMN2ldnN9vX+qZidulVu6yWrfm92LkW9NUJ27/1CjC16rSgRhMmwog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BX6LRosP; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BX6LRosP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg/cpjgsn5mByycTXqlByPKUvJpKAJDVaVSTMiYAXOx+u/VVB9sKqi88c/FKJA1cjZ8x6+l6oF5adFNT3j0MVwIJHD0LN0ulcpIyfA3tSyD+sTxBzYe9Hj+FHVGyfwYBqpVHfW2Es5Lz0mZS3e3LtQtodQZFRhV0DInkiuM1fkxkeSBb7j+8K6nR/+uugz2v1uYJr5x4BI9AozVGqE4G0zYH8wHIgFp6w4tulaa96bADpCWe4Tj3TSww63sKXywsu4URz1PnEpaaKk3DM0BjM+8ZwxznW/NvydPtg+iVQqpYLXaWx2FA/dfTpL4/VvTil5SE5zLmgxRhrr4AliQhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7X8TvTl/ZMwWzxwVLrpD/kk3V45DFK0S/NPVq8+CNL8=;
 b=LZa8CGWQzB80OtpvcFm4peZEKbI7B1vQegVF6Bc1PBZux08QzZk+HGPlBaIIQN5g1IBVLXcM2P7pybNFsh4Mq1s/HvUhQl2n83w7f4swQzzPT9WfcaZSQVh2yqI3pAnWjSZ3gp3FQW9dyL9o5hm4nUQrvVz5zEbVnIIVOQFzxHPy9yuoaxLHJQPY/G1tk95sq/u42b+G9nkggZlbvR+oCNml9Y6eeK/neUVU/H3G30IG7YXdGzgHSUosUfvY2LjVVhZqdwso7kDfnRFQOTXdDPWqXv1bj2Ko1ojC/hShOs992XpQo2Yqwqv+Smijb9NDLiBZfPysSctG2+0BZTkH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X8TvTl/ZMwWzxwVLrpD/kk3V45DFK0S/NPVq8+CNL8=;
 b=BX6LRosPTNTsOKzpdSwSAA68r46oP+vByoArZQ/m820LUhwPRFU9/p8s1DZcVB8vDXC7krBTs4JQlsUa5CCm1hn1e78F5HKVqOF6qS1w9peFVr/5XOP8hzq28Eu0xTp+F5yjvAO3jx7YOtQl2yiiy66bXj2nEwLeG2Q6afr1USk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:10:24 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:10:24 +0000
Message-ID: <01ab16bc-075e-4537-b4bf-f6c192c55bbd@amd.com>
Date: Fri, 24 Apr 2026 15:10:16 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD
To: Yu Zhang <zhangyu1@linux.microsoft.com>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
References: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 518f3910-9c19-4d16-b8bf-08dea1d8eec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yapE3s/Dm4PoRh4LUiWGrimgoqjFW1uArct1sEjMJ4WAPBhdfiDgYtrkkGFstR0azxhUUAIudolQ6tUtame+qZC3bHV7QDmK2epF9Ah80jABLSwGiou3cYhV/MAw+VvwvT/Qo1+PjencWKtsXd0ZVXjT6dIEBQcL+TWSrNYcRpMHBPvw+eefWYJKbsMGr3EdfRnpES0FLyCbr8DixjRpQQyZOURA5f5vKnmAgFloRCkv6Jk7eag6KYgd2YMYzuudQVJte42b1cwjp/aofT/Gwwz4R/SBZrMj2Ciz3tjcfo8gikVMnEX92OvQWHEOu8Prn1gYKUdOovelDCv7s5PvlRXzjx8KQMGi/PMbSP/EcMc61QfCR+5UZLWK+1xw20JjsUPqxB+FVvH7B8DPTkSWPH+9NxaAeSsU+nog8W1QMOfzmIaJ9953iAo35OV4lw/yFPPdVvukqbN7moRPBMjKy0G6K1mjm5nodKP0PW8nAYWsJC7BNhQxh9hCcZzTpED9usUiLpgaoCT0DIJLdh2l/dgX8ocAVqeL3f197VSNdiqHMMhUCBxgpPQsOoPmRZNlFuAf02Z6vWzAuj8i+b5Ch0IOVV3JjF0Nq53r2pixXRKX/0eV9mqyCVbPDlZvmhY6q5Ly3byAhnu/93FeSJX3FJ3RRkj/VBEHRciONufVl0UswdDlOdm5UZLNYHZDHCfQsnrXOX++ZsaQ7re25ruck8qpimDYwUUX7mk0MOooaH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlY1aWpWSnlKTG1nMlNrY2FkSzZadk1tZCtweWJmRmpCSnYyWG5hR3NnRkNo?=
 =?utf-8?B?b3MwSElQbFBvT00xR1NHRnRhbW01SXFTbGdyUXpEUHNZVEVQSzExZ3NHWFRi?=
 =?utf-8?B?cEgveDhTcGd6VHhlWVptTXNBQUNFMWoxSFM5T1l2SjlScG1MRFd5V2d0aUY2?=
 =?utf-8?B?NEZnUkY4QlBBT2ZPbFR1SCtqNjBCSm9ZZFFRb1pXWkVWdWJ6ai9hbDBtVm4r?=
 =?utf-8?B?NGU1RjJPTmt1NWx6cHpxVGdKZmRSY2l3akk4d09ocFZiZkRRbFp0eWtDZ29M?=
 =?utf-8?B?NnVRYzh3Tm1HMmFIOTY1b2lGVzNqRmFnd0hxcDhnSXpWeitCcmU2SnF3V3RF?=
 =?utf-8?B?YjVMQlNKV05mTjk1elJnWENhNDJLdlU5T3FEZkxmVWZ0U0oyNXI0R1czNVVR?=
 =?utf-8?B?eXVMYTdlN1VYTjZRSHdXYTdiNGZBdWx5Zi9TNVhpQTcxUnMxVUtvZzIzdTBw?=
 =?utf-8?B?c25DcVQxQWNhUE9uQW1LOWVwNXEvK0NIdTM2dU50TlJTMlRaalQxaGtvd3BP?=
 =?utf-8?B?d0N6MEt1c2FQbXk2cytEQkJvZTFlbEMwazZFUDBibURKSGkxTW1hZm9Sd1I1?=
 =?utf-8?B?U2ZsaUxMWUVkVnN5TlhpTi9JTXhIWldRUmk5MWlqRlVjeWw5OHQvK3ZWRW42?=
 =?utf-8?B?cWJ3cExha20zRUhCaFZlVTVaNTgzZnZSZmxxVVNSZzhSS2gyYnlrMG5oQlVM?=
 =?utf-8?B?L1JxeS9yb2ZNamFZa2RKU24zR3RNVm5nNjJUSysyWFhTTk5PbHNXd2Q4T1pm?=
 =?utf-8?B?OXZwOTlMZm41Z1BGNkJzcmdMd3ZwZHIzY1RJYSsvU0IyK2VxbURjcHpXdmxT?=
 =?utf-8?B?ZEJqQWtiQ1NUNWRJVDV2amI2Z0J0WlcyeUQ1cU56c2tLVW50M3h2WmgzNTF6?=
 =?utf-8?B?ekFTWUNuWHIyZUIrRXdyMExJN2ZzcUNaZy9waW9tOXNHbC9uWUpCSEM3MFFV?=
 =?utf-8?B?WFhTNUhSVWxZQU9nOXNzVUJzY21icmtmNkpuREVUckQ3S2NmbmliYXdmOXB4?=
 =?utf-8?B?RVFmWGdydFNmZnRURzVROWpPQ1NEQlY1Y2xZdFdoUUd4WUdydVZFYkZ2NnBT?=
 =?utf-8?B?ZVVBdUdMRG0yMkdORisyZFRRVmpTaFBXMDVIM3hpeTFIYklpVWJFcGs0NWp6?=
 =?utf-8?B?eDB2STVJUEpqajRjSzBGV3VXSzVLV2ROQTBKdmVJOUtRQ2ZVNmxHSGNtVGRp?=
 =?utf-8?B?UWM0WkRETm85eXRGa1BzNTZVU1FDZGxBajlEKzN2NGRqVmRhbFNpUGNVY0pu?=
 =?utf-8?B?R1MrbldYM05jVlN0b1VZajYzcjBuZDZaUk1KK2lLZ3dpdjZZd0haTUhKK0xH?=
 =?utf-8?B?MSttN3BlczZwaDZFdWYwdmZQUng3UWtIYTN1eFhiTnVTOER5Y3M4ODdDMm45?=
 =?utf-8?B?cTh5NkZpRytVWk1QRE1tQ09YS2FVNGNvWVVZNjVscm9pTWNUQUdvRXg3alVz?=
 =?utf-8?B?UmdkSS81MDFFT3pNWUVQK3NINnI0Y3BWc25SRjU5Uk5hRDZiVTNNUm9rYktq?=
 =?utf-8?B?R2J1SlRjL0pNdk00Y21JbWFWbE8zTkNxelFtd3BEVWhzMHRhN0UrSU4ybk9i?=
 =?utf-8?B?THNGb0Rqd21Fa0JTK1VFL09XTlhxamsrK2Jmbk9XQ2V3b3NvaXZzZWlNRWty?=
 =?utf-8?B?cjRrM3hKcGNxYVlxcnZlcHo5OHNBa00zWUNNUUR5aCtIYjJZajNYOFVMdzJP?=
 =?utf-8?B?Y2VtczVVZlF5WTU5b0FkSVRWdGtxdEZCbWJOUWtneXdFSUN1cVE3KzIzYU8x?=
 =?utf-8?B?a1QrMG9jMUFCTFZkaFZiRFc4V090SmdSeU8vV0Nkb0Q2T2czZkhQQnlBZlJY?=
 =?utf-8?B?NENFa0puM2hQOFNnT2phNFlWeWFHOW5PaHBjRG5raGtpRTBSR2VvY2x0dVdo?=
 =?utf-8?B?bVd3WWtOSkg1S1NhSE54TGFvTEZIYWdNMG1KSWlwWFdLNkdaSUdMZ1RyajBX?=
 =?utf-8?B?a2ZCdG5EbitLdDJ0dWJFUVBHWndRUTJiZ21xMW1PWjgrZ3lGMFV0RHZneEll?=
 =?utf-8?B?ZzVEaDJyNHZ5Z3JocmhpT0N4Mm50WngvTmg4ckVOYWRFcnlXalBhRWJOb1l4?=
 =?utf-8?B?aUFsbG8vMldSNkIwdERFeHFkZi9DQWJiTkl5WkMvRlN1VmE4MHdzc0haK1k1?=
 =?utf-8?B?R2RyUjZkZFBlOXlkU2FWSmlQamdnQXRZMk1CckZoWmljTjJrNy9nVUpSdzBv?=
 =?utf-8?B?RFZGOGdoYzZ6NnpPWkFWQjI2RFBJR2REcE9nVXQ2Q3c3YkErbWdPNW9DQXBP?=
 =?utf-8?B?S3R2QUdjRXlKMjVhaG5TSEVBcGdLQVNyNkdsU2xhanNjLzNZdXgvRnRNM3Zo?=
 =?utf-8?Q?RUsnCFDLVHejQUAfmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518f3910-9c19-4d16-b8bf-08dea1d8eec4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:10:24.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHSPSlP6qqTnKWf2dBq9J9vVY6bxEaXTfzBQXntZ1s4ozCD7Ce/ASmgljlBSBj8rkCqiEognxIVKWeVcVbGTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055



On 3/31/2026 10:25 PM, Yu Zhang wrote:
> Exclusion ranges in IVMD are treated as unity mappings with r&w
> permissions since commit 0bbe4ced53e3 ("iommu/amd: Fix the
> overwritten field in IVMD header"), using 1:1 mappings. And IOMMU
> Exclusion Base & Range Limit Registers (0x0020/0x0028) are actually
> no longer used.
> 
> As a result, several definitions and code paths became dead code:
> 
>   - exclusion_start/exclusion_length in struct amd_iommu are never
>     assigned,
>   - iommu_set_exclusion_range() always returns 0 now.
>   - MMIO_EXCL_ENABLE_MASK & MMIO_EXCL_ALLOW_MASK are only used by
>     the removed iommu_set_exclusion_range().
>   - DEV_ENTRY_EX is no longer set in any DTE.
>   - IOMMU_UNITY_MAP_FLAG_EXCL_RANGE is no longer set, thus the
>     IOMMU_RESV_RESERVED branch in amd_iommu_get_resv_regions() is
>     no longer reachable.
> 
> Just remove all of the dead code. No functional change.
> 
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h | 12 ------------
>   drivers/iommu/amd/init.c            | 23 -----------------------
>   drivers/iommu/amd/iommu.c           |  3 ---
>   3 files changed, 38 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index c685d3771436..a481d8cbd053 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -50,10 +50,6 @@
>   #define MMIO_GET_BUS(x) (((x) & MMIO_RANGE_BUS_MASK) >> MMIO_RANGE_BUS_SHIFT)
>   #define MMIO_MSI_NUM(x)	((x) & 0x1f)
>   
> -/* Flag masks for the AMD IOMMU exclusion range */
> -#define MMIO_EXCL_ENABLE_MASK 0x01ULL
> -#define MMIO_EXCL_ALLOW_MASK  0x02ULL
> -
>   /* Used offsets into the MMIO space */
>   #define MMIO_DEV_TABLE_OFFSET   0x0000
>   #define MMIO_CMD_BUF_OFFSET     0x0008
> @@ -231,7 +227,6 @@
>   #define DEV_ENTRY_IR            0x3d
>   #define DEV_ENTRY_IW            0x3e
>   #define DEV_ENTRY_NO_PAGE_FAULT	0x62
> -#define DEV_ENTRY_EX            0x67
>   #define DEV_ENTRY_SYSMGT1       0x68
>   #define DEV_ENTRY_SYSMGT2       0x69
>   #define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
> @@ -384,8 +379,6 @@
>   #define IOMMU_PROT_IR 0x01
>   #define IOMMU_PROT_IW 0x02
>   
> -#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
> -
>   /* IOMMU capabilities */
>   #define IOMMU_CAP_IOTLB   24
>   #define IOMMU_CAP_NPCACHE 26
> @@ -680,11 +673,6 @@ struct amd_iommu {
>   	/* pci domain of this IOMMU */
>   	struct amd_iommu_pci_seg *pci_seg;
>   
> -	/* start of exclusion range of that IOMMU */
> -	u64 exclusion_start;
> -	/* length of exclusion range of that IOMMU */
> -	u64 exclusion_length;
> -
>   	/* command buffer virtual address */
>   	u8 *cmd_buf;
>   	u32 cmd_buf_head;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39efb4..a33bf3f5ed8a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -352,28 +352,6 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
>    *
>    ****************************************************************************/
>   
> -/*
> - * This function set the exclusion range in the IOMMU. DMA accesses to the
> - * exclusion range are passed through untranslated
> - */
> -static void iommu_set_exclusion_range(struct amd_iommu *iommu)
> -{
> -	u64 start = iommu->exclusion_start & PAGE_MASK;
> -	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
> -	u64 entry;
> -
> -	if (!iommu->exclusion_start)
> -		return;
> -
> -	entry = start | MMIO_EXCL_ENABLE_MASK;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> -			&entry, sizeof(entry));
> -
> -	entry = limit;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> -			&entry, sizeof(entry));
> -}
> -
>   static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>   {
>   	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
> @@ -2891,7 +2869,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>   	iommu_set_device_table(iommu);
>   	iommu_enable_command_buffer(iommu);
>   	iommu_enable_event_buffer(iommu);
> -	iommu_set_exclusion_range(iommu);
>   	iommu_enable_gt(iommu);
>   	iommu_enable_ga(iommu);
>   	iommu_enable_xt(iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 760d5f4623b5..4e7f5b993c65 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3076,9 +3076,6 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>   			prot |= IOMMU_READ;
>   		if (entry->prot & IOMMU_PROT_IW)
>   			prot |= IOMMU_WRITE;
> -		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
> -			/* Exclusion range */
> -			type = IOMMU_RESV_RESERVED;
>   
>   		region = iommu_alloc_resv_region(entry->address_start,
>   						 length, prot, type,

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
