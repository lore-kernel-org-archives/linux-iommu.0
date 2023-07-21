Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D127F2C
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 15:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2FC433C8;
	Fri, 21 Jul 2023 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689953065;
	bh=4vyHB7EQZwg9omt+p08A1Wl1SFkgzANAN3Bd2PvcyGc=;
	h=Subject:To:Cc:From:Date:From;
	b=0qIqyuOQT7JHR6TijddYsC2EQvZRjc4cy1pl0byJLP9bDZdXLzdlrG2nvLw+niZ0z
	 e0YooGyitCYtfj6ZAytaj71xVtjvC5gzvPS0ydHI70FnFRTj/7rnVoCw1UR1KHE+GL
	 4QQgR8YH1mXn+NnkHQnxQNEBGdi/qXZ3DjHliwjA=
Subject: Patch "swiotlb: mark swiotlb_memblock_alloc() as __init" has been added to the 6.1-stable tree
To: aik@amd.com,gregkh@linuxfoundation.org,hch@lst.de,iommu@lists.linux.dev,linux-mm@kvack.org,rdunlap@infradead.org,rppt@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Jul 2023 17:24:14 +0200
Message-ID: <2023072114-umpire-ruined-a924@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    swiotlb: mark swiotlb_memblock_alloc() as __init

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     swiotlb-mark-swiotlb_memblock_alloc-as-__init.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 9b07d27d0fbb7f7441aa986859a0f53ec93a0335 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 21 Feb 2023 23:04:11 -0800
Subject: swiotlb: mark swiotlb_memblock_alloc() as __init

From: Randy Dunlap <rdunlap@infradead.org>

commit 9b07d27d0fbb7f7441aa986859a0f53ec93a0335 upstream.

swiotlb_memblock_alloc() calls memblock_alloc(), which calls
(__init) memblock_alloc_try_nid(). However, swiotlb_membloc_alloc()
can be marked as __init since it is only called by swiotlb_init_remap(),
which is already marked as __init. This prevents a modpost build
warning/error:

WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: swiotlb_memblock_alloc (section: .text) -> memblock_alloc_try_nid (section: .init.text)

This fixes the build warning/error seen on ARM64, PPC64, S390, i386,
and x86_64.

Fixes: 8d58aa484920 ("swiotlb: reduce the swiotlb buffer size on allocation failure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/dma/swiotlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -324,7 +324,8 @@ static void swiotlb_init_io_tlb_mem(stru
 	return;
 }
 
-static void *swiotlb_memblock_alloc(unsigned long nslabs, unsigned int flags,
+static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
+		unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
 	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);


Patches currently in stable-queue which might be from rdunlap@infradead.org are

queue-6.1/swiotlb-mark-swiotlb_memblock_alloc-as-__init.patch
queue-6.1/wifi-airo-avoid-uninitialized-warning-in-airo_get_ra.patch
queue-6.1/scsi-ufs-ufs-mediatek-add-dependency-for-reset_contr.patch
