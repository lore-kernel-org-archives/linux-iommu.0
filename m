From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 01/12] clk: tegra: Implement memory-controller clock
Date: Thu, 30 Oct 2014 15:57:46 +0100
Message-ID: <20141030145744.GE20072@ulmo.nvidia.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <CAAObsKB0ozbOy8ZzgbEyf-SrqF5jpfHUXCJdAMiqgS78DAyaVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAObsKB0ozbOy8ZzgbEyf-SrqF5jpfHUXCJdAMiqgS78DAyaVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 01:02:45PM +0200, Tomeu Vizoso wrote:
> On 13 October 2014 12:33, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
[...]
> > +struct clk *tegra_clk_register_mc(const char *name, const char *parent=
_name,
> > +                                 void __iomem *reg, spinlock_t *lock)
> > +{
> > +       return clk_register_divider_table(NULL, "mc", "emc_mux", 0, reg,
>=20
> Should take name and parent_name from the passed args?
>=20
> With that change:
>=20
> Reviewed-By: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

Good catch.

Thanks,
Thierry

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUlHoAAoJEN0jrNd/PrOh9hgQAIAhXLhqxEgA//P81a0CFRNT
qQUyaAPdtcamysQ6QAhQMdKGLOQCz6Iuc82jDn0diUzhqT5dAGFHZDJzG4Fg7991
xZZH9UOJr2I66gZQJTSLKEEuY0I2ZOii0ZASypfemtLGbYwJD27mpiXebvUDPpyZ
xKaRHkPayoG1kId81an6yB3x0jiIRPJDt9ROCZZWeXVf8NN0/8szkbgNxm5hKmCs
kqMoG5OzYGAifJmbIUs1YY9xpApKJc076Ezl0qTX0GpXk2Qnr4k+9ye3Rt2fWaqF
I9/0/ckmugrhYTTrNBe5kmWOq7dsAtyb6dbP+E6VOPzgDS8fCkkLXE8S4y6z76Cv
s2E9NnjA4wii4SfEWA4PQH1n3BEtiBIFZXuf4l8KYt7OQIgvxGvOh5SYTwD8omNQ
Ye6b5af86uLDZ/BsTuTnga2Pqq4gB26N4dBPWJBMuVsduki/tyK4Bo3v43l/F/51
fuJMap7QoiaGVqzLq4gDspBsjeZgXS3DEMB3ne5JRWSlbwPsgBCeQ3kADEESufDD
AHfnuiJJUc0klwgY5gwuwY2jlGOySA0nnnLky9OrM1NA1DknAFNTs1epQ5pR+g0G
zRCPs2R9nBKJ2VTPiVP/0IoxckIjLmXG+HYfCmIsswrDgZU3qzoG76/3hTfqmpj+
M5O6IoE1DELDNoPH4W/4
=wOJF
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
