From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dcdbas: Fix Intel-IOMMU domain allocation failure
Date: Thu, 24 Jan 2019 23:44:29 +0200
Message-ID: <CAHp75Vc4r=ceP=SOQk2LR2B8fZjmdo33fV3yio3a352WwkMyMA@mail.gmail.com>
References: <20190123230131.42094-1-sfruhwald@google.com>
	<c4e7855966a94b0c999a5f4325a27e90@ausx13mpc120.AMER.DELL.COM>
	<CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAKkQkjD=Hdm-3WbmrrqEj4c5df3LH7sMU960rwqHqF0Gf4CU7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stuart Hayes <stuart.w.hayes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mario Limonciello <Mario.Limonciello-8PEkshWhKlo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 10:31 PM Szabolcs Fruhwald <sfruhwald-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>
> (+iommu list for visibility and confirmation of the intended constant
> externalization, see 2nd point below)

> Absolutely, I thought so too. But, since the actual need to force
> id-mapping comes from the lack of support for non-pci buses
> particularly by the intel iommu implementation, it seemed a bit odd to
> move this constant into iommu.h. Other platforms' implementations are
> usually handling and hooking into other buses, eg platform bus.
>
> However, even these other hw platform iommu implementations are using
> ACPI or other (bios related) tables to generate source ids, which
> might still be an issue with drivers like dcdbas, with no real device
> info in these tables. Not to mention that forcing id-mapping might be
> a useful tool in driver developers' hands by other reasons too.
> Therefore, I just came to the conclusion that it is indeed useful to
> have this constant present in the common iommu header file (but with a
> more expressing name).
>
> Especially, as I just found that dcdbas is *not* the first one to
> implement this workaround:
> https://github.com/torvalds/linux/blob/71f3a82fab1b631ae9cb1feb677f498d4ca5007d/drivers/gpu/drm/i915/selftests/mock_gem_device.c#L154

> Let me come up with a v2 patch-set, containing a separate patch
> externalizing this constant from intel_iommu.c to iommu.h and making
> the above code using it too first, followed by this change in dcdbas.

Wait... It sounds to me like a part of arch code where we define
arch_setup_pdev_archdata() and use this dummy domain.
Though dummy domain definition should come from IOMMU framework.

-- 
With Best Regards,
Andy Shevchenko
