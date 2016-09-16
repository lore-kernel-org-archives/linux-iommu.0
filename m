From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Fri, 16 Sep 2016 17:18:53 +0100
Message-ID: <f16db032-1905-9804-0607-fe007af72b0e@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
 <d03ea5e7-59f1-8b49-4ba2-d05fc2030ebc@arm.com>
 <04a0a682-4fdc-8d62-57cd-efdf730582c6@redhat.com>
 <c2645c5e-edd3-2b31-4311-0ca621a915e2@arm.com>
 <4d87d5f2-0350-b5f8-ffc3-4e9377cf1f87@redhat.com>
 <fc4ce398-4eeb-f2ca-b964-e9f466be79c4@arm.com>
 <1838c65d-5944-8946-781c-b420bea1acab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1838c65d-5944-8946-781c-b420bea1acab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On 15/09/16 17:46, Auger Eric wrote:
[...]
> Hum OK; thanks for the explanation. With that implementation however,
> don't we face back the issue we encountered in early stage of default
> domain implementation:
> 
> With this sample config (AMD overdrive + I350-T2 + 2VFs per PF) I fill
> the 8 context banks. Whereas practically we didn't need them before?
> 
> 00:00.0 0600: 1022:1a00
> 	Subsystem: 1022:1a00
> 00:02.0 0600: 1022:1a01
> 00:02.2 0604: 1022:1a02
> 	Kernel driver in use: pcieport
> 01:00.0 0200: 8086:1521 (rev 01)
> 	Subsystem: 8086:0002
> 	Kernel driver in use: igb
> 01:00.1 0200: 8086:1521 (rev 01)
> 	Subsystem: 8086:0002
> 	Kernel driver in use: igb
> 01:10.0 0200: 8086:1520 (rev 01) -> context 5
> 	Subsystem: 8086:0002
> 	Kernel driver in use: vfio-pci
> 01:10.1 0200: 8086:1520 (rev 01) -> context 7
> 	Subsystem: 8086:0002
> 	Kernel driver in use: igbvf
> 01:10.4 0200: 8086:1520 (rev 01) -> context 6
> 	Subsystem: 8086:0002
> 	Kernel driver in use: igbvf
> 01:10.5 0200: 8086:1520 (rev 01) -> shortage
> 	Subsystem: 8086:0002
> 	Kernel driver in use: igbvf
> 
> So I can't even do passthrough anymore with that config. Is there
> anything wrong in my setup/understanding?

It's kind of hard to avoid, really - people want DMA ops support (try
plugging a card which can only do 32-bit DMA into that Seattle, for
instance); DMA ops need default domains; default domains are allocated
per group; each domain requires a context bank to back it; thus if you
have 9 groups and 8 context banks you're in a corner. It would relieve
the pressure to have a single default domain per SMMU, but we've no way
to do that due to the way the iommu_domain_alloc() API is intended to work.

Ultimately, it's a hardware limitation of that platform - plug in a card
with 16 VFs with ACS, and either way you're stuck. There are a number of
bodges I can think of that would make your specific situation work, but
none of them are really sufficiently general to consider upstreaming.
The most logical thing to do right now, if you were happy without DMA
ops using the old binding before, is to keep using the old binding (just
fixing your DT with #stream-id-cells=0 on the host controller so as not
to create the fake aliasing problem). Hopefully future platforms will be
in a position to couple their PCI host controllers to an IOMMU which is
actually designed to support a PCI host controller.

What I probably will do, though, since we have the functionality in
place for the sake of the old binding, and I think there are other folks
who want PCI iommu-map support but would prefer not to bother with DMA
ops on the host, is add a command-line option to disable DMA domains
even for the generic bindings.

Robin.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
