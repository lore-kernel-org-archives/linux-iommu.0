Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40861643F
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8ZwWifkENejzkSogoTX4toOVhOWrVK27HrPBRQf4/Z96iQdqWzsGiohS/GO3CuUuPIw//j9OsSFZS+l7ZhxrB5pbVdLcprvS0n4hmzDYlDnu7OviSgM0k4kJpFflJrZ2Big+KT368qKBClCpPcpFt6oQpGbmFExJg6L+Qtf895bdaMciniLLgGW/ql93xmxNBvz6vJqLydPsZ74A/DN6Iom5QPwo4eZN84tzswSULndTdJ+ruOuEgjfMHqx8We6bSix9BbilXv+SnUhA6cgEbSL3bCAfjNLPH9zKody0NimaOa+vkRnN2Vny+aH0fwGCb6ag6jBUp3dFSMWSBlgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11K/ZjDWMbBWHPyULj59FU7TnEqmk8OyqOeFQY6XF9A=;
 b=RCsEdPAOSxnhB3ryg2RdNK4/0HPpngONBPQKDMCizRLtC7H3iYV/nsCdcwhh0XwC9EWsw20NWEDXUN3aRPENSmKRpfdou6CAvrtBOC9LKcYYJfA3AqEd9dP1uVwrPZMH97a2TR0glL8In4OELuGPjaPiZU5CEAPptRQ9JEedBwJNo8etpnGRCjWxjSA6i9plbWHy8qhuCsOej9MOUwja7H22A0to2gR10jOe1cRg6Mt8TBRGAJGbWRr8Gz/qlGIf1ipySxiL3Ab61sjDEO07ZNpcFVyoD1wTEUorG3vSlgv5KuH4Oj7PTE9GRMO6PcP7qZFLw6zvtgUFVWdqy6fwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11K/ZjDWMbBWHPyULj59FU7TnEqmk8OyqOeFQY6XF9A=;
 b=gbAgYQ5/tSwmjpgbgzpxReALA9DzspLvScvFYC0YkCgkoxvjRqzkuWmto2V7rLh0uAqX/GF5jkYsRuT5Ic3jQGm9chEhId1WLzmtaotJvdnWN/+8gtOKRRawNg8wcZiwdaG4jxowRmmFB95QUx1rR7D1hITelodiS00wKx8KG9kIQ/nY5Q2dapyqHSm+n220mOQq57MqGVAFwT+xZntQj+AOVfbQmlQJH4Hl8ChGSl8CEO7kPF+t0HQ8PKdQz6lbxY0BC2vCsng/zecZzHx6PqmE8G4lWR0SYV6/O0ae0KsP5p02tigCIIfQ+UvYFcfgXuB1dTsrYel3dqPaMGz9bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:11:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 14:11:26 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after unlocking
Date: Tue, 20 Jun 2023 11:11:23 -0300
Message-Id: <1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:610:b1::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8867e665-3809-47d6-12f7-08db71983be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PxWoyYpJM9Fs/D1GWQqcevGvn3i+azipB6FkVwxyUy5TVZVLLaZmalkk+vWzYxYs6Q4E8SVZccl5vlj5eFJJTWBCOPdnUGiX3MOv1LY+N7WzjoboJnucPjcQmkZujTr4jurG32a14P+Wj6yozsrE03pes1ufNEtxPtrvmLfrbiZof+gLMYKV0vSUbvx9RMyFp7XvrWny9t6+iEqTsU8D8D8q1XYTIQDtcPMOwXKSTcRG5v0Rpyirl/xQgBwfTEktlgafq/FDDokMSBK7/B2d0RMhLSzuW12n+9gfGqJQ1xMkBTNxnS1FvZkNM+kCgldSAWrSsTrhxQJ23IdEn9IlE5+95YuF/z0qbwFQMm6svRgkX3MMQ2Oz/bFTNfpz+ilqP29Z4WTZ4gl+izVbMlB55wlvsrR12CbQtwrXdsBskc7G4pqWJNT1ve3VERKRZvEwml35IpsFZ8zvPhW2VzbfTtkfOFWRyhXWY47nDR3XnvlOQ0pnLskusBB5TgW6/lGa7B/VuqKP6oEcIFqP/fRF7G6qEC8JVugnqz9grG7m8O+ZKWTumAPZGtGV23SHLzIJdcnCDnnYvMe6astQYjnx7JoIDyYxPoboq7FtB8tc758=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(83380400001)(6486002)(966005)(6666004)(41300700001)(478600001)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(38100700002)(4326008)(6916009)(54906003)(8676002)(6506007)(2616005)(6512007)(26005)(86362001)(186003)(36756003)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vU+dJ/ErL9UxtYfK2aDzn1k/f0zTfGVTCHtRgPTTJecxeWeJRhc2SD6nx4Q/?=
 =?us-ascii?Q?eZmvURU3q2vpEn3o1bRTEe5VO4kw6QmRHapKYBasFj57Fb8tWuiwC2KT3uXZ?=
 =?us-ascii?Q?tK6Abe8YUAWhAUJNujfGkzfox/jUuYD7WanCqm0qCqFADuGB9IvcXd43En5C?=
 =?us-ascii?Q?ApNyVikSVw4t2OgpRZdy6QMkKt66IMTjMawkpOZP7OshO+fwHjxrggg9fRuy?=
 =?us-ascii?Q?wm+bsutTO0iibw99/I1YR+rIDxgAKUjSGJsFvjrfKYdLFDtyyUQTyksdzMmH?=
 =?us-ascii?Q?hRrb63uOuFdzUWgnAQi9NfUu66OK0iouuy79aaqw+p5mFdJAzjEurXRZZWXH?=
 =?us-ascii?Q?rBUwKBibPeQUaF9rzqWwtFYj6cU0lNg4JzT2qrj/2usCrms8B1b0WYM59Q44?=
 =?us-ascii?Q?0yqx3Vx2ia4ytAp9+V7BDOwskkpcTOlUGnM/Ba5xUvanZdPdIKQjeOYAtv/d?=
 =?us-ascii?Q?Jv5Zula6BDlTNWuxOukqs44RexJGAqXPPANQkpXUYWJtlOvqCVqOT/k80wfs?=
 =?us-ascii?Q?ivwV6VDlY9Fn40wUbtrlhE+4M0wiba+kQt8c6ImueEcAImRRBea0Nb5SZmMs?=
 =?us-ascii?Q?g+3rPLXTRMOZUOW1T2b2xHoXj62qpQXS9Mi0G3GzLZGhf+KrogLvYsGtZYib?=
 =?us-ascii?Q?WTTF/o2u7wc67T08q3TxaDsnrjDsh0sEAdrghtez53+EdAmpa7mxScedvS7I?=
 =?us-ascii?Q?6yUSEQ1LM32mdYPE3UnUYbgZdZiHCqhWo6KaQSSHuB96N+Dx5nVeyLwRYh5w?=
 =?us-ascii?Q?Obpd8gYu6vrV8Y2gktqSRxdrf8n62Qw3S+jE3lceSq2KrbyhFY0365DAbgjD?=
 =?us-ascii?Q?UHWHzfSFp1nt14caZRTCi0O+L3nhfOJWY5oHS2eDiotyq3aE9NyXMX5nZL59?=
 =?us-ascii?Q?NhXNYA8aHwoZhtNY9C5qldE/hqhiHrAia8Jv8L+YCQ1Akawm7/8MQzGe2sBQ?=
 =?us-ascii?Q?0eRDsc5NTjZFJekDKI8ntAqN8GtvkOiUJ84ijWlPZwrbuqRJnn/nqRfWPhED?=
 =?us-ascii?Q?HKHf2g3i7sYOMUh8YK9eZ2BcD7Zj8g3PUFHR+1evnId4se+ZPa5DElpFqKgT?=
 =?us-ascii?Q?SvAtYQWwkLn+FOeHW61XQv8j/huTpiExh5XhgftGnnGN/+iHFj24/y8lSrsp?=
 =?us-ascii?Q?dDIjH3PSRMWDoyKwQWFRF5JK5cfH5LBOy/CiAqLJwRgzOCM5W3gi3JwgAQoM?=
 =?us-ascii?Q?c4fBV3H20B7sXlrfeLZfRzMA5A+PRcwoDsAysHwMOeHr+s4/mt+J8tYnNy8Z?=
 =?us-ascii?Q?+/ImZve34tWQTfMcI2wBLQGod/6yFt0msRrktshjiwJrLylnAq9a8maS/+wc?=
 =?us-ascii?Q?lg0wDxCcUZ0yWKL+0dOycGT6z5mD92MZsntw5tQ1QDQWnuSCB569SBYNUpEh?=
 =?us-ascii?Q?ZqDQ41p9Ze9XlVqnwEiAFq4ki0Ez0ik3MSqAYt81uo0NKRsCmqRwcaMPgpfY?=
 =?us-ascii?Q?piqK/CStApKWTcLzwyMT36laHXMW6XNOSP6EpqL8+41SOqCKFRZOhivvstv9?=
 =?us-ascii?Q?v7TuJ43nPdMJ5INjr9ZMxlU4b4/32PYTpshmQOvm6SopCaHWzyTuCubbre1e?=
 =?us-ascii?Q?0bTNHRMR7UsfrjCqDTgMWrb3TLNU6dWsJdlcLS9y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8867e665-3809-47d6-12f7-08db71983be4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:11:25.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y17xkUO1zY4b8b3RJpagT5kFV7VpmIjQ48s5ZJYaIb+2zwUZ1aPxRzljhJPa+7rE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

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
 drivers/iommu/iommufd/io_pagetable.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f86..724c4c5742417a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 {
 	struct iopt_area *area;
 	unsigned long unmapped_bytes = 0;
+	unsigned int tries = 0;
 	int rc = -ENOENT;
 
 	/*
@@ -484,19 +485,26 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		if (area_first != start)
+			tries = 0;
+
 		/*
 		 * num_accesses writers must hold the iova_rwsem too, so we can
 		 * safely read it under the write side of the iovam_rwsem
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
+			if (WARN_ON(tries > 100))
 				return -EDEADLOCK;
 			goto again;
 		}
-- 
2.40.1

