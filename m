Return-Path: <SRS0=tWvy=SI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74CC10F06
	for <iommu@archiver.kernel.org>; Sat,  6 Apr 2019 06:41:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBB82186A
	for <iommu@archiver.kernel.org>; Sat,  6 Apr 2019 06:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBB82186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3D0672813;
	Sat,  6 Apr 2019 06:41:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5D156280F
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Apr 2019 06:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 28E8D4C3
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Apr 2019 06:40:47 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 745F3307CDCF;
	Sat,  6 Apr 2019 06:40:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F12060F87;
	Sat,  6 Apr 2019 06:40:45 +0000 (UTC)
Received: from zmail26.collab.prod.int.phx2.redhat.com
	(zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 303E31819AFD;
	Sat,  6 Apr 2019 06:40:40 +0000 (UTC)
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v9 00/13] Add support for eXclusive Page Frame
	Ownership
Message-Id: <80680B91-4EB8-4F23-B8CE-0156BC2C7DCA@redhat.com>
Date: Sat, 6 Apr 2019 02:40:39 -0400 (EDT)
References: <cover.1554248001.git.khalid.aziz@oracle.com>
To: Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <cover.1554248001.git.khalid.aziz@oracle.com>
Thread-Topic: Add support for eXclusive Page Frame Ownership
Thread-Index: 6OWDXOTXtuH6TAHWQlrXs03dvCq3eA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Sat, 06 Apr 2019 06:40:47 +0000 (UTC)
Cc: catalin.marinas@arm.com, will.deacon@arm.com, steven.sistare@oracle.com,
	hch@lst.de, tycho@tycho.ws, ak@linux.intel.com,
	aneesh.kumar@linux.ibm.com, jmorris@namei.org,
	rientjes@google.com, anthony.yznaga@oracle.com, riel@surriel.com,
	npiggin@gmail.com, rppt@linux.vnet.ibm.com, luto@kernel.org,
	tglx@linutronix.de, gregkh@linuxfoundation.org,
	rdunlap@infradead.org, linux-kernel@vger.kernel.org,
	jrdr.linux@gmail.com, jkosina@suse.cz, joe@perches.com,
	arunks@codeaurora.org, akpm@linux-foundation.org,
	dwmw@amazon.co.uk, mark.rutland@arm.com,
	linux-doc@vger.kernel.org, keith.busch@intel.com,
	joao.m.martins@oracle.com, hpa@zytor.com, brgl@bgdev.pl,
	konrad.wilk@oracle.com, jsteckli@amazon.de, jroedel@suse.de,
	keescook@google.com, zhangshaokun@hisilicon.com,
	boris.ostrovsky@oracle.com, chris.hyser@oracle.com,
	linux-arm-kernel@lists.infradead.org, khalid@gonehiking.org,
	aaron.lu@intel.com, steve.capper@arm.com, james.morse@arm.com,
	iamjoonsoo.kim@lge.com, mike.kravetz@oracle.com, mhocko@suse.cz,
	dave.hansen@intel.com, alexander.h.duyck@linux.intel.com,
	corbet@lwn.net, willy@infradead.org, khlebnikov@yandex-team.ru,
	kanth.ghatraju@oracle.com, ying.huang@intel.com,
	paulmck@linux.vnet.ibm.com, ben@decadent.org.uk,
	serge@hallyn.com, arnd@arndb.de, andreyknvl@google.com,
	rostedt@goodmis.org, bp@alien8.de, dan.j.williams@intel.com,
	osalvador@suse.de, ard.biesheuvel@linaro.org,
	iommu@lists.linux-foundation.org, andrew.cooper3@citrix.com,
	logang@deltatee.com, guro@fb.com,
	kirill.shutemov@linux.intel.com, mhocko@suse.com, mst@redhat.com,
	peterz@infradead.org, daniel.vetter@ffwll.ch,
	bigeasy@linutronix.de, amir73il@gmail.com, linux-mm@kvack.org,
	deepa.srinivasan@oracle.com, cpandya@codeaurora.org,
	x86@kernel.org, yaojun8558363@gmail.com, mingo@redhat.com,
	thymovanbeers@gmail.com, labbott@redhat.com,
	pradeep.vincent@oracle.com, pavel.tatashin@microsoft.com,
	jannh@google.com, vbabka@suse.cz, jmattson@google.com,
	jgross@suse.com, marco.antonio.780@gmail.com,
	yang.shi@linux.alibaba.com, juergh@gmail.com,
	mgorman@techsingularity.net, tyhicks@canonical.com,
	john.haxby@oracle.com, linux-security-module@vger.kernel.org,
	hannes@cmpxchg.org, liran.alon@oracle.com, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190406064039.IakwyEA6MqT28Tyb43bBbyJEGtq1Dqz9YInOTRIvL9Y@z>

Khalid,

Thanks for these patches. We will test them on x86 and investigate the Arm pieces highlighted.

Jon.

-- 
Computer Architect


> On Apr 4, 2019, at 00:37, Khalid Aziz <khalid.aziz@oracle.com> wrote:
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
