From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: WARN_ON when removing a device with no
	iommu_group associated
Date: Thu, 22 Aug 2013 21:33:27 -0600
Message-ID: <1377228807.25163.33.camel@ul30vt.home>
References: <1377222911-12144-1-git-send-email-weiyang@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1377222911-12144-1-git-send-email-weiyang-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Yang <weiyang-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: benh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, paulus-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+cc iommu]

On Fri, 2013-08-23 at 09:55 +0800, Wei Yang wrote:
> When removing a device from the system, iommu_group driver will try to
> disconnect it from its group. While in some cases, one device may not
> associated with any iommu_group. For example, not enough DMA address space.
> 
> In the generic bus notification, it will check dev->iommu_group before calling
> iommu_group_remove_device(). While in some cases, developers may call
> iommu_group_remove_device() in a different code path and without check. For
> those devices with dev->iommu_group set to NULL, kernel will crash.
> 
> This patch gives a warning and return when trying to remove a device from an
> iommu_group with dev->iommu_group set to NULL. This helps to indicate some bad
> behavior and also guard the kernel.
> 
> Signed-off-by: Wei Yang <weiyang-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/iommu/iommu.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fbe9ca7..43396f0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -379,6 +379,9 @@ void iommu_group_remove_device(struct device *dev)
>  	struct iommu_group *group = dev->iommu_group;
>  	struct iommu_device *tmp_device, *device = NULL;
>  
> +	if (WARN_ON(!group))
> +		return;
> +
>  	/* Pre-notify listeners that a device is being removed. */
>  	blocking_notifier_call_chain(&group->notifier,
>  				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
