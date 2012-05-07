From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Mon, 7 May 2012 13:47:58 +0200
Message-ID: <20120507.144758.1558303336683449254.hdoyu@nvidia.com>
References: <4FA2CE32.7010406@wwwdotorg.org><20120504.121357.1085445784831612281.hdoyu@nvidia.com><4FA410DD.3090105@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_201205071447581558303336683449254hdoyunvidiacom_"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FA410DD.3090105-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--_002_201205071447581558303336683449254hdoyunvidiacom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Fri, 4 May 2012 19:24:45 +0200
Message-ID: <4FA410DD.3090105-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 05/04/2012 03:13 AM, Hiroshi Doyu wrote:
> > From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> > Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
> > Date: Thu, 3 May 2012 20:28:02 +0200
> > Message-ID: <4FA2CE32.7010406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> >=20
> >> On 04/16/2012 09:04 AM, Thierry Reding wrote:
> >>> This commit adds the device node required to probe NVIDIA Tegra 20 GA=
RT
> >>> hardware from the device tree.
> >>
> >>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra=
20.dtsi
> >>
> >>> +	gart: gart@7000f000 {
> >>> +		compatible =3D "nvidia,tegra20-gart";
> >>> +		reg =3D < 0x7000f000 0x00000100    /* controller registers */
> >>> +		        0x58000000 0x02000000 >; /* GART aperture */
> >>> +	};
> >>
> >> Thierry, Hiroshi, Olof,
> >>
> >> I have already applied this to Tegra's for inclusion in 3.5, but I'm
> >> considering dropping it. Further thought/discussions related to adding
> >> DT to the Tegra SMMU have raised an issue with a similar binding there=
.
> >>
> >> I'd like to hear peoples' thoughts on all this, and get a resolution,
> >> before we go ahead with any more GART/SMMU/MC patches.
> >>
> >> The Tegra20 register block at 7000f000 is not (just) the GART, but the
> >> MC (Memory Controller). This register block contains both general
> >> MC-related registers, and the GART registers. The situation is identic=
al
> >> on Tegra30, except that the register block contains both MC and SMMU
> >> registers.
> >=20
> > For the furthur info, GART occupies 1 block within MC register range,
> > and SMMU occupies 3 blocks. In both Tegra{20,30}, MC driver only uses
> > MC registers, GART uses GART registers in its own block, and SMMU uses
> > SMMU registers in its own blocks *exclusively*.
> >=20
> > IRQ is handled in MC. They include IOMMU page access fault too, but
> > MC ISR just prints fault address and other info. IRQ handling
> > registers belong to MC, and GART/SMMU doesn't have to touch it.
> >=20
> >  Tegra20:
> >  	7000f000-7000f3ff : /mc@7000f000	1KB
> >  	  7000f024-7000f02f : gart
> > =20
> >  Tegra30:
> >  	7000f000-7000f3ff : /mc@7000f000	1KB
> >  	  7000f010-7000f03b : smmu, register block 1
> >  	  7000f1f0-7000f1ff : smmu, register block 2
> >  	  7000f228-7000f283 : smmu, register block 3
> >  	  ....
>=20
> True, it appears that each register is logically part of MC or GART/SMMU
> functionality. In that case, chunks of registers can be assigned to
> specific drivers. However, the memory map is rather interleaved:
>=20
> Tegra20:
>=20
> 00c-01c: MC
> 024-034: GART
> 03c-270: MC
>=20
> Tegra30:
>=20
> 010-038: SMMU
> 050-220: MC
> 228-280: SMMU
> 29c-36c: MC
>=20
> Perhaps the simplest way is to represent those chunks as separate reg
> entries:
>=20
>     mc@7000f010 {
>         compatible =3D "nvidia,tegra30-mc";
>         reg =3D <0x7000f010 0x1d4 0x70000228 0xd4>;
>     };
>=20
>     smmu@0x70000050 {
>         compatible =3D "nvidia,tegra30-smmu";
>         reg =3D <0x70000010 0x2c 0x70000228 0x5c>;
>     };
>=20
> This could all be hidden inside e.g. smmu_read():
>=20
> static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
> {
> 	BUG_ON(offs < 0x10);
> 	if (offs < 0x40)
>         	return readl(smmu->regsa + offs - 0x10);
> 	BUG_ON(offs < 0x228);
> 	if (offs < 0x370)
>         	return readl(smmu->regsb + offs - 0x228);
> 	BUG();
> }
>=20
> This would optimize out, since most likely "offs" would be a #define for
> the register address.
>=20
> Then there would be no need for the DT nodes or devices/drivers to
> interact at all.

This may be quite simple and enough ok at the moment, instead of
trying to make some tricky connections between devices now.

For reference, attached the above patch to this mail.

> We should really talk to our HW engineers and make sure that future
> chips don't get even more interleaved register maps - either make sure
> the current layout is perpetuated exactly, or fix it to make them
> entirely separate. Can you please start an internal thread with them on
> this topic, Hiroshi?

Ok, Done.

> >> Option 2:
> >>
> >> We add an explicit child node to MC in order to instantiate the GART
> >> itself, and have the MC call of_platform_populate() to instantiate it,
> >> just like a bus driver:
> >>
> >> mc: mc@7000f000 {
> >>     compatible =3D "nvidia,tegra20-mc";
> >>     reg =3D <0x7000f000 0x00000100>;
> >>
> >>     ranges;
> >>     #address-cells =3D <1>;
> >>     #size-cells =3D <1>;
> >>
> >>     gart: gart {
> >>         compatible =3D "nvidia,tegra20-gart";
> >>         reg =3D <0x7000f000 0x00000100   /* controller registers */
> >>                0x58000000 0x02000000>; /* GART aperture */
> >>     };
> >> };
> >>
> >> The question here is: If the MC and GART drivers both need to access
> >> basically the same register block, they can't both call
> >> request_mem_region() on the registers, which is rather unfortunate.
> >=20
> > Can "request_resource(mc_resource, gart_resource)" or
> > "insert_resource(mc_resource, gart_resource)" create the following
> > resource tree?
> >=20
> >  Tegra20:
> >  	7000f000-7000f3ff : /mc@7000f000	1KB
> >  	  7000f024-7000f02f : gart
> >=20
> > gart/smmu may be able to get the parent resources for ioremap()?
> >=20
> > +	mc =3D pdev->dev.parent->of_node;
> >   or
> > +	res =3D platform_get_resource(to_platform_device(pdev->dev.parent), I=
ORESOURCE_MEM, 0);
>=20
> I'd certainly rather avoid drivers reaching into other devices to get
> register windows, unless this is more explicitly managed by passing the
> data from one device to another via an API for this purpose. The code
> above feels quite fragile/dangerous.

Ok, let's start with the simplest way, and improve later with nice
framework.

--_002_201205071447581558303336683449254hdoyunvidiacom_
Content-Type: text/x-patch;
	name="0001-iommu-tegra-smmu-Add-DT-support-for-SMMU.patch"
Content-Description: 0001-iommu-tegra-smmu-Add-DT-support-for-SMMU.patch
Content-Disposition: attachment;
	filename="0001-iommu-tegra-smmu-Add-DT-support-for-SMMU.patch"; size=9705;
	creation-date="Mon, 07 May 2012 11:47:59 GMT";
	modification-date="Mon, 07 May 2012 11:47:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiOGMxODI4MzE5MGU4M2NkNzcyODVhNTYxNzUzMjUxMzFiYWFkZjg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogSGlyb3NoaSBET1lVIDxoZG95dUBudmlkaWEuY29tPg0KRGF0
ZTogV2VkLCAxOCBBcHIgMjAxMiAxNToyNjozOSArMDMwMA0KU3ViamVjdDogW1BBVENIIDEvMV0g
aW9tbXUvdGVncmE6IHNtbXU6IEFkZCBEVCBzdXBwb3J0IGZvciBTTU1VDQoNCkFkZCBEVCBzdXBw
b3J0IGZvciBTTU1VLiBUaGUgbmVjZXNzYXJ5IGluZm8gaXMgZXhwZWN0ZWQgdG8gcGFzcyBmcm9t
DQpEVCB3aXRoIG1vcmUgcHJlY2lzZSByZXNvdXJjZSByZXNlcnZhdGlvbiwgaW5kZXBlbmRldCBv
ZiB0aGUgcGFyZW50IE1DDQpyZWdpdGVyIHJhbmdlLg0KDQpTaWduZWQtb2ZmLWJ5OiBIaXJvc2hp
IERPWVUgPGhkb3l1QG52aWRpYS5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L0tjb25maWcgICAg
ICB8ICAgIDEgKw0KIGRyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jIHwgIDE1NiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTAz
IGluc2VydGlvbnMoKyksIDU0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9LY29uZmlnIGIvZHJpdmVycy9pb21tdS9LY29uZmlnDQppbmRleCBjNjk4NDM3Li4yNDMw
OGY0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9LY29uZmlnDQorKysgYi9kcml2ZXJzL2lv
bW11L0tjb25maWcNCkBAIC0xNTUsNiArMTU1LDcgQEAgY29uZmlnIFRFR1JBX0lPTU1VX0dBUlQN
CiBjb25maWcgVEVHUkFfSU9NTVVfU01NVQ0KIAlib29sICJUZWdyYSBTTU1VIElPTU1VIFN1cHBv
cnQiDQogCWRlcGVuZHMgb24gQVJDSF9URUdSQV8zeF9TT0MNCisJc2VsZWN0IFRFR1JBX0FIQg0K
IAlzZWxlY3QgSU9NTVVfQVBJDQogCWhlbHANCiAJICBFbmFibGVzIHN1cHBvcnQgZm9yIHJlbWFw
cGluZyBkaXNjb250aWd1b3VzIHBoeXNpY2FsIG1lbW9yeQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvdGVncmEtc21tdS5jIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMNCmluZGV4IGVj
ZDY3OTAuLjBhMTk1NGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYw0K
KysrIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMNCkBAIC0zMCwxMiArMzAsMTUgQEANCiAj
aW5jbHVkZSA8bGludXgvc2NoZWQuaD4NCiAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCiAjaW5j
bHVkZSA8bGludXgvaW8uaD4NCisjaW5jbHVkZSA8bGludXgvb2YuaD4NCisjaW5jbHVkZSA8bGlu
dXgvb2ZfYWRkcmVzcy5oPg0KIA0KICNpbmNsdWRlIDxhc20vcGFnZS5oPg0KICNpbmNsdWRlIDxh
c20vY2FjaGVmbHVzaC5oPg0KIA0KICNpbmNsdWRlIDxtYWNoL2lvbWFwLmg+DQogI2luY2x1ZGUg
PG1hY2gvc21tdS5oPg0KKyNpbmNsdWRlIDxtYWNoL3RlZ3JhLWFoYi5oPg0KIA0KIC8qIGJpdG1h
cCBvZiB0aGUgcGFnZSBzaXplcyBjdXJyZW50bHkgc3VwcG9ydGVkICovDQogI2RlZmluZSBTTU1V
X0lPTU1VX1BHU0laRVMJKFNaXzRLKQ0KQEAgLTExMSwxMiArMTE0LDYgQEANCiANCiAjZGVmaW5l
IFNNTVVfUERFX05FWFRfU0hJRlQJCTI4DQogDQotLyogQUhCIEFyYml0ZXIgUmVnaXN0ZXJzICov
DQotI2RlZmluZSBBSEJfWEJBUl9DVFJMCQkJCTB4ZTANCi0jZGVmaW5lIEFIQl9YQkFSX0NUUkxf
U01NVV9JTklUX0RPTkVfRE9ORQkxDQotI2RlZmluZSBBSEJfWEJBUl9DVFJMX1NNTVVfSU5JVF9E
T05FX1NISUZUCTE3DQotDQotI2RlZmluZSBTTU1VX05VTV9BU0lEUwkJCQk0DQogI2RlZmluZSBT
TU1VX1RMQl9GTFVTSF9WQV9TRUNUSU9OX19NQVNLCQkweGZmYzAwMDAwDQogI2RlZmluZSBTTU1V
X1RMQl9GTFVTSF9WQV9TRUNUSU9OX19TSElGVAkxMiAvKiByaWdodCBzaGlmdCAqLw0KICNkZWZp
bmUgU01NVV9UTEJfRkxVU0hfVkFfR1JPVVBfX01BU0sJCTB4ZmZmZmMwMDANCkBAIC0xNzcsNiAr
MTc0LDggQEANCiAjZGVmaW5lIFNNTVVfQVNJRF9ESVNBQkxFCTANCiAjZGVmaW5lIFNNTVVfQVNJ
RF9BU0lEKG4pCSgobikgJiB+U01NVV9BU0lEX0VOQUJMRSgwKSkNCiANCisjZGVmaW5lIE5VTV9T
TU1VX1JFR19CQU5LUwkzDQorDQogI2RlZmluZSBzbW11X2NsaWVudF9lbmFibGVfaHdncnAoYywg
bSkJc21tdV9jbGllbnRfc2V0X2h3Z3JwKGMsIG0sIDEpDQogI2RlZmluZSBzbW11X2NsaWVudF9k
aXNhYmxlX2h3Z3JwKGMpCXNtbXVfY2xpZW50X3NldF9od2dycChjLCAwLCAwKQ0KICNkZWZpbmUg
X19zbW11X2NsaWVudF9lbmFibGVfaHdncnAoYywgbSkgX19zbW11X2NsaWVudF9zZXRfaHdncnAo
YywgbSwgMSkNCkBAIC0yMzUsNyArMjM0LDcgQEAgc3RydWN0IHNtbXVfYXMgew0KICAqIFBlciBT
TU1VIGRldmljZSAtIElPTU1VIGRldmljZQ0KICAqLw0KIHN0cnVjdCBzbW11X2RldmljZSB7DQot
CXZvaWQgX19pb21lbQkqcmVncywgKnJlZ3NfYWhiYXJiOw0KKwl2b2lkIF9faW9tZW0JKnJlZ3Nb
TlVNX1NNTVVfUkVHX0JBTktTXTsNCiAJdW5zaWduZWQgbG9uZwlpb3ZtbV9iYXNlOwkvKiByZW1h
cHBhYmxlIGJhc2UgYWRkcmVzcyAqLw0KIAl1bnNpZ25lZCBsb25nCXBhZ2VfY291bnQ7CS8qIHRv
dGFsIHJlbWFwcGFibGUgc2l6ZSAqLw0KIAlzcGlubG9ja190CWxvY2s7DQpAQCAtMjUyLDI5ICsy
NTEsNTcgQEAgc3RydWN0IHNtbXVfZGV2aWNlIHsNCiAJdW5zaWduZWQgbG9uZyB0cmFuc2xhdGlv
bl9lbmFibGVfMTsNCiAJdW5zaWduZWQgbG9uZyB0cmFuc2xhdGlvbl9lbmFibGVfMjsNCiAJdW5z
aWduZWQgbG9uZyBhc2lkX3NlY3VyaXR5Ow0KKw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmFoYjsN
CiB9Ow0KIA0KIHN0YXRpYyBzdHJ1Y3Qgc21tdV9kZXZpY2UgKnNtbXVfaGFuZGxlOyAvKiB1bmlx
dWUgZm9yIGEgc3lzdGVtICovDQogDQogLyoNCi0gKglTTU1VL0FIQiByZWdpc3RlciBhY2Nlc3Nv
cnMNCisgKglTTU1VIHJlZ2lzdGVyIGFjY2Vzc29ycw0KICAqLw0KLXN0YXRpYyBpbmxpbmUgdTMy
IHNtbXVfcmVhZChzdHJ1Y3Qgc21tdV9kZXZpY2UgKnNtbXUsIHNpemVfdCBvZmZzKQ0KLXsNCi0J
cmV0dXJuIHJlYWRsKHNtbXUtPnJlZ3MgKyBvZmZzKTsNCi19DQotc3RhdGljIGlubGluZSB2b2lk
IHNtbXVfd3JpdGUoc3RydWN0IHNtbXVfZGV2aWNlICpzbW11LCB1MzIgdmFsLCBzaXplX3Qgb2Zm
cykNCisNCitzdGF0aWMgaW50IGdldF9yZWdfYmFuayh1MzIgb2Zmc2V0KQ0KIHsNCi0Jd3JpdGVs
KHZhbCwgc21tdS0+cmVncyArIG9mZnMpOw0KKwlpbnQgaTsNCisJY29uc3Qgc3RydWN0IHNtbXVf
cmVnX2Jhbmsgew0KKwkJdTMyIHN0YXJ0Ow0KKwkJc2l6ZV90IHNpemU7DQorCX0gcltdID0gew0K
KwkJew0KKwkJCS5zdGFydCA9IDB4MTAsDQorCQkJLnNpemUgPSAweDJjLA0KKwkJfSwNCisJCXsN
CisJCQkuc3RhcnQgPSAweDFmMCwNCisJCQkuc2l6ZSA9IDB4MTAsDQorCQl9LA0KKwkJew0KKwkJ
CS5zdGFydCA9IDB4MjI4LA0KKwkJCS5zaXplID0gMHg1YywNCisJCX0sDQorCX07DQorDQorCWZv
ciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHIpOyBpKyspIHsNCisJCUJVR19PTihvZmZzZXQgPCBy
W2ldLnN0YXJ0KTsNCisJCWlmIChvZmZzZXQgPCByW2ldLnN0YXJ0ICsgcltpXS5zaXplKQ0KKwkJ
CXJldHVybiBpOw0KKwl9DQorCUJVRygpOw0KKwlyZXR1cm4gMDsgLyogTmV2ZXIgcmVhY2ggaGVy
ZSAqLw0KIH0NCiANCi1zdGF0aWMgaW5saW5lIHUzMiBhaGJfcmVhZChzdHJ1Y3Qgc21tdV9kZXZp
Y2UgKnNtbXUsIHNpemVfdCBvZmZzKQ0KK3N0YXRpYyBpbmxpbmUgdTMyIHNtbXVfcmVhZChzdHJ1
Y3Qgc21tdV9kZXZpY2UgKnNtbXUsIHNpemVfdCBvZmZzKQ0KIHsNCi0JcmV0dXJuIHJlYWRsKHNt
bXUtPnJlZ3NfYWhiYXJiICsgb2Zmcyk7DQorCWludCBpOw0KKwlpID0gZ2V0X3JlZ19iYW5rKG9m
ZnMpOw0KKwlyZXR1cm4gcmVhZGwoc21tdS0+cmVnc1tpXSArIG9mZnMpOw0KIH0NCi1zdGF0aWMg
aW5saW5lIHZvaWQgYWhiX3dyaXRlKHN0cnVjdCBzbW11X2RldmljZSAqc21tdSwgdTMyIHZhbCwg
c2l6ZV90IG9mZnMpDQorc3RhdGljIGlubGluZSB2b2lkIHNtbXVfd3JpdGUoc3RydWN0IHNtbXVf
ZGV2aWNlICpzbW11LCB1MzIgdmFsLCBzaXplX3Qgb2ZmcykNCiB7DQotCXdyaXRlbCh2YWwsIHNt
bXUtPnJlZ3NfYWhiYXJiICsgb2Zmcyk7DQorCWludCBpOw0KKwlpID0gZ2V0X3JlZ19iYW5rKG9m
ZnMpOw0KKwl3cml0ZWwodmFsLCBzbW11LT5yZWdzW2ldICsgb2Zmcyk7DQogfQ0KIA0KICNkZWZp
bmUgVkFfUEFHRV9UT19QQSh2YSwgcGFnZSkJXA0KQEAgLTM3MCw3ICszOTcsNyBAQCBzdGF0aWMg
dm9pZCBzbW11X2ZsdXNoX3JlZ3Moc3RydWN0IHNtbXVfZGV2aWNlICpzbW11LCBpbnQgZW5hYmxl
KQ0KIAlGTFVTSF9TTU1VX1JFR1Moc21tdSk7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIHNtbXVfc2V0
dXBfcmVncyhzdHJ1Y3Qgc21tdV9kZXZpY2UgKnNtbXUpDQorc3RhdGljIGludCBzbW11X3NldHVw
X3JlZ3Moc3RydWN0IHNtbXVfZGV2aWNlICpzbW11KQ0KIHsNCiAJaW50IGk7DQogCXUzMiB2YWw7
DQpAQCAtMzk4LDEwICs0MjUsNyBAQCBzdGF0aWMgdm9pZCBzbW11X3NldHVwX3JlZ3Moc3RydWN0
IHNtbXVfZGV2aWNlICpzbW11KQ0KIA0KIAlzbW11X2ZsdXNoX3JlZ3Moc21tdSwgMSk7DQogDQot
CXZhbCA9IGFoYl9yZWFkKHNtbXUsIEFIQl9YQkFSX0NUUkwpOw0KLQl2YWwgfD0gQUhCX1hCQVJf
Q1RSTF9TTU1VX0lOSVRfRE9ORV9ET05FIDw8DQotCQlBSEJfWEJBUl9DVFJMX1NNTVVfSU5JVF9E
T05FX1NISUZUOw0KLQlhaGJfd3JpdGUoc21tdSwgdmFsLCBBSEJfWEJBUl9DVFJMKTsNCisJcmV0
dXJuIHRlZ3JhX2FoYl9lbmFibGVfc21tdShzbW11LT5haGIpOw0KIH0NCiANCiBzdGF0aWMgdm9p
ZCBmbHVzaF9wdGNfYW5kX3RsYihzdHJ1Y3Qgc21tdV9kZXZpY2UgKnNtbXUsDQpAQCAtODczLDU5
ICs4OTcsNzcgQEAgc3RhdGljIGludCB0ZWdyYV9zbW11X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQogew0KIAlzdHJ1Y3Qgc21tdV9kZXZpY2UgKnNtbXUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCisJaW50IGVycjsNCiANCiAJc3Bpbl9sb2NrX2ly
cXNhdmUoJnNtbXUtPmxvY2ssIGZsYWdzKTsNCi0Jc21tdV9zZXR1cF9yZWdzKHNtbXUpOw0KKwll
cnIgPSBzbW11X3NldHVwX3JlZ3Moc21tdSk7DQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNt
bXUtPmxvY2ssIGZsYWdzKTsNCi0JcmV0dXJuIDA7DQorCXJldHVybiBlcnI7DQogfQ0KIA0KIHN0
YXRpYyBpbnQgdGVncmFfc21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IHsNCiAJc3RydWN0IHNtbXVfZGV2aWNlICpzbW11Ow0KLQlzdHJ1Y3QgcmVzb3VyY2UgKnJlZ3Ms
ICpyZWdzMiwgKndpbmRvdzsNCiAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCi0J
aW50IGksIGVyciA9IDA7DQorCWludCBpLCBhc2lkcywgZXJyID0gMDsNCisJZG1hX2FkZHJfdCBi
YXNlOw0KKwlzaXplX3Qgc2l6ZTsNCisJY29uc3Qgdm9pZCAqcHJvcDsNCiANCiAJaWYgKHNtbXVf
aGFuZGxlKQ0KIAkJcmV0dXJuIC1FSU87DQogDQogCUJVSUxEX0JVR19PTihQQUdFX1NISUZUICE9
IFNNTVVfUEFHRV9TSElGVCk7DQogDQotCXJlZ3MgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDApOw0KLQlyZWdzMiA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMSk7DQotCXdpbmRvdyA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMik7DQotCWlmICghcmVncyB8fCAhcmVnczIgfHwgIXdp
bmRvdykgew0KLQkJZGV2X2VycihkZXYsICJObyBTTU1VIHJlc291cmNlc1xuIik7DQotCQlyZXR1
cm4gLUVOT0RFVjsNCi0JfQ0KLQ0KIAlzbW11ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpz
bW11KSwgR0ZQX0tFUk5FTCk7DQogCWlmICghc21tdSkgew0KIAkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gYWxsb2NhdGUgc21tdV9kZXZpY2VcbiIpOw0KIAkJcmV0dXJuIC1FTk9NRU07DQogCX0N
CiANCi0Jc21tdS0+ZGV2ID0gZGV2Ow0KLQlzbW11LT5udW1fYXMgPSBTTU1VX05VTV9BU0lEUzsN
Ci0Jc21tdS0+aW92bW1fYmFzZSA9ICh1bnNpZ25lZCBsb25nKXdpbmRvdy0+c3RhcnQ7DQotCXNt
bXUtPnBhZ2VfY291bnQgPSByZXNvdXJjZV9zaXplKHdpbmRvdykgPj4gU01NVV9QQUdFX1NISUZU
Ow0KLQlzbW11LT5yZWdzID0gZGV2bV9pb3JlbWFwKGRldiwgcmVncy0+c3RhcnQsIHJlc291cmNl
X3NpemUocmVncykpOw0KLQlzbW11LT5yZWdzX2FoYmFyYiA9IGRldm1faW9yZW1hcChkZXYsIHJl
Z3MyLT5zdGFydCwNCi0JCQkJCSByZXNvdXJjZV9zaXplKHJlZ3MyKSk7DQotCWlmICghc21tdS0+
cmVncyB8fCAhc21tdS0+cmVnc19haGJhcmIpIHsNCi0JCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRv
IHJlbWFwIFNNTVUgcmVnaXN0ZXJzXG4iKTsNCi0JCWVyciA9IC1FTlhJTzsNCi0JCWdvdG8gZmFp
bDsNCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoc21tdS0+cmVncyk7IGkrKykgew0KKwkJ
c3RydWN0IHJlc291cmNlICpyZXM7DQorDQorCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
cGRldiwgSU9SRVNPVVJDRV9NRU0sIGkpOw0KKwkJaWYgKCFyZXMpDQorCQkJcmV0dXJuIC1FTk9E
RVY7DQorCQlzbW11LT5yZWdzW2ldID0gZGV2bV9yZXF1ZXN0X2FuZF9pb3JlbWFwKCZwZGV2LT5k
ZXYsIHJlcyk7DQorCQlpZiAoIXNtbXUtPnJlZ3NbaV0pDQorCQkJcmV0dXJuIC1FQlVTWTsNCiAJ
fQ0KIA0KKwllcnIgPSBvZl9nZXRfZG1hX3dpbmRvdyhkZXYtPm9mX25vZGUsICJkbWEtd2luZG93
IiwgMCwgTlVMTCwNCisJCQkJJmJhc2UsICZzaXplKTsNCisJaWYgKGVycikNCisJCXJldHVybiAt
RU5PREVWOw0KKw0KKwlzaXplID4+PSBTTU1VX1BBR0VfU0hJRlQ7DQorCWlmICghc2l6ZSkNCisJ
CXJldHVybiAtRU5PREVWOw0KKw0KKwlwcm9wID0gb2ZfZ2V0X3Byb3BlcnR5KGRldi0+b2Zfbm9k
ZSwgIm52aWRpYSwjYXNpZHMiLCBOVUxMKTsNCisJaWYgKCFwcm9wKQ0KKwkJcmV0dXJuIC1FTk9E
RVY7DQorCWFzaWRzID0gYmUzMl90b19jcHVwKHByb3ApOw0KKwlpZiAoIWFzaWRzKQ0KKwkJcmV0
dXJuIC1FTk9ERVY7DQorDQorCXNtbXUtPmFoYiA9IG9mX3BhcnNlX3BoYW5kbGUocGRldi0+ZGV2
Lm9mX25vZGUsICJudmlkaWEsYWhiIiwgMCk7DQorCWlmICghc21tdS0+YWhiKQ0KKwkJcmV0dXJu
IC1FTk9ERVY7DQorDQorCXNtbXUtPmRldiA9IGRldjsNCisJc21tdS0+bnVtX2FzID0gYXNpZHM7
DQorCXNtbXUtPmlvdm1tX2Jhc2UgPSBiYXNlOw0KKwlzbW11LT5wYWdlX2NvdW50ID0gc2l6ZTsN
CisNCiAJc21tdS0+dHJhbnNsYXRpb25fZW5hYmxlXzAgPSB+MDsNCiAJc21tdS0+dHJhbnNsYXRp
b25fZW5hYmxlXzEgPSB+MDsNCiAJc21tdS0+dHJhbnNsYXRpb25fZW5hYmxlXzIgPSB+MDsNCiAJ
c21tdS0+YXNpZF9zZWN1cml0eSA9IDA7DQogDQogCXNtbXUtPmFzID0gZGV2bV9remFsbG9jKGRl
diwNCi0JCQlzaXplb2Yoc21tdS0+YXNbMF0pICogc21tdS0+bnVtX2FzLCBHRlBfS0VSTkVMKTsN
CisJCQkJc2l6ZW9mKHNtbXUtPmFzWzBdKSAqIHNtbXUtPm51bV9hcywgR0ZQX0tFUk5FTCk7DQog
CWlmICghc21tdS0+YXMpIHsNCiAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIHNt
bXVfYXNcbiIpOw0KIAkJZXJyID0gLUVOT01FTTsNCkBAIC05NDUsNyArOTg3LDkgQEAgc3RhdGlj
IGludCB0ZWdyYV9zbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQlJ
TklUX0xJU1RfSEVBRCgmYXMtPmNsaWVudCk7DQogCX0NCiAJc3Bpbl9sb2NrX2luaXQoJnNtbXUt
PmxvY2spOw0KLQlzbW11X3NldHVwX3JlZ3Moc21tdSk7DQorCWVyciA9IHNtbXVfc2V0dXBfcmVn
cyhzbW11KTsNCisJaWYgKGVycikNCisJCWdvdG8gZmFpbDsNCiAJcGxhdGZvcm1fc2V0X2RydmRh
dGEocGRldiwgc21tdSk7DQogDQogCXNtbXUtPmF2cF92ZWN0b3JfcGFnZSA9IGFsbG9jX3BhZ2Uo
R0ZQX0tFUk5FTCk7DQpAQCAtOTU4LDEwICsxMDAyLDYgQEAgc3RhdGljIGludCB0ZWdyYV9zbW11
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogZmFpbDoNCiAJaWYgKHNtbXUt
PmF2cF92ZWN0b3JfcGFnZSkNCiAJCV9fZnJlZV9wYWdlKHNtbXUtPmF2cF92ZWN0b3JfcGFnZSk7
DQotCWlmIChzbW11LT5yZWdzKQ0KLQkJZGV2bV9pb3VubWFwKGRldiwgc21tdS0+cmVncyk7DQot
CWlmIChzbW11LT5yZWdzX2FoYmFyYikNCi0JCWRldm1faW91bm1hcChkZXYsIHNtbXUtPnJlZ3Nf
YWhiYXJiKTsNCiAJaWYgKHNtbXUgJiYgc21tdS0+YXMpIHsNCiAJCWZvciAoaSA9IDA7IGkgPCBz
bW11LT5udW1fYXM7IGkrKykgew0KIAkJCWlmIChzbW11LT5hc1tpXS5wZGlyX3BhZ2UpIHsNCkBA
IC05OTMsOCArMTAzMyw2IEBAIHN0YXRpYyBpbnQgdGVncmFfc21tdV9yZW1vdmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCiAJCV9fZnJlZV9wYWdlKHNtbXUtPmF2cF92ZWN0b3JfcGFn
ZSk7DQogCWlmIChzbW11LT5yZWdzKQ0KIAkJZGV2bV9pb3VubWFwKGRldiwgc21tdS0+cmVncyk7
DQotCWlmIChzbW11LT5yZWdzX2FoYmFyYikNCi0JCWRldm1faW91bm1hcChkZXYsIHNtbXUtPnJl
Z3NfYWhiYXJiKTsNCiAJZGV2bV9rZnJlZShkZXYsIHNtbXUpOw0KIAlzbW11X2hhbmRsZSA9IE5V
TEw7DQogCXJldHVybiAwOw0KQEAgLTEwMDUsNiArMTA0MywxNCBAQCBjb25zdCBzdHJ1Y3QgZGV2
X3BtX29wcyB0ZWdyYV9zbW11X3BtX29wcyA9IHsNCiAJLnJlc3VtZQkJPSB0ZWdyYV9zbW11X3Jl
c3VtZSwNCiB9Ow0KIA0KKyNpZmRlZiBDT05GSUdfT0YNCitzdGF0aWMgc3RydWN0IG9mX2Rldmlj
ZV9pZCB0ZWdyYV9zbW11X29mX21hdGNoW10gX19kZXZpbml0ZGF0YSA9IHsNCisJeyAuY29tcGF0
aWJsZSA9ICJudmlkaWEsdGVncmEzMC1zbW11IiwgfSwNCisJeyB9LA0KK307DQorTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgdGVncmFfc21tdV9vZl9tYXRjaCk7DQorI2VuZGlmDQorDQogc3RhdGlj
IHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgdGVncmFfc21tdV9kcml2ZXIgPSB7DQogCS5wcm9iZQkJ
PSB0ZWdyYV9zbW11X3Byb2JlLA0KIAkucmVtb3ZlCQk9IHRlZ3JhX3NtbXVfcmVtb3ZlLA0KQEAg
LTEwMTIsNiArMTA1OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHRlZ3JhX3Nt
bXVfZHJpdmVyID0gew0KIAkJLm93bmVyCT0gVEhJU19NT0RVTEUsDQogCQkubmFtZQk9ICJ0ZWdy
YS1zbW11IiwNCiAJCS5wbQk9ICZ0ZWdyYV9zbW11X3BtX29wcywNCisJCS5vZl9tYXRjaF90YWJs
ZSA9IG9mX21hdGNoX3B0cih0ZWdyYV9zbW11X29mX21hdGNoKSwNCiAJfSwNCiB9Ow0KIA0KQEAg
LTEwMzEsNCArMTA3OCw1IEBAIG1vZHVsZV9leGl0KHRlZ3JhX3NtbXVfZXhpdCk7DQogDQogTU9E
VUxFX0RFU0NSSVBUSU9OKCJJT01NVSBBUEkgZm9yIFNNTVUgaW4gVGVncmEzMCIpOw0KIE1PRFVM
RV9BVVRIT1IoIkhpcm9zaGkgRE9ZVSA8aGRveXVAbnZpZGlhLmNvbT4iKTsNCitNT0RVTEVfQUxJ
QVMoInBsYXRmb3JtOnRlZ3JhLXNtbXUiKTsNCiBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQot
LSANCjEuNy41LjQNCg0K

--_002_201205071447581558303336683449254hdoyunvidiacom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--_002_201205071447581558303336683449254hdoyunvidiacom_--
