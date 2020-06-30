Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755ABC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:07:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BFA2078B
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BFA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A7B087DE1;
	Tue, 30 Jun 2020 01:07:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AioYaWScNz9d; Tue, 30 Jun 2020 01:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CE3B87DD7;
	Tue, 30 Jun 2020 01:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C52F9C0865;
	Tue, 30 Jun 2020 01:07:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1D5AC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A300986204
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:07:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v4AE-mqs07oN for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 01:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14D4586053
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:07:38 +0000 (UTC)
IronPort-SDR: pD8tAf4GVLF884P90aUN9H0v75mfdRD0welGEKsozjLe3IzMz0SgQleKvemwZqv+O+UN4VU3XT
 gyuB2qmHmeRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145184985"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="145184985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 18:07:37 -0700
IronPort-SDR: kGRx+YEb453Pvy0g34UT43n3nzebgsN3dhv0bzJr1xJsVPwByS5GbjR+8qM+7tv+pkXsq5gbxp
 UJ+wLUq786mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="264981824"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2020 18:07:34 -0700
Subject: Re: [PATCH 1/2] iommu: Add iommu_group_get/set_domain()
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200627031532.28046-1-baolu.lu@linux.intel.com>
 <acc0a8fd-bd23-fc34-aecc-67796ab216e7@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5dc1cece-6111-9b56-d04c-9553d592675b@linux.intel.com>
Date: Tue, 30 Jun 2020 09:03:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <acc0a8fd-bd23-fc34-aecc-67796ab216e7@arm.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

SGkgUm9iaW4sCgpPbiA2LzI5LzIwIDc6NTYgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIwLTA2LTI3IDA0OjE1LCBMdSBCYW9sdSB3cm90ZToKPj4gVGhlIGhhcmR3YXJlIGFzc2lzdGFu
dCB2ZmlvIG1lZGlhdGVkIGRldmljZSBpcyBhIHVzZSBjYXNlIG9mIGlvbW11Cj4+IGF1eC1kb21h
aW4uIFRoZSBpbnRlcmFjdGlvbnMgYmV0d2VlbiB2ZmlvL21kZXYgYW5kIGlvbW11IGR1cmluZyBt
ZGV2Cj4+IGNyZWF0aW9uIGFuZCBwYXNzdGhyIGFyZToKPj4KPj4gLSBDcmVhdGUgYSBncm91cCBm
b3IgbWRldiB3aXRoIGlvbW11X2dyb3VwX2FsbG9jKCk7Cj4+IC0gQWRkIHRoZSBkZXZpY2UgdG8g
dGhlIGdyb3VwIHdpdGgKPj4gwqDCoMKgwqDCoMKgwqDCoCBncm91cCA9IGlvbW11X2dyb3VwX2Fs
bG9jKCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihncm91cCkpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKGdyb3VwKTsKPj4KPj4gwqDC
oMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9ncm91cF9hZGRfZGV2aWNlKGdyb3VwLCAmbWRldi0+
ZGV2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJldCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZGV2X2luZm8oJm1kZXYtPmRldiwgIk1ERVY6IGdyb3VwX2lkID0gJWRc
biIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlvbW11X2dyb3VwX2lkKGdyb3VwKSk7Cj4+IC0gQWxsb2NhdGUgYW4gYXV4LWRvbWFpbgo+PiDC
oMKgwqDCoGlvbW11X2RvbWFpbl9hbGxvYygpCj4+IC0gQXR0YWNoIHRoZSBhdXgtZG9tYWluIHRv
IHRoZSBwaHlzaWNhbCBkZXZpY2UgZnJvbSB3aGljaCB0aGUgbWRldiBpcwo+PiDCoMKgIGNyZWF0
ZWQuCj4+IMKgwqDCoMKgaW9tbXVfYXV4X2F0dGFjaF9kZXZpY2UoKQo+Pgo+PiBJbiB0aGUgd2hv
bGUgcHJvY2VzcywgYW4gaW9tbXUgZ3JvdXAgd2FzIGFsbG9jYXRlZCBmb3IgdGhlIG1kZXYgYW5k
IGFuCj4+IGlvbW11IGRvbWFpbiB3YXMgYXR0YWNoZWQgdG8gdGhlIGdyb3VwLCBidXQgdGhlIGdy
b3VwLT5kb21haW4gbGVhdmVzCj4+IE5VTEwuIEFzIHRoZSByZXN1bHQsIGlvbW11X2dldF9kb21h
aW5fZm9yX2RldigpIGRvZXNuJ3Qgd29yayBhbnltb3JlLgo+Pgo+PiBUaGlzIGFkZHMgaW9tbXVf
Z3JvdXBfZ2V0L3NldF9kb21haW4oKSBzbyB0aGF0IGdyb3VwLT5kb21haW4gY291bGQgYmUKPj4g
bWFuYWdlZCB3aGVuZXZlciBhIGRvbWFpbiBpcyBhdHRhY2hlZCBvciBkZXRhY2hlZCB0aHJvdWdo
IHRoZSBhdXgtZG9tYWluCj4+IGFwaSdzLgo+IAo+IExldHRpbmcgZXh0ZXJuYWwgY2FsbGVycyBw
b2tlIGFyb3VuZCBkaXJlY3RseSBpbiB0aGUgaW50ZXJuYWxzIG9mIAo+IGlvbW11X2dyb3VwIGRv
ZXNuJ3QgbG9vayByaWdodCB0byBtZS4KClVuZm9ydHVuYXRlbHksIGl0IHNlZW1zIHRoYXQgdGhl
IHZpZm8gaW9tbXUgYWJzdHJhY3Rpb24gaXMgZGVlcGx5IGJvdW5kCnRvIHRoZSBJT01NVSBzdWJz
eXN0ZW0uIFdlIGNhbiBlYXNpbHkgZmluZCBvdGhlciBleGFtcGxlczoKCmlvbW11X2dyb3VwX2dl
dC9zZXRfaW9tbXVkYXRhKCkKaW9tbXVfZ3JvdXBfZ2V0L3NldF9uYW1lKCkKLi4uCgo+IAo+IElm
IGEgcmVndWxhciBkZXZpY2UgaXMgYXR0YWNoZWQgdG8gb25lIG9yIG1vcmUgYXV4IGRvbWFpbnMg
Zm9yIFBBU0lEIAo+IHVzZSwgaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KCkgaXMgc3RpbGwgZ29p
bmcgdG8gcmV0dXJuIHRoZSBwcmltYXJ5IAo+IGRvbWFpbiwgc28gd2h5IHNob3VsZCBpdCBiZSBl
eHBlY3RlZCB0byBiZWhhdmUgZGlmZmVyZW50bHkgZm9yIG1lZGlhdGVkCgpVbmxpa2UgdGhlIG5v
cm1hbCBkZXZpY2UgYXR0YWNoLCB3ZSB3aWxsIGVuY291bnRlciB0d28gZGV2aWNlcyB3aGVuIGl0
CmNvbWVzIHRvIGF1eC1kb21haW4uCgotIFBhcmVudCBwaHlzaWNhbCBkZXZpY2UgLSB0aGlzIG1p
Z2h0IGJlLCBmb3IgZXhhbXBsZSwgYSBQQ0llIGRldmljZQp3aXRoIFBBU0lEIGZlYXR1cmUgc3Vw
cG9ydCwgaGVuY2UgaXQgaXMgYWJsZSB0byB0YWcgYW4gdW5pcXVlIFBBU0lECmZvciBETUEgdHJh
bnNmZXJzIG9yaWdpbmF0ZWQgZnJvbSBpdHMgc3Vic2V0LiBUaGUgZGV2aWNlIGRyaXZlciBoZW5j
ZQppcyBhYmxlIHRvIHdyYXBwZXIgdGhpcyBzdWJzZXQgaW50byBhbiBpc29sYXRlZDoKCi0gTWVk
aWF0ZWQgZGV2aWNlIC0gYSBmYWtlIGRldmljZSBjcmVhdGVkIGJ5IHRoZSBkZXZpY2UgZHJpdmVy
IG1lbnRpb25lZAphYm92ZS4KClllcy4gQWxsIHlvdSBtZW50aW9uZWQgYXJlIHJpZ2h0IGZvciB0
aGUgcGFyZW50IGRldmljZS4gQnV0IGZvciBtZWRpYXRlZApkZXZpY2UsIGlvbW11X2dldF9kb21h
aW5fZm9yX2RldigpIGRvZXNuJ3Qgd29yayBldmVuIGl0IGhhcyBhbiB2YWxpZAppb21tdV9ncm91
cCBhbmQgaW9tbXVfZG9tYWluLgoKaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2KCkgaXMgYSBuZWNl
c3NhcnkgaW50ZXJmYWNlIGZvciBkZXZpY2UgZHJpdmVycwp3aGljaCB3YW50IHRvIHN1cHBvcnQg
YXV4LWRvbWFpbi4gRm9yIGV4YW1wbGUsCgogICAgICAgICAgIHN0cnVjdCBpb21tdV9kb21haW4g
KmRvbWFpbjsKICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtZGV2X2RldihtZGV2KTsK
CSAgdW5zaWduZWQgbG9uZyBwYXNpZDsKCiAgICAgICAgICAgZG9tYWluID0gaW9tbXVfZ2V0X2Rv
bWFpbl9mb3JfZGV2KGRldik7CiAgICAgICAgICAgaWYgKCFkb21haW4pCiAgICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RFVjsKCiAgICAgICAgICAgcGFzaWQgPSBpb21tdV9hdXhfZ2V0X3Bh
c2lkKGRvbWFpbiwgZGV2LT5wYXJlbnQpOwoJICBpZiAocGFzaWQgPT0gSU9BU0lEX0lOVkFMSUQp
CgkJICByZXR1cm4gLUVJTlZBTDsKCgkgIC8qIFByb2dyYW0gdGhlIGRldmljZSBjb250ZXh0IHdp
dGggdGhlIFBBU0lEIHZhbHVlICovCgkgIC4uLi4KCldpdGhvdXQgdGhpcyBmaXgsIGlvbW11X2dl
dF9kb21haW5fZm9yX2RldigpIGFsd2F5cyByZXR1cm5zIE5VTEwgYW5kIHRoZQpkZXZpY2UgZHJp
dmVyIGhhcyBubyBtZWFucyB0byBzdXBwb3J0IGF1eC1kb21haW4uCgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cgo+IGRldmljZXM/IEFGQUlDUyBpdCdzIHBlcmZlY3RseSBsZWdpdGltYXRlIHRvIGhhdmUg
bm8gcHJpbWFyeSBkb21haW4gaWYgCj4gdHJhZmZpYy13aXRob3V0LVBBU0lEIGlzIGludmFsaWQu
Cj4gCj4gUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
