From: Benson Leung <bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 9/9] platform/chrome: chromeos_laptop: use helper
 pci_dev_id
Date: Thu, 25 Apr 2019 11:21:21 -0700
Message-ID: <20190425182121.GA175682@google.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <e882f58b-0808-952e-d293-5e8cc3f04c97@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1084115940=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e882f58b-0808-952e-d293-5e8cc3f04c97-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "open list:AMD KFD" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Realtek linux nic maintainers <nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>moderated list:ARM/STM32 ARCHITECTURE
List-Id: iommu@lists.linux-foundation.org


--===============1084115940==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Wed, Apr 24, 2019 at 09:17:19PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-By: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 24326eecd..7abbb6167 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -125,7 +125,7 @@ static bool chromeos_laptop_match_adapter_devid(struc=
t device *dev, u32 devid)
>  		return false;
> =20
>  	pdev =3D to_pci_dev(dev);
> -	return devid =3D=3D PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	return devid =3D=3D pci_dev_id(pdev);
>  }
> =20
>  static void chromeos_laptop_check_adapter(struct i2c_adapter *adapter)
> --=20
> 2.21.0
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Chromium OS Project
bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzB+qEACgkQHwn1ewov
5lip2g//eS1J0w28ODQxNNXn6vFg16ufHWY3pS3fpqOzY2iOnxmiL4V9a8qXXgs6
Nb7+tl1LTqFgN10TKr4KcYiPShVug0uz3SX9Gx6sI8d0C8Cy74QrQf4wQp48cg6I
0J0BgM0Icd6QdpdrNYZrcRmFJc7FY16i30SMAuINtfcnqgw4oU6hSG3qNXjqNrFG
2VUUjZHpvbAwWso0xToWjfK0TNPQXSslFKi+ROjvWlL+y0TGUBbcMbxviAp1H35X
CuT5Ijknh8FdG+NaMFnGXf6JvzGORNgXlAon15XEbKDf25/K/JyyDh9nJuPesOwG
MmYEiWj29dwg3/8rKvuWpuJVqWplC4x+ZCFvvEaDFeoxZuoLVc5QkVMRkupxwoA7
Ux1/Q9A7YS7OjOPhN2DikJIn2hEJnEyCBU2PdKEZToCUJ/C2gA+WqHyNXcflOldD
PBJSisoYM4LcuV1hhhfXUU/n/BgVPbmYWfvyQpHEbDpnlnDxMb+LheCgDlBn9mAh
QBD82gS5LcMo20071hVEqReV4zBzOc+S+h/4OxYW2HCNyn3qwztqYOge2oM/ezQ8
CV98H+KfIw+dYK8Vi40O9C05+NRkcAY/RaZzjQMyDJG2KxcO1mZhdhhbzCBRuS0o
pj3CU8ScPFa+s0qe7xk/Pac8fR6hmcse8jaJKX7in5MDKQNQ2CY=
=Oshd
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============1084115940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1084115940==--
