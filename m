From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/5] iommu/ipmmu-vmsa: Add device tree bindings documentation
Date: Mon, 31 Mar 2014 12:18:04 +0200
Message-ID: <2135036.3YMfppXtgo@avalon>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1396049781-12941-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdUF6MmH_eK=SbG-q6Kai_q+5ufm-Vsd8z-bYKGj7Z-Spw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUF6MmH_eK=SbG-q6Kai_q+5ufm-Vsd8z-bYKGj7Z-Spw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Monday 31 March 2014 10:39:48 Geert Uytterhoeven wrote:
> On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart wrote:
> > +Required Properties:
> > +
> > +  - compatible: Must contain "renesas,ipmmu-vmsa".
> > +  - reg: Base address and size of the IPMMU registers.
> > +  - interrupts: Specifier for the MMU fault interrupt.
> 
> Does it make sense to have a property for the number of micro-TLBs,
> or is this handled transparently?
> 
> E.g. ipmmu_mx has 24 micro-TLBs, but ipmmu_mp has 30.

The IPMMU driver doesn't need to know the number of micro-TLBs, so we should 
be fine without specifying it in DT. The micro-TLBs are configured when a bus 
master device is attached or detached, and at that point the device provides 
its micro-TLB number.

The only reason I can foresee why the number of micro-TLBs would be useful is 
to iterate over micro-TLBs when the driver probes the device to disable them 
all. A mask would probably be better than a number in that case, and I think 
we can always add that later if we find a need for it.

-- 
Regards,

Laurent Pinchart

