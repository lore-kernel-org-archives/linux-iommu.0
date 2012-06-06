From: Chris Wright <chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: dmar -- reserve mmio space used by IOMMU
Date: Wed, 6 Jun 2012 16:56:22 -0700
Message-ID: <20120606235622.GJ12686@x200.localdomain>
References: <1338845342-12464-1-git-send-email-ddutile@redhat.com>
	<1338845342-12464-3-git-send-email-ddutile@redhat.com>
	<1338849430.10884.288.camel@shinybook.infradead.org>
	<4FCD401D.9000304@redhat.com>
	<1338852196.26785.10.camel@shinybook.infradead.org>
	<20120606081600.GB5991@gmail.com>
	<1338971183.26785.33.camel@shinybook.infradead.org>
	<20120606082900.GF5991@gmail.com>
	<1338972329.26785.34.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338972329.26785.34.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
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
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-X9Un+BFzKDI@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

* David Woodhouse (dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org) wrote:
> On Wed, 2012-06-06 at 10:29 +0200, Ingo Molnar wrote:
> > So for all practical purposes we get 99% of the warning power 
> > without going into chicken-and-egg problems like how do we 
> > determine that there's an IOMMU area there if there's no IOMMU 
> > aware code in the kernel, right? 
> 
> That's not a chicken-and-egg problem. It's hardly difficult to see the
> DMAR ACPI table and take a *basic* look at the DRHD entries. You don't
> even need to fully parse it.

I had the same impression as Ingo.  Patch is basically good as is (fixing
most of the problem), and could be augmented later to close the final gap
(when no IOMMU code).  While parsing the DMAR table is trivial, what are
you recommending to use to inform if the region is not properly reserved?

thanks,
-chris
