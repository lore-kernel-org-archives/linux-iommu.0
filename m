Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DF13AF0
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 16:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2Wn9RBO1G/Kjs65wUBnHd8R+jBh78+NQW/2veNRUIFyFsTwsJHjZyks8RZI6Tg1ZCG7xhafRutEP4wB3jxXU7UR5eZ6cjF4hnhZFT/5k4swhaCJjWX9eCVgXNshNWxZ8nBFbFewt1esfl1qaGRx9wta5vKNtCPIuOIqPW8qxySpPvgSoxMsbT5E+egUL1qVum4HCbKUvoytyV5gcdgx2UromkTMdwfybH7TvnzyBzNWV0uJGMmDDn/MCTD16xcn6zWYribHRBSS/mnFlwrGgt4dv3D5VjN+N2IskoN6TUXZ0k9DU/Lo/eVPpoUSdV/gYreOByTMM5nJFyHIQhtKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5DXLWTfzK+aukjf8s2EAlolxz3UO6dR9umxnEmARzY=;
 b=c3Yujmgm9OmIMJ+nTXPUq7wJSvEymuNEWDvwYsUTJmJHtSKU6vYIjg24XtN5wN1Q+BL0mH3Vwrlad7knhyP/D97Aow6NKIePaO0s9WW8fihAij9Sgo9cn/pfE72EfTXz7TsOj8Wnv7y0wCz6Jx/hcYT0oZdy32Qxq43WBsJIeVmS5YCbXoMn9V3fHBcVRfzqd8dheIrklrsb/ZY5bMgueYuOiWdD0+kZnCyB/vm2+8zQ2RM+OhUqEk+M+xOR9efOCgIgzP42OSH3MwSPiflzorPwgl/bLSyOxSBhnXtdkuYfehcPcgQJ/oIx1P0gDqxFhDOL0wHR13tmr3WJs0aC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5DXLWTfzK+aukjf8s2EAlolxz3UO6dR9umxnEmARzY=;
 b=Hf5HuZHfqnbCVHRNp5H5DX1rStSf3/sbUIblT4qjng1QmBfH4kDb9BmOBGDmGY2olfvrktYAdcZ06j4KoyyYzna7Ffp6b+Xy2Yj22XA5H2Xq0GETd2rC0uc9GiWg3CZIcROm+7cfBXTrF5XBv5i4C2V7VChMOwF54wyqVUrbE+8iWPs+mVXZ30MsOtk68oncP7MFuW3NH412qVPtOI0c3655h8zqCwTzeJVUARMMQN4v7PcDYaU5YkDFdidi+YjB2kHecXKpqf8m5Po7Xlfc18dpYHCxXypM/JlA0sk9knAwnXRzOxxKV2A8j3PneYOwsYJJoT66jLG6Lfx/X8As6g==
Received: from DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:30:36 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 16:30:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::98a5:ba0f:4167:8d53%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:30:33 +0000
Date: Mon, 10 Jul 2023 13:30:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Heiko Stuebner <heiko@sntech.de>, Kevin Tian <kevin.tian@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH rc] iommu: Fix crash during syfs iommu_groups/N/type
Message-ID: <ZKwyKPiPIsOGAO4t@nvidia.com>
References: <0-v1-5bd8cc969d9e+1f1-iommu_set_def_fix_jgg@nvidia.com>
 <ZKfNNT1yzDNRj-II@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKfNNT1yzDNRj-II@suse.de>
X-ClientProxiedBy: BL1PR13CA0293.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|DS0PR12MB8785:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8a1b0a-3dae-4afb-14b2-08db8162fbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	suoiDvToHect5uuiynIHosjSzPyQBRWR3AbY/EVhPiuoPsXVH1/FaLT/q4lGZubJ9cGFV+A0NNJpJhnO2qVTWWxtvsscKoH1RKejZvpEU5E6hgOxck+teJlQ3k5JoBxjmihIsmAd10q6ZGONJhyNbMsBtgSUxbtl2KW7W4h/hnpV9pTKa0pt+57cGku2n+Qhen46RvjVkxVEG9LwxHA3iw17h5xpsIUIhwlkQCWEkycbSaO8wxqOTwLvYW5uY9zMOlVydDfcdyxkgGZcQb+aY+haHsElBF+cJHkMV7Lv+ZzVbO3lBSmRmON+oITIFbWTUCAlbJknBa3jqPjG//qgtO/g2ip7Wj6xrgrCMxfxmm4mw0a8X9wVOcV7EfEp3zW2MwNY5medeaKAztAGx28Pw8f0SCzMmofovl05VH5DITmW4msybc6RUoyHD78wGrtmRTmrdCP1+cFmiIuu51McjlgJIUPxYA/ufKD+I+yK6shG25HB/qtyHW9HwavX/QPs0Ibg4MWDheiNNabCrU9qdJdwpJz3enXZtQR7ila9GFbxE6Sy1l0zSpJ13ByiTWFY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8785.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(86362001)(38100700002)(36756003)(6486002)(54906003)(6506007)(26005)(186003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Wi6/mn5xg1TzgbhduB/0tZLxWUxrd4Xl0GuYJLra9q3Cnb5LgG9+VKRlRFx?=
 =?us-ascii?Q?5PrJm5fMRxf6W3/9my+1hRBFC0R5VSn06hPEWd6Jxn7posV4CrJxBMJVWcFr?=
 =?us-ascii?Q?vbH5qOvGaFT5yLK+wwuZ5f6+FjBGBHkZSfw4XHeaKw8yb2jHVfzCwROow5eP?=
 =?us-ascii?Q?4vReZS76UNnFVloOl9BPs2PozoYbhjIB2Gs4crTHiop2/xyp6OZBPMuPn068?=
 =?us-ascii?Q?VboeKcJ9zWFSCGm0pZY+vmnzQu3AZHWlzQxkQyYfLcPz1gktGlA20sOJAVYp?=
 =?us-ascii?Q?IZFRYraIjjrmoxbuS19PqnbtwBU3pmHJ74ie2rpAbHWyU4Bjq+hPwWcXiFA+?=
 =?us-ascii?Q?AarzYJLu1BZnKqTaw2ylHDPXJG/G9NFsIS3cNHAgSHbW3RneFApuUpVtEKa/?=
 =?us-ascii?Q?LIrMQYzCRDWKj7l+jFSmK5+5YIl6KfJkeb5aL8YtBGi6OnZOX9isUwC14j5q?=
 =?us-ascii?Q?gPxiDm+8gOKC9OD+0pI0RtdGo8J3OKMz2Xm51FBfU6trVzhEnFvsK6F3Tkc8?=
 =?us-ascii?Q?vh551pyRv75bkBpYIK8V94dFYogw0D/ZMUpdJhxBSmBkj1yMJqSOkD4wCQ/N?=
 =?us-ascii?Q?1agBpnn5nqVOONh4kxcwARJ5MAQj+GPnzWgMfCyZS1TWJuZ4k2K0yRrCq2fO?=
 =?us-ascii?Q?/vvAjh6Cm/6OP8MLShel2F+BZq4eh7N1D95HTfNJL4T3dJZLb7uG4ZKM5NgL?=
 =?us-ascii?Q?frn77uQKsIOJGl2mkWUmEEelfwUda/ReqwifjLjJ9bShvVtSbwudPponDe67?=
 =?us-ascii?Q?DevQzHXwNceobt2JQAkvcMNtzbJ+0ZAchF4SGwyaOAXUcDixlMv3uGwYLrNr?=
 =?us-ascii?Q?uwCZL710N6eHABO4lw7FjAbCU5z7OAwfw84aAuyP3NO5G1gPTJx99CRr8x8z?=
 =?us-ascii?Q?rmX6CGdZNmRbHtoTvZTcSF89fjg5NQywPSJP3MruHzYbw6T3/6x6MV/PygZV?=
 =?us-ascii?Q?O8dk0ca0VdCgwKlSfS7j0AeAGPvxdksIeR0YkCLesUUUGN9b2BXm9fsAJO5c?=
 =?us-ascii?Q?+XDSpsWdM5/wJtdfu4D4DDyMs0HsyxzUzb21Pp3pBeDinjtfDLrxXQPdO412?=
 =?us-ascii?Q?3GoKbIORlKfBbj1Hi6XLxpkAP/0CP6BwZj34k/ROSfFkpKLFlEZrW1qacs1H?=
 =?us-ascii?Q?Tp1fcoHO+C+Xq+bXfb1IaXbIX4AO7Q+uegU9Mkfo0aXB6YN6JTPDrhg8PJTa?=
 =?us-ascii?Q?nHdxsLRbL3e7zaJyZjVz3L2b/iuGEyNTTswQWZwVItBDXjl3LU/Be7tGSSDM?=
 =?us-ascii?Q?nv7mIhCAA9qyY7RW8y4Fzup2HhzNwNoEEp15QPnNnol7ngWHo0dI6IoWpxkn?=
 =?us-ascii?Q?iBPU8MsiCfmPZrlR4grsEjBNPCj5Er8rAO4Jug1jZzoyJO1zvjV4eL70EtbW?=
 =?us-ascii?Q?hZagy4yexLc2L1h/ZB80NoOHvi8tUepz3LwcI1NmtxfRSjYESk/zrcK5qUJT?=
 =?us-ascii?Q?7U4apHLKkmIAdU8jsXd0gWUIBY1dQqADwqhXA2l0h643GfiaSIlFCn5bSZ/U?=
 =?us-ascii?Q?E/ISeV1EV5SQcJy9WwSZsERr/T7axcUir6+03ZiNrmMTED4VmC/kT+TY5cWJ?=
 =?us-ascii?Q?st6Uc3SqzCjUr20mO5t++38MM0DgQUyFqjeRE0kf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a1b0a-3dae-4afb-14b2-08db8162fbd6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:30:33.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bay4eNrNqYzL7HG6L5uLicPhD6ICt5H25m26dLvmOPEygxEoKTGKvP5XP/Hov5T6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337

On Fri, Jul 07, 2023 at 10:30:45AM +0200, Joerg Roedel wrote:
> On Mon, Jun 26, 2023 at 12:13:11PM -0300, Jason Gunthorpe wrote:
> > The err_restore_domain flow was accidently inserted into the success path
> > in commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on
> > ARM"). It should only happen if iommu_create_device_direct_mappings()
> > fails. This caused the domains the be wrongly changed and freed whenever
> > the sysfs is used, resulting in an oops:
> > 
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   PGD 0 P4D 0
> >   Oops: 0000 [#1] PREEMPT SMP NOPTI
> >   CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
> >   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6 07/06/2021
> >   RIP: 0010:__iommu_attach_device+0xc/0xa0
> >   Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48 85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
> >   RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
> >   RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
> >   RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
> >   RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
> >   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
> >   R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
> >   FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    ? __die+0x24/0x70
> >    ? page_fault_oops+0x82/0x150
> >    ? __iommu_queue_command_sync+0x80/0xc0
> >    ? exc_page_fault+0x69/0x150
> >    ? asm_exc_page_fault+0x26/0x30
> >    ? __iommu_attach_device+0xc/0xa0
> >    ? __iommu_attach_device+0x1c/0xa0
> >    __iommu_device_set_domain+0x42/0x80
> >    __iommu_group_set_domain_internal+0x5d/0x160
> >    iommu_setup_default_domain+0x318/0x400
> >    iommu_group_store_type+0xb1/0x200
> >    kernfs_fop_write_iter+0x12f/0x1c0
> >    vfs_write+0x2a2/0x3b0
> >    ksys_write+0x63/0xe0
> >    do_syscall_64+0x3f/0x90
> >    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> >   RIP: 0033:0x7f02e2f14a6f
> > 
> > Reorganize the error flow so that the success branch and error branches
> > are clearer.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
> 
> 
> Why is this Cc stable? The causing patch is not in any released kernel.

I don't keep track of when/where all the patches end up in stable. It
is now in -rc1 so it could be picked at any time. This is an important
bugfix so it should be backported if necessary.

If you know it is not in stable then please drop it when you merge it..

Otherwise it is harmless metadata, AFAIK.

Jason
