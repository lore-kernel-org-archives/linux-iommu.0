From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 4/7] dma-debug: Make leak-like behaviour apparent
Date: Mon, 10 Dec 2018 14:00:30 +0000
Message-ID: <22f6c17167b7270226d30dcd320eaff656a98bd4.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Now that we can dynamically allocate DMA debug entries to cope with
drivers maintaining excessively large numbers of live mappings, a driver
which *does* actually have a bug leaking mappings (and is not unloaded)
will no longer trigger the "DMA-API: debugging out of memory - disabling"
message until it gets to actual kernel OOM conditions, which means it
could go unnoticed for a while. To that end, let's inform the user each
time the pool has grown to a multiple of its initial size, which should
make it apparent that they either have a leak or might want to increase
the preallocation size.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 Documentation/DMA-API.txt |  6 +++++-
 kernel/dma/debug.c        | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 0fcb7561af1e..7a7d8a415ce8 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -747,7 +747,11 @@ driver afterwards. This filter can be disabled or changed later using debugfs.
 When the code disables itself at runtime this is most likely because it ran
 out of dma_debug_entries and was unable to allocate more on-demand. 65536
 entries are preallocated at boot - if this is too low for you boot with
-'dma_debug_entries=<your_desired_number>' to overwrite the default.
+'dma_debug_entries=<your_desired_number>' to overwrite the default. The
+code will print to the kernel log each time it has dynamically allocated
+as many entries as were initially preallocated. This is to indicate that a
+larger preallocation size may be appropriate, or if it happens continually
+that a driver may be leaking mappings.
 
 ::
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index ef7c90b7a346..912c23f4c177 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -691,6 +691,18 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
+void __dma_entry_alloc_check_leak(void)
+{
+	u32 tmp = nr_total_entries % nr_prealloc_entries;
+
+	/* Shout each time we tick over some multiple of the initial pool */
+	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
+		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
+			nr_total_entries,
+			(nr_total_entries / nr_prealloc_entries));
+	}
+}
+
 /* struct dma_entry allocator
  *
  * The next two functions implement the allocator for
@@ -710,6 +722,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
+		__dma_entry_alloc_check_leak();
 	}
 
 	entry = __dma_entry_alloc();
-- 
2.19.1.dirty
