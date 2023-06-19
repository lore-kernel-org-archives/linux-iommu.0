Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18A1427D
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 18:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPAJxn9rbqjjSymYp0dX4Wpr8fv8vB4xhziupR1w8+eGKdkj2Wyy3Bln+Ap1aSaykZCR0t4jTCqP5wEUEReWL7caFY390SqAyxyE98mRdxbGVoXOj3v4x0KqXkKSe18G8j+tnDTmXVOF+v04i3KOWe5V9BV7ka2Rs7yCqlmInEY7oo2K5c7SgERLRdXnomuoVzdEdOkeEWLD6fRrmDgK0xygeu5V1q0zUpDDVnUDoqkgpxepcjhtXC9SHMT21YUq2Phf8b1NGM61A7RwAZVc+E8ScOpKqC8Caop14A7LfZenA//ijRZRtmyhE2n7MGVziQD4A3z+sc8CoC4elErvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufKhCjEZRF8MA42DhIluwAQbrAwDlK+pnnLA4P7ChTY=;
 b=R5QwBCPKFO72lpYDa+ZFKdvU1oH5P+JlA8x+37MxcuhFa62JxFKVmbFcvFoVEbm/qBHbsfALWhpbqRgAE288w4V3uTQfGPk7830fSeuxEspvP/C7d9c2YhtSK2NCo8AvqfahlsJ8j73ClqNwEhPyVY4NoEMdeL2IFDkvQixKnndLxmSDI1oYOrPGW1X5jE5jFMDVylUoum1vYwSy0YI8HkldA8k+ilrSEYDFqKjaX+AqWgE32O4986T06oiUFgbOYqGMlbjFeQ/BgPkAm6M58Pd5CRJv7bNYF3JDxoB3CnzB7MTRp6M0jiuoDrADqJEbHwZQvb5gJTYSm0AatH/P5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufKhCjEZRF8MA42DhIluwAQbrAwDlK+pnnLA4P7ChTY=;
 b=VK2bMb+0s8aey5oBc2/en2IMrjYxoIZgNPXOVYMN8grFnW/UlBcpFIBrdFsb12qajLGRlJzEM3jCOkqq6JVcL9Be5kF7Lm1qL6t0p5r4Z6SkwKSRYXFZm9RL/WpubrtS4UCdqpA3gdLJcAqbAXV7SBXM7zwHl8HrfdyI0dkpS9l4dX+pxgEONDMGEEyGDoZ2yvx4N6rF8uIx/trMBD1xpU5xAZjMYjFnjb+sj46X5F3vWyLlJ/HlpcBzEAySmJLt1h8oE/trsq47RzRekp6VGdQYn+u28XUyhbmwbrFARHPJgxpAtabuPFOEHHfZpAh02qe7MO4oepX21Mb/0Bg73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 18:25:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 18:25:00 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc 2/2] iommufd: Call iopt_area_contig_done() under the lock
Date: Mon, 19 Jun 2023 15:24:59 -0300
Message-Id: <2-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
In-Reply-To: <0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0204.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7791a9bb-76cb-4b4e-91a6-08db70f27e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uQQZManNfLjA61j9m++cv4XPkKRxvEQ+e3uxZ/4NZyvcd83ds/qKw/qgXJ2zDspthZEe5wC6ZdXHDDt4n+HwZCwvmGEwVeBtLDOVoPJ4Uy+3zsD+AmyCUw6mY/DcuZ72MSFJ0/necmWICVRI3m8/OmsxdO7/+VFKJsD0aztUCizU2a3cBxwpDYp4OD1sacdndh4LBhZSXN7bc8i6q/IoYj+Yt8Ep/yIQR2mIde0ry6SlMKOn1K3df1NJ4uvvbsydsDn8pbMNTm/d1aEUmhjWLt8wd+AeDrUGMf5AKK0YneuuYKBsVSkFqZBROLPiI4CKWKGnigFl0sWCdm6n3jxjTLnNAbmBeOWDi/yh4Yl/t63bSgRjbjo2kcP8aPuj/iCaVkLIIvB839+h4J0XnYuuqYaPcP1a6Caw0Jw3Aq5KB7BhkhMx++sgysGcDY329BZ+PpYqnggdGDMRh04hGr9DVynLR8z/AHkQ87frci/JTiJNaj9knu8MGU+vrff2FI4grepUpqoMzrGL0EaoKLT3jUsw6qpRhqei3Np0Tw+GhNz/h60mCn608kQNWTxDmbaanub+JD9K087WwcrveRkBCWH7IhfAeMnzkClP0zybzLo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(38100700002)(36756003)(86362001)(966005)(6486002)(6512007)(26005)(6506007)(186003)(8936002)(8676002)(5660300002)(478600001)(54906003)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(2906002)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stp+Nyq7hvUkYhoIF4p91yhIn6BE3pmRNghS6TS/x/1WvLlSLgIt+NTT9T8o?=
 =?us-ascii?Q?HOzeB4AhpmDggSx3SSXK/PHyAyetSTbE73DfDMZa7dJEboDliCK05LQIq/2/?=
 =?us-ascii?Q?9zcuvEhU8xZ4J89eItgJ0kuLLgIKV56/hSdmqqtW5DI1yUYh2TSiN9JXXMdz?=
 =?us-ascii?Q?s5YqwDEVy8EkGsBtR7b5A/QfFFGMLUa+LC9aRBKFglzh3deUOJCxDzX6m99F?=
 =?us-ascii?Q?KjD6YuFISNGbO/i2uZMjfKT0c6JgnNXYo2IGdnsuY+TLXgH5fhrDiFUmfNfL?=
 =?us-ascii?Q?JO8KTmA4GBPYDT891m4cW499HyzYSUATbTY4RymGDXK2pOh7lljMkaaBmgvx?=
 =?us-ascii?Q?vGXltHWFkeYOVXLcOORa6y3reBcgbVgx1HQpIZ+Df3bAcW/1XfxC49WSBIKx?=
 =?us-ascii?Q?SzFNC2C0dkIbZx+wUxdvsKJ1YGm7BMyeexLuvMdUgCt6JCy1cyPluVIqarcV?=
 =?us-ascii?Q?a8t/TaI2CpFqoVcQ+CzhF7KkriNsMOATJgZA5sM1u2eQqsalj0hwlD7d+vT6?=
 =?us-ascii?Q?7ab39zY0MXHHx4WLxBWd9RYjU01Ib4MXy3EQZUec3wxNrEkrGJfcg/AGGhKx?=
 =?us-ascii?Q?TYDVjFOMwyuka1DZELhNWzoY+kj82E9dqxIQJGTkHhq2e1nt+2EhDbttfSwP?=
 =?us-ascii?Q?wT3g8mfEVX1R/yZIDZi6PkC5O+/PI9zsgOLi3b7qeUzpMKKixzQbQJSS43oP?=
 =?us-ascii?Q?t84XmOaV77IC9074gNLc4bfo7/yAWTdwEkXOzp0lFq4+kkqeKkabpFwGXL8P?=
 =?us-ascii?Q?AKdEJ5D6PXmxHuT1606CzS1r7SCNWIl7000xkJF3EfrOFWR6FCcdyffx2C8K?=
 =?us-ascii?Q?FE+woHbIR3s2r0xGxyoytMv2N0EkXXtx4DL+9zlD9ebxGUNepwjZQnBu6HqC?=
 =?us-ascii?Q?Uo+7RXOq2LGiEYO+fBeWtFYU8GUJvU12vSKqxp9ClePVIDReElr5wXnjeD0k?=
 =?us-ascii?Q?NgaQGmXVOVioVhPCE4+DGPA0GhwszUDvtcYgoTNXUlicL3CAt33QcUpQT47F?=
 =?us-ascii?Q?ZOvrboRgduzjWJXkzMC1RwIB3e/DFVztlLsNrGvBcNCKb+OYotmSfG+aVndY?=
 =?us-ascii?Q?XAr5u0Uvmf678ww814/K6CMbifzwwFJD8Oc+byimHlKJPE2U8qktg6SqdIKL?=
 =?us-ascii?Q?itumggRgil/PHMWmcM/L6Xu2u+NB8/AFkBEV9TEwfnHjxV3kpPdnK0NnAylW?=
 =?us-ascii?Q?ua7bro1anmVfJYFV5sr+Faadokr9IuWBapf+o/uoWjew2ttd0UNyIxz+PRkg?=
 =?us-ascii?Q?Qj5AWuazQOVci+J40dgAgeWqniLuJtREC/RaYexQnAaWbLMdPuNs/Fivhgpm?=
 =?us-ascii?Q?Ji2icpE+togMXrFngy4rUZvc8BWDtLddkRjez0BmX4BuVNV17GTbceKtLv4l?=
 =?us-ascii?Q?hveKKotAms632/+Zpk0E6Tw+bXGjlNZmJdG1wo1W8QQ/G1obJP4UMj9p0P1C?=
 =?us-ascii?Q?Lf25ZlupX4QjgknFDwksyqkcBKp7YgviiHpa3CFwLlm7D+X5x95dh4GRSWN3?=
 =?us-ascii?Q?rcr5Z5HKTHwCRa4spxgqJnbf86t9xfVfRn+xdBKdBDXDTXrSN8ruNxtFyv88?=
 =?us-ascii?Q?uhnsZKmFXTeeJ8OgicKLfKalpk0XbOzUBIDKLTfV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791a9bb-76cb-4b4e-91a6-08db70f27e3e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:25:00.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBrvIkPrO8O6WqFQug56N45DsnTIasxot8b7YKDHlzX1A2mGX/4LylsHRiGFHa9y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863

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

