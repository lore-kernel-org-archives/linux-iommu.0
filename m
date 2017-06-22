From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Thu, 22 Jun 2017 11:13:09 -0400
Message-ID: <1498144389.17007.25.camel@rutgers.edu>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4791361862103854488=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170622092053.GV30388-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "Nath,
	Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============4791361862103854488==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2FWM5+fm6eMoP8UA51Tb"


--=-2FWM5+fm6eMoP8UA51Tb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-06-22 at 11:20 +0200, Joerg Roedel wrote:
> On Wed, Jun 21, 2017 at 05:09:31PM -0400, Jan Vesely wrote:
> > On Wed, 2017-06-21 at 12:01 -0500, Tom Lendacky wrote:
> > > On 6/21/2017 11:20 AM, Jan Vesely wrote:
> > > > Hi Arindam,
> > > >=20
> > > > has this patch been replaced by Joerg's "[PATCH 0/7] iommu/amd:
> > > > Optimize iova queue flushing" series?
> > >=20
> > > Yes, Joerg's patches replaced this patch.  He applied just the first =
two
> > > patches of this series.
> >=20
> > Joerg's patches applied on top of 4.10.17 do not solve my issue (do I
> > need the first two patches of this series?). the machine still hangs on
> > boot with a flood of IOMMU wait loop timed out messages.
> >=20
> > on the other hand patch 3/3 v1 applied on top of 4.10.17 fixes the
> > problem and the machine boots successfully
>=20
> Interesting. I did some measurements on the IOTLB flush-rate with my
> network load-test. This test is designed to heavily excerise the IOMMU
> map/unmap path and thus cause many IOTLB invalidations too.

It looks like I tested different patches.
linux-4.10.17 with both
"iommu/amd: Optimize iova queue flushing"
and
"iommu/amd: Disable previously enabled IOMMUs at boot"
(I haven't tested the series independently)

works OK. The machine booted successfully and I was able to test clover
based OpenCL and simple OpenGL on both iGPU(carrizo) and dGPU(iceland).

thanks and sorry for the confusion,
Jan

>=20
> Results are:
>=20
> 	Current upstream v4.12-rc6:	~147000 flushes/s
> 	With Toms patches:		  ~5900 flushes/s
> 	With my patches:		  ~1200 flushes/s
>=20
> So while Toms patches also get the flush-rate down significantly, it is
> even lower with my patches. This indicates that the problem is
> triggerable even with low flush rates.
>=20
> But I have no idea why it still triggers with my patches, but not with
> Toms. The approaches follow the same idea of only flushing domains that
> have map/unmap operations on them.
>=20
> I really think we need the patch to blacklist ATS on these GPUs
> upstream.
>=20
> Regards,
>=20
> 	Joerg
>=20

--=-2FWM5+fm6eMoP8UA51Tb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJZS96FAAoJEGPjP7c/SLIg5FIQAJRU5MA7pge4FO6Q/RrAdqSk
GOh3uNDBhrmuwCN6R0eQASpaG0MOT3toNzdgl+qFlK8Om1wcOzW9ww7oqjDhXYEr
FdffzComoswplrM2n04Ca6FTZ/yp217cAypGWd+C0RbPw+mqqLdsi4QhxrEZEbKa
tXc/8YbfUyu5qNIzwn9fyGn9ztARIBUKyKncfrWxFG/XE91WNIKl1dOfZxiKZaQg
ihs1IKnQlhelKFasv5RqgGGQoXTZJknt0ciQ8a7zQc15/g+fR1YSkxG0UzHalOVm
pXiTu3OuuVTZbshrnELViNW8SJSlpd7MOtLSc8/Zx5ZLIpK1WjMlO5oW6iQ8YnO4
Ejb/3TrpHktJxyl2TlsNi2j9p/SIWP+fKpo+Bqn3cC4qNsPbNKiA6gKJV81EXObe
5/iEKqTPO6vBp7nOBPFonL8jXogF1F0kKpmloW+19XCofoDsFamr2K//OyWtzPYG
4JtGLjGZU2FLL35e0lK2av1hlAJ4QzfjBUChi0uaMk5PAQKIGcs+HAuAAf3NWY4A
kxyNvqxKoCzsjGk8CBgIooN+LP9MrmaBF/6ug5NU2JfVk83W09TRejaz4hrCMgx3
l5pgQYMbNazLe9kcw3IlcwhNQDQ9e8FsYmFEbycyCaUMI3yZ07BEDxtsN8ZxH2iO
M8xYjYy0WBlTYlnHp9FX
=jK7x
-----END PGP SIGNATURE-----

--=-2FWM5+fm6eMoP8UA51Tb--


--===============4791361862103854488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4791361862103854488==--
