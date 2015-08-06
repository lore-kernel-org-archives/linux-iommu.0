From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 00/26] iommu/vt-d: Clean up device<->domain  attachment
Date: Thu, 06 Aug 2015 13:19:47 -0600
Message-ID: <1438888787.4023.116.camel@redhat.com>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-08-05 at 17:18 +0200, Joerg Roedel wrote:
> Hi,
> 
> here is a (bigger than I expected) patch-set which cleans up
> the code to attach and detach domains to iommus in the Intel
> VT-d driver.
> 
> In particular, the patch-set does:
> 
> 	* Remove special cases around the handling of
> 	  various domain types and align their handling
> 	  where possible
> 
> 	* Rework the data structures for the domain<->iommu
> 	  relation to better match with its usage. This
> 	  allowed to get rid of a couple of search loops.
> 
> 	* Make the domain attachment and detachment path
> 	  to/from an iommu more symmetric. This makes the
> 	  code easier to understand and maintain.
> 
> 	* Rework and simplify the locking around the
> 	  domain<->iommu attachment/detachment path.
> 
> A few rough edges and special cases are still left, but I
> expect that these will be removed with the conversion to
> default domains.
> 
> I tested the code with some additional debug code to make
> sure that domain and domain-id allocation/deallocation works
> as expected.
> 
> As test I booted a kernel with the patches (with and
> without iommu=pt) and ran a KVM guest with devices assigned.
> No lockdep warning popped up and the debug output was also
> fine. But of course this is no guarantee that there are no
> issues left, so I am happy about feedback. Please review!

Nice cleanup, Joerg!  A few minor comments in follow-up to the
individual patches.  Thanks,

Alex
