From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Thu, 01 May 2014 23:02:14 +0900
Message-ID: <20140501230214.ed53cd0fc977225f37b14e29@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<20140429181601.GE3582@e103592.cambridge.arm.com>
	<CANEJEGs6TXNzE8cWYgEKfFSsD2w5XiYvwSbhQ_+gtfzfs+6udA@mail.gmail.com>
	<7044616.kdaKNu3Qet@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <7044616.kdaKNu3Qet@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, rahul.
List-Id: iommu@lists.linux-foundation.org

On Tue, 29 Apr 2014 23:00:29 +0200, Arnd Bergmann wrote:
> On Tuesday 29 April 2014 13:07:54 Grant Grundler wrote:
> > On Tue, Apr 29, 2014 at 11:16 AM, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org> wrote:
> > ...
> > > An IOMMU is really a specialised bridge
> > 
> > Is a GART a bridge?
> > 
> > IOMMUs can provide three basic functions:
> > 1) remap address space to reach phys mem ranges that the device is
> > otherwise not capable of accessing (classic 32-bit DMA to reach 64-bit
> > Phys address)
> > 
> > 2) implement scatter-gather (page level granularity) so the device
> > doesn't have to
> > 
> > 3) provide some level of system protection against "rogue" DMA by
> > forcing everything through a DMA mapping interface and faulting when
> > encountering unmapped DMA transactions.
> 
> [ 4) provide isolation between multiple contexts, typically for purposes
>      of virtualization]
> 
> > I summarize IOMMUs as: "participate in the routing of MMIO
> > transactions in the system fabric."
> > In this sense, IOMMUs are sort of a bridge. Defining what kind of
> > routing they can do (coalesce transactions? remapping MMIO domains?)
> > and which address ranges they route would describe most of that
> > functionality.
> > 
> > This "remapping" of MMIO transaction is also usually asymmetric.
> > Meaning routing of "downstream" transactions *might* be completely
> > different than the routing + remapping of transactions heading
> > upstream. DMA mappings services are designed to handle only the
> > transactions generated (aka "mastered") by a downstream device.
> 
> For the purposes of the DT binding, we have a 'ranges' property
> that defines the downstream translation (CPU-to-MMIO) and a
> 'dma-ranges' property for the opposite address translation
> (device-to-memory).
> 
> > >, so it may be cleaner to describe
> > > an IOMMU using a real bus node in the DT, if we also define a way to make
> > > master/slave linkages explicit where it matters.
> > 
> > "where it matters" is a bit vague.  Is the goal to just enable DMA
> > mapping services to "do the right thing" for a device that can
> > generate DMA?
> 
> Yes. It's very complicated unfortunately, because we have to be
> able to deal with arbitrary combinations of a lot of oddball cases
> that can show up in random SoCs:
> 
> - device can only do DMA to a limited address range
> - DMA is noncoherent and needs manual cache management
> - DMA address is at an offset from physical address
> - some devices have an IOMMU
> - some IOMMUs are shared between devices
> - some devices with IOMMU can have multiple simultaneous contexts
> - a device may access some memory directly and some other memory through IOMMU

Do we need to consider this case?
I don't think a device can have different contexts at the same time.
If there such device is in a system, its driver must handle it correctly
with different devices descriptors for the different contexts, for example.
I mean, if a device has two DMA ports that are in different contexts,
they can be treated as different devices which are handed by a driver.

I worry that abstracting everything we can think may make the problem harder.

Regards,

   KyongHo

> - a device may have DMA access to a bus that is invisible to the CPU
> - DMA on some device is only coherent if the IOMMU is enabled
> - DMA on some device is only coherent if the IOMMU is disabled
> - the IOVA range to an IOMMU is device dependent
> 
> > > I've been hacking around some proposals on these areas which are a bit
> > > different from the approach suggested here -- I'll try to summarise some
> > > of it intelligibly and post something tomorrow so that we can discuss.
> > 
> > Are you planning on consolidating Documentation/devicetree/bindings/iommu/ ?
> > Do you care about Documentation/Intel-IOMMU.txt?
> 
> I think we can ignore the Intel-IOMMU because that is specialized on PCI
> devices, which we don't normally represent in DT. It is also a special
> case because the Intel IOMMU is a single-instance device. If it's present
> and enabled, it will be used by every device. The case we do need to describe
> is when we don't know which IOMMU is used for which master, or how to
> configure it.
> 
> 	Arnd
