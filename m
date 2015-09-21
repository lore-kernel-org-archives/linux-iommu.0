From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: About amd-iommu support for kdump kernel
Date: Mon, 21 Sep 2015 15:54:30 +0200
Message-ID: <20150921135430.GC2173@8bytes.org>
References: <20150915120606.GD15856@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150915120606.GD15856-0VdLhd/A9PlfpSRLqpFUpR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Tue, Sep 15, 2015 at 08:06:06PM +0800, Baoquan He wrote:
> Recently I am free and can try to work out the amd-iommu support for
> kdump kernel. Now I have some plans and draft them into codes and debugging.
> And also there are prlblems. I brief them here, could you please have a
> look and give some suggestions?
> 
> Two parts:
> 
> 1) IO page mapping
>  .> Checking if it's in kdump kernel and previously enabled
>  .> If yes do below operatons:
>  	.> Do not disable amd iommu
> 	.> Copy dev table form old kernel and set the old domain id in amd_iommu_pd_alloc_bitmap
> 	.> Don't call update_domain() to update device table until the first __map_single() is called by device driver init

These operations look good so far, but a problem still remains: The AMD
IOMMU driver uses default domains which get allocated and initialized at
iommu driver initialization time. So there is no clean way yet to defer
device domain initialization to device driver init time.

This needs to be changed before the VT-d driver can be converted to
default domains too.

I'll also have a look into your patch. Maybe I see something that causes
the interrupt to fail.


	Joerg
