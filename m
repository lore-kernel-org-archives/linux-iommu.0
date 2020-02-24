Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7EFC35679
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:57:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD37F2051A
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD37F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B87ED20109;
	Mon, 24 Feb 2020 07:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-B97UvFUU1L; Mon, 24 Feb 2020 07:57:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D3C5C2035C;
	Mon, 24 Feb 2020 07:57:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0864C07FF;
	Mon, 24 Feb 2020 07:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC737C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CB65C85B12
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bbJAhKjh2OJX for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 07:57:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 12F6D85ABE
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:57:52 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Feb 2020 23:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="260261956"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2020 23:57:48 -0800
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 23 Feb 2020 23:57:47 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.180]) with mapi id 14.03.0439.000;
 Sun, 23 Feb 2020 23:57:47 -0800
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V2 3/5] iommu: Add support to change default domain of
 an iommu_group
Thread-Topic: [PATCH V2 3/5] iommu: Add support to change default domain of
 an iommu_group
Thread-Index: AQHV6edq0WFFpTxmr0SVz5mkWbbuAqgpndvwgAC/4AD//4X/oIAAmY8A//97rjA=
Date: Mon, 24 Feb 2020 07:57:46 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F5721AB7A@ORSMSX114.amr.corp.intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
 <b8b5ac1f-b736-531d-a621-030ec8e3e7b1@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F572177EC@ORSMSX114.amr.corp.intel.com>
 <4a92bc90-735f-8dbf-1a7c-7bc58563f75f@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F5721A118@ORSMSX114.amr.corp.intel.com>
 <d5138046-b613-b070-2af8-4a9a519ca42a@linux.intel.com>
In-Reply-To: <d5138046-b613-b070-2af8-4a9a519ca42a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

PiBPbiAyMDIwLzIvMjQgMTU6MDMsIFByYWtoeWEsIFNhaSBQcmFuZWV0aCB3cm90ZToNCj4gPj4g
T24gMjAyMC8yLzI0IDExOjIwLCBQcmFraHlhLCBTYWkgUHJhbmVldGggd3JvdGU6DQo+ID4+Pj4+
ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGdycF9kZXYsIHRlbXAsICZncm91cC0+ZGV2aWNl
cywgbGlzdCkgew0KPiA+Pj4+PiArCQlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4+Pj4+ICsNCj4g
Pj4+Pj4gKwkJZGV2ID0gZ3JwX2Rldi0+ZGV2Ow0KPiA+Pj4+PiArCQlpb21tdV9yZWxlYXNlX2Rl
dmljZShkZXYpOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJCXJldCA9IGlvbW11X2dyb3VwX2FkZF9k
ZXZpY2UoZ3JvdXAsIGRldik7DQo+ID4+Pj4+ICsJCWlmIChyZXQpDQo+ID4+Pj4+ICsJCQlkZXZf
ZXJyKGRldiwgIkZhaWxlZCB0byBhZGQgdG8gaW9tbXUgZ3JvdXAgJWQ6ICVkXG4iLA0KPiA+Pj4+
PiArCQkJCWdyb3VwLT5pZCwgcmV0KTsNCj4gPj4+PiBOZWVkIHRvIGhhbmRsZSB0aGlzIGVycm9y
IGNhc2UuDQo+ID4+PiBJIHdhc24ndCBzdXJlIG9uIGhvdyB0byBoYW5kbGUgdGhlIGVycm9yIOKY
uQ0KPiA+Pg0KPiA+PiBKdXN0IHJvbGwgYmFjayB0byB0aGUgc3RhdGUgYmVmb3JlIGNhbGxpbmcg
dGhpcyBmdW5jdGlvbiBhbmQgcmV0dXJuDQo+ID4+IGFuIGFwcHJvcHJpYXRlIGVycm9yIHZhbHVl
Lg0KPiA+Pg0KPiA+PiBUaGUgbGlrZWx5IGJlaGF2aW9yIGlzIGRldGFjaGluZyB0aGUgbmV3IGRv
bWFpbnMgZnJvbSBhbGwgZGV2aWNlcyAoaWYNCj4gPj4gaXQgaGFzIGFscmVhZHkgYXR0YWNoZWQp
LCBhdHRhY2hpbmcgdGhlIG9sZCBkb21haW5zIHRvIGFsbCBkZXZpY2VzIGluDQo+ID4+IHRoZSBn
cm91cCwNCj4gPg0KPiA+IEFuZCB3aGlsZSBoYW5kbGluZyB0aGlzIGVycm9yIGNhc2UsIHRoZXJl
IGlzIGEgcG9zc2liaWxpdHkgdGhhdCBhdHRhY2hpbmcgdG8gb2xkDQo+IGRvbWFpbiBjb3VsZCBm
YWlsLi4gc28sIHdlIG1pZ2h0IG5lZWQgdG8gaGFuZGxlIHRoYXQgZXJyb3IgY2FzZSBhcyB3ZWxs
LiBJZiB3ZQ0KPiBwbGFuIHRvIGhhbmRsZSBlcnJvciBjYXNlLCBzaW5jZSB3ZSBoYXZlIHJlbW92
ZWQgZGV2aWNlcyBmcm9tIGdyb3VwIGFib3ZlLA0KPiBhZGRpbmcgdGhlbSBiYWNrIGNvdWxkIGZh
aWwgdG9vLi4gdGhhdCB3b3VsZCBsZWFkIGludG8gaGFuZGxpbmcgZXJyb3IgY2FzZSBmb3IgYW4N
Cj4gZXJyb3IgY2FzZS4NCj4gDQo+IFdlIGNhbiBhc3N1bWUgdGhhdCB0aGUgb2xkIGRvbWFpbiBz
aG91bGQgYWx3YXlzIGJlIGF0dGFjaGVkIGJhY2suDQo+IE90aGVyd2lzZSwgdGhlcmUgbXVzdCBi
ZSBzb21lIGJ1Z3MgaW4gdGhlIHZlbmRvciBpb21tdSBkcml2ZXIuDQo+IA0KPiBJdCBtdXN0IGJl
IGFibGUgdG8gcm9sZSBiYWNrLCBvdGhlcndpc2UgdXNlcnMgaGF2ZSB0byByZWJvb3QgdGhlIHN5
c3RlbSBpbiBvcmRlcg0KPiB0byB1c2UgdGhlIGRldmljZXMgaW4gdGhlIGdyb3VwLiBUaGlzIGlz
IG5vdCBhY2NlcHRhYmxlIGluIHRoZSBwcm9kdWN0aW9uIGtlcm5lbC4NCg0KSSBhZ3JlZSB0aGF0
IHdlIHNob3VsZCBiZSBhYmxlIHRvIHJvbGwgYmFjayBidXQgSSBhbSBhZnJhaWQgdGhhdCB0aGUg
ZXJyb3IgaGFuZGxpbmcgY29kZSBjb3VsZCBiZWNvbWUgY29tcGxleCB0aGFuIHRoZSB1c3VhbCBj
b2RlIHRoYXQgZ2V0cyB0byBydW4uIEZvciBleGFtcGxlLCBhc3N1bWUgdGhlcmUgYXJlICduJyBk
ZXZpY2VzIGluIHRoZSBncm91cCwgJ2snIG9mIHRoZW0gYXJlIHN1Y2Nlc3NmdWxseSBwcm9jZXNz
ZWQgKGkuZS4gZGVmYXVsdCBkb21haW4gdHlwZSBoYXMgYmVlbiBjaGFuZ2VkKSBhbmQgaWYgaysx
IGZhaWxzIHdoaWxlIGNoYW5naW5nIGRlZmF1bHQgZG9tYWluIHR5cGUsIHRvIHJvbGwgYmFjayBz
dGF0ZSBvZiBrIGRldmljZXMsIHdlIG5lZWQgdG8gbWFpbnRhaW4gYSBsaXN0IG9mIHByb2Nlc3Nl
ZCBkZXZpY2VzIHNvIHRoYXQgd2Ugbm93IHJvbGwgYmFjayBzdGF0ZSBmb3IgZGV2aWNlcyBpbiB0
aGlzIGxpc3QuIFRoZSBwcmVzZW50IGNvZGUgZG9lcyBub3QgaGF2ZSBhbnkgbGlzdCBiZWNhdXNl
IGl0J3MgcHJvY2Vzc2luZyBzZXF1ZW50aWFsbHksIGl0IHRha2VzIGEgZGV2aWNlIGZyb20gdGhl
IGdyb3VwLCBjaGFuZ2VzIGl0IGRvbWFpbiBhbmQgbW92ZXMgdG8gb3RoZXIgZGV2aWNlIGFuZCBo
ZW5jZSBkb2VzIG5vdCByZXF1aXJlIGEgbGlzdC4NCg0KQWxsIHNhaWQsIEkgY291bGQgZ2l2ZSB0
aGlzIGEgdHJ5IGFuZCBzZWUgaG93IGNvbXBsZXggdGhlIGNvZGUgY291bGQgdHVybiBvdXQgdG8g
YmUuIEkgaG9wZSBJIGFtIHdyb25nIChpLmUuIHR1cm5zIG91dCBpbXBsZW1lbnRpbmcgZXJyb3Ig
aGFuZGxpbmcgaXMgc2ltcGxlKS4NCg0KPiA+IFNvLCBnaXZlbiB0aGUgcHJvYmFiaWxpdHkgb2Yg
dGhlc2UgZnVuY3Rpb25zIGZhaWxpbmcgaGVyZSBhcmUgdmVyeSBsb3csIEkgdGhpbmssDQo+IHdo
eSBub3QgYml0ZSB0aGUgYnVsbGV0IGFuZCBzYXksIGFkZCBjb2RlIHRvIGhhbmRsZSB0aGVzZSBl
cnJvciBjYXNlcyBpZiB3ZSBzZWUNCj4gdGhhdCB0aGVzZSBmdW5jdGlvbnMgYXJlIGZhaWxpbmcg
ZnJlcXVlbnRseT8gT3RoZXJ3aXNlIHRoZSBlcnJvciBoYW5kbGluZyBjb2RlIGlzDQo+IGp1c3Qg
YSBkZWFkIGNvZGUuDQo+ID4NCj4gPj4gY2xlYW5pbmcNCj4gPj4gdXAgYWxsIG5ldyByZXNvdXJj
ZXMgYWxsb2NhdGVkIGluIHRoaXMgZnVuY3Rpb24sIHB1dHRpbmcgYSBlcnJvcg0KPiA+PiBtZXNz
YWdlIHRvIHRlbGwgdGhlIHVzZXIgd2h5IGl0IGZhaWxzIGFuZCByZXR1cm5pbmcgYW4gZXJyb3Ig
Y29kZS4NCj4gPj4NCj4gPj4+IGkuZS4gZ3JvdXAncyBkb21haW4vZGVmYXVsdF9kb21haW4gYXJl
IGFscmVhZHkgdXBkYXRlZCB0byBuZXcgZG9tYWluDQo+ID4+PiBhbmQNCj4gPj4gYXNzdW1lIHRo
ZXJlIGFyZSAnbicgZGV2aWNlcyBpbiB0aGUgZ3JvdXAgYW5kIHRoaXMgZmFpbGVkIGZvciAnayd0
aA0KPiA+PiBkZXZpY2UsIEkgd2Fzbid0IHN1cmUgaG93IEkgY291bGQgcm9sbCBiYWNrIHRoZSBj
aGFuZ2VzIG1hZGUgZm9yIGstMSBkZXZpY2VzLg0KPiA+Pg0KPiA+PiBBIHN1Y2Nlc3NmdWwgYXR0
YWNoIGNvdWxkIGJlIGNoZWNrZWQgYnkgKGdyb3VwLT5kb21haW4gPT0NCj4gPj4gZ3JvdXAtPmRl
ZmF1bHRfZG9tYWluKS4NCj4gPg0KPiA+IE5vLi4gYmVjYXVzZSBJIGhhdmUgbWFudWFsbHkgc2V0
IGdyb3VwLT5kb21haW4gPT0NCj4gPiBncm91cC0+ZGVmYXVsdF9kb21haW4gPSBuZXdfZG9tYWlu
IChkaWQgdGhpcyBiZWNhdXNlDQo+ID4gaW9tbXVfZ3JvdXBfYWRkX2RldmljZSgpIGFuZCBpb21t
dV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKCkNCj4gPiBuZWVkcyB0aGVtKQ0KPiANCj4g
WW91IGNvdWxkIHNldCBncm91cC0+ZG9tYWluIHRvIHRoZSBkZWZhdWx0IGRvbWFpbiBvbmx5IGFm
dGVyIGl0IGhhcyBiZWVuDQo+IGF0dGFjaGVkIHRvIHRoZSBkZXZpY2Ugc3VjY2Vzc2Z1bGx5LCBy
aWdodD8NCg0KV2lsbCByZW9yZGVyIHRoaW5ncyBhbmQgc2VlIGhvdyB0aGlzIGNvdWxkIGJlIGhh
bmRsZWQuDQoNCj4gPiBTbywgcHJvYmFibHkgd2UgbWlnaHQgbmVlZCBzb21lIG90aGVyIHdheSB0
byBjaGVjayBzdWNjZXNzZnVsIGF0dGFjaC4NCj4gPg0KPiA+Pj4gU28sIEkgdGhvdWdodCBwcm9i
YWJseSBqdXN0IGFsZXJ0IHRoZSB1c2VyIHRoYXQgdGhlcmUgd2FzIGFuIGVycm9yDQo+ID4+PiB3
aGlsZQ0KPiA+PiBjaGFuZ2luZyBkZWZhdWx0IGRvbWFpbiB0eXBlIGFuZCB0cnkgdXBkYXRpbmcg
Zm9yIG90aGVyIGRldmljZXMgaW4NCj4gPj4gdGhlIGdyb3VwIChob3BlZnVsbHkgb3RoZXIgZGV2
aWNlcyBtaWdodCBzdWNjZWVkKS4gQWxzbywqZ2VuZXJhbGx5Kg0KPiA+PiB3ZSBzaG91bGRuJ3Qg
c2VlIGFueSBlcnJvcnMgaGVyZSBiZWNhdXNlIGFsbCB0aGVzZSBkZXZpY2VzIHdlcmUNCj4gPj4g
YWxyZWFkeSBpbiB0aGUgc2FtZSBncm91cCBlYXJsaWVyICh3ZSBhcmVu4oCZdCBhZGRpbmcvcmVt
b3ZpbmcgbmV3DQo+ID4+IGRldmljZXMgdG8gdGhlIGdyb3VwKS4gV2UgYXJlIGp1c3QgY2hhbmdp
bmcgZGVmYXVsdCBkb21haW4gdHlwZSBhbmQNCj4gPj4gd2UgYWxyZWFkeSBtYWRlIHN1cmUgdGhh
dCBkZXZpY2UgY291bGQgYmUgaW4gdGhlIHJlcXVlc3RlZCBkZWZhdWx0IGRvbWFpbg0KPiB0eXBl
Lg0KDQpbc25pcHBlZF0NCg0KPiA+PiBBdCBsZWFzdCBJIGRpZG4ndCBzZWUgdGhlIGlvbW11X2Rl
Zl9kb21haW5fdHlwZSBpcyB1c2VkIGlmIGJvdGgNCj4gPj4gaWR0X2RldnMgYW5kIGRtYV9kZXZz
IGFyZSBib3RoIGVxdWFsIHRvIDAuIDotKQ0KPiA+DQo+ID4gU29ycnkhIEkgZGlkbid0IGdldCB3
aGF0IHlvdSBtZWFudCBieSAiaW9tbXVfZGVmX2RvbWFpbl90eXBlIiwgc28sIGNvdWxkDQo+IHlv
dSBwbGVhc2UgZXhwbGFpbiB0aGF0Pw0KPiA+DQo+ID4gV2hlbiBpZHRfZGV2cyA9PSAwIGFuZCBk
bWFfZGV2cyA9PSAwLCBpdCBtZWFucyB0aGF0IGFsbCB0aGUgZGV2aWNlcyBpbiB0aGUNCj4gZ3Jv
dXAgY291bGQgYmUgaW4gZWl0aGVyIG9mIHRoZSBkb21haW4uIEhlbmNlLCBJIGRlZmF1bHQgdG8g
RE1BIGRvbWFpbiB3aGljaCBpcw0KPiBjb3ZlcmVkIGJ5IHRoaXMgY29kZS4NCj4gPiAJCWlmICgh
aWR0X2RldnMpDQo+ID4gCQkJcmVxX3R5cGUgPSBJT01NVV9ET01BSU5fRE1BOw0KPiANCj4gaW9t
bXVfZGVmX2RvbWFpbl90eXBlIGlzIHRoZSBzeXN0ZW0gbGV2ZWwgZGVmYXVsdCBkb21haW4gdHlw
ZSBkZWZpbmVkIGluDQo+IGlvbW11LmMuIElmIHRoZSB2ZW5kb3IgaW9tbXUgZHJpdmVyIGhhcyBu
byBzcGVjaWFsIHJlcXVpcmVtZW50LCB3ZSBzaG91bGQNCj4gY2hvb3NlIHRoZSBkZWZhdWx0IHZh
bHVlLg0KDQpPay4uIGdvdCBpdCwgdGhhbmtzIGZvciBleHBsYWluaW5nLiBJIHdpbGwgY2hhbmdl
IHRoaXMgYXMgc3VnZ2VzdGVkLg0KDQpSZWdhcmRzLA0KU2FpDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
