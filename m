Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086073D7B
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 00:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvgXO0j1QkVGB1OgiFycTJBwd6I/KnPLu2On8yUg/C/0n/IpL5LYVy9iWY+Cl/LpIXylmA2KHbauJE2ZShSYR+NAtzUkhkXcDpBOmBfzhmMiwH96qb1qFz60/xqbUzO3wkSwEbKtN2KoSEKo1LUx2ij9mG4TKbuRrIkIij1OwOadWQJK23Z8LPDTWnMkJqjojZ33FgGm0joRO/xcj/aTiFXh4vHaw4OXe9azQ5R6vdpu3QfaawGGegGhfYH+kAV5FfY58/PvkAAIkSp1OcdSrTAfCWbo5ibtU9tVaN/Uexi85fpdyn2PZrZSElseFMl+qKX+VagbGdhR6KHTXSM7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuHbRLD/9sJva3JGLMSk3rbsxHyuJBuURAmsKKzbTYs=;
 b=ho7D+7FBYGH4JMZ5vEv6mvumkyWFYQ6PK0vHAPhGuOtxlNjBkOXJ8qDCkcfxiohCFQiSlLiYNd1i37MWs50KkxfUNZuW31WAHI23TuLnrOeGnSHsrWhdC3JKfwEePZZGbVX91FjkhZTrFQ6jpSkYsA3mF0c+Hq8X6qL3u8eSqNmKSatV6muPzXpo/WfjeFSecw2P+7QmKloyNp0QtIjfCrXIgiNimj+EtAXDVE7Kbp2HsiKnwl7fpRFVz1YCChcv9H020jTmrTA7+t+/l6Zhb/qbzvj9tgvhpAq0PwXEjVimcsaqitKd49GsW3bAt/8TmPymFRovJ23KxUTKcVh7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuHbRLD/9sJva3JGLMSk3rbsxHyuJBuURAmsKKzbTYs=;
 b=MdNcU2kDpjdmuMUDOXYarfSiUQB1mY4Eiyim4nUyZBZYm9S0Hqo0r9xzsfNzABxZdY5Ly2ivbEkUOILPQcIXPMhv8UZdhDM8RhOJE2BRwS391VpwqD5y6m5OyV2+y5GmBmVroYwJcRsb54zV664pJTg5JF5+boG+CkScGLneuhCnfd/eRbJ0xPW4zcXDRoEOJNUntvKTMhOs2Xwn3fqgd3x6PykNFdJq8ZYxnN8mYNswEsVpssMYWlHo/c+nk07gwvPCekm21OSNKfzHnO+5Sqn0Lfx5+NLjN2N8BC7TWlEwZxeOz9PcWN8jn/MYhleFc6XXlNkezbJhp+vny93q5w==
Received: from SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 00:02:24 +0000
Received: from MW4PR03CA0101.namprd03.prod.outlook.com (2603:10b6:303:b7::16)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 00:02:23 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::31) by MW4PR03CA0101.outlook.office365.com
 (2603:10b6:303:b7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Tue, 4 Apr 2023 00:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.16 via Frontend Transport; Tue, 4 Apr 2023 00:02:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 17:02:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 17:02:11 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 17:02:11 -0700
Date: Mon, 3 Apr 2023 17:02:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCtpAYn76u499p6G@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1NAM11FT039:EE_|SN7PR12MB8102:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 276ffa29-841f-4fc4-02ca-08db349fdd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSYygyVr12VifTDPscUMOsEMWlj5LFZr7QEYXb1ggME/A9EPp7zEqR9hf8RPDiZPyfaE6Qioac7l0PaiT5KCTWrGjLMlgNS9ln5mC42ssn35kn+r4h2VsnExVTFMk43G02Qiat+4mx1Qqw87p2MCOerQ1Z9WQngp70imXzioLNGADFcPFYEVn9n/7iPljNLLLl3OTteSJ0aPAkv24X6aADju+/XckK0uuSKTM+HZttq1vrZv3n4HSE3rU0fgfP7noth5F4GEK4gfkNgQaG+tHKF89VHrlzmB+h9Hfwhgqzi+A3Mbk6XJeqQEGYOUeYQg/YLK3j0yVkbOovvcRMX9j2FY9Z4bAzg/K0JMXGX3TD5rbOGEiPARC4MoelFt3OucX7P7A+RIarYWvAAazG4oX2A39g2JaCPsxFtca1lAAHHsDQ4P51W/H1+UD73NK+0n42G6jJyxGOl9oYHSa4zBwnXnnl+pPJpsV7K4NkUZ7umyHM2pWKTrZqnkDAtDFRtEHt3DPMtxDGWeVZp8U4FQ3kCNUoVDhTrjKtXcVEgniEpjx0PZpnanHTatAmCl9BJTw3qm/jCBiiaPM5SlHFRKzdfKPmx6v7D+rs56v6FGtJNYLywlp4JKttofIZcsSAV7tCRUiEijwVSZvRBXwK4Z2CcGEJ6genbRGZvOpWHUEE48zJ9LTvJA2j56NuV2kvhbYtza7E6c6yuCOGaPptXg2ia2HqwXJf8oHT/ULSOMJX3LhSerfMFo0A+N8eLXZjrt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(82310400005)(2906002)(33716001)(40480700001)(55016003)(336012)(186003)(53546011)(83380400001)(47076005)(426003)(9686003)(26005)(36860700001)(8676002)(70586007)(70206006)(478600001)(40460700003)(6916009)(7636003)(356005)(5660300002)(82740400003)(41300700001)(4326008)(316002)(54906003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 00:02:22.2854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276ffa29-841f-4fc4-02ca-08db349fdd8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Hi Robin,

On Mon, Apr 03, 2023 at 08:15:03PM +0100, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2023-04-03 15:51, Nicolin Chen wrote:
> > On Mon, Apr 03, 2023 at 11:08:23AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Apr 02, 2023 at 05:33:35PM -0700, Nicolin Chen wrote:
> > > > The first version is simply to individually forward the entire
> > > > command. This can save a few CPU cycles from packing/unpacking
> > > > invalidation fields of the commands via a data structure, v.s.
> > > > the structure in v1[2].
> > > 
> > > The kernel must validate the SID for the ATS invalidations, we can't
> > > just blindly pass it through.
> > 
> > Yes. I didn't go further with the first version, yet leaving a
> > line of comments in the handler: we'd need set/unset_rid_user,
> > to validate the SID field of INV_ATC commands, as we discussed.
> > 
> > > And this simple path needs an explanation how errors are properly
> > > handled, eg by making execution synchronous, or someone guaranteeing
> > > that errors are impossible.
> > 
> > Yes. Both versions here execute in a synchronous fashion. The
> > error code will be returned in the cache_invalidate_user data
> > structure.
> > 
> > > > Then I added a new mmap interface to share kernel page(s) from the
> > > > Driver, to allow QEMU to write all TLBI commands as a single batch.
> > > > Then it can initiate the batch invalidation via another synchronous
> > > > hypercall.
> > > 
> > > I don't think a mmap is really needed for simple batching, just
> > > passing a larger buffer to ioctl is probably good enough
> > 
> > It wouldn't be a must, yet can omit a copy_from_user() at each
> > hypercall? And it also eases VCMDQ a bit.
> > 
> > > If a SW side is built it should mirror the HW vCMDQ path, not be
> > > different.
> > 
> > The host kernel has the host queue, while the hypervisor fills
> > in a guest TLBI queue. Switching between two queues at one SMMU
> > CMDQ (HW) requires a very complicated locking mechanism, v.s.
> > inserting the batch to the existing host queue. And it probably
> > doesn't have a big perf improvement by doing that?
> > 
> > If SMMU has ECMDQ, it'd allocate a free CMDQ upon availability,
> > calling arm_smmu_init_one_queue() and mmapping q->base, then it
> > can execute the guest TLBI queue directly, passing that q ptr.
> 
> FWIW I don't think that should be visible in a userspace interface. When
> the VMM is just requesting some invalidations in order to emulate some
> commands, it's up to the SMMU driver, or at best between the driver and
> and IOMMUFD, to decide exactly how those requests get executed as
> physical commands - that should not make any difference to the requester
> other than how quickly the requests are processed.
> 
> AFAICS this interface can't look like the proper hardware vCMDQ path,
> because the whole point of that will be to configure it in advance, map
> the queue controls directly into the guest, and avoid trapping
> invalidations to the VMM at all. This invalidation request interface is
> a large part of precisely what that path is intended to bypass. I don't
> see much benefit in supporting an additional slightly-accelerated slow
> path where the host avoids a tiny bit of housekeeping by maintaining a
> real vCMDQ *on behalf of* the guest and forwarding trapped commands into
> it instead of just processing them normally as host commands. Or,

I tend to agree with most of your point. The implementation of
a SW emulated VCMDQ might be overcomplicated cooperating with
the kernel driver and the QEMU vSMMU code. If SMMU HW (in most
cases) only has one CMDQ, it is hard to switch between commands
of host's and guest's to have a performance gain. VCMDQ could
simply do that because it has multiple CMDQs by nature.

What is the normal processing approach that you'd suggest? Do
you agree that having a batch invalidation would be nicer? We
could go for the mmap'd page approach in my draft, or go for
the ioctl that Jason pointed out.

My preference is to have a mmap'd page, so the interface can
be reused later by VCMDQ too. Performance-wise, it should be
good enough, since it does batching, IMHO.

> conversely, emulating a vCMDQ *in* the host kernel, in a way which still
> requires traps to bounce through the VMM and back - that just seems
> objectively worse than keeping all the emulation together in one place
> (however, I would concur that a "vhost-style" emulation, using all the
> same interfaces for configuration and error/irq/etc. reporting as the
> real hardware would, might be viable if performance really demands it).

I am not very familiar with the vhost style. By a glance at
its doc, it seems to be one interface for all hypercalls?
That would be very different than what we design here..

Thanks
Nicolin
