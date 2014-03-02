From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] iommu: Add driver for Renesas VMSA-compatible IPMMU
Date: Sun, 02 Mar 2014 22:00:33 +0100
Message-ID: <9614296.npf9XYVJ8Q@avalon>
References: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1393601099-4413-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdUcrANSqUmS6QJkcms_bU=aYLBXjBUL5ep=k0eQxYzw6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUcrANSqUmS6QJkcms_bU=aYLBXjBUL5ep=k0eQxYzw6g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the review.

On Friday 28 February 2014 18:48:22 Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 4:24 PM, Laurent Pinchart wrote:
> > +/*
> > + * VMSA that states in section B3.6.3 "Control of Secure or Non-secure
> > memory
>
> VMSA states
> 
> > + * access, Long-descriptor format" that the NStable bit being set in a
> > table + * descriptor will result in the NStable and NS bits of all child
> > entries being + * ignored and considered as being set. The IPMMU seems
> > not to comply with this, + * as it generates a secure access page fault
> > if any of the NStable and NS bits + * isn't set when running in
> > non-secure mode.
> > + */
> > 
> > +       /*
> > +        * TTBCR
> > +        * We use long descriptor, with inner-shareable WBWA tables and
> > allocate
>
> descriptors
> 
> > +        * the whole 32-bit VA space to TTBR0.
> > +        */
> > 
> > +       /*
> > +        * Clear the error status flags. Unlike traditionnal interrupt
> > flag
> 
> traditional
> 
> Sorry, only comments on the comments ;-)

I'll of course assume this means that the driver is perfect ;-)

I'll fix all this in v2.

-- 
Regards,

Laurent Pinchart

