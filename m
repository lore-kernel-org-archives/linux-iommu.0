From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH/RFC] iommu/ipmmu-vmsa: Update ->add_device() return value
Date: Tue, 20 Sep 2016 14:18:47 +0100
Message-ID: <3759bb9c-c482-4fae-d588-7c946ebeecae@arm.com>
References: <20160920124144.8629.22575.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160920124144.8629.22575.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 20/09/16 13:41, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Update the IPMMU driver to return -ENODEV when adding devices
> not hooked up a particular IPMMU instance.
> 
> Currently the ->add_device() callback implementation in the IPMMU
> driver returns -ENODEV for devices with no "iommus" property,
> however the function ipmmu_find_utlbs() may return -EINVAL.

If there were no "iommus" property at all, of_parse_phandle_with_args()
should return -ENOENT - that probably does want to be caught and passed
back as -ENODEV to imply an untranslated device. On the other hand,
-EINVAL would stem from the existence of the property, but in a somehow
erroneous manner - other than the "args.np != mmu->dev->of_node" check
(which could legitimately fail and be safely ignored if there are
multiple IOMMUs in the system), any other reason implies a DT error
which probably shouldn't be papered over.

Robin.

> This patch updates the ipmmu_find_utlbs() return value to -ENODEV
> for the case when multiple IPMMU instances exist. That way the
> code matches the expected behaviour described in the comment of
> the add_iommu_group() function in iommu.c:
> 
>  /*
>   * We ignore -ENODEV errors for now, as they just mean that the
>   * device is not translated by an IOMMU. We still care about
>   * other errors and fail to initialize when they happen.
>   */
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  Applies to next-20160920 on top of:
>  b1e2afc iommu/ipmmu-vmsa: Fix wrong error handle of ipmmu_add_device
> 
>  drivers/iommu/ipmmu-vmsa.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0002/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-08 18:20:06.270607110 +0900
> @@ -781,7 +781,7 @@ static int ipmmu_find_utlbs(struct ipmmu
>  		of_node_put(args.np);
>  
>  		if (args.np != mmu->dev->of_node || args.args_count != 1)
> -			return -EINVAL;
> +			return -ENODEV;
>  
>  		utlbs[i] = args.args[0];
>  	}
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
