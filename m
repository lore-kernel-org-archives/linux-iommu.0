Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B461562617;
	Wed, 14 Oct 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998599; cv=fail; b=hr8og0IArl1WN0AuatZZOk85BWOD9UN7/E8q257k0+vJyl4HZlMFEnKzdcmrzXqFb+2SP5KI7NCHCH+PxZJESogPmMZZmZielm1yDViqWfWCT0ZMRCt19Py8/A6JTg/pt1VW4TwFqYmwOYLcRntflAIu7WgtKqGoZ6OzSlaMLfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998599; c=relaxed/simple;
	bh=fgFSHPfGjd0NI4bE+Izn8WJHUs/Yfu0SkqNPxD1/iFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHi/UmCsKl1Rf6wbUaQYNPiYWw7mZmasHusiEc5+t5K1LmMia/gWi2KkSX1TZHBhmk3rcsNLaYrT8dAxVbFRQthyzIc2g/1f9hiHi8yhBJiQPGFeovpgTOsLTzmDowPGyyjngRNcwHjrx0YGFPHRjm6e/P9aDqaHQDb1EbZfsfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bVb1rV2Y; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVb1rV2Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/kdN7tyiwnjtlCf1e9V+9vBvyugFIdGz9p/7DeTaGKyeHhC+0/ZT25k5NXtmDuCRtHE7fipqp/SJmxfjfLHIj0z0i8m2inEKeJlj6DwYgPPJZKpn1VdfFYhRy0zCRkhbdBXZ2gmQKAzQPc7TYXX2FJ1F98duHi89EXrqJ9ilZOC2/mxRSLJXR/57e3wY8898FiGTbk550C8JZyqnAjRtBXRqj6ePY4MJHbR4J8I5ooAi/8SywVPfXSP4MozYPRK+A97g3yhssai7309C21T+Ga7GSKTm1rpCIPcstHaOCEU/kKbGy42C0sD5rmzgWtIAX+L75OupEansQdz9X/kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU+Q0ZM+OtCWWIZfUckYUcSDo0oKVok3eFxG30959Fw=;
 b=XHqo+ELHVS2bLufhv1Rr6p2K0pjK8YhD81bEhoEwI3E82izUIJoimfmaGq6l5naLlfJFU684TtKkhjaSt9APLhWuU70MeZYacwg2pHZys7MW/HsrdLvTwC4BKWA71AKEFCAQr7toS8h6hqSWtJUliGl6JSmKHQTLDzsTuRTiJCaKVo/5Ah7gGsKzb9dFXUrjQWfpvVPSbzzc7czq4OSh8kttJY+MxUtA3+J5XFywn6S9cQVxm8trUGNh9BzuJ1NwDe653gS91Z61ylZdMGnhFUCJ8jOASoktTj3N2sve4K1C5xeI7/Pe2zOSph3Zyv5LXYn5hjvF7ShQt9JYIugOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU+Q0ZM+OtCWWIZfUckYUcSDo0oKVok3eFxG30959Fw=;
 b=bVb1rV2YB3sYdyPeaJ9s7bBe118hWmsUCT60Duj0ombLjLAoxG8YVaoBoIoz0wZ3GnVBF/ldbodVfZtLJdT1bwgh5QsZ0+vXEzl5mMaillUZNvzm6TIJnoYcoCAJE+dL19j9aY/0Z1r+bsVRV35CGh1zilPQ/kdsriq0FfXOoXEEuVlV94XgSvBy7fTuubj50BcH/+WIeURMDndNzoQlv6NlZlSToBA9AWwbz2EOihCHt2k5YHJYAxGmpRLJ1sR9nV6PPp2/MAujZA2C4aLmMfKT6Nsw+AlFpoNRAcZFojd4G/S++GfCyqNmgkLQMMvTQLe4i4Sy6KmiPEg1PEgwWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 17:23:08 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:23:08 +0000
Message-ID: <52a702a4-14eb-4617-bd29-e3140fd36780@nvidia.com>
Date: Wed, 14 Oct 2026 19:22:59 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
 bounce buffers
To: Luigi Rizzo <lrizzo@google.com>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003212241.3432303-1-lrizzo@google.com>
 <20261003212241.3432303-20-lrizzo@google.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261003212241.3432303-20-lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: a86ad3f3-750b-40c1-a83b-08df2a17d09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|921020|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Jpc7nkYl+/Q2vfpm+rCIIhwidKrjEo16BaCm2gD4ay+fhx+f5FJBsJjJpsBHRt7AW+tOzbp2lL4wUDzHya0A3ZScVRreeKscojdhh/2Ke73mGgwBVLRpRoSJE3TOlMJrsFHUvuZvk/4agPLe0qRo8IA3iHSdxKMk++4ZWyYqatvfy0Mp2D9GZibIjom4fqwqwEBKw3hC4Dyr7bOecJcMu2lKVQ2DX1cTfQfAX5+9upmEa2q5rNRZzvpOPJVVE3VQI2+IEXW+8+lgemyiu09kiO6Zydt1gJp4KUBejTzChltSakVPhsYw55syVgHr5skaW5zVwEl4mcmY0277ZKVRWtZW5uAnzwZDLlN6IoCpDXSl2Yc8/thp9Q1n3hx3HD/0M5iA/8ysLHhfcBZuJAa6vCAQ0/+o0EbvxD99XGzx8YANaejBymnA0hkrl3SSbauNjRO1tzw7eG9xCfdHTmbPE3JOw84IC15oPYOWG/5fY2poGNpJhqnpRXCFEm5YrD6DYs/mnkaKrJfu32ZhqWxxMaJPsnLm8FIoUIo4OFahLwHWnTcvvM6GEbYLXLImijKDG9jVfW8gLJt+kDTuzwDenHLCPaY7CZ8GCg5VTJaIvNF2mR9Wsb1QNdCr5V+MXTuc505leevTZNMBiZQFrUj8S5Udn0gr6Tep1m+kQDrVwCIDR9Vgq4YmPzooCJXFC0syy5ggRjh7br688FFNjCueOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(921020)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTM2WWhDZDdHakxBSGtmNDdibWtXYmxnbHpDblJJVWpCV251aENJRDFCbURk?=
 =?utf-8?B?ZVp5NnNYMUVXS1BKdnVsVFc1L0NocnNjdDVWcVliWFRhK2dvWnoxWDgvT29Y?=
 =?utf-8?B?bHhuSGV2aTYrY0d6R2Q5RHd4NXd1MTM1NUl0Si91V3MrS3lKWFlvdDgzaDB6?=
 =?utf-8?B?emRzbWFQYmIwNWUrWldnNmZBaGVwZ1R3L1FxNmREVzd5REtkbUdCSTFBZERu?=
 =?utf-8?B?Vy9hcy90cDNsMURzRStqeDdPbjdnWDJWQmZHeEtFZUM2bm1KOEFod1dyTFFj?=
 =?utf-8?B?Z2EwMWFMNUthbGloTEhwOHF5WEJCcTB5ZnMwOFh6V0t0ZE9RSXFFU3JoMjVO?=
 =?utf-8?B?KzdGMFVlTXd5OHhjSWRDSURrQmpIZHRoMzlVQU5yZC9TRzFvaWowK3QzeVhm?=
 =?utf-8?B?d1liWis0RVhxK3FZQVRwZEhSaU5zUy9CTUs0bFk3ZzRoZUFyeXQ2Si9LN1A0?=
 =?utf-8?B?VENxQWpJbjBSSk5VMEI5cllnbHRYY1pYcWZnb0NXcTdhR1Fpclc2bWRyck9G?=
 =?utf-8?B?YWlUWXZ1OG9tbHJudGhXMGhFR0VuZ084VXdOaExnMkFSV2ZBd253V3d2ZTJU?=
 =?utf-8?B?NlR3aWp3ZU9CZFltRklGalRNVUdVZG5GWWJHOVlUU1AxcGRlaktkUmhvY1FI?=
 =?utf-8?B?NjdGMjZqV1I1eTJaaWMrTnRTeXE1cnhzSmFEMFpqNkh6NVZEVXJvSzNwdlVJ?=
 =?utf-8?B?OHdhQjZiUjhnamdVV3BaRFl3VFRjMStFd1c1MDVMVmFtUkROWTJOTEcwTUxL?=
 =?utf-8?B?ZmxSMGRBUFNjVXY1eG1UQ1RSUXJ1ODlWeFBHdE1PbTBia29UbmdjZkVpT1Qv?=
 =?utf-8?B?V3RXUTdCdUQzVDMxVC9XQi9SNHNQS3JmUnJnd3p1UG5reEp5bjhaaGdjSy92?=
 =?utf-8?B?bzgwS1FXYUdkUFpnRVpMeHZGSlh2Nzg3WDk4RzllQ3dDYkd2eFlvL21MUEls?=
 =?utf-8?B?dDFTOXM1VCtXNHF3aDEvZzEzUS9xVVU0em0rVktrWVEveDdHUzVDNU9DcnQ1?=
 =?utf-8?B?QktTWWFBc3djT0o3QkQxajk2Z3ZoMVFiaWtleDFrL3E1V3ppRHU4WnpwTmtE?=
 =?utf-8?B?UXhvSFZoVS80MC9LekFtelhCZ0Fma2hqM2dKcHA5Ym03cDZJVTdkY1RPdlFC?=
 =?utf-8?B?QXpGdVFYVERvdHBiMEpncjJRVmNvRGx5cFFyNEZObnpmZnlSaXNxUFJudXE5?=
 =?utf-8?B?Q25vU3JOaTBzdVo4YW1jaWVuSzNzQmt2TXM0T3R4VGp4RW1TRUk5S0RmKzVz?=
 =?utf-8?B?VVRXU3FEZzRXbFoxcTJVdTZDSUptVnBueTdNMkJIVjI1R0hGd2t0N3ZDdWpV?=
 =?utf-8?B?eTJaTjlZUlNacHZ0WkVrVUNGUmJMVGNGNjdoSnQrK0QrRm5OQlVXN0tnZ0hy?=
 =?utf-8?B?Q2NlQnpReFduWHVsRXBIRlU1RHBlK3AwYjZQdmJxaTM3UVA5SmpPU1B1eFor?=
 =?utf-8?B?ZVNraUMyUmRkdk9CdVJrVE0rRUZITVZQWjBMOE1MY1lodHllVG1ZekJreDJQ?=
 =?utf-8?B?Yjl6SWxuZzdsQ3FpOWdvdmVwdFRZZDVCUG94aDNyZWs4ZGtaUCs1UnpHSzVp?=
 =?utf-8?B?S1RaY0hzdStkV2c2Qmh5VUcrN04zblJINDZVZmpnampMTU1nN2lOODRIam93?=
 =?utf-8?B?d0xNMTBuK0g3UFRWT2tGNFh4MWplVzFVNXJNaktOUU5nUXA0UFpadmt4dlEz?=
 =?utf-8?B?K0Y4MGluWHB0RXEzUkRkZFhnRURVNGNDaHBkeTZzOEI4dE01QlpSdytIZXlY?=
 =?utf-8?B?Rm80ZXJvRWNWSmtEL3FwQlV0ZnAzMnBKSTR1TG90VkxJN3pWZll5RGdMbjM4?=
 =?utf-8?B?bkhGRmtDYmUrcXFpUStLU0xiRG5UVzQyQVE5S3JVK3dNLzhCL1hqMytacVBz?=
 =?utf-8?B?VTlUbzRaNWM0VWwvZXZ4Z3labDduRXhvNjNYcGR1V3IwSGRpZ0VCUm40Tjc1?=
 =?utf-8?B?RmdHRzFicXV0bU5ydndobzU2czhMYlY1VzExcVVnVnU2OVlqNFpUa1Z4L1hK?=
 =?utf-8?B?VGJkSjdkbGJUbkpMVDFPT2NkVlNhaFVGMkc5bDRwOXZ4TkxDYllLc21mcEtC?=
 =?utf-8?B?SkxKWTIxTnc1M0MxZU14US80UzdrcG04YlV1VWx6Sm5DMlJhUi8ybGROUUxn?=
 =?utf-8?B?TFE5NjFTSDZRSm51SWYvSGZjSWF6azNSSWRBejc3Q2RtV3FLekVIODRUbUFx?=
 =?utf-8?B?M0ZRUkNoZmFxRWtzZnd1SktheDdJMXlYMEpqZ1V5eUp1emU3ZDc0MlhRSlRu?=
 =?utf-8?B?a2hJQnE5aWkveFdqdmFQby9kVlAxMXJGUVFoTHdwR0s3RzVRaFhsdnhlZDlT?=
 =?utf-8?B?RGl5UURjRUFveDU5SE9SN2VFdmVuNUI0WXQzVjJzMmkzeE1jNENsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86ad3f3-750b-40c1-a83b-08df2a17d09d
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:23:08.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cxCQXw2m7xsnSltg+bUip43cPkYNIDDR7N+YMg6s9sCmWbfKhDnJfDgc4P2tt2d09kO6v5Rbpv9o/iMkz/qLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447



On 03.10.26 23:22, Luigi Rizzo wrote:
> When dev->dma_pmd_tx_hdrs is enabled, allocate a MAX_TCP_HEADER
> bounce buffer per TX DMA FIFO slot out of the DMA_PMD arena. When the
> linear portion of a transmitted packet is at most MAX_TCP_HEADER bytes,
> copy it into the pre-mapped bounce buffer instead of calling
> dma_map_single()/dma_unmap_single() on every packet.
> 
What is the difference between using the DMA_PMD pool or one (or a few)
coherent DMA (2MB) buffers allocated by the driver?

> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 ++
>  .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++
>  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 28 +++++++++++++++----
>  4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index a3945195f454e..d762ad1c1ffaf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -442,6 +442,8 @@ struct mlx5e_txqsq {
>  		struct mlx5e_sq_dma       *dma_fifo;
>  		struct mlx5e_skb_fifo      skb_fifo;
>  		struct mlx5e_tx_wqe_info  *wqe_info;
> +		void                      *tx_hdr_bufs;
> +		dma_addr_t                 tx_hdr_bufs_dma;
Why are only headers considered for bouncing? Because they have the
highest mapping overhead?

Note that TSO/GSO packets will copy the header inline in the WQE
already. But not for small packets.

>  	} db;
>  	void __iomem              *uar_map;
>  	struct netdev_queue       *txq;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> index f2a8453d8dce0..6de7a2a430d72 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> @@ -365,7 +365,9 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
>  {
>  	switch (dma->type) {
>  	case MLX5E_DMA_MAP_SINGLE:
> -		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> +		if (dma->size)
> +			dma_unmap_single(pdev, dma->addr, dma->size,
> +					 DMA_TO_DEVICE);
>  		break;
>  	case MLX5E_DMA_MAP_PAGE:
>  		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 4c6060d54fbed..efd766aa43a02 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1666,6 +1666,13 @@ static void mlx5e_free_icosq(struct mlx5e_icosq *sq)
>  
>  void mlx5e_free_txqsq_db(struct mlx5e_txqsq *sq)
>  {
> +	if (sq->db.tx_hdr_bufs) {
> +		int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
> +		int df_sz = wq_sz * MLX5_SEND_WQEBB_NUM_DS;
> +
> +		dma_free_coherent(sq->pdev, df_sz * MAX_TCP_HEADER,
> +				  sq->db.tx_hdr_bufs, sq->db.tx_hdr_bufs_dma);
> +	}
>  	kvfree(sq->db.wqe_info);
>  	kvfree(sq->db.skb_fifo.fifo);
>  	kvfree(sq->db.dma_fifo);
> @@ -1690,6 +1697,13 @@ int mlx5e_alloc_txqsq_db(struct mlx5e_txqsq *sq, int numa)
>  		return -ENOMEM;
>  	}
>  
> +	if (sq->pdev->dma_pmd_tx_hdrs)
> +		sq->db.tx_hdr_bufs =
> +			dma_alloc_coherent(sq->pdev,
> +					   df_sz * MAX_TCP_HEADER,
> +					   &sq->db.tx_hdr_bufs_dma,
> +					   GFP_KERNEL | __GFP_NOWARN);
> +
>  	sq->dma_fifo_mask = df_sz - 1;
>  
>  	sq->db.skb_fifo.pc   = &sq->skb_fifo_pc;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index 0b5e600e4a6a9..3b6a7a8b0128e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -177,6 +177,27 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
>  	return ihs;
>  }
>  
> +static inline dma_addr_t
> +mlx5e_tx_map_hdr(struct mlx5e_txqsq *sq, unsigned char *data, u32 len)
> +{
> +	dma_addr_t dma_addr;
> +
> +	if (sq->db.tx_hdr_bufs && len <= MAX_TCP_HEADER) {
> +		u32 off = (sq->dma_fifo_pc & sq->dma_fifo_mask) *
> +			  MAX_TCP_HEADER;
> +
> +		memcpy(sq->db.tx_hdr_bufs + off, data, len);
> +		dma_addr = sq->db.tx_hdr_bufs_dma + off;
> +		mlx5e_dma_push_single(sq, dma_addr, 0);
> +		return dma_addr;
> +	}
> +
> +	dma_addr = dma_map_single(sq->pdev, data, len, DMA_TO_DEVICE);
> +	if (likely(!dma_mapping_error(sq->pdev, dma_addr)))
> +		mlx5e_dma_push_single(sq, dma_addr, len);
> +	return dma_addr;
> +}
> +
This looks like a form of tx-copybreak.

Thanks,
Dragos
