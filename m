From: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC 1/2] of: reserved_mem: check return value of_dma_configure
Date: Mon, 27 Nov 2017 04:15:55 +0000
Message-ID: <DB6PR04MB32219685985135A408F39FFB88250@DB6PR04MB3221.eurprd04.prod.outlook.com>
References: <20171126131346.12532-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171126131346.12532-1-peng.fan-3arQi8VN3Tc@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Peng Fan
> Sent: Sunday, November 26, 2017 9:14 PM
> To: hch-jcswGhMUV9g@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Peng Fan
> <peng.fan-3arQi8VN3Tc@public.gmane.org>
> Subject: [RFC 1/2] of: reserved_mem: check return value of_dma_configure
> 
> In commit <7b07cbefb6>("iommu: of: Handle IOMMU lookup failure with
> deferred probing or error"), there is possibility that of_dma_configure may fail.
> So in of_reserved_mem_device_init_by_idx,
> also need to propagate the return value of_dma_configure to caller, when
> need to use reserved memory for a device which needs iommu.

Seems my understanding is wrong, with iommu enabled, reserved memory will not be used
for devices with memory-region. Please still help review RFC 2/2.

Thanks,
Peng.

> 
> Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/of/of_reserved_mem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 22b75c82e377..61523819b50e 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -357,9 +357,12 @@ int of_reserved_mem_device_init_by_idx(struct
> device *dev,
>  		/* ensure that dma_ops is set for virtual devices
>  		 * using reserved memory
>  		 */
> -		of_dma_configure(dev, np);
> -
> -		dev_info(dev, "assigned reserved memory node %s\n", rmem-
> >name);
> +		ret = of_dma_configure(dev, np);
> +		if (ret)
> +			of_reserved_mem_device_release(dev);
> +		else
> +			dev_info(dev, "assigned reserved memory node %s\n",
> +				 rmem->name);
>  	} else {
>  		kfree(rd);
>  	}
> --
> 2.14.1
