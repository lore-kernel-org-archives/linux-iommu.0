From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC V2] iommu: correct group reference count
Date: Mon, 09 Nov 2015 08:28:09 -0700
Message-ID: <1447082889.4925.5.camel@redhat.com>
References: <1447049608-6123-1-git-send-email-van.freenix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447049608-6123-1-git-send-email-van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-11-09 at 14:13 +0800, Peng Fan wrote:
> The basic flow for iommu_group_for_dev is:
> iommu_group_get_for_dev
>         |->  iommu_group_get   : increase reference count by 1.
>              return group;
>         |->  ops->device_group : Init/increase reference count to/by 1.
>              iommu_group_add_device  : Increase reference count by 1.
>              return group;
> 
> We can see that ops->device_group and iommu_group_add_device will together
> increase the iommu group reference count by 2. Actually we only need 1,
> but not 2. So we need add iommu_group_put after iommu_group_add_device
> to make sure iommu_group_get_for_dev only increase reference count by 1.

The premise seems incorrect to me.  In the first case where
iommu_group_get() provides a group, the reference is increased by 1, but
the device is already a member of the group and therefore already
increases the reference count of the group by 1.  The minimum group
reference at that point is therefore 2.  In the second case, the group
is created, which gives us our first reference, and the device is added,
giving us our second reference.  Therefore the minimum reference count
is also 2.  If we decrement it, allowing the caller to get the group
with a single reference and they release that reference, the group will
be destroyed even though it has a device member.  One reference to the
group is for the caller, the other reference is for the device contained
in the group.  Thanks,

Alex

> Signed-off-by: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> V1 thread: https://lkml.org/lkml/2015/11/3/304
> Changes V2:
>  I did not see the update about device_group when I worked out V1. So
>  redo the patch and refine commit msg and rebased to latest linus'
>  linux master tree.
> 
>  drivers/iommu/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index abae363..9c1971b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -852,10 +852,10 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  	}
>  
>  	ret = iommu_group_add_device(group, dev);
> -	if (ret) {
> -		iommu_group_put(group);
> +	iommu_group_put(group);
> +
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
>  
>  	return group;
>  }
