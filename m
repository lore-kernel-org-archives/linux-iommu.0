Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25712C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:00:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3327E2067C
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3327E2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AABB8750F;
	Fri,  6 Nov 2020 16:00:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33vyxj3QTt8Z; Fri,  6 Nov 2020 16:00:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC00787268;
	Fri,  6 Nov 2020 16:00:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C306C088B;
	Fri,  6 Nov 2020 16:00:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01BB7C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D72F987500
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kZiMmzdtwUY6 for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 16:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C9C9487268
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:00:27 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CSQ6z4HCGz67JFN;
 Fri,  6 Nov 2020 23:59:07 +0800 (CST)
Received: from lhreml712-chm.china.huawei.com (10.201.108.63) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 17:00:24 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 6 Nov 2020 16:00:23 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Fri, 6 Nov 2020 16:00:23 +0000
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>
Subject: RE: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
Thread-Topic: [RFC PATCH 3/4] ACPI/IORT: Add RMR memory regions reservation
 helper
Thread-Index: AQHWrFRUv2Y1mvStkkOY+RTCtTFo26m542gAgADmoJCAAFiCAIAAL5TA
Date: Fri, 6 Nov 2020 16:00:23 +0000
Message-ID: <4e1e1d3d873049cfaedda14a1187e1cd@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <20201027112646.44680-4-shameerali.kolothum.thodi@huawei.com>
 <327e6475-eb48-33a1-ef38-fae9df3bf0cb@arm.com>
 <66c52ba92d274adb818d03d2e6813f0a@huawei.com>
 <b0123797-4b49-8256-1080-36b9a6f7eee6@arm.com>
In-Reply-To: <b0123797-4b49-8256-1080-36b9a6f7eee6@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.181]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, wanghuiqiang <wanghuiqiang@huawei.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDA2IE5vdmVtYmVyIDIwMjAgMTM6
MDYNCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0u
dGhvZGlAaHVhd2VpLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnOyBkZXZlbEBhY3BpY2Eub3JnDQo+IENjOiBMaW51eGFybSA8bGludXhhcm1AaHVh
d2VpLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGpvcm9AOGJ5dGVzLm9yZzsg
d2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlhbmdAaHVhd2VpLmNvbT47IEd1b2hhbmp1bg0KPiAoSGFu
anVuIEd1bykgPGd1b2hhbmp1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzLzRd
IEFDUEkvSU9SVDogQWRkIFJNUiBtZW1vcnkgcmVnaW9ucyByZXNlcnZhdGlvbg0KPiBoZWxwZXIN
Cj4gDQo+IE9uIDIwMjAtMTEtMDYgMDg6MzAsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBSb2JpbiBNdXJwaHkgW21haWx0bzpyb2Jpbi5tdXJwaHlAYXJtLmNvbV0NCj4gPj4gU2VudDog
MDUgTm92ZW1iZXIgMjAyMCAxODowNA0KPiA+PiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9k
aSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gPj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsN
Cj4gPj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGRldmVsQGFjcGljYS5vcmcN
Cj4gPj4gQ2M6IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsNCj4gPj4gam9yb0A4Ynl0ZXMub3JnOyB3YW5naHVpcWlhbmcgPHdhbmdodWlx
aWFuZ0BodWF3ZWkuY29tPjsgR3VvaGFuanVuDQo+ID4+IChIYW5qdW4gR3VvKSA8Z3VvaGFuanVu
QGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+ID4+IDxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDMvNF0gQUNQSS9JT1JUOiBB
ZGQgUk1SIG1lbW9yeSByZWdpb25zDQo+IHJlc2VydmF0aW9uDQo+ID4+IGhlbHBlcg0KPiA+Pg0K
PiA+PiBPbiAyMDIwLTEwLTI3IDExOjI2LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4g
QWRkIGEgaGVscGVyIGZ1bmN0aW9uIHRoYXQgcmV0cmlldmVzIFJNUiBtZW1vcnkgZGVzY3JpcHRv
cnMNCj4gPj4+IGFzc29jaWF0ZWQgd2l0aCBhIGdpdmVuIGVuZHBvaW50IGRldi4gVGhlc2UgbWVt
b3J5IHJlZ2lvbnMNCj4gPj4+IHNob3VsZCBoYXZlIGEgdW5pdHnCoG1hcHBpbmcgaW4gdGhlIFNN
TVUuIFNvIHJlc2VydmUgdGhlbSBhcw0KPiA+Pj4gSU9NTVVfUkVTVl9ESVJFQ1QuDQo+ID4+DQo+
ID4+IEFzIGEgZ2VuZXJhbCBvYnNlcnZhdGlvbiwgd2UgYWxzbyBuZWVkIGEgd2F5IGludG8gdGhp
cyB0aGF0IGlzbid0IGZyb20NCj4gPj4gdGhlIHBlcnNwZWN0aXZlIG9mIGVuZHBvaW50IGRldmlj
ZXMuIFdpdGggU01NVXYzIHdlIG5lZWQgdG8ga25vdyBhbGwgdGhlDQo+ID4+IGFjdGl2ZSBzdHJl
YW0gSURzIHJlbGV2YW50IHRvIGEgZ2l2ZW4gU01NVSBpbnN0YW5jZSBhdCBwcm9iZSB0aW1lLCBz
bw0KPiA+PiB0aGF0IHdlIGNhbiBzZXQgdXAgc29tZSBraW5kIG9mIHZhbGlkIHN0cmVhbSB0YWJs
ZSBlbnRyaWVzICpiZWZvcmUqDQo+ID4+IGVuYWJsaW5nIHRoZSBTTU1VIGluIHRoZSByZXNldCBy
b3V0aW5lLg0KPiA+DQo+ID4gU28gSSBndWVzcywgdGhlIGlkZWEgaXMgdG8gcHJvdmlkZSBhbiBp
bnRlcmZhY2UgaGVyZSB0byByZXRyaWV2ZSB0aG9zZSBhY3RpdmUNCj4gPiBzdHJlYW0gSWRzPyBU
aGUgcHJvYmxlbSBpcywgYXQgcHJlc2VudChBRkFJQ1MpLCBSTVIgZG9lc27igJl0IGhhdmUgYW55
DQo+ID4gbWVhbnMgdG8gc3BlY2lmeSBzdWNoIGRldmljZXMuDQo+IA0KPiBJJ20gdGhpbmtpbmcg
d2UgbmVlZCB0byBjaGVjayBpZiBhbnkgUk1ScyBleGlzdCBpbiB0aGUgSU9SVCwgaWYgc28gZmlu
ZA0KPiB0aGUgZGV2aWNlcyB0aGF0IG1hcCB0byB0aGVtLCB0aGVuIHJlc29sdmUgdGhvc2UgZGV2
aWNlcycgSUQgbWFwcGluZ3MuDQo+IEluIHRlcm1zIG9mIHRoZSBpbnRlcmZhY2UsIG1heWJlIHRo
ZSBiZXR0ZXIgb3B0aW9uIGlzIHRvIGRvIHNvbWV0aGluZw0KPiBjbG9zZXIgdG8gd2hhdCBpbnRl
bC1pb21tdSBkb2VzIGFuZCBoYW5kbGUgKmFsbCogdGhlIHByb2Nlc3NpbmcgdXAtZnJvbnQNCj4g
LSBsZXQgdGhlIElPTU1VIGRyaXZlciBqdXN0IGNhbGwgaW50byB0aGUgZmlybXdhcmUgY29kZSBv
bmNlIHRvIHJldHJpZXZlDQo+IGEgY29tcGxldGUgbGlzdCBvZiBhbGwgdGhlIHJlbGV2YW50IGFi
c3RyYWN0ZWQgUk1SIChvciBEVCBlcXVpdmFsZW50KQ0KPiBpbmZvcm1hdGlvbiwgc28gaXQgY2Fu
IHRoZW4gcmVzb2x2ZSBib3RoIGl0cyBvd24gZWFybHkgaW5pdGlhbGlzYXRpb24NCj4gYW5kIHRo
ZSBsYXRlciBwZXItZGV2aWNlIHNldHVwIHdpdGhvdXQgY2FsbGluZyBiYWNrIGludG8gZmlybXdh
cmUgY29kZQ0KPiBhZ2Fpbi4NCg0KT2suIEkgd2lsbCB0cnkgdG8gY2hhbmdlIHRoZSBpbnRlcmZh
Y2UgdGhlbi4NCg0KPiA+ICAgT3RoZXJ3aXNlIHdlJ3JlIGp1c3QgZ29pbmcgdG8NCj4gPj4ga2ls
bCBvbmdvaW5nIHRyYWZmaWMgKGUuZy4gRUZJIEdPUCkgd2l0aCBDX0JBRF9TVEUgbG9uZyBiZWZv
cmUgd2UgZXZlcg0KPiA+PiBzdGFydCBhZGRpbmcgZGV2aWNlcyBhbmQgd29ycnlpbmcgYWJvdXQg
cmVzZXJ2ZWQgcmVnaW9ucyBmb3IgdGhlbS4NCj4gPj4gU2ltaWxhcmx5IGZvciB0aGUgaW5pdGlh
bCBTTVIvUzJDUiBzdGF0ZSBvbiBTTU1VdjIgd2l0aCBkaXNhYmxlX2J5cGFzcy4NCj4gPg0KPiA+
IE9rLiBJIHNlZSB0aGUgZGlzY3Vzc2lvbiBoZXJlLA0KPiA+DQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWlvbW11LzQ4NGI5ZTkwLTczOTUtNjE2MS01NzdjLTRkM2YzNzE2OTk3ZQ0K
PiBAYXJtLmNvbS8NCj4gPg0KPiA+ICBGcm9tIHdoYXQgSSBnYXRoZXIsIHRoZSBwbGFuIGlzIHRv
IHNldHVwIGEgZGVmYXVsdCBJREVOVElUWV9ET01BSU4gZm9yDQo+ID4gZGV2aWNlcyB0aGF0IGhh
dmUgbGl2ZSBzdHJlYW0gZ29pbmcgb24gZHVyaW5nIGJvb3QvU01NVSBwcm9iZSB0aW1lLg0KPiAN
Cj4gV2VsbCwgd2hldGhlciB3ZSB1c2UgYnlwYXNzIG9yIGEgdGVtcG9yYXJ5IHRyYW5zbGF0aW9u
IGNvbnRleHQgZm9yIHRoZQ0KPiBwZXJpb2QgYmVmb3JlIHdlIGV2ZW4gZ2V0IHRvIGRlZmF1bHQg
ZG9tYWlucy4uLiB0aGF0J3MgYSBkaXNjdXNzaW9uIHRoYXQNCj4gY2FuIHdhaXQgdW50aWwgd2Ug
aGF2ZSB0aGUgYWJpbGl0eSB0byBzZXQgdXAgdGhlIFNURXMgYXQgYWxsIDspDQoNClN1cmUuDQoN
ClRoYW5rcywNClNoYW1lZXINCiANCj4gUm9iaW4uDQo+IA0KPiA+Pj4gU2lnbmVkLW9mZi1ieTog
U2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIHwgNTYNCj4g
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgICBpbmNs
dWRlL2xpbnV4L2FjcGlfaW9ydC5oIHwgIDQgKysrDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQs
IDYwIGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3Bp
L2FybTY0L2lvcnQuYyBiL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gPj4+IGluZGV4IGIz
MmNkNTNjY2EwOC4uYzA3MDAxNDllNjBiIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9hY3Bp
L2FybTY0L2lvcnQuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYw0KPiA+
Pj4gQEAgLTg0Miw2ICs4NDIsNjAgQEAgc3RhdGljIGlubGluZSBpbnQgaW9ydF9hZGRfZGV2aWNl
X3JlcGxheShzdHJ1Y3QNCj4gPj4gZGV2aWNlICpkZXYpDQo+ID4+PiAgICAJcmV0dXJuIGVycjsN
Cj4gPj4+ICAgIH0NCj4gPj4+DQo+ID4+PiArc3RhdGljIGJvb2wgaW9ydF9kZXZfaGFzX3Jtcihz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBpb3J0X3Jtcl9lbnRyeQ0KPiAqZSkNCj4gPj4+ICt7
DQo+ID4+PiArCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3BlYyA9IGRldl9pb21tdV9md3NwZWNf
Z2V0KGRldik7DQo+ID4+PiArCXN0cnVjdCBhY3BpX2lvcnRfbm9kZSAqaW9tbXU7DQo+ID4+PiAr
CXN0cnVjdCBpb3J0X3Jtcl9pZCAqcm1yX2lkcyA9IGUtPnJtcl9pZHM7DQo+ID4+PiArCWludCBp
LCBqOw0KPiA+Pj4gKw0KPiA+Pj4gKwlpb21tdSA9IGlvcnRfZ2V0X2lvcnRfbm9kZShmd3NwZWMt
PmlvbW11X2Z3bm9kZSk7DQo+ID4+PiArDQo+ID4+PiArCWZvciAoaSA9IDA7IGkgPCBlLT5ybXJf
aWRzX251bTsgaSsrLCBybXJfaWRzKyspIHsNCj4gPj4+ICsJCWZvciAoaiA9IDA7IGogPCBmd3Nw
ZWMtPm51bV9pZHM7IGorKykgew0KPiA+Pj4gKwkJCWlmIChybXJfaWRzLT5zaWQgPT0gZndzcGVj
LT5pZHNbal0gJiYNCj4gPj4+ICsJCQkgICAgcm1yX2lkcy0+c21tdSA9PSBpb21tdSkNCj4gPj4+
ICsJCQkJcmV0dXJuIHRydWU7DQo+ID4+PiArCQl9DQo+ID4+PiArCX0NCj4gPj4+ICsNCj4gPj4+
ICsJcmV0dXJuIGZhbHNlOw0KPiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4+ICsvKioNCj4gPj4+ICsg
KiBpb3J0X2Rldl9ybXJfZ2V0X3Jlc3ZfcmVnaW9ucyAtIFJNUiBSZXNlcnZlZCByZWdpb24gZHJp
dmVyIGhlbHBlcg0KPiA+Pj4gKyAqIEBkZXY6IERldmljZSBmcm9tIGlvbW11X2dldF9yZXN2X3Jl
Z2lvbnMoKQ0KPiA+Pj4gKyAqIEBoZWFkOiBSZXNlcnZlZCByZWdpb24gbGlzdCBmcm9tIGlvbW11
X2dldF9yZXN2X3JlZ2lvbnMoKQ0KPiA+Pj4gKyAqDQo+ID4+PiArICogUmV0dXJuczogMCBvbiBz
dWNjZXNzLCA8MCBmYWlsdXJlDQo+ID4+PiArICovDQo+ID4+PiAraW50IGlvcnRfZGV2X3Jtcl9n
ZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZA0KPiA+
PiAqaGVhZCkNCj4gPj4+ICt7DQo+ID4+PiArCXN0cnVjdCBpb3J0X3Jtcl9lbnRyeSAqZTsNCj4g
Pj4+ICsNCj4gPj4+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmaW9ydF9ybXJfbGlzdCwgbGlz
dCkgew0KPiA+Pj4gKwkJc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb247DQo+ID4+PiAr
CQlzdHJ1Y3QgYWNwaV9pb3J0X3Jtcl9kZXNjICpybXI7DQo+ID4+PiArCQlpbnQgcHJvdCA9IElP
TU1VX1JFQUQgfCBJT01NVV9XUklURSB8DQo+ID4+PiArCQkJICAgSU9NTVVfTk9FWEVDIHwgSU9N
TVVfTU1JTzsNCj4gPj4+ICsNCj4gPj4+ICsJCWlmICghaW9ydF9kZXZfaGFzX3JtcihkZXYsIGUp
KQ0KPiA+Pj4gKwkJCWNvbnRpbnVlOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJcm1yID0gZS0+cm1yX2Rl
c2M7DQo+ID4+PiArCQlyZWdpb24gPSBpb21tdV9hbGxvY19yZXN2X3JlZ2lvbihybXItPmJhc2Vf
YWRkcmVzcywNCj4gPj4+ICsJCQkJCQkgcm1yLT5sZW5ndGgsIHByb3QsDQo+ID4+PiArCQkJCQkJ
IElPTU1VX1JFU1ZfRElSRUNUKTsNCj4gPj4+ICsJCWlmICghcmVnaW9uKSB7DQo+ID4+PiArCQkJ
ZGV2X2VycihkZXYsICJPdXQgb2YgbWVtb3J5IGFsbG9jYXRpbmcgUk1SIHJlZ2lvbnNcbiIpOw0K
PiA+Pj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiA+Pj4gKwkJfQ0KPiA+Pj4gKwkJbGlzdF9hZGRf
dGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsNCj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwly
ZXR1cm4gMDsNCj4gPj4+ICt9DQo+ID4+PiArDQo+ID4+PiAgICAvKioNCj4gPj4+ICAgICAqIGlv
cnRfaW9tbXVfbXNpX2dldF9yZXN2X3JlZ2lvbnMgLSBSZXNlcnZlZCByZWdpb24gZHJpdmVyIGhl
bHBlcg0KPiA+Pj4gICAgICogQGRldjogRGV2aWNlIGZyb20gaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9u
cygpDQo+ID4+PiBAQCAtMTExMiw2ICsxMTY2LDggQEAgaW50IGlvcnRfaW9tbXVfbXNpX2dldF9y
ZXN2X3JlZ2lvbnMoc3RydWN0DQo+ID4+IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpo
ZWFkKQ0KPiA+Pj4gICAgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqaW9ydF9pb21tdV9jb25maWd1
cmVfaWQoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+Pj4gICAgCQkJCQkJY29uc3QgdTMyICppbnB1
dF9pZCkNCj4gPj4+ICAgIHsgcmV0dXJuIE5VTEw7IH0NCj4gPj4+ICtpbnQgaW9ydF9kZXZfcm1y
X2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkDQo+
ID4+ICpoZWFkKQ0KPiA+Pj4gK3sgcmV0dXJuIDA7IH0NCj4gPj4+ICAgICNlbmRpZg0KPiA+Pj4N
Cj4gPj4+ICAgIHN0YXRpYyBpbnQgbmNfZG1hX2dldF9yYW5nZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHU2NCAqc2l6ZSkNCj4gPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5o
IGIvaW5jbHVkZS9saW51eC9hY3BpX2lvcnQuaA0KPiA+Pj4gaW5kZXggMjBhMzIxMjBiYjg4Li42
ZGQ4OWZhZjM0MGMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5o
DQo+ID4+PiArKysgYi9pbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oDQo+ID4+PiBAQCAtMzgsNiAr
MzgsNyBAQCB2b2lkIGlvcnRfZG1hX3NldHVwKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0DQo+ID4+
ICpkbWFfYWRkciwgdTY0ICpzaXplKTsNCj4gPj4+ICAgIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMg
KmlvcnRfaW9tbXVfY29uZmlndXJlX2lkKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4+ICAgIAkJ
CQkJCWNvbnN0IHUzMiAqaWRfaW4pOw0KPiA+Pj4gICAgaW50IGlvcnRfaW9tbXVfbXNpX2dldF9y
ZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gbGlzdF9oZWFkDQo+ID4+
ICpoZWFkKTsNCj4gPj4+ICtpbnQgaW9ydF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkDQo+ID4+ICpoZWFkKTsNCj4gPj4+ICAgICNl
bHNlDQo+ID4+PiAgICBzdGF0aWMgaW5saW5lIHZvaWQgYWNwaV9pb3J0X2luaXQodm9pZCkgeyB9
DQo+ID4+PiAgICBzdGF0aWMgaW5saW5lIHUzMiBpb3J0X21zaV9tYXBfaWQoc3RydWN0IGRldmlj
ZSAqZGV2LCB1MzIgaWQpDQo+ID4+PiBAQCAtNTUsNiArNTYsOSBAQCBzdGF0aWMgaW5saW5lIGNv
bnN0IHN0cnVjdCBpb21tdV9vcHMNCj4gPj4gKmlvcnRfaW9tbXVfY29uZmlndXJlX2lkKA0KPiA+
Pj4gICAgc3RhdGljIGlubGluZQ0KPiA+Pj4gICAgaW50IGlvcnRfaW9tbXVfbXNpX2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gbGlzdF9oZWFkDQo+ID4+ICpo
ZWFkKQ0KPiA+Pj4gICAgeyByZXR1cm4gMDsgfQ0KPiA+Pj4gK3N0YXRpYyBpbmxpbmUNCj4gPj4+
ICtpbnQgaW9ydF9kZXZfcm1yX2dldF9yZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgbGlzdF9oZWFkDQo+ID4+ICpoZWFkKQ0KPiA+Pj4gK3sgcmV0dXJuIDA7IH0NCj4gPj4+
ICAgICNlbmRpZg0KPiA+Pj4NCj4gPj4+ICAgICNlbmRpZiAvKiBfX0FDUElfSU9SVF9IX18gKi8N
Cj4gPj4+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
