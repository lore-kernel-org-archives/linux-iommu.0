From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document
	of Exynos System MMU
Date: Thu, 01 May 2014 16:11:48 +0100
Message-ID: <53626434.8000807@arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<6607258.MzzLbm2Afe@wuerfel>
	<20140501111527.GA3732@e103592.cambridge.arm.com>
	<36874558.Vf2LgdL3qf@wuerfel>
	<20140501143654.GB3732@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140501143654.GB3732-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel@lists>
List-Id: iommu@lists.linux-foundation.org

On 01/05/14 15:36, Dave Martin wrote:
> On Thu, May 01, 2014 at 02:29:50PM +0100, Arnd Bergmann wrote:
>> On Thursday 01 May 2014 12:15:35 Dave Martin wrote:
>>> On Tue, Apr 29, 2014 at 10:46:18PM +0200, Arnd Bergmann wrote:
>>>> On Tuesday 29 April 2014 19:16:02 Dave Martin wrote:
>>>
>>> [...]
>>>
>>>>> For example, suppose devices can post MSIs to an interrupt controller
>>>>> via a mailbox accessed through the IOMMU.  Suppose also that the IOMMU
>>>>> generates MSIs itself in order to signal management events or faults
>>>>> to a host OS.  Linux (as host) will need to configure the interrupt
>>>>> controller separately for the IOMMU and for the IOMMU clients.  This
>>>>> means that Linux needs to know which IDs may travel to the interrupt
>>>>> controller for which purpose, and they must be distinct.
>>>>
>>>> I don't understand. An MSI controller is just an address that acts
>>>> as a DMA slave for a 4-byte inbound data packet. It has no way of
>>>> knowing who is sending data, other than by the address or the data
>>>> sent to it. Are you talking of something else?
>>>
>>> Oops, looks like there are a few points I failed to respond to here...
>>>
>>>
>>> I'm not an expert on PCI -- I'm prepared to believe it works that way.
>>>
>>> GICv3 can descriminate between different MSI senders based on ID
>>> signals on the bus.
>>
>> Any idea what this is good for? Do we have to use it? It probably doesn't
>> fit very well into the way Linux handles MSIs today.
> 
> Marc may be better placed than me to comment on this in detail.

As to "fitting Linux", it seems to match what Linux does fairly well
(see the kvm-arm64/gicv3 branch in my tree). Not saying that it does it
in a very simple way (far from it, actually), but it works.

As to "what it is good for" (and before someone bursts into an Edwin
Starr interpretation), it mostly has to do with isolation, and the fact
that you may want to let the whole MSI programming to a guest (and yet
ensure that the guest cannot generate interrupts that would be assigned
to other devices). This is done by sampling the requester-id at the ITS
level, and use this information to index a per-device interrupt
translation table (I could talk for hours about the concept and its
variations, mostly using expletives and possibly a hammer, but I think
it is the time for my pink pill).

> However, I believe it's correct to say that because the GIC is not part
> of PCI, end-to-end MSI delivery inherently involves a non-PCI step from
> the PCI RC to the GIC itself.
> 
> Thus this is likely to be a fundamental requirement for MSIs on ARM SoCs
> using GIC, if we want to have a hope of mapping MSIs to VMs efficiently.

Indeed. GICv[34] is the ARM way of implementing MSI on SBSA compliant
systems (from level 1 onwards, if memory serves well). People are
actively building systems with this architecture, and relying on it to
provide VM isolation.

>>>>> I'm not sure whether there is actually a SoC today that is MSI-capable
>>>>> and contains an IOMMU, but all the components to build one are out
>>>>> there today.  GICv3 is also explicitly designed to support such
>>>>> systems.
>>>>
>>>> A lot of SoCs have MSI integrated into the PCI root complex, which
>>>> of course is pointless from MSI perspective, as well as implying that
>>>> the MSI won't go through the IOMMU.
>>>>
>>>> We have briefly mentioned MSI in the review of the Samsung GH7 PCI
>>>> support. It's possible that this one can either use the built-in
>>>> MSI or the one in the GICv2m.
>>>
>>> We are likely to get non-PCI MSIs in future SoC systems too, and there
>>> are no standards governing how such systems should look.
>>
>> I wouldn't call that MSI though -- using the same term in the code
>> can be rather confusing. There are existing SoCs that use message
>> based interrupt notification. We are probably better off modeling
>> those are regular irqchips in Linux and DT, given that they may
>> not be bound by the same constraints as PCI MSI.
> 
> We can call it what we like and maybe bury the distinction in irqchip
> drivers for some fixed-configuration cases, but it's logically the same
> concept.  Naming and subsystem factoring are implementation decisions
> for Linux.
> 
> For full dynamic assignment of pluggable devices or buses to VMs, I'm
> less sure that we can model that as plain irqchips.

Yeah, I've been looking at that. For some restricted cases, the irqchip
model works very well (think of wire to "MSI" translators, which are
likely to have a fixed configuration). Anything more dynamic requires a
more evolved infrastructure, but I'd hope they would also be on a
discoverable bus, removing most of the need for description in DT.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
