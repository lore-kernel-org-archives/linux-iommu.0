Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804316431
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 14:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl/gHxrcj/Fnct+dj+27HwWHsdnBU8XD2qdHjtckywJThbFnKk1hbdFvlsLHDRUR6E20dekdZaYEC3zzzyVvH+nqcYPjYIdhIQACYPtjhL3yEs9wB2hoHByzWzLqc9efDBt0qPKKbREias43j4Jd6KhQShmIIBNkEuXFVcWpTrVOqnp8dOdlwR14q6MQrsmht++gn3SgAURmsPbUFudD3+2vDusuRx8hn+d+HJyECf1zGiXiaTDfTwu/28+cVw/i0jeueRy33oJm2Fdfr5OZpS42DcRKh1IAbchkf9aw/KkJ0LfSj4C0vf59/+3BxjZzFjEVjYsl7/0r+PzvwdJfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw34t9aoJ91MwrYbePDdPtp5dTM+S+z7Uzxtprbx74s=;
 b=aicS/n1Og5QGZBkCIJm1hvoUMTa3PQynWLMRlaCWMIVwtps2SWYpz8ek9TTsvnJEk5dFA9r3q/cSMgOzgBqgYex0lswi7xPNW1tTaEzKVXcJzRHs8NPuZSGKSJ106PxhL/Sdg3RzPJIYH6TH4T2M2LmUrYLXG3t5zwnxdcWoImPveEOrhIj2g8+AJfb+f8v5QHVHMb/n7BnPdIucetL2FJ0HV5OBI8WV7u05Qq3LdV8FE5T7SHjiuksHG7S6+h/GQ6KF61UK1Ap0Fce279/8fZA+dvmIRUlBBvSkmEW+F2LtimwC65+dvqwuFssLjxmyD4VSx1GF9C8zQ1Pq8bSxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw34t9aoJ91MwrYbePDdPtp5dTM+S+z7Uzxtprbx74s=;
 b=IwWThbWYcd6AnSUc1TdbXmyrIFkjOEJtRaB1cputUwQWSwPnm038Aasw1oKcelth5xmNbP35YhQG1kR9TH2CvZMWhNU3KPpMB5otfRc4qsE3GZNAuNgnOTzEn2fq9ZxNfUSWq1MP0TLwJqJGag7pIaZATpr4FjE77vMVcYJ08vZ5LesvJERgGgRYNv5ebTfM7AcIBjZVYdropwkW90frhpM+ovj1/Np6fjuFFK4kFBBgYJXmXKTTCLCHjYl+7lz0epUn6nCSkE4meBDP6MExH19e3Wxz4N5HaFIAcgUAYZWZSQa8QIyaVra/njyekzZdYINC/MwRlH5pfH/BfAp6CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 14:11:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 14:11:25 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc v2 2/2] iommufd: Call iopt_area_contig_done() under the lock
Date: Tue, 20 Jun 2023 11:11:24 -0300
Message-Id: <2-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:610:b1::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: a51dfc08-44cf-4e73-4e66-08db71983bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+fbFVPfI7PD+N2I393zCdVJPOhg5zq/FyNFiTfCClNLY6hsO7bmk2AVF8j642ym8ZLjBx/w6Mp/qg9Gv1S/mpcOVnB9dRL0GrNdQuJcZSJNtAuOvzG16hB9D19BiwMAVNQvbEPTlyAfCYJHKR+Ep/HYCF6YYfCJrYsl9v+H7MnRBM5Q4bEyDR6axAsmDRS7DOr5celIUjETlCksFPZBiB1SxI1NbH/haKFfC2k9Yk3hqPDUc+8dkmId84C/DxZIxkdRVsqAyguy3maVRnJ1VbkFZCFsgJBW2WaCz5hWpvP9pnnaU6fH2eSIafp+17OQzYAftSRuIIJ3/7hh9EoP2cZ06hZfMLXhsQBSTEOEPHs7DG2VF+1bSocPslGq2kg7fh7yQ0y8HhQhnvfsHaOs+qU0OK8QY7KOr3CCTHWSszO2u+XYxExbo7q3SfVZZScb/Y8CApGUCMudXOVvRRpunpXUW8lz9kh5357eplqmB4xWpTQHy4PB2mh62jMWhjpva1CqLwv+bP6PQycR4Ql9D2ndm4PYW/GC10M9TTspCKdrf5AOJLYQkYqr+l3y11bG+kCuUz409/aMwDUfp0piplSE/fFndcXkNNCJ4nnE5of0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(83380400001)(6486002)(966005)(41300700001)(478600001)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(38100700002)(4326008)(6916009)(54906003)(8676002)(6506007)(2616005)(6512007)(26005)(86362001)(186003)(36756003)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/NZIamIyRtLbctJ5rl5RFJ8JBxKfCp2vIx7CjgwjsTFwkck39ucfXJ3iwlsV?=
 =?us-ascii?Q?lJSNK6jHYWdR9OUQ0wpbgABLTsmrtLPKxfPkd29AN1iC12cUVSXdIlMfdtr1?=
 =?us-ascii?Q?eRQWkXjq3KfqMU3xVnCQolWBdXdgqfUx0a6UXidHJh76adaJGex966S5GYz4?=
 =?us-ascii?Q?DGHew0t3UPPsCwZ+hgLJV2eYgwpV40tXUE29dfILbLNiOanpah/ZMsk9B8Xf?=
 =?us-ascii?Q?g7KB0zB+67FRDHoQ4KLfhNGeIiELMyICE/gwx9dMcACf6vvdIG2qqenvrgpd?=
 =?us-ascii?Q?pQCRe07mGV1vnvpJFIM+EbP1q1V98mHUXICvPC8p98qsRLqMp2VTU5YWJyLT?=
 =?us-ascii?Q?WjBQdq4lQqNCpR9GNYvhhegcri6tCFUdB5X/oT+2ecsBQWqV2cq58KsjY+c8?=
 =?us-ascii?Q?tkOfzD8iJRl0w7oJJTvIy/LHW7ZurHGTPwjS0e4KBhyXYGM6/SV+sKPzsZKL?=
 =?us-ascii?Q?Zh0GN3fXfSoX0q26wNYBuW5QeGxIfH3x/xsxcRp1AfHMuWPefhbscYbb+A6z?=
 =?us-ascii?Q?lUYQOEo9QirP8XmvyCbM5U7sLrrCyjjH7RhPHcDZsKTiYvC8ert6mQz4WEkt?=
 =?us-ascii?Q?1xDoUT4PNzu8tz9gsChYUoIXVndnlA96aQ0j2UA1lBrVX2KFPwo/4L7PSQMt?=
 =?us-ascii?Q?t8HsHRD5/n92TdlxOX8wei4gZqjs8zCOeUb99iFzlnkmRatHk7FTfwM5CtWg?=
 =?us-ascii?Q?UJW7xvNVxfyYrZnzOuuL/9F5WI3SAgvNUg3gQAfnIyy//zd/WmmAsQGtody+?=
 =?us-ascii?Q?+jbYWtPAKkWJvyU+juw0JMdL0PybNPGdw2Q67BXlBlinl2Vk6Hveohh4n5GG?=
 =?us-ascii?Q?NSP8jr3UIe7KTtMPnOYS8NA7upqvU7YCkjfS89MwvIXDIP9ZDjgM2gEkUtqX?=
 =?us-ascii?Q?P8W+lPDDaI+lded1C9hv6gWKToh5l/DBuRZu8prG57b2KMkqj9nc8h8FRPxL?=
 =?us-ascii?Q?k8pbSh5p6jUU5vO85JjVGjN2MHLx+TppYdfngd2z/2NXleQBvNbFye9+2Bft?=
 =?us-ascii?Q?mfTSuM5Fl/Os5N7UxfE70l5XVEgDsQmLwnATPS66I6qy8RyGx1+X6am9djoL?=
 =?us-ascii?Q?y+MuUXMxabWbZIeg75S5pdXUePoHnpbkUprmsSYRfxKdmrHt3VUeJ5ldbfXh?=
 =?us-ascii?Q?r/8F5pja9oBmW12wwwJxJ0qM06z4DU2VYSFgXMld8uE8A9L2YQO3qWxibosj?=
 =?us-ascii?Q?Lf8z6sj3F/LiJtjpeFsUwyQJs7zzJjBTXe66ilK0RLky1g2jd+oBm8EmdnHN?=
 =?us-ascii?Q?hgyUn2RYBS5j0KaWRgn8Zo7pUql/lGVrXc6ZNRFdHYa/OXapfx/0TLIH4ia6?=
 =?us-ascii?Q?/+1GeVMJ9EHc+p20egmoZ3dm0PxSroGzFExHe7YLj505XT6cUnE2rU+lpOBz?=
 =?us-ascii?Q?iBAQx3mx2VxsIjgKbksLOiidzRLPB4cmYbldnhtQO5xXjNhHCZiBy8gK0bWx?=
 =?us-ascii?Q?yIiOIetCfREsnPKbALVpHlivpgpEK0m6Lj3kmogOqbIP/GVFhJPvg4DbBtZ5?=
 =?us-ascii?Q?OF+w06cnWYAzP8jjwfMzWGXCYUmn7U37EAon5eYm5D3v+R/EFvhcXaC0dwww?=
 =?us-ascii?Q?sXChRyWjAEHZcE6FnwmbMNO/Cohl6NDM6GxorWEH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51dfc08-44cf-4e73-4e66-08db71983bdf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:11:25.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frMVwzfxKm2Kz3Qd3VSxmjDU9NwCcMbvCQQeVVaIObdyMP3k0mheATL93wthN5yi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

The iter internally holds a pointer to the area and
iopt_area_contig_done() will dereference it. The pointer is not valid
outside the iova_rwsem.

syzkaller reports:

  BUG: KASAN: slab-use-after-free in iommufd_access_unpin_pages+0x363/0x370
  Read of size 8 at addr ffff888022286e20 by task syz-executor669/5771

  CPU: 0 PID: 5771 Comm: syz-executor669 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0xd9/0x150
   print_address_description.constprop.0+0x2c/0x3c0
   kasan_report+0x11c/0x130
   iommufd_access_unpin_pages+0x363/0x370
   iommufd_test_access_unmap+0x24b/0x390
   iommufd_access_notify_unmap+0x24c/0x3a0
   iopt_unmap_iova_range+0x4c4/0x5f0
   iopt_unmap_all+0x27/0x50
   iommufd_ioas_unmap+0x3d0/0x490
   iommufd_fops_ioctl+0x317/0x4b0
   __x64_sys_ioctl+0x197/0x210
   do_syscall_64+0x39/0xb0
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
  RIP: 0033:0x7fec1dae3b19
  Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fec1da74308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007fec1db6b438 RCX: 00007fec1dae3b19
  RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000003
  RBP: 00007fec1db6b430 R08: 00007fec1da74700 R09: 0000000000000000
  R10: 00007fec1da74700 R11: 0000000000000246 R12: 00007fec1db6b43c
  R13: 00007fec1db39074 R14: 6d6f692f7665642f R15: 0000000000022000
   </TASK>

  Allocated by task 5770:
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

  Freed by task 5770:
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

The parallel unmap free'd iter->area the instant the lock was released.

Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Reported-by: syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000905eba05fe38e9f2@google.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4f9b2142274ceb..29d05663d4d17a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -553,8 +553,8 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 			iopt_area_iova_to_index(
 				area,
 				min(last_iova, iopt_area_last_iova(area))));
-	up_read(&iopt->iova_rwsem);
 	WARN_ON(!iopt_area_contig_done(&iter));
+	up_read(&iopt->iova_rwsem);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
 
-- 
2.40.1

