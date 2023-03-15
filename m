Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D837E
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 03:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678849352; x=1710385352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cZoPP2k57HGo1UjKLmiHKIDZ7MjEsYz2wiWDmWmTHgk=;
  b=bMezhC7wWDAn2CIjlnx6VQ3zI21SEBRP9MXgzBrU+IocyHomrqNZowhh
   ic/REDJqkm+2Cmqy+JnqkgB3E7quzK+7+wKnWsPLiofHIUIkQL6OlsSzP
   ojvWaDXGFztkxJkPXHHDgqNptM6g3osicA1QoEeOZL/ce2onpDpcWLpaJ
   3gw7BAIJiWmUfhLq++ayik79SqH6LBBuQMrlikVowdWpUfqw8rmUeUki9
   hiOlCdOvUnGiprNXB/NsbS5UuYXbfcUGBWRO93erVasNFoMtGE8ka2STS
   D0Y/qU2OnHXbdeZ9XsMXePorImI3bRxUZJ/Z2jT07PEuASxSiVaP3Y0hE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400182093"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="400182093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 20:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768344485"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="768344485"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Mar 2023 20:02:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 20:02:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 20:02:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 20:02:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 14 Mar 2023 20:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkwDHtw/3vdwOPC3O20pIUYuqOnsouPSlYQOdo91HEPGHQN40k/LaLwCNX+rn2PLIq3vCHvMf36KsvndZ6OF3AKjTHCl52oAxVGtFjG+QeZ+s6T2s2p6K2aR2OvXJbw6LafCJFC41D1Mhx5b9OWggfhc4eyVFrTOHuuBMOgiaWTsG2wuXY5SxJ1dkfvdXYzH4jL0TCmgqfn5UdNeuxHAjGM8NKg331w0dhbW6gFWeEj97CepU9oeSh8UiI41rx3bPgrApJTm5HsJfMrkXYIy1wIvvt+powdLpMxhewacVQSDRA/oFSBn+qoz0t2TkuvQFMm2LhB7fJJs1c08m1Ep2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWr7mKwWpkFLh/bHNDkTAmg/Dqn/Pba331TzZ8t+rRs=;
 b=nDe5yojZFH4CfF44IElpMQJE3Oxf5Z0nECtrMnGKpDNNx4sYSSK8RUFUCRW8c7lItQgml4lM2xLpppJq6WyOrZybTm5071MS2cTQ+AoDojwW+w3tYqg2pNQ1JDMc40oEb2QvRKhZgKXxSqvaAegzzbngXvodH0/olfr6ml0LA+BzBovnF0dP39G51yYk5FFufdwac7r6qolabEE0ryoxz6Oi5P1WZKStJugO6mTRccunWR7cEJYMEl009sw0xiUvdsgYz4dzNBmqIjCZEvUwQEjrT1stPm8dJL7uBCrUMwaFQ9FrhSQ47W+sTfSsXnkr1ei0b0cQL/dvJqD/4rDuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 03:02:27 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 03:02:27 +0000
Date: Wed, 15 Mar 2023 11:03:47 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <jgg@ziepe.ca>, <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<heng.su@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is "__iopt_area_unfill_domain" WARNING in
 v6.3-rc2 kernel
Message-ID: <ZBE1k040xAhIuTmq@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: c265b0e4-35de-49e9-d7d3-08db2501b563
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8n4Jj3ROKVCffdqH4ratuld1tLUzdv0LtAnZaS3hEuJakB4Av8LqVCFQko6vyNSbtk3duZqx918Fp/e4BXZGVSGbE3M7BjTHrA/Blklzggh6l5EOn4cuV7uM3HzLPSIvcdPihvSt/Dw9/s5/rrAgRiPqxEZq7i9XJGgsTs060EI85yu28ddQfJ8vcf6XRHHSBSG1t1n0CFUFPxqmEzx/UxlSu9YX8mTp5dOOrOn/H27+6Qbfgq+hBNUpR4pRWZYlzsTaZgNhusrobox1h5OLI5ftnkH+OuO1waQ13eRe5RVz2XSY2wwCKkovniCCLDDRdHMvFEBfd3KwrbM5RND3kd8VzNjNP/kWfnTCy2XkvNWj13f1isFp1wyxRFGxwOUY9TjdB6xQ0ZJFJaNHX6toAFPKBcWk5J3JO0Dri1yr7BWVfZoKrKs83IGAvXqWb5dR/6UxcUqXTc7jpQzdThHfI09HmKceYpA0lPFzZMp3qjfbhXN179eMVXeg/Ez6myvyJF6MmqCbyWnToZL54qFgmGtr6nNsCUQEIZz0gO5Z22ZhFvtpJ9JTX4/qTYsumx5omKCT045K+nFPjJSB2Y4bVePcEGrfLizRwiQB0zQD7Xo7hQxCgAS7a1hg8DosvbCNtJqklyrtaP8Mg62VNbLpmQ4jUYaNUJnnC1M6RIuY7VNG55Bum8q2zCwjK1tUfM4CGqrlbcIoeLMXK5zJV8BXvPpJIlDVVrgxW9+F/0ICgd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(2906002)(82960400001)(83380400001)(5660300002)(44832011)(66476007)(8936002)(8676002)(66556008)(4326008)(41300700001)(38100700002)(45080400002)(316002)(86362001)(478600001)(186003)(6506007)(66946007)(6512007)(6486002)(107886003)(6666004)(26005)(966005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyxdsIbyJaQcsDVOy3+0/ocjHdz3nNiy7FrsyHk/t2/aY1Eq42pbXTD4PDF5?=
 =?us-ascii?Q?5kaDxeDrqwMC5b/QypBodIk7xFxeOuZL50e351wb7fcvG/pjDTEODdDL1VtV?=
 =?us-ascii?Q?Kq5FnHi+xBjmeENWRw0Yfmv97/4VuMEItaSz4A4AfLE5TAlWtDPbEpk9uNPV?=
 =?us-ascii?Q?OacuBV4f7bysi3voHzmgV+/yWfmTnFHxqO94IdSABsMNcbnvKn3y27dCdjeU?=
 =?us-ascii?Q?vDr+u6D/UrkZveoRktE1brNIWZoZ3odCjB7jHSmmcQNS27PbEhz0Z240B3IC?=
 =?us-ascii?Q?mmrPjFwu5ExKfFZ0GqvfBVfoWBJtYDFbhXhFMTPyDnA9FmiwQ9qFlRNF509F?=
 =?us-ascii?Q?RT+3nDOW8hW52Qg2mQH3gvvnH+X0OQxyP3U0xLAsnOfRl4Iw8Rs1sLhI4LEU?=
 =?us-ascii?Q?kMJv/MxThB2nro9DFcNaMmjCWU9Dbrv/PgAA/ICb722ZoYtJF9FZMnLyBtuu?=
 =?us-ascii?Q?iCffhJfnu4aSmdE9hpS5rkkram5BoDAiXqvPu71mVKxSI/zZEZAcWTEF1TB8?=
 =?us-ascii?Q?OMLa8bt2uXwm/Gck3CbrRYBH4ndqs/E6WD+Gy/NoaJjm72RFpRsdiBXQfYiz?=
 =?us-ascii?Q?CvdyPbCKA3e38AheYn30fMpwx0LRfOuGPGNN8et/2et2X+DTXpQXOc4Bn+Yq?=
 =?us-ascii?Q?EzJkGo9DqSDfcor4fxs3XwiZG42QCaZ26JqEdLqU4l/Dhc+WWBMRJ0vscVVB?=
 =?us-ascii?Q?EExUMC4jKe0n50p9yk+BQItjHG0nseGQzsr1i86L+OHeIKE9H8VCRSQ3rPaO?=
 =?us-ascii?Q?pAsKVbU1/OzhDbD6rQIWoiNrtvV8uwS29SeqUbZrNH6fTdX/SE5Fku8tAhOl?=
 =?us-ascii?Q?duE9n7XOJdvDTeEZy8jgA0JrofGIqtWAyN2egKrZGexTwCyLWFy+X/3xgPjE?=
 =?us-ascii?Q?iwi1TTfdiVWl3fRq1+IuDoL5F2KBSM2OBe2ANM6SI0LQWaJmmh2XpW3pqPrc?=
 =?us-ascii?Q?lskhz23D8Osp+53A987kd6sLpg8Ri+bmcR5O19UXH6LxxKdAmVS38GUf+a8q?=
 =?us-ascii?Q?PIpgk2JNi3zfCocAuGWbfbVZUg1CaaMl4Wo8LVS5A6r8Zy8YPnAjYiySmC9I?=
 =?us-ascii?Q?UhnXVxz+bZMszvYsLhXIN4SB2Po2KNbaB1Muj7smopORqwNCxbusw9GyLec5?=
 =?us-ascii?Q?+j61PfrT22PW7H3JLWDEHL6Xyk/H1CGKYUN+XHEUWF82AJocmOzfq/EE0Odl?=
 =?us-ascii?Q?GWJUmmG/WsJt84tosctvijzo1Y5uDXktU/BXMnvk3/Kv+TDAvGzL+woH3usK?=
 =?us-ascii?Q?4tZG/7tD8XambTMmCGHMnNVbhY3+5m5vtoh0vusiYqkqqKthRMAH/P4qllQc?=
 =?us-ascii?Q?K5CWOjVHgVv+eH4hxNMpNpdTEFudmQJwcHdCs0PHOlNUkV3I2srYujwB1/Y+?=
 =?us-ascii?Q?t6xf/8V3E+iPECmqR9YVfXmNZLZpqw8mG+br1cwXnfhyr5raSsqPXgk0CfTP?=
 =?us-ascii?Q?5NWh8pqcHnnGIOwup/LqRoY6vg6ltxkmdzJb4i9m25rSMYz3A69QCKTx/MG7?=
 =?us-ascii?Q?Jah2NfJ80swSg0aVCHqhbAmbYp+7r9oTRxCnqZ5P2v3e41uOj58F127FBKO0?=
 =?us-ascii?Q?kRviPyboSPbU/1xEGZ5mq8DaTtcdOyGBtZkJWCi0wWZMRrqAHafspmWjd5Ub?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c265b0e4-35de-49e9-d7d3-08db2501b563
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 03:02:27.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR4HElTho2+gr2r3JwMSXa2YUB+xz9VCHG1dKCV9OysWjpRCFsHQN8fo9FD1aF8Q4UT1N60wNJD1OOwuH/mdeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

Hi Jason and kernel experts,

Greeting!

Platform: x86 platforms
There is "__iopt_area_unfill_domain" WARNING in v6.3-rc2 kernel:

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230314_094459___iopt_area_unfill_domain
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_094459___iopt_area_unfill_domain/repro.c
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_094459___iopt_area_unfill_domain/kconfig_origin
v6.3 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_094459___iopt_area_unfill_domain/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_094459___iopt_area_unfill_domain/bisect_info.log
"
[   24.464930] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=329 'systemd'
[   32.196744] ------------[ cut here ]------------
[   32.197234] WARNING: CPU: 0 PID: 557 at drivers/iommu/iommufd/pages.c:294 __iopt_area_unfill_domain+0x152/0x560
[   32.197954] Modules linked in:
[   32.198195] CPU: 0 PID: 557 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755 #1
[   32.198777] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   32.199605] RIP: 0010:__iopt_area_unfill_domain+0x152/0x560
[   32.200029] Code: d2 0f ff 44 8b 64 24 54 48 8b 44 24 48 31 ff 44 89 e6 48 89 44 24 38 e8 fc d3 0f ff 45 85 e4 0f 85 eb 01 00 00 e8 0e d2 0f ff <0f> 0b e8 07 d2 0f ff 48 8b 44 24 38 89 5c 24 58 89 18 8b 44 24 54
[   32.201354] RSP: 0018:ffffc9000108baf0 EFLAGS: 00010246
[   32.201759] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff821e3f85
[   32.202270] RDX: 0000000000000000 RSI: ffff88800faf0000 RDI: 0000000000000002
[   32.202819] RBP: ffffc9000108bd18 R08: 000000000003ca25 R09: 0000000000000014
[   32.203341] R10: 000000000003ca00 R11: 0000000000000024 R12: 0000000000000004
[   32.203875] R13: 0000000000000801 R14: 00000000000007ff R15: 0000000000000800
[   32.204383] FS:  00007f3499ce1740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   32.204978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.205393] CR2: 0000000020000243 CR3: 00000000179c2001 CR4: 0000000000770ef0
[   32.205927] PKRU: 55555554
[   32.206132] Call Trace:
[   32.206320]  <TASK>
[   32.206491]  ? __this_cpu_preempt_check+0x20/0x30
[   32.206915]  ? __this_cpu_preempt_check+0x20/0x30
[   32.207299]  ? lock_is_held_type+0xe6/0x140
[   32.207630]  ? rcu_read_lock_sched_held+0x57/0x80
[   32.208000]  ? __mutex_lock+0x13a/0xf80
[   32.208327]  ? write_comp_data+0x2f/0x90
[   32.208643]  ? write_comp_data+0x2f/0x90
[   32.208948]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   32.209333]  iopt_area_unfill_domain+0x32/0x40
[   32.209688]  iopt_table_remove_domain+0x23f/0x4c0
[   32.210053]  iommufd_device_selftest_detach+0x3a/0x90
[   32.210451]  iommufd_selftest_destroy+0x55/0x70
[   32.210832]  iommufd_object_destroy_user+0xce/0x130
[   32.211214]  iommufd_destroy+0xa2/0xc0
[   32.211528]  iommufd_fops_ioctl+0x206/0x330
[   32.211851]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   32.212212]  ? write_comp_data+0x2f/0x90
[   32.212541]  __x64_sys_ioctl+0x10e/0x160
[   32.212848]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   32.213207]  do_syscall_64+0x3b/0x90
[   32.213511]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   32.213896] RIP: 0033:0x7f3499e0659d
[   32.214174] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   32.215510] RSP: 002b:00007ffd7bbdb808 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   32.216071] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3499e0659d
[   32.216581] RDX: 0000000020000140 RSI: 0000000000003b80 RDI: 0000000000000003
[   32.217108] RBP: 00007ffd7bbdb820 R08: 00007ffd7bbdb820 R09: 00007ffd7bbdb820
[   32.217624] R10: 00007ffd7bbdb820 R11: 0000000000000213 R12: 0000000000401180
[   32.218154] R13: 00007ffd7bbdb940 R14: 0000000000000000 R15: 0000000000000000
[   32.218704]  </TASK>
[   32.218899] irq event stamp: 18545
[   32.219156] hardirqs last  enabled at (18553): [<ffffffff811eac21>] __up_console_sem+0x91/0xb0
[   32.219774] hardirqs last disabled at (18560): [<ffffffff811eac06>] __up_console_sem+0x76/0xb0
[   32.220410] softirqs last  enabled at (18388): [<ffffffff83024a4c>] __do_softirq+0x31c/0x49c
[   32.221014] softirqs last disabled at (18383): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
[   32.221641] ---[ end trace 0000000000000000 ]---
"

Bisected and found bad commit:
"
f4b20bb34c83dceade5470288f48f94ce3598ada
iommufd: Add kernel support for testing iommufd
"
It's just a suspected commit, because reverted above commit on top of v6.3-rc2
and made kernel failed, could not double confirm the commit for this issue.

From reproduced code, it seems related to ioctl IOMMU_TEST_OP_MOCK_DOMAIN,
IOMMU_TEST_OP_CREATE_ACCESS and IOMMU_TEST_OP_ACCESS_PAGES related action.
So it seems similar as issue:
https://lore.kernel.org/linux-iommu/ZBExkEW%2FOn0ue68q@xpf.sh.intel.com/T/#u

Anyway reported the above info and I hope it's helpful.

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
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
