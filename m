From: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page
	tables
Date: Wed, 21 Nov 2018 13:38:53 -0800
Message-ID: <20181121213853.GL3065@bombadil.infradead.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
	<0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000-p/GC64/jrecnJqMo6gzdpkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>
Cc: Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Levin Alexander <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Huaisheng Ye <yehs1-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mike Rapoport <rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pekka Enberg <penberg-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>, Mel Gorman <mgorman-3eNAlZScCAx27rWaFMvyedHuzzzSOjJt@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 21, 2018 at 06:20:02PM +0000, Christopher Lameter wrote:
> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
> 
> > This is a follow-up to the discussion in [1], to make sure that the page
> > tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > physical address space.
> 
> Page tables? This means you need a page frame? Why go through the slab
> allocators?

Because this particular architecture has sub-page-size PMD page tables.
We desperately need to hoist page table allocation out of the architectures;
there're a bunch of different implementations and they're mostly bad,
one way or another.

For each level of page table we generally have three cases:

1. single page
2. sub-page, naturally aligned
3. multiple pages, naturally aligned

for 1 and 3, the page allocator will do just fine.
for 2, we should have a per-MM page_frag allocator.  s390 already has
something like this, although it's more complicated.  ppc also has
something a little more complex for the cases when it's configured with
a 64k page size but wants to use a 4k page table entry.

I'd like x86 to be able to simply do:

#define pte_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pmd_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define pud_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)
#define p4d_alloc_one(mm, addr)	page_alloc_table(mm, addr, 0)

An architecture with 4k page size and needing a 16k PMD would do:

#define pmd_alloc_one(mm, addr) page_alloc_table(mm, addr, 2)

while an architecture with a 64k page size needing a 4k PTE would do:

#define ARCH_PAGE_TABLE_FRAG
#define pte_alloc_one(mm, addr) pagefrag_alloc_table(mm, addr, 4096)

I haven't had time to work on this, but perhaps someone with a problem
that needs fixing would like to, instead of burying yet another awful
implementation away in arch/ somewhere.
