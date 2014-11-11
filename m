From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Play nice on non-ARM/SMMU systems
Date: Tue, 11 Nov 2014 17:18:53 +0100
Message-ID: <20141111161852.GB27754@ulmo>
References: <1415373978-16203-1-git-send-email-thierry.reding@gmail.com>
	<20141110172539.GM23942@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7304302739309202140=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141110172539.GM23942-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============7304302739309202140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 05:25:39PM +0000, Will Deacon wrote:
> On Fri, Nov 07, 2014 at 03:26:18PM +0000, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Currently the driver registers IOMMU bus operations for all busses even
> > if no ARM SMMU is present on a system. Depending on the driver probing
> > order this prevents the driver for the real IOMMU to register itself as
> > the bus-wide IOMMU.
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 60558f794922..e154826d8b1d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -2072,8 +2072,20 @@ static struct platform_driver arm_smmu_driver =
=3D {
> > =20
> >  static int __init arm_smmu_init(void)
> >  {
> > +	struct device_node *np;
> >  	int ret;
> > =20
> > +	/*
> > +	 * Play nice with systems that don't have an ARM SMMU by checking that
> > +	 * an ARM SMMU exists in the system before proceeding with the driver
> > +	 * and IOMMU bus operation registration.
> > +	 */
> > +	np =3D of_find_matching_node(NULL, arm_smmu_of_match);
> > +	if (!np)
> > +		return 0;
> > +
> > +	of_node_put(np);
> > +
>=20
> Hopefully, this will be solved shortly by the of_iommu_configure series I=
've
> been dragging my feet with recently. However, since that's not done yet,
> this looks like the best thing for now, even if it's a bit of a bodge.
>=20
> Have you checked/updated other IOMMMU drivers too?

ARM SMMU was the only one being enabled on 64-bit where I noticed this,
but from a quick glance a couple of the other ARM driver are affected as
well. I'll see if I can find the time to come up with a similar patch.

Of course if these IOMMU drivers were proper drivers and bind to a
device, then this problem wouldn't exist in the first place.

Thierry

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUYjbsAAoJEN0jrNd/PrOhY4YP/1o8bd6Xxd79UcBiv+qQeifV
IlalV8b0QmYuXzarVqxzbA13hI+P46IHpLlZBRjKzMbUE12QNsrE5rsfG60RxVSL
61ud4mg0ol6Wc3dhaYOUaQPUm64f8Csc2TJA2OBwQs3F1AGoRvi3LgDOlWx/YaD9
LTQi/DgMRoABaJjERCDnoHvQxvlMox43D3smwQL7KwM+qjwtgtioZ3nSsKuyQ40X
y+8Vqucem3OluqwSYOJ/pl6Mhy7YLw306vIQU5oIvg1NGQg5DnWOakbhvSz5S2tN
Ofsm0Ksj40HT1qEwpOPbpdgLR9/I7M19m+Sq/3GjKuSqJahZXfjzfg0We20EF7i8
E4xZXUDWzneA0IYlAlje0/jGdhKk2DB3EjywkMOjTDa4pTTf+/G+1tuaT9biLPGS
oqsExPu5owUrJMVct8aKXWXmQT+JO6dQqJ28ViOfw8p4wWj/0nKmd1UyrQKkbrzV
k8kHaNwClejKL62jJqhJkCaxq36FILIFROczGDXSqA/BiSRRHeWDnGqevu/2gVQW
Aud3RO0wKU5c0qjGRiZjHfarps0sBsdk7pmBU9cOE5EPSS0Toas3Vfl/l7CsAujc
yl7HGMb/0lJLWRJ0rwRZjYCy2DbJf2MvHXtWkA1IEg+bMi0pfmjA3rbvGR6pSTyP
XYnckw+IamrtlfCjIo7Z
=mZiK
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--

--===============7304302739309202140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7304302739309202140==--
