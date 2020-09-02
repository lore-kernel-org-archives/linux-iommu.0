Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574CC433E2
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 08:02:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388FB2084C
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uCptm6F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388FB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EE6EC204E6;
	Wed,  2 Sep 2020 08:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJH3hJgzsmFy; Wed,  2 Sep 2020 08:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 09BCA275A6;
	Wed,  2 Sep 2020 08:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF435C0052;
	Wed,  2 Sep 2020 08:01:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3143CC0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1DFDD867F9
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPv8ViehfREB for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 08:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B332D867FD
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 08:01:09 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08280pA7094762;
 Wed, 2 Sep 2020 03:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1599033651;
 bh=1bOhg2Pozz6rcMj1+uMvlXBX35wWMkgjDScBHdgjrGA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=uCptm6F4IhHx1+0CT2rnCmC7OxX+/Xm05UrEQJBqEw8tEOO0a9Z3QZHXHM/N4/wdh
 GWSpcQdbbxmEnnfKvTmTB2/ylM3AvQKsmTc4oMmLfpmi0juS7j1s8G8y8OO3bwH+FJ
 nOoQOPwT33Ba4fTsS1SdhZFBfOpEFTOu/BScnvwo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08280p0X077629
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 2 Sep 2020 03:00:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 03:00:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 03:00:51 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08280mFG008004;
 Wed, 2 Sep 2020 03:00:48 -0500
Subject: Re: [PATCH v9 14/32] drm: omapdrm: fix common struct sg_table related
 issues
To: Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>,
 <dri-devel@lists.freedesktop.org>, <iommu@lists.linux-foundation.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2@eucas1p2.samsung.com>
 <20200826063316.23486-15-m.szyprowski@samsung.com>
 <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
Message-ID: <e3f8d1d2-9c33-78be-56e6-ad214c7fb84c@ti.com>
Date: Wed, 2 Sep 2020 11:00:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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
From: Tomi Valkeinen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMDEvMDkvMjAyMCAyMjozMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDgtMjYg
MDc6MzIsIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6Cj4+IFRoZSBEb2N1bWVudGF0aW9uL0RNQS1B
UEktSE9XVE8udHh0IHN0YXRlcyB0aGF0IHRoZSBkbWFfbWFwX3NnKCkgZnVuY3Rpb24KPj4gcmV0
dXJucyB0aGUgbnVtYmVyIG9mIHRoZSBjcmVhdGVkIGVudHJpZXMgaW4gdGhlIERNQSBhZGRyZXNz
IHNwYWNlLgo+PiBIb3dldmVyIHRoZSBzdWJzZXF1ZW50IGNhbGxzIHRvIHRoZSBkbWFfc3luY19z
Z19mb3Jfe2RldmljZSxjcHV9KCkgYW5kCj4+IGRtYV91bm1hcF9zZyBtdXN0IGJlIGNhbGxlZCB3
aXRoIHRoZSBvcmlnaW5hbCBudW1iZXIgb2YgdGhlIGVudHJpZXMKPj4gcGFzc2VkIHRvIHRoZSBk
bWFfbWFwX3NnKCkuCj4+Cj4+IHN0cnVjdCBzZ190YWJsZSBpcyBhIGNvbW1vbiBzdHJ1Y3R1cmUg
dXNlZCBmb3IgZGVzY3JpYmluZyBhIG5vbi1jb250aWd1b3VzCj4+IG1lbW9yeSBidWZmZXIsIHVz
ZWQgY29tbW9ubHkgaW4gdGhlIERSTSBhbmQgZ3JhcGhpY3Mgc3Vic3lzdGVtcy4gSXQKPj4gY29u
c2lzdHMgb2YgYSBzY2F0dGVybGlzdCB3aXRoIG1lbW9yeSBwYWdlcyBhbmQgRE1BIGFkZHJlc3Nl
cyAoc2dsIGVudHJ5KSwKPj4gYXMgd2VsbCBhcyB0aGUgbnVtYmVyIG9mIHNjYXR0ZXJsaXN0IGVu
dHJpZXM6IENQVSBwYWdlcyAob3JpZ19uZW50cyBlbnRyeSkKPj4gYW5kIERNQSBtYXBwZWQgcGFn
ZXMgKG5lbnRzIGVudHJ5KS4KPj4KPj4gSXQgdHVybmVkIG91dCB0aGF0IGl0IHdhcyBhIGNvbW1v
biBtaXN0YWtlIHRvIG1pc3VzZSBuZW50cyBhbmQgb3JpZ19uZW50cwo+PiBlbnRyaWVzLCBjYWxs
aW5nIERNQS1tYXBwaW5nIGZ1bmN0aW9ucyB3aXRoIGEgd3JvbmcgbnVtYmVyIG9mIGVudHJpZXMg
b3IKPj4gaWdub3JpbmcgdGhlIG51bWJlciBvZiBtYXBwZWQgZW50cmllcyByZXR1cm5lZCBieSB0
aGUgZG1hX21hcF9zZygpCj4+IGZ1bmN0aW9uLgo+Pgo+PiBGaXggdGhlIGNvZGUgdG8gcmVmZXIg
dG8gcHJvcGVyIG5lbnRzIG9yIG9yaWdfbmVudHMgZW50cmllcy4gVGhpcyBkcml2ZXIKPj4gY2hl
Y2tzIGZvciBhIGJ1ZmZlciBjb250aWd1aXR5IGluIERNQSBhZGRyZXNzIHNwYWNlLCBzbyBpdCBz
aG91bGQgdGVzdAo+PiBzZ190YWJsZS0+bmVudHMgZW50cnkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KPj4gLS0tCj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29tYXBfZ2VtLmMgfCA2ICsrKy0tLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9vbWFwZHJtL29tYXBfZ2VtLmMKPj4gaW5kZXggZmYwYzRiMGMzZmQwLi5hN2E5YTBhZmUyYjYg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9vbWFwZHJtL29tYXBfZ2VtLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL29tYXBkcm0vb21hcF9nZW0uYwo+PiBAQCAtNDgsNyArNDgsNyBA
QCBzdHJ1Y3Qgb21hcF9nZW1fb2JqZWN0IHsKPj4gwqDCoMKgwqDCoMKgICrCoMKgIE9NQVBfQk9f
TUVNX0RNQV9BUEkgZmxhZyBzZXQpCj4+IMKgwqDCoMKgwqDCoCAqCj4+IMKgwqDCoMKgwqDCoCAq
IC0gYnVmZmVycyBpbXBvcnRlZCBmcm9tIGRtYWJ1ZiAod2l0aCB0aGUgT01BUF9CT19NRU1fRE1B
QlVGIGZsYWcgc2V0KQo+PiAtwqDCoMKgwqAgKsKgwqAgaWYgdGhleSBhcmUgcGh5c2ljYWxseSBj
b250aWd1b3VzICh3aGVuIHNndC0+b3JpZ19uZW50cyA9PSAxKQo+PiArwqDCoMKgwqAgKsKgwqAg
aWYgdGhleSBhcmUgcGh5c2ljYWxseSBjb250aWd1b3VzICh3aGVuIHNndC0+bmVudHMgPT0gMSkK
PiAKPiBIbW0sIGlmIHRoaXMgcmVhbGx5IGRvZXMgbWVhbiAqcGh5c2ljYWxseSogY29udGlndW91
cyAtIGkuZS4gaWYgYnVmZmVycyBtaWdodCBiZSBzaGFyZWQgYmV0d2Vlbgo+IERNQS10cmFuc2xh
dGFibGUgYW5kIG5vbi1ETUEtdHJhbnNsYXRhYmxlIGRldmljZXMgLSB0aGVuIHRoZXNlIGNoYW5n
ZXMgbWlnaHQgbm90IGJlIGFwcHJvcHJpYXRlLiBJZgo+IG5vdCBhbmQgaXQgb25seSBhY3R1YWxs
eSBtZWFucyBETUEtY29udGlndW91cywgdGhlbiBpdCB3b3VsZCBiZSBnb29kIHRvIGNsYXJpZnkg
dGhlIGNvbW1lbnRzIHRvIHRoYXQKPiBlZmZlY3QuCj4gCj4gQ2FuIGFueW9uZSBmYW1pbGlhciB3
aXRoIG9tYXBkcm0gY2xhcmlmeSB3aGF0IGV4YWN0bHkgdGhlIGNhc2UgaXMgaGVyZT8gSSBrbm93
IHRoYXQgSU9NTVVzIG1pZ2h0IGJlCj4gaW52b2x2ZWQgdG8gc29tZSBkZWdyZWUsIGFuZCBJJ3Zl
IHNraW1tZWQgdGhlIGludGVyY29ubmVjdCBjaGFwdGVycyBvZiBlbm91Z2ggT01BUCBUUk1zIHRv
IGJlIHNjYXJlZAo+IGJ5IHRoZSByZWZlcmVuY2UgdG8gdGhlIHRpbGVyIGFwZXJ0dXJlIGluIHRo
ZSBjb250ZXh0IGJlbG93IDopCgpEU1MgKGxpa2UgbWFueSBvdGhlciBJUHMgaW4gT01BUCkgZG9l
cyBub3QgaGF2ZSBhbnkgTU1VL1BBVCwgYW5kIGNhbiBvbmx5IHVzZSBjb250aWd1b3VzIGJ1ZmZl
cnMKKGNvbnRpZ3VvdXMgaW4gdGhlIFJBTSkuCgpUaGVyZSdzIGEgc3BlY2lhbCBjYXNlIHdpdGgg
VElMRVIgKHdoaWNoIGlzIG5vdCBwYXJ0IG9mIERTUyBidXQgb2YgdGhlIG1lbW9yeSBzdWJzeXN0
ZW0sIGJ1dCBpdCdzCnN0aWxsIGhhbmRsZWQgaW50ZXJuYWxseSBieSB0aGUgb21hcGRybSBkcml2
ZXIpLCB3aGljaCBoYXMgYSBQQVQuIFBBVCBjYW4gY3JlYXRlIGEgY29udGlndW91cyB2aWV3Cm9m
IHNjYXR0ZXJlZCBwYWdlcywgYW5kIERTUyBjYW4gdGhlbiB1c2UgdGhpcyBjb250aWd1b3VzIHZp
ZXcgKCJ0aWxlciBhcGVydHVyZSIsIHdoaWNoIHRvIERTUyBsb29rcwpqdXN0IGxpa2Ugbm9ybWFs
IGNvbnRpZ3VvdXMgbWVtb3J5KS4KCk5vdGUgdGhhdCBvbWFwZHJtIGRvZXMgbm90IHVzZSBkbWFf
bWFwX3NnKCkgJiBjby4gbWVudGlvbmVkIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4KCklmIHRo
ZXJlJ3Mgbm8gTU1VL1BBVCwgaXMgb3JpZ19uZW50cyBhbHdheXMgdGhlIHNhbWUgYXMgbmVudHM/
IE9yIGNhbiB3ZSBoYXZlIG11bHRpcGxlIHBoeXNpY2FsbHkKY29udGlndW91cyBwYWdlcyBsaXN0
ZWQgc2VwYXJhdGVseSBpbiB0aGUgc2d0IChzbyBvcmlnX25lbnRzID4gMSkgYnV0IGFzIHRoZSBw
YWdlcyBmb3JtIG9uZSBiaWcKY29udGlndW91cyBhcmVhLCBuZW50cyA9PSAxPwoKIFRvbWkKCi0t
IApUZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5kIE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBI
ZWxzaW5raS4KWS10dW5udXMvQnVzaW5lc3MgSUQ6IDA2MTU1MjEtNC4gS290aXBhaWtrYS9Eb21p
Y2lsZTogSGVsc2lua2kKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
