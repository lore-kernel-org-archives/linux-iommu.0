Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB88AC433EC
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:14:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0B122B47
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+RZG9Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0B122B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6612D228E7;
	Tue, 28 Jul 2020 05:14:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZlsn3hV3CgS; Tue, 28 Jul 2020 05:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 48A6920796;
	Tue, 28 Jul 2020 05:14:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337A0C0050;
	Tue, 28 Jul 2020 05:14:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 976FFC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 86733882CC
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UFER-Q0ouK-B for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2072E882C3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:32 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A319622B45;
 Tue, 28 Jul 2020 05:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595913272;
 bh=hFA2o8it4I/HXbe86IOHmF4tlkZa8gVYSY+0N3aJP/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M+RZG9ZnotcmsF2PkNa5zM/WFJM3ny9Ao4jVf4GZvFJO9XWUIy1uk0iFGD2FkFtN2
 /+/KrQiOLQR/E4QyReOgoyl9fI+gDphQS1WeTYk5sT9/kd5vjko1vVBIixO3xg+5dl
 6l0zbIn3ds2e3/BzAP/7In9EqpLZsIJvcvdKNYd8=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 14/15] x86/numa: remove redundant iteration over
 memblock.reserved
Date: Tue, 28 Jul 2020 08:11:52 +0300
Message-Id: <20200728051153.1590-15-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
MIME-Version: 1.0
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
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

From: Mike Rapoport <rppt@linux.ibm.com>

numa_clear_kernel_node_hotplug() function first traverses numa_meminfo
regions to set node ID in memblock.reserved and than traverses
memblock.reserved to update reserved_nodemask to include node IDs that were
set in the first loop.

Remove redundant traversal over memblock.reserved and update
reserved_nodemask while iterating over numa_meminfo.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/numa.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8ee952038c80..4078abd33938 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -498,31 +498,25 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	 * and use those ranges to set the nid in memblock.reserved.
 	 * This will split up the memblock regions along node
 	 * boundaries and will set the node IDs as well.
+	 *
+	 * The nid will also be set in reserved_nodemask which is later
+	 * used to clear MEMBLOCK_HOTPLUG flag.
+	 *
+	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
+	 *   numa_meminfo might not include all memblock.reserved
+	 *   memory ranges, because quirks such as trim_snb_memory()
+	 *   reserve specific pages for Sandy Bridge graphics.
+	 *   These ranges will remain with nid == MAX_NUMNODES. ]
 	 */
 	for (i = 0; i < numa_meminfo.nr_blks; i++) {
 		struct numa_memblk *mb = numa_meminfo.blk + i;
 		int ret;
 
 		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
+		node_set(mb->nid, reserved_nodemask);
 		WARN_ON_ONCE(ret);
 	}
 
-	/*
-	 * Now go over all reserved memblock regions, to construct a
-	 * node mask of all kernel reserved memory areas.
-	 *
-	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
-	 *   numa_meminfo might not include all memblock.reserved
-	 *   memory ranges, because quirks such as trim_snb_memory()
-	 *   reserve specific pages for Sandy Bridge graphics. ]
-	 */
-	for_each_memblock(reserved, mb_region) {
-		int nid = memblock_get_region_node(mb_region);
-
-		if (nid != MAX_NUMNODES)
-			node_set(nid, reserved_nodemask);
-	}
-
 	/*
 	 * Finally, clear the MEMBLOCK_HOTPLUG flag for all memory
 	 * belonging to the reserved node mask.
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
