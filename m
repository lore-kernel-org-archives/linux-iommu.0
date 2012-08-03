From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Include linux/notifier.h
Date: Fri, 3 Aug 2012 16:26:59 +0200
Message-ID: <20120803142659.GB12268@avionic-0098.mockup.avionic-design.de>
References: <1343226290-32511-1-git-send-email-thierry.reding@avionic-design.de>
	<1343226290-32511-2-git-send-email-thierry.reding@avionic-design.de>
	<20120803140826.GF1996@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4427803172624587639=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120803140826.GF1996-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4427803172624587639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 03, 2012 at 04:08:26PM +0200, Joerg Roedel wrote:
> On Wed, Jul 25, 2012 at 04:24:50PM +0200, Thierry Reding wrote:
> > The linux/iommu.h header uses types defined in linux/notifier.h but
> > doesn't include it.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
>=20
> Better than adding the header-file is to add a forward declaration for
> struct notifier_block. I added a patch to iommu/fixes for this.

Yes, that would also work.

Thierry

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQG9+zAAoJEN0jrNd/PrOhmVkP/1lDXxoFJvg97e4yBpc/P7j1
BfmGWa2bUciZ/pQfipPzg4wbSwX/Q/ca1eWfVI0k7Rh5GXohA8/Cm1pe/bQ84h3Q
XiPzm4gXweQteQZ56R52NbjHK0MLIgevcsh1ES+HEToIsZ05ZbwkZxQfUbPmDGkt
tN8n0VIgUkCnlKjucMxD6GoXuPtL3N0/uQrjVEy6fuXN8gt7t6JOpzzvLLNU+mXh
KD1TdWoSWw0mxlXJF0F2N6XJDaeLUgylOixl5PkPbCwpyf15A7tMtevfuPiQ1ObC
5OAxbxSmv5Ixe+l2BTTP6YP7MmomSE2Iz5lhIr9UGZUivie0KapiRdbl8sJCq+us
3SkO6veL4lVpnnwKltsZIIJlRvbeb6qR0FeNCaTB88x6ZqTAANKLda7YBT4jwjfp
+OGSh7gR9Y7agf0sgBgUrixu/nO0Lp4jYbPmbGMtKMUSZORimJDZvJpi27rwzprO
t3ivLSVn+3sRHzNMgx5ZSH3QNYXbcl2F8ifZlPv5E3KsyQlPbhfq030C2R9XfdRc
6HdJ3VrjLdGmWkKDmMBa9ySoJGRu9+OOI284tMEj2db+rspMwRsswZM6gzGlmstx
Nypv3NfAXc6u0JF2ZecqkJjCajGOoTLu3uGWRMbWi4kJZXb7nSiigdTxB7UPgZjx
DvwbmTEQnvRRDjwZTX3+
=phih
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--===============4427803172624587639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4427803172624587639==--
