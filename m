From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Mon, 8 Apr 2019 08:55:25 -0700
Message-ID: <20190408155525.GA11471@infradead.org>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
	<1554736414.118779.265.camel@acm.org>
	<20190408092345.01751472@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190408092345.01751472-hfcDOgR9qeA@public.gmane.org>
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
Cc: James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 09:23:45AM -0600, Alex Williamson wrote:
> Loading modules is privileged:
> 
> $ modprobe vfio-pci
> modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted
> 
> Granting a device to a user for device assignment purposes is also a
> privileged operation.  Can you describe a scenario where this is
> reachable without elevated privileges?  The driver core maintainer has
> indicated previously that manipulation of driver binding is effectively
> at your own risk.  It's entirely possible to bind devices to the wrong
> driver creating all sorts of bad behavior.  In this case, it appears
> that the system has been improperly configured if devices from a user
> owned group can accidentally be bound to host drivers.  Thanks,

Sorry, but BUG()ing in case of invalid user input is simply not
acceptable.  Please fix this code to have proper error handling.
