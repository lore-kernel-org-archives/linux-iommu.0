From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Mon, 29 Sep 2014 10:31:37 +0200
Message-ID: <20140929083136.GG12506@ulmo>
References: <1411874849-343-1-git-send-email-mitchelh@codeaurora.org>
	<1411874849-343-2-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1283864965348866559=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411874849-343-2-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1283864965348866559==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2014 at 08:27:28PM -0700, Mitchel Humpherys wrote:
> From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>=20
> It is sometimes necessary to poll a memory-mapped register until its
> value satisfies some condition. Introduce a family of convenience macros
> that do this. Tight-loop and sleeping versions are provided with and
> without timeouts.
>=20
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  include/linux/iopoll.h | 77 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 include/linux/iopoll.h

It would be good to provide a changelog with each new version of the
patch. As it is I now have v2 and v3 of this patch in my inbox and I
have no idea what the differences are, so I'd need to download both
and run them through interdiff to find out.

Thierry

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKRjoAAoJEN0jrNd/PrOhmOoQALIAUnaHud5cqrqCXh3D+wF6
41qDxcyXmZpZb3X/mNKBDj/0Vhl4f6yE71T+Hm/jKGku5tOQn3F1kL3Qhj/256Xu
P6oNubRO/vEga9HiSOjOyJx+QZliGfxMBCFSXSP6CGFtSlkhlTej4PDXfBABscu0
mY5LK4/bID+65jjV96NngC+2SYBGLHbYqCeilR/mb4H5YOl3z9b2qIlbPSZaWWwn
BzA/A0OzEAy4vmN2AQhEC7+ccqICZdAZ+GF+0D7cB+AMSpEc+U2IGe6vCSIFEK8Z
7QurhwOXSM+5ezi6o89D2vv4b1d81/cAup0+eMXI0J6z4u2guOQ2NiEv1FNnFAqk
JtYhkQdCgi1YqQMAJiOfb1/DNfV1xDAc/J9gaCL+P5FrBjznUOK05RPi14Sc0yFe
IjmOkja9kViZC7b21FGok97PUKx6S0Ov0vy+ucWMv5U1WASk8MAAuKfE9j18VXi7
InVD4TuSc1TfXmcq1CXgLHbjK66JVcXkWgtpRc8CT30t5KY/FoQA9gmxc/jm2HU5
UhFqid8kZg0lRWBmn/h0NyjJsdiiV6d5/b7At4AQaOld3Xi+noxs9+795bnT0Hgq
KLB7TmkpruKBtYMUmh7Wiuh1ZTIp2WWwPflEb4BdAjdIsYuFMBh2nhcF7RXIXhzH
0VmzYBwttSqgtx96tY1Y
=q59x
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--

--===============1283864965348866559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1283864965348866559==--
