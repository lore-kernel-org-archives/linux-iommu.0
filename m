From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 2/7] dma-debug: Expose nr_total_entries in debugfs
Date: Mon, 10 Dec 2018 14:00:28 +0000
Message-ID: <06146c16a9c9af8b363d9e5faa73e9952b4f0865.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Expose nr_total_entries in debugfs, so that {num,min}_free_entries
become even more meaningful to users interested in current/maximum
utilisation. This becomes even more relevant once nr_total_entries
may change at runtime beyond just the existing AMD GART debug code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 Documentation/DMA-API.txt | 3 +++
 kernel/dma/debug.c        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index ac66ae2509a9..6bdb095393b0 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -723,6 +723,9 @@ dma-api/min_free_entries	This read-only file can be read to get the
 dma-api/num_free_entries	The current number of free dma_debug_entries
 				in the allocator.
 
+dma-api/nr_total_entries	The total number of dma_debug_entries in the
+				allocator, both free and used.
+
 dma-api/driver-filter		You can write a name of a driver into this file
 				to limit the debug output to requests from that
 				particular driver. Write an empty string to
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 91b84140e4a5..29486eb9d1dc 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -144,6 +144,7 @@ static struct dentry *show_all_errors_dent  __read_mostly;
 static struct dentry *show_num_errors_dent  __read_mostly;
 static struct dentry *num_free_entries_dent __read_mostly;
 static struct dentry *min_free_entries_dent __read_mostly;
+static struct dentry *nr_total_entries_dent __read_mostly;
 static struct dentry *filter_dent           __read_mostly;
 
 /* per-driver filter related state */
@@ -928,6 +929,12 @@ static int dma_debug_fs_init(void)
 	if (!min_free_entries_dent)
 		goto out_err;
 
+	nr_total_entries_dent = debugfs_create_u32("nr_total_entries", 0444,
+			dma_debug_dent,
+			&nr_total_entries);
+	if (!nr_total_entries_dent)
+		goto out_err;
+
 	filter_dent = debugfs_create_file("driver_filter", 0644,
 					  dma_debug_dent, NULL, &filter_fops);
 	if (!filter_dent)
-- 
2.19.1.dirty
