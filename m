From: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v9 00/13] Add support for eXclusive Page Frame
	Ownership
Date: Sat, 6 Apr 2019 02:40:39 -0400 (EDT)
Message-ID: <80680B91-4EB8-4F23-B8CE-0156BC2C7DCA@redhat.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org, aaron.l
List-Id: iommu@lists.linux-foundation.org

Khalid,

Thanks for these patches. We will test them on x86 and investigate the Arm pieces highlighted.

Jon.

-- 
Computer Architect


> On Apr 4, 2019, at 00:37, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> 
> This is another update to the work Juerg, Tycho and Julian have
> done on XPFO. After the last round of updates, we were seeing very
> significant performance penalties when stale TLB entries were
> flushed actively after an XPFO TLB update.  Benchmark for measuring
> performance is kernel build using parallel make. To get full
> protection from ret2dir attackes, we must flush stale TLB entries.
> Performance penalty from flushing stale TLB entries goes up as the
> number of cores goes up. On a desktop class machine with only 4
> cores, enabling TLB flush for stale entries causes system time for
> "make -j4" to go up by a factor of 2.61x but on a larger machine
> with 96 cores, system time with "make -j60" goes up by a factor of
> 26.37x!  I have been working on reducing this performance penalty.
> 
> I implemented two solutions to reduce performance penalty and that
> has had large impact. XPFO code flushes TLB every time a page is
> allocated to userspace. It does so by sending IPIs to all processors
> to flush TLB. Back to back allocations of pages to userspace on
> multiple processors results in a storm of IPIs.  Each one of these
> incoming IPIs is handled by a processor by flushing its TLB. To
> reduce this IPI storm, I have added a per CPU flag that can be set
> to tell a processor to flush its TLB. A processor checks this flag
> on every context switch. If the flag is set, it flushes its TLB and
> clears the flag. This allows for multiple TLB flush requests to a
> single CPU to be combined into a single request. A kernel TLB entry
> for a page that has been allocated to userspace is flushed on all
> processors unlike the previous version of this patch. A processor
> could hold a stale kernel TLB entry that was removed on another
> processor until the next context switch. A local userspace page
> allocation by the currently running process could force the TLB
> flush earlier for such entries.
> 
> The other solution reduces the number of TLB flushes required, by
> performing TLB flush for multiple pages at one time when pages are
> refilled on the per-cpu freelist. If the pages being addedd to
> per-cpu freelist are marked for userspace allocation, TLB entries
> for these pages can be flushed upfront and pages tagged as currently
> unmapped. When any such page is allocated to userspace, there is no
> need to performa a TLB flush at that time any more. This batching of
> TLB flushes reduces performance imapct further. Similarly when
> these user pages are freed by userspace and added back to per-cpu
> free list, they are left unmapped and tagged so. This further
> optimization reduced performance impact from 1.32x to 1.28x for
> 96-core server and from 1.31x to 1.27x for a 4-core desktop.
> 
> I measured system time for parallel make with unmodified 4.20
> kernel, 4.20 with XPFO patches before these patches and then again
> after applying each of these patches. Here are the results:
> 
> Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
> make -j60 all
> 
> 5.0                    913.862s
> 5.0+this patch series            1165.259ss    1.28x
> 
> 
> Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
> make -j4 all
> 
> 5.0                    610.642s
> 5.0+this patch series            773.075s    1.27x
> 
> Performance with this patch set is good enough to use these as
> starting point for further refinement before we merge it into main
> kernel, hence RFC.
> 
> I have restructurerd the patches in this version to separate out
> architecture independent code. I folded much of the code
> improvement by Julian to not use page extension into patch 3. 
> 
> What remains to be done beyond this patch series:
> 
> 1. Performance improvements: Ideas to explore - (1) kernel mappings
>   private to an mm, (2) Any others??
> 2. Re-evaluate the patch "arm64/mm: Add support for XPFO to swiotlb"
>   from Juerg. I dropped it for now since swiotlb code for ARM has
>   changed a lot since this patch was written. I could use help
>   from ARM experts on this.
> 3. Extend the patch "xpfo, mm: Defer TLB flushes for non-current
>   CPUs" to other architectures besides x86.
> 4. Change kmap to not map the page back to physmap, instead map it
>   to a new va similar to what kmap_high does. Mapping page back
>   into physmap re-opens the ret2dir security for the duration of
>   kmap. All of the kmap_high and related code can be reused for this
>   but that will require restructuring that code so it can be built for
>   64-bits as well. Any objections to that?
> 
> ---------------------------------------------------------
> 
> Juerg Haefliger (6):
>  mm: Add support for eXclusive Page Frame Ownership (XPFO)
>  xpfo, x86: Add support for XPFO for x86-64
>  lkdtm: Add test for XPFO
>  arm64/mm: Add support for XPFO
>  swiotlb: Map the buffer if it was unmapped by XPFO
>  arm64/mm, xpfo: temporarily map dcache regions
> 
> Julian Stecklina (1):
>  xpfo, mm: optimize spinlock usage in xpfo_kunmap
> 
> Khalid Aziz (2):
>  xpfo, mm: Defer TLB flushes for non-current CPUs (x86 only)
>  xpfo, mm: Optimize XPFO TLB flushes by batching them together
> 
> Tycho Andersen (4):
>  mm: add MAP_HUGETLB support to vm_mmap
>  x86: always set IF before oopsing from page fault
>  mm: add a user_virt_to_phys symbol
>  xpfo: add primitives for mapping underlying memory
> 
> .../admin-guide/kernel-parameters.txt         |   6 +
> arch/arm64/Kconfig                            |   1 +
> arch/arm64/mm/Makefile                        |   2 +
> arch/arm64/mm/flush.c                         |   7 +
> arch/arm64/mm/mmu.c                           |   2 +-
> arch/arm64/mm/xpfo.c                          |  66 ++++++
> arch/x86/Kconfig                              |   1 +
> arch/x86/include/asm/pgtable.h                |  26 +++
> arch/x86/include/asm/tlbflush.h               |   1 +
> arch/x86/mm/Makefile                          |   2 +
> arch/x86/mm/fault.c                           |   6 +
> arch/x86/mm/pageattr.c                        |  32 +--
> arch/x86/mm/tlb.c                             |  39 ++++
> arch/x86/mm/xpfo.c                            | 185 +++++++++++++++++
> drivers/misc/lkdtm/Makefile                   |   1 +
> drivers/misc/lkdtm/core.c                     |   3 +
> drivers/misc/lkdtm/lkdtm.h                    |   5 +
> drivers/misc/lkdtm/xpfo.c                     | 196 ++++++++++++++++++
> include/linux/highmem.h                       |  34 +--
> include/linux/mm.h                            |   2 +
> include/linux/mm_types.h                      |   8 +
> include/linux/page-flags.h                    |  23 +-
> include/linux/xpfo.h                          | 191 +++++++++++++++++
> include/trace/events/mmflags.h                |  10 +-
> kernel/dma/swiotlb.c                          |   3 +-
> mm/Makefile                                   |   1 +
> mm/compaction.c                               |   2 +-
> mm/internal.h                                 |   2 +-
> mm/mmap.c                                     |  19 +-
> mm/page_alloc.c                               |  19 +-
> mm/page_isolation.c                           |   2 +-
> mm/util.c                                     |  32 +++
> mm/xpfo.c                                     | 170 +++++++++++++++
> security/Kconfig                              |  27 +++
> 34 files changed, 1047 insertions(+), 79 deletions(-)
> create mode 100644 arch/arm64/mm/xpfo.c
> create mode 100644 arch/x86/mm/xpfo.c
> create mode 100644 drivers/misc/lkdtm/xpfo.c
> create mode 100644 include/linux/xpfo.h
> create mode 100644 mm/xpfo.c
> 
> -- 
> 2.17.1
> 
