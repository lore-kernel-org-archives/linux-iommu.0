From: Mark Brown <broonie@kernel.org>
Subject: Re: of_dma_request_slave_channel() failed ?
Date: Wed, 12 Sep 2018 16:50:57 +0100
Message-ID: <20180912155057.GJ6062@sirena.org.uk>
References: <87efe9ls4n.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3372955151748389190=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAMuHMdVkQ8vio3O7VWyoWnVrY8Y8_YRWxQeXDwJ48iTxzujWdA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--===============3372955151748389190==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 11, 2018 at 11:43:47AM +0200, Geert Uytterhoeven wrote:

> So it seems the audio DMAC is deferred a second time, before the iommu driver
> probed.

Shouldn't there be at least one more round of deferred probe triggers
after the IOMMU probes?

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluZNeEACgkQJNaLcl1U
h9D66Af+LuJmW1P5LeruN0ZnF7/HzgPVOb014v5ql4+hVRoFyKthWfr3TSh1Yt91
SCsxf4BlCg9R9k+2scbWFvjKNdsArH+CS84UfAOhvz8l0U2rygnrsYVuzXY2eaBU
KAQiHLv9vTcbYvN9w2zTZMHkybIV2VPeZqpL+8EWwDIs+qRAPPvJF99xUkVhIiH8
1soUjgmsQPGeK3MvLsKrF9EbFkpjIcfdR/eAbc3ngS799fYbgk59CU2TYOgA39bn
uSVLrJqL6pMTRVuz4yocyGoEWQ1rkcOFAOq2FXaBY7TnQ9TXRkVn1P+I2PmNdNQC
nS5aAC1Z2Jpw8rQn1YQFCAGmcRrl3Q==
=lC1m
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--

--===============3372955151748389190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3372955151748389190==--
