From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 2/8] dma-debug: Expose nr_total_entries in debugfs
Date: Wed,  5 Dec 2018 19:56:51 +0000
Message-ID: <6740cfb143a084e8f5851b760bf99121a7ad6c67.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1544037783.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Expose nr_total_entries in debugfs, so that {num,min}_free_entries
become even more meaningful to users interested in current/maximum
utilisation. This becomes even more relevant once nr_total_entries
may change at runtime beyond just the existing AMD GART debug code.

Suggested-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New

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
