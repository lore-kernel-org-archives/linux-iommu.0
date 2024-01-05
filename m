Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF469249F3
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w1fEcYHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF291C433C7;
	Fri,  5 Jan 2024 09:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446243;
	bh=00fdE9m57Sh2UCvCxnFwl+1/xGcKqUH2frMo3rQ9MYg=;
	h=Subject:To:From:Date:From;
	b=w1fEcYHRHN2Eutgi1ek2UCGsvLNdJWoUKeAyp/rfTpa0ydyHHeZBz+TZfwSFm8W6R
	 0XxI6ag1I9fMonWZhJjOpFY86Hi+QHNb+zm1XnaMh6LtcmIqAMeno7IUwE16fmTpNu
	 LUV4fETPZXAUC17YWI4QDXKlrGvR98lE7cXM3Tys=
Subject: patch "dma-debug: make dma_debug_add_bus take a const pointer" added to char-misc-next
To: gregkh@linuxfoundation.org,hch@lst.de,iommu@lists.linux.dev,m.szyprowski@samsung.com,robin.murphy@arm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:17:16 +0100
Message-ID: <2024010516-uproar-ice-ef26@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


