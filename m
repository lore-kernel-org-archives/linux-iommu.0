Received: from mgamail.intel.com (unknown [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7447111E
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690897450; x=1722433450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CPAacdsa8wAiSWl/FDER1hcL6svRKyoWPbxRryWaHj0=;
  b=HmI/BvQ4Ax4gsupPpRMmiPj1Fo3tZeYGTGHgzDta4SEfKzqpjpi+u47A
   riOCOmNuusQe4q4AwpVIIhOS1xVf1cwXJ/Wiiqh4lJk8pfzNrwd4QnVhz
   cH95SjIG3RrEd7hMB2zTx+CH2JRIJgbiFAv2EEP7fzs6hXNt3Me7RYqAI
   0vXsLBi1W1ZIy4CnJkW7P22IlD6IIeEOdcAME9k93f3HldVjQRAcVtg4I
   HNViQRovV146MJMbVVFMCg0uWUUqR8EqzjFqC+ufacXTdq91ITM0asxYy
   SPPh4/HoVxaxUtnDUeUoRbTrKZXqhpMK4STGUXvZbDyqvkyNaNlRtu6QF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348900462"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348900462"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 06:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902554376"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="902554376"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 06:44:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 06:44:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 06:44:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 06:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG0bHHrR2PvBlIJTGGWCeBpDNXZLs34k4K+9NVnWSKWaFNraRYJuR2issJzMlo6cQywMX50H5usshpd10TI7ACBItRwHkZkI0EQi/7rsF6hg5/NWiCvxT0faZe0FGC5kuDSI/v6AeJwB1eJMu+8Nm5etForJjlYON58OOU+gVfLGGTnR2KwkqsFJf/PTH9k0i04dH8o+YkqlgeMpvUMbbsuKxw0os70GSWd0pYM3VnRkpQPnR+8LKzpMRzFT+xXIJ9DFgYRW7n/hA0NQtWbdHQeWiNrTFN0GGv2U2LfbWMXUR3X2/ntsVG9wzB5gP/nkpquGH18bxK8kQkmlzXVrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ORY6jITnddPvMotPKDon4rQf2kjUj4Fd7g/5ycFBiY=;
 b=Q0xSoWEplNzzruqI3gi2eNn2GrHx8P8RhMiAUCd7wiU5UMDW/MnBW2CneESd+gZJ0YRsxuv2EF7b3oVIWtLX5WVfF63+QTEz05pS3T7eVPsfAy5AjY186VR1Q8MO2Brf9qZFzzvI08DH1cv+ImB+mFzitsYr7E6un+WccpCcXo4ywac6qMucYjoz7OIQgBQNbq/tPFE92VAaNwvSNFZB/7Xe/z+fDk0ITgxWYPxMvRFXorYKHoo40+z7xmswQ7jqPt0ZowhrSdBt1E0+4TVYm2G3zltvh/BXY2mXbGSH0I3lvKR2Q8ytn9hvTCqGb0KeguUru7xvfhDjPN+5wdwuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Tue, 1 Aug
 2023 13:44:06 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34c:f9c:28bd:e642%4]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 13:44:06 +0000
Date: Tue, 1 Aug 2023 21:46:31 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <nicolinc@nvidia.com>, <heng.su@intel.com>,
	<rafael.j.wysocki@intel.com>, <lenb@kernel.org>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is general protection fault in
 iommu_device_unlink in upstream patch
Message-ID: <ZMkMt1cTeXhg8yBM@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH0PR11MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: c6afdd09-3a0a-4efb-252e-08db92955fdb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTz5aKMmpMgoMCBNZ/S71jBtaCiqP0bagLNFbOPXzZSS6Jsx7X7n5KAd3DJvhLsDMus4tsu28/3Du2ILctz1smF5lI5CTwQvBXw3BIIzQtXExO1BGw/w8XjEm6/2+QpbNyBxdC3xyQARDfbPqDzkEZqquUU+CCcdjLk/yKuBbJK5xOxYQHfnDehh+OhTEIOiv5Ft9sGiMyfXdawBMhk4KzJ/yl59Y4rOG1ngPbLpllRnjZ8WPgjwbtqFbNr2wrks8xdXp9JvGXZSWt2GJUxzjZwnvmV9DmzU5WVS5z341HXsSYszGc8c4EeK8Pm/4mx6LwSiSbQzEvxUghWPe+h3XTllHqB/EMhoDdUP19mMbOUZNkdBba9av0HuCv77GT01rTqa9ECup2NwHfivanHOVuKQu59aKpj0atikJrdXrUH5a94ZmQW8HkaxtqHDftNH7DFAlSHHlRTQF088XUbYgS4xgiIovFtVmeVwbACilHKry2xlf5tO2IjS4fvA7IP9jB8o1xLi9+J7f1EI8496AVoaxtgaiovzRZBBx6Pqpt8EzHTI8SkaZkCbv5+ysDJm6vntjcmo0CaUC45p/Dkxz57zYv8p5gKzLl0GzQkMaNYiQlFptmz23+PEXRcqKZxK/LnHGThrz0p+EIei02mBhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(41300700001)(316002)(45080400002)(6486002)(6666004)(26005)(8936002)(6506007)(8676002)(186003)(83380400001)(82960400001)(478600001)(38100700002)(6512007)(86362001)(966005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAcwlLsDkYrKr3meRWL4uM1u1vFxSnYpCFjGICa++kfUxNDEHVmZfOamqmAw?=
 =?us-ascii?Q?29/ROpIGewBta+2LkzK7XxAC4dPeZt1VWnCZUR7Bh2u/mfu0TDgoDvaVK+WA?=
 =?us-ascii?Q?0e3UX6UPiiQkTvFOLSSTJ6W7ML5jbFScZiUEl+eHT1zZFQB3SAEpCVN3yyU/?=
 =?us-ascii?Q?HBBc7YPM0K52AzIYE3uBXruv8RA/y9GYN4v0ussGwM9gOQ+OuuELWyLgfR9R?=
 =?us-ascii?Q?R/NBGD7RAoUFaHHPexeoG40+9nbT2DJaipNTKvhxcxseJ6km34Ty3Gmse0bP?=
 =?us-ascii?Q?Jk3AfBWaP06Wkf+hLei7qMdAHrSMloq/nw0lVVJsOfvlCn1yDIC9EGnNzOHT?=
 =?us-ascii?Q?4KrZYFEc2z93hZMBW1oJuMjSx+eP6vKPLxrwtOW8hMD/J5qCPR6JD/q+Y+BN?=
 =?us-ascii?Q?Uu/PlIdJG81PerMn14N0RX2UTwXR+nV+CUg10pnJfS1YzujnJ4BHydjZ0Yhh?=
 =?us-ascii?Q?rfkUoCtB4t5nQqHyR9+9SqjhQjZ1C0KsXd9/+5XyeWE0CcgsKBemd94qZdjU?=
 =?us-ascii?Q?MO+kVMq5vxUMJKPX63pz2OS+UWCluGaiI8Gk8x/60Ou1lkJuBdmByKaN80ec?=
 =?us-ascii?Q?APgGzjxEjeWOoH3SS2mPL0cX1xPFnUBFbHmCHXuW+jjVPEDvVO/gtE8vYpKf?=
 =?us-ascii?Q?QyBmkhFb5kzbpogwW6U/JbKXCZrvpStb0PfRwHpNsNpVoWWntZ2AJ8hdNLi1?=
 =?us-ascii?Q?VgSQwLrwbqjuynLy7gsPlR8wlF1TKZD44JKZIOn+L7g1BmPdbl58QAhEVVV/?=
 =?us-ascii?Q?VkwdUJ3ShJMQRpRGOExA8r9h6p91DGjfE/54g235kZ8MpGoE/sXVvFnHbv2y?=
 =?us-ascii?Q?E62ramFLzjEUjtH8TPvKRx15ExddSQGp2xzS1aK7MFzY+4/19H4xrHmjVoKR?=
 =?us-ascii?Q?WMw2CiwTtcl7mMHr7qnlUG8ICLOnl161qAwa7oSFlxykoIPBm+7IO3zso0Ov?=
 =?us-ascii?Q?idmbFHmTZ5oQyQAmiVTelG2k1FfmzOfjUe2+O+CNrcWTXKhV+34sA9e9XIK8?=
 =?us-ascii?Q?fV0S6uPgojoWg7Uv/AdlbO9bfmZKTiBCPcpaZzciYri1pfmsx9XXv+ltPQa0?=
 =?us-ascii?Q?AJC6bl1weFuDWWMJn0Hiq+WKKaaFySB4X65GeapORGtA+fgqBMn19y/+AiYh?=
 =?us-ascii?Q?jNqdDHCyYIUxuhYirWNGpIpCwsbVwolZ/W7JoDE7qb0zarsQSbFEGCdI8FHD?=
 =?us-ascii?Q?jEDB++R3YinQMGsYJFxuuzdl6Q8smVX7FLmJQDw/NmPiwnYA+xA/HaaoiCQz?=
 =?us-ascii?Q?atbeNlSnmy4q9EqSEXFXZ2JM+sWYB4W+LNBX7CosiWdTZIp9wA2ncANAd66h?=
 =?us-ascii?Q?PB8/sbIc0HGZTu3ZODf2SsJAxAE4+qsYraCl50T2SA2ZnaXZW5GOjzUV9ejw?=
 =?us-ascii?Q?Y6XTc9H/jqJVWHfPNJ3xn63MHJpdc6eHDSDo5mU2E7NA+JjKhBibHgl3OVy6?=
 =?us-ascii?Q?SVcsmO+szEDpB/Kk01CrSPwXndk0G/OWlKOQV+nUVUOlMoyjiYx3u9L4AlEJ?=
 =?us-ascii?Q?A8XAo8MqAZ5I3b4zj6velPy4sy/XWSbNxI2qRffhzyYGdieA8RF+cNQnoM03?=
 =?us-ascii?Q?tDXEFskjij4UQe/vzlBTzHKZFrLpRh4zI+/duWOF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6afdd09-3a0a-4efb-252e-08db92955fdb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:44:06.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Joi5JvJTpXJ41/N78RSdI15NTcVatbn9DHNDbs44lvV04MYlluD8GfIc9QZTn6gTZv1y1wlsKVIN3araZFGkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
X-OriginatorOrg: intel.com

Hi Jason,

Greeting!

We tested the intel internal kernel and found that:
There was general protection fault in iommu_device_unlink issue in kernel
and found the problem commit:
14891af3799e iommu: Move the iommu driver sysfs setup into iommu_init/deinit_device()

Above commit is same as following patch:
https://lore.kernel.org/linux-iommu/6-v3-328044aa278c+45e49-iommu_probe_jgg@nvidia.com/

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230801_150257_iommu_device_unlink
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/kconfig_origin
repro.prog: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.prog
repro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/repro.report
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230801_150257_iommu_device_unlink/a3fe9a2e1692a413d887a6a0f1184c26481d6a2b_dmesg.log

"
[   14.525705] general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   14.526161] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   14.526438] CPU: 1 PID: 715 Comm: repro Not tainted 6.5.0-rc4-a3fe9a2e1692+ #1
[   14.526706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   14.527121] RIP: 0010:sysfs_remove_link_from_group+0x37/0x90
[   14.527345] Code: 41 56 49 89 d6 41 55 49 89 f5 41 54 49 89 fc e8 4f 1a 6c ff 49 8d 7c 24 30 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 42 49 8b 7c 24 30 31 d2 4c 89 ee e8 54 e2 fe ff 49
[   14.527994] RSP: 0018:ffff88802457fba8 EFLAGS: 00010206
[   14.528201] RAX: dffffc0000000000 RBX: ffff888014f9b000 RCX: 0000000000000000
[   14.528456] RDX: 0000000000000006 RSI: ffffffff81f39941 RDI: 0000000000000030
[   14.528710] RBP: ffff88802457fbc0 R08: 0000000000000001 R09: ffffed100155b11b
[   14.528964] R10: ffff88800aad88df R11: 0000000000000001 R12: 0000000000000000
[   14.529222] R13: ffffffff85cc0180 R14: ffff8880109b6ac0 R15: ffffffff87070ae0
[   14.529480] FS:  00007f354bf75600(0000) GS:ffff88806cb00000(0000) knlGS:0000000000000000
[   14.529767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.529974] CR2: 000055bf0ca7f990 CR3: 00000000135d2000 CR4: 0000000000750ee0
[   14.530233] PKRU: 55555554
[   14.530338] Call Trace:
[   14.530433]  <TASK>
[   14.530517]  ? show_regs+0x6e/0x80
[   14.530658]  ? die_addr+0x45/0xb0
[   14.530797]  ? exc_general_protection+0x159/0x250
[   14.530988]  ? asm_exc_general_protection+0x2b/0x30
[   14.531178]  ? sysfs_remove_link_from_group+0x21/0x90
[   14.531365]  ? sysfs_remove_link_from_group+0x37/0x90
[   14.531558]  ? sysfs_remove_link_from_group+0x21/0x90
[   14.531746]  iommu_device_unlink+0x85/0xd0
[   14.531908]  iommu_deinit_device+0x11f/0x4c0
[   14.532075]  __iommu_group_remove_device+0x26b/0x300
[   14.532262]  iommu_group_remove_device+0x8a/0xb0
[   14.532447]  iommufd_test+0x1f1a/0x2d10
[   14.532593]  ? __pfx_lock_release+0x10/0x10
[   14.532752]  ? __pfx_iommufd_test+0x10/0x10
[   14.532908]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   14.533108]  iommufd_fops_ioctl+0x377/0x510
[   14.533265]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   14.533438]  ? trace_hardirqs_on+0x26/0x120
[   14.533602]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   14.533832]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   14.534013]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   14.534208]  ? security_file_ioctl+0x9d/0xd0
[   14.534373]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   14.534546]  __x64_sys_ioctl+0x1b9/0x230
[   14.534696]  do_syscall_64+0x3c/0x90
[   14.534836]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   14.535019] RIP: 0033:0x7f354bc3ee5d
[   14.535153] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   14.535792] RSP: 002b:00007ffe42dd02d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   14.536061] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f354bc3ee5d
[   14.536310] RDX: 0000000020000180 RSI: 0000000000003ba0 RDI: 0000000000000003
[   14.536559] RBP: 00007ffe42dd02f0 R08: 0000000000000800 R09: 0000000000000800
[   14.536809] R10: 0000000000000000 R11: 0000000000000213 R12: 00007ffe42dd0408
[   14.537065] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007f354bfb6000
[   14.537320]  </TASK>
[   14.537403] Modules linked in:
[   14.537544] ---[ end trace 0000000000000000 ]---
"

If it's useful, please add the Reported-by tag for updated patch.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!
