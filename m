From: Yves-Alexis Perez <corsac-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Thu, 22 Feb 2018 08:48:37 +0100
Message-ID: <1519285717.2388.11.camel@debian.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
	<20180213140303.42mbzfxpypljy37l@8bytes.org>
	<20180213214002.GA27066@otc-nc-03> <1518992132.2542.5.camel@debian.org>
	<20180220142512.039309aa@jacob-builder>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1636436823757048057=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180220142512.039309aa@jacob-builder>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1636436823757048057==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-iIS2QBEqX5miAuDNO4vV"


--=-iIS2QBEqX5miAuDNO4vV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-02-20 at 14:25 -0800, Jacob Pan wrote:
> I didn't know about chipsec but reading the code seems to rely on an
> out-of-tree kernel module. I don't think it matches what we need here.

Yes good indeed, I had forgot about that. Maybe the userland part is still
useful, but there's definitely a need for (protected) access to privileged
memory (and access to /dev/mem is less practical than debugfs, I guess).

Regards,
--=20
Yves-Alexis
--=-iIS2QBEqX5miAuDNO4vV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlqOddUACgkQ3rYcyPpX
RFsBGwgA2j4wld43w9fzKFS9Tr/cBIhJ6u1Ap9yovmGTUEz4nWJeY6QL108CjrmF
aW4JfkMKoLNgq/7sGTQqD2K28H/XUJ0PVmXFpqR8iLdVLmpvEJpbWL4zBQSurrOQ
Buwi90VRCRqzLgO/30ohfSlQoIbk5cl5NqMWzSG8x4zYxffG0T2cpJFub6a9L2PI
NnF8bqjyqdwS1gZQkj47Y9KVSEq+85KsYDXXJE8mUAA2fd6eg77wZF5QBxQkeEcL
jXP2pBldjPFpkG1pCexL3nFG3AjVMfvSM6Kj9GmcUKfDFZiX6af3N0e0xePoa/pE
34OoObjheDonqbP+GyAeDsFnAgIxxw==
=SpJn
-----END PGP SIGNATURE-----

--=-iIS2QBEqX5miAuDNO4vV--

--===============1636436823757048057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1636436823757048057==--
