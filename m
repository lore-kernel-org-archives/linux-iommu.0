Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE764C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 00:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 459FC4031F;
	Mon, 14 Feb 2022 00:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ixbJXD5sYMfK; Mon, 14 Feb 2022 00:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED201402FB;
	Mon, 14 Feb 2022 00:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0656C001A;
	Mon, 14 Feb 2022 00:52:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 754E5C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BE4640463
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ttl26mMgQBXf for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 00:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03198400F1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644799931; x=1676335931;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=A7I9zLwsVImPNRQZmWXcl3s9YjInQxRy4fAobdgLVV8=;
 b=Jjc0+XjmX2nI7okoSDBQuT4JZj9Pj/BUfs48xg8ABBCrcKAOBhhD7tNm
 kOV1RJ4xrgbMo1NdQ2fGN2Ka6B91Y6LsRbmiXVMOKeWtFlI07Ahii2t6X
 OHDjmu7DPxxHdfXGkJTr3mF7iLn8s/sJ0MBICKo8J+bgIhrhE8QsEKKEg
 REc5nmKVODetczquhI5WiP+e6muYqc05LbvUa2GaXC1YHU5GRCG1YsfcG
 MxRuxlCNTUi9zP7VVuSXnEdA8f06jc9TP4c5OqTtTBhm2GPpxaSzvRiSx
 UPd3P8nGC/a8Phpks52uXUAibozEoT42QLfrlIAc37dB+vFx9PQ+6+NyH w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249933243"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="249933243"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 16:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680109475"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 16:52:05 -0800
Message-ID: <73989fc7-b01e-fbfc-3fbd-cef0ec326334@linux.intel.com>
Date: Mon, 14 Feb 2022 08:50:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
 <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4sCgpPbiAyLzkvMjIgOTo1MiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIw
MjItMDItMDggMDE6MjUsIEx1IEJhb2x1IHdyb3RlOgo+PiBUaGUgaXNfYXR0YWNoX2RlZmVycmVk
IGlvbW11X29wcyBjYWxsYmFjayBpcyBhIGRldmljZSBvcC4gVGhlIGRvbWFpbgo+PiBhcmd1bWVu
dCBpcyB1bm5lY2Vzc2FyeSBhbmQgbmV2ZXIgdXNlZC4gUmVtb3ZlIGl0IHRvIG1ha2UgY29kZSBj
bGVhbi4KPj4KPj4gU3VnZ2VzdGVkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29t
Pgo+PiAtLS0KPj4gwqAgaW5jbHVkZS9saW51eC9pb21tdS5owqDCoMKgwqDCoMKgwqDCoCB8wqAg
MiArLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FtZC9hbWRfaW9tbXUuaCB8wqAgMyArLS0KPj4gwqAg
ZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuY8KgwqDCoMKgIHzCoCAzICstLQo+PiDCoCBkcml2ZXJz
L2lvbW11L2FtZC9pb21tdV92Mi5jwqAgfMKgIDIgKy0KPj4gwqAgZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jwqDCoCB8wqAgMyArLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pb21tdS5jwqDCoMKg
wqDCoMKgwqDCoCB8IDE1ICsrKysrKy0tLS0tLS0tLQo+PiDCoCA2IGZpbGVzIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+IGluZGV4IGViMjY4NGY5
NTAxOC4uNDdjYTdlY2E1ZDdiIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgK
Pj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+IEBAIC0yNjksNyArMjY5LDcgQEAgc3Ry
dWN0IGlvbW11X29wcyB7Cj4+IMKgwqDCoMKgwqAgdm9pZCAoKnB1dF9yZXN2X3JlZ2lvbnMpKHN0
cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGxpc3RfaGVhZCAKPj4gKmxpc3QpOwo+PiDCoMKgwqDC
oMKgIGludCAoKm9mX3hsYXRlKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBvZl9waGFuZGxl
X2FyZ3MgKmFyZ3MpOwo+PiAtwqDCoMKgIGJvb2wgKCppc19hdHRhY2hfZGVmZXJyZWQpKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0IAo+PiBkZXZpY2UgKmRldik7Cj4+ICvCoMKg
wqAgYm9vbCAoKmlzX2F0dGFjaF9kZWZlcnJlZCkoc3RydWN0IGRldmljZSAqZGV2KTsKPj4gwqDC
oMKgwqDCoCAvKiBQZXIgZGV2aWNlIElPTU1VIGZlYXR1cmVzICovCj4+IMKgwqDCoMKgwqAgYm9v
bCAoKmRldl9oYXNfZmVhdCkoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGlvbW11X2Rldl9mZWF0
dXJlcyAKPj4gZik7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9hbWRfaW9tbXUu
aCAKPj4gYi9kcml2ZXJzL2lvbW11L2FtZC9hbWRfaW9tbXUuaAo+PiBpbmRleCA0MTY4MTVhNTI1
ZDYuLjNiMmYwNmI3YWNhNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWQvYW1kX2lv
bW11LmgKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWQvYW1kX2lvbW11LmgKPj4gQEAgLTExNiw4
ICsxMTYsNyBAQCB2b2lkIGFtZF9pb21tdV9kb21haW5fY2xyX3B0X3Jvb3Qoc3RydWN0IAo+PiBw
cm90ZWN0aW9uX2RvbWFpbiAqZG9tYWluKQo+PiDCoCBleHRlcm4gYm9vbCB0cmFuc2xhdGlvbl9w
cmVfZW5hYmxlZChzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSk7Cj4+IC1leHRlcm4gYm9vbCBhbWRf
aW9tbXVfaXNfYXR0YWNoX2RlZmVycmVkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAq
ZGV2KTsKPj4gK2V4dGVybiBib29sIGFtZF9pb21tdV9pc19hdHRhY2hfZGVmZXJyZWQoc3RydWN0
IGRldmljZSAqZGV2KTsKPj4gwqAgZXh0ZXJuIGludCBfX2luaXQgYWRkX3NwZWNpYWxfZGV2aWNl
KHU4IHR5cGUsIHU4IGlkLCB1MTYgKmRldmlkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGNtZF9saW5lKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYW1kL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jCj4+IGluZGV4
IDQ2MWYxODQ0ZWQxZi4uMzdmMmZiYjRiMTI5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11
L2FtZC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11LmMKPj4gQEAgLTIy
MTUsOCArMjIxNSw3IEBAIHN0YXRpYyB2b2lkIGFtZF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0
cnVjdCAKPj4gZGV2aWNlICpkZXYsCj4+IMKgwqDCoMKgwqAgbGlzdF9hZGRfdGFpbCgmcmVnaW9u
LT5saXN0LCBoZWFkKTsKPj4gwqAgfQo+PiAtYm9vbCBhbWRfaW9tbXVfaXNfYXR0YWNoX2RlZmVy
cmVkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2KQo+PiArYm9vbCBhbWRfaW9tbXVfaXNf
YXR0YWNoX2RlZmVycmVkKHN0cnVjdCBkZXZpY2UgKmRldikKPj4gwqAgewo+PiDCoMKgwqDCoMKg
IHN0cnVjdCBpb21tdV9kZXZfZGF0YSAqZGV2X2RhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2
KTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmMgYi9kcml2ZXJz
L2lvbW11L2FtZC9pb21tdV92Mi5jCj4+IGluZGV4IDU4ZGEwOGNjM2QwMS4uN2M5NGVjMDVkMjg5
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZC9pb21tdV92Mi5jCj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvYW1kL2lvbW11X3YyLmMKPj4gQEAgLTUzNyw3ICs1MzcsNyBAQCBzdGF0aWMg
aW50IHBwcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCAKPj4gdW5zaWduZWQg
bG9uZyBlLCB2b2lkICpkYXRhKQo+PiDCoMKgwqDCoMKgIHJldCA9IE5PVElGWV9ET05FOwo+PiDC
oMKgwqDCoMKgIC8qIEluIGtkdW1wIGtlcm5lbCBwY2kgZGV2IGlzIG5vdCBpbml0aWFsaXplZCB5
ZXQgLT4gc2VuZCAKPj4gSU5WQUxJRCAqLwo+PiAtwqDCoMKgIGlmIChhbWRfaW9tbXVfaXNfYXR0
YWNoX2RlZmVycmVkKE5VTEwsICZwZGV2LT5kZXYpKSB7Cj4+ICvCoMKgwqAgaWYgKGFtZF9pb21t
dV9pc19hdHRhY2hfZGVmZXJyZWQoJnBkZXYtPmRldikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGFtZF9pb21tdV9jb21wbGV0ZV9wcHIocGRldiwgaW9tbXVfZmF1bHQtPnBhc2lkLAo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUFBSX0lOVkFMSUQs
IHRhZyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+
PiBpbmRleCAyYjVmNGU1N2E4YmIuLjgwZjEyOTRiZTYzNCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
Ywo+PiBAQCAtNTA1Miw4ICs1MDUyLDcgQEAgaW50ZWxfaW9tbXVfZGV2X2Rpc2FibGVfZmVhdChz
dHJ1Y3QgZGV2aWNlICpkZXYsIAo+PiBlbnVtIGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQo+PiDC
oMKgwqDCoMKgIH0KPj4gwqAgfQo+PiAtc3RhdGljIGJvb2wgaW50ZWxfaW9tbXVfaXNfYXR0YWNo
X2RlZmVycmVkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldikKPj4gK3N0
YXRpYyBib29sIGludGVsX2lvbW11X2lzX2F0dGFjaF9kZWZlcnJlZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCByZXR1cm4gYXR0YWNoX2RlZmVycmVkKGRldik7Cj4g
Cj4gU2VlbXMgbGlrZSB0aGVyZSdzIG5vIG5lZWQgdG8gd3JhcCB0aGlzIG5vdz8KCkkganVzdCBy
ZWFsaXplZCB0aGF0IEkgaGF2ZSBjbGVhbmVkIHRoaXMgdXAgaW4gdGhpcyBwYXRjaC4KCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjIwMjA3MDY0MTQyLjEwOTI4NDYtNy1i
YW9sdS5sdUBsaW51eC5pbnRlbC5jb20vCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
