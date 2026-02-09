Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0221366839
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632869; cv=fail; b=VdKGzmmz2CTgzhmnexOcPSFRFtZkC8CZDri8701rbbQ8bXoCy8/sXxyzWGT/1qymWmZGybKjtPBq2kL8BbPDGaGy2Uec5g6EaFZGHe2ZY0ea1XMG4yePA3Z88hduIsE5lj/I/xcS/yD57VhtEJT5q68UYg0bL5TcWLbaexieWaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632869; c=relaxed/simple;
	bh=DHZcJHKKjQzqmMYiFKfA+NKSEnVymgCeqJnJnEEs7q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IOy0wIDiG1o7eiHv8mE6G1JrqGyW/NIGTrpyPwaSjIc0jjQg+Vrz+aU6jpRYOGSReg4abLcU7kQbFzHFmibAvB+H7UR+S9E4o9y0vudMh0cOzQaFddnXSiZr2wNUDyFmJGmDciZRo+IBt6Gt7W0S+Gv2IGTSgW3m3SEOTd0E/mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYeZuyHG; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYeZuyHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mephSDkZqSZnQoz2al+d43Ahiaaj+/Qz+4pI5EFbCeyeLUFz6VjDLBRtymhEs6kWqTmpZjPqunocfQt8aU5cgfqRJgOPAU7dEQxwBYM9sgBIfWohPilSPANwKNDAD2pupUXEs8FpONbEzhlH0f1D4Siu0MO5cUe07C59Uyde0uPqkNPiB5gN80fyT4Gnc16LD+yn9U7wfAUqNEdrwIMQpcF/r6rwiVrTH8zi/e3r3gDxVB7zzj/u0YOM3EmRbvlaYAgFaRJngSgt5yYILC6oDY5TTYieid64ri02p7u2swE4FEKLKgGaIppc5GE+l5pVEXLkinLi0gqlKOajWcPKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvcjkMn9ebPzbVZ/wFJutPeFYbkAN+8NJPcXspOjbQs=;
 b=waeMCkXAE3s+S9EwO3usaQUiQtHwfXDMfFPwUmbgodMumgpKfYaq2qnknid9Ezw+s26Xi8WUryaxH/IFUY+1yANTUtzZId94PMobALw9EzAVsQI6DMjhHYYBnbdUQDx8eGMAoFsdQNYQ6/o0fuX8j0KpPsYCqNhQlVCwiYxUo2L3xtgrRS+VdOn3GDNUEKlNvqhuTSpEDYC0DbeC7kst59DXVIfEiiOxlKTp/YG/KsTucQflMe4ktrOKeA+OmGpvgrWNKYgD2TdxlbnIAYI/NQWhO/yiQ7+d+lisG0rVdd3hER8SwlNmZgb87fwg/5t+XqybiwuTQp52CN/RlVlS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dolphinics.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvcjkMn9ebPzbVZ/wFJutPeFYbkAN+8NJPcXspOjbQs=;
 b=eYeZuyHG9/JoNCEe2qqJVb/SV2zjzMAmfkCY/H1GDoT0CArtsK1Y5kMc+eYdD2T9KxZPOukdFaBqDJlv9cWWYBVSCuprQ6WtoZkszNvw96tB1ba0QQ5KUoSbVLeITtyfrVGvcwUHU6OE8Cc9iqo+McitBXC9/r1mPI+JSV8Ds4o=
Received: from CH2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:610:4f::32)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:27:44 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::d4) by CH2PR18CA0022.outlook.office365.com
 (2603:10b6:610:4f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 10:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 10:27:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 04:27:43 -0600
Received: from [10.252.200.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Feb 2026 04:27:40 -0600
Message-ID: <26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com>
Date: Mon, 9 Feb 2026 15:57:34 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>, <joro@8bytes.org>
CC: <iommu@lists.linux.dev>, <jonas@dolphinics.com>, <larsk@dolphinics.com>,
	<linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
	<torel@simula.no>, <vasant.hegde@amd.com>
References: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
 <20260205140059.11857-2-magnus@dolphinics.com>
Content-Language: en-US
From: "Srivastava, Dheeraj Kumar" <dhsrivas@amd.com>
In-Reply-To: <20260205140059.11857-2-magnus@dolphinics.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fffad7f-bc5f-4134-cd67-08de67c5dca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXQ5M3BITzdia2M3dTlzM1R4UC9sa09vL0ZPUUl2dXIwaEpsZDB2T1Jzd2o2?=
 =?utf-8?B?N21LWkdwWmZablFuRHBqQ292Z2tMdCtoRERFUEMxU2twVWpNNERCdTdld0Za?=
 =?utf-8?B?Q3p2cTdmNXhydEZLVnJON2hzaGV3MmRPVXNWUzg3MU5NRCtRRDhNbE5Kd1hK?=
 =?utf-8?B?QmloT2JwUCtBQXVUUDRiRCtyOHphS2VGNUhXendyMDhuMnFUL1UyREIwZVcy?=
 =?utf-8?B?bytZUy9XTXd5b082eGROWW5CN3BnWURlUjYzYmxFTjV1WFoxclFBZm9zNU50?=
 =?utf-8?B?aUpXNUJnSW5OK2t4ZUVhbFYzcG5oSDZGcGh0NFNqQ0xvSzNkSkpLbXpaQlJE?=
 =?utf-8?B?T3hxcXZ5QWZPOUVUVGt6aWl6c2Z1ckh5MzN4ZWt5R3M0eGZoWFJ1TDZmUUFO?=
 =?utf-8?B?L0hLcU9peUhJZE5VQkE0OC9rTTBkbmR2MFBjNENRZ2lYb3VKcWIwKzE0cGpP?=
 =?utf-8?B?R1RlcEVIeUFlMjZaVTdIelA1b3BISU50cWdvV3hBSUlzdUY0UlVuZDNUVzZN?=
 =?utf-8?B?MXM1eWJZWWpnTGpnYTM0NXlzSDhxNTZDeWVJUkZTM3JOaXlhL2M3ZmVxRVQr?=
 =?utf-8?B?cFNnMWduYndWenZGTURmWEVlMm5HZUx3dmw5TDJ0aWFrd3MrQjFnQVNFZksz?=
 =?utf-8?B?aUx1bEo3ZmdPVE5yOGZoZkRyYy9uQk5zSnNwejlKcFhibUp4bytaZDNweEgw?=
 =?utf-8?B?YzdJZmNaR0NkZ0tXMHNSYkJpNW9ORS80Q0RweVAvU1JKbHRqYitZeUpySHJm?=
 =?utf-8?B?Qkx4TjIzbm53NW0wMTVuTzd6emlralVNYXMwZFJ2RUhlSTBNNk9uMTJyc2Fp?=
 =?utf-8?B?eWNVcXpZQ2IrbG00Yi9YUHU1SUNudUhjQmFJVWxMVDdKaW84V0swNjA4STZl?=
 =?utf-8?B?bmtGL3BDakFDQW8zVkJTaStxbzZRMEROL3ozK3BVWW96Mk8zdG9ESjdNWnBW?=
 =?utf-8?B?eGIrWlNFbVpzTmtjL2pPelhRN0RuTkU5NXNKbnJzNnNZRmFPamtZSndTQnZJ?=
 =?utf-8?B?SEtDUk5rVFUzZGV3cXdxZE14WHJyemdjVUtEMVJSbU1YaG4ySmM4N1lKZS9S?=
 =?utf-8?B?UExaNHNNckpINmJ6RExQeXZLTnU0WFNyZ0ZoMkJPNlVRRUZlaGxlL2NuMjQ4?=
 =?utf-8?B?YUk4dXN1QmlwRHMrMUR2NU1IOGlpREpVQUJTcmx5QnlyNVZCTThPQWU5ZXJh?=
 =?utf-8?B?ajY3aUVHeWNaTnBUWVR5UkJaejgyQkVINk1ybXV1cHNkSlBVdnVQRmRzeE02?=
 =?utf-8?B?dDhicEZzcWhleTR4djJFS29UbXBzMEltdWRnMmVEcGd1MjR2QlBiMVkwWncv?=
 =?utf-8?B?VytJSytsMzJodHAyOTJpdGoxcFdSalEvK1dKaDlEd2NkZTcrQTFINkpudDlO?=
 =?utf-8?B?Ymd2RkJ4UkluSHY2RDZRcVFRZGtpNCtpL1RUZldPRVc0bDczclFLaDM1YW5r?=
 =?utf-8?B?aGlxUjA2Q24wM3Z0TkVvR3RWT1NmT2UvWnNFa1RjMU0zVEpDMkR0cXVVTCtK?=
 =?utf-8?B?bDZkM0U5QStKWnVsOUIrVCtMMGt2WGF5U0Zoa3ZWVWViVkR2WWJKMmtWbVpJ?=
 =?utf-8?B?ajJnWGtGRlA2SE04WWJrd0J0TTV3dUR1M3VhUkpneEYySzhlbnhBNi95TlNV?=
 =?utf-8?B?L1dxaGgyS2xoVDFIYU43MjI3eDFURWRwQzFUYTNISHYxU2kvMW9SaVpCbEkr?=
 =?utf-8?B?dzhlQXRmeWU5QkdDNmVneU9vanpUaWhacnc1dzEwQVBWVGJLdkljMjVuRExU?=
 =?utf-8?B?OXZJcjlreWZTODlWK3RobkxvakJZU3FqUXhsZTl6OG53V3NPS2xqYm05ckRk?=
 =?utf-8?B?SXcvUUdCUDhmM1JRTGI4UDRtYjZyYkxVTktLRFZZWmRNbGNzMFRSb3gwUWRY?=
 =?utf-8?B?dC91VjRDdWpkME9wQnJJbDlWTnpKNTQwQWhscjUyKytnV08wdFdwMjl0WDlF?=
 =?utf-8?B?eFkwYVltZDd6QkgzL1JEYUhheldFMUx3ZEE2YmxZTHR5M2k5eXprSnk3Q0V0?=
 =?utf-8?B?cmFjbUUzdExnNFpoc2NuZi9zL1BjY1F1UzBhUVN3aXp2UTBja3ZWMHdTNFJh?=
 =?utf-8?B?Z1A2RDQydVZhQmd0RTUwK2cyc3ROUDJzc1cyeEZuMjVidnNPRUZybVdPVnZr?=
 =?utf-8?B?Nm9SNFRxWHVtMHVjNFdmNzRwMzhtbksrMm01RkV6SGdLT1dNMEh3dk9wM3oy?=
 =?utf-8?B?NlY5MzhlU3pXTmdlamw5RGRHWE5CWk1ud0gra3JKNHZrZ3NnTFAyYng5bGVM?=
 =?utf-8?B?cWt3ekJJTWlGT1k2L1JsZ21obHR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a9V5SMQ5/wo3iwRucNUfShph+YhbvE/ukuauFX6NIRjTMXxh5twfDvhhcuYRSl+oLOPrRN7Kwra/JkofYK04GzF+2MGPVztOKrfvIXWie62sZzIGdEsW0brZ2WeD35GlDN3rRUdKksOI1/H7EG35thwVo4ZUl9ZLxACMHapsVnYyFWG+huIGQlS+QwpiJ8PiF46nWf8Cu5pHNAIsFDCyXfh6rB8jByjvTyim3JDafFfl5Z5FyS4PhhkvpjN4kgb18B2qgFoqJg5YktdQL3L0yuzQGBl4qoY7uiV8p6TebmT/TY46WFpSffenr/7vuIPRPtzwjmWzQqGBfKh2Db4JpyBfYf3jCSIMQETLU00BWrDOOjQxSyJ4TkOc9HgX6JRaONTvXpePIZ7nPS+oZqYnFLAQvAMrpY1mC1EhAwTfgHekNg9ex0rByGQfFWED91rq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:27:44.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fffad7f-bc5f-4134-cd67-08de67c5dca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

Hi Magnus,

On 2/5/2026 7:31 PM, Magnus Kalland wrote:
> DMA aliasing causes interrupt remapping table entries (IRTEs) to be shared
> between multiple device IDs. See commit 3c124435e8dd
> ("iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping") for more
> information on this. However, the AMD IOMMU driver currently invalidates
> IRTE cache entries on a per-device basis whenever an IRTE is updated, not
> for each alias.
> 
> This approach leaves stale IRTE cache entries when an IRTE is cached under
> one DMA alias but later updated and invalidated through a different alias.
> In such cases, the original device ID is never invalidated, since it is
> programmed via aliasing.
> 
> This incoherency bug has been observed when IRTEs are cached for one
> Non-Transparent Bridge (NTB) DMA alias, later updated via another.
> 
> Fix this by invalidating the interrupt remapping table cache for all DMA
> aliases when updating an IRTE.
> 
> Link: https://lore.kernel.org/linux-iommu/fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk/
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> 
> ---
> 
> v2:
>   - Move the lock acquire before branching
>   - Call iommu_flush_dev_irt() when pdev is null
>   - Handle pdev refcount in correct branch
> 
>   drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
>   1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2e1865daa1ce..b5256b28b0c8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3077,25 +3077,47 @@ const struct iommu_ops amd_iommu_ops = {
>   static struct irq_chip amd_ir_chip;
>   static DEFINE_SPINLOCK(iommu_table_lock);
>   
> +static int iommu_flush_dev_irt(struct pci_dev *unused, u16 devid, void *data)
> +{
> +	int ret;
> +	struct iommu_cmd cmd;
> +	struct amd_iommu *iommu = data;
> +
> +	build_inv_irt(&cmd, devid);
> +	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	return ret;
> +}
> +
>   static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
>   {
>   	int ret;
>   	u64 data;
> +	int domain = iommu->pci_seg->id;
> +	unsigned int bus = PCI_BUS_NUM(devid);
> +	unsigned int devfn = devid & 0xff;
>   	unsigned long flags;
> -	struct iommu_cmd cmd, cmd2;
> +	struct iommu_cmd cmd;
> +	struct pci_dev *pdev = NULL;
>   
>   	if (iommu->irtcachedis_enabled)
>   		return;
>   
> -	build_inv_irt(&cmd, devid);
>   	data = atomic64_inc_return(&iommu->cmd_sem_val);
> -	build_completion_wait(&cmd2, iommu, data);
> +	build_completion_wait(&cmd, iommu, data);
>   
> +	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>   	raw_spin_lock_irqsave(&iommu->lock, flags);
> -	ret = __iommu_queue_command_sync(iommu, &cmd, true);
> +	if (pdev) {
> +		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
> +		pci_dev_put(pdev);
> +	} else {
> +		ret = iommu_flush_dev_irt(NULL, devid, iommu);
> +	}
> +
>   	if (ret)
>   		goto out;
> -	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
> +
> +	ret = __iommu_queue_command_sync(iommu, &cmd, false);
>   	if (ret)
>   		goto out;
>   	wait_on_sem(iommu, data);


I tested the patch with lockdep (CONFIG_PROVE_LOCKING=y) enabled and 
observed the following lockdep warnings in the kernel logs.

[    7.215360] kernel: =============================
[    7.215360] kernel: [ BUG: Invalid wait context ]
[    7.215360] kernel: 6.19.0-rc8-3e36d27b34eb-1770495763816 #1 Not tainted
[    7.215360] kernel: -----------------------------
[    7.215360] kernel: swapper/0/1 is trying to lock:
[    7.215360] kernel: ff4a3b3365f62368 (&k->list_lock){+.+.}-{3:3}, at: 
bus_to_subsys+0x28/0x90
[    7.215360] kernel: other info that might help us debug this:
[    7.215360] kernel: context-{5:5}
[    7.215360] kernel: 2 locks held by swapper/0/1:
[    7.215360] kernel:  #0: ff4a3ad400055650 
(&desc->request_mutex){+.+.}-{4:4}, at: __setup_irq+0xac/0x770
[    7.215360] kernel:  #1: ff4a3ad4000554c0 
(&irq_desc_lock_class){-...}-{2:2}, at: __setup_irq+0xe7/0x770
[    7.215360] kernel: stack backtrace:
[    7.215360] kernel: CPU: 61 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.19.0-rc8-3e36d27b34eb-1770495763816 #1 PREEMPT(voluntary)
[    7.215360] kernel: Hardware name: AMD Corporation 
Titanite_4G/Titanite_4G, BIOS RTI100CC 03/28/2024
[    7.215360] kernel: Call Trace:
[    7.215360] kernel:  <TASK>
[    7.215360] kernel:  dump_stack_lvl+0x78/0xe0
[    7.215360] kernel:  __lock_acquire+0x836/0xbe0
[    7.215360] kernel:  lock_acquire+0xc7/0x2c0
[    7.215360] kernel:  ? bus_to_subsys+0x28/0x90
[    7.215360] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[    7.215360] kernel:  ? validate_chain+0x261/0x6e0
[    7.215360] kernel:  ? __pfx_match_pci_dev_by_id+0x10/0x10
[    7.215360] kernel:  _raw_spin_lock+0x34/0x80
[    7.215360] kernel:  ? bus_to_subsys+0x28/0x90
[    7.215360] kernel:  bus_to_subsys+0x28/0x90
[    7.215360] kernel:  bus_find_device+0x30/0xd0
[    7.215360] kernel:  ? lock_acquire+0xc7/0x2c0
[    7.215360] kernel:  pci_get_domain_bus_and_slot+0x7d/0x100
[    7.215360] kernel:  iommu_flush_irt_and_complete+0xaa/0x190
[    7.215360] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[    7.215360] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[    7.215360] kernel:  ? __modify_irte_ga.isra.0+0x5f/0x80
[    7.215360] kernel:  irq_remapping_activate+0x43/0x80
[    7.215360] kernel:  __irq_domain_activate_irq+0x53/0x90
[    7.215360] kernel:  __irq_domain_activate_irq+0x32/0x90
[    7.215360] kernel:  irq_domain_activate_irq+0x2d/0x50
[    7.215360] kernel:  __setup_irq+0x339/0x770
[    7.215360] kernel:  request_threaded_irq+0xe5/0x190
[    7.215360] kernel:  ? __pfx_acpi_irq+0x10/0x10
[    7.215360] kernel:  ? __pfx_acpi_ev_sci_xrupt_handler+0x10/0x10
[    7.215360] kernel:  acpi_os_install_interrupt_handler+0xaf/0x100
[    7.215360] kernel:  ? __pfx_acpi_init+0x10/0x10
[    7.215360] kernel:  acpi_ev_install_xrupt_handlers+0x22/0x90
[    7.215360] kernel:  ? __pfx_acpi_init+0x10/0x10
[    7.215360] kernel:  acpi_bus_init+0x3a/0x460
[    7.215360] kernel:  ? acpi_ut_release_mutex+0x4a/0x90
[    7.215360] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[    7.215360] kernel:  ? 
acpi_install_address_space_handler_internal.part.0+0x64/0x90
[    7.215360] kernel:  ? __pfx_acpi_init+0x10/0x10
[    7.215360] kernel:  ? __pfx_acpi_init+0x10/0x10
[    7.215360] kernel:  acpi_init+0x5d/0x130
[    7.215360] kernel:  ? __pfx_scan_for_dmi_ipmi+0x10/0x10
[    7.215360] kernel:  ? __pfx_acpi_init+0x10/0x10
[    7.215360] kernel:  do_one_initcall+0x5c/0x370
[    7.215360] kernel:  do_initcalls+0xdb/0x190
[    7.215360] kernel:  kernel_init_freeable+0x2d1/0x420
[    7.215360] kernel:  ? __pfx_kernel_init+0x10/0x10
[    7.215360] kernel:  kernel_init+0x1a/0x1c0
[    7.215360] kernel:  ret_from_fork+0x25a/0x280
[    7.215360] kernel:  ? __pfx_kernel_init+0x10/0x10
[    7.215360] kernel:  ret_from_fork_asm+0x1a/0x30
[    7.215360] kernel:  </TASK>

 From the warning trace, it appears that __setup_irq() is already 
holding a raw_spinlock (context 2).

Meanwhile, pci_get_domain_bus_and_slot() attempts to acquire a regular 
spinlock (context 3). This triggers the kernel warning.

Thanks
Dheeraj

