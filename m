From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using
	COMPILE_TEST with LPAE
Date: Mon, 25 Sep 2017 16:21:11 +0100
Message-ID: <20170925152111.GB30917@arm.com>
References: <20170712171654.35DA922D7E@pdx-korg-gitolite-1.ci.codeaurora.org>
	<CAMuHMdVSR1fcDPgruPPDFAXQe_yVXHJFE-sCR3U8MNYOAUzfKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVSR1fcDPgruPPDFAXQe_yVXHJFE-sCR3U8MNYOAUzfKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Mon, Sep 25, 2017 at 09:16:22AM +0200, Geert Uytterhoeven wrote:
> On Wed, Jul 12, 2017 at 7:16 PM, Linux Kernel Mailing List
> <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> wrote:
> > Web:        https://git.kernel.org/torvalds/c/c1004803b40596c1aabbbc78a6b1b33e4dfd96c6
> > Commit:     c1004803b40596c1aabbbc78a6b1b33e4dfd96c6
> > Parent:     58188afeb727e0f73706f1460707bd3ba6ccc221
> > Refname:    refs/heads/master
> > Author:     Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > AuthorDate: Fri Jun 23 11:45:57 2017 +0100
> > Committer:  Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > CommitDate: Fri Jun 23 17:58:02 2017 +0100
> >
> >     iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST with LPAE
> >
> >     The LPAE/ARMv8 page table format relies on the ability to read and write
> >     64-bit page table entries in an atomic fashion. With the move to a lockless
> >     implementation, we also need support for cmpxchg64 to resolve races when
> >     installing table entries concurrently.
> >
> >     Unfortunately, not all architectures support cmpxchg64, so the code can
> >     fail to compiler when building for these architectures using COMPILE_TEST.
> >     Rather than disable COMPILE_TEST altogether, instead check that
> >     GENERIC_ATOMIC64 is not selected, which is a reasonable indication that
> >     the architecture has support for 64-bit cmpxchg.
> >
> >     Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >     Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 6ee3a25ae731..c88cfa7522b2 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -23,7 +23,7 @@ config IOMMU_IO_PGTABLE
> >  config IOMMU_IO_PGTABLE_LPAE
> >         bool "ARMv7/v8 Long Descriptor Format"
> >         select IOMMU_IO_PGTABLE
> > -       depends on HAS_DMA && (ARM || ARM64 || COMPILE_TEST)
> > +       depends on HAS_DMA && (ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64))
> >         help
> >           Enable support for the ARM long descriptor pagetable format.
> >           This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> 
> I can't find where this patch was submitted and discussed, so I'm replying
> to this email. On which architectures did it fail to compile?

It was in response to a report from the kbuild test robot on m32r, but
looking back I now see that it didn't go to the lists for some reason. I've
included the report at the end of this email so you can have a look.

> cmpxchg64() is defined by include/asm-generic/cmpxchg.h, so I fail to
> see what's the relation with GENERIC_ATOMIC64, which is related to
> lib/atomic64.c instead.

Yeah, it's a bit of a hack, but we're basically relying on architectures
that don't select GENERIC_ATOMIC64 providing their own cmpxchg64
implementation, which seems to be the case.

> E.g. on m68k, which uses GENERIC_ATOMIC64, it compile-tested fine before.

FWIW, the lock-based atomics wouldn't be sufficient at runtime, but I
appreciate that we're only talking about COMPILE_TEST here.

> Perhaps there's another (SMP vs UP?) dependency, as
> include/asm-generic/cmpxchg.h cannot be used on SMP?
> Should it be COMPILE_TEST && (!GENERIC_ATOMIC64 || !SMP)?

I don't see how that helps. Are you seeing build failures on a non-SMP
arch?

Will

--->8

>From fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org Fri Jun 23 07:06:26 2017
Date: Fri, 23 Jun 2017 14:05:19 +0800
From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
CC: kbuild-all-JC7UmRfGjtg@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [arm-perf:for-joerg/arm-smmu/updates 10/13]
 include/linux/atomic.h:475:29: error: implicit declaration of function
 'cmpxchg64'
User-Agent: Mutt/1.5.23 (2014-03-12)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Status: RO
X-Status: A

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates
head:   5723c883174667dab5c42cbefa8d4d0e9acc16bc
commit: a22753392d403aba096a3b10b2bc6ed721a2eb8f [10/13] iommu/io-pgtable-arm: Support lockless operation
config: m32r-allyesconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a22753392d403aba096a3b10b2bc6ed721a2eb8f
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/iommu/io-pgtable-arm.c:23:0:
   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>> include/linux/atomic.h:475:29: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]
    #define  cmpxchg64_relaxed  cmpxchg64
                                ^
>> drivers/iommu/io-pgtable-arm.c:337:8: note: in expansion of macro 'cmpxchg64_relaxed'
     old = cmpxchg64_relaxed(ptep, curr, new);
           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers//iommu/io-pgtable-arm.c:23:0:
   drivers//iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>> include/linux/atomic.h:475:29: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]
    #define  cmpxchg64_relaxed  cmpxchg64
                                ^
   drivers//iommu/io-pgtable-arm.c:337:8: note: in expansion of macro 'cmpxchg64_relaxed'
     old = cmpxchg64_relaxed(ptep, curr, new);
           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/cmpxchg64 +475 include/linux/atomic.h

654672d4 Will Deacon 2015-08-06  469  	__atomic_op_fence(cmpxchg, __VA_ARGS__)
654672d4 Will Deacon 2015-08-06  470  #endif
654672d4 Will Deacon 2015-08-06  471  #endif /* cmpxchg_relaxed */
654672d4 Will Deacon 2015-08-06  472  
654672d4 Will Deacon 2015-08-06  473  /* cmpxchg64_relaxed */
654672d4 Will Deacon 2015-08-06  474  #ifndef cmpxchg64_relaxed
654672d4 Will Deacon 2015-08-06 @475  #define  cmpxchg64_relaxed		cmpxchg64
654672d4 Will Deacon 2015-08-06  476  #define  cmpxchg64_acquire		cmpxchg64
654672d4 Will Deacon 2015-08-06  477  #define  cmpxchg64_release		cmpxchg64
654672d4 Will Deacon 2015-08-06  478  

:::::: The code at line 475 was first introduced by commit
:::::: 654672d4ba1a6001c365833be895f9477c4d5eab locking/atomics: Add _{acquire|release|relaxed}() variants of some atomic operations

:::::: TO: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
:::::: CC: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
