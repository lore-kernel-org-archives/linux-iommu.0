From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/2] vfio: type1 iommu hugepage support
Date: Sat, 25 May 2013 07:21:54 -0400
Message-ID: <20130525112153.GD2418@localhost.localdomain>
References: <20130524171613.14229.84050.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130524171613.14229.84050.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 24, 2013 at 11:24:26AM -0600, Alex Williamson wrote:
> This series let's the vfio type1 iommu backend take advantage of iommu
> large page support.  See patch 2/2 for the details.  This has been
> tested on both amd_iommu and intel_iommu, but only my AMD system has
> large page support.  I'd appreciate any testing and feedback on other
> systems, particularly vt-d systems supporting large pages.  Mapping
> efficiency should be improved a bit without iommu hugepages, but I
> hope that it's much more noticeable with huge pages, especially for
> very large QEMU guests.

I took a very very quick look - and I am wondering if there should also
be a flag to turn it on/off in ther kernel in such case? Especially in the 
field if a user finds out that their particular IOMMU chipset might
be doing something funky with large-pages ?

> 
> This change includes a clarification to the mapping expectations for
> users of the type1 iommu, but is compatible with known users and works
> with existing QEMU userspace supporting vfio.  Thanks,
> 
> Alex
> 
> ---
> 
> Alex Williamson (2):
>       vfio: Convert type1 iommu to use rbtree
>       vfio: hugepage support for vfio_iommu_type1
> 
> 
>  drivers/vfio/vfio_iommu_type1.c |  607 ++++++++++++++++++++++++---------------
>  include/uapi/linux/vfio.h       |    8 -
>  2 files changed, 387 insertions(+), 228 deletions(-)
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
