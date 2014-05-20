From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix for L2 race with VM invalidation
Date: Tue, 20 May 2014 15:32:45 +0200
Message-ID: <20140520133245.GE17056@8bytes.org>
References: <1400049252-4213-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20140514092920.GB6026@8bytes.org>
	<99CB3FADB756624A867BE9481439561C334C9045@satlexdag03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <99CB3FADB756624A867BE9481439561C334C9045-XjPeyzlH3nQYUXYKxDj4HkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Cornwall, Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Naru, Kim" <Kim.Naru-5C7GfCeVMHo@public.gmane.org>, "Hurwitz, Sherry" <sherry.hurwitz-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 14, 2014 at 11:38:25AM +0000, Cornwall, Jay wrote:
> Hi,
> 
> I'm not sure why you're submitting this, Suravee?
> 
> We already agreed that we need the extra mmu_notifier point, proposed
> by Joerg back in 2011, to eliminate the race. I had thought we were
> waiting on that to be implemented.

Speaking of this, would it also be possible to hold back all faults (so
not sending back ppr-comletions) between invalidate_range_start/end()?
Or will the hardware run into a timeout when it takes too long to
process a fault or when it issued the maximum number of parallel faults?


Regards,

	Joerg
