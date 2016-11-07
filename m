From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/2] swiotlb: Add swiotlb=nobounce debug option
Date: Mon, 7 Nov 2016 14:20:12 -0500
Message-ID: <20161107192012.GB4750@char.us.oracle.com>
References: <1477928704-10611-1-git-send-email-geert+renesas@glider.be>
 <1477928704-10611-3-git-send-email-geert+renesas@glider.be>
 <20161031175252.GA6952@char.us.oracle.com>
 <CAMuHMdXFCVP2L-1jdzxbA6JD2Pm4accCyc57fFXt=g7VgAv53Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFCVP2L-1jdzxbA6JD2Pm4accCyc57fFXt=g7VgAv53Q@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, iommu@lists.linux-foundation.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 07, 2016 at 07:57:11PM +0100, Geert Uytterhoeven wrote:
> Hi Konrad,
> 
> On Mon, Oct 31, 2016 at 6:52 PM, Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
> > On Mon, Oct 31, 2016 at 04:45:04PM +0100, Geert Uytterhoeven wrote:
> >> On architectures like arm64, swiotlb is tied intimately to the core
> >> architecture DMA support. In addition, ZONE_DMA cannot be disabled.
> >>
> >> To aid debugging and catch devices not supporting DMA to memory outside
> >> the 32-bit address space, add a kernel command line option
> >> "swiotlb=nobounce", which disables the use of bounce buffers.
> >> If specified, trying to map memory that cannot be used with DMA will
> >> fail, and a warning will be printed (rate-limited).
> >
> > I would make the 'swiotlb_force' an enum. And then instead of this
> > being 'nobounce' just do the inverse of 'force', that is the
> > 'noforce' would trigger this no bounce effect.
> >
> > So:
> >
> > enum {
> >         NORMAL,         /* Default - depending on the hardware DMA mask and such. */
> >         FORCE,          /* swiotlb=force */
> >         NO_FORCE,       /* swiotlb=noforce */
> 
> Fine for me, but swiotlb_force is exported to platform code. Hence all users
> should be updated?

Yeah it would have to be moved to the swiotlb.h (the enum).

Thanks!
