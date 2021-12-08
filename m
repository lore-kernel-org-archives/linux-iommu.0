Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E8FC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FF976069E;
	Wed,  8 Dec 2021 15:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urA-dyzTYYuz; Wed,  8 Dec 2021 15:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 77FAB60657;
	Wed,  8 Dec 2021 15:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8EAC001E;
	Wed,  8 Dec 2021 15:03:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25678C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06BA240210
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AFI9zlwB6Ss2 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C827401A6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638975829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2jrd2Kf9So+x8Xz8AeO7h4+6EIMVdYK/e/smQ/H8MM=;
 b=f6Aq8dbIU1Gh0qzz5/zABRu0zkITXm0KVFJ/0RD3i4DQTNZYNpM9SgArRGcKE40xXhQFI/
 J9KxuNbY+Po0k23gfuE5FJJTPzxV47aPkFaSW+uymOgrxdQkSP8wXHryduB4sYddALsvpl
 SuwBcaKYJP0+/oHVTOwS6HoaZmWmn30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-cf0uzvLzM2eUCw3rji32Lg-1; Wed, 08 Dec 2021 10:03:45 -0500
X-MC-Unique: cf0uzvLzM2eUCw3rji32Lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6647802C99;
 Wed,  8 Dec 2021 15:03:42 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E4F019724;
 Wed,  8 Dec 2021 15:03:38 +0000 (UTC)
Message-ID: <f5b75c4d99c1f9e94ab9e639bc2fc8fddb9c7366.camel@redhat.com>
Subject: Re: [PATCH v3 21/26] KVM: SVM: Drop AVIC's intermediate
 avic_set_running() helper
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>,  Joerg Roedel <joro@8bytes.org>
Date: Wed, 08 Dec 2021 17:03:37 +0200
In-Reply-To: <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <20211208015236.1616697-22-seanjc@google.com>
 <e1c4ec6a-7c1e-b96c-63e6-d07b35820def@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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

T24gV2VkLCAyMDIxLTEyLTA4IGF0IDE1OjQzICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+
IE9uIDEyLzgvMjEgMDI6NTIsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gPiArCS8qCj4g
PiArCSAqIFVubG9hZCB0aGUgQVZJQyB3aGVuIHRoZSB2Q1BVIGlzIGFib3V0IHRvIGJsb2NrLF9i
ZWZvcmVfICB0aGUgdkNQVQo+ID4gKwkgKiBhY3R1YWxseSBibG9ja3MuICBUaGUgdkNQVSBuZWVk
cyB0byBiZSBtYXJrZWQgSXNSdW5uaW5nPTAgYmVmb3JlIHRoZQo+ID4gKwkgKiBmaW5hbCBwYXNz
IG92ZXIgdGhlIHZJUlIgdmlhIGt2bV92Y3B1X2NoZWNrX2Jsb2NrKCkuICBBbnkgSVJRcyB0aGF0
Cj4gPiArCSAqIGFycml2ZSBiZWZvcmUgSXNSdW5uaW5nPTAgd2lsbCBub3Qgc2lnbmFsIHRoZSBk
b29yYmVsbCwgaS5lLiBpdCdzCj4gPiArCSAqIEtWTSdzIHJlc3BvbnNpYmlsaXR5IHRvIGVuc3Vy
ZSB0aGVyZSBhcmUgbm8gcGVuZGluZyBJUlFzIGluIHRoZSB2SVJSCj4gPiArCSAqIGFmdGVyIElz
UnVubmluZyBpcyBjbGVhcmVkLCBwcmlvciB0byBzY2hlZHVsaW5nIG91dCB0aGUgdkNQVS4KPiAK
PiBJIHByZWZlciB0byBwaHJhc2UgdGhpcyBhcm91bmQgcGFpcmVkIG1lbW9yeSBiYXJyaWVycyBh
bmQgdGhlIHVzdWFsIAo+IHN0b3JlL3NtcF9tYi9sb2FkIGxvY2tsZXNzIGlkaW9tOgo+IAo+IAkv
Kgo+IAkgKiBVbmxvYWQgdGhlIEFWSUMgd2hlbiB0aGUgdkNQVSBpcyBhYm91dCB0byBibG9jaywg
X2JlZm9yZV8KPiAJICogdGhlIHZDUFUgYWN0dWFsbHkgYmxvY2tzLgo+IAkgKgo+IAkgKiBBbnkg
SVJRcyB0aGF0IGFycml2ZSBiZWZvcmUgSXNSdW5uaW5nPTAgd2lsbCBub3QgY2F1c2UgYW4KPiAJ
ICogaW5jb21wbGV0ZSBJUEkgdm1leGl0IG9uIHRoZSBzb3VyY2UsIHRoZXJlZm9yZSB2SVJSIHdp
bGwgYWxzbwo+IAkgKiBiZSBjaGVja2VkIGJ5IGt2bV92Y3B1X2NoZWNrX2Jsb2NrKCkgYmVmb3Jl
IGJsb2NraW5nLiAgVGhlCj4gCSAqIG1lbW9yeSBiYXJyaWVyIGltcGxpY2l0IGluIHNldF9jdXJy
ZW50X3N0YXRlIG9yZGVycyB3cml0aW5nCgpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoaXMg
aXMgYSBmdWxsIG1lbW9yeSBiYXJyaWVyIGFuZCBub3Qgb25seSBhIHdyaXRlIGJhcnJpZXI/Cgog
CkFsc28sIGp1c3QgdG8gZG9jdW1lbnQsIEkgYWxzbyBmb3VuZCBvdXQgdGhhdCBsYWNrIG9mIHN1
YnNlcXVlbnQgdklSUiBjaGVja2luZwppbiB0aGUgJ0tWTTogU1ZNOiBVbmNvbmRpdGlvbmFsbHkg
bWFyayBBVklDIGFzIHJ1bm5pbmcgb24gdkNQVSBsb2FkICh3aXRoIEFQSUN2KScKaXMgd2hhdCBt
YWRlIEFWSUMgdG90YWxseSB1bnVzYWJsZSBvbiBteSBzeXN0ZW1zLgpUaGF0IHBhdGNoIHdvdWxk
IHNldCBpc19ydW5uaW5nIHJpZ2h0IGluIHRoZSBtaWRkbGUgb2Ygc2NoZWR1bGUoKSBhbmQgdGhl
bgpubyB2SVJSIGNoZWNrIHdvdWxkIGJlIGRvbmUgYWZ0ZXJ3YXJkcy4KIApTbWFsbCB1cGRhdGUg
b24gbXkgYWR2ZW50dXJlcyB3aXRoIEFWSUM6IE9uIHR3byBNaWxhbiBtYWNoaW5lcyBJIGdvdCBt
eSBoYW5kcyBvbiwKb24gYm90aCBBVklDIGlzIGRpc2FibGVkIGluIENQVUlELCBidXQgc2VlbXMg
dG8gd29yay4gTm9uZSBvZiBteSByZXByb2R1Y2VycwptYW5hZ2UgdG8gaGl0IHRoYXQgZXJyYXRh
IGFuZCBvbiB0b3Agb2YgdGhhdCBJIGhhdmUgc2V0IG9mIHBhdGNoZXMgdGhhdCBtYWtlCkFWSUMg
Y28tZXhpc3Qgd2l0aCBuZXN0aW5nIGFuZCBpdCBhcHBlYXJzIHRvIHdvcmsgd2hpbGUgc3RyZXNz
IHRlc3RlZCB3aXRoCm15IEtWTSB1bml0IHRlc3Qgd2hpY2ggSSB1cGRhdGVkIHRvIHJ1biBhIG5l
c3RlZCBndWVzdCBvbiBvbmUgb2YgdGhlIHZDUFVzLgpJIG1vc3RseSB0ZXN0aW5nIHRoZSBzZWNv
bmQgbWFjaGluZSB0aG91Z2ggdGhpcyB3ZWVrLgogCkknbGwgcG9zdCBteSBwYXRjaGVzIGFzIHNv
b24gYXMgSSByZWJhc2UgdGhlbSBvbiB0b3Agb2YgdGhpcyBwYXRjaCBzZXJpZXMsCmFmdGVyIEkg
cmV2aWV3IGl0LgpJ4oCZbGwgcG9zdCB0aGUgdW5pdCB0ZXN0IHNvb24gdG9vLgogClN0aWxsIG15
IGd1dCBmZWVsaW5nIGlzIHRoYXQgdGhlIGVycmF0YSBpcyBzdGlsbCB0aGVyZSAtIEkgYW0gc3Rp
bGwgd2FpdGluZyBmb3IKQU1EIHRvIHByb3ZpZGUgYW55IGluZm8gdGhleSBjb3VsZCBvbiB0aGlz
LgoKCkJlc3QgcmVnYXJkcywKCU1heGltIExldml0c2t5CgoKPiAJICogSXNSdW5uaW5nPTAgYmVm
b3JlIHJlYWRpbmcgdGhlIHZJUlIuICBUaGUgcHJvY2Vzc29yIG5lZWRzIGEKPiAJICogbWF0Y2hp
bmcgbWVtb3J5IGJhcnJpZXIgb24gaW50ZXJydXB0IGRlbGl2ZXJ5IGJldHdlZW4gd3JpdGluZwo+
IAkgKiBJUlIgYW5kIHJlYWRpbmcgSXNSdW5uaW5nOyB0aGUgbGFjayBvZiB0aGlzIGJhcnJpZXIg
bWlnaHQgYmUKPiAJICogdGhlIGNhdXNlIG9mIGVycmF0YSAjMTIzNSkuCj4gCSAqLwo+IAo+IElz
IHRoZXJlIGFueSBudWFuY2UgdGhhdCBJIGFtIG1pc3Npbmc/Cj4gCj4gUGFvbG8KPiAKPiA+ICsJ
ICovCj4gPiArCWF2aWNfdmNwdV9wdXQodmNwdSk7Cj4gPiArCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
