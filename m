Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653AFC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:01:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E7D64F47
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 07:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E7D64F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DAAC8613E;
	Thu,  4 Feb 2021 07:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k2lE2LpIg8Df; Thu,  4 Feb 2021 07:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A55E286113;
	Thu,  4 Feb 2021 07:01:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7694FC08A1;
	Thu,  4 Feb 2021 07:01:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3D7EC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B8EFE86119
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HusjSjZdN9Uf for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 07:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 058F986113
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 07:01:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFED11FB;
 Wed,  3 Feb 2021 23:01:07 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 472063F694;
 Wed,  3 Feb 2021 23:01:04 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org
Subject: [RFC 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
Date: Thu,  4 Feb 2021 12:31:21 +0530
Message-Id: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The following warning gets triggered while trying to boot a 64K page size
without THP config kernel on arm64 platform.

WARNING: CPU: 5 PID: 124 at mm/vmstat.c:1080 __fragmentation_index+0xa4/0xc0
Modules linked in:
CPU: 5 PID: 124 Comm: kswapd0 Not tainted 5.11.0-rc6-00004-ga0ea7d62002 #159
Hardware name: linux,dummy-virt (DT)
[    8.810673] pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
[    8.811732] pc : __fragmentation_index+0xa4/0xc0
[    8.812555] lr : fragmentation_index+0xf8/0x138
[    8.813360] sp : ffff0000864079b0
[    8.813958] x29: ffff0000864079b0 x28: 0000000000000372
[    8.814901] x27: 0000000000007682 x26: ffff8000135b3948
[    8.815847] x25: 1fffe00010c80f48 x24: 0000000000000000
[    8.816805] x23: 0000000000000000 x22: 000000000000000d
[    8.817764] x21: 0000000000000030 x20: ffff0005ffcb4d58
[    8.818712] x19: 000000000000000b x18: 0000000000000000
[    8.819656] x17: 0000000000000000 x16: 0000000000000000
[    8.820613] x15: 0000000000000000 x14: ffff8000114c6258
[    8.821560] x13: ffff6000bff969ba x12: 1fffe000bff969b9
[    8.822514] x11: 1fffe000bff969b9 x10: ffff6000bff969b9
[    8.823461] x9 : dfff800000000000 x8 : ffff0005ffcb4dcf
[    8.824415] x7 : 0000000000000001 x6 : 0000000041b58ab3
[    8.825359] x5 : ffff600010c80f48 x4 : dfff800000000000
[    8.826313] x3 : ffff8000102be670 x2 : 0000000000000007
[    8.827259] x1 : ffff000086407a60 x0 : 000000000000000d
[    8.828218] Call trace:
[    8.828667]  __fragmentation_index+0xa4/0xc0
[    8.829436]  fragmentation_index+0xf8/0x138
[    8.830194]  compaction_suitable+0x98/0xb8
[    8.830934]  wakeup_kcompactd+0xdc/0x128
[    8.831640]  balance_pgdat+0x71c/0x7a0
[    8.832327]  kswapd+0x31c/0x520
[    8.832902]  kthread+0x224/0x230
[    8.833491]  ret_from_fork+0x10/0x30
[    8.834150] ---[ end trace 472836f79c15516b ]---

This warning comes from __fragmentation_index() when the requested order
is greater than MAX_ORDER.

static int __fragmentation_index(unsigned int order,
				 struct contig_page_info *info)
{
        unsigned long requested = 1UL << order;

        if (WARN_ON_ONCE(order >= MAX_ORDER)) <===== Triggered here
                return 0;

Digging it further reveals that pageblock_order has been assigned a value
which is greater than MAX_ORDER failing the above check. But why this
happened ? Because HUGETLB_PAGE_ORDER for the given config on arm64 is
greater than MAX_ORDER.

The solution involves enabling HUGETLB_PAGE_SIZE_VARIABLE which would make
pageblock_order a variable instead of constant HUGETLB_PAGE_ORDER. But that
change alone also did not really work as pageblock_order still got assigned
as HUGETLB_PAGE_ORDER in set_pageblock_order(). HUGETLB_PAGE_ORDER needs to
be less than MAX_ORDER for its appropriateness as pageblock_order otherwise
just fallback to MAX_ORDER - 1 as before. While here it also fixes a build
problem via type casting MAX_ORDER in rmem_cma_setup().

This series applies in v5.11-rc6 and has been slightly tested on arm64. But
looking for some early feedbacks particularly with respect to concerns in
subscribing HUGETLB_PAGE_SIZE_VARIABLE on a platform where the hugetlb page
size is config dependent but not really a runtime variable. Even though it
appears that HUGETLB_PAGE_SIZE_VARIABLE is used only while computing the
pageblock_order, could there be other implications ?

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  mm/page_alloc: Fix pageblock_order when HUGETLB_PAGE_ORDER >= MAX_ORDER
  arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
  dma-contiguous: Type cast MAX_ORDER as unsigned int

 arch/arm64/Kconfig      | 4 ++++
 kernel/dma/contiguous.c | 2 +-
 mm/page_alloc.c         | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
