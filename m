Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4461427D
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 18:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/vBwrbL4rmEUdcOWn6g10Feq/QJzgHwWgr+VQzIl6FKDXoEUANF/zW71fMdPze0YZSl+y+pWeQty637oig1AcknJVWhjMJWQ2kNhpfIZ5ckPK1FQPq/trEtzM4mrZ0mZDFSVrz+QaqtpsRDnfyAQ0l0Ej2NcZBHHnjfmPZxRhiZp/tHSLwVSZwyIyOPLkr5EGFECNpZWa5h5vG/+7hn9wUKpCOkOj+wiC3OwFCOhAL+pAmUMltBYmJZouWOhP0HIKvqFblK2t52ciZTuUWfGrYhEDdNIXquUHLsnNzJWA4yBsXLjQqcXtwwvPgf1L8u9kH20QQJyH6yEbm9o3ep6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oG5X5qCol50/3ubIh1o2njN9pEOUujiacBcrrCeM0k=;
 b=J3v48U+13lEMiyoUL0BSKG/2xcH86C2kT8589DIdqQ1Fl/UVfPhn6yjohsjP7rgRqPcfgSNJ5sxI0VVnebBZx1WLnZHr7PiGp3O1mJpiqt9RwuKvj4gdlhWFwI1pD2bMvaBhvWgXHE3x9VnIEEkiz9Sp1kqNuNBP/fQxWjp8aun0bFyVR+MWggE+FcvSD11hZIAKkFZHEgKRUHviruGQAZ0YkoE/qlmTidFjPWwLZp2Rhid5R7DzzLiH0kaFGfDpQ6sCYOnL3De8QGe1MhkUg77ILnpWB7FliCStfMNWc1Ht7pC0/UoY1+RZ3S2CPFp3zYJNwFci++eD98pWHDW0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oG5X5qCol50/3ubIh1o2njN9pEOUujiacBcrrCeM0k=;
 b=PE33KEYGdVz0mBp49KJo9UoxGY3fDLdCSWLRVkrxnTUWcnbfZywHQ4itvRcbG0hJY1XIcm2poff8tO1hD/HcqgwgFmcHH2SZLdq9H6PGL5ihHt//PA5oHe9C3iGXF8mOm29ryBxsn78r7HRti03hZN/l6DSksu/w4VfaGrYf41yIZBKTu2wqU4DsoY0MqtVxFByDcvaR4beeq3k+AwzeRY3N8ydwLm5osEcOPN4P+OgCHErLMiYj1483S1V2cA8j5C5ZieczHUJpqXXyOn+kee5NTILhI5pHEhraYx0bT2aYoSMjKWJOFcEeWOy3SpiAsc4QrwokKg0Jl/qwVgz5nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 18:25:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 18:25:02 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc 1/2] iommufd: Do not access the area pointer after unlocking
Date: Mon, 19 Jun 2023 15:24:58 -0300
Message-Id: <1-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YTBP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0bb5b7-66a4-412d-82ed-08db70f27ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QtPGEBEmBVW0D6cstf692otJTI5JuXk2tUvbKQOxVsHpi6cDGVzJMi1T5/EBVHPwdqPZB3hoHhRDw8XL9SzPgz1T+KwiUMmqtE32SETI9A26NId64NS8nDqEsGt1QpUAm560KfOieMQjKI+L5KJmrh95ppdob2C9NP/OaRpVauTKpd+r6J5jpIsmtlf7ht1mcSJ1dfx9VYTon9YwDEyAY/ME6wYcQ8YOAn1xyQTm7JReaKf8rCRtWn1g/Tf2GmSArdBub/FPJdAIjTKKAtdY6gqtGbaxaA/Ng+Y1R28J6JxhrKr/D370HMY5FcAjOTJPvCLdxn6MU+G/KmQIUnA6B96ZAHdjdq8RftiG77Haxfqpj+PfZmv4/OVYTj8sA3tNMkOx76qcybCRSCJxlkBwiEdPjKdFNB8A2II3AdH+TIaooKY8WNG1A6NyMMLL/JJUUry9J8jjlYFHVJ2sfXiBkSm5noNbLu910AVva+SJrbcmnEZxq0svwsZqkhvBmpmcUp6DhKBb9zIHDcCN3chRui089XrTAaV7Sk30dc9AOemmbs62oeASejpumBjzxQ2GcJkPzWeyiCAmsNuTvXuJ/4N20W8AjRXCVlycTqUCRuA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(38100700002)(36756003)(86362001)(966005)(6666004)(6486002)(6512007)(26005)(6506007)(186003)(8936002)(8676002)(5660300002)(478600001)(54906003)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(2906002)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Yf1tsnS6Bj8WF75tQOElR0OQiRybrqgvsZeUaaLOgcUst/CmyAC2BIe0Tv8?=
 =?us-ascii?Q?a+4ZkfVFv9dKisMIuUlFPFaOnfxBJTj4xs2lrSWlRpFCwmU2Jq/RI8vFfZG9?=
 =?us-ascii?Q?DmETug+jcFMXsvrbF9Uipa8X0uE22PjuxLt0dp0A5zC2BM+vpvxhnvAgZI2F?=
 =?us-ascii?Q?q20tjqAWQaAsN5NGWg5F9Gfe/qcJ0j35fcVvnBxJSnJ38k9xlZdTP5HDsp9I?=
 =?us-ascii?Q?cEWe8+7BPUW5N2DruSSVViNOhKUVfOckhfvJ2RKOAOKdMHko5SqprkTgs7V2?=
 =?us-ascii?Q?ywNz77pKYnQDGE+iMkGT1Q111fLFTT3odUNl0OvMfMCZI20XOLwmN/JaxxfC?=
 =?us-ascii?Q?gB5Ty+CLolSoJhJZlw6WW1LKqC8wuxib7vOHtizMzght8oCPL66ZC30inMXo?=
 =?us-ascii?Q?5ZmXcurktwSuY4YPRgnmXLwuoGj686WoIFO+TmFXSTdkL+xUPkeItWU4/s2H?=
 =?us-ascii?Q?RP8E2hp25dpNaJxR/kXpuzwjj+JhvUHhKirO7oT4buLb7DDUdmwXdupCXZsD?=
 =?us-ascii?Q?QqRn5n5adc/Q82jGBBZ3IW/ShdvSlsFmFq72sCP/62uk3R11bfK1Penk8Upc?=
 =?us-ascii?Q?5tZT6M6g8xE+8NHJ7FlJClHS/x/F6rALHdNM4bfWlxgjxJbPQEy2xu2tFECS?=
 =?us-ascii?Q?28qxNOS51xNPCeeIR5KnBLU/v+HpmYrxUi2EBDAZL/ByPn6UHfXudHZ+Ze4b?=
 =?us-ascii?Q?lpd5ZMtBniu/WY8HlDSR0bz6reJ/z2yhZKGUJTryJz7nwe6zpYtHoOBbZwBC?=
 =?us-ascii?Q?4jMGQI2if7QMgmmFRU+wrzw28K/nix0ardcGS50178U0nR0v+sJgDszg3GwU?=
 =?us-ascii?Q?H3OSZLUv+zaLcGqF7fgQiXhTlqCsEJ4rTMkniZy+i7fDsdWGlI7BFAP4GA3i?=
 =?us-ascii?Q?ofmZq2pPV44fP7MyhaTa9BISSP9UibhwY6b0YwcPjmjPsbn1N/kAzvMLB5iX?=
 =?us-ascii?Q?kbNlZv8yx7FE8MqsSEB0yMnAkfGud0dXAi18s11U3hdMCrFUWRBVop3xxhbr?=
 =?us-ascii?Q?gHoQcL/yiCGJdS9R3cJpIj5E4Hr01wIsdYGdRCekepuDWaOuun/7OrM/Y366?=
 =?us-ascii?Q?C7fJC0kwUASbxBu22zPLElMWo3xTapQDWndRdOl/rgG33ZZMsunJUIrINUqu?=
 =?us-ascii?Q?UiZtP8VViTQXd5D0/TeB/qqv+FYs1G7DB9nMs3L4bPtIlxD1smsP188sO3RU?=
 =?us-ascii?Q?nR6tSPQBfSv9W41MWZ9+hqFx/ikasG35wUqVcbGrSIV5s+xk6FbMMq4MgAvE?=
 =?us-ascii?Q?2lOBzLL8L5UDFl/x96OmZ8NvzLna7ScK3+/dkZBAgQd2Xze/cC1bAuPQkQTz?=
 =?us-ascii?Q?qf/UOkTQqW3nXjIyK9Oh9wjN7a2e6f8rTR5TY8jTMtfUyhz85lD/xaqGRmb3?=
 =?us-ascii?Q?7zZRZAZnpdaJ1oR+4UtRCaDxuBXbsSKH0C7+WtYwkSGsxzf12sBLtCFIEQyX?=
 =?us-ascii?Q?Y1SS2QJoI+3WlBK4OAb14j1oZpVNzsav+DAC+q/5cJ72v8Lp1lOLVBIvu1yT?=
 =?us-ascii?Q?aiq3nIErRD8P55frLCvOfCvCMhkIogPbCTvVOqw9PdCqyhN/EgeiN4wvtPcy?=
 =?us-ascii?Q?Gmz8KAbzBx8CRw4Y7SafqwNQiWe/ke9gDyg4M89W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0bb5b7-66a4-412d-82ed-08db70f27ed9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:25:01.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkUGjtYi4YyBUlYZH7CkezEo6DSWAmeC3oEuyhAwkRLLN/SjfUi+2nVXzzI8zUSD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

A concurrent unmap can trigger freeing of the area pointers while we are
generating an unmapping notification for accesses.

syzkaller reports:

  BUG: KASAN: slab-use-after-free in iopt_unmap_iova_range+0x5ba/0x5f0
  Read of size 4 at addr ffff888075996184 by task syz-executor.2/31160

  CPU: 1 PID: 31160 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0xd9/0x150
   print_address_description.constprop.0+0x2c/0x3c0
   kasan_report+0x11c/0x130
   iopt_unmap_iova_range+0x5ba/0x5f0
   iopt_unmap_all+0x27/0x50
   iommufd_ioas_unmap+0x3d0/0x490
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7f0812c8c169
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f0813914168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007f0812dabf80 RCX: 00007f0812c8c169
  RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000005
  RBP: 00007f0812ce7ca1 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f0812ecfb1f R14: 00007f0813914300 R15: 0000000000022000
   </TASK>

  Allocated by task 31160:
   kasan_save_stack+0x22/0x40
   kasan_set_track+0x25/0x30
   __kasan_kmalloc+0xa2/0xb0
   iopt_alloc_area_pages+0x94/0x560
   iopt_map_user_pages+0x205/0x4e0
   iommufd_ioas_map+0x329/0x5f0
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  Freed by task 31161:
   kasan_save_stack+0x22/0x40
   kasan_set_track+0x25/0x30
   kasan_save_free_info+0x2e/0x40
   ____kasan_slab_free+0x160/0x1c0
   slab_free_freelist_hook+0x8b/0x1c0
   __kmem_cache_free+0xaf/0x2d0
   iopt_unmap_iova_range+0x288/0x5f0
   iopt_unmap_all+0x27/0x50
   iommufd_ioas_unmap+0x3d0/0x490
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  The buggy address belongs to the object at ffff888075996100
   which belongs to the cache kmalloc-cg-192 of size 192
  The buggy address is located 132 bytes inside of
   freed 192-byte region [ffff888075996100, ffff8880759961c0)

  The buggy address belongs to the physical page:
  page:ffffea0001d66580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75996
  memcg:ffff88801f1c2701
  flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
  page_type: 0xffffffff()
  raw: 00fff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000080100010 00000001ffffffff ffff88801f1c2701
  page dumped because: kasan: bad access detected
  page_owner tracks the page as allocated
  page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 31157, tgid 31154 (syz-executor.0), ts 1984547323469, free_ts 1983933451331
   post_alloc_hook+0x2db/0x350
   get_page_from_freelist+0xf41/0x2c00
   __alloc_pages+0x1cb/0x4a0
   alloc_pages+0x1aa/0x270
   allocate_slab+0x25f/0x390
   ___slab_alloc+0xa91/0x1400
   __slab_alloc.constprop.0+0x56/0xa0
   __kmem_cache_alloc_node+0x136/0x320
   kmalloc_trace+0x26/0xe0
   iommufd_test+0x1328/0x2c20
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  page last free stack trace:
   free_unref_page_prepare+0x62e/0xcb0
   free_unref_page_list+0xe3/0xa70
   release_pages+0xcd8/0x1380
   tlb_batch_pages_flush+0xa8/0x1a0
   tlb_finish_mmu+0x14b/0x7e0
   exit_mmap+0x2b2/0x930
   __mmput+0x128/0x4c0
   mmput+0x60/0x70
   do_exit+0x9b0/0x29b0
   do_group_exit+0xd4/0x2a0
   get_signal+0x2318/0x25b0
   arch_do_signal_or_restart+0x79/0x5c0
   exit_to_user_mode_prepare+0x11f/0x240
   syscall_exit_to_user_mode+0x1d/0x50
   do_syscall_64+0x46/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

Precompute what is needed to call the access function and do not check the
area's num_accesses again as the pointer may not be valid anymore. Use a
counter instead.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Reported-by: syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000001d40fc05fe385332@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f86..bab9b6464d18b8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 {
 	struct iopt_area *area;
 	unsigned long unmapped_bytes = 0;
+	unsigned int tries = 0;
 	int rc = -ENOENT;
 
 	/*
@@ -490,13 +491,17 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 		 * without the pages->mutex.
 		 */
 		if (area->num_accesses) {
+			size_t length = iopt_area_length(area);
+
 			start = area_first;
 			area->prevent_access = true;
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
-			iommufd_access_notify_unmap(iopt, area_first,
-						    iopt_area_length(area));
-			if (WARN_ON(READ_ONCE(area->num_accesses)))
+
+			iommufd_access_notify_unmap(iopt, area_first, length);
+			/* Something is not responding to unmap requests. */
+			tries++;
+			if (WARN_ON(tries > 1000))
 				return -EDEADLOCK;
 			goto again;
 		}
-- 
2.40.1

