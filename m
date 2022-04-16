Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6158DC433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 02:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC11284044;
	Sat, 16 Apr 2022 02:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5YgLyO8fUwuE; Sat, 16 Apr 2022 02:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F90A8403A;
	Sat, 16 Apr 2022 02:03:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49C25C0033;
	Sat, 16 Apr 2022 02:03:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9051EC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 02:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 748D141B73
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 02:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZX2ISOGb6eVE for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 02:03:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0334A41B70
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 02:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF5YY/US4cAVsn3mQj1DSvzVhEi3/rZTUs5dyEZfVZ9L4WVYJKxqpLMw/ipNC2jh5Ii4kgnFLBOdcHA1mhFOK3hEo9IeXxBDppiBDE76G1vqXgHpuBDHOlgYsHHF3KtnZh7mQ14MThx1r5VoxS+2K0oqtVM0qxT172XeIBAfrRdGIf8wj+DeJAHDD4aXcqPykmGLsp+8EqHD161pTlkDxKCJPI5ql8zySyCZsB57DC5OjCm7MiSXvBnb3rpqa8pdV876Vk0DLSFczWgwjeFn0PZ+DMpPiIu1/t5C2Nm6hIT7YLYvp+MRJqIpZr2DscTN+8ojzObfzcE9UmknM5sRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDjmvJd8OtWnfc/ieSJhNhvznp/MO2Q6a0IHyo0ZCUE=;
 b=JRRhBTfEYsIYOgUiOJxOZr1VFjDoPbkD7LWvpQyRyD/4p0X2lWbD58PCm8mXux3fHCORlPv6FzPSn4+zv9+mrC9gdweXCZT7XRG2E68VcaLWxE5x50Uvma6PRqa64xER6hL7Lsu1RngtDOa1xqwIOVwNLdW8TneDXCxoCwZ5V/iOfANTiI8kdMWyBJ/A4sJ+WzNqi3ouQMsgnlTDqaph0GuvyHm7lR64ngRipZOahw5wOgaNklYifUFdJhly6vUSlQ7h/n7lmd2zM2Z1zJDeXTJKTwVYMlGdCOkM1UFtFFNkCgLJ0ZeWRLwVoZ2YTqrLxXW6y44naonVIKD/Ifqe6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDjmvJd8OtWnfc/ieSJhNhvznp/MO2Q6a0IHyo0ZCUE=;
 b=ivQnM+aH0msvvN7nFCJ+K+/rmZGHFsH7XH3wz9IelomW7wz+2dygb6WzmzWrv9Q9cLo07knM50NVmCrFSDPNrxxWQu16wS3YyPGX5Cvz5Nx3qOEjtVhlLWgKjg5yeruTMRd/pAG/kDEjyvqx6dQT/pszdXM4lNJ39YYG/MmYPqbuSgGyN4Mk6Huxw8B+z8aQuqYmhB55SGx+26zzV/ycqxKInPfdlukEdAM6PwQM9QaCc/hrWyf7GgalWdXlhv6LEgqUbnQZVBJviyacJCeNPYXkH8I7cMU4B8HGkBPr5rZKgJoFfio/V2r/wW7paN5ZF3/bfVX4YtCcM8elfIbweg==
Received: from BN6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:405:2::11)
 by BN6PR12MB1491.namprd12.prod.outlook.com (2603:10b6:405:5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 02:03:23 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::8f) by BN6PR11CA0001.outlook.office365.com
 (2603:10b6:405:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Sat, 16 Apr 2022 02:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 02:03:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 16 Apr 2022 02:03:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Apr 2022 19:03:22 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Fri, 15 Apr 2022 19:03:21 -0700
Date: Fri, 15 Apr 2022 19:03:20 -0700
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <Yloj6GM+yykImKvp@Asurada-Nvidia>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da85917-889f-4a6d-f83a-08da1f4d499f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1491:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1491356C8A4F0D71C5719BE6ABF19@BN6PR12MB1491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvowyuE0LMkjGVW576gIltPPvo6Afb/HglzM/cHlX8ELW6SgegWkX1wPD3otiQq5Lp/KqOVmag5eEBuoTT88Lryl3IEfGGryQYlxOeDmlyS+oX2OfaJERlw7kh2RHuiyOkR8O5madXjkWOIcl86xYDwT8VfQ/XsOYeVLVEiYGfKye+Xkmh7Es06FMQhkvQdFJN121nUbO81Vq2pq1Q59m5o566M2fIWYCXqLzvo73Hq+9QZlSUmGpFneJSkQTcCCpoJpkfAFtwgqsbrpq02MP4UAsk/LXHLy+v6CHv+tFAEGZNSegmoh53daxPbgI8yNNEF85EEOoCa6oli330Yi/O40s+DoJvNiefm63Ol7aK05/oUXbVIBAOquWFpHmnlJdL5+p0NWS7urtm4/NYZcqhRBGuA+d3RNCVk4bt3SnwTzqB2Q4auaxJsQYDRLPIlZ/iEjotu7VwHPkIbm7qIaJ7rW61eyuPpc69o3r9a4aAQR8d5z/lF8DX9DPQcokT2ClbpkeNoiP7ZvdKCOwAbfDpIMnKtvq2X87v5oGHBDFbDrayWKVyfx4E5yB7DDFLmPUrN5oe3NkpT98EFxSmzAm2OhBn8VGb836Bz9pZMF2ltNXQlkaqkIWyqyuMyIsMek2HqFTKoM5gtcGjGtGgpkkwj4vNmxnV3MQ8YY5jYH8zu1IlcxgABiyp07HwSzS26o2ADdhCqC1pzXdQbUN9/dZB0AfQWp7tE3cvGqlevxwo0=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(356005)(6916009)(81166007)(7416002)(55016003)(33716001)(8936002)(36860700001)(83380400001)(47076005)(316002)(426003)(336012)(82310400005)(8676002)(4326008)(70586007)(2906002)(70206006)(186003)(45080400002)(5660300002)(508600001)(86362001)(26005)(9686003)(40460700003)(67856001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 02:03:23.2947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da85917-889f-4a6d-f83a-08da1f4d499f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1491
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 iommu@lists.linux-foundation.org, christophe.jaillet@wanadoo.fr,
 tglx@linutronix.de, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 14, 2022 at 11:32:38AM +0100, Robin Murphy wrote:
> > By looking at the call trace within arm_smmu_* functions:
> >    __arm_smmu_tlb_inv_range
> >    arm_smmu_tlb_inv_range_asid
> >    arm_smmu_mm_invalidate_range
> >    {from mm_notifier_* functions}
> > 
> > There's no address alignment check. Although I do think we
> > should fix the source who passes down the non-page-aligned
> > parameter, the SMMU driver shouldn't silently dead loop if
> > a set of unaligned inputs are given, IMHO.
> 
> Oh, sure, I'm not saying we definitely don't need to fix anything, I'd
> just like to get a better understanding of *what* we're fixing. I'd have
> (naively) expected the mm layer to give us page-aligned quantities even
> in the SVA notifier case, so if we've got a clear off-by-one somewhere
> in that path we should fix that before just blindly over-invalidating to
> paper over it; if we still also want to be robust at the SMMU driver end
> just in case, something like "if (WARN_ON(num_pages == 0)) num_pages =
> 1;" might be more appropriate. However if it turns out that we *can*
> actually end up with unsanitised input from some userspace unmap
> interface getting this far, then a silent fixup is the best option, but
> if so I'd still like to confirm that we're rounding in the same
> direction as whoever touched the pagetables (since it can't have been us).

I got some details:

[ 1008.868735] mmap: -------__do_munmap: range [ffffa4fd0000, ffffa4fe0000] len 10000
[ 1008.869183] -------arm_smmu_mm_invalidate_range: range [ffffa4fd0000, ffffa4fe0000] len 10001
[ 1009.056127] ------------[ cut here ]------------
[ 1009.345791] WARNING: CPU: 0 PID: 131 at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c:189 arm_smmu_mm_invalidate_range+0x4c/0xa8
[ 1009.605439] Modules linked in: nvidia(O)
[ 1009.692799] CPU: 0 PID: 131 Comm: dmaTest Tainted: G        W  O      5.15.0-tegra #30
[ 1009.865535] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[ 1010.015871] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1010.168191] pc : arm_smmu_mm_invalidate_range+0x4c/0xa8
[ 1010.283136] lr : arm_smmu_mm_invalidate_range+0x48/0xa8
[ 1010.397119] sp : ffff80001436fa60
[ 1010.469568] x29: ffff80001436fa60 x28: ffff00001840be80 x27: ffff000007b3fff0
[ 1010.629631] x26: 00e80000589f0f43 x25: ffff00001aa20288 x24: 0000000000000000
[ 1010.786432] x23: ffff0000138c1000 x22: ffff00001783aa00 x21: ffff00001c021380
[ 1010.944448] x20: 0000ffffa4fd0000 x19: 0000000000010001 x18: 0000000000000000
[ 1011.101568] x17: ffff80000e4b0000 x16: ffff800010010000 x15: 000081a13a744e89
[ 1011.259839] x14: 00000000000000ce x13: 00000000000000ce x12: 0000000000000000
[ 1011.415616] x11: 0000000000000010 x10: 00000000000009c0 x9 : ffff80001436f7f0
[ 1011.575552] x8 : ffff000013563420 x7 : ffff00001feb9180 x6 : 00000000000035aa
[ 1011.731775] x5 : 0000000000000000 x4 : ffff00001feb29e0 x3 : ffff00001feb5a78
[ 1011.887615] x2 : 66f9034381513000 x1 : 0000000000000000 x0 : 0000000000000051
[ 1012.042944] Call trace:
[ 1012.097919]  arm_smmu_mm_invalidate_range+0x4c/0xa8
[ 1012.204480]  __mmu_notifier_invalidate_range+0x68/0xb0
[ 1012.318208]  unmap_page_range+0x730/0x740
[ 1012.405951]  unmap_single_vma+0x4c/0xb0
[ 1012.521920]  unmap_vmas+0x70/0xf0
[ 1012.633727]  unmap_region+0xb0/0x110
[ 1012.753856]  __do_munmap+0x36c/0x460
[ 1012.855168]  __vm_munmap+0x70/0xd0
[ 1012.929791]  __arm64_sys_munmap+0x34/0x50
[ 1013.018944]  invoke_syscall.constprop.0+0x4c/0xe0
[ 1013.122047]  do_el0_svc+0x50/0x150
[ 1013.196415]  el0_svc+0x28/0xc0
[ 1013.262848]  el0t_64_sync_handler+0xb0/0xc0
[ 1013.355584]  el0t_64_sync+0x1a0/0x1a4
[ 1013.435903] ---[ end trace c95eb7dc909f29ba ]---

We can see from call trace and logs that the invalidation range
comes from __do_munmap() with end address = 0xffffa4fe0000.

The problem seems to be the difference between how mm and iommu
cores express their end addresses: mm core calculates end using
start + size, while iommu core subtracts 1 from that. So that
end address 0xffffa4fe0000 should be 0xffffa4fdffff in iommu's
way.

Perhaps we should simply do something like the following?

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index d816759a6bcf..e280568bb513 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 {
        struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
        struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
-       size_t size = end - start + 1;
+       size_t size = end - start;

        if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
                arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,

Thanks
Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
