From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
	API
Date: Thu, 26 Apr 2018 14:11:36 +0200
Message-ID: <20180426121136.GD11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
	<20180425101051.15349-2-thierry.reding@gmail.com>
	<20180425151934.GC16075@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8683177563047192142=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425151934.GC16075-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8683177563047192142==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > The dma_iommu_detach_device() API can be used by drivers to forcibly
> > detach a device from an IOMMU that architecture code might have attached
> > to. This is useful for drivers that need explicit control over the IOMMU
> > using the IOMMU API directly.
>=20
> Given that no one else implements it making it a generic API seems
> rather confusing.  For now I'd rename it to
> arm_dma_iommu_detach_device() and only implement it in arm.

That'd be suboptimal because this code is used on both 32-bit and 64-bit
ARM. If we make the function 32-bit ARM specific then the driver code
would need to use an #ifdef to make sure compilation doesn't break on
64-bit ARM.

Thierry

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhwfgACgkQ3SOs138+
s6EHTw//ZCryzeW2f4svmcpSQUrTrRTWPLyEgOfAxcIeMtoliIGtCwYilD4vyk0q
Y9pOCf3XNj3PQMb6lAi2OjTCcv6AvWbd2K3HKIvZNvz5jY51dL+jtxIgX2EP+udP
V/yRh3zLYAWEndTMvLw8vbGpZa6iCYRhhS+Ik6PTmH7Yyn+htcIUDzN5LwoFEA/Z
zaYd2/pZIxjc6alAnyEgfrs2gxxC4fCdr0FIWxmYqtrxDlAx5MGTBcgdiN67XoNI
MgH4k2MPZQmInjrjwklCp8UbHd92maweTwHojBfEmikvLSL2hzUeL71gfptEQ24g
+x9KPnwP/EquB8/3xrI87xWE99EbRAf1Jv3SrYByaS0jfW2H3TsRtUVCszKxVniS
vqDp+pUGaqDJgB2e4QXb8Rtlrk11BSWK10Du+w9G1+8bB2bFK+ClfB/8Zim0PV8u
p3BeVrXrCtiL+egyvvxnfUEQsb61D4FXYn7QqacgR0JDZJjNl4jZmFe+urH2FM/W
bRDzt7ACb36GCobVR5ujGmA+x1agw2jyis8IcEf2FgOM5CdNIKZzAy1lZQvh5scv
v3mvTMWBMyAtArb+U3zAiG2NGZGdJI39bjdpYsB+gL5v+ErXd+7voxd38KTaIi45
nTz6ecCBNkuOWljeUvMdUlkFu29q/VKXCqISAkBtr16JXDk3b44=
=UbRL
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

--===============8683177563047192142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8683177563047192142==--
