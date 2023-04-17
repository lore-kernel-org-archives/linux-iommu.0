Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937BF1101
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720388; x=1713256388;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fSDW31n3QrSDdbn7YhIYBN9KlWvOZfR5oISxILD0dCc=;
  b=UOVMkValCjUhdj9AGFP5zkUqdjNI9vUdd/V1saZrugQkKkRBAjjY2Nqg
   VL6ureN/F6+3H2NEFrcZA8Gndb7kEWCYatAh0iEfpEKDqZdn79b5H5utd
   nOd5hORrcmLX7NGHGe8jEsClIM3DTakVUSMWMWT5XCxTZuUzojZBJk0fo
   fasYdAebH3cR64/kP8o0ZAaDuMiRAkR3lcFBnTvFfULeOp41k/6z4C5B0
   ADf812VEp4Q+lcsn/HvTye6sVHkcOJ/JQa1HBDP4tQ0Hc8BFEbdiL40VJ
   wIcSawYU0v5GQ0jlWLwl8UYVYaFNXs1F0O75i/0L3mHxvNe1/n9nLPGka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="407729163"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="407729163"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640885679"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="640885679"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 17 Apr 2023 01:33:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 01:33:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 01:33:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 01:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiCl3PS2LiLnvbikmeSP3FRKszqNPfRQ7OHDxNs46GW+jriMO7fUH+l5z30nqz+yeuUG7dBxfH76IjV+pKh0nteo7sPANloG0h7ofvZtnR+0ssMKsUQdWP4vXarFfzd2tjBZh0BAYh8coWilyVhIjzKTMGl54RpM4df3KsauoIwI4k9/a6W1MZBuwTZlUo3eXWkH0xOPzV7Ulf4fZQmfKgLRjAuqNvlIljmnc1UDBg88oGy0NXFGy29GBB530YjTmdK1N7+qr/+PUF+11N7Lh5doNiTxEaTcbV69jodtwTPK1d4Ka8Js/9qBZrF8BGzYLDU0d2ikimbXxZ6rdV1TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHwjVV5xhj72ZBYosD3VmwhZwoMmkOZ9eFknxrrEMwQ=;
 b=B5SMNZPwgTZmjT7XejgvXuSpUWCC7Q8dzu8RuOS46jJ9voWoSx0aK2F+rB7oS32Y10Pj4ICJ6MYx6RWOylrdXcosM+hP47ps7Gr01tYo6UFRrVHJlbaWGfQRFYGxFpTkqwcPp9ezJEC7MxH1gDCiA5EYQOxSvzNCXGPqU2QawV54NYqZFQOtNL9kWVubAF4FhNsX3+sqMsycluOl6J0ixz1J03JPEicVaSm0VdcBT0l7oiTYyUDkfPFrWT4Tn+FrqCPUuKsoHMji9LiAoN5e2RiAhM4CE/DAb1BHiFWIIKeHh3jlQpBtTBvnAaO+7oF2ddu3eIp7cMIztYH6ISJWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 08:32:59 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 08:32:59 +0000
Date: Mon, 17 Apr 2023 16:34:41 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Message-ID: <ZD0EoRVqdfYkOtt6@xpf.sh.intel.com>
References: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
 <ZAuJB92z/6XIriZ1@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAuJB92z/6XIriZ1@nvidia.com>
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 47acffd7-49cb-4ece-8e35-08db3f1e5977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WroDxC2cNVOD6uoSbYyjPlPHAyexD1VgYbKn7SaG6dfNzmetYEXGXJ7F5FhvNP72RdrhzU+HpzxqGcuZducSB7H1xw1zxTGmhu6jcmPqsjyswL01bChIYlhmBnkbjK4iSd4mZMxkif2uuQSlKFuvBg/oeWjvsSySHSFVavVOQCBxSGbhUNki/TFFJF6WuPelmzOW1gxmXyqoOEg1/PrZF4CX4QhqVEgl/Syavm6ndWvPCWoRJgRYA7Yf7ipNa4umBkL5R1/STiYI25AuzBqxhaGiKKveJtivXupHufhhDyubC+B2M1xHR8O+e4IxLbyOJOCIdxSlALhLmnjHtCI8/aWjcLRG77Rjz2MBsLJDCsKo+1UjY5GrZtrPE0mnsjpfqAQnWNt66KrZ6uOHtLJiWXR4j/yRqSSsijjaEtc/ahSWW1ul980osH/EhhYyrAYWQQZbbNSAyPGCmXO5MdAVb34U1roy/VDYrRmo1ucOagSbq2IrU7cX9yIlcl+63nrcvN0w3PfhE5SK5UKqbIrhnu52DI94/bKt6S2IZQCPOOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(6916009)(4326008)(316002)(66556008)(66946007)(66476007)(966005)(6486002)(478600001)(45080400002)(6666004)(5660300002)(8936002)(8676002)(41300700001)(2906002)(44832011)(86362001)(82960400001)(38100700002)(26005)(6512007)(6506007)(107886003)(186003)(53546011)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1xNXMZ4c9/BC1TWcfKtVc4bXfpNJpLB1GL/ThzB27IWRuapzytM+Qvs65Bp?=
 =?us-ascii?Q?+/6NX0N2jbIQIILe7eAB6ou4HHPXKb/4yU7ncdfeEdocgtrJ59RD4GMZ4DrJ?=
 =?us-ascii?Q?9TqId/gJFiKkVPsnHg6tRDbSumHSDB4dvsHUvkBHI6gWczfRK5Tgk8Hd5630?=
 =?us-ascii?Q?BuLgdpI23AplC3Xm281o1pWeN+BqhrEbzHGCnqqB/QKUvERNcrBk+5W9zpxz?=
 =?us-ascii?Q?ydgQjdoyd1qJavJcxleUacJx5xyfsQGeUGtQuZT4p8J2kG1K8RtVK5r8LTNJ?=
 =?us-ascii?Q?MZU2lfCkEEZZnGQyys+0E/ErOskSZrb0dGRyjbTyHdCFtU3JRzlhUUTWkSJE?=
 =?us-ascii?Q?unCJtuZ+kZDWYVlaH2Tm6hNJ5cfYgpcL9gterQcTyRNPXd8pMeUEdD8f7VfF?=
 =?us-ascii?Q?cosmnNR7HGY2sTi173Fn8Y3aZp2ssejs6rs1Uok20dIrfMwpKoueds5tMCv2?=
 =?us-ascii?Q?9lKZn+kYKgw0/YfBNtFq1IB8/K0wxCq44faIQC+/q0xBCRhJna7MThhf0qi/?=
 =?us-ascii?Q?75yqvpqVk8M73rUFX7G8H9x/lxndawM7bIU1T+CQfeoE29Iw5GzQqSjVqKvh?=
 =?us-ascii?Q?nmN5XDCdlhvVgZcAys2hF7CKKRPTY/SRUlaPBIPp/AuOa3aX2n0vuy8jkJCF?=
 =?us-ascii?Q?3/tvPKTar45YNiHZ9soQRKFbuD4I4sLHI68R0X6FGAjNBjBnYhhR+vk8UyAH?=
 =?us-ascii?Q?HC4etMyP1iwFlAU/cbEKg2WoSfA1NQJhluah3o2sKs9hfm98rouj6D6xHDii?=
 =?us-ascii?Q?su1cYmuPGJPUeLQsGqCtVVrHWVPaEGKrnUcHzloSq0Upjaf+ui1aj2bU6+TQ?=
 =?us-ascii?Q?VisFM/hq6Hxm0I83oo6Pd99Z1KFisWSyk6xgF9N8qBWBurh2hyakCbZY3tJh?=
 =?us-ascii?Q?w2kPum1+kPYaQLFs31qEur+U8lkKIbZ515gnoBGItCtKN87sWB8a5e6Z4Beu?=
 =?us-ascii?Q?cwLOfPYaBH1efWELoMGfFJitYBciC2nDSdvFI2elerM7tzz5SxzglSEAGvf+?=
 =?us-ascii?Q?Pg9kCo2zGNO/nSQ44SdSdJHH2H4cqptofalEKpqsSsq2+xDDvYPB78dhuE7f?=
 =?us-ascii?Q?Y7xloShUP+WtwqAC7b/B44hPvgaiULjQRjw16v4vLqXw1PQRAfAowRX8dHgR?=
 =?us-ascii?Q?lHFX7YwdUEJc99qSCUmv+MF3GdufbFTBfqS/aKW0nf7VTxwcBjg1LU/VLA9j?=
 =?us-ascii?Q?5OXPt30KokguCGcEorZ7EBNe+una5RgC7OtXoOL+q+Jp3DSPuS3yC8+vO5CX?=
 =?us-ascii?Q?Fu6wVGA+HxtiyzenKLd/f+gycckSyCS7iLil8dLTkrj86bqN7rxYjm4fAZCK?=
 =?us-ascii?Q?9iUe0v/6ar8fNRvF7biw09LAQ2NEqhahoo3sCj0bGxwatT65vk6k+xSuCWg0?=
 =?us-ascii?Q?rxXvCQYnCOSckcOaOuOFvCr326N+3oY+CCssCg53M3N7WI65NODdy2bhvwEk?=
 =?us-ascii?Q?8pb1kpkcaeFbvzzK/v+GPmIBRie3XPCaHKrUTcsDDE0yvQcAENP70Bq84SqI?=
 =?us-ascii?Q?1RwYqBC1ex9MujUQM+xCOZlCN6bQRIAh1eww0gLdGN+SN3TIrGrZva9UXZKO?=
 =?us-ascii?Q?WtAsxfrXsioTvotwSi2coAJz2EqKhWXgh+tgDIn7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47acffd7-49cb-4ece-8e35-08db3f1e5977
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 08:32:58.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AjKU0aAWVNyoY84aRfZhen8ecLkNVS11wM6z1JKHggpJFv5Tn5acWED3nqcj/JRYHZp38HSvSE0BMGHJE2H0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com

Hi Jason,

It's a soft remind.
Seems like this patch was not merged into Linux kernel main line yet for some
reason?
And this issue still could be reproduced in v6.3-rc7 kernel.

Thanks!
BR.

On 2023-03-10 at 15:46:15 -0400, Jason Gunthorpe wrote:
> On Mon, Mar 06, 2023 at 01:27:04PM -0400, Jason Gunthorpe wrote:
> > syzkaller hits a WARN_ON when trying to have a uptr close to UINTPTR_MAX:
> > 
> >   WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
> >   Modules linked in:
> >   CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> >   RIP: 0010:iommufd_test+0xb19/0x16f0
> >   Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41 be fb ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
> >   RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
> >   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
> >   RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
> >   RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
> >   R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
> >   R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
> >   FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    ? write_comp_data+0x2f/0x90
> >    iommufd_fops_ioctl+0x1ef/0x310
> >    __x64_sys_ioctl+0x10e/0x160
> >    ? __pfx_iommufd_fops_ioctl+0x10/0x10
> >    do_syscall_64+0x3b/0x90
> >    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > 
> > Check that the user memory range doesn't overflow.
> > 
> > Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
> > Link: https://lore.kernel.org/r/Y/hOiilV1wJvu/Hv@xpf.sh.intel.com
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/selftest.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Applied
> 
> Jason
