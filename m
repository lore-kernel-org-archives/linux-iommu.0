From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 05/19] ARM: dt: tegra114: iommu: Fix IOMMU register
	address
Date: Thu, 31 Oct 2013 18:11:26 +0100
Message-ID: <20131031.191126.1326472797634956722.hdoyu@nvidia.com>
References: <1382092020-13170-6-git-send-email-hdoyu@nvidia.com><20131031165127.GB3037@kartoffel><20131031.190524.343708041257755667.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_201310311911261326472797634956722hdoyunvidiacom_"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031.190524.343708041257755667.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--_002_201310311911261326472797634956722hdoyunvidiacom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Thu, 31 Oct 2013 19:05:24 +0200 (EE=
T):

> Hi Mark,
>=20
> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote @ Thu, 31 Oct 2013 17:51:27 +01=
00:
>=20
> > On Fri, Oct 18, 2013 at 11:26:46AM +0100, Hiroshi Doyu wrote:
> > > Fix IOMMU register address.
> > >=20
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  arch/arm/boot/dts/tegra114.dtsi | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegr=
a114.dtsi
> > > index 2905145..8d42787 100644
> > > --- a/arch/arm/boot/dts/tegra114.dtsi
> > > +++ b/arch/arm/boot/dts/tegra114.dtsi
> > > @@ -318,9 +318,9 @@
> > > =20
> > >  	iommu {
> > >  		compatible =3D "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
> > > -		reg =3D <0x7000f010 0x02c
> > > -		       0x7000f1f0 0x010
> > > -		       0x7000f228 0x074>;
> > > +		reg =3D <0x70019010 0x02c
> > > +		       0x700191f0 0x010
> > > +		       0x70019228 0x074>;
> >=20
> > Minor cleanup/consistency request: as all these lines are changing anyw=
ay,
> > would you mind bracketing each entry individually:
> >=20
> > 		reg =3D <0x70019010 0x02c>,
> > 		      <0x700191f0 0x010>,
> > 		      <0x70019228 0x074>;
>=20
> No, at all. Attached the updated "[PATCHv3' 05/19]".

Oops, here's the right one, "[PATCHv3'' 05/19]".


--_002_201310311911261326472797634956722hdoyunvidiacom_
Content-Type: text/x-patch;
	name="0001-ARM-dt-tegra114-iommu-Fix-IOMMU-register-address.patch"
Content-Description: 0001-ARM-dt-tegra114-iommu-Fix-IOMMU-register-address.patch
Content-Disposition: attachment;
	filename="0001-ARM-dt-tegra114-iommu-Fix-IOMMU-register-address.patch";
	size=985; creation-date="Thu, 31 Oct 2013 17:11:27 GMT";
	modification-date="Thu, 31 Oct 2013 17:11:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNTZhNmFkMDU5ZjkwMjU5MDA5NDU3MDY5N2NiMzNlNWI4OTJkODM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSGlyb3NoaSBEb3l1IDxoZG95dUBudmlkaWEuY29tPg0KRGF0
ZTogTW9uLCAxNyBKdW4gMjAxMyAxNTozNzozNSArMDMwMA0KU3ViamVjdDogW1BBVENIdjMnJyAx
LzFdIEFSTTogZHQ6IHRlZ3JhMTE0OiBpb21tdTogRml4IElPTU1VIHJlZ2lzdGVyIGFkZHJlc3MN
Cg0KRml4IElPTU1VIHJlZ2lzdGVyIGFkZHJlc3MuDQoNClNpZ25lZC1vZmYtYnk6IEhpcm9zaGkg
RG95dSA8aGRveXVAbnZpZGlhLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTE0
LmR0c2kgfCA2ICsrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTExNC5kdHNp
IGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMTQuZHRzaQ0KaW5kZXggMjkwNTE0NS4uZTYyOTA0
MiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTE0LmR0c2kNCisrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTE0LmR0c2kNCkBAIC0zMTgsOSArMzE4LDkgQEANCiANCiAJ
aW9tbXUgew0KIAkJY29tcGF0aWJsZSA9ICJudmlkaWEsdGVncmExMTQtc21tdSIsICJudmlkaWEs
dGVncmEzMC1zbW11IjsNCi0JCXJlZyA9IDwweDcwMDBmMDEwIDB4MDJjDQotCQkgICAgICAgMHg3
MDAwZjFmMCAweDAxMA0KLQkJICAgICAgIDB4NzAwMGYyMjggMHgwNzQ+Ow0KKwkJcmVnID0gPDB4
NzAwMTkwMTAgMHgwMmM+LA0KKwkJICAgICAgPDB4NzAwMTkxZjAgMHgwMTA+LA0KKwkJICAgICAg
PDB4NzAwMTkyMjggMHgwNzQ+Ow0KIAkJbnZpZGlhLCNhc2lkcyA9IDw0PjsNCiAJCWRtYS13aW5k
b3cgPSA8MCAweDQwMDAwMDAwPjsNCiAJCW52aWRpYSxzd2dyb3VwcyA9IDwweDE4NjU5ZmU+Ow0K
LS0gDQoxLjguMS41DQoNCg==

--_002_201310311911261326472797634956722hdoyunvidiacom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_201310311911261326472797634956722hdoyunvidiacom_--
