From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Tue, 29 Apr 2014 13:07:54 -0700
Message-ID: <CANEJEGs6TXNzE8cWYgEKfFSsD2w5XiYvwSbhQ_+gtfzfs+6udA@mail.gmail.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<4780885.JaktFvJeC7@wuerfel> <20140428193056.GD22135@arm.com>
	<5242619.ZKgCdLW1L4@wuerfel>
	<20140429181601.GE3582@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140429181601.GE3582-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 29, 2014 at 11:16 AM, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org> wrote:
...
> An IOMMU is really a specialised bridge

Is a GART a bridge?

IOMMUs can provide three basic functions:
1) remap address space to reach phys mem ranges that the device is
otherwise not capable of accessing (classic 32-bit DMA to reach 64-bit
Phys address)

2) implement scatter-gather (page level granularity) so the device
doesn't have to

3) provide some level of system protection against "rogue" DMA by
forcing everything through a DMA mapping interface and faulting when
encountering unmapped DMA transactions.


I summarize IOMMUs as: "participate in the routing of MMIO
transactions in the system fabric."
In this sense, IOMMUs are sort of a bridge. Defining what kind of
routing they can do (coalesce transactions? remapping MMIO domains?)
and which address ranges they route would describe most of that
functionality.

This "remapping" of MMIO transaction is also usually asymmetric.
Meaning routing of "downstream" transactions *might* be completely
different than the routing + remapping of transactions heading
upstream. DMA mappings services are designed to handle only the
transactions generated (aka "mastered") by a downstream device.


>, so it may be cleaner to describe
> an IOMMU using a real bus node in the DT, if we also define a way to make
> master/slave linkages explicit where it matters.

"where it matters" is a bit vague.  Is the goal to just enable DMA
mapping services to "do the right thing" for a device that can
generate DMA?


> The problems of how to describe master/slave linkage, coherency between
> masters, and how to describe sideband ID information present on the bus
> are really interrelated.
>
> If we can come up with a consistent description for these things, it
> should help us to describe IOMMUs, bus mastering peripherals, MSI
> controllers and complex bridges in a more uniform way, without having to
> reinvent so much for each binding.  That's my hope anyway.

I don't know...these all deal with MMIO routing. The parts that are
dynamic should be detectable by platform specific SW (in general).
But where it's not (e.g. ISTR MSI transaction addressing is defined by
Intel Arch), it needs to be described by _something_  and device tree
seems to be a reasonable place to do that.

> I've been hacking around some proposals on these areas which are a bit
> different from the approach suggested here -- I'll try to summarise some
> of it intelligibly and post something tomorrow so that we can discuss.

Are you planning on consolidating Documentation/devicetree/bindings/iommu/ ?
Do you care about Documentation/Intel-IOMMU.txt?

Lots of stuff in Documentation/ touch different parts of the MMIO routing uses.

hth,
grant
