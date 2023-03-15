Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EF7E
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678848324; x=1710384324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rUngYlI6+/yGLLqC2R+tm/Eobe+VMY3qP6TfzVkUuoA=;
  b=JWoyv1TBmkr+8L+4zT+B37EVHSA7RIMZ7QxEcJnytsiRXc0EC6qJBDrB
   Nxdrf/vsFF813N4xcDyzMj0jz9VcMig6baB8ANHL7Pp/07wvhcJA5BlBw
   LD6FKGTAA4mLjSdB/c0lT03ocn2skr7lfIoVzhzZahQgcN6NKioPSF/lw
   RPjpwz9UhQt8OiOCDWCsSo0NJyjA+3VBsiSF+zwlB/oxXT4ypj8bnahxx
   JZfiCkaqfsv37a4JRiuExR2p+hboQ670THTcNGLZOnbNiOz+DzDu1sFFr
   L6An+KriYeBlMp6lra+ZRli1iRVxLkwcgepsTiqLUi9JKuDj4u35P5fOG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="400179650"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="400179650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 19:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743525908"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="743525908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2023 19:45:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 19:45:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 19:45:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 14 Mar 2023 19:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2x9/NEFgNUgPbKpRxIXZe8TVBuXdVfJmUSljlzi+31r9BXM0km3TaxhB03MCPCVsdUz6RW9c0jNjtsYUHOU0JHnnSUOlIrBXyzVc9XL/2kAIdnsOHA/mKEVPRosMhw2/SMHik8T5kjdYjh8FI3gShG/dmt6eVA1itIYUC8mavJQ86IG2M6nWWaGzaEzePAA4rrkKe25OePAJd3a3L4UAkzaCoeQnhi570DUGQBoe9d1dHQysHuboCYaUg/CZkXbNama4W644ACDU4B1xOtH8POZrUqYY7gNFF3pFHw5Z1vsapqS0IhbS20D9X01E4IVbRbxTJpv3eWxAG9EJ96Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SU8Cpwi/IqLSpvYTkYFytPz3cftlR++j3DqQSwbJi4=;
 b=i6jJDpqGRZOYLOmNU4OpoxrXa1lo8RROIqEJJdMngLnrV60WRfkE3oLJSrn21KL6TEZL5mNj29wkpb+PyszNE5KrI0H3jJhh93PolBISgcT7IevLpBCA6R/ffV8mbKoHlD6u6NTG9fhlen/aC4lGOnphjmvZrIqDPoXjmkfLXjwWV5DHG2jHFCDiF863hQcZ6BMt1j1z6siA3+NfXAnPwetOV0Umr4z2CrF49ipjMIPrFovaii3Oj87O0juIJN283ZJaMRgZjAGASGsMb8bVMUw4T8IkKtizVUt1XMGqLz5mjrPqukpqCMZ0dGVHX8sG9s5OkVQFIu51iwwQ9yjl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB5581.namprd11.prod.outlook.com (2603:10b6:a03:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 02:45:19 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 02:45:19 +0000
Date: Wed, 15 Mar 2023 10:46:40 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <jgg@ziepe.ca>, <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<heng.su@intel.com>, <ying.huang@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is "try_grab_folio" WARNING in v6.3-rc2
 kernel
Message-ID: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: d7362871-8c2a-4029-59fb-08db24ff50dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9lY3T7OoCh3LuWGY8flP8lH96ylfwSyZJsVlRlbJEnPZWSSAi9J8xXSrXRgbLQ7Ck3SbYqph9DwuQX4uIdklIVW5kJ1Q3axBlDufSB7Uy8QclAYXinDIUk9R+yfPo0hr2Pyw09H5pmqRl98AxuIqTZ+Mlnt+MWu/VgAYxdCnHxhzP0FS6hm3uoZGhiNJodSKGIyNXMK/9eSY+Cl4GlR6XHy7ESDGQJlnJARKbJOchwmBRgkIZZ4Cd3rwrvzpNZao2pCrLcRnQ8nsQwB/RPKvA7394Lk670Dz0A3QrJyvUlob1XOY7vQcmyc+0SoxKA2hIYXeVIQDzxk+5C6Lqmt4fOweJTw9xc06v4W9q+jFi3EGvc0IzXvRNLqBdBBFqVYQGyC8av+JFKdtxgvbEPAuJQjnPzj3LOWLsVBjqsSRK0PH3A6Eq2DXBFYHq/pVAMuMKGdRBBexAi9FHHQBenwCHZBIDgrS5Ln0160wYBaEYbWlBippOJCnrtIArrMVkCmGvXJ7EFJzFR5aBJHt75z9wlj9CdmYDra81zr1a/6HJvqe4uiDpztWDymHLfq9Z2/TL5BJHqGU41BA7F8cxZyLx7A+xA/+JXwWtXgRfvHl7uANNXlsZWWrmZbOf4dVNbLEYMqZCX2EDbB1lO5REfH1SCBjXMeg3VvakHVNXttJ04qgEHpCrbJY+Kyz/0XUhBDW2Vq2ieP3eHE1aQJNy1ahy02SlTcYBjnQII1iNczAJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(966005)(6486002)(66476007)(66556008)(66946007)(82960400001)(478600001)(26005)(6506007)(6512007)(107886003)(6666004)(8936002)(41300700001)(45080400002)(5660300002)(8676002)(4326008)(83380400001)(316002)(2906002)(186003)(38100700002)(86362001)(44832011)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvj4v9U9VWMuciLBYYSfHqBNHhnvTmTU0JmuCt4xnFMTg6h9ryd9NMscz6p9?=
 =?us-ascii?Q?8FP6ABvz+Zvc39SJ0uwMq0VBXfuFPFEvYZFaKzLB5e6r0LW01zMV8YzDkNxF?=
 =?us-ascii?Q?ps1d7bMTPy0vW9nMtcJD2JnjeL2oqNwA7gQvhNdzeIlZ9kzVLA9a/QVYN9Ui?=
 =?us-ascii?Q?Nx8kMnpKDsCMXZ842phn6zsRZRfgMFH83VZszm20jdn/FV5zanXX7ZNN4oFL?=
 =?us-ascii?Q?GK4Uajl8DemgBatrgE0xRsQWQWxTap6yvskVOV1/GpxO5qu5K/iOUoJthBHq?=
 =?us-ascii?Q?AQagV1Neh1Km9jk4AU3PUvuiEXStyqcnRS9fbNV7ihoLPw3U0RLAMvSLBlt4?=
 =?us-ascii?Q?74uTcQ+GSWwMj9HwkSEXq0qWzsnuRF5wdIApL2H61LTqfAZggNc3YCHuYGM8?=
 =?us-ascii?Q?yNeUgZJxvl8nNHAizGVK0g5zrTq7+77DcVkyzbV7MhymrSCHkSg/l7p9t6Mo?=
 =?us-ascii?Q?xEdjP2e+vJM1rMu1GAxNoHtVJ1/vyiWkAlqSLfiII9aJSENTRqLibQwFEvzj?=
 =?us-ascii?Q?ZmnjcPABSrOhkJT50H5BCI6V47b8sRgvkeQSFJNElsVs8ecvfIokJtt68wF/?=
 =?us-ascii?Q?7Dzg0FxDArhNutzF9j7CAuWtnbymgsAjBTcAbWytl+euMgTMGj24XhLQxiJ3?=
 =?us-ascii?Q?c6+Ps+Ufh6zczcR5RXJcdFaWXbxFzHkaOo8g4MrffrJE3neYzWCWN6Krku9x?=
 =?us-ascii?Q?iFdnw6uFt2Ze6UOTecEwvvgaJs+MZ2U+2CdAXl85EFt8s1Y+JiVzVSj2Ox9B?=
 =?us-ascii?Q?MwE1XS5pdSnlMNnVQRViJ8ahRwG6mGQeFmd9P2u4QfvT+lIZtERyPGucGrQc?=
 =?us-ascii?Q?K14GwLyAcSoBNNqb0Z8T2+oNEetMMP+4qzCfmTfxaBrslEH+/xptj5gjdtbd?=
 =?us-ascii?Q?DuE3Yg/9FXp/zr9wEg8SEqFk93W83EwtJM+uB0iDDOzSCgv1TvhR94YPPspt?=
 =?us-ascii?Q?+weSd3HWGIQcbaP1AWZGzOWord3Eeiea3jehKv9qKHKKkOISItyaIIDR3q0h?=
 =?us-ascii?Q?LFZZUnMMFSMMbah+vSjoszhj9a7YgU1ZWGcVLfiNeQAwxxl6PfdAhK3S2mjk?=
 =?us-ascii?Q?IFWJPIOkhH9X0tjvBZvn5O5AmnoQZrrD5cwAn+tqulpRWNeUFrVTTt9GiIwn?=
 =?us-ascii?Q?ccSx6XpTI6GtRWsWUun9nI09/NO5zKcJ+kAaikEz6yBDt7FB4gYfwtFvv/mz?=
 =?us-ascii?Q?BDQlIA+IGQJJoPy42PWLJ2zchjcZEAxH6bUu5cKtGG7oDNC9ESA25u+UtQa/?=
 =?us-ascii?Q?ZdOz9BkL1qhpQ0UryWILJl/Yd2gstS6PhTjTfogM2OieQWsIPho8pdWOWPon?=
 =?us-ascii?Q?7mf/1Fa1r18Sv1MHGOnHqynITJy56xKCnXfd8+u/2RUeP9KjW2geiXg5qNFi?=
 =?us-ascii?Q?pi9d+9Su8vxaqzEJeKKQAFPHoy9rEvi3O8u8OdYgOgeJhbWVwnwxboWcn0ku?=
 =?us-ascii?Q?5pS+25a3a9rCfs8CDieLpf4/zuxWY0Gl2txQn4ZhqZLZjeDIenlwIf0FIiO4?=
 =?us-ascii?Q?OuCOmSbW1udt05N3yRbQ6MHs1NNCyQRkptbhyj+0xX6tyeP5zc5VopnCVYSv?=
 =?us-ascii?Q?7pavvzCsPX/lpEo5yxqe3uaiRzvTTawgUIHSWyHSjyafueOoUuKbznCpivPw?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7362871-8c2a-4029-59fb-08db24ff50dc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 02:45:19.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKbDoZ6MHJKVXfFiIrW9gwMadPIBRDZ93P5eaSOyGdFLFAo0u/XGGyH2OiTnXrFOvCFdvQhM9XE43p/SZ6lxbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5581
X-OriginatorOrg: intel.com

Hi Jason and kernel experts,

Greeting!

Platform: x86 platforms
There is "try_grab_folio" WARNING in v6.3-rc2 kernel:

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230313_234302_try_grab_folio
Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.c
v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/bisect_info.log
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/kconfig_origin
"
[   24.259581] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=327 'systemd'
[   30.909936] ------------[ cut here ]------------
[   30.910782] WARNING: CPU: 1 PID: 527 at mm/gup.c:75 try_grab_folio+0x503/0x740
[   30.911851] Modules linked in:
[   30.912325] CPU: 1 PID: 527 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
[   30.913355] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   30.914936] RIP: 0010:try_grab_folio+0x503/0x740
[   30.915615] Code: e3 01 48 89 de e8 6d c1 dd ff 48 85 db 0f 84 7c fe ff ff e8 4f bf dd ff 49 8d 47 ff 48 89 45 d0 e9 73 fe ff ff e8 3d bf dd ff <0f> 0b 31 db e9 d0 fc ff ff e8 2f bf dd ff 48 8b 5d c8 31 ff 48 89
[   30.918172] RSP: 0018:ffffc90000f37908 EFLAGS: 00010046
[   30.918916] RAX: 0000000000000000 RBX: 00000000fffffc02 RCX: ffffffff81504c26
[   30.919886] RDX: 0000000000000000 RSI: ffff88800d030000 RDI: 0000000000000002
[   30.920863] RBP: ffffc90000f37948 R08: 000000000003ca24 R09: 0000000000000008
[   30.921865] R10: 000000000003ca00 R11: 0000000000000023 R12: ffffea000035d540
[   30.922842] R13: 0000000000000001 R14: 0000000000000000 R15: ffffea000035d540
[   30.923792] FS:  00007fecbf659740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   30.924873] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.925657] CR2: 00000000200011c3 CR3: 000000000ef66006 CR4: 0000000000770ee0
[   30.926604] PKRU: 55555554
[   30.926989] Call Trace:
[   30.927342]  <TASK>
[   30.927684]  internal_get_user_pages_fast+0xd32/0x2200
[   30.928474]  pin_user_pages_fast+0x65/0x90
[   30.929076]  pfn_reader_user_pin+0x376/0x390
[   30.929733]  pfn_reader_next+0x14a/0x7b0
[   30.930301]  ? interval_tree_double_span_iter_update+0x11a/0x140
[   30.931143]  pfn_reader_first+0x140/0x1b0
[   30.931722]  iopt_area_fill_domain+0x74/0x210
[   30.932411]  iopt_table_add_domain+0x30e/0x6e0
[   30.933070]  iommufd_device_selftest_attach+0x7f/0x140
[   30.933811]  iommufd_test+0x10ff/0x16f0
[   30.934371]  ? write_comp_data+0x2f/0x90
[   30.934972]  iommufd_fops_ioctl+0x206/0x330
[   30.935583]  __x64_sys_ioctl+0x10e/0x160
[   30.936161]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   30.936828]  do_syscall_64+0x3b/0x90
[   30.937370]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   30.938097] RIP: 0033:0x7fecbf77e59d
[   30.938616] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
[   30.941034] RSP: 002b:00007ffda07340b8 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
[   30.942065] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fecbf77e59d
[   30.943019] RDX: 00000000200001c0 RSI: 0000000000003ba0 RDI: 0000000000000003
[   30.943980] RBP: 00007ffda07340d0 R08: 00007ffda07340d0 R09: 00007ffda07340d0
[   30.944936] R10: 00007ffda07340d0 R11: 0000000000000217 R12: 0000000000401180
[   30.945894] R13: 00007ffda07341f0 R14: 0000000000000000 R15: 0000000000000000
[   30.946868]  </TASK>
[   30.947194] irq event stamp: 1304
[   30.947659] hardirqs last  enabled at (1303): [<ffffffff815f635b>] mod_objcg_state+0x16b/0x2f0
[   30.948851] hardirqs last disabled at (1304): [<ffffffff8150caee>] internal_get_user_pages_fast+0x205e/0x2200
[   30.950223] softirqs last  enabled at (0): [<ffffffff81117af8>] copy_process+0x1298/0x2d10
[   30.951386] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   30.952232] ---[ end trace 0000000000000000 ]---
"

Bisected and found bad commit:
"
f4b20bb34c83dceade5470288f48f94ce3598ada
iommufd: Add kernel support for testing iommufd
"
It's just a  suspected commit, because reverted above commit on top of v6.3-rc2
and made kernel failed, could not double confirm the commit for this issue.

From reproduced code, it seems related to ioctl IOMMU_TEST_OP_MOCK_DOMAIN,
IOMMU_TEST_OP_CREATE_ACCESS and IOMMU_TEST_OP_ACCESS_PAGES related action.

I hope it's helpful.

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
