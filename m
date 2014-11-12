From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
	support
Date: Wed, 12 Nov 2014 16:09:42 +0100
Message-ID: <20141112150940.GE26488@ulmo>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
	<1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
	<20141112142150.GV10744@8bytes.org> <20141112144715.GD26488@ulmo>
	<20141112150233.GW10744@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4388358225186136192=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141112150233.GW10744-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4388358225186136192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 04:02:34PM +0100, Joerg Roedel wrote:
> On Wed, Nov 12, 2014 at 03:47:16PM +0100, Thierry Reding wrote:
> > The SMMU is part of a larger IP block that's also a memory controller.
> > Having it in drivers/iommu would mean that we need to provide a
> > mechanism to synchronize between the two drivers. They also share a
> > number of data tables, so that would need to be shared somehow as well.
> > By keeping both in the same directory we don't have to expose any of
> > this publicly.
>=20
> Since these parts are in different files you export the interfaces
> anyway through non-static symbols and those dependencys also exist for
> other IOMMU drivers. So I prefer this file to live in drivers/iommu.

But we don't export symbols to the global symbol table since it's all
built as a single module. Moving one part to drivers/iommu will mean
that I need to provide a public header with the symbols. And I'd need
to actually EXPORT_SYMBOL them because technically there's nothing
preventing these drivers to be built as modules.

Thierry

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUY3g0AAoJEN0jrNd/PrOhyp8P/RhC2bVYuJjh4MDHPBwhoME5
wjBoXIkii2FIVTDbZAlB+WqpanQ1lPObcgSEj6/L8CIK0WmpZVCPze7gtz8T371b
QF5zYA1pScs1d7rQNznJn0EzaZuSSO1k8/6ozpLjOecWx7BxdQ0PX86zzYik6stk
n192J5XkvpRELo1pjQnUaSJdWQSaak+FqRoCynra3YBlJ5LgGKMtQOEmmFVwtMKf
sPtZNB8qmUDM6ZpCaUpYKXXJME9pSVJHlUxYowG28gTYy0i8NoTzP1Vl4KK8BuGr
/2cRcJW3CFz2HTvpnln/SXjrWUL0qKW3Ys30q1goicNQ8Vr2H8Ahye15NcOKKl7y
Qca+f08EPR/F1V/1KYNmNZKqr+Dx0qHbbuCYAXQdDwWhbWanPA1h/KiQ2vlBD1hg
O25FFboVw4gj9mBjBLOvfuQwBOYUJvJKUsKQNqrmweL5ke/BhSfGkuxwXq2KH2CI
jknqA2JRP+1mHz/ewHJUuyxVgBssvQg2FvTunFHgp2K9rUY4LoX+VeNMtF+4Ug8F
fgM2dBM80Njkubox2JFmXkTUTpRczA0MIageT0IjVdgSY4OA0D1sCsowLN7344hC
CTTX2eW3QZA/ekUwqkRqlsBjA6r5m0rWJ/3ARWX4oEZIj7J7Rbpvagniu5uJkEyb
1qkkZQAX12oNcQa239R0
=YKeO
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

--===============4388358225186136192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4388358225186136192==--
