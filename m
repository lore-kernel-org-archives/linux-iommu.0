From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/13] Introduce IOMMU-API TLB Flushing Interface
Date: Thu, 17 Aug 2017 17:22:20 +0200
Message-ID: <20170817152220.GK16908@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<20170817083520.3329c0ff@w520.home>
	<20170817144308.GI16908@8bytes.org>
	<20170817085407.3de4e755@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817085407.3de4e755-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 08:54:07AM -0600, Alex Williamson wrote:
> So _sync() does imply that they're slower, but iommu_map() does not
> imply that a _flush() is required.  One is a performance issue, the
> other is an API usability issue.  If the sync version is used
> sub-optimally, it's a performance issue, not a correctness issue.  If
> the async version is used without an explicit flush, it's a correctness
> issue.  Therefore, I would lean towards making the asynchronous mode
> explicit and providing good documentation and comments to steer
> developers to the async version.  I think it makes the API harder to
> use incorrectly.

I agree that it makes the API a bit more complicated to use. But that
can be solved by documenting it and by converting the main users (for me
that is VFIO and dma-iommu.c) of it to the unsynchronized interface,
because people will look at existing users and just do what they do.

Introducing _sync functions instead of _async ones also has the
side-effect that it puts pressure on the maintainers of the code to
convert it to the async interface, because they now see explicitly that
they use the slow version and start looking for ways to make things
faster.

What I absolutly don't want is that the whole explicit TLB flushing
of the IOMMU-API (as introduced in this patch-set) is considered some
optional part of the API, as it would be when I just introduce _async
versions of map/unmap/map_sg.


Regards,

	Joerg
