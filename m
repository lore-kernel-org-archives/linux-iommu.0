From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart
	into tegra20-mc
Date: Mon, 24 Sep 2018 11:55:30 +0200
Message-ID: <20180924095530.GA21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3769059958876066490=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-7-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3769059958876066490==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:39AM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver wasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. As a result
> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT and not to break older kernels using
> newer DT, that is done by changing the 'compatible' of the node to
> 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> property also puts the tegra20-mc binding in line with the bindings of the
> later Tegra generations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
>  2 files changed, 19 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra2=
0-gart.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.=
txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> deleted file mode 100644
> index 099d9362ebc1..000000000000
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -NVIDIA Tegra 20 GART
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-gart"
> -- reg: Two pairs of cells specifying the physical address and size of
> -  the memory controller registers and the GART aperture respectively.
> -
> -Example:
> -
> -	gart {
> -		compatible =3D "nvidia,tegra20-gart";
> -		reg =3D <0x7000f024 0x00000018	/* controller registers */
> -		       0x58000000 0x02000000>;	/* GART aperture */
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidi=
a,tegra20-mc.txt
> index 7d60a50a4fa1..e55328237df4 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-mc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-mc.txt
> @@ -1,26 +1,37 @@
>  NVIDIA Tegra20 MC(Memory Controller)
> =20
>  Required properties:
> -- compatible : "nvidia,tegra20-mc"
> -- reg : Should contain 2 register ranges(address and length); see the
> -  example below. Note that the MC registers are interleaved with the
> -  GART registers, and hence must be represented as multiple ranges.
> +- compatible : "nvidia,tegra20-mc-gart"
> +- reg : Should contain 2 register ranges: physical base address and leng=
th of
> +  the controller's registers and the GART aperture respectively.

Couldn't we have achieved the same thing by adding a reg-names property
instead of using a different compatible string? After all we only change
what information the DT provides, but the device is still a "tegra20-mc"
device.

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotI8ACgkQ3SOs138+
s6EI3A/+MrOSQlcTPEzyOBIMaNpmEc3SIOPvJY5xDEGmqJikhg1/SRSnkn2pb+S4
YFLRE1fMd/Fq50lRvvSsWqkzMMUAYTcuPugw5xJf0LIFoOar3XcEB4O3qgvHO/2h
xJgfnCsno58K1rLKre3NknJnrjsNjRuDZuoKSwuqWRauxWPm1Bf9Q40KzdX/Zhcc
zSWpi9oJNXRep25zdmTJaZIzgAJuxXaLuR9HOorHGaDnCue2sw9CHdvDrxl13wD6
rXNOolsnYlRURWvyojLzDTfeY87VGRePPud5sksyA744h61lzqDTJndQw5Nw+Wm9
IiPnXuUwIB1/szMqMF29I1SWGayNCVah0T3q1n+BZoUD7t8a5darIgXL4wzzus/z
c1tN/MU7wbKRCFN6Ix3IVyqvcSvr1kW9mZNT1CHCsWexOI8szKh59Kyy+tzuk6LL
qS6cNC0wx4AMe38ptzaCe8B5ZY0esAOf2v2z9mWM4UAJSfHNOZzf/Nw5Z++5iFXe
/Ss94F1vEo0o+WTskXBzRpnHj0/U21C22ww32NH0h4yrzIud3HSphhg0V+Xb/s5r
yWynLOWXJ8uLT2ig4pSarpMhW/N7qUircP1VwyCCmsxUuJCs70PN/Eca4FD2ilqr
VyPLbxYsGzOveMHzSsHGD99NJW1WYpXDB27DfH+6G4gCPNX/MXU=
=dkO7
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============3769059958876066490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3769059958876066490==--
