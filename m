Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BA224CE
	for <iommu@lists.linux.dev>; Thu,  4 Jan 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwLwQETN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0162C433C7;
	Thu,  4 Jan 2024 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704375567;
	bh=Dlkll0N4kYE4e7WXG4C9bd7mZuSorr5IQIupO60SeFg=;
	h=Subject:To:From:Date:From;
	b=VwLwQETNWXW/OoS91l4xuZP17x8ke3WtXKFTY9FZfOzo+KoeQIqmFXxOiZdhiVu5u
	 /zDDnmNP7swfyJXDc6M4+KCKW2yRxb0xIuUhSF0ozwbYpDFt6/Y0ain6Shtcp6KIEq
	 WLGc43jyBPmXJPmyTLP8ivRdAphPNVFqPTkFiZD8=
Subject: patch "dma-debug: make dma_debug_add_bus take a const pointer" added to char-misc-testing
To: gregkh@linuxfoundation.org,hch@lst.de,iommu@lists.linux.dev,m.szyprowski@samsung.com,robin.murphy@arm.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 14:39:24 +0100
Message-ID: <2024010424-spoof-lifting-7702@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    dma-debug: make dma_debug_add_bus take a const pointer

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 86438841e48f6361f0a6a04805b7d7813738761f Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 14:41:42 +0100
Subject: dma-debug: make dma_debug_add_bus take a const pointer

The driver core now can handle a const struct bus_type pointer, and the
dma_debug_add_bus() call just passes on the pointer give to it to the
driver core, so make this pointer const as well to allow everyone to use
read-only struct bus_type pointers going forward.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc:  <iommu@lists.linux.dev>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/2023121941-dejected-nugget-681e@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/dma-map-ops.h | 4 ++--
 kernel/dma/debug.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..e401f824a007 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -443,10 +443,10 @@ static inline void arch_teardown_dma_ops(struct device *dev)
 #endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
 
 #ifdef CONFIG_DMA_API_DEBUG
-void dma_debug_add_bus(struct bus_type *bus);
+void dma_debug_add_bus(const struct bus_type *bus);
 void debug_dma_dump_mappings(struct device *dev);
 #else
-static inline void dma_debug_add_bus(struct bus_type *bus)
+static inline void dma_debug_add_bus(const struct bus_type *bus)
 {
 }
 static inline void debug_dma_dump_mappings(struct device *dev)
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3de494375b7b..1a5c86dd87d5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -876,7 +876,7 @@ static int dma_debug_device_change(struct notifier_block *nb, unsigned long acti
 	return 0;
 }
 
-void dma_debug_add_bus(struct bus_type *bus)
+void dma_debug_add_bus(const struct bus_type *bus)
 {
 	struct notifier_block *nb;
 
-- 
2.43.0


