Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1D361DA2
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869514; cv=fail; b=ZLjIRGkVcDLGgYpXXECV5rnTrgbIScN2NnbGeLWm2a/v852XGHIpGLUskMUGWpoWfTu6c9/spTdH1DmHQwPo/GzruPycHsHwg2ywPf38cNSARsFhbklOFHWMHCH4jGWyvEI/eW6FBI/BWngmM/bG6zSfcBz01+cJlPRWGtOnvzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869514; c=relaxed/simple;
	bh=CHhGDQV+kkunrnoWsyZsvQLPzYBRaeyxOQ4u9eoHLtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FnGIqDCZpry80cNeQvoDDILS22IpLCxyBGP9MJe/yU6h4q5d7RisCbtFiw0fjAFujX2PZu6IMbNrqlX4anJVlIfhBL0d65MNHNMkXltejkfLxhnzaLj2ty0p+zy9feVOpRpkaIzRuQ7h8yAJ+sZQ4sL8sbzpyEBcUtzgRKxvpT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hQ9uGE2f; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hQ9uGE2f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwwNQkoaYuFsULTqA5NVS3NbXfegrhFYBNG/PndIVW34t0IYUxssgRXiX5VAkCyxpaaOpBvTBiicFsF82wyOYJXJsuJzHaQBozZVJc6bfEjzCUEgPMnJSj1bjU0JXUx37t7aUJpQWRLj2k45NBZgoao8iHSVhV/+g3Xw+VsL9IXnd1jXRIcN4j54vtEpFvkE2QIMTxGPCfU21Fj2UUJyGIygtOToWLO52tqYlWxiWDxOvGlT5FN7seZZbAtTDMzreeHtEB3KwR3JJesjvBOO357q9QDZ8YTtyWjdc1Wrsqor8Z6bHM6QczXrkJSCUSm1XieZQ76Klnh57PS3BLOp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOha/ZCgF5QNrcvPp0L1OIajjPJ8v0YdK1r7fBZGCTY=;
 b=QptqA4jW6H+dqdhxd1ZCSENVAMJURlgZAf1e8bs5aBNVDxuKIsX60VNMTCqxCthQkXA5RRL16lo6zhcAMBM5gRB/LK5814G1j1Muh81UfaRr0NhJKcRGfG/Y4YjmCNBZ1aWALCMFSdjzqbsoJkyru9WG59XykEzeLmUknFyB2QBu/j3Tif99BR1CeZNipFkleXp7tSzEMVaMgpSKyIte0FwTR+qYoLhGtr818Y3PqJ6p+Vmcul3331oUBoepGouQa3Zx0cYPBR6eaGku4y91c+xkXUY9wWRzXJazTctIp3ClN9En5eWZAAmnJhQzFQIIC0v/nXP74sHYirTf/Vr1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOha/ZCgF5QNrcvPp0L1OIajjPJ8v0YdK1r7fBZGCTY=;
 b=hQ9uGE2fZabOJqvd9NPj7ZS1IBKzcVliHeLqZXKn+bf/sct1gIyJdZT/Mj3ZC5cq8+ysuiNO4u4JACxi3YSnPNWlIHXHP25RoEVQzUs19eaW8ek1+jyo3XL5I6A0VhjZqkEVuSN+dO9ZJ5s3Pkj41E2bcSokHyju3/URgZ5pQAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:18:30 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 11:18:30 +0000
Message-ID: <2f486ae6-d22b-4a30-b93c-f019feb8043c@amd.com>
Date: Mon, 30 Mar 2026 16:48:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>, suravee.suthikulpanit@amd.com,
 joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: dhsrivas@amd.com, "Lars B . Kristiansen" <larsk@dolphinics.com>,
 Jonas Markussen <jonas@dolphinics.com>, "Tore H . Larsen" <torel@simula.no>
References: <20260225202330.23027-1-magnus@dolphinics.com>
 <20260225202330.23027-4-magnus@dolphinics.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260225202330.23027-4-magnus@dolphinics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b7d11f-745b-417e-499b-08de8e4e1236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b3X+brDjcF9zNSQxJ28SDa9hJWMszjnSUg9UyOKkW/YqGfDpq61oifS9EzFeOGfFNzAkZRpj6XKqm3R++e0a/N7OcT9LiBLeaqluHvBWUaRYgIxJ4h+Mqx1zvSIeaRuq8RmGtK7qqup9XYThcMeeD6d56oAzUKRw7/tCbZvvKBrV9DQSFJ8vxQ9XlzXikeFn6oxoPltSGxld2WpBddILpFjWQB6PfnNF1hxPUzVx7JIs9v9UwvJQVW2meGLut3OQiO+35TEE1Ra80DdJb17IO5iLJ7dl65Dj1ggHczV8e/+EaGK7dwXtCYnJBHGg6vLh7KNTuYJD1DwY9ywdWmDFj3Jiji+/xlaboybzqHTi1NJu6u5hjYdCoxO81MC2JfObXAdCMpcgmq0U78e7iQA3Us23eTC5yZsewby/HbDsF4nQFvS7qatc1gB78TKwikbxPietFoJdPDT8T0K/05yQs4pgng6n9A32c/FVAWc8QopAh3DU4yzV0e7WsBREbZcgDQD6UCFoDdaHcLuZx7xZGm4k+MWY4vPy02B5GwGob3FMSmQjCkD6TacNI4uwfGjug0smZc10zcgUVqepA11qkT8frHHrc4EKE2sKTsHshDrUP/SO16yX8UQigM9qJhI/4bbnRTxGV0K1YTeR5JgINUQfwv5IbU37q1D5T7rczpFHivqgTu0ZZwMehAastsFp8HYXF0NRg3bRsDnmm9WF6ahCvEJIZ7d/7jHWl89oqvT/ijRYlOF2a+pdlEj1xK1I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdieFYyU1g5ZlJLTlNEWGdlZmRteGlBaXZ4VnlEanIwK0FqN1JqZUdCMDAz?=
 =?utf-8?B?bjFiTHZmTndvQ01FNXhpME96T0w2REpsS1ZJNWpoczZoamtKSHFJRCtoemtT?=
 =?utf-8?B?ZEQveEplYzJzbmovckNiWnNwbG9SUkZDU2dTT2ZXUWNGSGVBVTcyaFVreGxp?=
 =?utf-8?B?NFNadEtEK2NsM3p2ZmFmVjBOSmtld1J5OWpSMTltMklTYXZDZFhCQkx4Ujdj?=
 =?utf-8?B?TjZwYXVRa05UQjNXSC9CWVlKVXZBOEtkQ1ZHeDk2YXlJNTNKbGhsRnNad1hs?=
 =?utf-8?B?RkRkQnJWR0hJTnlCZXo5cVdyUlYrejViMjBiLzNubWZGRWdEK0xVV0kwUXJP?=
 =?utf-8?B?YVZyczQ2R1F2M2ViS1d3WnVkRVRpSjhJak93VS95cCtET2JBa1dzL3I4Tnl0?=
 =?utf-8?B?UWtQazg3czdZZkMzRFBaR2NKeU9oVjA5V0pCUU9OaGxVZVZLSnplTVFXM1lO?=
 =?utf-8?B?Z3o4dkFtYUUrRUJncmFDOVVzOHRFQkRsTy8wdW05L1IwN2hHTFdPY0l3WHBL?=
 =?utf-8?B?NHBYa2tjQUlIOTZwc3ZPR25YNjJVV2JDTkdna2VBWWVINFF1S1p4RG5Nc0RJ?=
 =?utf-8?B?K0JXTUVvTHlFcnNMdFJqMUtURFJibEJMQXduNnNOQTNldlpubnJCbG11aGdw?=
 =?utf-8?B?dHA0N0Y4OE9vcmhzbE1ndHpOYTZOYUpaNVArdExQZllwV0NyK1l4YnJVc3ZY?=
 =?utf-8?B?Tmd5MFJHSW5LdXh2cG1ibTYzamVkUitIMmZhemdGK2xMOTduazdCWkxMcjdy?=
 =?utf-8?B?V2F0aU5XRzhWNWk2bmRwMjNaeFRqS3R3cnZYZ24rWUVvWEFMd3dLVlZvQldE?=
 =?utf-8?B?YVo5azA5SFdTNWdaWnNiVlY2SU9DNWVIdU1jaUREb0hYK3l5Y1gwWDZ6L2U0?=
 =?utf-8?B?WlNjQWl1aFNvY0kwYVdWTGtjWi9nNmp6MjNqYWgyMFNuS1FJei9OS2xXMEZv?=
 =?utf-8?B?c1VqemVLQnk3ODdjaEJ1UzJBVURsWnZMSWxxYVFJWmZweUpTczdleGxDTzMw?=
 =?utf-8?B?cDFBTjNxTlgzcE16eDdZTytUWmhaRmd6Qm1ac2J5S1AyalAxelA5VmhhSHFa?=
 =?utf-8?B?TDM5cUY0K1BXeDRLWFdFNHNGOXZCY0x2bXpqNWZoVXJjaVNHUUhtbVVFeEpo?=
 =?utf-8?B?bkg1bjk1SFRFYnFSQWQxdlloRDR6VHFJVC9tYTNCWnkvQ1Z1ZlE5VU1ESnJB?=
 =?utf-8?B?SnZnTzBhRFl4WTAwMzhVOEJkRVdBdkdZODhQcWxUcWR5MlZXdVV1RmZkTTZj?=
 =?utf-8?B?eGZXSUtGRXpuYzU5NUVZeXVaT0RUTUNVc1BRQjNOY3lzcVdXYWdqaGNtdzFX?=
 =?utf-8?B?MVJUK2hYY1dWM0hkY3VaVWNsUlhDOVdDbUxSZUxnZ01ralBrS3pvR1o5TzFs?=
 =?utf-8?B?VjkrWFN5TnpqemN6RmY5RzExejdURE5Ob3RuS3FRNFdoLzB1SXYyUFJWc1Y4?=
 =?utf-8?B?enRYay83blNjZUJFdlV3Q2ZvSk95VWluRGxGa2hBRC84NE5ja01vUndKRmVU?=
 =?utf-8?B?WDAwYTZ6R3hWeTh2TU4yNDNwZFdCdm9hYWdDTjc1SFBPVjFMeTdVUGNFSjF0?=
 =?utf-8?B?RWhONXJJOHhmRXV0ZzZENDlEeXFTQWxrL25iU1htVE9rZzh0S2g5aTVqcjZH?=
 =?utf-8?B?SnAwbmkzTVFmdDlxakFuNyt6UlRnREdKc2Exd3VVaUNSMWo3b3RuSUV1Qk5u?=
 =?utf-8?B?SGxEVklZSjZLZWk3UE8wQzJDeUIvcTRZYVpoRUxJV25PbnRmTFNrV1JjcUNU?=
 =?utf-8?B?RW1NUzEwRC9adnQzWUNwU2lZc2IybE4xNHZTUUFVOHQ2aUN5c0RYUVRpMExv?=
 =?utf-8?B?TkV6dklJdVNibERZam9KU0pxQXVxU2JvRldrRFFreXVYWnl5b0pWbzhjNUlV?=
 =?utf-8?B?TCtxQjZCblViTVZjTGcwNXgxTzFyUmVUeDQyeFVoKzRkbUVFSE9YbFJ5RGhs?=
 =?utf-8?B?bnZIeFpYakp1TWpMTkR5aDE4c1JhbWw3WkhMWHdDdXUzTXh2RWx3TDl4RDhF?=
 =?utf-8?B?ajVPSVp0d3krTzB1S3M2Ri9TaUNqZTBzeitObjl5T09qZXFuWHZDN3dIY1Bz?=
 =?utf-8?B?OUU5L0pkakNOZlI3TjlobjJqZ3hpTHdjM0xjc09iOUZHbVRqUlgwTXJuTlpJ?=
 =?utf-8?B?Q0UvTWtVRy9TV2VlYXhlMWJ5TUNiYjRvMU1QT3VHRDZVVXp5cjZscC9RTWRt?=
 =?utf-8?B?TDBCazUwVVdqZXc0STNzVVUyV2l6SlZhNGxoV3dxZUtIWVJtbEl3ZVJzOHB2?=
 =?utf-8?B?YzlOb1Vvd1FZdEhUcndPckRqOWVBUVRoaVRoWVpEalQ5MmtiVUtVNk02cC9Y?=
 =?utf-8?B?OTBzbGhEZlZrTGZ0SC9sbTZEaW1QWC9wTHQ4eldnOGU1VjlDc0Y0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b7d11f-745b-417e-499b-08de8e4e1236
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:18:30.2658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqwEpoVt6yd4pcP9Ue/SjiluBD77JzlH1upAsqZweZv2hFGVKHn60Fk1UCCREG75Ns/1l/FfKe/ayboEwDm1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798

Hi Magnus,


On 2/26/2026 1:53 AM, Magnus Kalland wrote:
> IRTEs may be shared between multiple device IDs when PCIe DMA
> aliasing is in use. The AMD IOMMU driver currently invalidates
> the interrupt remapping table cache only for the device ID used
> to update the IRTE.
> 
> If the same IRTE is cached under a different DMA alias, this
> leaves stale cache entries that are never invalidated.
> 
> Iterate over all device IDs sharing the same DMA alias and
> invalidate the IRT cache for each of them when an IRTE is updated.
> 
> Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
> Co-developed-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> Link: https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/
> 
> ---
>  drivers/iommu/amd/iommu.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5dec3502c8b3..d9a91d1a083e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3166,6 +3166,31 @@ const struct iommu_ops amd_iommu_ops = {
>  static struct irq_chip amd_ir_chip;
>  static DEFINE_RAW_SPINLOCK(iommu_table_lock);
>  
> +static int iommu_flush_irt_for_aliases(struct amd_iommu *iommu,
> +				       u16 alias)
> +{
> +	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> +	struct iommu_cmd cmd;
> +	unsigned long flags;
> +	u32 devid;
> +	int ret = 0;
> +
> +	raw_spin_lock_irqsave(&iommu_table_lock, flags);

There is a possible deadlock. Actually we can remove lock here?


path 1) alloc_irq_table() -> holds iommu_table_lock [A] -> iommu->lock [B]
path 2) iommu_flush_irt_and_complete -> holds iommu->lock [B] ->
iommu_table_lock [A]


> +
> +	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> +		if (pci_seg->alias_table[devid] != alias)

This is heavy hammer. Why not use pci_for_each_dma_alias() like we do in DTE
flush path?


-Vasant

> +			continue;
> +
> +		build_inv_irt(&cmd, devid);
> +		ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
> +	return ret;
> +}
>  
>  static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  {
> @@ -3173,19 +3198,29 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>  	u64 data;
>  	unsigned long flags;
>  	struct iommu_cmd cmd, cmd2;
> +	u16 alias;
>  
>  	if (iommu->irtcachedis_enabled)
>  		return;
>  
> -	build_inv_irt(&cmd, devid);
> +	raw_spin_lock_irqsave(&iommu_table_lock, flags);
> +	alias = iommu->pci_seg->alias_table[devid];
> +	raw_spin_unlock_irqrestore(&iommu_table_lock, flags);
>  
>  	raw_spin_lock_irqsave(&iommu->lock, flags);
>  	data = get_cmdsem_val(iommu);
>  	build_completion_wait(&cmd2, iommu, data);
>  
> -	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	if (alias == devid) {
> +		build_inv_irt(&cmd, devid);
> +		ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	} else {
> +		ret = iommu_flush_irt_for_aliases(iommu, alias);
> +	}
> +
>  	if (ret)
>  		goto out_err;
> +
>  	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
>  	if (ret)
>  		goto out_err;

