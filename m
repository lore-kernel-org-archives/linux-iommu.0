Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3410377AAD;
	Wed, 14 Oct 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000274; cv=fail; b=EeVlKCX1xUnx9Idi3aNir++GhdZFgAZqdq/gnNJmmLqinobnbdSn5U4d+dOCbgPH/+cNMtU8vd+QbMI2g+EMR8j/iTZl9DQXTwnNUJegO0DlPKJtV7wdGGUU6pGt41VzbjCjX6iTO2D9V031DrByqiGTHpQk3o2afoGT6Y+geCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000274; c=relaxed/simple;
	bh=cSsCBuAonnjZExsZISPhlkZ/8f0StFX/HEcB81FyR9A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufH37WeVVhUTjodSW6vnJdwDDhKs2v5qliY9PPMwFtDUUuR6EcIHau9s7JISCQFn23hIcSoGzk0PvrzUhseBpKcjqHkdchW++6IskC5Aw8dFeSZW4i7myYzkqY5PUYdZ3zd+c84d+8IoVtYm5lgdsScf9k2hqvXSmsgFDxMowNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cM5EmzzT; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cM5EmzzT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGBQSMOeVHXy3PCmDXjac7PM64zpP3M60B+nalsJWgSJ4ZW6VgdKHlHb3JFge5F8GuBY1bqPLZuUyBbjkedm/BH5DPuUtdW9KDYeLyOqLEEBPmmn3SFbgvMhBPOaoEZVJIUOlXGPkbyi8wUV/cED1VkYlLHF42jbh6UOwTwpMWNT/dzATQOpsFLv+igkSDIi+jfuycR6epxNnPEBwQNL6WmdLiWulYbSt9okXHdZatKlFhyGHn3IuS9dFQDwkSO5HZ9ACrN7GizvTH9TxdGMyRCkeGuoM5jqVl0TxZaAhK1b0DcgXGXj+tPmXQ5QXoygXeZAA2MF4rMuo6w9Eh8D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mq/CqTyBBCzihJZtGt0D8lTwvPcrcT7cZ6MxffIikI=;
 b=rKuxjhqNGdAzEmqWuXILjmuxkIXYxMzTgChfNz2+fwVWfmAxGao/cfAZkbTia2JGAuOJz3WVZ9/Kvg9jim0JNhEG5caqyXGfk8qfv+QWw/fbSYCOtTd8+aRhB6hnffhrKTvIDiuWj/kaKDwLELTwIe35CHkWoHLl5Euui2RsRydQuUWu6gJRkgoT9+TnD3fda7x9HFpLHn/mHVBDq/az8CQRoT44BTJhbXIG6RmEaNzJWqYc5IlyWTQ/mLvRsd3H63CyimD/USBIAOFOr9sPAremdD2acyzDyEsan3+UWWdUVz1sHFtwtpNLTe3ZsvlfKRb3VTTtBxaAWLt/FbYedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mq/CqTyBBCzihJZtGt0D8lTwvPcrcT7cZ6MxffIikI=;
 b=cM5EmzzTKi1BXtcBUz7+LTz+zfHw8djTKHFi4NZWXxJQBN1uq/BZmDlnak8C7TzWS8FdBR8lYyTuNy7D7HHQZRDZmPrfQB/3FKW3B4fmhWfRn9knzrSl9JuEjxikGJ5DAjgX+lJxIPiNJVSewvGQwqfg1toeX0A7ywoBaqE1NRqdtmJQQa+mSw+O1U8F2w5g/MF5aPtRQ+4dPu4m0loVtyH3qXb94ONAe7w/R9d/a0IfcmLfuzKBisHTQVtgsKnQkZfGsR2QFf6Z4R/yLedzniQ7CvOxSt5BvLLh6nSItfVa/8J2LNrp5okd0lOHbi57snSbhtDiubKcobAaVbFlgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 17:51:04 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:51:04 +0000
Message-ID: <afff5a1f-000a-4216-b4df-dd3d0406047c@nvidia.com>
Date: Wed, 14 Oct 2026 19:50:55 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC: DMA_PMD 19/22] net/mlx5e: Use DMA_PMD memory for tx header
 bounce buffers
From: Dragos Tatulea <dtatulea@nvidia.com>
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
 <52a702a4-14eb-4617-bd29-e3140fd36780@nvidia.com>
Content-Language: en-US
In-Reply-To: <52a702a4-14eb-4617-bd29-e3140fd36780@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c23e81-7b5a-4899-5b1f-08df2a1bb78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|921020|4143699003|261009223027099003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oVFDTws5nvjVH8vrQyLgsfySZL+FktAjfQZlR4/HQDJKPJRgEbID34pN4U9HgAHLGGodBV054B7J35mt1T4PPGg1SbyonKFzH4M68tj+gE8nLD7JdQs8xayLKRifdndSaoTijT9Uh4//Wpf85/wsSYBBdYv0hRJr21VeLINsnFnHPieKb2m1qy3VGqSCB7fxR2W98pjmYMzlZDCKSp8MxXGOGf818daHeZVmTq/ZDbi9juHwaDUzlGd7A0UT0Bf8MrHxIhvLUgfs+xvuIMICTPx37N0RrL3Q1r/kzYs2IzqMp+sWpHjDuSnPlUHxyi8faAZ5VA606zetcFCalTfrFyc0XCJxJXltbf/Zn+1RitQdsTB4cEaGyzm26M3JRKF3Fb/yRxXuHLAYmdDWmSkXbpAASHCMPL31TZ4UE9/1qBUfaNEa4ZYOLUq5Ib45sB/iQZEgtIpo2HylIra8eSf1MAYHEly6X/zUh51EjqTxCHcjyOWH1+iUn9gjtoLZbDSZCjA8odO7HxHd5oAYGLKRBcH4GS/3jFY9ShnKPO5V7btJNP6yRm31jcYYh570ngw0lZqKZVyePCrImOXK5BlUtupHgGeZPMeIAwNI05pQ4m+zMR0q+itoBW2mXArxh1c6mCCcGMJp4Re/zQDqfKTKUOugpeEbDYw6Wapml4V3eMdLJ8R6nSLscP7u77WcUs/FCzzoSgJQY+ID8bVorN5i8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(921020)(4143699003)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Rwck5hdFFUek9OckpRVW1Vd3gzT1V1di9vSWFLbk5IWEZmT2lwRU1ROWNI?=
 =?utf-8?B?L3VnUnZKd09yUkQ1OXJNTFdWcjFSQjVRYkY2OFpQZ01ZTExhUytpSmI1akt0?=
 =?utf-8?B?cnVxVFBWcWR4V3hBS3VBTVNkOWlGSlAxdmpmNUdWOVRtVEF2b2ZETGJxVy81?=
 =?utf-8?B?ai80TEdVMHZTcG5pS1ZIMzltNkNvczhqcGxldHFMR1hheDBhQmx3S3EzMmxP?=
 =?utf-8?B?UkZBOEYrVFFONjErVVhjVUFiWk5YZ1B5dWtGUW1KUkxYUGxxVm92dThobSth?=
 =?utf-8?B?WGlPRVltMWViRGJac2FmTHF2cGtsWjBqR0JCNE1icEFFeENFbUpqeTlKUENp?=
 =?utf-8?B?bDhSREMzRmRYb1pGbi9JYWpwRGEvWnE1T0NXUmtRenozbEtmYSt3KysrYWN0?=
 =?utf-8?B?UjVuOUMxK2UvdGVWcmQyR1oyRTRXeWdld1hDNDR6eWx5dEQ3ejM5aTh0SVdY?=
 =?utf-8?B?dFc2Q3ZveEQ2UG8xV3kwWlQzTk02WUZOZ1JMN1I2c3o2VTFNSTVvT2NUdlh0?=
 =?utf-8?B?Vm5obXhadEc4OWFxanQxcjF0blVubE1NU2xxVzF6WHNqcTkxMG90aUJ3QStn?=
 =?utf-8?B?ODlvSUsveEIyeGV2QlFHcStMbzFYVXF0cXRXYUtTTDJsNDVhaElHRjVyMHBM?=
 =?utf-8?B?NGtSdXc3L0NzOW9VZlFXdHNDUXRoZk1hL1RmL1BIVTVLb2ZwdE9wdi9tU2Iw?=
 =?utf-8?B?UHZHTzQxdmlDaitGMi9kTk1zUFl0RUVmTkp4cDNVeGI1M2dNN0ZhK0pJdU93?=
 =?utf-8?B?a0phZ1VWL0I2K1RFUFE2aEx5Y09tNkJleHBkUERmWWIxTFdQZmRXOHBmdlhy?=
 =?utf-8?B?eTl6NGdmczlwU25Tek1kOHFKWVZRK1NrbU1pU3NNd08zWXMybUV6R0xualFv?=
 =?utf-8?B?d1RhYmtFdUtDZHJDRHVKQjhzQ3FVR0FWWjhGWEhiOExhUk5JWXkyQlQ5bTZ5?=
 =?utf-8?B?OUlZcmFsZ1h3RVIvdWdLSzFzUHdVeWx5NXFmWkFLekJveDQxSEpNMW56Y09U?=
 =?utf-8?B?TkdBeXBJKzE1ZTZYaXFZeDJ0THJBSjFicm9Wek9IK0xFc0NBWXRQSW9Pa0JI?=
 =?utf-8?B?OFZOYWZjQ25pVTBDd1daMUFuR2pqZU1NTy9vc1BXS1VtdzJXZk5qM3ZPdk9j?=
 =?utf-8?B?c3lCazFVVXJMMVpSR0FBUUljS2hwRVZmUFY5d3BJblY1a0kvUGpDaEZpYlFH?=
 =?utf-8?B?ZEpRNXhTSU42QkxUN08zV2VhMHlRQVNMMzAyYWVHRWZ3dFFmRjVXZW1Vc29r?=
 =?utf-8?B?emtpbjVSVFRpMkdSZkpoRDJtZ0E4SmtNeGFRR0Y5ODBFcjVRWTdjMWRibGRs?=
 =?utf-8?B?enJRYTJHR3Q2SWV6L3VuVGFvMDFoYTFLb2o4aFRJNlVOd3J1WnM0QU9XRGlV?=
 =?utf-8?B?L1NhN0ZuTjFwbXpQby9YeW1icndrVjFnYTJIbkVhdjRBZlhjZi9sbC9PeEps?=
 =?utf-8?B?UkRGeGJkaHVWc2JEdDdMekhVdWg2YWx1RU40MDNERzl3WWpnL25ra2tWends?=
 =?utf-8?B?aTZCMkppbGpDS3BPMWxheGs1UHN2WkNIaVRWb3ZNdUdrdGtZV2tCYitENlpS?=
 =?utf-8?B?MStMN1F3TElRMWwzNWR0R1J2L1ZCL2s2cFFzTjJWMFBYZll3bGVSMFZlN1ht?=
 =?utf-8?B?cVZEN0xrWTRoV2FwNDN3VVJzclpoMXVaTEF6ZHpKSUczUTJidG1JQ0FPbVpq?=
 =?utf-8?B?UG51WUJ2ZklYUURGNU5RbDdyTExoNEdYaDBtbk82VEJJYmdON0lIOU9rbkQ3?=
 =?utf-8?B?aDdMVWkxWFUvSW5LNEk2VU9TUnU1K29NL0ZsYVRUQTNWVWR4NFVuREVicWIv?=
 =?utf-8?B?MUM5NEJIVHUxbkhaMy8zMEZXUGhsejkwSWNOR052TE1HMWtIY0tBRDR5Mm82?=
 =?utf-8?B?TzNwa2JndUlzMVRhdldRcVVmQU9BWXRiQnQ2YWZ6a2krZkxpUlhBRml2RWlu?=
 =?utf-8?B?Z2x3Y0F3MUFnZ2p5eFZGWUpJZnhYbzAyMjJhajAvTnVDRmkzMFdKVVUrUldh?=
 =?utf-8?B?RGYyRnFTMVE3S29ZVXpSbi9mS3FBaGQ3YlRObG1WZzJXZHZldHNnUTVCTEcz?=
 =?utf-8?B?OHBUVjVQZ2pxUlNjQWdUN09QZ3p3OXpnRldpMVY0cGlaREdqTm50cWdQa1lH?=
 =?utf-8?B?ZUR2L05lY2pOdGhXbVA0UjBacjRqMXdFTGZIYTZEcEdwbmZXZEw4TDBUTXN0?=
 =?utf-8?B?SFk3YWU0NzhSOUMzYURNdnBFVXlLY3I4VXZSaVIwb0Mzd09HVVlIZXJrNCtq?=
 =?utf-8?B?UFNaRW4xVGdQbWR1aThoUDRxWVdxOTBLZmFKUkhDcUQxcUhMdTJpL01RSCtN?=
 =?utf-8?B?c3NhaHB2elNPa0dWa2wvV3o5elpsZjhYak96NklFUExQNnVpRVA5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c23e81-7b5a-4899-5b1f-08df2a1bb78a
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:51:04.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfbh/Y6WbgiVJ4GCuwPwxp+S02Sw8h4Eyi6bZcWgFIwsRXh6vn405is6iDBGHZaWySjgZG6/0iQSvITv3eeBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583



On 14.10.26 19:22, Dragos Tatulea wrote:
> 
> 
> On 03.10.26 23:22, Luigi Rizzo wrote:
>> When dev->dma_pmd_tx_hdrs is enabled, allocate a MAX_TCP_HEADER
>> bounce buffer per TX DMA FIFO slot out of the DMA_PMD arena. When the
>> linear portion of a transmitted packet is at most MAX_TCP_HEADER bytes,
>> copy it into the pre-mapped bounce buffer instead of calling
>> dma_map_single()/dma_unmap_single() on every packet.
>>
> What is the difference between using the DMA_PMD pool or one (or a few)
> coherent DMA (2MB) buffers allocated by the driver?
> 
The patch was actually using the coherent buffer. My bad, sorry.

>> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 ++
>>  .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++-
>>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++
>>  .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 28 +++++++++++++++----
>>  4 files changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> index a3945195f454e..d762ad1c1ffaf 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> @@ -442,6 +442,8 @@ struct mlx5e_txqsq {
>>  		struct mlx5e_sq_dma       *dma_fifo;
>>  		struct mlx5e_skb_fifo      skb_fifo;
>>  		struct mlx5e_tx_wqe_info  *wqe_info;
>> +		void                      *tx_hdr_bufs;
>> +		dma_addr_t                 tx_hdr_bufs_dma;
> Why are only headers considered for bouncing? Because they have the
> highest mapping overhead?

I meant to say headers and small packets.

> 
> Note that TSO/GSO packets will copy the header inline in the WQE
> already. But not for small packets.
> 
>>  	} db;
>>  	void __iomem              *uar_map;
>>  	struct netdev_queue       *txq;
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
>> index f2a8453d8dce0..6de7a2a430d72 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
>> @@ -365,7 +365,9 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
>>  {
>>  	switch (dma->type) {
>>  	case MLX5E_DMA_MAP_SINGLE:
>> -		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
>> +		if (dma->size)
>> +			dma_unmap_single(pdev, dma->addr, dma->size,
>> +					 DMA_TO_DEVICE);
>>  		break;
>>  	case MLX5E_DMA_MAP_PAGE:
>>  		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 4c6060d54fbed..efd766aa43a02 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -1666,6 +1666,13 @@ static void mlx5e_free_icosq(struct mlx5e_icosq *sq)
>>  
>>  void mlx5e_free_txqsq_db(struct mlx5e_txqsq *sq)
>>  {
>> +	if (sq->db.tx_hdr_bufs) {
>> +		int wq_sz = mlx5_wq_cyc_get_size(&sq->wq);
>> +		int df_sz = wq_sz * MLX5_SEND_WQEBB_NUM_DS;
>> +
>> +		dma_free_coherent(sq->pdev, df_sz * MAX_TCP_HEADER,
>> +				  sq->db.tx_hdr_bufs, sq->db.tx_hdr_bufs_dma);
>> +	}
>>  	kvfree(sq->db.wqe_info);
>>  	kvfree(sq->db.skb_fifo.fifo);
>>  	kvfree(sq->db.dma_fifo);
>> @@ -1690,6 +1697,13 @@ int mlx5e_alloc_txqsq_db(struct mlx5e_txqsq *sq, int numa)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	if (sq->pdev->dma_pmd_tx_hdrs)
>> +		sq->db.tx_hdr_bufs =
>> +			dma_alloc_coherent(sq->pdev,
>> +					   df_sz * MAX_TCP_HEADER,
>> +					   &sq->db.tx_hdr_bufs_dma,
>> +					   GFP_KERNEL | __GFP_NOWARN);
>> +
>>  	sq->dma_fifo_mask = df_sz - 1;
>>  
>>  	sq->db.skb_fifo.pc   = &sq->skb_fifo_pc;
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> index 0b5e600e4a6a9..3b6a7a8b0128e 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
>> @@ -177,6 +177,27 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb)
>>  	return ihs;
>>  }
>>  
>> +static inline dma_addr_t
>> +mlx5e_tx_map_hdr(struct mlx5e_txqsq *sq, unsigned char *data, u32 len)
>> +{
>> +	dma_addr_t dma_addr;
>> +
>> +	if (sq->db.tx_hdr_bufs && len <= MAX_TCP_HEADER) {
>> +		u32 off = (sq->dma_fifo_pc & sq->dma_fifo_mask) *
>> +			  MAX_TCP_HEADER;
>> +
>> +		memcpy(sq->db.tx_hdr_bufs + off, data, len);
>> +		dma_addr = sq->db.tx_hdr_bufs_dma + off;
>> +		mlx5e_dma_push_single(sq, dma_addr, 0);
>> +		return dma_addr;
>> +	}
>> +
>> +	dma_addr = dma_map_single(sq->pdev, data, len, DMA_TO_DEVICE);
>> +	if (likely(!dma_mapping_error(sq->pdev, dma_addr)))
>> +		mlx5e_dma_push_single(sq, dma_addr, len);
>> +	return dma_addr;
>> +}
>> +
> This looks like a form of tx-copybreak.
> 
> Thanks,
> Dragos

