From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Tue, 27 Jun 2017 12:24:35 -0400
Message-ID: <1498580675.10525.3.camel@rutgers.edu>
References: <20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
	<MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
	<1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
	<1498144389.17007.25.camel@rutgers.edu>
	<20170622215735.GW30388@8bytes.org>
	<1498227647.17007.31.camel@rutgers.edu>
	<20170626121430.GX30388@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1074234701124820523=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170626121430.GX30388-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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


--===============1074234701124820523==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-B8qlcI9DE6O6OYFI+CyF"


--=-B8qlcI9DE6O6OYFI+CyF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-06-26 at 14:14 +0200, Joerg Roedel wrote:
> On Fri, Jun 23, 2017 at 10:20:47AM -0400, Jan Vesely wrote:
> > I was able to trigger "Completion-Wait loop timed out" messages in the
> > following situation:
> > Hung OpenCL task running on dGPU.
> > dGPU goes to sleep.
> > sigterm to hung task.
> > it seems to recover OK after the dGPU is powered back on
>=20
> How does that 'dGPU goes to sleep' work? Do you put it to sleep manually
> via sysfs or something? Or is that something that amdgpu does on its
> own?

AMD folks should be able to provide more details. afaik, the driver
uses ACPI methods to power on/off the device. Driver routines wake the
device up before accessing it and there is a timeout to turn it off
after few seconds of inactivity.

>=20
> It looks like the GPU just switches the ATS unit off when it goes to
> sleep and doesn't answer the invalidation anymore, which explains the
> completion-wait timeouts.

Both MMIO regs and PCIe config regs are turned off so it would not
surprise me if all PCIe requests were ignored by the device in off
state. it should be possible to request device wake up before
invalidating the relevant IOMMU domain. I'll leave to more
knowledgeable ppl to judge whether it's a good idea (we can also
postpone such invalidations until the device is woken by other means)


Jan

>=20
>=20
>=20
> 	Joerg
>=20

--=20
Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
--=-B8qlcI9DE6O6OYFI+CyF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjGgSoFJq63cCYGKvY+M/tz9IsiAFAllShsMACgkQY+M/tz9I
siDNVBAAqajBq45f4/vFEfgdxxiKV76MwJp81abW0QujNduq7vHd5zt2o9AXWug6
YWpwbnmKvzoFJ7HNilDCUVOmO/aJ0CsFhKSplsigC2IvDnjKirBOV126Ov6IGeI4
ZglwJQi0DbvPxtRTSaYXezIox3MX9bEnSZrWoVexV5EtaLUqnwsM09HtNGPLqNHD
Gf+k3qCQsxASFdPhqU5L7yK+/Ri2VnchvRiGSBapR0SuWxG6GrXfmWyRDl4DM819
o61h6SjqshxF8XVqmdWd8oKdtib8W3IK9NdTGKC0nxpf8FLaX6LEwcOsTPt6rw85
6jNcGkAQDj35qnnlFUaDtRJJzf8QycoByBBWRBoEaZ9kdROVKNKUhpkbxoo6BGP/
lGTJ2Ld/IVRlwvQ17iz127BzxQsBxlUUc3lFkmT8ElB5UtJ0EQH4acewH3VuuChK
D5275YJivkX7sGcZ8/E45Gw/0kMw+ppE1v6vB99z1cadEujl3sLQbD5Ukt2lKYsj
UbpIwfmKI0U8bEIHqZD/8hhSR4RftEyaYZow0PLOzIz6oYW96TqByy4aFSLiW6my
erUBBnWKNn0GxajZ5AQojA4kjVXVHLq5DyJD4x9YKfAA9sOJRDwv2wjDZFvYhkTs
k/BUob4oee4gXh9xyQE99bzTmrXak2COwMBGccdoCJHq1nFsLmE=
=YWu5
-----END PGP SIGNATURE-----

--=-B8qlcI9DE6O6OYFI+CyF--


--===============1074234701124820523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1074234701124820523==--
