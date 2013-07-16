From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v7 00/12] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Tue, 16 Jul 2013 22:05:10 +0900
Message-ID: <002001ce8225$1a844540$4f8ccfc0$@samsung.com>
References: <002801ce797b$3d2fbc80$b78f3580$@samsung.com>
	<CANEJEGvajhgzUPG6ppbjwBb4-9TdU9em3T_SejBpz8NCjGHYTQ@mail.gmail.com>
	<00a701ce8155$be139240$3a3ab6c0$@samsung.com>
	<CANEJEGu0VJdFZmS800EKRSH0GXLGomC973BON7Vtr1qjjqi_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CANEJEGu0VJdFZmS800EKRSH0GXLGomC973BON7Vtr1qjjqi_nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Doug Anderson' <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org [mailto:grundler-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org] On Behalf Of Grant Grundler
> Sent: Tuesday, July 16, 2013 12:56 AM
> 
> On Mon, Jul 15, 2013 at 5:20 AM, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> ...
> >> > Cho,
> >> > Of the above patches, nearly all have been applied to chromeos-3.8
> >> > (kernel-next git tree) by Doug Anderson and others.
> >> >
> >> > AFAICT, the only ones not applied are:
> >> >    [v7,3/9] iommu/exynos: fix page table maintenance
> >> >    [v7,6/9] clk: exynos5250: add gate clock descriptions of System MMU
> >> > (conflicts in this one)
> >> >    [v7,7/9] ARM: dts: Add description of System MMU of Exynos SoCs
> >> > (depends on 6/9)
> >> >
> >> > We also already have parts of:
> >> >    [v7,9/9] iommu/exynos: add bus notifier for registering System MMU
> >> >
> >> > Some of those are being further discussed but I've lost track now
> >> > exactly which ones.
> >> >
> >> > I'm telling you about chromeos-3.8 status since the adopted changes
> >> > have been reviewed (by me and others) are being tested manually here
> >> > on several different Samsung Exynos platforms (including 5250 which is
> >> > our "snow" platform). Not sure how you should to mark those patches
> >> > since they aren't identical to your changes (which apply to post 3.10
> >> > kernels, not 3.8).  You might consider splitting those patches out
> >> > from the 4 I've listed above to get that series accepted upstream
> >> > since the additional review/testing should provide some confidence
> >> > those patches are good.
> >> >
> >>
> >> I understand what you are concerning about.
> >> Have you applied v6 patchset?
> 
> I did not though it's possible some of the code that was applied to
> chromeos-3.8 kernel came from v6 (or earlier) patches. I just compared
> with v7. Since it's a "backport", the code I found in chromeos-3.8 is
> the same if not identical to v7.
> 
Ok.
I think chromeos-3.8 kernel must work well with v7 also.
But there're a lot of changes in device tree of exynos SoC
and exynos-iommu driver followed by the changes in device tree
since 3.8 kernel.
I worry that back-porting of v7 is not trivial.

> >>
> >> I will try to split the patches and make the changes from v6
> >> on top of the v6 patcheset.
> 
> Ok.
> 
> > Actually, as you know, the previous patches include setting a System MMU
> > as the parent device of its master device in probe() of System MMU.
> > I asked Greg KH about changing device hierarchy in probe() and he answered
> > that it is not a good idea because it modifies sysfs even though probe() of
> > System MMU driver is called before sysfs is constructed.
> 
> SysMMU primarily provides DMA API, right? Can sysfs be initialized
> before DMA is available?
> On some (many?) platforms the SysMMU is also responsible for "child"
> bus controllers and MMIO resource routing, and on ARM platforms,
> clocks for rest of the IO devices.
> 
> SysMMU might be needed for early gfx support (or something). Maybe the
> right answer is to "discover" the SysMMU twice: once very early to get
> the SysMMU operational and then again later in a "normal" probe
> sequence to register with the sysfs. Any reason a driver couldn't
> register two different module_init() routines in different parts of
> the init call table?
> 
I agree with you.
Actually, exynos-iommu driver in Android devices based on 3.4 kernel
sets System MMUs as the parent of their Master devices in the different
initcalls.
(You can find it in the kernel of Galaxy S4 which contains Exynos SoC.)
There are several reasons.
Some devices are not involved in generic IO powerdomain and
genpd_pm_ops is not called for the devices.
Some devices are not proper to handle System MMU with genpd_pm_ops.

I wished that every device which has System MMU uses generic IO powerdomain
for its power management.

If I can be convince myself of that setting System MMU as the parent of
its master device is not a problem, I will not hesitate to do so.

> 
> > That's why I uses genpd_pm_ops.
> > It results in big change in the patches after registering device tree.
> >
> > I want to ask your opinion about this change :)
> 
> I have no objection to large changes if they work well and are easy to
> understand.
> 
Thank you.

> <rant>
> I personally not happy with the direction the Linux IOMMU "subsystem"
> has taken. I think the generic IOMMU subsystem should be discarded.
> Strong words for someone who's not a key contributor but I'll explain.
> 
> I wrote the IOMMU support for PA-RISC (three different IOMMUs) 10+
> years ago. I rewrote the HPUX implementations in the 90's and then
> around 2000 wrote the implementation for PA-RISC (one of which Alex
> Williamson used for IA64 IOMMU support - sba_iommu.c).  It's pretty
> straight forward. There is "page allocation policy", code to do TLB
> shoot down, and code to manage the IO Pdir. This is the same as for
> CPU MMU.  The *efficiency* of the TLB depends on the page allocation
> (SW) to work together with the HW TLB replacement policy. In other
> words, the page allocation policy needs to avoid thrashing the IO TLB.
> A generic IOTLB allocation policy can't do that for every platform.
> 
> Exynos 5250 has an 8-way associative TLB. That's likely very different
> from the Intel and TI (omap) IOMMU the IOMMU subsystem code was
> originally implemented for. The "optimal" size of page to allocate
> will be different too.  Older Exynos products are likely different
> 
> The "2cd layer" of indirect function calls between the generic IOMMU
> support and the platform specific code makes it harder to understand
> the code.  While jump tables are good for some things, I don't think
> this is a good use. We should "flip" this design around. Let the
> platform specific code "own" the DMA ops API and it can decide which
> services it should or should not use.
> 
> E.g. The IOTLB shoot down can be divorced from the "unmap" call. The
> efficiency of shooting down one IOTLB entry at a time is horrible on
> most platforms. One answer is to add a new API to shoot down an array
> of IOVAs. But the tradeoffs in the size of the array and the events
> that might trigger a TLB shoot down should be left up to the
> platform/chipset specific code (e.g. "lazy TLB shootdown").
> 
> Sorry...this got rant got alot longer than it should have been. I hope
> this helps people understand the design tradeoffs that linux IOMMU
> subsystem never will be able to cleanly address. My hope is this rant
> will help developers like you justify small steps to move away from
> generic IOMMU code.
> </rant>
> 
I understand what you are talking about.
Many people including me are finding a way to abstract different types
of H/W. I think IOMMU API is one of the result and DMA mapping framework
for ARM architecture is already finished with IOMMU API.

One of the inefficiency in the current implementation of DMA mapping for
ARM architecture is TLB invalidation which you addressed above.
TLB invalidation interface in IOMMU API was introduced earlier but it was
discarded. We can propose that if any others also agree.

Actually, I defined several custom TLB maintenance interfaces
for the kernel of our product to manage TLB efficiently.

> cheers,
> grant

Thank you very much, Grant.

Cho KyongHo.
