Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94045C2D0F2
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:13:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CC02071A
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CC02071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 30CE82639B;
	Wed,  1 Apr 2020 07:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SD8vYmqQpJfX; Wed,  1 Apr 2020 07:13:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C71391FE41;
	Wed,  1 Apr 2020 07:13:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6DEBC1D7F;
	Wed,  1 Apr 2020 07:13:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D38BC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0962E89AC8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nZAP5g9d8+Rt for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 07:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B80E89A55
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:13:43 +0000 (UTC)
IronPort-SDR: 04MRbwcTLe9m7cOV3F18iziW0k9UJd1KCmMb5vnXRm18iavKx6cv3L9tZAkpDhHUU1oTVwkblI
 z1XJbS9klpnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 00:13:42 -0700
IronPort-SDR: j/V9mYQw38f565XZV0f40WaKx8s33Kr6QPs7TWpNd8NMiGo9Ce3fM+0HoILVkFzhKD+0JgCIGo
 AAj3UixF5OTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="249323455"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga003.jf.intel.com with ESMTP; 01 Apr 2020 00:13:41 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 00:13:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 15:13:38 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Topic: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Index: AQHV/w5hiFCIIwap/Eaujod2FPXZGKhdS4kAgAHvP4CAAk70gIABMDKAgACfq4CAAIq7wA==
Date: Wed, 1 Apr 2020 07:13:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
 <20200331135807.4e9976ab@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

PiBGcm9tOiBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgQXByaWwgMSwgMjAyMCAyOjMwIFBNDQo+IFRvOiBKYWNvYiBQYW4gPGphY29iLmp1bi5w
YW5AbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYxMCAwOC8xMV0gaW9t
bXUvdnQtZDogQWRkIHN2bS9zdmEgaW52YWxpZGF0ZSBmdW5jdGlvbg0KPiANCj4gPiBGcm9tOiBK
YWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+IFNlbnQ6IFdlZG5l
c2RheSwgQXByaWwgMSwgMjAyMCA0OjU4IEFNDQo+ID4NCj4gPiBPbiBUdWUsIDMxIE1hciAyMDIw
IDAyOjQ5OjIxICswMDAwDQo+ID4gIlRpYW4sIEtldmluIiA8a2V2aW4udGlhbkBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gPiA+IEZyb206IEF1Z2VyIEVyaWMgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4gPiA+ID4gU2VudDogU3VuZGF5LCBNYXJjaCAyOSwgMjAyMCAxMTozNCBQTQ0KPiA+
ID4gPg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4NCj4gPiA+ID4gT24gMy8yOC8yMCAxMTowMSBBTSwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiA+ID4+IEZyb206IEphY29iIFBhbiA8amFjb2IuanVu
LnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAy
MSwgMjAyMCA3OjI4IEFNDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IFdoZW4gU2hhcmVkIFZpcnR1
YWwgQWRkcmVzcyAoU1ZBKSBpcyBlbmFibGVkIGZvciBhIGd1ZXN0IE9TIHZpYQ0KPiA+ID4gPiA+
PiB2SU9NTVUsIHdlIG5lZWQgdG8gcHJvdmlkZSBpbnZhbGlkYXRpb24gc3VwcG9ydCBhdCBJT01N
VSBBUEkNCj4gPiA+ID4gPj4gYW5kDQo+ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiA+PiBsZXZlbC4g
VGhpcyBwYXRjaCBhZGRzIEludGVsIFZULWQgc3BlY2lmaWMgZnVuY3Rpb24gdG8NCj4gPiA+ID4g
Pj4gaW1wbGVtZW50IGlvbW11IHBhc3Nkb3duIGludmFsaWRhdGUgQVBJIGZvciBzaGFyZWQgdmly
dHVhbCBhZGRyZXNzLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBUaGUgdXNlIGNhc2UgaXMgZm9y
IHN1cHBvcnRpbmcgY2FjaGluZyBzdHJ1Y3R1cmUgaW52YWxpZGF0aW9uDQo+ID4gPiA+ID4+IG9m
IGFzc2lnbmVkIFNWTSBjYXBhYmxlIGRldmljZXMuIEVtdWxhdGVkIElPTU1VIGV4cG9zZXMgcXVl
dWUNCj4gPiA+ICBbLi4uXQ0KPiA+ID4gIFsuLi5dDQo+ID4gPiA+IHRvDQo+ID4gPiA+ID4+ICsg
KiBWVC1kIGdyYW51bGFyaXR5LiBJbnZhbGlkYXRpb24gaXMgdHlwaWNhbGx5IGluY2x1ZGVkIGlu
IHRoZQ0KPiA+ID4gPiA+PiB1bm1hcA0KPiA+ID4gPiBvcGVyYXRpb24NCj4gPiA+ID4gPj4gKyAq
IGFzIGEgcmVzdWx0IG9mIERNQSBvciBWRklPIHVubWFwLiBIb3dldmVyLCBmb3IgYXNzaWduZWQN
Cj4gPiA+ID4gPj4gZGV2aWNlcw0KPiA+ID4gPiBndWVzdA0KPiA+ID4gPiA+PiArICogb3ducyB0
aGUgZmlyc3QgbGV2ZWwgcGFnZSB0YWJsZXMuIEludmFsaWRhdGlvbnMgb2YNCj4gPiA+ID4gPj4g
dHJhbnNsYXRpb24gY2FjaGVzIGluDQo+ID4gPiA+IHRoZQ0KPiA+ID4gIFsuLi5dDQo+ID4gPiAg
Wy4uLl0NCj4gPiA+ICBbLi4uXQ0KPiA+ID4gPg0KPiA+IGludl90eXBlX2dyYW51X21hcFtJT01N
VV9DQUNIRV9JTlZfVFlQRV9OUl1bSU9NTVVfSU5WX0dSQU5VXw0KPiA+ID4gPiA+PiBOUl0gPSB7
DQo+ID4gPiA+ID4+ICsJLyoNCj4gPiA+ID4gPj4gKwkgKiBQQVNJRCBiYXNlZCBJT1RMQiBpbnZh
bGlkYXRpb246IFBBU0lEIHNlbGVjdGl2ZSAocGVyDQo+ID4gPiA+ID4+IFBBU0lEKSwNCj4gPiA+
ID4gPj4gKwkgKiBwYWdlIHNlbGVjdGl2ZSAoYWRkcmVzcyBncmFudWxhcml0eSkNCj4gPiA+ID4g
Pj4gKwkgKi8NCj4gPiA+ID4gPj4gKwl7MCwgMSwgMX0sDQo+ID4gPiA+ID4+ICsJLyogUEFTSUQg
YmFzZWQgZGV2IFRMQnMsIG9ubHkgc3VwcG9ydCBhbGwgUEFTSURzIG9yDQo+ID4gPiA+ID4+IHNp
bmdsZSBQQVNJRCAqLw0KPiA+ID4gPiA+PiArCXsxLCAxLCAwfSwNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IElzIHRoaXMgY29tYmluYXRpb24gY29ycmVjdD8gd2hlbiBzaW5nbGUgUEFTSUQgaXMgYmVp
bmcNCj4gPiA+ID4gPiBzcGVjaWZpZWQsIGl0IGlzIGVzc2VudGlhbGx5IGEgcGFnZS1zZWxlY3Rp
dmUgaW52YWxpZGF0aW9uIHNpbmNlDQo+ID4gPiA+ID4geW91IG5lZWQgcHJvdmlkZSBBZGRyZXNz
IGFuZCBTaXplLg0KPiA+ID4gPiBJc24ndCBpdCB0aGUgc2FtZSB3aGVuIEc9MT8gU3RpbGwgdGhl
IGFkZHIvc2l6ZSBpcyB1c2VkLiBEb2Vzbid0DQo+ID4gPiA+IGl0DQo+ID4gPg0KPiA+ID4gSSB0
aG91Z2h0IGFkZHIvc2l6ZSBpcyBub3QgdXNlZCB3aGVuIEc9MSwgYnV0IGl0IG1pZ2h0IGJlIHdy
b25nLiBJJ20NCj4gPiA+IGNoZWNraW5nIHdpdGggb3VyIHZ0LWQgc3BlYyBvd25lci4NCj4gPiA+
DQo+ID4NCj4gPiA+ID4gY29ycmVzcG9uZCB0byBJT01NVV9JTlZfR1JBTlVfQUREUiB3aXRoDQo+
IElPTU1VX0lOVl9BRERSX0ZMQUdTX1BBU0lEDQo+ID4gPiA+IGZsYWcgdW5zZXQ/DQo+ID4gPiA+
DQo+ID4gPiA+IHNvIHswLCAwLCAxfT8NCj4gPiA+DQo+ID4gSSBhbSBub3Qgc3VyZSBJIGdvdCB5
b3VyIGxvZ2ljLiBUaGUgdGhyZWUgZmllbGRzIGNvcnJlc3BvbmQgdG8NCj4gPiAJSU9NTVVfSU5W
X0dSQU5VX0RPTUFJTiwJLyogZG9tYWluLXNlbGVjdGl2ZQ0KPiA+IGludmFsaWRhdGlvbiAqLw0K
PiA+IAlJT01NVV9JTlZfR1JBTlVfUEFTSUQsCS8qIFBBU0lELXNlbGVjdGl2ZSBpbnZhbGlkYXRp
b24gKi8NCj4gPiAJSU9NTVVfSU5WX0dSQU5VX0FERFIsCS8qIHBhZ2Utc2VsZWN0aXZlIGludmFs
aWRhdGlvbiAqDQo+ID4NCj4gPiBGb3IgZGV2VExCLCB3ZSB1c2UgZG9tYWluIGFzIGdsb2JhbCBz
aW5jZSB0aGVyZSBpcyBubyBkb21haW4uIFRoZW4gSQ0KPiA+IGNhbWUgdXAgd2l0aCB7MSwgMSwg
MH0sIHdoaWNoIG1lYW5zIHdlIGNvdWxkIGhhdmUgZ2xvYmFsIGFuZCBwYXNpZA0KPiA+IGdyYW51
IGludmFsaWRhdGlvbiBmb3IgUEFTSUQgYmFzZWQgZGV2VExCLg0KPiA+DQo+ID4gSWYgdGhlIGNh
bGxlciBhbHNvIHByb3ZpZGUgYWRkciBhbmQgUyBiaXQsIHRoZSBmbHVzaCByb3V0aW5lIHdpbGwg
cHV0DQo+IA0KPiAiYWxzbyIgLT4gIm11c3QiLCBiZWNhdXNlIHZ0LWQgcmVxdWlyZXMgYWRkci9z
aXplIG11c3QgYmUgcHJvdmlkZWQgaW4NCj4gZGV2dGxiDQo+IGRlc2NyaXB0b3IsIHRoYXQgaXMg
d2h5IEVyaWMgc3VnZ2VzdHMgezAsIDAsIDF9Lg0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSB7MCwg
MCwgMX0gOi0pIGFkZHIgZmllbGQgYW5kIFMgZmllbGQgYXJlIG11c3QsIHBhc2lkDQpmaWVsZCBk
ZXBlbmRzIG9uIEcgYml0Lg0KDQpJIGRpZG7igJl0IHJlYWQgdGhyb3VnaCBhbGwgY29tbWVudHMu
IEhlcmUgaXMgYSBjb25jZXJuIHdpdGggdGhpcyAyLUQgdGFibGUsDQp0aGUgaW9tbXUgY2FjaGUg
dHlwZSBpcyBkZWZpbmVkIGFzIGJlbG93LiBJIHN1cHBvc2UgdGhlcmUgaXMgYSBwcm9ibGVtIGhl
cmUuDQpJZiBJJ20gdXNpbmcgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfUEFTSUQsIGl0IHdpbGwgYmV5
b25kIHRoZSAyLUQgdGFibGUuDQoNCi8qIElPTU1VIHBhZ2luZyBzdHJ1Y3R1cmUgY2FjaGUgKi8N
CiNkZWZpbmUgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfSU9UTEIgICAgICAoMSA8PCAwKSAvKiBJT01N
VSBJT1RMQiAqLw0KI2RlZmluZSBJT01NVV9DQUNIRV9JTlZfVFlQRV9ERVZfSU9UTEIgICgxIDw8
IDEpIC8qIERldmljZSBJT1RMQiAqLw0KI2RlZmluZSBJT01NVV9DQUNIRV9JTlZfVFlQRV9QQVNJ
RCAgICAgICgxIDw8IDIpIC8qIFBBU0lEIGNhY2hlICovDQojZGVmaW5lIElPTU1VX0NBQ0hFX0lO
Vl9UWVBFX05SICAgICAgICAgKDMpDQoNCj4gPg0KPiA+ID4gSSBoYXZlIG9uZSBtb3JlIG9wZW46
DQo+ID4gPg0KPiA+ID4gSG93IGRvZXMgdXNlcnNwYWNlIGtub3cgd2hpY2ggaW52YWxpZGF0aW9u
IHR5cGUvZ3JhbiBpcyBzdXBwb3J0ZWQ/DQo+ID4gPiBJIGRpZG4ndCBzZWUgc3VjaCBjYXBhYmls
aXR5IHJlcG9ydGluZyBpbiBZaSdzIFZGSU8gdlNWQSBwYXRjaCBzZXQuDQo+ID4gPiBEbyB3ZSB3
YW50IHRoZSB1c2VyL2tlcm5lbCBhc3N1bWUgdGhlIHNhbWUgY2FwYWJpbGl0eSBzZXQgaWYgdGhl
eQ0KPiA+ID4gYXJlIGFyY2hpdGVjdHVyYWw/IEhvd2V2ZXIgdGhlIGtlcm5lbCBjb3VsZCBhbHNv
IGRvIHNvbWUNCj4gPiA+IG9wdGltaXphdGlvbiBlLmcuIGhpZGUgZGV2dGxiIGludmFsaWRhdGlv
biBjYXBhYmlsaXR5IGdpdmVuIHRoYXQgdGhlDQo+ID4gPiBrZXJuZWwgYWxyZWFkeSBpbnZhbGlk
YXRlIGRldnRsYiBhdXRvbWF0aWNhbGx5IHdoZW4gc2VydmluZyBpb3RsYg0KPiA+ID4gaW52YWxp
ZGF0aW9uLi4uDQo+ID4gPg0KPiA+IEluIGdlbmVyYWwsIHdlIGFyZSB0cmVuZGluZyB0byB1c2Ug
VkZJTyBjYXBhYmlsaXR5IGNoYWluIHRvIGV4cG9zZQ0KPiA+IGlvbW11IGNhcGFiaWxpdGllcy4N
Cj4gPg0KPiA+IEJ1dCBmb3IgYXJjaGl0ZWN0dXJhbCBmZWF0dXJlcyBzdWNoIGFzIHR5cGUvZ3Jh
bnUsIHdlIGhhdmUgdG8gYXNzdW1lDQo+ID4gdGhlIHNhbWUgY2FwYWJpbGl0eSBiZXR3ZWVuIGhv
c3QgJiBndWVzdC4gR3JhbnUgYW5kIHR5cGVzIGFyZSBub3QNCj4gPiBlbnVtZXJhdGVkIG9uIHRo
ZSBob3N0IElPTU1VIGVpdGhlci4NCj4gPg0KPiA+IEZvciBkZXZUTEIgb3B0aW1pemF0aW9uLCBJ
IGFncmVlIHdlIG5lZWQgdG8gZXhwb3NlIGEgY2FwYWJpbGl0eSB0byB0aGUNCj4gPiBndWVzdCBz
dGF0aW5nIHRoYXQgaW1wbGljaXQgZGV2dGxiIGludmFsaWRhdGlvbiBpcyBzdXBwb3J0ZWQuDQo+
ID4gT3RoZXJ3aXNlLCBpZiBMaW51eCBndWVzdCBydW5zIG9uIG90aGVyIE9TZXMgbWF5IG5vdCBz
dXBwb3J0IGltcGxpY2l0DQo+ID4gZGV2dGxiIGludmFsaWRhdGlvbi4NCj4gPg0KPiA+IFJpZ2h0
IFlpPw0KPiANCj4gVGhhbmtzIGZvciBleHBsYW5hdGlvbi4gU28gd2UgYXJlIGFzc3VtZWQgdG8g
c3VwcG9ydCBhbGwgb3BlcmF0aW9ucw0KPiBkZWZpbmVkIGluIHNwZWMsIHNvIG5vIG5lZWQgdG8g
ZXhwb3NlIHRoZW0gb25lLWJ5LW9uZS4gRm9yIG9wdGltaXphdGlvbiwNCj4gSSdtIGZpbmUgdG8g
ZG8gaXQgbGF0ZXIuDQoNCnllcy4gOi0pDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
