From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] x86, irq: Keep IRQ assignment for PCI devices during
	suspend/hibernation
Date: Thu, 31 Jul 2014 17:21:33 +0200
Message-ID: <20140731152132.GE4375@pd.tnic>
References: <20140730175836.GC10213@pd.tnic>
	<1406766807-5745-1-git-send-email-jiang.liu@linux.intel.com>
	<20140731103941.GA4375@pd.tnic> <53DA55A0.6070005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53DA55A0.6070005-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Jul 31, 2014 at 10:41:36PM +0800, Jiang Liu wrote:
> 	Really appreciate your help. There are two issues left
> according to the log messages.

first of all:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

So please refrain from top-posting on lkml.

> 	The first issue is " WARNING: CPU: 2 PID: 3786 at
> fs/proc/generic.c:521 remove_proc_entry+0x19c/0x1b0()".
> It's caused by an issue in usb driver and a patch is ready to fix
> this issue, please refer to https://lkml.org/lkml/2014/7/20/277.
> This patch has been merged into Greg's usb repository, so it should
> be merge into v3.17 too.

I can apply this patch to test.

> 	The second issue is "AMD-Vi: Event logged [IO_PAGE_FAULT
> device=00:12.0 domain=0x0009 address=0x0000000000000000 flags=0x0000]".
> I feel it's not caused by IRQ related changes, but may be caused
> by IO page fault related work for AMD IOMMU. I need more time
> to investigate this and also CC Joerg for help too.

I don't think that's the issue - plain rc7 doesn't trigger the issue.
Only if I merge tip/master in it happens. And there are no AMD iommu
patches in tip/master since Joerg doesn't send stuff through tip
anymore.

> 	According to the log message, I feel my patch has fixed the
> original issue caused by IRQ related changes. What's your thoughts?

I still think the issue is in tip/master. I'm currently trying to
reproduce on another box so that I can bisect it. (Bisecting on my
workstation is always nasty :-\).

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
