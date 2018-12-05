From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
Date: Wed, 5 Dec 2018 12:18:07 +0000
Message-ID: <20181205121807.evmslrimsv4pdtza@master>
References: <20181205054828.183476-1-drinkcat@chromium.org>
	<20181205054828.183476-3-drinkcat@chromium.org>
	<20181205072528.l7blg6y24ggblh4m@master>
	<CANMq1KCi-k_4-66pMfvByzsjpf1H6_bvC82Ow0b_jEH6B3LHwA@mail.gmail.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KCi-k_4-66pMfvByzsjpf1H6_bvC82Ow0b_jEH6B3LHwA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Christoph Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 03:39:51PM +0800, Nicolas Boichat wrote:
>On Wed, Dec 5, 2018 at 3:25 PM Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> On Wed, Dec 05, 2018 at 01:48:27PM +0800, Nicolas Boichat wrote:
>> >In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
>> >data structures smaller than a page with GFP_DMA32 flag.
>> >
>> >This change makes it possible to create a custom cache in DMA32 zone
>> >using kmem_cache_create, then allocate memory using kmem_cache_alloc.
>> >
>> >We do not create a DMA32 kmalloc cache array, as there are currently
>> >no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
>> >ensures that such calls still fail (as they do before this change).
>> >
>> >Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
>> >Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> >---
>> >
>> >Changes since v2:
>> > - Clarified commit message
>> > - Add entry in sysfs-kernel-slab to document the new sysfs file
>> >
>> >(v3 used the page_frag approach)
>> >
>> >Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
>> > include/linux/slab.h                        |  2 ++
>> > mm/internal.h                               |  8 ++++++--
>> > mm/slab.c                                   |  4 +++-
>> > mm/slab.h                                   |  3 ++-
>> > mm/slab_common.c                            |  2 +-
>> > mm/slub.c                                   | 18 +++++++++++++++++-
>> > 7 files changed, 40 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
>> >index 29601d93a1c2ea..d742c6cfdffbe9 100644
>> >--- a/Documentation/ABI/testing/sysfs-kernel-slab
>> >+++ b/Documentation/ABI/testing/sysfs-kernel-slab
>> >@@ -106,6 +106,15 @@ Description:
>> >               are from ZONE_DMA.
>> >               Available when CONFIG_ZONE_DMA is enabled.
>> >
>> >+What:         /sys/kernel/slab/cache/cache_dma32
>> >+Date:         December 2018
>> >+KernelVersion:        4.21
>> >+Contact:      Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> >+Description:
>> >+              The cache_dma32 file is read-only and specifies whether objects
>> >+              are from ZONE_DMA32.
>> >+              Available when CONFIG_ZONE_DMA32 is enabled.
>> >+
>> > What:         /sys/kernel/slab/cache/cpu_slabs
>> > Date:         May 2007
>> > KernelVersion:        2.6.22
>> >diff --git a/include/linux/slab.h b/include/linux/slab.h
>> >index 11b45f7ae4057c..9449b19c5f107a 100644
>> >--- a/include/linux/slab.h
>> >+++ b/include/linux/slab.h
>> >@@ -32,6 +32,8 @@
>> > #define SLAB_HWCACHE_ALIGN    ((slab_flags_t __force)0x00002000U)
>> > /* Use GFP_DMA memory */
>> > #define SLAB_CACHE_DMA                ((slab_flags_t __force)0x00004000U)
>> >+/* Use GFP_DMA32 memory */
>> >+#define SLAB_CACHE_DMA32      ((slab_flags_t __force)0x00008000U)
>> > /* DEBUG: Store the last owner for bug hunting */
>> > #define SLAB_STORE_USER               ((slab_flags_t __force)0x00010000U)
>> > /* Panic if kmem_cache_create() fails */
>> >diff --git a/mm/internal.h b/mm/internal.h
>> >index a2ee82a0cd44ae..fd244ad716eaf8 100644
>> >--- a/mm/internal.h
>> >+++ b/mm/internal.h
>> >@@ -14,6 +14,7 @@
>> > #include <linux/fs.h>
>> > #include <linux/mm.h>
>> > #include <linux/pagemap.h>
>> >+#include <linux/slab.h>
>> > #include <linux/tracepoint-defs.h>
>> >
>> > /*
>> >@@ -34,9 +35,12 @@
>> > #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
>> >
>> > /* Check for flags that must not be used with a slab allocator */
>> >-static inline gfp_t check_slab_flags(gfp_t flags)
>> >+static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
>> > {
>> >-      gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>> >+      gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>> >+
>> >+      if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
>> >+              bug_mask |= __GFP_DMA32;
>>
>> The original version doesn't check CONFIG_ZONE_DMA32.
>>
>> Do we need to add this condition here?
>> Could we just decide the bug_mask based on slab_flags?
>
>We can. The reason I did it this way is that when we don't have
>CONFIG_ZONE_DMA32, the compiler should be able to simplify to:
>
>bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
>if (true || ..) => if (true)
>   bug_mask |= __GFP_DMA32;
>
>Then just
>bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK | __GFP_DMA32;
>
>And since the function is inline, slab_flags would not even need to be
>accessed at all.
>

Hmm, I get one confusion.

This means if CONFIG_ZONE_DMA32 is not enabled, bug_mask will always
contains __GFP_DMA32. This will check with cachep->flags.

If cachep->flags has GFP_DMA32, this always fail?

Is this possible?

-- 
Wei Yang
Help you, Help me
