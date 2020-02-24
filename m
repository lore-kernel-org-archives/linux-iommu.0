Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B7FC3567B
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:44:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DB12072D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 08:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DB12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B7D98619F;
	Mon, 24 Feb 2020 08:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YNX-52RbjutU; Mon, 24 Feb 2020 08:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 797F0861C1;
	Mon, 24 Feb 2020 08:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC32C18DA;
	Mon, 24 Feb 2020 08:44:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 487CFC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 453C120014
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuyEyvEQTlx7 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 08:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 8BD3F1FF59
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:44:48 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 00:44:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,479,1574150400"; d="scan'208";a="237251474"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by orsmga003.jf.intel.com with ESMTP; 24 Feb 2020 00:44:47 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.140]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.206]) with mapi id 14.03.0439.000;
 Mon, 24 Feb 2020 00:44:47 -0800
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH V2 3/5] iommu: Add support to change default domain of
 an iommu_group
Thread-Topic: [PATCH V2 3/5] iommu: Add support to change default domain of
 an iommu_group
Thread-Index: AQHV6edq0WFFpTxmr0SVz5mkWbbuAqgpndvwgAC/4AD//4X/oIAAmY8A//97rjCAAI25gIAAB4mA//97H2A=
Date: Mon, 24 Feb 2020 08:44:47 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F5721B424@ORSMSX114.amr.corp.intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
 <b8b5ac1f-b736-531d-a621-030ec8e3e7b1@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F572177EC@ORSMSX114.amr.corp.intel.com>
 <4a92bc90-735f-8dbf-1a7c-7bc58563f75f@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F5721A118@ORSMSX114.amr.corp.intel.com>
 <d5138046-b613-b070-2af8-4a9a519ca42a@linux.intel.com>
 <FFF73D592F13FD46B8700F0A279B802F5721AB7A@ORSMSX114.amr.corp.intel.com>
 <17eae788-1ed7-a24b-339e-4800496f9542@linux.intel.com>
 <e7addf56-3b7d-e9c4-178c-2de53e7f9d95@linux.intel.com>
In-Reply-To: <e7addf56-3b7d-e9c4-178c-2de53e7f9d95@linux.intel.com>
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

PiBPbiAyMDIwLzIvMjQgMTY6MTIsIEx1IEJhb2x1IHdyb3RlOg0KPiA+IE9uIDIwMjAvMi8yNCAx
NTo1NywgUHJha2h5YSwgU2FpIFByYW5lZXRoIHdyb3RlOg0KPiA+Pj4gT24gMjAyMC8yLzI0IDE1
OjAzLCBQcmFraHlhLCBTYWkgUHJhbmVldGggd3JvdGU6DQo+ID4+Pj4+IE9uIDIwMjAvMi8yNCAx
MToyMCwgUHJha2h5YSwgU2FpIFByYW5lZXRoIHdyb3RlOg0KPiA+Pj4+Pj4+PiArwqDCoMKgIGxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZShncnBfZGV2LCB0ZW1wLCAmZ3JvdXAtPmRldmljZXMsDQo+
ID4+Pj4+Pj4+IGxpc3QpIHsNCj4gPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZp
Y2UgKmRldjsNCj4gPj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZGV2ID0g
Z3JwX2Rldi0+ZGV2Ow0KPiA+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaW9tbXVfcmVsZWFzZV9k
ZXZpY2UoZGV2KTsNCj4gPj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
ID0gaW9tbXVfZ3JvdXBfYWRkX2RldmljZShncm91cCwgZGV2KTsNCj4gPj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChyZXQpDQo+ID4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCB0byBpb21tdSBncm91cCAlZDoNCj4gPj4+Pj4+Pj4g
KyVkXG4iLA0KPiA+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdyb3Vw
LT5pZCwgcmV0KTsNCj4gPj4+Pj4+PiBOZWVkIHRvIGhhbmRsZSB0aGlzIGVycm9yIGNhc2UuDQo+
ID4+Pj4+PiBJIHdhc24ndCBzdXJlIG9uIGhvdyB0byBoYW5kbGUgdGhlIGVycm9yIOKYuQ0KPiA+
Pj4+PiBKdXN0IHJvbGwgYmFjayB0byB0aGUgc3RhdGUgYmVmb3JlIGNhbGxpbmcgdGhpcyBmdW5j
dGlvbiBhbmQNCj4gPj4+Pj4gcmV0dXJuIGFuIGFwcHJvcHJpYXRlIGVycm9yIHZhbHVlLg0KPiA+
Pj4+Pg0KPiA+Pj4+PiBUaGUgbGlrZWx5IGJlaGF2aW9yIGlzIGRldGFjaGluZyB0aGUgbmV3IGRv
bWFpbnMgZnJvbSBhbGwgZGV2aWNlcw0KPiA+Pj4+PiAoaWYgaXQgaGFzIGFscmVhZHkgYXR0YWNo
ZWQpLCBhdHRhY2hpbmcgdGhlIG9sZCBkb21haW5zIHRvIGFsbA0KPiA+Pj4+PiBkZXZpY2VzIGlu
IHRoZSBncm91cCwNCj4gPj4+PiBBbmQgd2hpbGUgaGFuZGxpbmcgdGhpcyBlcnJvciBjYXNlLCB0
aGVyZSBpcyBhIHBvc3NpYmlsaXR5IHRoYXQNCj4gPj4+PiBhdHRhY2hpbmcgdG8gb2xkDQo+ID4+
PiBkb21haW4gY291bGQgZmFpbC4uIHNvLCB3ZSBtaWdodCBuZWVkIHRvIGhhbmRsZSB0aGF0IGVy
cm9yIGNhc2UgYXMNCj4gPj4+IHdlbGwuIElmIHdlIHBsYW4gdG8gaGFuZGxlIGVycm9yIGNhc2Us
IHNpbmNlIHdlIGhhdmUgcmVtb3ZlZCBkZXZpY2VzDQo+ID4+PiBmcm9tIGdyb3VwIGFib3ZlLCBh
ZGRpbmcgdGhlbSBiYWNrIGNvdWxkIGZhaWwgdG9vLi4gdGhhdCB3b3VsZCBsZWFkDQo+ID4+PiBp
bnRvIGhhbmRsaW5nIGVycm9yIGNhc2UgZm9yIGFuIGVycm9yIGNhc2UuDQo+ID4+Pg0KPiA+Pj4g
V2UgY2FuIGFzc3VtZSB0aGF0IHRoZSBvbGQgZG9tYWluIHNob3VsZCBhbHdheXMgYmUgYXR0YWNo
ZWQgYmFjay4NCj4gPj4+IE90aGVyd2lzZSwgdGhlcmUgbXVzdCBiZSBzb21lIGJ1Z3MgaW4gdGhl
IHZlbmRvciBpb21tdSBkcml2ZXIuDQo+ID4+Pg0KPiA+Pj4gSXQgbXVzdCBiZSBhYmxlIHRvIHJv
bGUgYmFjaywgb3RoZXJ3aXNlIHVzZXJzIGhhdmUgdG8gcmVib290IHRoZQ0KPiA+Pj4gc3lzdGVt
IGluIG9yZGVyIHRvIHVzZSB0aGUgZGV2aWNlcyBpbiB0aGUgZ3JvdXAuIFRoaXMgaXMgbm90DQo+
ID4+PiBhY2NlcHRhYmxlIGluIHRoZSBwcm9kdWN0aW9uIGtlcm5lbC4NCj4gPj4gSSBhZ3JlZSB0
aGF0IHdlIHNob3VsZCBiZSBhYmxlIHRvIHJvbGwgYmFjayBidXQgSSBhbSBhZnJhaWQgdGhhdCB0
aGUNCj4gPj4gZXJyb3IgaGFuZGxpbmcgY29kZSBjb3VsZCBiZWNvbWUgY29tcGxleCB0aGFuIHRo
ZSB1c3VhbCBjb2RlIHRoYXQNCj4gPj4gZ2V0cyB0byBydW4uIEZvciBleGFtcGxlLCBhc3N1bWUg
dGhlcmUgYXJlICduJyBkZXZpY2VzIGluIHRoZSBncm91cCwNCj4gPj4gJ2snIG9mIHRoZW0gYXJl
IHN1Y2Nlc3NmdWxseSBwcm9jZXNzZWQgKGkuZS4gZGVmYXVsdCBkb21haW4gdHlwZSBoYXMNCj4g
Pj4gYmVlbg0KPiA+PiBjaGFuZ2VkKSBhbmQgaWYgaysxIGZhaWxzIHdoaWxlIGNoYW5naW5nIGRl
ZmF1bHQgZG9tYWluIHR5cGUsIHRvIHJvbGwNCj4gPj4gYmFjayBzdGF0ZSBvZiBrIGRldmljZXMs
IHdlIG5lZWQgdG8gbWFpbnRhaW4gYSBsaXN0IG9mIHByb2Nlc3NlZA0KPiA+PiBkZXZpY2VzIHNv
IHRoYXQgd2Ugbm93IHJvbGwgYmFjayBzdGF0ZSBmb3IgZGV2aWNlcyBpbiB0aGlzIGxpc3QuIFRo
ZQ0KPiA+PiBwcmVzZW50IGNvZGUgZG9lcyBub3QgaGF2ZSBhbnkgbGlzdCBiZWNhdXNlIGl0J3Mg
cHJvY2Vzc2luZw0KPiA+PiBzZXF1ZW50aWFsbHksIGl0IHRha2VzIGEgZGV2aWNlIGZyb20gdGhl
IGdyb3VwLCBjaGFuZ2VzIGl0IGRvbWFpbiBhbmQNCj4gPj4gbW92ZXMgdG8gb3RoZXIgZGV2aWNl
IGFuZCBoZW5jZSBkb2VzIG5vdCByZXF1aXJlIGEgbGlzdC4NCj4gPj4NCj4gPj4gQWxsIHNhaWQs
IEkgY291bGQgZ2l2ZSB0aGlzIGEgdHJ5IGFuZCBzZWUgaG93IGNvbXBsZXggdGhlIGNvZGUgY291
bGQNCj4gPj4gdHVybiBvdXQgdG8gYmUuIEkgaG9wZSBJIGFtIHdyb25nIChpLmUuIHR1cm5zIG91
dCBpbXBsZW1lbnRpbmcgZXJyb3INCj4gPj4gaGFuZGxpbmcgaXMgc2ltcGxlKS4NCj4gPj4NCj4g
Pg0KPiA+IEkgdGhpbmsgc29tZXRoaW5nIGxpa2UgYmVsb3cgc2hvdWxkIHdvcmsuDQo+ID4NCj4g
PiBzdGF0aWMgaW50IGlvbW11X2dyb3VwX2RvX2F0dGFjaF9kZXZpY2Uoc3RydWN0IGRldmljZSAq
ZGV2LCB2b2lkDQo+ID4gKmRhdGEpIHsNCj4gPiAgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tYWluID0gZGF0YTsNCj4gPg0KPiA+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
X19pb21tdV9hdHRhY2hfZGV2aWNlKGRvbWFpbiwgZGV2KTsgfQ0KPiA+DQo+ID4gc3RhdGljIGlu
dCBfX2lvbW11X2F0dGFjaF9ncm91cChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQo+ID4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXApIHsNCj4gPiAgwqDCoMKgwqDCoMKgwqAg
aW50IHJldDsNCj4gPg0KPiA+ICDCoMKgwqDCoMKgwqDCoCBpZiAoZ3JvdXAtPmRlZmF1bHRfZG9t
YWluICYmIGdyb3VwLT5kb21haW4gIT0NCj4gPiBncm91cC0+ZGVmYXVsdF9kb21haW4pDQo+ID4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOw0KPiA+DQo+ID4g
IMKgwqDCoMKgwqDCoMKgIHJldCA9IF9faW9tbXVfZ3JvdXBfZm9yX2VhY2hfZGV2KGdyb3VwLCBk
b21haW4sDQo+ID4NCj4gPiBpb21tdV9ncm91cF9kb19hdHRhY2hfZGV2aWNlKTsNCj4gPiAgwqDC
oMKgwqDCoMKgwqAgaWYgKHJldCA9PSAwKQ0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ3JvdXAtPmRvbWFpbiA9IGRvbWFpbjsNCj4gPg0KPiA+ICDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcmV0Ow0KPiA+IH0NCj4gPg0KPiA+IFRoZSB2ZW5kb3IgaW9tbXUgZHJpdmVyIHNob3Vs
ZCBhbHdheXMgZGVwcmVjYXRlIHRoZSBvbGQgZG9tYWluIGlmIGl0DQo+ID4gZXhpc3RzLiBBZGQg
YSBjb21tZW50IHRoZXJlLg0KPiA+DQo+IA0KPiBCeSB0aGUgd2F5LCB0aGlzIGlzIHRoZSBleHBl
Y3RlZCBiZWhhdmlvci4gUGxlYXNlIGNoZWNrDQo+IF9faW9tbXVfZGV0YWNoX2dyb3VwKCkuDQoN
Ck9rLi4gSSB3aWxsIGxvb2sgaW50byBpdC4NCg0KUmVnYXJkcywNClNhaQ0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
