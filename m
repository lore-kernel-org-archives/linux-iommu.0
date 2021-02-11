Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE38C433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 06:22:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C665964E77
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 06:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665964E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78ADE6F4E1
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 06:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUb--F2S6Wdz for <iommu@archiver.kernel.org>;
	Thu, 11 Feb 2021 06:22:10 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 391E46F4E4; Thu, 11 Feb 2021 06:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7A076F49E;
	Thu, 11 Feb 2021 06:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2F11C0174;
	Thu, 11 Feb 2021 06:22:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4394DC013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23B3D6F49E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HEDYghTJ8iA5 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:22:05 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 2C84D6F4E1; Thu, 11 Feb 2021 06:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C9596F49E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2AC411B3;
 Wed, 10 Feb 2021 22:22:02 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.253])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DAD7D3F73B;
 Wed, 10 Feb 2021 22:21:57 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, will@kernel.org
Subject: [PATCH 1/3] mm/page_alloc: Fix pageblock_order when
 HUGETLB_PAGE_ORDER >= MAX_ORDER
Date: Thu, 11 Feb 2021 11:52:09 +0530
Message-Id: <1613024531-19040-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

With HUGETLB_PAGE_SIZE_VARIABLE enabled, pageblock_order cannot be assigned
as HUGETLB_PAGE_ORDER when it is greater than or equal to MAX_ORDER during
set_pageblock_order(). Otherwise  the following warning is triggered during
boot as detected on an arm64 platform.

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

The above warning happens because pageblock_order exceeds MAX_ORDER, caused
by large HUGETLB_PAGE_ORDER on certain platforms like arm64. Lets prevent
the scenario by first checking HUGETLB_PAGE_ORDER against MAX_ORDER, before
its assignment as pageblock_order.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..36473f2fa683 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6798,7 +6798,7 @@ void __init set_pageblock_order(void)
 	if (pageblock_order)
 		return;
 
-	if (HPAGE_SHIFT > PAGE_SHIFT)
+	if ((HPAGE_SHIFT > PAGE_SHIFT) && (HUGETLB_PAGE_ORDER < MAX_ORDER))
 		order = HUGETLB_PAGE_ORDER;
 	else
 		order = MAX_ORDER - 1;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
