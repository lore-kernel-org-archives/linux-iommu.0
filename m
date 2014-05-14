From: "Cornwall, Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] iommu/amd: Fix for L2 race with VM invalidation
Date: Wed, 14 May 2014 11:38:25 +0000
Message-ID: <99CB3FADB756624A867BE9481439561C334C9045@satlexdag03.amd.com>
References: <1400049252-4213-1-git-send-email-suravee.suthikulpanit@amd.com>,
	<20140514092920.GB6026@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140514092920.GB6026-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Naru, Kim" <Kim.Naru-5C7GfCeVMHo@public.gmane.org>, "Hurwitz, Sherry" <sherry.hurwitz-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

I'm not sure why you're submitting this, Suravee?

We already agreed that we need the extra mmu_notifier point, proposed by Joerg back in 2011, to eliminate the race. I had thought we were waiting on that to be implemented.

________________________________________
From: Joerg Roedel [joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
Sent: Wednesday, May 14, 2014 4:29 AM
To: Suthikulpanit, Suravee
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Hurwitz, Sherry; Naru, Kim; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Cornwall, Jay
Subject: Re: [PATCH] iommu/amd: Fix for L2 race with VM invalidation

On Wed, May 14, 2014 at 01:34:12AM -0500, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> A low probability race exists with this fix. Translations received
> within the critical section to PTEs which are concurrently being
> invalidated may resolve to stale mappings.

Sorry, no. This patch can cause silent data corruption when the pages in
these stale mappings get reused. I understand that the current way does
not work either and can cause failures in the GPU, but silent data
corruption is worse than that.

How about putting the page-fault requests on hold between
invalidate_range_start/end()? The GPU will not see the failures, just a
longer delay until the page faults are handled.


        Joerg
