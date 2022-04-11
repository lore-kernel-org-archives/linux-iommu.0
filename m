Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE43C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 17:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7857B60E43;
	Mon, 11 Apr 2022 17:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xx5hBN2GQYSf; Mon, 11 Apr 2022 17:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5873460D4F;
	Mon, 11 Apr 2022 17:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32AE3C0033;
	Mon, 11 Apr 2022 17:34:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4BA7C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 17:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3DA782423
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 17:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUBBqxr5u_EB for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 17:34:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07DB682416
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 17:34:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423411570
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 10:34:39 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0BE543F73B
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 10:34:38 -0700 (PDT)
Date: Mon, 11 Apr 2022 18:34:34 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Brian Starkey <brian.starkey@arm.com>
Subject: Re: [PATCH] drm/arm/malidp: Stop using iommu_present()
Message-ID: <YlRmqhX7WKv8XQgC@e110455-lin.cambridge.arm.com>
References: <5049994e6c2ba92c2f30d51850c8929136d0f8ca.1649167878.git.robin.murphy@arm.com>
 <20220406092700.t7o7ujk4eqn7ckgr@000377403353>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406092700.t7o7ujk4eqn7ckgr@000377403353>
Cc: iommu@lists.linux-foundation.org, nd@arm.com,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org
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

T24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMTA6Mjc6MDBBTSArMDEwMCwgQnJpYW4gU3RhcmtleSB3
cm90ZToKPiBIaSBSb2JpbiwKPiAKPiBPbiBUdWUsIEFwciAwNSwgMjAyMiBhdCAwMzoxMToxOFBN
ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gPiBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYo
KSBpcyBhbHJlYWR5IHBlcmZlY3RseSBoYXBweSB0byByZXR1cm4gTlVMTAo+ID4gaWYgdGhlIGdp
dmVuIGRldmljZSBoYXMgbm8gSU9NTVUuIERyb3AgdGhlIHVubmVjZXNzYXJ5IGNoZWNrLgo+ID4g
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+
IAo+IExHVE0sIEFja2VkLWJ5OiBCcmlhbiBTdGFya2V5IDxicmlhbi5zdGFya2V5QGFybS5jb20+
Cj4gCj4gSSdsbCBoYXZlIHRvIGxlYXZlIGl0IHRvIExpdml1IHRvIHB1c2ggdGhvdWdoLgoKSSBo
YXZlIG5vdyBwdXNoZWQgdGhlIHBhdGNoIHRvZ2V0aGVyIHdpdGggb3RoZXIgMyB0aGF0IGhhdmUg
YmVlbiBsaW5nZXJpbmcgaW4gbXkgdHJlZS4KCkJlc3QgcmVnYXJkcywKTGl2aXUKCj4gCj4gVGhh
bmtzLAo+IC1Ccmlhbgo+IAo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBf
cGxhbmVzLmMgfCAxNCArKysrKy0tLS0tLS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYXJtL21hbGlkcF9wbGFuZXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX3Bs
YW5lcy5jCj4gPiBpbmRleCAwNTYyYmRhYWMwMGMuLjgxZDlmNTAwNDAyNSAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vbWFsaWRwX3BsYW5lcy5jCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYXJtL21hbGlkcF9wbGFuZXMuYwo+ID4gQEAgLTMxMCwxNyArMzEwLDEzIEBAIHN0
YXRpYyBpbnQgbWFsaWRwX3NlX2NoZWNrX3NjYWxpbmcoc3RydWN0IG1hbGlkcF9wbGFuZSAqbXAs
Cj4gPiAgCj4gPiAgc3RhdGljIHUzMiBtYWxpZHBfZ2V0X3Bnc2l6ZV9iaXRtYXAoc3RydWN0IG1h
bGlkcF9wbGFuZSAqbXApCj4gPiAgewo+ID4gLQl1MzIgcGdzaXplX2JpdG1hcCA9IDA7Cj4gPiAr
CXN0cnVjdCBpb21tdV9kb21haW4gKm1tdV9kb207Cj4gPiAgCj4gPiAtCWlmIChpb21tdV9wcmVz
ZW50KCZwbGF0Zm9ybV9idXNfdHlwZSkpIHsKPiA+IC0JCXN0cnVjdCBpb21tdV9kb21haW4gKm1t
dV9kb20gPQo+ID4gLQkJCWlvbW11X2dldF9kb21haW5fZm9yX2RldihtcC0+YmFzZS5kZXYtPmRl
dik7Cj4gPiArCW1tdV9kb20gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYobXAtPmJhc2UuZGV2
LT5kZXYpOwo+ID4gKwlpZiAobW11X2RvbSkKPiA+ICsJCXJldHVybiBtbXVfZG9tLT5wZ3NpemVf
Yml0bWFwOwo+ID4gIAo+ID4gLQkJaWYgKG1tdV9kb20pCj4gPiAtCQkJcGdzaXplX2JpdG1hcCA9
IG1tdV9kb20tPnBnc2l6ZV9iaXRtYXA7Cj4gPiAtCX0KPiA+IC0KPiA+IC0JcmV0dXJuIHBnc2l6
ZV9iaXRtYXA7Cj4gPiArCXJldHVybiAwOwo+ID4gIH0KPiA+ICAKPiA+ICAvKgo+ID4gLS0gCj4g
PiAyLjI4LjAuZGlydHkKPiA+IAoKLS0gCj09PT09PT09PT09PT09PT09PT09CnwgSSB3b3VsZCBs
aWtlIHRvIHwKfCBmaXggdGhlIHdvcmxkLCAgfAp8IGJ1dCB0aGV5J3JlIG5vdCB8CnwgZ2l2aW5n
IG1lIHRoZSAgIHwKIFwgc291cmNlIGNvZGUhICAvCiAgLS0tLS0tLS0tLS0tLS0tCiAgICDCr1xf
KOODhClfL8KvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
