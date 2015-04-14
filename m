From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] iommu/tegra-smmu: Add debugfs support
Date: Tue, 14 Apr 2015 13:07:26 +0200
Message-ID: <20150414110725.GA15878@ulmo.nvidia.com>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
	<20150327101539.GA17976@ulmo.nvidia.com>
	<20150331150214.GE22683@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7557853999973040794=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150331150214.GE22683-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============7557853999973040794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2015 at 05:02:14PM +0200, Joerg Roedel wrote:
> Hi Thierry,
>=20
> On Fri, Mar 27, 2015 at 11:15:41AM +0100, Thierry Reding wrote:
> > Another possibility would be for you to ack this patch so that I can
> > take it into the same branch as the dependency. The remainder of this
> > series doesn't depend on either of the two patches, so they should be
> > fine for you to take into your tree.
>=20
> This solution sounds like the best one. You have my
>=20
> 	Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> on the first patch.

Thanks.

> I merged patches 2-4 into the arm/tegra branch. As
> you noticed there were conflict merging the branch into next. Please
> have a look into my solution for that when I pushed it out later today
> and let me know if it looks good and still works.

Yes, the resolution looks correct and I've been running linux-next
without issues for a couple of days now.

Thanks,
Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVLPTqAAoJEN0jrNd/PrOhhAkQAIF+CMvxyMzcZWuHWv/SNRCu
4+SyISQkpLvetewjzeROHWwPzhGOxw3fcTC/tXUIpZuUSVZtbKg/lWAEpOzaAcrb
8FIbdbEhF4LL2HzkJXGK1/CX0JNX/jFIkOx1N6HpRD7MIGKUpCXiRH2/ueFZROMP
4OL9QJ0aJqvgVshzba6CWHpbwR2vuGaIm+lfsz2buDkTJt68n56qYXlx6vqYMzsr
ivt72x7YxfHYEENytRlT72GKDMNQ7fpN6HlDeCsvpH3FEMhnrasNSU5//LRGN9y8
a1VmWzqZxp7z0D+ePGQXOTeafYrY7vfb3uPSGVdpMaPw+ISywQgxpkGlwByrvCRW
veAYekVCOOq8kwIJa8CpW+YxQALho/EB097b7Zmu2weWNsjTR4W9U4MR8thCWXo+
0Fnk4GZLZXniPuVojIkmxDWDtPjLIrLSPHYYadW4Ds+cvrOxnzK96ZCY0n+5jqWL
0iNVMS872ouMsqDW4+r5WFM1LFkigb6b3EItKZzTchHJ0vX4PiqbnVyNS9JbqmxC
IQ+0BhmpYoKxC5FxiARuiT5xVvajT1mnQmqeumKm898WaGiXgC203/8QXmmxEvah
BYpFp/Wl9ZDNXTgEofMhI4K4mydNR/Iz28KoYaOPfF22wc+YGLiRAydHq0EceXf0
9RkrYebu0jX8UzslJt7y
=vzp7
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============7557853999973040794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7557853999973040794==--
