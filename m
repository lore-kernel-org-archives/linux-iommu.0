From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Date: Mon, 30 Apr 2018 12:41:24 +0200
Message-ID: <20180430104124.GE2476@ulmo>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1524883919-29484-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2143633477189065833=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1524883919-29484-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Cc: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, msuchanek-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2143633477189065833==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 08:21:58AM +0530, Nipun Gupta wrote:
[...]
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 88a3558..a9ec99d 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -314,6 +314,13 @@ static int host1x_device_match(struct device *dev, s=
truct device_driver *drv)
>  	return strcmp(dev_name(dev), drv->name) =3D=3D 0;
>  }
> =20
> +static int host1x_dma_configure(struct device *dev)
> +{
> +	if (dev->of_node)
> +		return of_dma_configure(dev, dev->of_node);

The conditional here is somewhat pointless since the of_node should
always be set. If it weren't it should be considered a bug and this
function welcome to crash to make that very obvious.

Either way:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm8tIACgkQ3SOs138+
s6HAJg/9FscZP4vLRd/bBp6+rBZLIilAu8k5gn/V+Tv9DJZRIXPsbeOuuixcznXK
Sc940MSfERPYXl8fscrW9kdJWuFM4W3bdXJGzZ08T+IdVVSyFdbldOoPAVpeLi8Y
C8pT3jlCLD5r6foGpUXy52rt6Jtuh7Tc4+3rr+D5h/efg9kbudcOjb2p3hcUDum+
6BJSl7yVKDN6yjK1+o7GHu0wic6CWZe/mNmaQ7g8jn7ahWV3kHnwrHj3/3l4N+h+
cDiZhl34yzyEJRyQ0aHr1r2qdEJTXYA33JpX0zMhqzpv9JCMa+VlteQ48kXSxxTN
X6TuS4pmeihUA9h3pFsuGAogPvW/tznL8tr9c2F2cJ/VDL3itQmfNmzT44ybrZYT
uNPIULOaNePPf10DGcd4RZCJIMUDQeza1IHEmiwlDnr5lYJWJUDtSb4ZfyA2j87y
q5wcupDKuqQ4v2tdkcZb9z8Mm5jYGsrWDVKFxKDPfx0LAwzmo5MNOcbGHnPiy8Oo
N24oBFW3v1ESkzX9Yfd7VCDcKIms1qjO2hyVmIb6jCvPg36E8mqG3f599zn8zCdu
i7xUnhwOs64t/yj62rPEd++T6dEsn7idUd6RGkZxLAWwSMipQ7dFhh0nBbKUGwwU
8yRNFMAtpLAaTnt4FqcLN/0BFZ09zwCVHJFw/mYxeUTFGN/V4Xc=
=hGR3
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--

--===============2143633477189065833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2143633477189065833==--
