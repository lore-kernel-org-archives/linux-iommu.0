From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 12:46:49 +0200
Message-ID: <20140731104648.GD7458@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej> <20140731083923.GA31218@ulmo>
	<20140731092241.GA21850@leverpostej> <20140731101807.GB7458@ulmo>
	<20140731102351.GJ9809@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5699056176308196911=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140731102351.GJ9809-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5699056176308196911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline


--TD8GDToEDw0WLGOL
Content-Type: multipart/mixed; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 12:23:51PM +0200, Joerg Roedel wrote:
> On Thu, Jul 31, 2014 at 12:18:08PM +0200, Thierry Reding wrote:
> > It looks like this hasn't been applied yet, so I can send out a v5
> > shortly with the requested changes addressed.
>=20
> Yes, please send a v5 with the requested changes and all Reviewed-bys
> and Acked-bys this got so far. I'll take it into my tree then if nobody
> else objects.

I just sent out v5, although I trimmed the Cc list a little since it was
growing somewhat long. But I've kept everyone that gave feedback on v4
as well as the lists.

For reference I've attached the diff since v4.

Thierry

--k4f25fnPtRuIRUb3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="v5.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentat=
ion/devicetree/bindings/iommu/iommu.txt
index 464a81eaaf61..5a8b4624defc 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -82,7 +82,9 @@ device's parent node it will be ignored. An exception to =
this rule is if the
 referenced IOMMU is disabled, in which case the "dma-ranges" property of t=
he
 parent shall take effect. Note that merely disabling a device tree node do=
es
 not guarantee that the IOMMU is really disabled since the hardware may not
-have a means to turn off translation.
+have a means to turn off translation. But it is invalid in such cases to
+disable the IOMMU's device tree node in the first place because it would
+prevent any driver from properly setting up the translations.
=20
=20
 Notes:
@@ -108,7 +110,7 @@ Single-master IOMMU:
 	};
=20
 	master {
-		iommus =3D <&/iommu>;
+		iommus =3D <&{/iommu}>;
 	};
=20
 Multiple-master IOMMU with fixed associations:
@@ -117,8 +119,12 @@ Multiple-master IOMMU with fixed associations:
 	/* multiple-master IOMMU */
 	iommu {
 		/*
-		 * Masters are statically associated with this IOMMU and
-		 * address translation is always enabled.
+		 * Masters are statically associated with this IOMMU and share
+		 * the same address translations because the IOMMU does not
+		 * have sufficient information to distinguish between masters.
+		 *
+		 * Consequently address translation is always on or off for
+		 * all masters at any given point in time.
 		 */
 		#iommu-cells =3D <0>;
 	};
@@ -126,13 +132,13 @@ Multiple-master IOMMU with fixed associations:
 	/* static association with IOMMU */
 	master@1 {
 		reg =3D <1>;
-		iommus =3D <&/iommu>;
+		iommus =3D <&{/iommu}>;
 	};
=20
 	/* static association with IOMMU */
 	master@2 {
 		reg =3D <2>;
-		iommus =3D <&/iommu>;
+		iommus =3D <&{/iommu}>;
 	};
=20
 Multiple-master IOMMU:
@@ -145,28 +151,32 @@ Multiple-master IOMMU:
=20
 	master@1 {
 		/* device has master ID 42 in the IOMMU */
-		iommus =3D <&/iommu 42>;
+		iommus =3D <&{/iommu} 42>;
 	};
=20
 	master@2 {
 		/* device has master IDs 23 and 24 in the IOMMU */
-		iommus =3D <&/iommu 23>, <&/iommu 24>;
+		iommus =3D <&{/iommu} 23>, <&{/iommu} 24>;
 	};
=20
 Multiple-master IOMMU with configurable DMA window:
 ---------------------------------------------------
=20
 	/ {
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
-
 		iommu {
-			/* master ID, address and length of DMA window */
+			/*
+			 * One cell for the master ID and one cell for the
+			 * address of the DMA window. The length of the DMA
+			 * window is encoded in two cells.
+			 *
+			 * The DMA window is the range addressable by the
+			 * master (i.e. the I/O virtual address space).
+			 */
 			#iommu-cells =3D <4>;
 		};
=20
 		master {
 			/* master ID 42, 4 GiB DMA window starting at 0 */
-			iommus =3D <&/iommu  42  0  0x1 0x0>;
+			iommus =3D <&{/iommu}  42  0  0x1 0x0>;
 		};
 	};

--k4f25fnPtRuIRUb3--

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2h6YAAoJEN0jrNd/PrOh3BAQAJAKR+XNFHRo+WvVzVJvBVpQ
U7YOyRt4wRsZ1bq+a4AEUWShFDqHb3GE/z/vgKP1sIUeVZ5jant39yhcdowYr1Hf
83d9HlYscpS4ynKQKR1+iJIrjxlpdTjseZQDE8Hfa1S8Zs7tTGcG/BPf5aAUsv7i
XmVHcNDdUwdpwFXTzjnxzb6BEsCdrsEIJJW9OrKzCsLRTxc/sZ06zLeBS4iA+J86
uOChenrEVOHf9zWXcezTsyxi1KJfkNXnJ3Ex4Fq0AMZd0ZVN5IFYa/58RVgSefN8
1Q56/7b2dj3ZEh/GoW+CEJS+xOBKwUt10VSNmHwR0kMe9S8ouyWJ61vzPCZsx27Z
a8Cg+K0f0v4wfMN02RsV4uokPNhytSIEzUVUveV9y4e4D12TD+0BpwgeKlOu6lGg
AgoEUaV0Az1kMFJs07ZRedDYWIHjg7oMCrMpAZfxuIau8iSiPGJRnTYKLS6NXtOP
NU2DA5lHC+rzl0JktJyVfJX11qfrn9bLMxL/9R0SI4Qu9q6dEJU58LwO8WX99lBK
YQ6JMb0FISUeS3KOka5BoQmF5eMeTGTwyQF+rj3nMCJBGZDzbZ5xn3ShqokIFbRo
NZc8SJjiFPp/hGMiZ7tLcfeqMxBx+wtIo1khvtt3viiY1jtYwJ6VWwPtl//spqvK
8Ff5HOk/U+Vuu8RzH7Gg
=3sBi
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--

--===============5699056176308196911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5699056176308196911==--
