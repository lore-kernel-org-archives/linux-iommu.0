Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92807C4321B
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 18:45:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BB520820
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 18:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BB520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 390FADB4;
	Mon, 10 Jun 2019 18:45:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 068D2D3E
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 18:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 993F26D6
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 18:45:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Jun 2019 11:45:23 -0700
X-ExtLoop1: 1
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
	by orsmga002.jf.intel.com with ESMTP; 10 Jun 2019 11:45:23 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.248]) by
	ORSMSX102.amr.corp.intel.com ([169.254.3.187]) with mapi id
	14.03.0415.000; Mon, 10 Jun 2019 11:45:23 -0700
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
	generic iommu
Thread-Topic: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
	generic iommu
Thread-Index: AQHVHm1riigSOeMSoEKdi5DrOzgP5aaVsjoA
Date: Mon, 10 Jun 2019 18:45:23 +0000
Message-ID: <1560192412.27481.12.camel@intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
	<20190609023803.23832-6-baolu.lu@linux.intel.com>
In-Reply-To: <20190609023803.23832-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-ID: <06FAD7A4365DF84993512DC9E698AAA7@intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"cai@lca.pw" <cai@lca.pw>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gU3VuLCAyMDE5LTA2LTA5IGF0IDEwOjM4ICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gwqBz
dGF0aWMgaW50IF9faW5pdCBzaV9kb21haW5faW5pdChpbnQgaHcpDQo+IEBAIC0zMzA2LDE0ICsz
MjUyLDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfZG1hcnModm9pZCkNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocGFzaWRfc3VwcG9ydGVkKGlvbW11KSkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZWxfc3ZtX2lu
aXQoaW9tbXUpOw0KPiDCoCNlbmRpZg0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IC3CoMKg
wqDCoMKgwqDCoC8qDQo+IC3CoMKgwqDCoMKgwqDCoCAqIE5vdyB0aGF0IHFpIGlzIGVuYWJsZWQg
b24gYWxsIGlvbW11cywgc2V0IHRoZSByb290IGVudHJ5DQo+IGFuZCBmbHVzaA0KPiAtwqDCoMKg
wqDCoMKgwqAgKiBjYWNoZXMuIFRoaXMgaXMgcmVxdWlyZWQgb24gc29tZSBJbnRlbCBYNTggY2hp
cHNldHMsDQo+IG90aGVyd2lzZSB0aGUNCj4gLcKgwqDCoMKgwqDCoMKgICogZmx1c2hfY29udGV4
dCBmdW5jdGlvbiB3aWxsIGxvb3AgZm9yZXZlciBhbmQgdGhlIGJvb3QNCj4gaGFuZ3MuDQo+IC3C
oMKgwqDCoMKgwqDCoCAqLw0KPiAtwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9hY3RpdmVfaW9tbXUo
aW9tbXUsIGRyaGQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBOb3cgdGhhdCBxaSBpcyBlbmFibGVkIG9u
IGFsbCBpb21tdXMsIHNldCB0aGUgcm9vdA0KPiBlbnRyeSBhbmQNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGZsdXNoIGNhY2hlcy4gVGhpcyBpcyByZXF1aXJlZCBvbiBzb21l
IEludGVsIFg1OA0KPiBjaGlwc2V0cywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIG90aGVyd2lzZSB0aGUgZmx1c2hfY29udGV4dCBmdW5jdGlvbiB3aWxsIGxvb3ANCj4gZm9y
ZXZlciBhbmQNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHRoZSBib290IGhh
bmdzLg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaW9tbXVfZmx1c2hfd3JpdGVfYnVmZmVyKGlvbW11KTsNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpb21tdV9zZXRfcm9vdF9lbnRyeShpb21t
dSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW9tbXUtPmZsdXNoLmZsdXNo
X2NvbnRleHQoaW9tbXUsIDAsIDAsIDAsDQo+IERNQV9DQ01EX0dMT0JBTF9JTlZMKTsNCg0KDQpU
aGlzIGNoYW5nZXMgdGhlIGludGVudCBvZiB0aGUgb3JpZ2luYWwgY29kZS4gQXMgdGhlIGNvbW1l
bnQgc2F5cw0KZW5hYmxlIFFJIG9uIGFsbCBJT01NVXMsIHRoZW4gZmx1c2ggdGhlIGNhY2hlcyBh
bmQgc2V0IHRoZSByb290IGVudHJ5Lg0KVGhlIG9yZGVyIG9mIHNldHRpbmcgdGhlIHJvb3QgZW50
cmllcyBoYXMgY2hhbmdlZCBub3cuDQoNClJlZmVyOsKgDQpDb21taXQgYTRjMzRmZjFjMDI5ICgn
aW9tbXUvdnQtZDogRW5hYmxlIFFJIG9uIGFsbCBJT01NVXMgYmVmb3JlDQpzZXR0aW5nIHJvb3Qg
ZW50cnknKQ0KDQotLVNvaGlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
