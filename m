Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C421CC433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 03:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56C2C84CD3;
	Tue, 25 Jan 2022 03:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tosxwhy7Kz-z; Tue, 25 Jan 2022 03:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 19E6784CD6;
	Tue, 25 Jan 2022 03:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3019C0031;
	Tue, 25 Jan 2022 03:55:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A38ABC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DF2C84CD6
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PaclN4yPt-O for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:55:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85C9584CD3
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643082931; x=1674618931;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=zlw5ADHuEjC3rrgpbVFAVmAXOq0f2hfek2JlqjXlmsE=;
 b=Fb1Ttvxa/rYQ6RBNCRlauqL8dDw1FDsSWDRs0sCrvw8Fkau4hkOw19s2
 YXjAbJzOE2BazYc7hAuTb1J5xCo6BFXRoPtIw5s4ulkBjoLpZMU51RWTN
 +RY/02pqKBH1CwAmvz+4x5n6leLaythNS/OwC+PeqTEi5RAdactPHN1xa
 Vn7N8MxqpkVaKa0EOfJyRPdKiwx0XZH5Tjx1HHTYRjKQXVi8GR8Nwm6jI
 7VndeJ7/lPFCOUK13RbgDiaz1OfhNs8NYkg5emDVcaPUq39Zd+Mk+uM6N
 +cdUii3kW91QaVvovjsIosOrJdBIcd//H23LWoQa1UDo5rtCM63qSwQX0 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246429216"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="246429216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534545827"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:55:15 -0800
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <363b8f7d-5459-0d19-c1ac-a2c6bce9d26f@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d4fea6f-aa21-3703-a254-2594004c60a1@linux.intel.com>
Date: Tue, 25 Jan 2022 11:54:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <363b8f7d-5459-0d19-c1ac-a2c6bce9d26f@arm.com>
Content-Language: en-US
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
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

Ck9uIDEvMjUvMjIgODoyMCBBTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDEtMjQg
MDc6MTEsIEx1IEJhb2x1IHdyb3RlOgo+PiBUaGUgY29tbW9uIGlvbW11X29wcyBpcyBob29rZWQg
dG8gYm90aCBkZXZpY2UgYW5kIGRvbWFpbi4gV2hlbiBhIGhlbHBlcgo+PiBoYXMgYm90aCBkZXZp
Y2UgYW5kIGRvbWFpbiBwb2ludGVyLCB0aGUgd2F5IHRvIGdldCB0aGUgaW9tbXVfb3BzIGxvb2tz
Cj4+IG1lc3N5IGluIGlvbW11IGNvcmUuIFRoaXMgc29ydHMgb3V0IHRoZSB3YXkgdG8gZ2V0IGlv
bW11X29wcy4gVGhlIGRldmljZQo+PiByZWxhdGVkIGhlbHBlcnMgZ28gdGhyb3VnaCBkZXZpY2Ug
cG9pbnRlciwgd2hpbGUgdGhlIGRvbWFpbiByZWxhdGVkIG9uZXMKPj4gZ28gdGhyb3VnaCBkb21h
aW4gcG9pbnRlci4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4KPj4gLS0tCj4+IMKgIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8wqAgOCArKysr
KysrKwo+PiDCoCBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCAyNSArKysrKysrKysrKysrKy0tLS0t
LS0tLS0tCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lvbW11LmggYi9pbmNsdWRl
L2xpbnV4L2lvbW11LmgKPj4gaW5kZXggYWE1NDg2MjQzODkyLi4xMTFiM2U5Yzc5YmIgMTAwNjQ0
Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2lv
bW11LmgKPj4gQEAgLTM4NSw2ICszODUsMTQgQEAgc3RhdGljIGlubGluZSB2b2lkIGlvbW11X2lv
dGxiX2dhdGhlcl9pbml0KHN0cnVjdCAKPj4gaW9tbXVfaW90bGJfZ2F0aGVyICpnYXRoZXIpCj4+
IMKgwqDCoMKgwqAgfTsKPj4gwqAgfQo+PiArc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgaW9t
bXVfb3BzICpkZXZfaW9tbXVfb3BzX2dldChzdHJ1Y3QgZGV2aWNlIAo+PiAqZGV2KQo+PiArewo+
PiArwqDCoMKgIGlmIChkZXYgJiYgZGV2LT5pb21tdSAmJiBkZXYtPmlvbW11LT5pb21tdV9kZXYp
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZGV2LT5pb21tdS0+aW9tbXVfZGV2LT5vcHM7Cj4+
ICsKPj4gK8KgwqDCoCByZXR1cm4gTlVMTDsKPiAKPiBUaGlzIHByb2JhYmx5IHdhcnJhbnRzIGF0
IGxlYXN0IGEgV0FSTiwgYnV0IGl0J3MgYXJndWFibGUgdG8ganVzdCBhc3N1bWUgCj4gdGhhdCB2
YWxpZCBvcHMgbXVzdCBiZSBpbnN0YWxsZWQgaWYgaW9tbXVfcHJvYmVfZGV2aWNlKCkgaGFzIHN1
Y2NlZWRlZC4gCj4gVGhlIGRldmljZSBvcHMgYXJlIGVzc2VudGlhbGx5IGZvciBpbnRlcm5hbCB1
c2Ugd2l0aGluIHRoZSBJT01NVSAKPiBzdWJzeXN0ZW0gaXRzZWxmLCBzbyB3ZSBzaG91bGQgYmUg
YWJsZSB0byB0cnVzdCBvdXJzZWx2ZXMgbm90IHRvIG1pc3VzZSAKPiB0aGUgaGVscGVyLgoKSSBh
Z3JlZSB0aGF0IHdlIGNvdWxkIGFkZCBhIFdBUk4oKSBoZXJlLiBUaGUgZXhwZWN0YXRpb24gaXMg
dGhhdCBldmVyeQpkZXZpY2UgZ29pbmcgdGhyb3VnaCB0aGUgSU9NTVUgaW50ZXJmYWNlcyBvciBo
ZWxwZXJzIHNob3VsZCBoYXZlIGJlZW4KcHJvYmVkIGJ5IGlvbW11X3Byb2JlX2RldmljZSgpLgoK
PiAKPj4gK30KPj4gKwo+PiDCoCAjZGVmaW5lIElPTU1VX0JVU19OT1RJRllfUFJJT1JJVFnCoMKg
wqDCoMKgwqDCoCAwCj4+IMKgICNkZWZpbmUgSU9NTVVfR1JPVVBfTk9USUZZX0FERF9ERVZJQ0XC
oMKgwqDCoMKgwqDCoCAxIC8qIERldmljZSBhZGRlZCAqLwo+PiDCoCAjZGVmaW5lIElPTU1VX0dS
T1VQX05PVElGWV9ERUxfREVWSUNFwqDCoMKgwqDCoMKgwqAgMiAvKiBQcmUgRGV2aWNlIHJlbW92
ZWQgKi8KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvaW9tbXUuYwo+PiBpbmRleCA1MjMwYzZkOTBlY2UuLjY2MzFlMmVhNDRkZiAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUu
Ywo+PiBAQCAtNzY0LDYgKzc2NCw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2dyb3VwX3Nl
dF9uYW1lKTsKPj4gwqAgc3RhdGljIGludCBpb21tdV9jcmVhdGVfZGV2aWNlX2RpcmVjdF9tYXBw
aW5ncyhzdHJ1Y3QgaW9tbXVfZ3JvdXAgCj4+ICpncm91cCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2
KQo+PiDCoCB7Cj4+ICvCoMKgwqAgY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gZGV2X2lv
bW11X29wc19nZXQoZGV2KTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21h
aW4gPSBncm91cC0+ZGVmYXVsdF9kb21haW47Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGlvbW11X3Jl
c3ZfcmVnaW9uICplbnRyeTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIG1hcHBpbmdz
Owo+PiBAQCAtNzg1LDggKzc4Niw4IEBAIHN0YXRpYyBpbnQgCj4+IGlvbW11X2NyZWF0ZV9kZXZp
Y2VfZGlyZWN0X21hcHBpbmdzKHN0cnVjdCBpb21tdV9ncm91cCAqZ3JvdXAsCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBkbWFfYWRkcl90IHN0YXJ0LCBlbmQsIGFkZHI7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBzaXplX3QgbWFwX3NpemUgPSAwOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGRvbWFpbi0+
b3BzLT5hcHBseV9yZXN2X3JlZ2lvbikKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWlu
LT5vcHMtPmFwcGx5X3Jlc3ZfcmVnaW9uKGRldiwgZG9tYWluLCBlbnRyeSk7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAob3BzLT5hcHBseV9yZXN2X3JlZ2lvbikKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgb3BzLT5hcHBseV9yZXN2X3JlZ2lvbihkZXYsIGRvbWFpbiwgZW50cnkpOwo+IAo+IFN0
cmljdGx5IEkgdGhpbmsgdGhpcyB3YXMgYSBkb21haW4gb3AsIGFzIGl0IHdhcyBhYm91dCByZXNl
cnZpbmcgdGhlIAo+IElPVkEgcmFuZ2UgaW4gdGhlIGdpdmVuIERNQSBkb21haW4uIEFsc28gdGFr
aW5nIHRoZSBkb21haW4gYXMgYW4gCj4gYXJndW1lbnQgaXMgYSBiaXQgb2YgYSBnaXZlYXdheS4g
SG93ZXZlciBpdCdzIG5vdyBqdXN0IGRlYWQgY29kZSBlaXRoZXIgCj4gd2F5IHNpbmNlIHRoZXJl
IGFyZSBubyByZW1haW5pbmcgaW1wbGVtZW50YXRpb25zLCBhbmQgbm8gcmVhc29uIGZvciBhbnkg
Cj4gbmV3IG9uZXMuCgpUaGlzIGNhbGxiYWNrIGlzIGEgZGVhZCBjb2RlLiBJIHdpbGwgY2xlYW51
cCBpdC4KCiQgZ2l0IGdyZXAgYXBwbHlfcmVzdl9yZWdpb24KZHJpdmVycy9pb21tdS9pb21tdS5j
OiAgICAgICAgICBpZiAob3BzLT5hcHBseV9yZXN2X3JlZ2lvbikKZHJpdmVycy9pb21tdS9pb21t
dS5jOiAgICAgICAgICAgICAgICAgIG9wcy0+YXBwbHlfcmVzdl9yZWdpb24oZGV2LCAKZG9tYWlu
LCBlbnRyeSk7CmluY2x1ZGUvbGludXgvaW9tbXUuaDogKiBAYXBwbHlfcmVzdl9yZWdpb246IFRl
bXBvcmFyeSBoZWxwZXIgY2FsbC1iYWNrIApmb3IgaW92YSByZXNlcnZlZCByYW5nZXMKaW5jbHVk
ZS9saW51eC9pb21tdS5oOiAgdm9pZCAoKmFwcGx5X3Jlc3ZfcmVnaW9uKShzdHJ1Y3QgZGV2aWNl
ICpkZXYsCgo+IAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQgPSBBTElHTihlbnRyeS0+c3Rh
cnQsIHBnX3NpemUpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW5kwqDCoCA9IEFMSUdOKGVudHJ5
LT5zdGFydCArIGVudHJ5LT5sZW5ndGgsIHBnX3NpemUpOwo+PiBAQCAtODMxLDggKzgzMiwxMCBA
QCBzdGF0aWMgaW50IAo+PiBpb21tdV9jcmVhdGVfZGV2aWNlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1
Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLAo+PiDCoCBzdGF0aWMgYm9vbCBpb21tdV9pc19hdHRhY2hf
ZGVmZXJyZWQoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4+IMKgIHsK
Pj4gLcKgwqDCoCBpZiAoZG9tYWluLT5vcHMtPmlzX2F0dGFjaF9kZWZlcnJlZCkKPj4gLcKgwqDC
oMKgwqDCoMKgIHJldHVybiBkb21haW4tPm9wcy0+aXNfYXR0YWNoX2RlZmVycmVkKGRvbWFpbiwg
ZGV2KTsKPj4gK8KgwqDCoCBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPSBkZXZfaW9tbXVf
b3BzX2dldChkZXYpOwo+PiArCj4+ICvCoMKgwqAgaWYgKG9wcy0+aXNfYXR0YWNoX2RlZmVycmVk
KQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG9wcy0+aXNfYXR0YWNoX2RlZmVycmVkKGRvbWFp
biwgZGV2KTsKPiAKPiBTaW1pbGFybHkgaWYgdGhpcyB0YWtlcyBhIGRvbWFpbiBhcyBpdHMgZmly
c3QgYXJndW1lbnQgdGhlbiBpdCdzIGRlIAo+IGZhY3RvIGEgZG9tYWluIG1ldGhvZC4gSG93ZXZl
ciwgSSdkIGNvbmN1ciB0aGF0IGxvZ2ljYWxseSBpdCAqaXMqIGEgCj4gZGV2aWNlIG9wLCBzbyBs
ZXQncyBkcm9wIHRoYXQgKHVudXNlZCkgZG9tYWluIGFyZ3VtZW50IGlmIHdlJ3JlIGNsZWFuaW5n
IAo+IHVwLgo+IAo+IE1heWJlIHRoZXJlJ3MgZXZlbiBhbiBhcmd1bWVudCBmb3IgZmFjdG9yaW5n
IHRoaXMgb3V0IHRvIGEgc3RhbmRhcmQgZmxhZyAKPiBpbiBkZXZfaW9tbXUgcmF0aGVyIHRoYW4g
YW4gb3AgYXQgYWxsPwoKTWFrZSBpdCBwYXJ0IG9mIGRldl9pb21tdSBsb29rcyBtb3JlIGF0dHJh
Y3RpdmUuIExldCBtZSBjaGVjayBob3cgbWFueQplZmZvcnRzIHdpbGwgaXQgdGFrZS4gSWYgYSBs
b3Qgb2YgY2hhbmdlcyByZXF1aXJlZCwgbWF5YmUgd2UgY2FuIHJlbW92ZQpAZG9tYWluIGluIHRo
aXMgc2VyaWVzIGFuZCB0aGVuIHN3aXRjaCBpdCB0byBhIGRldl9pb21tdSBmbGFnIGluIGEKc2Vw
YXJhdGVkIHNlcmllcy4KCj4gCj4gVGhlIG90aGVycyBjb3ZlcmVkIGhlcmUgbG9vayBPSyAtIHdl
IGNhbiBibGFtZSBQQ0kgZm9yIHBhZ2UgcmVzcG9uc2UgCj4gYmVpbmcgd2VpcmRseSBkZXZpY2Ut
Y2VudHJpYyAtIGhvd2V2ZXIgY291bGQgd2UgYWxzbyBjb252ZXJ0IGFsbCB0aGUgCj4gZmVhc2li
bGUgaW5zdGFuY2VzIG9mIGRldi0+YnVzLT5pb21tdV9vcHMgdG8gZGV2X2lvbW11X29wcygpIGFz
IHdlbGw/CgpTdXJlLgoKPiAoU3VidGx5IGltcGx5aW5nIHRoYXQgSSdtIGFsc28gbm90IGEgZmFu
IG9mIGhhdmluZyAiX2dldCIgaW4gdGhlIG5hbWUgCj4gZm9yIGEgbm9uLXJlZmNvdW50ZWQgbG9v
a3VwLi4uKSBPYnZpb3VzbHkgaW9tbXVfcHJvYmVfZGV2aWNlKCkgYW5kIAo+IGlvbW1tdV9kb21h
aW5fYWxsb2MoKSBzdGlsbCBuZWVkIGJ1cyBvcHMgYXQgdGhpcyBwb2ludCwgYnV0IEknbSB3b3Jr
aW5nIAo+IG9uIHRoYXQuLi4gOikKClRoYW5rcyBhbmQgZ2xhZCB0byBrbm93IHRoYXQuCgo+IAo+
IFRoYW5rcywKPiBSb2Jpbi4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
