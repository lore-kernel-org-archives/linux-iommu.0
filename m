Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0AC2D0E7
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:23:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17BB120714
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BB120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1A4A8870D;
	Fri, 27 Mar 2020 10:23:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vy8roMUZBt-T; Fri, 27 Mar 2020 10:23:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B56E886F4;
	Fri, 27 Mar 2020 10:23:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11D30C18DA;
	Fri, 27 Mar 2020 10:23:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 399C4C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3534B888BE
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T74SFfjzOjMt for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 10:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1727587C8C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:23:01 +0000 (UTC)
IronPort-SDR: WkzTtEBAfQfPj4HWH2XP06PsvKnVbILoeVA+9W8/ylltF1nSXua99+yi1f780GBNYyKDG2dbIy
 WCIR8f2RzX5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 03:23:00 -0700
IronPort-SDR: 6ZN8f+bSxYAMu9n5uXSQWg/zn0EJ8O2Dk24TSu6QUUHM+CHiqTAqF6gVQsnp4iSOViWy3BPlji
 tjSbyEo3RLYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; d="scan'208";a="271529243"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 03:23:00 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 03:23:00 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 03:23:00 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.144]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 18:22:57 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH 10/10] iommu/vt-d: Register PASID notifier for status
 change
Thread-Topic: [PATCH 10/10] iommu/vt-d: Register PASID notifier for status
 change
Thread-Index: AQHWAs3LAsvpFGSvTECBwK8sBN6czqhcOe4w
Date: Fri, 27 Mar 2020 10:22:57 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED65A@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-11-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-11-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

PiBGcm9tOiBKYWNvYiBQYW4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDI2LCAyMDIwIDE6NTYg
QU0NCj4gDQo+IEluIGJhcmUgbWV0YWwgU1ZBLCBJT01NVSBkcml2ZXIgZW5zdXJlcyB0aGF0IElP
QVNJRCBmcmVlIGNhbGwgYWx3YXlzIGNvbWVzDQo+IGFmdGVyIElPQVNJRCB1bmJpbmQgb3BlcmF0
aW9uLg0KPiANCj4gSG93ZXZlciwgZm9yIGd1ZXN0IFNWQSB0aGUgdW5iaW5kIGFuZCBmcmVlIGNh
bGwgY29tZSBmcm9tIHVzZXIgc3BhY2UNCj4gdmlhIFZGSU8sIHdoaWNoIGNvdWxkIGJlIG91dCBv
ZiBvcmRlci4gVGhpcyBwYXRjaCByZWdpc3RlcnMgYSBub3RpZmllcg0KPiBibG9jayBpbiBjYXNl
IElPQVNJRCBmcmVlKCkgY29tZXMgYmVmb3JlIHVuYmluZCBzdWNoIHRoYXQgVlQtZCBkcml2ZXIN
Cj4gY2FuIHRha2UgYWN0aW9uIHRvIGNsZWFuIHVwIFBBU0lEIGNvbnRleHQgYW5kIGRhdGEuDQoN
CmNsZWFybHkgdGhlIHBhdGNoIGluY2x1ZGVzIG1vcmUgdGhhbiBhYm92ZSB1c2FnZS4gSXQgYWxz
byBoYW5kbGVzIHRoZQ0KYmluZCB1c2FnZSB0byBub3RpZnkgS1ZNIGZvciBzZXR0aW5nIFBBU0lE
IHRyYW5zbGF0aW9uIHRhYmxlLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNvYiBQYW4gPGphY29iLmp1bi5w
YW5AbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMg
ICB8IDY4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAgaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA2OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9pbnRlbC1zdm0uYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMNCj4gaW5k
ZXggZjUxMTg1NWQxODdiLi43NzlkZDJjNmY5ZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9t
bXUvaW50ZWwtc3ZtLmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYw0KPiBAQCAt
MjMsNiArMjMsNyBAQA0KPiAgI2luY2x1ZGUgImludGVsLXBhc2lkLmgiDQo+IA0KPiAgc3RhdGlj
IGlycXJldHVybl90IHBycV9ldmVudF90aHJlYWQoaW50IGlycSwgdm9pZCAqZCk7DQo+ICtzdGF0
aWMgREVGSU5FX01VVEVYKHBhc2lkX211dGV4KTsNCj4gDQo+ICAjZGVmaW5lIFBSUV9PUkRFUiAw
DQo+IA0KPiBAQCAtOTIsNiArOTMsNjUgQEAgc3RhdGljIGlubGluZSBib29sIGludGVsX3N2bV9j
YXBhYmxlKHN0cnVjdA0KPiBpbnRlbF9pb21tdSAqaW9tbXUpDQo+ICAJcmV0dXJuIGlvbW11LT5m
bGFncyAmIFZURF9GTEFHX1NWTV9DQVBBQkxFOw0KPiAgfQ0KPiANCj4gKyNkZWZpbmUgcGFzaWRf
bG9ja19oZWxkKCkgbG9ja19pc19oZWxkKCZwYXNpZF9tdXRleC5kZXBfbWFwKQ0KPiArDQo+ICtz
dGF0aWMgaW50IHBhc2lkX3N0YXR1c19jaGFuZ2Uoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwN
Cj4gKwkJCQl1bnNpZ25lZCBsb25nIGNvZGUsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICsJc3RydWN0
IGlvYXNpZF9uYl9hcmdzICphcmdzID0gKHN0cnVjdCBpb2FzaWRfbmJfYXJncyAqKWRhdGE7DQo+
ICsJc3RydWN0IGludGVsX3N2bV9kZXYgKnNkZXY7DQo+ICsJc3RydWN0IGludGVsX3N2bSAqc3Zt
Ow0KPiArCWludCByZXQgPSBOT1RJRllfRE9ORTsNCj4gKw0KPiArCWlmIChjb2RlID09IElPQVNJ
RF9GUkVFKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFVuYmluZCBhbGwgZGV2aWNlcyBhc3NvY2lhdGVk
IHdpdGggdGhpcyBQQVNJRCB3aGljaCBpcw0KPiArCQkgKiBiZWluZyBmcmVlZCBieSBvdGhlciB1
c2VycyBzdWNoIGFzIFZGSU8uDQo+ICsJCSAqLw0KPiArCQltdXRleF9sb2NrKCZwYXNpZF9tdXRl
eCk7DQo+ICsJCXN2bSA9IGlvYXNpZF9maW5kKElOVkFMSURfSU9BU0lEX1NFVCwgYXJncy0+aWQs
IE5VTEwpOw0KPiArCQlpZiAoIXN2bSB8fCAhc3ZtLT5pb21tdSkNCj4gKwkJCWdvdG8gZG9uZV91
bmxvY2s7DQoNCnNob3VsZCB3ZSB0cmVhdCAhc3ZtLT5pb21tdSBhcyBhbiBlcnJvciBjb25kaXRp
b24/IGlmIG5vdCwgZG8geW91IGhhdmUNCmFuIGV4YW1wbGUgd2hlbiBpdCBtYXkgb2NjdXIgaW4g
bm9ybWFsIHNpdHVhdGlvbj8NCg0KPiArDQo+ICsJCWlmIChJU19FUlIoc3ZtKSkgew0KPiArCQkJ
cmV0ID0gTk9USUZZX0JBRDsNCj4gKwkJCWdvdG8gZG9uZV91bmxvY2s7DQo+ICsJCX0NCg0Kc3Zt
LT5pb21tdSBzaG91bGQgYmUgcmVmZXJlbmNlZCBhZnRlciBJU19FUlIgY2hlY2sNCg0KPiArDQo+
ICsJCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KHNkZXYsICZzdm0tPmRldnMsIGxpc3QsDQo+IHBh
c2lkX2xvY2tfaGVsZCgpKSB7DQo+ICsJCQkvKiBEb2VzIG5vdCBwb2lzb24gZm9yd2FyZCBwb2lu
dGVyICovDQo+ICsJCQlsaXN0X2RlbF9yY3UoJnNkZXYtPmxpc3QpOw0KPiArCQkJaW50ZWxfcGFz
aWRfdGVhcl9kb3duX2VudHJ5KHN2bS0+aW9tbXUsIHNkZXYtDQo+ID5kZXYsDQo+ICsJCQkJCQkg
ICAgc3ZtLT5wYXNpZCk7DQo+ICsJCQlrZnJlZV9yY3Uoc2RldiwgcmN1KTsNCj4gKw0KPiArCQkJ
LyoNCj4gKwkJCSAqIEZyZWUgYmVmb3JlIHVuYmluZCBvbmx5IGhhcHBlbnMgd2l0aCBndWVzdA0K
PiB1c2FnZWQNCj4gKwkJCSAqIGhvc3QgUEFTSURzLiBJT0FTSUQgZnJlZSB3aWxsIGRldGFjaCBw
cml2YXRlIGRhdGENCj4gKwkJCSAqIGFuZCBmcmVlIHRoZSBJT0FTSUQgZW50cnkuDQoNCiJndWVz
dCB1c2FnZWQgaG9zdCBQQVNJRHMiPw0KDQo+ICsJCQkgKi8NCj4gKwkJCWlmIChsaXN0X2VtcHR5
KCZzdm0tPmRldnMpKQ0KPiArCQkJCWtmcmVlKHN2bSk7DQo+ICsJCX0NCj4gKwkJbXV0ZXhfdW5s
b2NrKCZwYXNpZF9tdXRleCk7DQo+ICsNCj4gKwkJcmV0dXJuIE5PVElGWV9PSzsNCj4gKwl9DQo+
ICsNCj4gK2RvbmVfdW5sb2NrOg0KPiArCW11dGV4X3VubG9jaygmcGFzaWRfbXV0ZXgpOw0KPiAr
CXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
cGFzaWRfbmIgPSB7DQo+ICsJCS5ub3RpZmllcl9jYWxsID0gcGFzaWRfc3RhdHVzX2NoYW5nZSwN
Cj4gK307DQo+ICsNCj4gK3ZvaWQgaW50ZWxfc3ZtX2FkZF9wYXNpZF9ub3RpZmllcih2b2lkKQ0K
PiArew0KPiArCWlvYXNpZF9hZGRfbm90aWZpZXIoJnBhc2lkX25iKTsNCj4gK30NCj4gKw0KPiAg
dm9pZCBpbnRlbF9zdm1fY2hlY2soc3RydWN0IGludGVsX2lvbW11ICppb21tdSkNCj4gIHsNCj4g
IAlpZiAoIXBhc2lkX3N1cHBvcnRlZChpb21tdSkpDQo+IEBAIC0yMTksNyArMjc5LDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtbXVfbm90aWZpZXJfb3BzIGludGVsX21tdW9wcyA9DQo+IHsNCj4g
IAkuaW52YWxpZGF0ZV9yYW5nZSA9IGludGVsX2ludmFsaWRhdGVfcmFuZ2UsDQo+ICB9Ow0KPiAN
Cj4gLXN0YXRpYyBERUZJTkVfTVVURVgocGFzaWRfbXV0ZXgpOw0KPiAgc3RhdGljIExJU1RfSEVB
RChnbG9iYWxfc3ZtX2xpc3QpOw0KPiANCj4gICNkZWZpbmUgZm9yX2VhY2hfc3ZtX2RldihzZGV2
LCBzdm0sIGQpCQkJXA0KPiBAQCAtMzE5LDYgKzM3OCw3IEBAIGludCBpbnRlbF9zdm1fYmluZF9n
cGFzaWQoc3RydWN0IGlvbW11X2RvbWFpbg0KPiAqZG9tYWluLA0KPiAgCQkJc3ZtLT5ncGFzaWQg
PSBkYXRhLT5ncGFzaWQ7DQo+ICAJCQlzdm0tPmZsYWdzIHw9IFNWTV9GTEFHX0dVRVNUX1BBU0lE
Ow0KPiAgCQl9DQo+ICsJCXN2bS0+aW9tbXUgPSBpb21tdTsNCg0KYWgsIGl0J3MgaW50ZXJlc3Rp
bmcgdG8gc2VlIHdlIGhhdmUgYSBmaWVsZCBkZWZpbmVkIGJlZm9yZSBidXQgbmV2ZXIgdXNlZC4g
8J+Yig0KDQo+IA0KPiAgCQlpb2FzaWRfYXR0YWNoX2RhdGEoZGF0YS0+aHBhc2lkLCBzdm0pOw0K
PiAgCQlJTklUX0xJU1RfSEVBRF9SQ1UoJnN2bS0+ZGV2cyk7DQo+IEBAIC0zODMsNiArNDQzLDEx
IEBAIGludCBpbnRlbF9zdm1fYmluZF9ncGFzaWQoc3RydWN0IGlvbW11X2RvbWFpbg0KPiAqZG9t
YWluLA0KPiAgCX0NCj4gIAlzdm0tPmZsYWdzIHw9IFNWTV9GTEFHX0dVRVNUX01PREU7DQo+IA0K
PiArCS8qDQo+ICsJICogTm90aWZ5IEtWTSBuZXcgaG9zdC1ndWVzdCBQQVNJRCBiaW5kIGlzIHJl
YWR5LiBLVk0gd2lsbCBzZXQgdXANCj4gKwkgKiBQQVNJRCB0cmFuc2xhdGlvbiB0YWJsZSB0byBz
dXBwb3J0IGd1ZXN0IEVOUUNNRC4NCj4gKwkgKi8NCg0Kc2hvdWxkIHRha2UgaXQgYXMgYW4gZXhh
bXBsZSBpbnN0ZWFkIG9mIHRoZSBvbmx5IHBvc3NpYmxlIHVzYWdlLg0KDQo+ICsJaW9hc2lkX25v
dGlmeShkYXRhLT5ocGFzaWQsIElPQVNJRF9CSU5EKTsNCj4gIAlpbml0X3JjdV9oZWFkKCZzZGV2
LT5yY3UpOw0KPiAgCWxpc3RfYWRkX3JjdSgmc2Rldi0+bGlzdCwgJnN2bS0+ZGV2cyk7DQo+ICAg
b3V0Og0KPiBAQCAtNDQwLDYgKzUwNSw3IEBAIGludCBpbnRlbF9zdm1fdW5iaW5kX2dwYXNpZChz
dHJ1Y3QgZGV2aWNlICpkZXYsIGludA0KPiBwYXNpZCkNCj4gIAkJCQkgKiB1c2VkIGJ5IGFub3Ro
ZXIuDQo+ICAJCQkJICovDQo+ICAJCQkJaW9hc2lkX2F0dGFjaF9kYXRhKHBhc2lkLCBOVUxMKTsN
Cj4gKwkJCQlpb2FzaWRfbm90aWZ5KHBhc2lkLCBJT0FTSURfVU5CSU5EKTsNCj4gIAkJCQlrZnJl
ZShzdm0pOw0KPiAgCQkJfQ0KPiAgCQl9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lu
dGVsLWlvbW11LmggYi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgNCj4gaW5kZXggZjg1MDRh
OTgwOTgxLi42NDc5OTA2N2VhNTggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaW50ZWwt
aW9tbXUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgNCj4gQEAgLTcwOCw2
ICs3MDgsNyBAQCBleHRlcm4gc3RydWN0IGlvbW11X3N2YSAqDQo+ICBpbnRlbF9zdm1fYmluZChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB2b2lkICpkcnZkYXRhKTsN
Cj4gIGV4dGVybiB2b2lkIGludGVsX3N2bV91bmJpbmQoc3RydWN0IGlvbW11X3N2YSAqaGFuZGxl
KTsNCj4gIGV4dGVybiBpbnQgaW50ZWxfc3ZtX2dldF9wYXNpZChzdHJ1Y3QgaW9tbXVfc3ZhICpo
YW5kbGUpOw0KPiArZXh0ZXJuIHZvaWQgaW50ZWxfc3ZtX2FkZF9wYXNpZF9ub3RpZmllcih2b2lk
KTsNCj4gDQo+ICBzdHJ1Y3Qgc3ZtX2Rldl9vcHM7DQo+IA0KPiAtLQ0KPiAyLjcuNA0KPiANCj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gaW9tbXUg
bWFpbGluZyBsaXN0DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IGh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11DQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
