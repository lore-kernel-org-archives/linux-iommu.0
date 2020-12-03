Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F3C63777
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 13:02:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D3322260
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 13:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D3322260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DFB962E370;
	Thu,  3 Dec 2020 13:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yQm4NOhQL8sl; Thu,  3 Dec 2020 13:02:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69DA82E36B;
	Thu,  3 Dec 2020 13:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF97C163C;
	Thu,  3 Dec 2020 13:02:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6DCBC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 13:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D2FD38791F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 13:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VH-r0QSlO-xB for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 13:02:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5F2C68757D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607000520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx3IzkdTLXifDG8SYt+10b33NncoBl8+h6tsKrPXXKI=;
 b=PCYeluZkLurdCYqp0ottD5LoIWpwdPiNkNBx4ciIg63qfJMk/R0Eq+2DtzMF7ezYAZyNuU
 bBe6CNFMcmLPr2STzmJN3xVVxibMLYHOSgZvyHgF1ySvz4d8R8FcYSZnvXcRLuUtl3c0hO
 l8qhyxWrm6Uo8qI+OIp9XYFrqRNNmSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-55srNphXMgaa_GE-OCNWuA-1; Thu, 03 Dec 2020 08:01:55 -0500
X-MC-Unique: 55srNphXMgaa_GE-OCNWuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AABD107464A;
 Thu,  3 Dec 2020 13:01:52 +0000 (UTC)
Received: from [10.36.112.89] (ovpn-112-89.ams2.redhat.com [10.36.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1EE60C17;
 Thu,  3 Dec 2020 13:01:43 +0000 (UTC)
Subject: Re: [PATCH v13 05/15] iommu/smmuv3: Get prepared for nested stage
 support
To: Kunkun Jiang <jiangkunkun@huawei.com>, eric.auger.pro@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 joro@8bytes.org, maz@kernel.org, robin.murphy@arm.com,
 alex.williamson@redhat.com
References: <20201118112151.25412-1-eric.auger@redhat.com>
 <20201118112151.25412-6-eric.auger@redhat.com>
 <a40b90bd-6756-c8cc-b455-c093d16d35f5@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <096c2c79-84b2-75d4-094f-bdd8b0a2d125@redhat.com>
Date: Thu, 3 Dec 2020 14:01:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a40b90bd-6756-c8cc-b455-c093d16d35f5@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: jean-philippe@linaro.org, vivek.gautam@arm.com, wanghaibin.wang@huawei.com,
 zhangfei.gao@linaro.org, Keqian Zhu <zhukeqian1@huawei.com>
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

SGkgS3Vua3VuLAoKT24gMTIvMy8yMCAxOjMyIFBNLCBLdW5rdW4gSmlhbmcgd3JvdGU6Cj4gSGkg
RXJpYywKPiAKPiBPbiAyMDIwLzExLzE4IDE5OjIxLCBFcmljIEF1Z2VyIHdyb3RlOgo+PiBXaGVu
IG5lc3RlZCBzdGFnZSB0cmFuc2xhdGlvbiBpcyBzZXR1cCwgYm90aCBzMV9jZmcgYW5kCj4+IHMy
X2NmZyBhcmUgc2V0Lgo+Pgo+PiBXZSBpbnRyb2R1Y2UgYSBuZXcgc21tdSBkb21haW4gYWJvcnQg
ZmllbGQgdGhhdCB3aWxsIGJlIHNldAo+PiB1cG9uIGd1ZXN0IHN0YWdlMSBjb25maWd1cmF0aW9u
IHBhc3NpbmcuCj4+Cj4+IGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoKSBpcyBtb2RpZmllZCB0
byB3cml0ZSBib3RoIHN0YWdlCj4+IGZpZWxkcyBpbiB0aGUgU1RFIGFuZCBkZWFsIHdpdGggdGhl
IGFib3J0IGZpZWxkLgo+Pgo+PiBJbiBuZXN0ZWQgbW9kZSwgb25seSBzdGFnZSAyIGlzICJmaW5h
bGl6ZWQiIGFzIHRoZSBob3N0IGRvZXMKPj4gbm90IG93bi9jb25maWd1cmUgdGhlIHN0YWdlIDEg
Y29udGV4dCBkZXNjcmlwdG9yOyBndWVzdCBkb2VzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Cj4+Cj4+IC0tLQo+PiB2MTAgLT4gdjExOgo+
PiAtIEZpeCBhbiBpc3N1ZSByZXBvcnRlZCBieSBTaGFtZWVyIHdoZW4gc3dpdGNoaW5nIGZyb20g
d2l0aCB2U01NVQo+PiAgIHRvIHdpdGhvdXQgdlNNTVUuIERlc3BpdGUgdGhlIHNwZWMgZG9lcyBu
b3Qgc2VlbSB0byBtZW50aW9uIGl0Cj4+ICAgc2VlbXMgdG8gYmUgbmVlZGVkIHRvIHJlc2V0IHRo
ZSAyIGhpZ2ggNjRiIHdoZW4gc3dpdGNoaW5nIGZyb20KPj4gICBTMStTMiBjZmcgdG8gUzEgb25s
eS4gRXNwZWNpYWxseSBkc3RbM10gbmVlZHMgdG8gYmUgcmVzZXQgKFMyVFRCKS4KPj4gICBPbiBz
b21lIGltcGxlbWVudGF0aW9ucywgaWYgdGhlIFMyVFRCIGlzIG5vdCByZXNldCwgdGhpcyBjYXVz
ZXMKPj4gICBhIENfQkFEX1NURSBlcnJvcgo+PiAtLS0KPj4gIGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCA2NCArKysrKysrKysrKysrKysrKy0tLS0KPj4gIGRy
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggfCAgMiArCj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gaW5kZXggMThhYzVh
ZjFiMjg0Li40MTJlYTFiYWZhNTAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBAQCAtMTE4MSw4ICsxMTgxLDEwIEBAIHN0YXRpYyB2b2lk
IGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVy
LCB1MzIgc2lkLAo+PiAgCSAqIHRocmVlIGNhc2VzIGF0IHRoZSBtb21lbnQ6Cj4gTm93LCBpdCBz
aG91bGQgYmUgKmZpdmUgY2FzZXMqLgo+PiAgCSAqCj4+ICAJICogMS4gSW52YWxpZCAoYWxsIHpl
cm8pIC0+IGJ5cGFzcy9mYXVsdCAoaW5pdCkKPj4gLQkgKiAyLiBCeXBhc3MvZmF1bHQgLT4gdHJh
bnNsYXRpb24vYnlwYXNzIChhdHRhY2gpCj4+IC0JICogMy4gVHJhbnNsYXRpb24vYnlwYXNzIC0+
IGJ5cGFzcy9mYXVsdCAoZGV0YWNoKQo+PiArCSAqIDIuIEJ5cGFzcy9mYXVsdCAtPiBzaW5nbGUg
c3RhZ2UgdHJhbnNsYXRpb24vYnlwYXNzIChhdHRhY2gpCj4+ICsJICogMy4gU2luZ2xlIG9yIG5l
c3RlZCBzdGFnZSBUcmFuc2xhdGlvbi9ieXBhc3MgLT4gYnlwYXNzL2ZhdWx0IChkZXRhY2gpCj4+
ICsJICogNC4gUzIgLT4gUzEgKyBTMiAoYXR0YWNoX3Bhc2lkX3RhYmxlKQo+IAo+IEkgd2FzIHRl
c3RpbmcgdGhpcyBzZXJpZXMgb24gb25lIG9mIG91ciBoYXJkd2FyZSBib2FyZCB3aXRoIFNNTVV2
My4gQW5kCj4gSSBmb3VuZCB3aGlsZSB0cnlpbmcgdG8gLyIvL2F0dGFjaF9wYXNpZF90YWJsZS8v
Ii8sCj4gCj4gdGhlIHNlcXVlbmNlIG9mIFNURSAoaG9zdCkgY29uZmlnKGJpdFszOjFdKSBpcyAv
IlMyLT5hYm9ydC0+UzEgKyBTMiIvLgo+IEJlY2F1c2UgdGhlIG1haW50ZW5hbmNlIGlzwqAgLyJX
cml0ZSBldmVyeXRoaW5nIGFwYXJ0Ly8vCj4gCj4gL2Zyb20gZHdvcmQgMCwgc3luYywgd3JpdGUg
ZHdvcmQgMCwgc3luYyIvIHdoZW4gd2UgdXBkYXRlIHRoZSBTVEUKPiAoZ3Vlc3QpLiBEb3NlIHRo
ZSBzZXF1ZW5jZSBtZWV0IHlvdXIgZXhwZWN0YXRpb24/Cgp5ZXMgaXQgZG9lcy4gSSB3aWxsIGZp
eCB0aGUgY29tbWVudHMgYWNjb3JkaW5nbHkuCgpJcyB0aGVyZSBhbnl0aGluZyB0byBjb3JyZWN0
IGluIHRoZSBjb2RlIG9yIHdhcyBpdCBmdW5jdGlvbmFsPwoKVGhhbmtzCgpFcmljCj4gCj4+ICsJ
ICogNS4gUzEgKyBTMiAtPiBTMiAoZGV0YWNoX3Bhc2lkX3RhYmxlKQo+PiAgCSAqCj4+ICAJICog
R2l2ZW4gdGhhdCB3ZSBjYW4ndCB1cGRhdGUgdGhlIFNURSBhdG9taWNhbGx5IGFuZCB0aGUgU01N
VQo+PiAgCSAqIGRvZXNuJ3QgcmVhZCB0aGUgdGhpbmcgaW4gYSBkZWZpbmVkIG9yZGVyLCB0aGF0
IGxlYXZlcyB1cwo+PiBAQCAtMTE5Myw3ICsxMTk1LDggQEAgc3RhdGljIHZvaWQgYXJtX3NtbXVf
d3JpdGVfc3RydGFiX2VudChzdHJ1Y3QgYXJtX3NtbXVfbWFzdGVyICptYXN0ZXIsIHUzMiBzaWQs
Cj4+ICAJICogMy4gVXBkYXRlIENvbmZpZywgc3luYwo+PiAgCSAqLwo+PiAgCXU2NCB2YWwgPSBs
ZTY0X3RvX2NwdShkc3RbMF0pOwo+PiAtCWJvb2wgc3RlX2xpdmUgPSBmYWxzZTsKPj4gKwlib29s
IHMxX2xpdmUgPSBmYWxzZSwgczJfbGl2ZSA9IGZhbHNlLCBzdGVfbGl2ZTsKPj4gKwlib29sIGFi
b3J0LCBuZXN0ZWQgPSBmYWxzZSwgdHJhbnNsYXRlID0gZmFsc2U7Cj4+ICAJc3RydWN0IGFybV9z
bW11X2RldmljZSAqc21tdSA9IE5VTEw7Cj4+ICAJc3RydWN0IGFybV9zbW11X3MxX2NmZyAqczFf
Y2ZnOwo+PiAgCXN0cnVjdCBhcm1fc21tdV9zMl9jZmcgKnMyX2NmZzsKPj4gQEAgLTEyMzMsNiAr
MTIzNiw4IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoc3RydWN0IGFy
bV9zbW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAo+PiAgCQlkZWZhdWx0Ogo+PiAgCQkJYnJl
YWs7Cj4+ICAJCX0KPj4gKwkJbmVzdGVkID0gczFfY2ZnLT5zZXQgJiYgczJfY2ZnLT5zZXQ7Cj4+
ICsJCXRyYW5zbGF0ZSA9IHMxX2NmZy0+c2V0IHx8IHMyX2NmZy0+c2V0Owo+PiAgCX0KPj4gIAo+
PiAgCWlmICh2YWwgJiBTVFJUQUJfU1RFXzBfVikgewo+PiBAQCAtMTI0MCwyMyArMTI0NSwzNiBA
QCBzdGF0aWMgdm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0cnVjdCBhcm1fc21tdV9t
YXN0ZXIgKm1hc3RlciwgdTMyIHNpZCwKPj4gIAkJY2FzZSBTVFJUQUJfU1RFXzBfQ0ZHX0JZUEFT
UzoKPj4gIAkJCWJyZWFrOwo+PiAgCQljYXNlIFNUUlRBQl9TVEVfMF9DRkdfUzFfVFJBTlM6Cj4+
ICsJCQlzMV9saXZlID0gdHJ1ZTsKPj4gKwkJCWJyZWFrOwo+PiAgCQljYXNlIFNUUlRBQl9TVEVf
MF9DRkdfUzJfVFJBTlM6Cj4+IC0JCQlzdGVfbGl2ZSA9IHRydWU7Cj4+ICsJCQlzMl9saXZlID0g
dHJ1ZTsKPj4gKwkJCWJyZWFrOwo+PiArCQljYXNlIFNUUlRBQl9TVEVfMF9DRkdfTkVTVEVEOgo+
PiArCQkJczFfbGl2ZSA9IHRydWU7Cj4+ICsJCQlzMl9saXZlID0gdHJ1ZTsKPj4gIAkJCWJyZWFr
Owo+PiAgCQljYXNlIFNUUlRBQl9TVEVfMF9DRkdfQUJPUlQ6Cj4+IC0JCQlCVUdfT04oIWRpc2Fi
bGVfYnlwYXNzKTsKPj4gIAkJCWJyZWFrOwo+PiAgCQlkZWZhdWx0Ogo+PiAgCQkJQlVHKCk7IC8q
IFNURSBjb3JydXB0aW9uICovCj4+ICAJCX0KPj4gIAl9Cj4+ICAKPj4gKwlzdGVfbGl2ZSA9IHMx
X2xpdmUgfHwgczJfbGl2ZTsKPj4gKwo+PiAgCS8qIE51a2UgdGhlIGV4aXN0aW5nIFNURV8wIHZh
bHVlLCBhcyB3ZSdyZSBnb2luZyB0byByZXdyaXRlIGl0ICovCj4+ICAJdmFsID0gU1RSVEFCX1NU
RV8wX1Y7Cj4+ICAKPj4gIAkvKiBCeXBhc3MvZmF1bHQgKi8KPj4gLQlpZiAoIXNtbXVfZG9tYWlu
IHx8ICEoczFfY2ZnLT5zZXQgfHwgczJfY2ZnLT5zZXQpKSB7Cj4+IC0JCWlmICghc21tdV9kb21h
aW4gJiYgZGlzYWJsZV9ieXBhc3MpCj4+ICsKPj4gKwlpZiAoIXNtbXVfZG9tYWluKQo+PiArCQlh
Ym9ydCA9IGRpc2FibGVfYnlwYXNzOwo+PiArCWVsc2UKPj4gKwkJYWJvcnQgPSBzbW11X2RvbWFp
bi0+YWJvcnQ7Cj4+ICsKPj4gKwlpZiAoYWJvcnQgfHwgIXRyYW5zbGF0ZSkgewo+PiArCQlpZiAo
YWJvcnQpCj4+ICAJCQl2YWwgfD0gRklFTERfUFJFUChTVFJUQUJfU1RFXzBfQ0ZHLCBTVFJUQUJf
U1RFXzBfQ0ZHX0FCT1JUKTsKPj4gIAkJZWxzZQo+PiAgCQkJdmFsIHw9IEZJRUxEX1BSRVAoU1RS
VEFCX1NURV8wX0NGRywgU1RSVEFCX1NURV8wX0NGR19CWVBBU1MpOwo+PiBAQCAtMTI3NCw4ICsx
MjkyLDE2IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoc3RydWN0IGFy
bV9zbW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAo+PiAgCQlyZXR1cm47Cj4+ICAJfQo+PiAg
Cj4+ICsJQlVHX09OKHN0ZV9saXZlICYmICFuZXN0ZWQpOwo+PiArCj4+ICsJaWYgKHN0ZV9saXZl
KSB7Cj4+ICsJCS8qIEZpcnN0IGludmFsaWRhdGUgdGhlIGxpdmUgU1RFICovCj4+ICsJCWRzdFsw
XSA9IGNwdV90b19sZTY0KFNUUlRBQl9TVEVfMF9DRkdfQUJPUlQpOwo+PiArCQlhcm1fc21tdV9z
eW5jX3N0ZV9mb3Jfc2lkKHNtbXUsIHNpZCk7Cj4+ICsJfQo+PiArCj4+ICAJaWYgKHMxX2NmZy0+
c2V0KSB7Cj4+IC0JCUJVR19PTihzdGVfbGl2ZSk7Cj4+ICsJCUJVR19PTihzMV9saXZlKTsKPj4g
IAkJZHN0WzFdID0gY3B1X3RvX2xlNjQoCj4+ICAJCQkgRklFTERfUFJFUChTVFJUQUJfU1RFXzFf
UzFEU1MsIFNUUlRBQl9TVEVfMV9TMURTU19TU0lEMCkgfAo+PiAgCQkJIEZJRUxEX1BSRVAoU1RS
VEFCX1NURV8xX1MxQ0lSLCBTVFJUQUJfU1RFXzFfUzFDX0NBQ0hFX1dCUkEpIHwKPj4gQEAgLTEy
OTQsNyArMTMyMCwxNCBAQCBzdGF0aWMgdm9pZCBhcm1fc21tdV93cml0ZV9zdHJ0YWJfZW50KHN0
cnVjdCBhcm1fc21tdV9tYXN0ZXIgKm1hc3RlciwgdTMyIHNpZCwKPj4gIAl9Cj4+ICAKPj4gIAlp
ZiAoczJfY2ZnLT5zZXQpIHsKPj4gLQkJQlVHX09OKHN0ZV9saXZlKTsKPj4gKwkJdTY0IHZ0dGJy
ID0gczJfY2ZnLT52dHRiciAmIFNUUlRBQl9TVEVfM19TMlRUQl9NQVNLOwo+PiArCj4+ICsJCWlm
IChzMl9saXZlKSB7Cj4+ICsJCQl1NjQgczJ0dGIgPSBsZTY0X3RvX2NwdShkc3RbM10gJiBTVFJU
QUJfU1RFXzNfUzJUVEJfTUFTSyk7Cj4+ICsKPj4gKwkJCUJVR19PTihzMnR0YiAhPSB2dHRicik7
Cj4+ICsJCX0KPj4gKwo+PiAgCQlkc3RbMl0gPSBjcHVfdG9fbGU2NCgKPj4gIAkJCSBGSUVMRF9Q
UkVQKFNUUlRBQl9TVEVfMl9TMlZNSUQsIHMyX2NmZy0+dm1pZCkgfAo+PiAgCQkJIEZJRUxEX1BS
RVAoU1RSVEFCX1NURV8yX1ZUQ1IsIHMyX2NmZy0+dnRjcikgfAo+PiBAQCAtMTMwNCw5ICsxMzM3
LDEyIEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0cnRhYl9lbnQoc3RydWN0IGFybV9z
bW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAo+PiAgCQkJIFNUUlRBQl9TVEVfMl9TMlBUVyB8
IFNUUlRBQl9TVEVfMl9TMkFBNjQgfAo+PiAgCQkJIFNUUlRBQl9TVEVfMl9TMlIpOwo+PiAgCj4+
IC0JCWRzdFszXSA9IGNwdV90b19sZTY0KHMyX2NmZy0+dnR0YnIgJiBTVFJUQUJfU1RFXzNfUzJU
VEJfTUFTSyk7Cj4+ICsJCWRzdFszXSA9IGNwdV90b19sZTY0KHZ0dGJyKTsKPj4gIAo+PiAgCQl2
YWwgfD0gRklFTERfUFJFUChTVFJUQUJfU1RFXzBfQ0ZHLCBTVFJUQUJfU1RFXzBfQ0ZHX1MyX1RS
QU5TKTsKPj4gKwl9IGVsc2Ugewo+PiArCQlkc3RbMl0gPSAwOwo+PiArCQlkc3RbM10gPSAwOwo+
PiAgCX0KPj4gIAo+PiAgCWlmIChtYXN0ZXItPmF0c19lbmFibGVkKQo+PiBAQCAtMTk4Miw2ICsy
MDE4LDE0IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVfZG9tYWluX2ZpbmFsaXNlKHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbiwKPj4gIAkJcmV0dXJuIDA7Cj4+ICAJfQo+PiAgCj4+ICsJaWYgKHNt
bXVfZG9tYWluLT5zdGFnZSA9PSBBUk1fU01NVV9ET01BSU5fTkVTVEVEICYmCj4+ICsJICAgICgh
KHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9UUkFOU19TMSkgfHwKPj4gKwkgICAgICEo
c21tdS0+ZmVhdHVyZXMgJiBBUk1fU01NVV9GRUFUX1RSQU5TX1MyKSkpIHsKPj4gKwkJZGV2X2lu
Zm8oc21tdV9kb21haW4tPnNtbXUtPmRldiwKPj4gKwkJCSAiZG9lcyBub3QgaW1wbGVtZW50IHR3
byBzdGFnZXNcbiIpOwo+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4gKwl9Cj4+ICsKPj4gIAkvKiBS
ZXN0cmljdCB0aGUgc3RhZ2UgdG8gd2hhdCB3ZSBjYW4gYWN0dWFsbHkgc3VwcG9ydCAqLwo+PiAg
CWlmICghKHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9UUkFOU19TMSkpCj4+ICAJCXNt
bXVfZG9tYWluLT5zdGFnZSA9IEFSTV9TTU1VX0RPTUFJTl9TMjsKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggYi9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oCj4+IGluZGV4IDA3ZjU5MjUyZGQyMS4uMjY5
Nzc5ZGVlOGQxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5oCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmgKPj4gQEAgLTIwNiw2ICsyMDYsNyBAQAo+PiAgI2RlZmluZSBTVFJUQUJfU1RFXzBf
Q0ZHX0JZUEFTUwkJNAo+PiAgI2RlZmluZSBTVFJUQUJfU1RFXzBfQ0ZHX1MxX1RSQU5TCTUKPj4g
ICNkZWZpbmUgU1RSVEFCX1NURV8wX0NGR19TMl9UUkFOUwk2Cj4+ICsjZGVmaW5lIFNUUlRBQl9T
VEVfMF9DRkdfTkVTVEVECQk3Cj4+ICAKPj4gICNkZWZpbmUgU1RSVEFCX1NURV8wX1MxRk1UCQlH
RU5NQVNLX1VMTCg1LCA0KQo+PiAgI2RlZmluZSBTVFJUQUJfU1RFXzBfUzFGTVRfTElORUFSCTAK
Pj4gQEAgLTY4Miw2ICs2ODMsNyBAQCBzdHJ1Y3QgYXJtX3NtbXVfZG9tYWluIHsKPj4gIAllbnVt
IGFybV9zbW11X2RvbWFpbl9zdGFnZQlzdGFnZTsKPj4gIAlzdHJ1Y3QgYXJtX3NtbXVfczFfY2Zn
CXMxX2NmZzsKPj4gIAlzdHJ1Y3QgYXJtX3NtbXVfczJfY2ZnCXMyX2NmZzsKPj4gKwlib29sCQkJ
CWFib3J0Owo+PiAgCj4+ICAJc3RydWN0IGlvbW11X2RvbWFpbgkJZG9tYWluOwo+IAo+IFRoYW5r
cywKPiAKPiBLdW5rdW4gSmlhbmcKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
