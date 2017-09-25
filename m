From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using
	COMPILE_TEST with LPAE
Date: Mon, 25 Sep 2017 17:37:46 +0200
Message-ID: <CAMuHMdVF0BWr_-5QxR3254dGhunPyfq-YLChO8CkCbGk_Oo02Q@mail.gmail.com>
References: <20170712171654.35DA922D7E@pdx-korg-gitolite-1.ci.codeaurora.org>
	<CAMuHMdVSR1fcDPgruPPDFAXQe_yVXHJFE-sCR3U8MNYOAUzfKQ@mail.gmail.com>
	<20170925152111.GB30917@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170925152111.GB30917-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Sep 25, 2017 at 5:21 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Mon, Sep 25, 2017 at 09:16:22AM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jul 12, 2017 at 7:16 PM, Linux Kernel Mailing List
>> <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> wrote:
>> > Web:        https://git.kernel.org/torvalds/c/c1004803b40596c1aabbbc78a6b1b33e4dfd96c6
>> > Commit:     c1004803b40596c1aabbbc78a6b1b33e4dfd96c6
>> > Parent:     58188afeb727e0f73706f1460707bd3ba6ccc221
>> > Refname:    refs/heads/master
>> > Author:     Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> > AuthorDate: Fri Jun 23 11:45:57 2017 +0100
>> > Committer:  Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> > CommitDate: Fri Jun 23 17:58:02 2017 +0100
>> >
>> >     iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST with LPAE
>> >
>> >     The LPAE/ARMv8 page table format relies on the ability to read and write
>> >     64-bit page table entries in an atomic fashion. With the move to a lockless
>> >     implementation, we also need support for cmpxchg64 to resolve races when
>> >     installing table entries concurrently.
>> >
>> >     Unfortunately, not all architectures support cmpxchg64, so the code can
>> >     fail to compiler when building for these architectures using COMPILE_TEST.
>> >     Rather than disable COMPILE_TEST altogether, instead check that
>> >     GENERIC_ATOMIC64 is not selected, which is a reasonable indication that
>> >     the architecture has support for 64-bit cmpxchg.
>> >
>> >     Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> >     Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> > ---
>> >  drivers/iommu/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> > index 6ee3a25ae731..c88cfa7522b2 100644
>> > --- a/drivers/iommu/Kconfig
>> > +++ b/drivers/iommu/Kconfig
>> > @@ -23,7 +23,7 @@ config IOMMU_IO_PGTABLE
>> >  config IOMMU_IO_PGTABLE_LPAE
>> >         bool "ARMv7/v8 Long Descriptor Format"
>> >         select IOMMU_IO_PGTABLE
>> > -       depends on HAS_DMA && (ARM || ARM64 || COMPILE_TEST)
>> > +       depends on HAS_DMA && (ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64))
>> >         help
>> >           Enable support for the ARM long descriptor pagetable format.
>> >           This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>>
>> I can't find where this patch was submitted and discussed, so I'm replying
>> to this email. On which architectures did it fail to compile?
>
> It was in response to a report from the kbuild test robot on m32r, but
> looking back I now see that it didn't go to the lists for some reason. I've
> included the report at the end of this email so you can have a look.

Thanks!

>> cmpxchg64() is defined by include/asm-generic/cmpxchg.h, so I fail to
>> see what's the relation with GENERIC_ATOMIC64, which is related to
>> lib/atomic64.c instead.
>
> Yeah, it's a bit of a hack, but we're basically relying on architectures
> that don't select GENERIC_ATOMIC64 providing their own cmpxchg64
> implementation, which seems to be the case.
>
>> E.g. on m68k, which uses GENERIC_ATOMIC64, it compile-tested fine before.
>
> FWIW, the lock-based atomics wouldn't be sufficient at runtime, but I
> appreciate that we're only talking about COMPILE_TEST here.

Correct.

>> Perhaps there's another (SMP vs UP?) dependency, as
>> include/asm-generic/cmpxchg.h cannot be used on SMP?
>> Should it be COMPILE_TEST && (!GENERIC_ATOMIC64 || !SMP)?
>
> I don't see how that helps. Are you seeing build failures on a non-SMP
> arch?

I'm not seeing build failures.
I see reduced build coverage on m68k due to this change.

So m32r fails to provide a definition for cmpxchg64(), which has nothing to
do with GENERIC_ATOMIC64.
Probably m32r just needs the same treatment as in commit feb20ec2bb859d1d
("m68k: Add missing cmpxchg64() if CONFIG_RMW_INSNS=y")

Worse, people are now adding more depends on !GENERIC_ATOMIC64 for
various IOMMU drivers, to fix up "selects IOMMU_IO_PGTABLE_LPAE which
has unmet direct dependencies" warnings :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
