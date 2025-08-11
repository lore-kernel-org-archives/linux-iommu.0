Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFD1A256E
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873470; cv=fail; b=fUB43U2FGWmtoComOMlgpTd7cWCvL6NtzgNGxm8s6ydlDyz0m6EZlDXXCMc5RqFlSX4aGy0KyyHgAXk1PhocIdWXdWm62ITZT9XJzjb+s3fyHf6V3iytgpSEHwdG8V2pt+5QyQKUOvDwFnDOxyTDeAo7lVZb83Ic2BhIu0klVO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873470; c=relaxed/simple;
	bh=7S9+7hXuupTElSl4qkb3Cir3BeWYziWTLOwO8w40FZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t32wZjXhXW5ll3Z4a6AAuinRrkK4a+GMyNhrhpRMRFoIZA483sb0kGtvAJ0GhII/thNNRhMs2zemZIoNko/j1tMCEuLvNaf+bhbEKvaSegeRQmDrgE9XSuVD/ns4DJ3RXEMqjbMKWgmxhNoLEYAI8IPYFaI6p0/pb8lBdUWFd+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CzCHvEUF; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CzCHvEUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsCKQ0QHgdq84hZtzR8BnizhLwS6T/Haz1XThwNWm9xhtr2+38fCAWVZF11gEaoUCGpWquc6o+S13vqqk9En5zv/8Br2TXq3zmBvRVTM1sItDAwli4SPhI4YrBo9V1sCOKfR0VWlgHrpPY6/j4GgwcdG//DtuZkA0Vmb+Uzbp/NA0SyGuFjVYy6cztI0kVBak2wdmIRhj6UuLNZYY3GRXhbNNVfta/RPCL01wRuUD5rFsVO5fH6nwYUNVJMyv5HG6OsdFogzIgriaoGBtDdo9YM7Dd02O6zm4Hh5Jzj5KhZ30CUumpJzqD0pA5W1fNzVBCYJNa7iL//+2EG3A4Ehsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t/2+IxKAxipnp1W80SRHa+0rIUOaLymiVSezzUBPh4=;
 b=F5Sa2N6kvsUGimLWFTITbcxqf3gyrKtvVVtjNrco+vW+PAd2ylAl5MQry8VMsdfelXhi5I64bwTCOV97xFzUrOobdtncR+wqMYAjdqaFkSyTBCslC20JKWrkjP4ml6SIF+x1UzaX+aU/LUHxIKHUhupqt26DWGq/wJjptvneePBfO8EN+Mw+RBdTDvS4nGgJjELQ7nM8fdE1ipXxSi4D1d3VHEZy5gAfZrgNrCQGxInDTjpNjybaYtgTZ23bRtm16MSk249jQ4uYWGXctbzsfWFpPcZzvdFCKW9LXUdqPeHbVjfNyeGF1e4xHfdgKiFS6j65fIkYgkD8U9pufoF4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t/2+IxKAxipnp1W80SRHa+0rIUOaLymiVSezzUBPh4=;
 b=CzCHvEUF5b4zgbweNF/Atdr4u70kQFHR5JuC0rWY/1qiByw3uw0m5XCQUbIfAaOveGPrYr9IA8jljy4ZTZGLXbTU28JA+AMLIm2Z5CwfydvR7j9KpRIln3lckNmKO1XQ89sJ2MsR4sE/tdkCRDlcFkppB1ISYEQOuI6HtSu6exjWiTV2Wpbclu4e8ZILaS+3Bv/5HX2t8v24d83jxsC87W0aVllAOxHga9J0rccQo8Q2JmUrkWCo0nZgDzvom/teOCRAYXA+9RSdzL2EV2hj7HDsX38jbLwjjgZVvXNylrpUBuUYRDncochOCxqKJC6D0T5f42uJv70x8cXVN0HAXA==
Received: from MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::33)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 00:51:00 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::cf) by MN0P221CA0019.outlook.office365.com
 (2603:10b6:208:52a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 00:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:50:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:45 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:50:44 -0700
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
Subject: [RESEND PATCH 2/2] arm64: Add encrypt/decrypt support for vmalloc regions
Date: Sun, 10 Aug 2025 19:50:35 -0500
Message-ID: <20250811005036.714274-3-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811005036.714274-1-sdonthineni@nvidia.com>
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4b8d44-b66c-4471-e548-08ddd87123a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnowT01kZDlxVDh3T3JZVE5jdHNpRldRdWYraEpENWpncFVhand6eURvSnpG?=
 =?utf-8?B?dFNSTVVzaDhvUWhOelEwZDd4dGV5Ty9BYTMyTzlKRUJLYXlrZHJMTk5hczFF?=
 =?utf-8?B?VzlHRzg2TWlXNjVJa0VESmpTQ3VCVi93YWIvdFpiTmRRUTVvem1GOVN5RUxZ?=
 =?utf-8?B?MUp0V2hFZy9uRjVtaDFZWFB4cXI1alRiSXk0QVBWcTkxRmZuRDA2ZDhuR3p5?=
 =?utf-8?B?MlBvWi8wMTNJYmplRGRoT2lSVTNCd1BBVjkyRUljaWcxaCsyMFNWajFOTjZS?=
 =?utf-8?B?VkhiRTE0V3RvaGZLclU5b1FvcFMvOEkrUE9uR2F0QjFYUXpXa2F5R21JTTRs?=
 =?utf-8?B?MjZPOFpyYVUzeS9ob1NIdk1EUXh0OTZkVmQxbFBNYlFwRiszcEt2REpWNkVt?=
 =?utf-8?B?OE9MWUoyWk5VTUtqTFl2R1FXMjlpeWloQk5nRHBhN053a0thdDdQbVUydnRp?=
 =?utf-8?B?UENkRDZEbEhicC9vVEIvcTFvZGtyV2loTVRZbmJObWNTR3hZcTdQREhSdkda?=
 =?utf-8?B?cVN5Y3p2aXVWdGVnWnIxK1VDd3hTbllkbE8wWEZpRm9KOHFDbk1hQjZsaGt0?=
 =?utf-8?B?K0cxclJweDhqWkdIL2xyelNBcVF2S0IxREcxT1FLRFZZTG5BdEx0Vy9aZCtq?=
 =?utf-8?B?MHFxTFgzTGRPMjQxS0FFMDRac3VXTitIUU1LQlBSaHNMU3UzcVZVSkVBMURn?=
 =?utf-8?B?WHVmaU9Vd2dFZlgwdm5VVWpoMlY0SEZ4THFYdllzeTZBSEdKWGtPaUhZeXl6?=
 =?utf-8?B?SVBqdlNKa3lYTDBuVlIyb25ycXhRVjBXWjFJSnlsUVZ6cDFRS0lwazg5VTk2?=
 =?utf-8?B?VVBZaWg3amVBbHhOaVdKbGkrN3dHTXp2a3JtWWJoWXM0SEJCNDFxUTdnRFQr?=
 =?utf-8?B?WHFVNHI4OUw1RWlEUWd5a0FOajNZQmRHRG56dzBmMzJWMTVFQm0xWTdTVFAv?=
 =?utf-8?B?ZGp5SWR6UllkSHl0U2RHWnE4ZXI5QjVYRmVIbk5WekxlckhkTGVCU3N5NFZy?=
 =?utf-8?B?VGREcnB5ejh6Z2dqeTFrS0k4bUNVZGZ0MnRoVndJQy9WY3JaRkNoSlVqdlJR?=
 =?utf-8?B?K0paanFIekN0VThkSFRpdUhEc3I5NTdWUkF5c2IxU0JyZ0hTWUNVYXdUVkFB?=
 =?utf-8?B?MTN5Uk1sdmg4TkJqNFFZNHROM0RnaEJWMTZvQUtNSXhVT2tuSjlIbVZNeGFL?=
 =?utf-8?B?bHFyVnRkRklSdzJrelprMXdzelhmaHV1Ny9TUVBzbUp2bjNzb2pqeEh2UWRY?=
 =?utf-8?B?SGE2N2pmVjhSeWtyS0lDODJ3akJoRUdjOTFLYjZaYS8xWG1hcWNwRFBCY1RW?=
 =?utf-8?B?N3lza3JFVk16cUdQMWttWjdqWi96ck1QOUpyTjllWVZ0VzRPTjBvYkVvWjVH?=
 =?utf-8?B?L3BKaFAxWVN2anp3bXVhT1NNSk1SYjlGRFZvS3dIaG93L09kTElZaWxIaEZX?=
 =?utf-8?B?V2ZXaG1JREY2UzU0T2w3WVd1ODNvcFZXbWtsUGxpRndKY2NCM1pFbG9oWHNG?=
 =?utf-8?B?Tm41V2tEUlhhaU81YlQxL241NnIzNFZCeVVwSzErNW1xK1pSbHhxSDIvcVlJ?=
 =?utf-8?B?emZqNkExTTJGNEt3TzQ4Znl2aVJEZmxiZ2szYll2cEgvOEFMRStoR3JvbGtK?=
 =?utf-8?B?aEczUHRQcTZZMFJzN0hOSUpwMXc4cm9iaW9RZ1RjNmpaREFEa2creUFkVno0?=
 =?utf-8?B?NmN0eUtIYjhyelJpSFhQRXlLU0ZPSWZ6V0hadmVHQnpxNjE5MHBYcThmT3JG?=
 =?utf-8?B?eHJoR0REYngxaXZlNWxlalpmV2VDVHA0RzQyL1FqcWxNRVhOQjU2UENYRUNi?=
 =?utf-8?B?MUtRVzJYeUZxVzl1SytrTnFDSWJiOHIxTXNEQVFlVjFhdkZWYnd4VVE3QkVm?=
 =?utf-8?B?ZmVvcVpMTG5IU3hpYTQ4d3NrdXdJaFJSSnhZL0FVcG5YSXFrcm9Ta0hjbXAx?=
 =?utf-8?B?NDRWTER6MG5jd0NjOFBMcGIrMWw0eUc1QkcxL1ZJTi9SU1U1V1d0U3F2ZkJ4?=
 =?utf-8?B?eDU3RXBkRGdoMlJOcEdscVJrOTlDQXdHVEpKSnNOMkh5MWdxaWp0NStuaWVq?=
 =?utf-8?Q?+brS7j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:50:59.5812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b8d44-b66c-4471-e548-08ddd87123a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

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

