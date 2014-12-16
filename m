From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Tue, 16 Dec 2014 13:47:53 +0200
Message-ID: <11086003.zET0ejo4os@avalon>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1521122.WC5DkGVrBt@avalon> <CAMuHMdWnOgN+rmDTo7S+o3AS2hyjgzKEza0vuUYnWz7CbksfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWnOgN+rmDTo7S+o3AS2hyjgzKEza0vuUYnWz7CbksfSA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, iommu@lists.linux-foundation.org
Cc: Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Tuesday 16 December 2014 11:02:03 Geert Uytterhoeven wrote:
> On Mon, Dec 15, 2014 at 7:44 PM, Laurent Pinchart wrote:
> > On Monday 15 December 2014 14:07:52 Geert Uytterhoeven wrote:
> >> On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart wrote:
> >> > Add the seven IPMMU instances found in the r8a7791 to DT with a
> >> > disabled status.
> >> > 
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >> 
> >> The addresses and interrupt numbers look OK to me.
> >> However, my comment about the "0x800" offset is still valid.
> >> Shouldn't we have two register blocks, and let the driver use only the
> >> second one?
> >> 
> >> If you ignore, feel free to add my
> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > I don't want to ignore your comment, but I don't know what to do here :-/
> > The datasheet lacks detailed information about secure vs. non-secure mode
> > and how the two register sets are supposed to interoperate and be handled
> > by the operating system.
> 
> When in doubt, the safest thing to do is "describe the hardware in DT".
> 
> The datasheet says there are two register sets of size 0x800, so IMHO we
> should have both in DT. Whether the driver only uses the second bank due to
> our limited understanding of the hardware is something different. We can
> still fix the driver later, if needed. Fixing the DT is, ... well...
> complicated ;-)

According to the datasheet there are two register sets sharing the same base 
address, banked through secure mode. There's additionally an alias at a 
different base address for non-secure registers access when running in secure 
mode. The hardware description thus depends on whether we're running in secure 
or non-secure mode, which doesn't play nicely with DT.

Additionally, I've tried to disable secure mode at boot time to test non-
secure mode at the base address, but it didn't seem to make any difference. I 
might have done something wrong though.

For these reasons I don't really like the idea of having two resources for 
secure and non-secure mode. Extending the single resource to cover the base 
address and the aliases should be fine though, I'll give it a go.

> Following the rule "describe the hardware in DT", I would also add the
> second interrupt (marked "SEC") for the DS0, MX, SY0, and GP IPMMU
> instances.

Agreed, I'll do that.

-- 
Regards,

Laurent Pinchart

