From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 06/11] iommu/ipmmu-vmsa: Teach xlate() to skip disabled
	iommus
Date: Wed, 08 Jun 2016 03:23:54 +0300
Message-ID: <9580255.XWMtPoN9Mj@avalon>
References: <20160606035723.31763.66500.sendpatchset@little-apple>
	<20160606035822.31763.39713.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160606035822.31763.39713.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

I agree with the comment that Geert made on v1, and I haven't seen you 
replying to it or addressing it.

Quoting Geert,

"I think this should be handled in drivers/iommu/of_iommu.c:of_iommu_init()
instead, cfr. commit 3e5dd6f6e690048d ("clk: Ignore disabled DT clock
providers")."

On Monday 06 Jun 2016 12:58:22 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> The ->xlate() call gets invoked even though the iommu
> device has status = "disabled" in DT, so make sure we
> skip over disabled devices.
> 
> In my mind it would make sense to have this at some
> shared level, but I guess some users may want to
> configure the iommu regardless of DT state.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  Changes since V1:
>  - Reworked slightly to fit on top of updated patch order
> 
>  drivers/iommu/ipmmu-vmsa.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> --- 0017/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 10:58:18.530607110 +0900
> @@ -1001,7 +1001,13 @@ static struct iommu_group *ipmmu_device_
>  static int ipmmu_of_xlate_dma(struct device *dev,
>  			      struct of_phandle_args *spec)
>  {
> -	/* dummy callback to satisfy of_iommu_configure() */
> +	/* If the IPMMU device is disabled in DT then return error
> +	 * to make sure the of_iommu code does not install ops
> +	 * even though the iommu device is disabled
> +	 */
> +	if (!of_device_is_available(spec->np))
> +		return -ENODEV;
> +
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart
