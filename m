Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AB5C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 05:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF804408ED;
	Mon,  4 Apr 2022 05:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIhb1GkVD-6d; Mon,  4 Apr 2022 05:06:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB54C408EB;
	Mon,  4 Apr 2022 05:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1374C002C;
	Mon,  4 Apr 2022 05:06:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B90C6C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1A8F82C21
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hj9vZ9M70IEb for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 05:06:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A4E882BC3
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 05:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=VlHGJyMm9vzjIewl+QL3o4DmXNPqBE0xLUE3ejLiJgA=; b=VvTajNYxlVH8VM8PJFY0XdrnDE
 PYMemX1VnGoK/6lMerwGvFWsXR63qtldaV9JNnljEtSNzVgnoja0hj0U4yTVPJciulZJmTsOI3InN
 9hUlVc62KvnpHo9FcY7S2qTjaXiVY8On07Etkgs7y+Zf1tacU/1T/jDeLWMfoNw99mUlitJW6j7sp
 sR3bgvz3cSLVxwfkpBzV25UYIr9nlpUkxvMpGAkcr7rxsGfZ9bUZedEDez4l3//tIzUMxcmnj07eu
 vbRPdl2Gx79fwX5yqj6ntMFxO89PZnRv3tx/aIDni2kH+augWjt6yLz05Y4QJbSg/3+OhHwoek82/
 unMzf8FA==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbEvG-00D95w-SQ; Mon, 04 Apr 2022 05:06:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 08/15] x86: centralize setting SWIOTLB_FORCE when guest memory
 encryption is enabled
Date: Mon,  4 Apr 2022 07:05:52 +0200
Message-Id: <20220404050559.132378-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404050559.132378-1-hch@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

Move enabling SWIOTLB_FORCE for guest memory encryption into common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/cpu/mshyperv.c | 8 --------
 arch/x86/kernel/pci-dma.c      | 8 ++++++++
 arch/x86/mm/mem_encrypt_amd.c  | 3 ---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4b67094215bba..5b8f2c3571601 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -337,14 +337,6 @@ static void __init ms_hyperv_init_platform(void)
 			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
 #endif
 		}
-
-#ifdef CONFIG_SWIOTLB
-		/*
-		 * Enable swiotlb force mode in Isolation VM to
-		 * use swiotlb bounce buffer for dma transaction.
-		 */
-		swiotlb_force = SWIOTLB_FORCE;
-#endif
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index df96926421be0..04140e20ef1a3 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -53,6 +53,14 @@ static void __init pci_swiotlb_detect(void)
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		x86_swiotlb_enable = true;
 
+	/*
+	 * Guest with guest memory encryption currently perform all DMA through
+	 * bounce buffers as the hypervisor can't access arbitrary VM memory
+	 * that is not explicitly shared with it.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		swiotlb_force = SWIOTLB_FORCE;
+
 	if (swiotlb_force == SWIOTLB_FORCE)
 		x86_swiotlb_enable = true;
 }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6169053c28541..d732d727d3dee 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -432,9 +432,6 @@ void __init sme_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		swiotlb_force = SWIOTLB_FORCE;
-
 	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
