Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04F15AE
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678757963; x=1710293963;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F4oYcgvnz7aNgqrots0NRFO4mdIKTqJK14ZYT/9tUOE=;
  b=Ltot17AKEXIDi111PrBeDaiep5zzLzu9kjUhrLV52DBCKL4vCHS+F0l5
   eIM7qgU6vuOwUpYfLsc9Jm4RTZE33EJcBBK4/HhcEYG7Pq1hlhkF1Sllq
   nH7AFwtX5DQTmO0q9cN4/Qzmimg2EGD/ATig1dXLVNguTHjidGt6rqpEN
   tJVeRsNSlxs2gVQwx7mOB7GlKrdRJVra78I0rWcstjlmkVj7P4TYvTRFv
   NjlLog2pxEPH1Mholftla3tq9+1VF88C9vU01nzwEmyz9+8Sz9lsWwXj4
   c/Xyl/Hg0KRLPTY6YGVzDwsr9AMGy4tBNV06g5QWGpavqnD3663tEFmha
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321154881"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="321154881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="681243033"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="681243033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2023 18:39:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 18:39:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 18:39:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 18:39:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 18:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBcubwX9kCvLkjsQYeV0CQ3CJ2QXVboYlfsTqJZWzFd3D5//QCRVZhdEHjJgX6h8OKcielAjzIxnzI/qmMJ6a2RSq+dkeoezkW37CQn3ItDx5zIxeU//9E/mQbxunb1IlQO5uM4X6kFrwqwR/1pshExM6p/LbJ/jedWWeT0Ulr4SFkWwRcJyScnKP9FvS4i9w6oeqz2y1+mISbIKX7KDvike3+L9x3wPproTAIMiDe6SEIx0qqWyVluZDM0swiQPnD2ojEukQ9+2g559OYZET6c4CLFyA1wt93DSFLQnaw+oEWMep4MnO6KoHHu/zFOTIayVogpwZ3RTslARXDo+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/1J8PXa4TCKXxLu8SZMhyYG/GtFaKlyPZc8+PYG3gc=;
 b=hXZiDl+tKsriXKhtPQuiPFsft3nTCsEPm2KAmDNOfZx45HfF97i74pZTT8NvQY1pqeZHnh0pp82PgTmeUTNt+rNehVHTJFRpnYJUAFYhRiMyoOyg0FO7nEXjX875CRAoEPFOHIX96aN9RTwrBNIU05fWoe1FAvdUV2/qdxmLoMayZgcgm5JM8Muo+zIEPGvakwlzYPYp9foVu7I0UJI2XhaNIHoVZO7dlUKD2g4FJ5v1XZ8jOUzAMDhUvnvKaT3+1zHhN+9gATiwpbczze/supzSlMOlYipVH35D/Oev+e3MXJS1tTtEoWFCKR0EpKGufqFlXSfkZY0L2eZWbD6syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 01:39:09 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::7369:ca71:6d2e:b239%8]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 01:39:09 +0000
Date: Tue, 14 Mar 2023 09:40:33 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <jgg@ziepe.ca>, <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is pfn_reader_user_pin related
 WARNING in v6.3-rc2 kernel
Message-ID: <ZA/QkW801jpfcYGJ@xpf.sh.intel.com>
References: <ZA/O6vGUfni158oK@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZA/O6vGUfni158oK@xpf.sh.intel.com>
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4def83-6c48-4741-dc55-08db242ce7d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdxpKClRrgRyVY5SwMrmkluvs4RgOlVi33ICaE8oC79HemHOSaWtUcJENZ6jReME0AWDddf+svjMJXpiufGJZYe8Pmt+kdFkzXwZOqG/T1jc5oCZosnAItzeHicde1bz1FprWtXj8j0f5GgG9idtyOxwSUtwSR818qHEp4Ra40A1S+uagMOP6vXwi61AoKsQhngo1rRW3y/cJNZy9rYZfH3vZ2lNkC1/1lNNbcfNSZvYQAOXz7jmT0oJ6fsEMEUSrR0ClSbqCsk6XLK5jfPaoDIKAWUxYEnAUoWHrLw9Hq2hgMGIDMAWn5IQUXrXfqotkj5D291RssVNKvUgs9RSY3bNysg7+WwzBKT8u5IL47CG+56mdoNp7Iiu1p1cq6JdfVqy6MrHyG6Z520Z7F7X1G/lJK1/eK6Tpl/MKscP7HGXMd5D8uNIP7DU5PjypDWDH8iJHPxDwdIZfskx73VB5OaNqYZhwh3WMQemAf6OdVqljJQ3l3Y+myfuS4crdlGPa+X7ASsiAeX5MLLVUFn7HfMGiQIAJOWlWUbm0bTEGuYKSuTiPGZ4b8TaJopvm037EQWnnmU0SFfNCROQ0OC//UzLiWjulsMLDnEwlDiKDm6eJlMxLGD/1XjN+73wJ0dUvPfWjItuDRO1XqUvuDVfuccmp9mpJbDH2L1TOcaWmIWtCETZlqFdITElkGL5Vx23ZMI8GSerQw4RXZZax+7CNm77y89QXekGSb5W5tSbMWBJ8mnzLD1sAUaPj/zw9hj3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199018)(186003)(44832011)(26005)(6506007)(6512007)(53546011)(83380400001)(8936002)(6666004)(107886003)(45080400002)(6486002)(82960400001)(38100700002)(5660300002)(966005)(66556008)(66476007)(8676002)(4326008)(2906002)(66946007)(41300700001)(316002)(478600001)(86362001)(99710200001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+j9iRIyLu7rWOZIwtj4yhW6GaHKUP3D8hNHIeEGMQ+x/rRAMciCahaPRs2n?=
 =?us-ascii?Q?YPwhnme2Ti0S4pfmG7tgHjpFvT5NriLmgHYPD/598/LOkMqIHMsS4qFPzrUf?=
 =?us-ascii?Q?HLYGt1nNZIpKrYti/fBmpOjSEEvZwgmRMbJ5LGvoxmGoxqR0GkaZdnGaiAmv?=
 =?us-ascii?Q?+0zjn+4NK+z7DyxKCyI81ghcy+xGZWkhfcaQVY42Qh2gqagcKEl+0DKJ/oqi?=
 =?us-ascii?Q?j+yZVGr7xsoM2MZGbWHAmZHhABgwQBsxnkTh4E2HdDZld+D8Tq/AJTrd6+4d?=
 =?us-ascii?Q?9JLJK4D+sGtcm8NeYfKolrt/tAc0wNeJ7byVhUgoOya2huDJScvBcyClEwQo?=
 =?us-ascii?Q?4Bl0/EKQ16bgv+zgg0fUeHFnhved4QiCabAtlWzf7sWs49/RmJdiJjzMA+LO?=
 =?us-ascii?Q?rdyb1MyaYGI0hOKaEMq+anDYPHANjPNNUvTym8DZq0u6+hxaX5qwoZ5yeAtg?=
 =?us-ascii?Q?7/9up2gEbGbqmZ+XNLdw8RRlH69SIizv8AAmVRgn6PVX+3FC52kLHM+LxNad?=
 =?us-ascii?Q?bF2Zec4VqogrkqWIMPNBdKBi5yTE6WNS+/H4Co2bsSx4/uSRlvrscCTn4qYw?=
 =?us-ascii?Q?b4irsuTf+PiRfjH/GCq16RBlrpWzzs7iSBXQz8KhzHMOoRtCeyeCc+9X80KW?=
 =?us-ascii?Q?z2FTDuFlZxSANTDFoXAbLgxalqjbJsBDGCH79hdoW2vDa6+wXb6mSv7vNIrN?=
 =?us-ascii?Q?7ZZtDRhyTqVlTjTQHSMmiCXZ8uoLHRX+4HXPfSIJcUjX8pQCtQ3hCZEcdWwy?=
 =?us-ascii?Q?f2WH488vWcnecEvOVe4E8urRoB3xq8F6De3ImsRZ83SlcYwTPX6Uau4SQyyZ?=
 =?us-ascii?Q?A6dCRwsH9fnd9lOJ3Ckw3mZurXncYQms+lSdDVbdoEEgk0T3JbJgII4PTE8H?=
 =?us-ascii?Q?iZqm4iX5BdSeE6B5BICp33IW2kI2PS7X7SsTyo3LuCW4O6b05oCRFMG8raxP?=
 =?us-ascii?Q?b1sTKwfD6j/H0ov2H3kFnSCL9ju2wcBJncVjSqOvBNj8ucLA3gkptKadktJE?=
 =?us-ascii?Q?kTYhNR4nrXHuTU5NL3OVWT406Ny/QD3gOyXh/IaDqEyyuTUagXTXl5NR5zVn?=
 =?us-ascii?Q?SYMwfHZAtlAkI8GaI7qhAuzFnz/MIr+zEXzDKNUBR+cXvH6jra/1nDoRJKT0?=
 =?us-ascii?Q?7UQmRq1RZq7AabZoVlWj2oTg0s4G442BQXOGJMIWM2TEIReaJ7tehhxFZP0P?=
 =?us-ascii?Q?9E6N6jpH8uQjsmgDvCYcfk7qVz67ixGUNV4Nu/VOKX/DsCs8rNz2+5U0PifS?=
 =?us-ascii?Q?sMbqb1+isVkY+r087aK3ukSWKdZW5G/YepV4bhjWQ6nZratKjBfk/9Z/kAGN?=
 =?us-ascii?Q?1g0VCj/YpfKDZP2oX5SDm/ewG9QYgt939fnQ7iRduSe+PYPLZtumr2PkthZO?=
 =?us-ascii?Q?ZyooASybK/YUHSLzdHAfCNfWF/9m+snLZY3ugNMxZw2VUxJX2aP+qu7oKXrE?=
 =?us-ascii?Q?zZj2XxmpUXX4xHs5W6CfiqRjQjYYobnwM2Jiacw9R+bC1/B2t9gg9GgfFSXf?=
 =?us-ascii?Q?oljVdhLQvpFboOsSRGRGlXzGFvmE3+iffAlGQUKYgfzYXHz5cICIwhot9OvT?=
 =?us-ascii?Q?Np1muzbtq5xNc6brOqq+hKJXUOKmRKs4F5IExwgw3D8BIU8q4Fa8THrDJVZh?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4def83-6c48-4741-dc55-08db242ce7d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 01:39:09.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKe8CplnN/oAuRzh8vZr3F7AxC2f0vNTJ7LMDhamry8i9c4AN1wccN/dKyvOa5GYy/db8JsyzP1iWXlY035Uig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-OriginatorOrg: intel.com

Sorry to resend the correct iommu mailing list.

On 2023-03-14 at 09:33:30 +0800, Pengfei Xu wrote:
> Hi Jason and iommu experts,
> 
> Greeting!
> 
> Platform: x86 platforms
> There is pfn_reader_user_pin related WARNING in v6.3-rc2 kernel:
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230314_024214_pfn_reader_user_pin
> Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_024214_pfn_reader_user_pin/repro.c
> Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_024214_pfn_reader_user_pin/kconfig_origin
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_024214_pfn_reader_user_pin/eeac8ede17557680855031c6f305ece2378af326_dmesg.log#L676
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230314_024214_pfn_reader_user_pin/bisect_info.log
> 
> "
> [   24.721671] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=331 'systemd'
> [   28.878030] ------------[ cut here ]------------
> [   28.878512] WARNING: CPU: 0 PID: 518 at drivers/iommu/iommufd/pages.c:793 pfn_reader_user_pin+0x2e6/0x390
> [   28.879291] Modules linked in:
> [   28.879557] CPU: 0 PID: 518 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
> [   28.880120] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   28.880984] RIP: 0010:pfn_reader_user_pin+0x2e6/0x390
> [   28.881431] Code: b1 11 e9 25 fe ff ff e8 28 e4 0f ff 31 ff 48 89 de e8 2e e6 0f ff 48 85 db 74 0a e8 14 e4 0f ff e9 4d ff ff ff e8 0a e4 0f ff <0f> 0b bb f2 ff ff ff e9 3c ff ff ff e8 f9 e3 0f ff ba 01 00 00 00
> [   28.882819] RSP: 0018:ffffc90000f9fa30 EFLAGS: 00010246
> [   28.883230] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff821e2b72
> [   28.883786] RDX: 0000000000000000 RSI: ffff888014184680 RDI: 0000000000000002
> [   28.884335] RBP: ffffc90000f9fa78 R08: 00000000000000ff R09: 0000000079de6f4e
> [   28.884886] R10: ffffc90000f9f790 R11: ffff888014185418 R12: ffffc90000f9fc60
> [   28.885460] R13: 0000000000000002 R14: ffff888007879800 R15: 0000000000000000
> [   28.886018] FS:  00007f4227555740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   28.886636] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.887084] CR2: 0000000020000043 CR3: 000000000e748005 CR4: 0000000000770ef0
> [   28.887670] PKRU: 55555554
> [   28.887902] Call Trace:
> [   28.888105]  <TASK>
> [   28.888291]  pfn_reader_next+0x14a/0x7b0
> [   28.888619]  ? interval_tree_double_span_iter_update+0x11a/0x140
> [   28.889140]  pfn_reader_first+0x140/0x1b0
> [   28.889484]  iopt_pages_rw_slow+0x71/0x280
> [   28.889830]  ? __this_cpu_preempt_check+0x20/0x30
> [   28.890287]  iopt_pages_rw_access+0x2b2/0x5b0
> [   28.890679]  iommufd_access_rw+0x19f/0x2f0
> [   28.891025]  iommufd_test+0xd11/0x16f0
> [   28.891342]  ? write_comp_data+0x2f/0x90
> [   28.891697]  iommufd_fops_ioctl+0x206/0x330
> [   28.892053]  __x64_sys_ioctl+0x10e/0x160
> [   28.892391]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
> [   28.892784]  do_syscall_64+0x3b/0x90
> [   28.893124]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   28.893553] RIP: 0033:0x7f422767a59d
> [   28.893850] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 08 0d 00 f7 d8 64 89 01 48
> [   28.895247] RSP: 002b:00007ffeeb8f6638 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> [   28.895852] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f422767a59d
> [   28.896403] RDX: 00000000200001c0 RSI: 0000000000003ba0 RDI: 0000000000000006
> [   28.896952] RBP: 00007ffeeb8f6650 R08: 00007ffeeb8f6730 R09: 00007ffeeb8f6730
> [   28.897530] R10: 00007ffeeb8f6730 R11: 0000000000000206 R12: 0000000000401060
> [   28.898098] R13: 00007ffeeb8f6730 R14: 0000000000000000 R15: 0000000000000000
> [   28.898659]  </TASK>
> [   28.898845] irq event stamp: 4555
> [   28.899111] hardirqs last  enabled at (4563): [<ffffffff811eac21>] __up_console_sem+0x91/0xb0
> [   28.899769] hardirqs last disabled at (4570): [<ffffffff811eac06>] __up_console_sem+0x76/0xb0
> [   28.900156] softirqs last  enabled at (3896): [<ffffffff83024a4c>] __do_softirq+0x31c/0x49c
> [   28.900541] softirqs last disabled at (3783): [<ffffffff8112b5a4>] irq_exit_rcu+0xc4/0x100
> [   28.900924] ---[ end trace 0000000000000000 ]---
> "
> 
> Bisected and found the first bad commit:
> "
> f4b20bb34c83dceade5470288f48f94ce3598ada
> iommufd: Add kernel support for testing iommufd
> "
> 
> There is no this issue's report yet in syzbot link:
> https://syzkaller.appspot.com/upstream
> 
> I hope it's helpful.
> 
> Thanks!
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
> make
> make install
> 
> Thanks!
> BR.
