Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5A566C
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 17:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhjLldZDUOMLN2aoz7yFMdsVqkqMcSpx6Qkg3WKnh3S6qbJEhlaJ5dulOfMV8F6sxzC2JYjnzVEWhXiO/AyTLvGeT/zePck2qQQy0kqOyXvqPRXRZVtOb51AopW6nmMgBrnuFK4iMTfTyaHTkHa3OKzfRTOrCAHnXJFrwMOE0cffvMhyXLYViTrAaf5jXzxDv+dXGGO3cNHCoNRFJXJcODp3/d/rtIe7L0lzFLL9tBz7HIjaOR6+BjqTv52/nlZ3TP1yUrHFS4ikG6LX2oV4LRR4+N9/xtiSgURKk2Hej/Y+5tej3ynvByoHefXKElY716VkpAO/oPKAjIl/abzOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrhK36AfQ5FEuD6pfijDwGkNFyS2qGvF8mEqGd0JAKw=;
 b=R5BLaOzbNQFK/cHn42/VpMvq1I9WyYN1Q8tZmI5p04VHuZCrx+c3LI6HXSsYaFyaHdW0FXH/mwGN7f8wDcsxdSimbo1XKySKPG4iblSE1Sw73HDzvFWUqX6KJdwuVxHWzvcUZZB7sLBQzGNiB4+KgESz56GZPOxsru8k9rBbKDwKlBFVSSik4fQJpfA3hkghqgRdpDSs/evIZS1+JBN963obHm9I7EMmYzwrdVfTjNu2wQgeDBAG5NJeLXFIqiBGmWMVidEyrZp/PiZQ4UHzEdb+25oZuRdYSnjq3ptLN1+cz0DY3aXEFOcB4IA8CeLFBOwSQ3Uo/5BoueNiKcCvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrhK36AfQ5FEuD6pfijDwGkNFyS2qGvF8mEqGd0JAKw=;
 b=CpNKFFSUjMneWOcx1xbC2ZiW+pBmB2hd7sKSSB3Eh/4pu4RS9LxfRr23XQSbPcM/tqtvR+OAXp7PX2z+iu+GyLuP/p5dMsbpTmBrHwM0kMg1pL+9SJzQsudYMj0d2PCOYMjdpWy0niREbwAxlSPS3Im/2bs1Znj7/Xs0yA7z+adybo4qTWoqrmPZkbxMWDv9UrBzVD8LXUxa41yTmYmpBzLaPe1HztGZaC4KuB1AQEJjxn5Yt/kIwjd+yLlu4eDI2q3MOdvY1jXe9buYa6UJN+a8IjdICnpzAKWos59NDkDQU7QWUI0xXKYVLy0QcfHDiv9T6AeOrJPvrjP21kXOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 17:27:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 17:27:05 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Date: Mon,  6 Mar 2023 13:27:04 -0400
Message-Id: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:335::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddf2981-d02c-4095-861a-08db1e68015d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ro1OiPdcAA+S20/3rIjKdICOFkbpmwELO6sEfnoLNG8L/m1LAH7C0Ot4gKXHffJfuoLGMRyziNOSG65q5G1P39KSDxZ/A/3mraQkB9Wp0oeQJH8zJpV9+rLaBYFcz0vYmOysrq8K6FPVtWr6B7E0k1IH5mDHqPowuR7Fww9cFS6u7eclMGOpjTt3a4f5MdXNBdgv1M/e8A8gTd1EHZDJkwtIzTB0KQVQsIiLbq5Id+iQmgYd74roXa5TB2rcZgj96J8qBS7U0le18Qpgv6d3SO+xOFgLotDRbnoSI80CyEX4sazviwJ1yEtuOnIvb+e2nO3PO14qznAmTl2ZQ1W0NFER4xmbWRT97Fh/1wJBwxJgEVZy1TNq17Q5AbT8ui1bat50PiWMAEhOLqbc+O5S6flqnFvNJ6wS3D+UH+/IDK+HuyZObD7Mhq2/7taxf8r9iPpw5pib3D8VzNoijfACJ7RKPBONZ72dY4niVuRkFu0pjY04H9LMRmY/i/AzIF1V7d2/yOOQ8yyWftuHZpzowoDNM3N4OoJmblhIoQ/p8qTyCghQaWOfCjTRdeolQZX0dzCX+VUpKvMxk7WxFz2fPSdyeJ8dXPq3h/9xgZFtBcnkQNrAHg9V7cOXS8vJ1enxxIt/NIb3j8mBJY9xQqhT8iBbJabsaY9gdeKJvccrcb0rXI9AD6goeKKwT1RkFbf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199018)(86362001)(38100700002)(66476007)(36756003)(5660300002)(2906002)(66946007)(4326008)(8936002)(6916009)(8676002)(66556008)(41300700001)(2616005)(186003)(26005)(83380400001)(6512007)(6506007)(45080400002)(478600001)(316002)(6486002)(966005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDyWqWkofvlRPYDKNqOSsuqqnUpKmGSZUNXMdUR1/ZuPlZXtM7nVgkqCNIG1?=
 =?us-ascii?Q?5SdSDmKZYkRM45QWWsY3laD7q9/GH/4EFZJAnQrfUdr2uHNBZv73vYqDRnop?=
 =?us-ascii?Q?y29QqYvKhD3FqIA69HyH2gp0/NlI3fL2AKMhBiZKo020Pqn7nKlzVo5khLzL?=
 =?us-ascii?Q?eWpLV92GViySXoAOquPP+KlXDd2PVTsrjhobzs14o27YtbDfedm0Lk1Dahhy?=
 =?us-ascii?Q?f+J9hkoIr8MPuXQWU60mwxFBnTjRqPW9Op59kEoSOPCx2O2xhuxjCYkAlMsz?=
 =?us-ascii?Q?wZQ+0nGaQmPnIx0qt798+M+KWkS2i7roicGKqluXqetTGFihgp+nSAnoWNeN?=
 =?us-ascii?Q?71IyoRdOcUYyHqRBuhjb52SscPs1JClGr+mCAePCHah18hf3TxqGR6mcCeQx?=
 =?us-ascii?Q?pr67hJfa5cpGZ6Nab+vjZ7AgQnL2VIGtbli1WmNKku9Pb2RoVLhsjRfLfSaT?=
 =?us-ascii?Q?RMmodpevRvY6KHU35TrHPsFaQ+Lj+7ywX54qvq0QIna0T6ZZvl/vbpZwdTDK?=
 =?us-ascii?Q?JrfwzbVPrgoFRauGhN1nc4acMa/xXNn+8nFcgN6WsA7YjslaTIVi/AF4zDPz?=
 =?us-ascii?Q?ouzEAOxBrwVDkBioPlb7Mz38DUUP2pOVYZnwDGDp8ifMrE84JOWVLhTez8Ft?=
 =?us-ascii?Q?V8A5UFbUsvOcFA1+mSvO/RZ6UziFrHu+Y+QbjYibgwruHSEv1rJUeD1rm/mu?=
 =?us-ascii?Q?0xZoBbp87mYNIGgZo4qG45Il9WlK/1q6toRuziMSxDSJbMhjOAjgmcHuq+P1?=
 =?us-ascii?Q?EIbut1TqW0qg9UMqNuuoTlpmte7uS4YKxtbXcKJg74LkQXuOZ3HSq+CpUvXY?=
 =?us-ascii?Q?UQIC6zaUOT1hT9NIRogv2XIgnoUnF2yOGumsniz1tbTqjR4GZq8S4jkhI4Nm?=
 =?us-ascii?Q?fDWemk8jM6n0POwFFRZp5SpeZzQM8DyQNmu53lAb69FmQdIHZsqsv2wg8SWs?=
 =?us-ascii?Q?QdiLxeKrALrWWwr6RE9zGQUh8zfFzNU857kxggualTdevXQd3aGwxDpl5R7r?=
 =?us-ascii?Q?z5nAZZpbpknfkhlLOQ+oY88/f6dndMWK5HX7Erh3HIXk8XNBEtlt80VMN+80?=
 =?us-ascii?Q?866LpSQJdggyKD9aLK+GjhlExZWN4+zr9zz9jg+Ox0JSxTs3p55qKyOIhT0O?=
 =?us-ascii?Q?85/DojMEErBFXRD0bFUs3TMTuvrazzZNGG5T3k28bovvCnysZDn4PhVqRWlL?=
 =?us-ascii?Q?QAuRDuPfO9M0SkyHh7wTQK1HM8nkE4eESUNMJ9BW16nurw00t6FLc0+U/xLZ?=
 =?us-ascii?Q?r4++JOXGXgN9/d7OPcZ2YM78RzYP5KvMXhk/RZDULLqWpN1vXr2GKEAqPljm?=
 =?us-ascii?Q?G5+9q5fEvdod+K0YRiDXzl8TzVDACetK+wAYDveh2rUcus8Q9/kP3oeQd6Up?=
 =?us-ascii?Q?sCuRXp9N8uWz/drgnyxIyDkt/t9FTdxAS03hnX7PkIwMZFJPJwJdJerDK4n3?=
 =?us-ascii?Q?hfxww1A3TDSs9DZMJY00OCMdBbQm9LT0WxCgqUAburGNRfRSPSYwEG/22cWp?=
 =?us-ascii?Q?MFFFj8c+PkD4tc0YwRwU0EFkHbYvXQhNVqKvz+6w/HtsJQkyHYpR6XxMQFpd?=
 =?us-ascii?Q?q3n/NntcP0da3vrPJuBud92RhZm/PmmeAszzLbrY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddf2981-d02c-4095-861a-08db1e68015d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 17:27:05.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvh0n4KlYTJhSFStGAOKVz2Aaq06tVa2liIG/kKgVt8PWhXfP8dI+k18yy+8TWey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

syzkaller hits a WARN_ON when trying to have a uptr close to UINTPTR_MAX:

  WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
  Modules linked in:
  CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:iommufd_test+0xb19/0x16f0
  Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41 be fb ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
  RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
  RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
  RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
  R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
  FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? write_comp_data+0x2f/0x90
   iommufd_fops_ioctl+0x1ef/0x310
   __x64_sys_ioctl+0x10e/0x160
   ? __pfx_iommufd_fops_ioctl+0x10/0x10
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Check that the user memory range doesn't overflow.

Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
Link: https://lore.kernel.org/r/Y/hOiilV1wJvu/Hv@xpf.sh.intel.com
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 17cb7b95eb2757..58471f9452be55 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -480,10 +480,12 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 {
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
+	uintptr_t end;
 	int rc;
 
 	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
-	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE)
+	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
 		return -EINVAL;
 
 	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
@@ -531,7 +533,10 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 				      void __user *uptr, size_t length,
 				      unsigned int refs)
 {
-	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
+	uintptr_t end;
+
+	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
 		return -EINVAL;
 
 	for (; length; length -= PAGE_SIZE) {

base-commit: 4ed4791afb34c61650b17407846174a72e4034f4
-- 
2.39.2

