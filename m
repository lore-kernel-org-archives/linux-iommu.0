From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix amd_iommu_detect() (does not fix any
	issues).
Date: Mon, 26 Oct 2015 12:07:17 -0400
Message-ID: <20151026160717.GF5618@l.oracle.com>
References: <1441059183-9023-1-git-send-email-j.glisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441059183-9023-1-git-send-email-j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 31, 2015 at 06:13:03PM -0400, j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> =

> Fix amd_iommu_detect() to return positive value on success, like
> intended, and not zero. This will not change anything in the end
> as AMD IOMMU disable swiotlb and properly associate itself with

Not sure how it disables SWIOTLB? The AMD Vi does not seem to
change 'swiotlb'. While 'gart_iommu_init' does. Did you mean
the AMD GART code?

> devices even if detect() doesn't return a positive value.

Returning positive will mean that the pci_iommu_alloc will stop
processing _all_ other IOMMUs.

While returning 0 will let it detect the other IOMMUs.

Granted on an AMD machine there can be two 'IOMMU's - the GART
and the AMD Vi. The detection is always to call gart_iommu_hole_init
first, then amd_iommu_detect.

I presume if there was one more type on AMD we would run into trouble.


> =

> Signed-off-by: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> ---
>  drivers/iommu/amd_iommu_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_ini=
t.c
> index a24495e..360a451 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2198,7 +2198,7 @@ int __init amd_iommu_detect(void)
>  	iommu_detected =3D 1;
>  	x86_init.iommu.iommu_init =3D amd_iommu_init;
>  =

> -	return 0;
> +	return 1;
>  }
>  =

>  /***********************************************************************=
*****
> -- =

> 1.8.3.1
> =

> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
