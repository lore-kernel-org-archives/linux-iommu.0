Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD711A5B9D
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774416088; cv=fail; b=SoadMflchLlJLXzbQcxgAoRqMkmnWaZuyrPR+ipsSGq0KbDPMKhqVpOMp5WUvbFZ/V/1CbSU5IdhRWnhh2AXtFcu1eKXg7++zYQXTdfznuXAZ6DU3SrvzpAgGDyMVRCyD+TxTPaMptnr4+o0yntDd2FoYNxF7HFCyuL20iNlQ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774416088; c=relaxed/simple;
	bh=eSpwz0I8kM05wY6GymM8PlXZPu0+bUm5vhT2+E4Oxgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udBQdLYvtnUTDWuddAUebRC1hviKlIWRrl6AqPKodwOuMOBxojwCL0ivqrCRdLMBs2QStyQvd3IGzDB9X7fyBSK3AEV6IbL5Raegticbab60swuGpIS1v6vvS7egpT4BOk2ivmxkE00lANRMSBGN95IZAkQ5NxAIP0OcjsPhICo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iAf/ke7F; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iAf/ke7F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb78x0NV89WE7ZIbVvrBEpM48fOwPOtVLnUeRTqdESg/vkGS4gz3NMG1oo31Nrd7JXp0E1c50Ujf5BiAaV/DYfotgfZtin0f04Pc6xIj5PDetlRl0vWPTCTaqjqWJaCCNLIkjsgO5KUU1VX1Th+KD92eqVBbYE69emmAbxLspgBLw+MHmT0vM8pwSX4xzbKUQWowWH5TbaemOwFt9qZSeDtc8p2p4RMhbFSPjYsK/MztlYZMsPcACBJzOBRFfv0FNQdB/GNI6Bc/6ItBRCJUAe5GdiJbbqEFn08hiiS1TyhXFRxDTq+bMonsQm6o2zBIW4/9ACDpmM1iYFj4IijRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CqDEBuqIka20pVcssAjqw/mNLBm+HHIy07+KT7tRsY=;
 b=FV5FMzP2prFsYll1eLI69tORWyujus7oWA5FbQx56v0MikmGDosM5t5INueiamK3rm7laELWHX0pnctxO7X6BbWiM+DV1A4GiKx0MWuekrDgCEXGN/fPbAUABvXalf8rXFnVuG4Igy0UkBGyxPjUbW8itqtZSYwVJgcPcT8MXma1SgBFc0hlXeWwI7+rkpymUZuxYy8tewpoCFcmSODJoTk28e113PcgNW0r8h6B27vAgquvrfHPfU0nXXy/pQNCXEwH4iiRrPLh0MB7pFpZkUpsSGNRM0weCCjZswTDKJLOU6HNJMEKKqVlvgrMNCZjqYcDO7sK1lAJV/uS98S9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CqDEBuqIka20pVcssAjqw/mNLBm+HHIy07+KT7tRsY=;
 b=iAf/ke7FmwG4smpdiO0N3TWKbjf6BsNqJSWtqRpBkmq8fKVUYjj45NPVzprw0LjHmvTjTWZafIlBq11U69IuZRVwZtOJqG49h7r6Em9HsNf9EAOm8002I6DBVurQW1mVwXR4tcRB3QmKUnb1xwA0nKDdPE7fjtIcHPmcldj9TIk=
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by LV8PR12MB9272.namprd12.prod.outlook.com (2603:10b6:408:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 05:21:22 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::6) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 05:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 05:21:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Mar
 2026 00:21:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Mar
 2026 00:21:20 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 00:21:18 -0500
Date: Wed, 25 Mar 2026 05:19:51 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Pranjal Shrivastava <praan@google.com>
CC: syzbot <syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com>,
	<iommu@lists.linux.dev>, <jgg@ziepe.ca>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <syzkaller-bugs@googlegroups.com>, <will@kernel.org>
Subject: Re: [syzbot] [iommu?] WARNING in pt_iommu_amdv1_init
Message-ID: <nvmacpqf4nisbhxct3vfiphyhqllfn5ojf5r5dm47aflseocwl@4bwo7kz6bjuf>
References: <69c1d50b.a70a0220.3cae05.0001.GAE@google.com>
 <acKhtdpfSctT5r5I@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acKhtdpfSctT5r5I@google.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|LV8PR12MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: 383bab5a-1fc5-48cd-ecec-08de8a2e5a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bvEtrY0MJZrrMP37lyyLmjvbx41ocI9omiY65hcRa2UUzYhyF1/7u1M2YGLgGtWbcnkOCHfunmnLGlONE2plcUzxcwvBgZbdlFZY2tMf0dCbKcXmU/9FEeGIhgp+4IjHPu5NWL/3MEhY8j5AOO9f5SKvEO5PK273rDZJCeZAq0N6O/nlgy3iFagfW2RpsXuf4w9T5k3wqB/f4G+9TWsmGVamaqovKMmv9qjaQTSTIWxalnIwwku6li+zJR/c3hhy7SUm5LA0h5Dj0SE5D99LN6ePup1Npbul3suXKsNOFhJnYLO030ulsttNF4OkTwNq53vin3z/qQxMJWAewotcnNeLDuF1XeUr2penTRTNd/DeRlGINYpo/Yn7uccZZDaKNw/xEkIHyPrAr/l8g//tUR+BqxjaidP+6KVYBB3w7lTH2HgWF83VImHfErRX3e8XqKIObGrmJAJ9DURytvxGbrzVa40lDTUl6yUfyN9ppW0SuI8XnLHFA/SGR7D7wlkrVKCk9z6XjwO3eWI1E9pYLRdgUUFHZ/hEdkoi30Nx9C/qW8N26PJt027ke55IaoS8K9uFwmmKUGsSy5wwf0DG8PR6nLL/NafM2MhuV4NLfVnwtEBA28yvjaa9Hu9eKx6M6q+07xkN3MuTu+3pRWo7Vhgkc3icL3GZTCxtZTLf+9hPS7RUnjCsbRHWb8ERTYRaZZXvzPi3SHe2hP5ogi8lBlNAXfsrlsPwuB7ZVl6qiQw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qT0UaQwJVsRuKgKb0TgL1X0NHed4eawLM3qIa06tgqiASNqV6a05xflYo1ewNSiDiKX7ltdf2Kdi9YYHm6/pSS9mAfZws3uwh2ixl0Pp8X85tNSZTXHLjMVAGX3ScgzkWf0sFImMo/0IvTsNSt86SL3xhXogevQcqf5xpMK2p916Ss2GoSg9eDhgXkOlODijdgLPj9+79LfHur1L/P2s0+0yHIE6zEc7U5y3wJini5AhNHJ9ZpsbGK+0bOBZUxH0QtbT1Te0dOn7k6o/GGEM+H7gTzXaQlmGtGdmTrbBuik1doT9xXQJh0wA3uU2CR4XMTvj1qs9YzmK7V4kT0NliQwCo2e48Zo40xrknDlb+za2GIM4IwXxQddU3aPQbBYgRUHKll/zmltL9KGZMoSVGpxszXbVNjLwR07UHqhnc3PPDZw2GISkW+KSWCsSU4cn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 05:21:21.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383bab5a-1fc5-48cd-ecec-08de8a2e5a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9272

On Tue, Mar 24, 2026 at 02:37:41PM +0000, Pranjal Shrivastava wrote:
> On Mon, Mar 23, 2026 at 05:04:27PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    0e4f8f1a3d08 Merge tag 'parisc-for-7.0-rc5' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=176df352580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=453eb7add07c3767adab
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0e4f8f1a.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/838ecdb7b55f/vmlinux-0e4f8f1a.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3742378914db/bzImage-0e4f8f1a.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
> > 
> > iommufd_mock iommufd_mock1: Adding to iommu group 10
> > ------------[ cut here ]------------
> > !iommu_table->driver_ops || !iommu_table->driver_ops->change_top || !iommu_table->driver_ops->get_top_lock
> > WARNING: drivers/iommu/generic_pt/fmt/../iommu_pt.h:1249 at pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249, CPU#1: syz.0.1303/9714
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 9714 Comm: syz.0.1303 Tainted: G             L      syzkaller #0 PREEMPT(full) 
> > Tainted: [L]=SOFTLOCKUP
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:pt_iommu_amdv1_init+0xa10/0xb20 drivers/iommu/generic_pt/iommu_pt.h:1249
> > Code: e8 95 a4 e7 fc e9 aa f6 ff ff e8 db 18 7b fc 89 ab 94 00 00 00 e9 15 ff ff ff e8 cb 18 7b fc e9 e4 fd ff ff e8 c1 18 7b fc 90 <0f> 0b 90 e9 19 ff ff ff bd a1 ff ff ff e9 cc fd ff ff 4c 89 cf 4c
> > RSP: 0018:ffffc90003747a68 EFLAGS: 00010287
> > RAX: 00000000000007ee RBX: ffff88802bb03500 RCX: ffffc9000407a000
> > RDX: 0000000000080000 RSI: ffffffff858db73f RDI: ffff888026f94980
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000034 R11: 0000000000000000 R12: 0000000000000034
> > R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000034
> > FS:  00007f29a60136c0(0000) GS:ffff8880d6442000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000110c3f39c7 CR3: 000000003d1d7000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  mock_domain_alloc_pgtable drivers/iommu/iommufd/selftest.c:491 [inline]
> >  mock_domain_alloc_paging_flags+0x29b/0x680 drivers/iommu/iommufd/selftest.c:548
> >  iommufd_hwpt_paging_alloc+0x393/0xb20 drivers/iommu/iommufd/hw_pagetable.c:149
> >  iommufd_hwpt_alloc+0xb46/0x1af0 drivers/iommu/iommufd/hw_pagetable.c:369
> >  iommufd_fops_ioctl+0x358/0x520 drivers/iommu/iommufd/main.c:533
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> >  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f29a519c799
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f29a6013028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f29a5415fa0 RCX: 00007f29a519c799
> > RDX: 0000200000000200 RSI: 0000000000003b89 RDI: 0000000000000009
> > RBP: 00007f29a5232c99 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f29a5416038 R14: 00007f29a5415fa0 R15: 00007ffedd2b95c8
> >  </TASK>
> > 
> > 
> 
> I believe this is because we don't populate struct pt_iommu_driver_ops
> for the "mock" iommu / selftest? Would defining mock ops help fix this?
> 
> I have a patch that seems to fix the WARN_ON:
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 9607416f8069..1599eb737d2a 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -119,6 +119,7 @@ struct mock_iommu_domain {
>  		struct pt_iommu_amdv1 amdv1;
>  	};
>  	unsigned long flags;
> +	spinlock_t lock;

May be top_lock for consistency with kunit?
Otherwise looks good to me.

-Ankit

>  };
>  PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
>  PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
> @@ -129,6 +130,29 @@ to_mock_domain(struct iommu_domain *domain)
>  	return container_of(domain, struct mock_iommu_domain, domain);
>  }
>  
> +static void mock_domain_change_top(struct pt_iommu *iommu_table,
> +				   phys_addr_t top_paddr,
> +				   unsigned int top_level)
> +{
> +	/*
> +	 * The selftest doesn't have real hardware, so there is no need to
> +	 * perform any root table moves.
> +	 */
> +}
> +
> +static spinlock_t *mock_domain_get_top_lock(struct pt_iommu *iommu_table)
> +{
> +	struct mock_iommu_domain *mock =
> +		container_of(iommu_table, struct mock_iommu_domain, iommu);
> +
> +	return &mock->lock;
> +}
> +
> +static const struct pt_iommu_driver_ops mock_driver_ops = {
> +	.change_top = &mock_domain_change_top,
> +	.get_top_lock = &mock_domain_get_top_lock,
> +};
> +
>  struct mock_iommu_domain_nested {
>  	struct iommu_domain domain;
>  	struct mock_viommu *mock_viommu;
> @@ -445,6 +469,8 @@ mock_domain_alloc_pgtable(struct device *dev,
>  	if (!mock)
>  		return ERR_PTR(-ENOMEM);
>  	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
> +	spin_lock_init(&mock->lock);
> +	mock->amdv1.iommu.driver_ops = &mock_driver_ops;
>  
>  	mock->amdv1.iommu.nid = NUMA_NO_NODE;
>  
> 
> LMK, if I shall send this as a separate patch?
> 
> Thanks,
> Praan
