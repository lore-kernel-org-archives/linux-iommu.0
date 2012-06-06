From: Chris Wright <chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: dmar -- reserve mmio space used by IOMMU
Date: Wed, 6 Jun 2012 16:58:27 -0700
Message-ID: <20120606235827.GK12686@x200.localdomain>
References: <1338845342-12464-1-git-send-email-ddutile@redhat.com>
	<1338845342-12464-3-git-send-email-ddutile@redhat.com>
	<1338849430.10884.288.camel@shinybook.infradead.org>
	<4FCD401D.9000304@redhat.com>
	<1338852196.26785.10.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338852196.26785.10.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

* David Woodhouse (dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org) wrote:
> On Mon, 2012-06-04 at 19:09 -0400, Don Dutile wrote:
> > How does the kernel probe for chipsets, then registers with the chipsets
> > to find the programmed IOMMU BAR values?
> > -- I missed that class.... I only have Intel Virt Tech Directed I/O
> > Architecture spec., and the beginning of IOMMU is based on DMAR tables...
> > If you have more info/guidance, I'd appreciate it.
> 
> Hm, I thought we'd already started doing some of that in order to
> sanity-check the DMAR tables. The VTBAR registers are in PCI config
> space. The quirk_ioat_snb_local_iommu() check is already looking at
> them...

I always had the impression that things like VTBAR registers are
entirely chipset specific (and may not be there for all chipsets).
Would be great if that's incorrect.  Any idea?

thanks,
-chris
