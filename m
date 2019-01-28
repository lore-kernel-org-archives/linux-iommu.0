From: Szabolcs Fruhwald via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
Date: Mon, 28 Jan 2019 15:42:17 -0800
Message-ID: <CAKkQkjB08FjLDUv=_=uAxNjstqryx6VG5zOq1LQ71V+Rws7+-w@mail.gmail.com>
References: <20190123230131.42094-1-sfruhwald@google.com>
	<c4e7855966a94b0c999a5f4325a27e90@ausx13mpc120.AMER.DELL.COM>
	<CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A@mail.gmail.com>
	<CAHp75Vc4r=ceP=SOQk2LR2B8fZjmdo33fV3yio3a352WwkMyMA@mail.gmail.com>
	<CAKkQkjD6WGE2jPSqUQ-BpJmevix2vd4GoSFKK5J312mEJB0Jpg@mail.gmail.com>
	<CAHp75VdhqGSCxZSPAW2DXq-cFUcDCoOnpW5mqD27LygGoiLMHA@mail.gmail.com>
	<7cd81f91-a69e-1561-821f-f21148a3aec0@arm.com>
Reply-To: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7cd81f91-a69e-1561-821f-f21148a3aec0-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 25, 2019 at 5:12 AM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On 25/01/2019 11:58, Andy Shevchenko wrote:
> > On Fri, Jan 25, 2019 at 3:50 AM Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > First of all, please do not top post!
> >
> >> I took a quick look at arch_setup_pdev_archdata(), overridden it in
> >> dcdbas.c and it works well (despite it's being called twice, since
> >> it's called from platform_device_alloc and platform_device_register).
> >>
> >> However, as I am not super familiar with ELF weak method references,
> >> especially with its scope resolution / versioning part, so as I see
> >> this weak method was introduced mainly for arch/** specific hooks.
> >> Is it safe to override this method from driver code, when let's say
> >> there's another implementation in the x86 arch code (currently there
> >> isn't)?
> >
> > No, it should be done somewhere in arch/x86.
> >
> > OTOH, Intel iommu driver can do it based on the check dev_is_pci().
> > For now I think it's better to solve this inside Intel iommu driver.
>
> Indeed - hacking code into individual device drivers which is entirely
> specific to the current implementation of the intel-iommu driver sounds
> like a recipe for a maintenance disaster (not to mention the extra fun
> if any of those devices also end up in AMD-based systems).
>
> AFAICS, the VT-d spec accommodates non-PCI devices via DRHD and
> corresponding ANDD entries, and the driver already has at least some
> degree of support for those - see dmar_acpi_insert_dev_scope() - so it
> may not need much more than just hooking up to the platform bus. If
> these platform devices do actually master through the IOMMU but don't
> have an appropriate device scope described, then frankly that's broken
> firmware, but the place to work around that would still be in the DMAR code.
>
> Robin.

It does, however, unfortunately, AFAK this 'device' is not listed in
any of those
ACPI tables. This is not even a real device, it's a CMOS chip with a fixed mem
segment and it needs dma only to let it read out the cmd data from a buffer.
So it's not really possible to support proper iommu for this driver.
Same is true for the previously mentioned drm915 mock test device.

Either way, there are device drivers which for various reasons may need to
opt-out / force 1:1 iommu mapping to work properly when iommu is turned on.

I agree that the current way of handling this (archdata.iommu) in intel_iommu
driver is not nice, a better solution might be to create a generalized way
through iommu.h (eg a method or constant value stored in main dev /
pdev struct),
which is well documented to be used only for legacy drivers / special
cases where
forced 1:1 mapping is truly justified / last resort. And other arch
iommu drivers can
support this, if and until necessary (legacy drivers don't need anymore).
