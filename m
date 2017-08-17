From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/13] Introduce IOMMU-API TLB Flushing Interface
Date: Thu, 17 Aug 2017 08:54:07 -0600
Message-ID: <20170817085407.3de4e755@w520.home>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<20170817083520.3329c0ff@w520.home>
	<20170817144308.GI16908@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817144308.GI16908-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 17 Aug 2017 16:43:08 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Hi Alex,
> 
> On Thu, Aug 17, 2017 at 08:35:20AM -0600, Alex Williamson wrote:
> > Wouldn't it be much more friendly to downstreams and out-of-tree
> > drivers to introduce new functions for the async semantics?  ie.
> > iommu_map_async(), etc.  The API also seems a little cleaner that
> > iommu_map() stands alone, it's synchronous, iommu_map_async() is
> > explicitly asynchronous and a _flush() call is needed to finalize it.
> > What do you see as the advantage to the approach here?  Thanks,  
> 
> The reason I did it this way was that I want the iommu_map(),
> iommu_unmap(), and iomu_map_sg() functions be considered the _default_
> to chose when using the IOMMU-API, because their use is faster than
> using the _sync() variants. Or in other words, I want the _sync function
> names to imply that they are slower versions of the default ones.

So _sync() does imply that they're slower, but iommu_map() does not
imply that a _flush() is required.  One is a performance issue, the
other is an API usability issue.  If the sync version is used
sub-optimally, it's a performance issue, not a correctness issue.  If
the async version is used without an explicit flush, it's a correctness
issue.  Therefore, I would lean towards making the asynchronous mode
explicit and providing good documentation and comments to steer
developers to the async version.  I think it makes the API harder to
use incorrectly.  Thanks,

Alex
