From: Szabolcs Fruhwald via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
Date: Thu, 24 Jan 2019 17:50:32 -0800
Message-ID: <CAKkQkjD6WGE2jPSqUQ-BpJmevix2vd4GoSFKK5J312mEJB0Jpg@mail.gmail.com>
References: <20190123230131.42094-1-sfruhwald@google.com>
	<c4e7855966a94b0c999a5f4325a27e90@ausx13mpc120.AMER.DELL.COM>
	<CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A@mail.gmail.com>
	<CAHp75Vc4r=ceP=SOQk2LR2B8fZjmdo33fV3yio3a352WwkMyMA@mail.gmail.com>
Reply-To: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHp75Vc4r=ceP=SOQk2LR2B8fZjmdo33fV3yio3a352WwkMyMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andy,

I took a quick look at arch_setup_pdev_archdata(), overridden it in
dcdbas.c and it works well (despite it's being called twice, since
it's called from platform_device_alloc and platform_device_register).

However, as I am not super familiar with ELF weak method references,
especially with its scope resolution / versioning part, so as I see
this weak method was introduced mainly for arch/** specific hooks.
Is it safe to override this method from driver code, when let's say
there's another implementation in the x86 arch code (currently there
isn't)?

So while I agree that archdata should be ideally written from within
this hook to make sure the value is there when the bus notifiers call
the iommu code (currently not registered for platform_bus), I am just
a bit worried that this might mask a future generic arch
implementation and could cause issues. What do you think?

Best Regards,
Szabolcs

On Thu, Jan 24, 2019 at 1:44 PM Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Thu, Jan 24, 2019 at 10:31 PM Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > (+iommu list for visibility and confirmation of the intended constant
> > externalization, see 2nd point below)
>
> > Absolutely, I thought so too. But, since the actual need to force
> > id-mapping comes from the lack of support for non-pci buses
> > particularly by the intel iommu implementation, it seemed a bit odd to
> > move this constant into iommu.h. Other platforms' implementations are
> > usually handling and hooking into other buses, eg platform bus.
> >
> > However, even these other hw platform iommu implementations are using
> > ACPI or other (bios related) tables to generate source ids, which
> > might still be an issue with drivers like dcdbas, with no real device
> > info in these tables. Not to mention that forcing id-mapping might be
> > a useful tool in driver developers' hands by other reasons too.
> > Therefore, I just came to the conclusion that it is indeed useful to
> > have this constant present in the common iommu header file (but with a
> > more expressing name).
> >
> > Especially, as I just found that dcdbas is *not* the first one to
> > implement this workaround:
> > https://github.com/torvalds/linux/blob/71f3a82fab1b631ae9cb1feb677f498d4ca5007d/drivers/gpu/drm/i915/selftests/mock_gem_device.c#L154
>
> > Let me come up with a v2 patch-set, containing a separate patch
> > externalizing this constant from intel_iommu.c to iommu.h and making
> > the above code using it too first, followed by this change in dcdbas.
>
> Wait... It sounds to me like a part of arch code where we define
> arch_setup_pdev_archdata() and use this dummy domain.
> Though dummy domain definition should come from IOMMU framework.
>
> --
> With Best Regards,
> Andy Shevchenko
