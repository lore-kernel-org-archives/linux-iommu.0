Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCE248883
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388031; cv=fail; b=J6iv6+EhxcNlK0MsTSOrMlnidBy5fogiTRYst2jcvX+Ee4RYNxHbq4wfnDMTlCxq1Mi1LvP0iLWMvZyM8P7iMS1Ps6yVojcQCZKB3XATjPUXL8ZSSmLReeFiGwDXym/rzUnQYg8ycweX8ccTS4l/1kGSeZhGCU7MG+wUM1qpOzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388031; c=relaxed/simple;
	bh=wx3SxPRAx5s/w9+0qti6+7mwrrlYUzLrxHw5cybqSuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bemQjmJET60dt0I5Oi3mml0Yoo0A237i9AHGDhcj+HwKFg3ci9jJNKRMKWBN3gZSfuQ5F3bHJrPeMjTsJgSwjuIROJOfwwImn53m7Mh6NCc0ZQAq7t+AJSUpff9vVzCj/2O3E3SxYSBeNvkD3655kXyBP62Y2kLSpSstphBIyx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JM/X1jhm; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JM/X1jhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h82Qk9ceI58NOqoUYSV8vioYYbUulOMt2iO7TUz5vNNGFa3kdwtC7EhdTCMsmwlVCrDsrm4M6u6Uy3HYZeW0rrjzzQomqqHwj4Z1m5FWpFZpTHuM682a2L/N292BBhNl1I4T0Ts6ore3GaOTaghWq5uMgEOYrhWVSMzHX+5dYSqJvrS9NNELflsWkrf5b+/tzRUh/L02NcNz//o9pfpAL+1G5f9rMBt2zmEnIERQeLzf4Rtxgim9yH1TLGVA7r4TS7KVAtTGBUHRbzPiCV7nA7tZXffSMyGYacd/a5QAIChIQ7iypKut2f3ocFXDcD1Gpocic3GFb17ZrmvQh8IHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RSK8FqES5FGNMUj8/WWuqFql7bKZfzChfybr3dImYs=;
 b=gn/iVPvVirINuTn28gfGpq9kSQjFz+GQXT/nUgWrvejUBuS4aSZJuFEKmk8THq/PWBuPtebEolkIVprG/Pp0ttZ0YtHiiJvNpr+9OrbLojWtAPk9o9YAHyf15LPazAH3Mi8vobewg4CL2ENa9vpjSMRTi/inAlxSQNtvHdqCQlhwLTU4X5QTqcJ3WfymneOolOd7J3HByMzMQtZKPCoek1VY5i9faoBnN5VvxOWtm1hInDv81CPdbqSVC0f2zdWuDHq9cfkOzUvHzeKf2XrDeV6Tct8AXpI9xgrSdaxnKF2w1oyV3BXuHysQgFuLApKVkQesA1pXNYjf+kSFDD2A5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dolphinics.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RSK8FqES5FGNMUj8/WWuqFql7bKZfzChfybr3dImYs=;
 b=JM/X1jhm6TA5mwgLNKMUM/BEnCYvJzZ2PI7IBmfYxYxzfBDwNWQ7F/5jVXOvVmg1G5aiuZJA2NoQNFvlNgKLqUOGzWNtHDk5/RnP0hXiGWcuwD6I6DjVCYM5eWbk1h18G9KxdukS7+uirNAQv3aFirQJKXmN83FT6peH0kPTQic=
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 07:47:02 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e3) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 07:47:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 13 Mar
 2026 02:47:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Mar
 2026 02:47:00 -0500
Received: from [10.136.42.249] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 02:46:57 -0500
Message-ID: <5de2362c-61e2-4287-8735-8fcbc8a1ab09@amd.com>
Date: Fri, 13 Mar 2026 13:16:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <dhsrivas@amd.com>, "Lars B . Kristiansen" <larsk@dolphinics.com>, "Jonas
 Markussen" <jonas@dolphinics.com>, "Tore H . Larsen" <torel@simula.no>
References: <20260306092230.132183-1-magnus@dolphinics.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20260306092230.132183-1-magnus@dolphinics.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: dheerajkumar.srivastava@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6c7922-ca90-4834-5634-08de80d4b647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sKBzXWAbCUTVuSbTRP2nqmCJt29AUlnWOj4P+ddG96iawdJIz6yQ2w7As7e0rmX59qNHeLTUIIEnY5riRtjnbxmSOyUWdUMheN8n9QmBHoFWFYftt7m/BRIVelpYMNDcDFwFrYA/J+fxvGQGdZinQIgP85meNcCYWV/fEt1j7ZSUlU68sXgbrZ4vfYYS9RCihi5ATlyHWF+zakLCkTKMaJTa/zdHdvX7YDmGPFRq7BQuJvr7vIdavx3hg8WD+HotN2ary4SdBk1lPV4RJaKawjeKPgyUZNMuJatjapMdWE8c4cIcQ0gVTLg0jJxIHmGo6mtS0UMxBSa99wPjOoPa6Pi+75QNh2ekC7PWNeX1LN0hPQoUUGrRU9/z1CIKP5Y/kjMM3EFNz61fsx/HeHYUWRRbuLinJpezcHMmjsWj3o6TUkEQmM4BOZe7EtitlvxYXsEVNMbVxidmmH8QBX+cbe9jTeVhTdPl+Ln/A3yvtXmGdes8oTD1mLV7CKuqXeLBMYO+VEwsqdEHg/w+swNQomAkia3RXcMbkbpzId/thwejf++sPo02rf1HqWPpsqdEB43m69qAqaowJE4fgUsF2Wf1Vplws46S+ZOdz4SEp/OX2EKut5R25gqab7xP2T38bvl2LOkIK3ExM/pVRts4rPDT1aAtc41lpMiyedihANUl49pTtBts34syO16DnBDHswaqmmWsNhvqRv4oXKqYFjk/L/WWsODN5Qs93Vh7LjM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DlvaKk9pTNbHNejN8wDa9S8gHAyIEWk04ll+XBvGzRbuLm4IMcKsc8vTFlin3pzLO1kCB0tcwdaYS42C7OoGzPQxqrdC9N98Y7qi7mVN28BH1QZ29tWfmfQJ/0XeSOfDKVHKkkloaF13MRushH8haJPjMNn7AQBjmbC9tH2rJGod3+dpo+NV65BC8L23LMPU2v5VOZWemJDUDi7Mjw99TnF6oXZRHeGP2H0iUxeTtubRGjygEWqNoo5l41dR6F6/MvkeyPaS5QzFBWelLiZLmjtUoUAQrNexlZzBU2L/zq45PyPzybiWGqqsTqDtVe5iUzlo34GlJPlUQ9fIMq3tplTTdpg2NVexF6mKpgxxiabau2uwgJAc4wKV5Et4Bmk+UhiCPmHCR3LsRnavsPD3c3R3asGckikI4VePYa6bAbDx/O6RlyE79ET5Fdam9OxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 07:47:01.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6c7922-ca90-4834-5634-08de80d4b647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727

Hi

On 3/6/2026 2:52 PM, Magnus Kalland wrote:
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
> Changes since v2:
>   - Look for aliases with pci_seg->alias_table instead of
>     pci_for_each_dma_alias since we can't get the pdev (lockdep).
>     Track the aliases in set_remap_table_entry_alias. Invalidate IRT cache
>     for each BDF sharing alias with the given devid in
>     iommu_flush_irt_and_complete.
>   - Make iommu_table_lock a raw spinlock to use it when invalidating
>     IRT caches.
>   - Rebased and applied cleanly on the IOMMU maintainers tree
> 
> Resending for visibility.

I tested the patch with lockdep (CONFIG_PROVE_LOCKING=y) enabled and
observed the following lockdep warnings in the kernel logs.

[   13.224217] kernel: =============================
[   13.224217] kernel: [ BUG: Invalid wait context ]
[   13.224217] kernel: 7.0.0-rc3-eee9d444276c-1773350434439 #1 Not tainted
[   13.224217] kernel: -----------------------------
[   13.224217] kernel: kworker/0:1/11 is trying to lock:
[   13.224217] kernel: ff364c9da9e416b8 
(&dev_data->dte_lock){....}-{3:3}, at: set_dte_irq_entry+0x84/0x150
[   13.224217] kernel: other info that might help us debug this:
[   13.224217] kernel: context-{5:5}
[   13.224217] kernel: 5 locks held by kworker/0:1/11:
[   13.224217] kernel:  #0: ff364bde58164158 
((wq_completion)sync_wq){+.+.}-{0:0}, at: process_one_work+0x4c0/0x730
[   13.224217] kernel:  #1: ff8437db001efe48 
((work_completion)(&arg.work)){+.+.}-{0:0}, at: process_one_work+0x1ee/0x730
[   13.224217] kernel:  #2: ff364bde63dabaa0 (&md->mutex){+.+.}-{4:4}, 
at: __pci_enable_msi_range+0x228/0x360
[   13.224217] kernel:  #3: ff364bde4109bca0 
(&domain->mutex){+.+.}-{4:4}, at: __irq_domain_alloc_irqs+0x3b/0xa0
[   13.224217] kernel:  #4: ffffffff886590f8 
(iommu_table_lock){....}-{2:2}, at: alloc_irq_table+0x190/0x2c0
[   13.224217] kernel: stack backtrace:
[   13.224217] kernel: CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not 
tainted 7.0.0-rc3-eee9d444276c-1773350434439 #1 PREEMPT(lazy)
[   13.224217] kernel: Hardware name: AMD Corporation 
Titanite_4G/Titanite_4G, BIOS RTI100FD_1 03/25/2025
[   13.224217] kernel: Workqueue: sync_wq local_pci_probe_callback
[   13.224217] kernel: Call Trace:
[   13.224217] kernel:  <TASK>
[   13.224217] kernel:  dump_stack_lvl+0x78/0xe0
[   13.224217] kernel:  __lock_acquire+0x836/0xbe0
[   13.224217] kernel:  lock_acquire+0xc7/0x300
[   13.224217] kernel:  ? set_dte_irq_entry+0x84/0x150
[   13.224217] kernel:  ? lock_acquire+0xc7/0x300
[   13.224217] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.224217] kernel:  _raw_spin_lock+0x34/0x80
[   13.224217] kernel:  ? set_dte_irq_entry+0x84/0x150
[   13.224217] kernel:  set_dte_irq_entry+0x84/0x150
[   13.224217] kernel:  set_remap_table_entry_alias+0x64/0x90
[   13.224217] kernel:  ? __pfx_set_remap_table_entry_alias+0x10/0x10
[   13.224217] kernel:  pci_for_each_dma_alias+0x3f/0x150
[   13.224217] kernel:  alloc_irq_table+0x1f9/0x2c0
[   13.224217] kernel:  alloc_irq_index+0x2c/0x170
[   13.224217] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.224217] kernel:  irq_remapping_alloc+0x1b6/0x520
[   13.224217] kernel:  msi_domain_alloc+0x71/0x140
[   13.224217] kernel:  irq_domain_alloc_irqs_locked+0xd2/0x370
[   13.224217] kernel:  __irq_domain_alloc_irqs+0x56/0xa0
[   13.224217] kernel:  __msi_domain_alloc_irqs+0x1f7/0x430
[   13.224217] kernel:  msi_domain_alloc_irqs_all_locked+0x5a/0xa0
[   13.224217] kernel:  __msi_capability_init+0x152/0x240
[   13.224217] kernel:  __pci_enable_msi_range+0x234/0x360
[   13.224217] kernel:  pci_alloc_irq_vectors_affinity+0xc5/0x110
[   13.224217] kernel:  pcie_port_enable_irq_vec+0x3e/0x220
[   13.224217] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.224217] kernel:  ? __pci_set_master+0x55/0xe0
[   13.224217] kernel:  pcie_portdrv_probe+0xdf/0x2f0
[   13.224217] kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
[   13.224217] kernel:  local_pci_probe+0x41/0x90
[   13.224217] kernel:  local_pci_probe_callback+0x16/0x20
[   13.224217] kernel:  process_one_work+0x22f/0x730
[   13.224217] kernel:  worker_thread+0x1d3/0x3a0
[   13.224217] kernel:  ? __pfx_worker_thread+0x10/0x10
[   13.224217] kernel:  kthread+0xe6/0x120
[   13.224217] kernel:  ? __pfx_kthread+0x10/0x10
[   13.224217] kernel:  ret_from_fork+0x2cb/0x340
[   13.224217] kernel:  ? __pfx_kthread+0x10/0x10
[   13.224217] kernel:  ret_from_fork_asm+0x1a/0x30
[   13.224217] kernel:  </TASK>

Thanks
Dheeraj

> 
> Link: https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/
> Co-developed-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Signed-off-by: Lars B. Kristiansen <larsk@dolphinics.com>
> Co-developed-by: Jonas Markussen <jonas@dolphinics.com>
> Signed-off-by: Jonas Markussen <jonas@dolphinics.com>
> Co-developed-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Tore H. Larsen <torel@simula.no>
> Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
> 
> Magnus Kalland (3):
>    iommu/amd: Use raw spinlock for interrupt remapping tables
>    iommu/amd: Track PCIe DMA aliases in set_remap_table_entry_alias
>    iommu/amd: Invalidate IRT cache for DMA aliases
> 
>   drivers/iommu/amd/iommu.c | 52 +++++++++++++++++++++++++++++++++------
>   1 file changed, 45 insertions(+), 7 deletions(-)
> 

