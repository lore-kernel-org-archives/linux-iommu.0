From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Only remove domain when device is removed
Date: Tue, 04 Nov 2014 09:12:17 -0700
Message-ID: <1415117537.27420.428.camel@ul30vt.home>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
	<1412074923-6342-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412074923-6342-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2014-09-30 at 13:02 +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> This makes sure any RMRR mappings stay in place when the
> driver is unbound from the device.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5619f26..eaf825a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3865,16 +3865,7 @@ static int device_notifier(struct notifier_block *nb,
>  	if (iommu_dummy(dev))
>  		return 0;
>  
> -	if (action != BUS_NOTIFY_UNBOUND_DRIVER &&
> -	    action != BUS_NOTIFY_DEL_DEVICE)
> -		return 0;
> -
> -	/*
> -	 * If the device is still attached to a device driver we can't
> -	 * tear down the domain yet as DMA mappings may still be in use.
> -	 * Wait for the BUS_NOTIFY_UNBOUND_DRIVER event to do that.
> -	 */
> -	if (action == BUS_NOTIFY_DEL_DEVICE && dev->driver != NULL)
> +	if (action != BUS_NOTIFY_REMOVED_DEVICE)

I haven't tested it, but I'm concerned whether this has introduced a
domain leak.  If we think about the case of unbinding a device from a
host driver and attaching it to a domain through the IOMMU API, I think
we used to count on this path to call domain_exit(), which made the
domain_context_mapped() in intel_iommu_attach_device() "unlikely".  With
this change, isn't the test in intel_iommu_attach_device() now neither
likely nor unlikely and we're only removing the dev_info from the domain
and not destroying the domain itself?  Thanks,

Alex
