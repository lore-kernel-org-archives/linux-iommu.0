From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/5] memblock: introduce memblock_alloc_range()
Date: Tue, 15 Apr 2014 22:08:48 +0900
Message-ID: <1397567329-3771-5-git-send-email-akinobu.mita@gmail.com>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1397567329-3771-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This introduces memblock_alloc_range() which allocates memblock from
the specified range of physical address.  I would like to use this
function to specify the location of CMA.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
* Change from v2
- Rebased on current Linus tree

 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 8a20a51..c5a61d9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -221,6 +221,8 @@ static inline bool memblock_bottom_up(void) { return false; }
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
 
+phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
+					phys_addr_t start, phys_addr_t end);
 phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				phys_addr_t max_addr);
 phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
diff --git a/mm/memblock.c b/mm/memblock.c
index e9d6ca9..9a3bed0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -975,22 +975,35 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
-static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
-					phys_addr_t align, phys_addr_t max_addr,
-					int nid)
+static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+					phys_addr_t align, phys_addr_t start,
+					phys_addr_t end, int nid)
 {
 	phys_addr_t found;
 
 	if (!align)
 		align = SMP_CACHE_BYTES;
 
-	found = memblock_find_in_range_node(size, align, 0, max_addr, nid);
+	found = memblock_find_in_range_node(size, align, start, end, nid);
 	if (found && !memblock_reserve(found, size))
 		return found;
 
 	return 0;
 }
 
+phys_addr_t __init memblock_alloc_range(phys_addr_t size, phys_addr_t align,
+					phys_addr_t start, phys_addr_t end)
+{
+	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE);
+}
+
+static phys_addr_t __init memblock_alloc_base_nid(phys_addr_t size,
+					phys_addr_t align, phys_addr_t max_addr,
+					int nid)
+{
+	return memblock_alloc_range_nid(size, align, 0, max_addr, nid);
+}
+
 phys_addr_t __init memblock_alloc_nid(phys_addr_t size, phys_addr_t align, int nid)
 {
 	return memblock_alloc_base_nid(size, align, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
-- 
1.8.3.2
