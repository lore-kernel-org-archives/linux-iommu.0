Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14D31CA4A
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820496; cv=fail; b=ewgQjndd5qfYNqYxFBDrDjnEr3YZDjr7Q0wlnonEXND6UEHNmTxhYFWy+z1EwXErK0sNdV+JNyrjhEXzK4txJ2gOVDeiecU+KrT1U/HGWr5yGi4WGoE8PZL7np677InTvG3AiDWbfUhW4ssgwSCOJBLIS+XDvgeqrdUdFTJKrQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820496; c=relaxed/simple;
	bh=/Ie8Hf8njkbVuE7lhBmkRikqVYLhzHMoTTbaegh/Ms0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/WfKM2Sy9Uf0Hpygi0z3aqOq5l+jRabGRubk/lQjn4i6LJp4xVbJ6OP4TMo+Ykn9me6BksIDHPUwV8N0xAmExH1VywCpTKGuBLZx5+sXHreNKMQ+9gXTcYz4MJbMxeb2XhuXZyWnmtM+OVQL/wahhcTuDaFzre1A46l5RufBOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BWtbwqU8; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BWtbwqU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2hcUaxE+5SBZwY+gDXY/g5TJK8jzC8ZiwuEypTI3tpKWHxEqavWqsJgvoPa35JHREaLekbAukY/KoDTLTm06RDTWBrspwE3MPhP69oTZmiVathSq90tiH38apqRC1RdYM/0XLtAUjh0DvIxFuqfbsEQ2p3i76gKj7xF90/NTCkmpJqFph5fBxd3oHMegmlhVqZex4RnIw+Z7s8xQOouS88uZjsLmPDDx+EhCuH4GGOVVUBetItppDtB4mfqGepNp7TSOS1Cs+TlcVM0359jmwnnrNdwCuQ1nNCtcZ7SHOi5jopFINq/5XnxxB+gcsbha4BBvirnCzhrPumxB0cOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TdhJr095ZSop8YldFnKtYR21Zlo0NrzBNuTImGU36M=;
 b=Wx2tr1G9R6jbrTwW24acg4PdCCY0MKIK6Bxa2uFfLv9V/wqQtxpRDRARi7iNot5JlcwRtjFR/IT+f51A1czx4O1kMBTgOfH64kg7v7cJafaEmtadyGlRc+9mbnnJ0wFTszoG8RRKckbtOyS5keHL1iIzXBnP9yyyeXL1nBRHQ/autLs3t8B+TpalEWbkPGhIoRrpdrq0DHZQsGRtiV9yK80Lygafe6vZAnhoT5bxXjUWN1rwkwrcjvsKSpOIp0fWwKfFYVHWhJocHbimnjyRCjOeoTTYO/7TEaf+9gmEYiJ3P1HKaQSgh3va0yvMPE3aRtlxkRGd3spIPi0410Qobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TdhJr095ZSop8YldFnKtYR21Zlo0NrzBNuTImGU36M=;
 b=BWtbwqU8BmiDC2+M1Q9dOYgQ5kdk5M5LFKSvbe5F8WLHrJmpDUWQ1YI07iu4NO+p+NtR3dVLYpQUBf3dRNfuOwiGWcFaV2lHNYdfEADzCEt1gLpSh9fBmhE4Ot6l00MEW41fOYfJNrxQ96wl9q2ptZhYJiZogl8047QeiGMuCUI=
Received: from CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 04:48:06 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::54) by CH2PR18CA0048.outlook.office365.com
 (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Fri,
 15 May 2026 04:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 04:48:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 23:48:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 21:48:00 -0700
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 14 May 2026 23:47:57 -0500
Date: Fri, 15 May 2026 04:47:51 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
CC: <iommu@lists.linux.dev>, <vasant.hegde@amd.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: Re: [PATCH v5 0/4] Respect VASIZE for address limits
Message-ID: <g4ottdke5ui57ilntjqy4d74qac7hbuqj7nq7ihm3g4zaxrhsp@jfsdbtehdfoh>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
 <af41-umpPHen-9Ry@jsnitsel-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af41-umpPHen-9Ry@jsnitsel-thinkpadt14sgen2i.remote.csb>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa0f800-bf44-487b-1acd-08deb23d2784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003|4143699003|11063799003|27256017;
X-Microsoft-Antispam-Message-Info:
	4hGJ8O0aJV+c/TcTe9eCYCsCyUBLiiAcx1uURcNKmBEndOlPp2NPM5A+Gww3ni6nMDZsPaK3THDz9PiCw79MRF+5uV0U4FmDZx6HFrBo6pmwMY+DqD/c2OG2pLRaK9fmDVUd2yVgLTzx7VMd6xshWaF3F8vIi4lSrKDfEpSiu7jm6qnB/Bzagm1RDd2xEH9OA9l7+8A5oOxlPWvAfK4+Ni64c5kdvUYgVl62M7QautwxxPNPtsUPnby2qVZCn3vUAM8QR0Ex5STQ7P22QlEKrquAC89s1RTINSVBl5E1QwAwP9Xz0iE/y96ZUIoXR+Wd89BIM+MAX/9rIx/RWVBbDgg7PI6MwkGVSe58yNRMzy2Jd2NUa4jkPnJsdLlJCUj1B3NZY8ou+por2+s0W5sLmmLWPCMblo7bZAR9SUQG5A7nttnsAhnhdizkMiirJxzxCmfalGkpmItN56B4YWD9EPpOzh1kprvlH+2NBStlJhAhQAqK+MjlJMTfCNdZPgHD/+uSr0v2o5v5PjXn5Foo7jyx0zP6z5xAu1Wxlv9y4I2JLxTVvcm/yw3USb7XowYxPw9OC8CgC9N3bD/cTdbfScsOsJXtgmRxASbrfAC6qrZHUFAMFoPiJGDRPpcuIgxbEZLe/ixzJeTjn7gtP173+cId/oPfButV82Nqy/699M+Eow13YbazTwMu+i1X1KcjmR0JgkR9QFTSkWmTMUyYoMg3NFAvNDZ6dh5ufDRT+dxVg1tYMNaCsebtRM6deHMVmkwzcQ9EvjbDH+IyUHch8AMYXlGRMoUQpzc0zjHk/v8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(4143699003)(11063799003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6Di24yNA6rTc3PjG9ORQEL80nw83Vi+gaR8KgbOcTae5q6bnsO8d9ZeelrRrek5jarg+ucziqTxgq1eAfMTNya2iKgCY9QPaPfIh461GIJ+/2+hNuYMHv1rpNpx2kHxJlFEWsXri5wHEG3JeHmmyDzK1tnhdCHGXLBKywH3jddjx35Sjad4z6SpPECZNHI6Vr6iStXQKvOXpj7BYMvCxx/sjMacQWV/9gSENzWx5fG7muSdDwE1kxU99pRuUuQVXo2hFBTgvYzZYIVktw2W/wowoeMv+DPHOPJmnt0/LePpesVw5O7jkSYuZHAX1NDS8Q0QEDxkNRhAp1ROFpRCv8EQK+bkYUqXOALtK6iPxhX8C4tktbVBDCpdwENAZUyATARNkg147kzFD8OIhIdI2+6akMU0vuZJOYoZIby7nkld69Q1d9Zx/repXszea3Yzq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 04:48:05.8368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa0f800-bf44-487b-1acd-08deb23d2784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

On Fri, May 08, 2026 at 12:23:00PM -0700, Jerry Snitselaar wrote:
> On Mon, Apr 13, 2026 at 02:45:17PM +0000, Ankit Soni wrote:
> > The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
> > ignoring the IVINFO[VASIZE] limit. This could create domains that
> > exceed the bounds advertised by hypervisor. With this series, driver
> > respects IVINFO[VASIZE] when determining the addressable VA range.
> > 
> 
> Should the AMD code also respect IVINFO[PASIZE]? VMWare presents an IVRS
> table that has both set to 40 bits.
> 
> [000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
> [004h 0004 004h]                Table Length : 000000BC
> [008h 0008 001h]                    Revision : 01
> [009h 0009 001h]                    Checksum : AD
> [00Ah 0010 006h]                      Oem ID : "VMWARE"
> [010h 0016 008h]                Oem Table ID : "VMW IVRS"
> [018h 0024 004h]                Oem Revision : 06040001
> [01Ch 0028 004h]             Asl Compiler ID : "VMW "
> [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
> [024h 0036 004h]         Virtualization Info : 00142803
> [028h 0040 008h]                    Reserved : 0000000000000000
> 
> [030h 0048 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
> [031h 0049 001h]       Flags (decoded below) : 00
>                                      HtTunEn : 0
>                                       PassPW : 0
>                                    ResPassPW : 0
>                                 Isoc Control : 0
>                                Iotlb Support : 0
>                                     Coherent : 0
>                             Prefetch Support : 0
>                                  PPR Support : 0
> [032h 0050 002h]                      Length : 008C
> [034h 0052 002h]                    DeviceId : 0010
> [036h 0054 002h]           Capability Offset : 0040
> [038h 0056 008h]                Base Address : 00000000FEC10000
> [040h 0064 002h]           PCI Segment Group : 0000
> [042h 0066 002h]         Virtualization Info : 0000
> [044h 0068 004h]                  Attributes : 00000000
> [048h 0072 008h]                   EFR Image : 00004000000000C4
> [050h 0080 008h]                    Reserved : 0000000000000000
> 
> Regards,
> Jerry
> 


Hi Jerry,
Good point regarding also considering PASize.
Currently, with this patch we only limit the VA size based on the 
IVHD-reported capability because that directly reflects what the IOMMU can
support for virtual address translation. For physical addresses, we are 
effectively allowing up to 52 bits unconditionally, which matches the 
current hardcoded assumption and effectively does not constrain the mm
layer.
Your suggestion to additionally restrict PASize makes sense from a 
correctness perspective. If we propagate the IOMMU-reported physical 
address size, we could detect cases where the mm layer provides addresses
that exceed what the IOMMU hardware can actually handle. In such scenarios, 
it would clearly indicate a mismatch/bug somewhere in the stack (either 
incorrect capability reporting or misuse by the mm layer).

I will add enforce on pasize change and send a patch.

Thanks,
Ankit

> > For a small VA size, domain initialization in the generic page table
> > framework can fail with -EOPNOTSUPP. This happens because the page table
> > clears the dynamic top feature from the force enabled feature set, as no
> > page table growth is needed beyond the current level.
> > This series also fixes this issue and adds KUnit test coverage for the
> > 32-bit VA configuration.
> > 
> > Changes:
> > v5: - Added Jason's suggestion for modifying get_info().
> > v4: - Remove PT_FEAT_DYNAMIC_TOP check from pt_init_common().
> >     - Add test coverage in amdv1 for 32bit va size.
> > v3: - Remove specific value checking for vasize.
> >     - Add patch for PT_FORCE_ENABLED_FEATURES.
> > v2: - Mark ivinfo_vasize_bits() as __init.
> > 
> > Ankit Soni (4):
> >   iommu_pt: Fix pgsize_bitmap calculation in get_info for smaller vasz's
> >   iommu_pt: support small VA for AMDv1
> >   iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
> >   iommu/amd: Adhere to IVINFO[VASIZE] for address limits
> > 
> >  drivers/iommu/amd/amd_iommu.h               |  2 +-
> >  drivers/iommu/amd/amd_iommu_types.h         |  1 +
> >  drivers/iommu/amd/init.c                    | 13 +++++++++----
> >  drivers/iommu/amd/iommu.c                   |  3 +--
> >  drivers/iommu/generic_pt/fmt/amdv1.h        |  1 +
> >  drivers/iommu/generic_pt/iommu_pt.h         | 12 ++++++------
> >  drivers/iommu/generic_pt/kunit_generic_pt.h | 10 +++++++---
> >  drivers/iommu/generic_pt/kunit_iommu_pt.h   |  5 +++--
> >  8 files changed, 29 insertions(+), 18 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> 
