From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
Date: Fri, 14 Sep 2018 17:57:06 +0200
Message-ID: <20180914155706.GA906@kunai>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
	<20180913151716.6333-4-wsa+renesas@sang-engineering.com>
	<874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8505571280792290471=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <874f7cd9-ac51-5968-de40-14a0addf9c96-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8505571280792290471==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 02:23:51PM +0100, Robin Murphy wrote:
> On 13/09/18 16:17, Wolfram Sang wrote:
> > While sanitizig the pointer for dma_ops on teardown, do the same for
> > dma_parms, too. Rename the function to have a more generic name.
>=20
> Upon closer inspection, it looks like there are some cases (at least PCI =
and
> MFD) where dma_parms is installed by the parent/bus at device creation, a=
nd
> therefore remains valid and *would* be expected to persist across the chi=
ld
> device's driver unbinding and rebinding - seems this is more complex than=
 I
> first thought, sorry.

No problem. I am thankful I understand more details. So, the life cycle
of dma_parms is truly that of the device. Which means that the drivers
using devm_kzalloc in their probe, should ideally clear the pointer on
unbind. Otherwise, it is not possible to say if the non-NULL dma_parms
is intended or dangling. Which makes my initial dmam_set_dma_parms()
approach look not too bad, I'd think?

However, I don't want to push hard with this one. If you think this is
too academic, I'll just leave it for now...


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlub2k0ACgkQFA3kzBSg
KbZ0sRAAlqPAK/mkyLDkx5RBUJpzYe+XRAaNpF8cP8Kyw9BHyyekOpFVoBqjfNlo
Ohqjm1dkJTPh9buRXYdQexUQnquUSp6Ji7WQ96O1qNAlz5G8//cMD5zOt7K0ArlY
GUxHvhd7HBX8l/gqQ1uftoQCKRxJRVPtVuQn9MlLGCSScP29Kerj6aSFnFco0XUR
4GTnIcFG+OCcIFnRH57KpZw3iV8yeAIJpTvtfokb4a5Mugfb6BKqxtsqFKEIPJ0U
z643Yn3hRvuSxq64POTdqMLFsGL/Z1Gj12SOgobz09PFbiJ5Ts92JIy48cPVEdyp
N98Phn1y99/usBJWnXVjWmxgZPg4bHx8kU+hokOzmt9i87I4Hgm+9o36FsBCnMGJ
qkIrhADRfVAmrCnSR38Ti+YJFsqSfOrxqOFi6UQAW2yQC/leO5JCNFNANX8ZwHbg
n6Ng73pggrcwICZM1r3eQ8/U+xXcU8IJT+5QBW0XCXK33KZTyNZpvGXHxqaeSmXo
sdZB/FV6QwCTDuVwcfx6VJs6Czebv4YN41Uj/hal+JIyCYSAJgfA4s95EAHex8Ed
Kpv6cRNiodDtcxci9jTt+YWgNMMiQZkJnJZJZS7F7m7KLl10ljh5l4wg8TRNZdN0
ThEjQj5IjwBY1LxIFWoT68gCqk+W5wO/v6KJTtrJcMa1ax96fdo=
=ur+L
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

--===============8505571280792290471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8505571280792290471==--
