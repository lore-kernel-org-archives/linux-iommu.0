Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26762C43331
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 12:58:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E963C20716
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 12:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E963C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C3A71860C4;
	Mon, 30 Mar 2020 12:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7yhptaozZmg; Mon, 30 Mar 2020 12:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 71CB186031;
	Mon, 30 Mar 2020 12:58:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54F30C1D7E;
	Mon, 30 Mar 2020 12:58:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC8AC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68CDC228B3
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1YNJMvPOlelK for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 12:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 085CA2288F
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 12:58:19 +0000 (UTC)
IronPort-SDR: XQqOcOnvysROotVwhfHmPszcoUwbbJzpB4iaSbuZiBB53buPZKnSFtWR7U+yRrHxaztqkQ+2TD
 bDjixUJStDBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 05:58:19 -0700
IronPort-SDR: g/AWCXdXyO4HidWwQg0ayWCYUSanvHNkem/fUxHxz4Q6ktOv49wSyXBmbwvRBLl2NyCyh0IpZZ
 +TlZgXC6TCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; d="scan'208";a="242019923"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 05:58:18 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 05:58:15 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 20:58:11 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHWAEUdbUtKvEWiiEiZu1SnRvWegKhhIjHA
Date: Mon, 30 Mar 2020 12:58:11 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF9F1@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBN
YXJjaCAyMiwgMjAyMCA4OjMyIFBNDQo+IA0KPiBGcm9tOiBMaXUgWWkgTCA8eWkubC5saXVAbGlu
dXguaW50ZWwuY29tPg0KPiANCj4gRm9yIFZGSU8gSU9NTVVzIHdpdGggdGhlIHR5cGUgVkZJT19U
WVBFMV9ORVNUSU5HX0lPTU1VLCBndWVzdA0KPiAib3ducyIgdGhlDQo+IGZpcnN0LWxldmVsL3N0
YWdlLTEgdHJhbnNsYXRpb24gc3RydWN0dXJlcywgdGhlIGhvc3QgSU9NTVUgZHJpdmVyIGhhcyBu
bw0KPiBrbm93bGVkZ2Ugb2YgZmlyc3QtbGV2ZWwvc3RhZ2UtMSBzdHJ1Y3R1cmUgY2FjaGUgdXBk
YXRlcyB1bmxlc3MgdGhlIGd1ZXN0DQo+IGludmFsaWRhdGlvbiByZXF1ZXN0cyBhcmUgdHJhcHBl
ZCBhbmQgcHJvcGFnYXRlZCB0byB0aGUgaG9zdC4NCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyBhIG5l
dyBJT0NUTCBWRklPX0lPTU1VX0NBQ0hFX0lOVkFMSURBVEUgdG8NCj4gcHJvcGFnYXRlIGd1ZXN0
DQo+IGZpcnN0LWxldmVsL3N0YWdlLTEgSU9NTVUgY2FjaGUgaW52YWxpZGF0aW9ucyB0byBob3N0
IHRvIGVuc3VyZSBJT01NVQ0KPiBjYWNoZQ0KPiBjb3JyZWN0bmVzcy4NCj4gDQo+IFdpdGggdGhp
cyBwYXRjaCwgdlNWQSAoVmlydHVhbCBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nKSBjYW4gYmUg
dXNlZCBzYWZlbHkNCj4gYXMgdGhlIGhvc3QgSU9NTVUgaW90bGIgY29ycmVjdG5lc3MgYXJlIGVu
c3VyZWQuDQo+IA0KPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IEND
OiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBDYzogQWxleCBX
aWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4gQ2M6IEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gQ2M6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVh
bi1waGlsaXBwZUBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkgTCA8eWkubC5s
aXVAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIFBhbiA8amFjb2IuanVuLnBh
bkBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy92ZmlvL3ZmaW9faW9tbXVfdHlw
ZTEuYyB8IDQ5DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICBpbmNsdWRlL3VhcGkvbGludXgvdmZpby5oICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jDQo+IGIvZHJpdmVycy92ZmlvL3ZmaW9f
aW9tbXVfdHlwZTEuYw0KPiBpbmRleCBhODc3NzQ3Li45MzdlYzNmIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3ZmaW8vdmZpb19pb21tdV90eXBlMS5jDQo+ICsrKyBiL2RyaXZlcnMvdmZpby92Zmlv
X2lvbW11X3R5cGUxLmMNCj4gQEAgLTI0MjMsNiArMjQyMywxNSBAQCBzdGF0aWMgbG9uZw0KPiB2
ZmlvX2lvbW11X3R5cGUxX3VuYmluZF9ncGFzaWQoc3RydWN0IHZmaW9faW9tbXUgKmlvbW11LA0K
PiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIGludCB2ZmlvX2NhY2hlX2ludl9m
bihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQoNCnZmaW9faW9tbXVfY2FjaGVfaW52
X2ZuDQoNCj4gK3sNCj4gKwlzdHJ1Y3QgZG9tYWluX2NhcHN1bGUgKmRjID0gKHN0cnVjdCBkb21h
aW5fY2Fwc3VsZSAqKWRhdGE7DQo+ICsJc3RydWN0IGlvbW11X2NhY2hlX2ludmFsaWRhdGVfaW5m
byAqY2FjaGVfaW52X2luZm8gPQ0KPiArCQkoc3RydWN0IGlvbW11X2NhY2hlX2ludmFsaWRhdGVf
aW5mbyAqKSBkYy0+ZGF0YTsNCj4gKw0KPiArCXJldHVybiBpb21tdV9jYWNoZV9pbnZhbGlkYXRl
KGRjLT5kb21haW4sIGRldiwgY2FjaGVfaW52X2luZm8pOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
bG9uZyB2ZmlvX2lvbW11X3R5cGUxX2lvY3RsKHZvaWQgKmlvbW11X2RhdGEsDQo+ICAJCQkJICAg
dW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpDQo+ICB7DQo+IEBAIC0yNjI5LDYg
KzI2MzgsNDYgQEAgc3RhdGljIGxvbmcgdmZpb19pb21tdV90eXBlMV9pb2N0bCh2b2lkDQo+ICpp
b21tdV9kYXRhLA0KPiAgCQl9DQo+ICAJCWtmcmVlKGdiaW5kX2RhdGEpOw0KPiAgCQlyZXR1cm4g
cmV0Ow0KPiArCX0gZWxzZSBpZiAoY21kID09IFZGSU9fSU9NTVVfQ0FDSEVfSU5WQUxJREFURSkg
ew0KPiArCQlzdHJ1Y3QgdmZpb19pb21tdV90eXBlMV9jYWNoZV9pbnZhbGlkYXRlIGNhY2hlX2lu
djsNCj4gKwkJdTMyIHZlcnNpb247DQo+ICsJCWludCBpbmZvX3NpemU7DQo+ICsJCXZvaWQgKmNh
Y2hlX2luZm87DQo+ICsJCWludCByZXQ7DQo+ICsNCj4gKwkJbWluc3ogPSBvZmZzZXRvZmVuZChz
dHJ1Y3QNCj4gdmZpb19pb21tdV90eXBlMV9jYWNoZV9pbnZhbGlkYXRlLA0KPiArCQkJCSAgICBm
bGFncyk7DQo+ICsNCj4gKwkJaWYgKGNvcHlfZnJvbV91c2VyKCZjYWNoZV9pbnYsICh2b2lkIF9f
dXNlciAqKWFyZywgbWluc3opKQ0KPiArCQkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwkJaWYg
KGNhY2hlX2ludi5hcmdzeiA8IG1pbnN6IHx8IGNhY2hlX2ludi5mbGFncykNCj4gKwkJCXJldHVy
biAtRUlOVkFMOw0KPiArDQo+ICsJCS8qIEdldCB0aGUgdmVyc2lvbiBvZiBzdHJ1Y3QgaW9tbXVf
Y2FjaGVfaW52YWxpZGF0ZV9pbmZvICovDQo+ICsJCWlmIChjb3B5X2Zyb21fdXNlcigmdmVyc2lv
biwNCj4gKwkJCSh2b2lkIF9fdXNlciAqKSAoYXJnICsgbWluc3opLCBzaXplb2YodmVyc2lvbikp
KQ0KPiArCQkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwkJaW5mb19zaXplID0gaW9tbXVfdWFw
aV9nZXRfZGF0YV9zaXplKA0KPiArCQkJCQlJT01NVV9VQVBJX0NBQ0hFX0lOVkFMLA0KPiB2ZXJz
aW9uKTsNCj4gKw0KPiArCQljYWNoZV9pbmZvID0ga3phbGxvYyhpbmZvX3NpemUsIEdGUF9LRVJO
RUwpOw0KPiArCQlpZiAoIWNhY2hlX2luZm8pDQo+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0K
PiArCQlpZiAoY29weV9mcm9tX3VzZXIoY2FjaGVfaW5mbywNCj4gKwkJCSh2b2lkIF9fdXNlciAq
KSAoYXJnICsgbWluc3opLCBpbmZvX3NpemUpKSB7DQo+ICsJCQlrZnJlZShjYWNoZV9pbmZvKTsN
Cj4gKwkJCXJldHVybiAtRUZBVUxUOw0KPiArCQl9DQo+ICsNCj4gKwkJbXV0ZXhfbG9jaygmaW9t
bXUtPmxvY2spOw0KPiArCQlyZXQgPSB2ZmlvX2lvbW11X2Zvcl9lYWNoX2Rldihpb21tdSwgdmZp
b19jYWNoZV9pbnZfZm4sDQo+ICsJCQkJCSAgICBjYWNoZV9pbmZvKTsNCj4gKwkJbXV0ZXhfdW5s
b2NrKCZpb21tdS0+bG9jayk7DQo+ICsJCWtmcmVlKGNhY2hlX2luZm8pOw0KPiArCQlyZXR1cm4g
cmV0Ow0KPiAgCX0NCj4gDQo+ICAJcmV0dXJuIC1FTk9UVFk7DQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvdmZpby5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZmaW8uaA0KPiBpbmRl
eCAyMjM1YmM2Li42MmNhNzkxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmZp
by5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92ZmlvLmgNCj4gQEAgLTg5OSw2ICs4OTks
MjggQEAgc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfYmluZCB7DQo+ICAgKi8NCj4gICNkZWZpbmUg
VkZJT19JT01NVV9CSU5ECQlfSU8oVkZJT19UWVBFLCBWRklPX0JBU0UgKyAyMykNCj4gDQo+ICsv
KioNCj4gKyAqIFZGSU9fSU9NTVVfQ0FDSEVfSU5WQUxJREFURSAtIF9JT1coVkZJT19UWVBFLCBW
RklPX0JBU0UgKyAyNCwNCj4gKyAqCQkJc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfY2FjaGVfaW52
YWxpZGF0ZSkNCj4gKyAqDQo+ICsgKiBQcm9wYWdhdGUgZ3Vlc3QgSU9NTVUgY2FjaGUgaW52YWxp
ZGF0aW9uIHRvIHRoZSBob3N0LiBUaGUgY2FjaGUNCj4gKyAqIGludmFsaWRhdGlvbiBpbmZvcm1h
dGlvbiBpcyBjb252ZXllZCBieSBAY2FjaGVfaW5mbywgdGhlIGNvbnRlbnQNCj4gKyAqIGZvcm1h
dCB3b3VsZCBiZSBzdHJ1Y3R1cmVzIGRlZmluZWQgaW4gdWFwaS9saW51eC9pb21tdS5oLiBVc2Vy
DQo+ICsgKiBzaG91bGQgYmUgYXdhcmUgb2YgdGhhdCB0aGUgc3RydWN0ICBpb21tdV9jYWNoZV9p
bnZhbGlkYXRlX2luZm8NCj4gKyAqIGhhcyBhIEB2ZXJzaW9uIGZpZWxkLCB2ZmlvIG5lZWRzIHRv
IHBhcnNlIHRoaXMgZmllbGQgYmVmb3JlIGdldHRpbmcNCj4gKyAqIGRhdGEgZnJvbSB1c2Vyc3Bh
Y2UuDQo+ICsgKg0KPiArICogQXZhaWxhYmlsaXR5IG9mIHRoaXMgSU9DVEwgaXMgYWZ0ZXIgVkZJ
T19TRVRfSU9NTVUuDQo+ICsgKg0KPiArICogcmV0dXJuczogMCBvbiBzdWNjZXNzLCAtZXJybm8g
b24gZmFpbHVyZS4NCj4gKyAqLw0KPiArc3RydWN0IHZmaW9faW9tbXVfdHlwZTFfY2FjaGVfaW52
YWxpZGF0ZSB7DQo+ICsJX191MzIgICBhcmdzejsNCj4gKwlfX3UzMiAgIGZsYWdzOw0KPiArCXN0
cnVjdAlpb21tdV9jYWNoZV9pbnZhbGlkYXRlX2luZm8gY2FjaGVfaW5mbzsNCj4gK307DQo+ICsj
ZGVmaW5lIFZGSU9fSU9NTVVfQ0FDSEVfSU5WQUxJREFURSAgICAgIF9JTyhWRklPX1RZUEUsIFZG
SU9fQkFTRSArDQo+IDI0KQ0KPiArDQo+ICAvKiAtLS0tLS0tLSBBZGRpdGlvbmFsIEFQSSBmb3Ig
U1BBUFIgVENFIChTZXJ2ZXIgUE9XRVJQQykgSU9NTVUgLS0tLS0tLS0gKi8NCj4gDQo+ICAvKg0K
PiAtLQ0KPiAyLjcuNA0KDQpUaGlzIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUgaW4gZ2VuZXJhbC4g
QnV0IHNpbmNlIHRoZXJlIGlzIHN0aWxsDQphIG1ham9yIG9wZW4gYWJvdXQgdmVyc2lvbiBjb21w
YXRpYmlsaXR5LCBJJ2xsIGhvbGQgbXkgci1iIHVudGlsDQp0aGF0IG9wZW4gaXMgY2xvc2VkLiDw
n5iKDQoNClRoYW5rcw0KS2V2aW4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
