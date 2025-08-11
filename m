Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDE1922FB
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871867; cv=fail; b=Hxh3FJLft7ZcbeawJjrplncAFqxTdEAOtg5H4BBGa1S0GuqZnBvrlXQy26v+Sh2kqUc052Ei29kkfxvEUTaQQBVBgIBZVvxfy/EE1VDT8U2+5rw4UT/+X7BZicEbr19Vp+/k3GXF2lGsLnNJV1pLswr5lgA7piNJT2edoGL3M54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871867; c=relaxed/simple;
	bh=7S9+7hXuupTElSl4qkb3Cir3BeWYziWTLOwO8w40FZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLTkblOBQlUdncaEwtvCRaS4b/ClhsYprQr4/gLXvhVGCOLYENVs2JnrnHQ2ZgKB/iPalgH6fYlMoRsYSZvgtPF/5mY2EccnCrwZEeklbtwaExkvgPGL7FP9InH+NG+diKergHJrDkmPmsgbxdgNAX84PnGveNh5nRGmkgswWtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aNb8DwDT; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aNb8DwDT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY6+M8O8E3EGK42XxOot2l9An8bG+AUXm2pfAUgMnU5L7nhhMS4v0g4NVRm1279uLFfJcTopMqSoRnCD0eVFcUbNcP0aFtr4Ipb28MPe/Mlc3zpdMur/3OvDNoqqqwz3FEPCWWtmTSWZKAHG/4e6TiAwN8NsxniIHzHPQ7+F75+VIQxuVuG1aBUnlu/qnH4WW3/PFHZ9+d2aCv8wUW9X85biIr2mpgfFEN9/lpGg8Nn9ZzyvKZweXij8eAxJg9wK0NZ4j7dnTYNSBDgaIw3BIqFS9GbvUseIeiduiOnd/oQEQww448Gb+8ZOKxKw8FN9R+bn3XelisKziREAQsiHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t/2+IxKAxipnp1W80SRHa+0rIUOaLymiVSezzUBPh4=;
 b=yi5QMCw5k89a+BimWTBXTS4YQX5T50s/PfXOR2U6wICzSR4J6Z+dbVQr/suUbXwKoRP6rHaL0ZqhRIeNQI5nytwJ9uEyOhfrteZCSa5lqx/hXqgFxzoWRK/ZJKWKhGlAI7lUTdRyF8mjeyq362qyWoDehOVUIbLnU5Y+MikyFKsHMHa5HoL8wMoQ7xe08XGVnL291SY9nb1R0uTBi0RMVuNYj23ICajYmWjEGP+Wu2U0cxEG9qRH/cQng9rG3kvOhluI65X3AfR4ZdwKovF0XzS7HWteZtmxenijuWpUNaSPNCVkavo+K4dEVjlpuNWrbw5WcXurKd06bvZXmsMRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t/2+IxKAxipnp1W80SRHa+0rIUOaLymiVSezzUBPh4=;
 b=aNb8DwDTLQbwSwwydYaPz9UP+/nUAARdn/AD3+VikPJAo1302ilBK0gmMZzrM6v8mbVeDl3aWCzpBqZktEJpoqsfpiIxS7eC+c/VhSv6dcMlr+gZwzKeQ8PVDU3bjumX7wBQm47R/pxvdgJ/9tc+kFccZnG+MMCqj0qjlCau5w7HI7ZcZoZVsnTNkHCPuwJHypDY190eQTpE+KrrE52aKSSizo/lYwSADq8oha6NRtVPFCAFHXN2F5y/z6RG6YJXULk1Zv6qj2sytsgJKr42pfiVwhR3j45VfFtnrtXQMe4Mt9CHr5yIi46FE152zOAxZtOZo4j1+LJxuONAo5WLNg==
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Mon, 11 Aug
 2025 00:24:19 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::74) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Mon,
 11 Aug 2025 00:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:24:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:06 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:24:05 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>, "Mike
 Rapoport" <rppt@kernel.org>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, "Dev
 Jain" <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc regions
Date: Sun, 10 Aug 2025 19:23:57 -0500
Message-ID: <20250811002357.714109-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811002357.714109-1-sdonthineni@nvidia.com>
References: <20250811002357.714109-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf0b213-61ce-4337-f8e2-08ddd86d6983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THp2ODAzcnlTdW1yQUszUk5mdnJtTEJCSVl6L1djbzZnZUVBdWxqK09tVURz?=
 =?utf-8?B?QnZvMk13STFwTXRrbEVRRlVVdFlwVzNzNFpzYTQvZ1BrZGVKamw5Qy9LZisx?=
 =?utf-8?B?QUxXWnRjMGVLK0ZYY255NW1qS3lHMG9OM2NpNDJ4alRrWjNIRGFzeTBjVENw?=
 =?utf-8?B?TWR6UHRoMHViTXJRVGFuTU4yenRMU21IUHJGSnhBeGt2RmRCM2hsa0pmVm9C?=
 =?utf-8?B?aitxMjBhK1dpNldPZ3dRRmoxRTdhUk1GbzdJbDVPSVR6Vm9QZzdLWmxsTjha?=
 =?utf-8?B?L0F6TW9Da20rNXIwMTZuK2xwZ2JCSXd5T2IyRW10aThzQStZTFVBQjV1Y2Zu?=
 =?utf-8?B?QVE2WFNuVnJNYVhjd242R216OE5pakZQNGFKL1pyejRVYi9tNUR5WDdscm1E?=
 =?utf-8?B?UmRHV21tL3pYakNUTTZ0OG15SEthc2g2SlM1cXRJeElUWTErTEZJWFZyUU02?=
 =?utf-8?B?cHY1dUdPMG1BRmVXRkt0cVF1UGJlRndWVThVUlFXN2RyZW9mNjF2akpVa2g4?=
 =?utf-8?B?UWZjbXJ1WFpWdEcxdHlhZ0xSWEFGNW8vVjZWVGU0NGFIdGU3ZnRqRmF0Z0ta?=
 =?utf-8?B?aGlwZElqTy96cndTenVFNC8xMmlPUnZxTERPMm8xcDZjQzVsRzFlQnhPbExi?=
 =?utf-8?B?RXo1V2xMSjdmK0JyaUJ6ZC9raEExeGNZdjVXZzBVeVcrVll0R3phaitWOW5Z?=
 =?utf-8?B?SmZRZlNPTm9hTm9INFdoS2NxZWlNUTJXY2padktQOGV6NDZPQko4alh4Q04r?=
 =?utf-8?B?dE5seUMzZXBVL3RSemM2dWUza01RYmZpN0lvRVNXbld0c01HR3I2SjNBbGQ5?=
 =?utf-8?B?azYyRC83T0dnN1hyM1U1cGRjdmRVN3lmVUMwVGRnUXNHMzFJWFBlWDdXclIz?=
 =?utf-8?B?eWVpMWZ3Tnd0a25HNVIwTFNWc3NpdUt4S0FocDZHNGpxN3FUalRQQWoyaTJ2?=
 =?utf-8?B?R0tBR04vamoxb3AyRG4yVmRXeU9scjh6aU50TVhHK1hUc1JhVFZoa2NqRWNF?=
 =?utf-8?B?RWFra3VkUkpEYXJYM2RJelAranRuNnBpbExVL0RLV25adDJFUkszaHN0dDdj?=
 =?utf-8?B?dzRONWVZOE1yMi8wQUdyOTlzaDBVYUlVNTBaQ0hHTWI0T1MwRkZtU1J4N1Q2?=
 =?utf-8?B?Tk1DcHVTUExuNmpLbjJjakpZVkk2SzZsZEJ0bHpqRVFvOHc0Z29VRTVOMDl6?=
 =?utf-8?B?WDNnMGNHRUUrNjQxQ2s4cVR1ZHg2enVaYSs2b3c3R2kvOHNtSnZkaHJhcGNa?=
 =?utf-8?B?aWtRZXpNSnpXdlJDTzQxVHRPQ3VNblVab3c2TkFSYTh2bnNvOTcyOGZCVU4r?=
 =?utf-8?B?bTA0a1ZZRGFxWWJaRmxzK3dabkRERjVTK0UvSUdFSW9sS2Z1YUE2ODRCNXlp?=
 =?utf-8?B?Z3AzUkp5Q0NvSTJJWWVNOHl0NGlBS2VUWFkrTFd3anBQemJUb1pqVUN4R2RY?=
 =?utf-8?B?aGdDRXMyeVJCYlovNWtGYk9CK1NyS3Uva2lBcUVyNWVrb0Zia3llbXVyakk5?=
 =?utf-8?B?ak5hRGNjVnZyd29iUHdORG9XMWpWTFg0dkZxUnp0L0phRkJFdUVpOElERjhM?=
 =?utf-8?B?OStGTW1hTUw4WUFhS3lVZXZQNi8yZ2FDVFhTOUdiN3NRam9DNG1oRGdNWUZV?=
 =?utf-8?B?ZzRHMmpSZEZyRVFTbVM3SkxxVk5US1hDcW15OUJrZzhUVWJSQmxMUVhVUHV4?=
 =?utf-8?B?bi9LeE1jS3dHUDhXMFc5a1Q5VmVkdjFTNnlJalNDaGJ4aUxTMlV1L0txdlZL?=
 =?utf-8?B?M3VZS1FsdnIrSXZ4MzJFRVNSdit4c3VQVk9kbkRGN1EyOC8yYnNwUzlmR2w4?=
 =?utf-8?B?MURSR21ibEpMTnNKWVNwWHJubkVHWFR4elJYc2poazVUY3NscHE3c3FIeldv?=
 =?utf-8?B?MWlWMUVKQUtUNVBLcTVmT3NyTXpTOGh1dVNpUU5FVnNXMFIwZXNvSHU2dlJz?=
 =?utf-8?B?UUQ3Wmp4bjRzRkFRUWw2VElUMW9ETURBRHRZby9lU0NEQjdFZkZOa2dLOStV?=
 =?utf-8?B?WXRNQTROS2ZsclZ0VHBsWnhTOTVRMWYxSklKMmV6MWwyQXpXamoyMW1lK2d2?=
 =?utf-8?Q?sbdF6D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:24:18.8527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf0b213-61ce-4337-f8e2-08ddd86d6983
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8

On ARM64 systems with CCA (Confidential Compute Architecture) enabled,
the kernel may need to change the encryption attributes of memory
regions. The existing implementation of set_memory_encrypted() and
set_memory_decrypted() assumes that the input address is part of the
linear mapping region '__is_lm_address()', and fails with -EINVAL
otherwise.

This breaks use cases where the memory region resides in the vmalloc
area, which is mapped in non-linear mapping region.

This patch introduces a new helper, realm_set_memory(), which detects
whether the given address is from a non-linear mapping. If so, it uses
vmalloc_to_page() to resolve each page’s physical address and applies
attribute changes one page at a time. For the linear address regions,
it maintains the existing fast-path.

This change ensures that encrypted/decrypted memory attribute updates
correctly for all memory regions, including those allocated via vmap(),
module allocations, or other vmalloc-backed paths.

Call stack of Realm crash, QEMU hypervisor + NVME device (emulated):
 ...
 Freeing unused kernel memory: 6336K
 Run /sbin/init as init process
 Internal error: synchronous external abort: 0000000096000250 [#1]  SMP
 Modules linked in:
 CPU: 0 UID: 0 PID: 64 Comm: lsblk Not tainted 6.15.5 #2 PREEMPT(undef)
 Hardware name: linux,dummy-virt (DT)
 pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : __pi_memset_generic+0x16c/0x188
 lr : dma_alloc_from_pool+0xd0/0x1b8
 sp : ffff80008335b350
 x29: ffff80008335b350 x28: ffff800083162000 x27: ffff80008335b3c0
 x26: ffff80008144f000 x25: ffff8000801a27e8 x24: ffff800081e14000
 x23: ffffc1ffc0000000 x22: 0000000000001000 x21: ffff800081458310
 x20: 0000000042a40000 x19: ffff00000232fcc0 x18: 0000000000200000
 x17: 00000000000120c0 x16: ffff0000795520c0 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
 x8 : ffff800083162000 x7 : 0000000000000000 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
 x2 : 0000000000000fc0 x1 : 0000000000000000 x0 : ffff800083162000
 Call trace:
   __pi_memset_generic+0x16c/0x188 (P)
   dma_direct_alloc_from_pool+0xc4/0x230
   dma_direct_alloc+0x80/0x4a0
   dma_alloc_attrs+0x94/0x238
   dma_pool_alloc+0x128/0x258
   nvme_prep_rq.part.0+0x5f0/0x950
   nvme_queue_rq+0x78/0x1e8
   blk_mq_dispatch_rq_list+0x10c/0x6f0
   __blk_mq_sched_dispatch_requests+0x4a0/0x580
   blk_mq_sched_dispatch_requests+0x38/0xa0
   blk_mq_run_hw_queue+0x288/0x2f8
   blk_mq_flush_plug_list+0x134/0x630
   __blk_flush_plug+0x100/0x168
   blk_finish_plug+0x40/0x60
   read_pages+0x1a0/0x2b0
   page_cache_ra_unbounded+0x1f8/0x268
   force_page_cache_ra+0xa4/0xe0
   page_cache_sync_ra+0x48/0x268
   filemap_get_pages+0xf4/0x7a0
   filemap_read+0xf0/0x448
   blkdev_read_iter+0x8c/0x1a8
   vfs_read+0x288/0x330
   ksys_read+0x78/0x118
   __arm64_sys_read+0x24/0x40
   invoke_syscall+0x50/0x120
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x34/0xf8
   el0t_64_sync_handler+0x10c/0x138
   el0t_64_sync+0x1ac/0x1b0

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 arch/arm64/mm/pageattr.c | 55 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 04d4a8f676db4..65c3322a86b49 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -202,21 +202,26 @@ int set_direct_map_default_noflush(struct page *page)
 				   PAGE_SIZE, change_page_range, &data);
 }
 
+/*
+ * Common function for setting memory encryption or decryption attributes.
+ *
+ * @addr:        Virtual start address of the memory region
+ * @start:       Corresponding physical start address
+ * @numpages:    Number of pages to update
+ * @encrypt:     If true, set memory as encrypted; if false, decrypt
+ */
 static int __set_memory_enc_dec(unsigned long addr,
+				phys_addr_t start,
 				int numpages,
 				bool encrypt)
 {
 	unsigned long set_prot = 0, clear_prot = 0;
-	phys_addr_t start, end;
+	phys_addr_t end;
 	int ret;
 
 	if (!is_realm_world())
 		return 0;
 
-	if (!__is_lm_address(addr))
-		return -EINVAL;
-
-	start = __virt_to_phys(addr);
 	end = start + numpages * PAGE_SIZE;
 
 	if (encrypt)
@@ -248,9 +253,45 @@ static int __set_memory_enc_dec(unsigned long addr,
 				      __pgprot(0));
 }
 
+/*
+ * Wrapper for __set_memory_enc_dec() that handles both linear-mapped
+ * and vmalloc/module memory regions.
+ *
+ * If the address is in the linear map, we can directly compute the
+ * physical address. If not (e.g. vmalloc memory), we walk each page
+ * and call the attribute update individually.
+ */
+static int realm_set_memory(unsigned long addr, int numpages, bool encrypt)
+{
+	phys_addr_t start;
+	struct page *page;
+	int ret, i;
+
+	if (__is_lm_address(addr)) {
+		start = __virt_to_phys(addr);
+		return __set_memory_enc_dec(addr, start, numpages, encrypt);
+	}
+
+	for (i = 0; i < numpages; i++) {
+		page = vmalloc_to_page((void *)addr);
+		if (!page)
+			return -EINVAL;
+
+		start = page_to_phys(page);
+		ret = __set_memory_enc_dec(addr, start, 1, encrypt);
+		if (ret)
+			return ret;
+
+		addr += PAGE_SIZE;
+	}
+
+	return 0;
+}
+
 static int realm_set_memory_encrypted(unsigned long addr, int numpages)
 {
-	int ret = __set_memory_enc_dec(addr, numpages, true);
+	int ret = realm_set_memory(addr, numpages, true);
+
 
 	/*
 	 * If the request to change state fails, then the only sensible cause
@@ -264,7 +305,7 @@ static int realm_set_memory_encrypted(unsigned long addr, int numpages)
 
 static int realm_set_memory_decrypted(unsigned long addr, int numpages)
 {
-	int ret = __set_memory_enc_dec(addr, numpages, false);
+	int ret = realm_set_memory(addr, numpages, false);
 
 	WARN(ret, "Failed to decrypt memory, %d pages will be leaked",
 	     numpages);
-- 
2.25.1

