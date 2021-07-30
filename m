Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC912C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 11:42:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DC661052
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 11:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53DC661052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 130614062B;
	Fri, 30 Jul 2021 11:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l91dPGXoX8B4; Fri, 30 Jul 2021 11:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2A2840607;
	Fri, 30 Jul 2021 11:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFF3BC001A;
	Fri, 30 Jul 2021 11:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F211EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 11:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E894F83A5F
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 11:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPfMVfMQxi8N for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 11:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F2EC82DE6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 11:42:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA0B56103B;
 Fri, 30 Jul 2021 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627645357;
 bh=nRa9TJJxTAW4vDwwhA6VyorL4FVC9dzFn9iKflCLVG4=;
 h=From:To:Cc:Subject:Date:From;
 b=AX4PmDXFu2OLhlDawWaxLNHParYoTGmSJs27Idg5FL5pTfeInPD7rwiKgXxtrPeI+
 YnwXvpvboeOTSnmX/9f+mJ3pK9gkCHjGs1oOX1FEqc/IlpAEENMFlPxjozGkEsqeRe
 +SJcWyl4yBDUBIX9BWRzNcVNNGHxZAwrWROd3Slwwzk9h7ai3tQmQ+Rw3tJslJOoEA
 JDxgIz+qYcifZf5UFEZ2HUVKcEEErOFWHEP3BSmqPcUWWS0MWvPMPstHVDuFBYfJrV
 n3N3cwwEGzSKSNAO4b1VbXellnqtPpwftg22Q3+Z80kzZ2DcYa8RZJu3CXAzO/vKm4
 W5of3aDkiQuZQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
Date: Fri, 30 Jul 2021 12:42:31 +0100
Message-Id: <20210730114231.23445-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linuxppc-dev@lists.ozlabs.org,
 Robin Murphy <robin.murphy@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, Will Deacon <will@kernel.org>,
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

Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
introduced a set_memory_encrypted() call to swiotlb_exit() so that the
buffer pages are returned to an encrypted state prior to being freed.

Sachin reports that this leads to the following crash on a Power server:

[    0.010799] software IO TLB: tearing down default memory pool
[    0.010805] ------------[ cut here ]------------
[    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!

Nick spotted that this is because set_memory_encrypted() is issuing an
ultracall which doesn't exist for the processor, and should therefore
be gated by mem_encrypt_active() to mirror the x86 implementation.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/powerpc/platforms/pseries/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 1d829e257996..87f001b4c4e4 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
@@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
+	if (!mem_encrypt_active())
+		return 0;
+
 	if (!PAGE_ALIGNED(addr))
 		return -EINVAL;
 
-- 
2.32.0.554.ge1b32706d8-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
