Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EDCC433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:19:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896456146D
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 09:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896456146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 282BB4031D;
	Mon, 10 May 2021 09:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B-Oa5-ujdIOy; Mon, 10 May 2021 09:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B65540317;
	Mon, 10 May 2021 09:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68C9DC000E;
	Mon, 10 May 2021 09:19:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B42AEC0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DA0C40318
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4_Gk0kgNMEDN for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 09:19:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43D8040317
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 09:19:25 +0000 (UTC)
Received: from dggeml706-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FdwPR5c7fzWgmZ;
 Mon, 10 May 2021 17:15:07 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggeml706-chm.china.huawei.com (10.3.17.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 10 May 2021 17:19:20 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:19:19 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 10 May 2021 10:19:17 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
Thread-Topic: [PATCH v3 08/10] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
Thread-Index: AQHXQygBB9Vpe9n6UUKndwgDQTx/5KrcZBEg
Date: Mon, 10 May 2021 09:19:17 +0000
Message-ID: <241042b6d1ea45f790e0766c6f5d3542@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-9-shameerali.kolothum.thodi@huawei.com>
 <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
In-Reply-To: <7ec85477-9c02-17de-9620-f0b153adcc82@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.9]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IFttYWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDA3IE1heSAyMDIx
IDExOjAyDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90
aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZw0KPiBDYzogTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsb3Jl
bnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiBqb3JvQDhieXRlcy5vcmc7IHdhbmdodWlxaWFuZyA8
d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+OyBHdW9oYW5qdW4NCj4gKEhhbmp1biBHdW8pIDxndW9o
YW5qdW5AaHVhd2VpLmNvbT47IHN0ZXZlbi5wcmljZUBhcm0uY29tOw0KPiBTYW1pLk11amF3YXJA
YXJtLmNvbTsgam9uQHNvbGlkLXJ1bi5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDA4LzEwXSBpb21tdS9hcm0tc21tdS12MzogUmVzZXJ2ZSBhbnkg
Uk1SIHJlZ2lvbnMNCj4gYXNzb2NpYXRlZCB3aXRoIGEgZGV2DQo+IA0KPiBPbiAyMDIxLTA0LTIw
IDA5OjI3LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEdldCBSTVIgcmVnaW9ucyBhc3Nv
Y2lhdGVkIHdpdGggYSBkZXbCoHJlc2VydmVkIHNvIHRoYXQgdGhlcmUgaXMNCj4gPiBhIHVuaXR5
IG1hcHBpbmcgZm9yIHRoZW0gaW7CoFNNTVUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFt
ZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+
ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
IHwgMjkNCj4gKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMNCj4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12
My9hcm0tc21tdS12My5jDQo+ID4gaW5kZXggMTRlOWM3MDM0YzA0Li44YmFjZWRmN2JiMzQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMN
Cj4gPiBAQCAtMjUzMSw2ICsyNTMxLDM0IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfb2ZfeGxhdGUo
c3RydWN0IGRldmljZSAqZGV2LA0KPiBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICphcmdzKQ0KPiA+
ICAgCXJldHVybiBpb21tdV9md3NwZWNfYWRkX2lkcyhkZXYsIGFyZ3MtPmFyZ3MsIDEpOw0KPiA+
ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBib29sIGFybV9zbW11X2Rldl9oYXNfcm1yKHN0cnVjdCBh
cm1fc21tdV9tYXN0ZXIgKm1hc3RlciwNCj4gPiArCQkJCSBzdHJ1Y3QgaW9tbXVfcm1yICplKQ0K
PiA+ICt7DQo+ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbWFzdGVy
LT5udW1fc2lkczsgaSsrKSB7DQo+ID4gKwkJaWYgKGUtPnNpZCA9PSBtYXN0ZXItPnNpZHNbaV0p
DQo+ID4gKwkJCXJldHVybiB0cnVlOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBmYWxz
ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXJtX3NtbXVfcm1yX2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICsJCQkJCSAgc3RydWN0IGxpc3RfaGVh
ZCAqaGVhZCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyID0g
ZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7DQo+ID4gKwlzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpz
bW11ID0gbWFzdGVyLT5zbW11Ow0KPiA+ICsJc3RydWN0IGlvbW11X3JtciAqcm1yOw0KPiA+ICsN
Cj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkocm1yLCAmc21tdS0+cm1yX2xpc3QsIGxpc3QpIHsN
Cj4gPiArCQlpZiAoIWFybV9zbW11X2Rldl9oYXNfcm1yKG1hc3Rlciwgcm1yKSkNCj4gPiArCQkJ
Y29udGludWU7DQo+ID4gKw0KPiA+ICsJCWlvbW11X2RtYV9nZXRfcm1yX3Jlc3ZfcmVnaW9ucyhk
ZXYsIHJtciwgaGVhZCk7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+IA0KPiBUQkggSSB3b3Vs
ZG4ndCBoYXZlIHRob3VnaHQgd2UgbmVlZCBhIGRyaXZlci1zcGVjaWZpYyBob29rIGZvciB0aGlz
LCBvcg0KPiBpcyBpdCB0b28gcGFpbmZ1bCB0byBjb3JyZWxhdGUgZndzcGVjLT5pb21tdV9md25v
ZGUgYmFjayB0byB0aGUgcmVsZXZhbnQNCj4gSU9SVCBub2RlIGdlbmVyaWNhbGx5Pw0KDQpGcm9t
IGEgcXVpY2sgbG9vaywgSSB0aGluayBJIGNvdWxkIGdldCByaWQgb2YgdGhlIGFib3ZlIHdpdGgg
c29tZXRoaW5nIGxpa2UgYmVsb3csDQoNCi0tLS0tLTg8LS0tLQ0KK3N0YXRpYyBib29sIGlvbW11
X2RtYV9kZXZfaGFzX3JtcihzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvbW11X3JtciAqZSkNCit7DQorICAgICAg
IGludCBpOw0KKw0KKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgZndzcGVjLT5udW1faWRzOyBpKysp
IHsNCisgICAgICAgICAgICAgICAgaWYgKGUtPnNpZCA9PSBmd3NwZWMtPmlkc1tpXSkNCisgICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCisgICAgICAgIH0NCisNCisgICAgICAg
IHJldHVybiBmYWxzZTsNCit9DQorDQorDQordm9pZCBpb21tdV9kbWFfZ2V0X3Jtcl9yZXN2X3Jl
Z2lvbnMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbGlzdF9oZWFkICpsaXN0KQ0KK3sNCisg
ICAgICAgc3RydWN0IGlvbW11X2Z3c3BlYyAqZndzcGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQo
ZGV2KTsNCisgICAgICAgc3RydWN0IGxpc3RfaGVhZCBybXJfbGlzdDsNCisgICAgICAgc3RydWN0
IGlvbW11X3JtciAqcm1yOw0KKw0KKyAgICAgICBJTklUX0xJU1RfSEVBRCgmcm1yX2xpc3QpOw0K
KyAgICAgICBpZiAoaW9tbXVfZG1hX2dldF9ybXJzKGZ3c3BlYy0+aW9tbXVfZndub2RlLCAmcm1y
X2xpc3QpKQ0KKyAgICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgLi4uDQorICAgICAgIGxp
c3RfZm9yX2VhY2hfZW50cnkocm1yLCAmcm1yX2xpc3QsIGxpc3QpIHsNCisgICAgIA0KKyAgICAg
ICBpZiAoIWlvbW11X2RtYV9kZXZfaGFzX3Jtcihmd3NwZWMsIHJtcikNCisgICAgICAgICAgIGNv
bnRpbnVlOw0KKyAgICAgICAgICAuLi4gDQorICAgICAgICAgICAgICAgcmVnaW9uID0gaW9tbXVf
YWxsb2NfcmVzdl9yZWdpb24ocm1yLT5iYXNlX2FkZHJlc3MsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm1yLT5sZW5ndGgsIHByb3QsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZSk7DQogICAgICAg
ICAuLi4NCisgICAgICAgfQ0KK30NCiAvKioNCiAgKiBpb21tdV9kbWFfZ2V0X3Jlc3ZfcmVnaW9u
cyAtIFJlc2VydmVkIHJlZ2lvbiBkcml2ZXIgaGVscGVyDQogICogQGRldjogRGV2aWNlIGZyb20g
aW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucygpDQpAQCAtMTg4LDEwICsyNDIsMTEgQEAgdm9pZCBpb21t
dV9kbWFfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBsaXN0X2hl
YWQgKmxpc3QpDQogICAgICAgIGlmICghaXNfb2Zfbm9kZShkZXZfaW9tbXVfZndzcGVjX2dldChk
ZXYpLT5pb21tdV9md25vZGUpKQ0KICAgICAgICAgICAgICAgIGlvcnRfaW9tbXVfbXNpX2dldF9y
ZXN2X3JlZ2lvbnMoZGV2LCBsaXN0KTsNCiANCisgICAgICAgaW9tbXVfZG1hX2dldF9ybXJfcmVz
dl9yZWdpb25zKGRldiwgbGlzdCk7DQogfQ0KDQotLS0tODwtLS0tDQoNCkJ1dCBsb29raW5nIGF0
IHRoZSBTTU1VdjIgY29kZSwgdGhlIGZ3c3BlYy0+aWRzIGlzIE1BU0s6U0lELCBzbyBJIGFtIG5v
dA0Kc3VyZSB0aGUgUk1SIHNpZCBjYW4gYmUgY29tcGFyZWQgZGlyZWN0bHkgdG8gZndzcGVjLT5p
ZHMgYWJvdmUuIFJpZ2h0PyBPcg0KaXMgdGhlcmUgYSBiZXR0ZXIgd2F5IGhlcmU/DQoNClRoYW5r
cywNClNoYW1lZXINCg0KDQo+IA0KPiA+ICAgc3RhdGljIHZvaWQgYXJtX3NtbXVfZ2V0X3Jlc3Zf
cmVnaW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gICAJCQkJICAgICAgc3RydWN0IGxpc3Rf
aGVhZCAqaGVhZCkNCj4gPiAgIHsNCj4gPiBAQCAtMjU0NSw2ICsyNTczLDcgQEAgc3RhdGljIHZv
aWQgYXJtX3NtbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+ID4g
ICAJbGlzdF9hZGRfdGFpbCgmcmVnaW9uLT5saXN0LCBoZWFkKTsNCj4gPg0KPiA+ICAgCWlvbW11
X2RtYV9nZXRfcmVzdl9yZWdpb25zKGRldiwgaGVhZCk7DQo+ID4gKwlhcm1fc21tdV9ybXJfZ2V0
X3Jlc3ZfcmVnaW9ucyhkZXYsIGhlYWQpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgYm9v
bCBhcm1fc21tdV9kZXZfaGFzX2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
