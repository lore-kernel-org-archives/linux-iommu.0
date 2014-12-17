From: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove dead code in device_notifier
Date: Wed, 17 Dec 2014 14:41:44 -0700
Message-ID: <20141217214144.GB11569@anatevka.fc.hp.com>
References: <1418813017-24888-1-git-send-email-joro@8bytes.org>
	<1418813017-24888-2-git-send-email-joro@8bytes.org>
Reply-To: Jerry.Hoemann-VXdhtT5mjnY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418813017-24888-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 17, 2014 at 11:43:37AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> This code only runs when action == BUS_NOTIFY_REMOVED_DEVICE,
> so it can't be BUS_NOTIFY_DEL_DEVICE.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 7610121..40dfbc0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4029,14 +4029,6 @@ static int device_notifier(struct notifier_block *nb,
>  	if (action != BUS_NOTIFY_REMOVED_DEVICE)
>  		return 0;
>  
> -	/*
> -	 * If the device is still attached to a device driver we can't
> -	 * tear down the domain yet as DMA mappings may still be in use.
> -	 * Wait for the BUS_NOTIFY_UNBOUND_DRIVER event to do that.
> -	 */
> -	if (action == BUS_NOTIFY_DEL_DEVICE && dev->driver != NULL)
> -		return 0;
> -
>  	domain = find_domain(dev);
>  	if (!domain)
>  		return 0;
> -- 
> 1.9.1

Joerg,

Tested this along w/ other patch of the set.

Instrumentation showed that the removed code wouldn't have been executed
during VM power on/power off.

Thanks!

Tested-by: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>


-- 

----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer              Hewlett-Packard

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann-VXdhtT5mjnY@public.gmane.org
----------------------------------------------------------------------------
