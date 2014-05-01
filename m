From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Thu, 1 May 2014 09:42:24 -0700
Message-ID: <CANEJEGtS8VHgT=W54QT-849Nz9n+uURj6LFM-sie0cX6=zn37A@mail.gmail.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<6607258.MzzLbm2Afe@wuerfel>
	<20140501111527.GA3732@e103592.cambridge.arm.com>
	<36874558.Vf2LgdL3qf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <36874558.Vf2LgdL3qf@wuerfel>
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
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWMP3drIcvDWNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, May 1, 2014 at 6:29 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
...
>> GICv3 can descriminate between different MSI senders based on ID
>> signals on the bus.
>
> Any idea what this is good for? Do we have to use it? It probably doesn't
> fit very well into the way Linux handles MSIs today.

I can see this being used for diagnosing failures - e.g. hung system
would leave tracks if an interrupt was or was not provided by the
device. I can't think of a reason why Linux MSI code would need to
support this though.

...
>> We are likely to get non-PCI MSIs in future SoC systems too, and there
>> are no standards governing how such systems should look.

Why look to the future when one can look in the past? :)

PA-RISC was designed in the 1980s to use "MSI" to generate all CPU
interrupts. This is as simple as it gets.

The concept is identical to MSI: MMIO routeable address with a payload
to indicate interrupt source (or map that source to some "vector
table".) Look at arch/parisc/kernel/smp.c:ipi_send() for an example
(note "p->hpa" is "processor->host physical address").

Current and  future products do the same things but add more
"features" that make this more complicated. But the basic transaction
will be identical and it needs to be routed like any other MMIO
transaction by any bridge (including IOMMUs).

> I wouldn't call that MSI though -- using the same term in the code
> can be rather confusing. There are existing SoCs that use message
> based interrupt notification. We are probably better off modeling
> those are regular irqchips in Linux and DT, given that they may
> not be bound by the same constraints as PCI MSI.

PCI device is one "source" for MSI and PCI defines how to initialize
an MSI source.  The target is not PCI (or not even Intel). Intel
defines how MSI works on their chipsets/CPUs. Other can still do it
differently.

I'm perfectly ok with using "MSI" to refer to any "in band interrupt message".

>> Who knows?  A management component of the GPU that is under exclusive
>> control of the host or hypervisor might be wired up to bypass the IOMMU
>> completely.

Does the linux kernel need to know about a device/component that it
can't control?
Either linux kernel shouldn't be told about it OR should ignore this
device/component.

>> Partly, yes.  The concept embodied by "dma-ranges" is correct, but the
>> topological relationship is not: the assumption that a master device
>> always masters onto its parent node doesn't work for non-tree-like
>> topologies.
>
> In almost all cases it will fit. When it doesn't, we can work around it by
> defining virtual address spaces the way that the PCI binding does. The only
> major exception that we know we have to handle is IOMMUs.

MMIO routing (and thus dma-ranges) is a "graph" (very comparable to
network routing). Some simple (e.g. PCI) implementations look like a
tree - but that's not the general case.

DMA cares about more than routing though - cache coherency and
performance (BW and latency) matter too.

cheers,
grant
