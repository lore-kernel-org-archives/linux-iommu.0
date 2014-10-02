From: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 0/2] iommu/vt-d: Keep RMRR mappings around on driver unbind
Date: Wed, 1 Oct 2014 18:30:38 -0600
Message-ID: <20141002003038.GA30672@anatevka.fc.hp.com>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
Reply-To: Jerry.Hoemann-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412074923-6342-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 30, 2014 at 01:02:01PM +0200, Joerg Roedel wrote:
> Hi,
> 
> here is a patch-set to fix an issue recently discovered when
> the Intel IOMMU is in use with devices that need RMRR
> mappings.
> 
> The problem is that the RMRR mappings are destroyed when the
> device driver is unbound from the device, causing DMAR
> faults.
> 
> To solve this problem a device driver core change is
> necessary to catch the right point in time for the IOMMU
> code to destroy any mappings for a device.
> 
> With this patch-set the RMRR mappings are only destroyed
> when the device is actually removed from the system.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (2):
>   driver core: Add BUS_NOTIFY_REMOVED_DEVICE event
>   iommu/vt-d: Only remove domain when device is removed
> 
>  drivers/base/core.c         |  3 +++
>  drivers/iommu/intel-iommu.c | 11 +----------
>  include/linux/device.h      | 11 ++++++-----
>  3 files changed, 10 insertions(+), 15 deletions(-)
> 
> -- 
> 1.9.1


Joerg,

I tested on HP Gen7 and Gen9 systems for which we experience dmar faults
when we rmmod a driver whose device had RMRR regions associated with it.

We don't see problem when patch set is applied.

Thanks,

Tested-by: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>

-- 

----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer              Hewlett-Packard

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann-VXdhtT5mjnY@public.gmane.org
----------------------------------------------------------------------------
