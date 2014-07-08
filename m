From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [stable PATCH] iommu/vt-d: Fix missing IOTLB flush in
	intel_iommu_unmap()
Date: Tue, 08 Jul 2014 16:50:40 +0100
Message-ID: <1404834640.26540.5.camel@deadeye.wl.decadent.org.uk>
References: <1402319285.7595.9.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0399491055109342211=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1402319285.7595.9.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0399491055109342211==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-hvA0lViMJRI0wTXn72gJ"


--=-hvA0lViMJRI0wTXn72gJ
Content-Type: multipart/mixed; boundary="=-radYZS+94nJwX5S05y1h"


--=-radYZS+94nJwX5S05y1h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-06-09 at 14:09 +0100, David Woodhouse wrote:
> This missing IOTLB flush was added as a minor, inconsequential bug-fix
> in commit ea8ea460c ("iommu/vt-d: Clean up and fix page table clear/free
> behaviour") in 3.15. It wasn't originally intended for -stable but a
> couple of users have reported issues which turn out to be fixed by
> adding the missing flush.
>=20
> Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> For 3.14 and earlier. As noted, this fix is in 3.15 already.
[...]

I've queued this up for 3.2, with some adjustment.  I'm attaching my
version.

Ben.

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable from a rigged demo=
.

--=-radYZS+94nJwX5S05y1h
Content-Disposition: attachment;
	filename="iommu-vt-d-fix-missing-iotlb-flush-in-intel_iommu_unmap.patch"
Content-Type: text/x-patch;
	name="iommu-vt-d-fix-missing-iotlb-flush-in-intel_iommu_unmap.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogRGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPg0KRGF0ZTogTW9uLCAw
OSBKdW4gMjAxNCAxNDowOTo1MyArMDEwMA0KU3ViamVjdDogaW9tbXUvdnQtZDogRml4IG1pc3Np
bmcgSU9UTEIgZmx1c2ggaW4gaW50ZWxfaW9tbXVfdW5tYXAoKQ0KDQpQYXJ0IG9mIGNvbW1pdCBl
YThlYTQ2MGM5YWNlNjBiYmI1YWM2ZTU1MjFkNjM3ZDVjMTUyOTNkIHVwc3RyZWFtLg0KDQpUaGlz
IG1pc3NpbmcgSU9UTEIgZmx1c2ggd2FzIGFkZGVkIGFzIGEgbWlub3IsIGluY29uc2VxdWVudGlh
bCBidWctZml4DQppbiBjb21taXQgZWE4ZWE0NjBjICgiaW9tbXUvdnQtZDogQ2xlYW4gdXAgYW5k
IGZpeCBwYWdlIHRhYmxlIGNsZWFyL2ZyZWUNCmJlaGF2aW91ciIpIGluIDMuMTUuIEl0IHdhc24n
dCBvcmlnaW5hbGx5IGludGVuZGVkIGZvciAtc3RhYmxlIGJ1dCBhDQpjb3VwbGUgb2YgdXNlcnMg
aGF2ZSByZXBvcnRlZCBpc3N1ZXMgd2hpY2ggdHVybiBvdXQgdG8gYmUgZml4ZWQgYnkNCmFkZGlu
ZyB0aGUgbWlzc2luZyBmbHVzaC4NCg0KU2lnbmVkLW9mZi1ieTogRGF2aWQgV29vZGhvdXNlIDxE
YXZpZC5Xb29kaG91c2VAaW50ZWwuY29tPg0KW2J3aDogQmFja3BvcnRlZCB0byAzLjI6DQogLSBB
ZGp1c3QgY29udGV4dA0KIC0gVXNlICZkbWFyX2RvbWFpbi0+aW9tbXVfYm1wLCBhcyBpdCBpcyBh
IHNpbmdsZSB3b3JkIG5vdCBhbiBhcnJheV0NClNpZ25lZC1vZmYtYnk6IEJlbiBIdXRjaGluZ3Mg
PGJlbkBkZWNhZGVudC5vcmcudWs+DQotLS0NCiBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMg
fCAxOCArKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KDQotLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMNCisr
KyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYw0KQEAgLTQwNzAsNyArNDA3MCw3IEBAIHN0
YXRpYyBpbnQgaW50ZWxfaW9tbXVfdW5tYXAoc3RydWN0IGlvbW0NCiB7DQogCXN0cnVjdCBkbWFy
X2RvbWFpbiAqZG1hcl9kb21haW4gPSBkb21haW4tPnByaXY7DQogCXNpemVfdCBzaXplID0gUEFH
RV9TSVpFIDw8IGdmcF9vcmRlcjsNCi0JaW50IG9yZGVyOw0KKwlpbnQgb3JkZXIsIGlvbW11X2lk
Ow0KIA0KIAlvcmRlciA9IGRtYV9wdGVfY2xlYXJfcmFuZ2UoZG1hcl9kb21haW4sIGlvdmEgPj4g
VlREX1BBR0VfU0hJRlQsDQogCQkJICAgIChpb3ZhICsgc2l6ZSAtIDEpID4+IFZURF9QQUdFX1NI
SUZUKTsNCkBAIC00MDc4LDYgKzQwNzgsMjIgQEAgc3RhdGljIGludCBpbnRlbF9pb21tdV91bm1h
cChzdHJ1Y3QgaW9tbQ0KIAlpZiAoZG1hcl9kb21haW4tPm1heF9hZGRyID09IGlvdmEgKyBzaXpl
KQ0KIAkJZG1hcl9kb21haW4tPm1heF9hZGRyID0gaW92YTsNCiANCisJZm9yX2VhY2hfc2V0X2Jp
dChpb21tdV9pZCwgZG1hcl9kb21haW4tPmlvbW11X2JtcCwgZ19udW1fb2ZfaW9tbXVzKSB7DQor
CQlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0gZ19pb21tdXNbaW9tbXVfaWRdOw0KKwkJaW50
IG51bSwgbmRvbWFpbnM7DQorDQorCQkvKg0KKwkJICogZmluZCBiaXQgcG9zaXRpb24gb2YgZG1h
cl9kb21haW4NCisJCSAqLw0KKwkJbmRvbWFpbnMgPSBjYXBfbmRvbXMoaW9tbXUtPmNhcCk7DQor
CQlmb3JfZWFjaF9zZXRfYml0KG51bSwgaW9tbXUtPmRvbWFpbl9pZHMsIG5kb21haW5zKSB7DQor
CQkJaWYgKGlvbW11LT5kb21haW5zW251bV0gPT0gZG1hcl9kb21haW4pDQorCQkJCWlvbW11X2Zs
dXNoX2lvdGxiX3BzaShpb21tdSwgbnVtLA0KKwkJCQkJCSAgICAgIGlvdmEgPj4gVlREX1BBR0Vf
U0hJRlQsDQorCQkJCQkJICAgICAgMSA8PCBvcmRlciwgMCk7DQorCQl9DQorCX0NCisNCiAJcmV0
dXJuIG9yZGVyOw0KIH0NCiANCg==


--=-radYZS+94nJwX5S05y1h--

--=-hvA0lViMJRI0wTXn72gJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAU7wTVee/yOyVhhEJAQqZ6RAAl8Im/FdCwOiIBKMdHgUTjgFVzTiv4ZGJ
z9WS8oe9dUNcDvJ0NWIEXBfIbm4ha8YhpCa/JVSlki8023RH7/s2ShlDgvRmhPpA
3WPZRRbS5TaQefE2uV0sMyZHwgzep09X+Q8BsQpwpz1zOyRqtu8Rfm++Hsc8zl/x
2obN3btpKulJkTMpbl7YV4DrVQOb3fboz3S8Lg48IRT5Z/hx8ofm4nJixBytoMxq
BuzbI30kVD0/yr3ROpyGRdQMpBJ5a7fbc0G/TocrrYRWC5QkwXxClmh7sjDVIUgf
CQSYdK8T0cULvJH+ZeNDPOZQxMWkMSDtLt4Yw65GCde3QbhjwWqMxvci9KpTcr3e
gkqG76Sl1vXt0pxeEm7VbdGQfq18bQgWLEPamw1HPJgUx2PhBhLCk2qOZzW/Uz2a
fx5KvGTEGLy6xBIiesi2RHgTbwItQ45YUDXrRETfvpSI/0zMuCJDnKBu0+ylUUgn
gU6TniQrQDJ6QOkAl5PyQr2x0HW7L79Ao/jZvuovktm9z2ehUktOWZLcqPUo5KY0
pf4lIBUSIvd+gMWsQJvVSNqH62m06qA1yOAkHMkYafvW3JSexJxqUO+PlJ+WL+FD
syP0zPAuw290/AtBbegcpxMczWApcTmuHz0fr56GT2+0eB6Ck+1Ug9HPTTz8lCLE
B/uTn3i+IMw=
=EuMW
-----END PGP SIGNATURE-----

--=-hvA0lViMJRI0wTXn72gJ--

--===============0399491055109342211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0399491055109342211==--
