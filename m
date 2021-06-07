Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560D3C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 13:02:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 121E06108D
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 13:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121E06108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5D7282896;
	Mon,  7 Jun 2021 13:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhWdISHj6XHJ; Mon,  7 Jun 2021 13:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F9DF827A8;
	Mon,  7 Jun 2021 13:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26F48C000D;
	Mon,  7 Jun 2021 13:02:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9F2FC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99F2B82896
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gmk2oyi0TKWG for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 13:01:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CAC3827A8
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 13:01:58 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 29FF1391; Mon,  7 Jun 2021 15:01:55 +0200 (CEST)
Date: Mon, 7 Jun 2021 15:01:54 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/dma: Fix compile warning in 32-bit builds
Message-ID: <YL4Ywt5FcELNkx0t@8bytes.org>
References: <20210607124905.27525-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607124905.27525-1-joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <poza@codeaurora.org>
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

T24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMDI6NDk6MDVQTSArMDIwMCwgSm9lcmcgUm9lZGVsIHdy
b3RlOgo+IEZyb206IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgo+IAo+IENvbXBpbGlu
ZyB0aGUgcmVjZW50IGRtYS1pb21tdSBjaGFuZ2VzIHVuZGVyIDMyLWJpdCB4ODYgdHJpZ2dlcnMg
dGhpcwo+IGNvbXBpbGUgd2FybmluZzoKPiAKPiBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jOjI0
OTo1OiB3YXJuaW5nOiBmb3JtYXQg4oCYJWxseOKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg
4oCYbG9uZyBsb25nIHVuc2lnbmVkIGludOKAmSwgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUg4oCY
cGh5c19hZGRyX3TigJkge2FrYSDigJh1bnNpZ25lZCBpbnTigJl9IFstV2Zvcm1hdD1dCj4gCj4g
VGhlIHJlYXNvbiBpcyB0aGF0ICVsbHggaXMgdXNlZCB0byBwcmludCBhIHZhcmlhYmxlIG9mIHR5
cGUKPiBwaHlzX2FkZHJfdC4gRml4IGl0IGJ5IHVzaW5nIHRoZSBjb3JyZWN0ICVwYSBmb3JtYXQg
c3BlY2lmaWVyIGZvcgo+IHBoeXNfYWRkcl90Lgo+IAo+IENjOiBTcmluYXRoIE1hbm5hbSA8c3Jp
bmF0aC5tYW5uYW1AYnJvYWRjb20uY29tPgo+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPgo+IENjOiBPemEgUGF3YW5kZWVwIDxwb3phQGNvZGVhdXJvcmEub3JnPgo+IEZp
eGVzOiBhYWRhZDA5N2NkNDYgKCJpb21tdS9kbWE6IFJlc2VydmUgSU9WQSBmb3IgUENJZSBpbmFj
Y2Vzc2libGUgRE1BIGFkZHJlc3MiKQoKVGhpcyB0YWcgaXMgd3JvbmcsIGl0IHNob3VsZCBiZToK
CkZpeGVzOiA5NTYxZGQ0MzQ4NjAgKCJpb21tdS9kbWE6IEZpeCBJT1ZBIHJlc2VydmUgZG1hIHJh
bmdlcyIpCgo+IFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgo+
IC0tLQo+ICBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4gaW5k
ZXggOTVlNzM0OWFjM2YxLi41ZDk2ZmNjNDVmZWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21t
dS9kbWEtaW9tbXUuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPiBAQCAtMjQ2
LDggKzI0Niw4IEBAIHN0YXRpYyBpbnQgaW92YV9yZXNlcnZlX3BjaV93aW5kb3dzKHN0cnVjdCBw
Y2lfZGV2ICpkZXYsCj4gIAkJfSBlbHNlIGlmIChlbmQgPCBzdGFydCkgewo+ICAJCQkvKiBkbWFf
cmFuZ2VzIGxpc3Qgc2hvdWxkIGJlIHNvcnRlZCAqLwo+ICAJCQlkZXZfZXJyKCZkZXYtPmRldiwK
PiAtCQkJCSJGYWlsZWQgdG8gcmVzZXJ2ZSBJT1ZBIFslIzAxMGxseC0lIzAxMGxseF1cbiIsCj4g
LQkJCQlzdGFydCwgZW5kKTsKPiArCQkJCSJGYWlsZWQgdG8gcmVzZXJ2ZSBJT1ZBIFslcGEtJXBh
XVxuIiwKPiArCQkJCSZzdGFydCwgJmVuZCk7Cj4gIAkJCXJldHVybiAtRUlOVkFMOwo+ICAJCX0K
PiAgCj4gLS0gCj4gMi4zMS4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
