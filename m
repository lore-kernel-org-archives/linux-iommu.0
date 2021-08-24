Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3767C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 13:46:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297FE61246
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 13:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 297FE61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2EAF80EFD;
	Tue, 24 Aug 2021 13:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2EdNg3EU8dS; Tue, 24 Aug 2021 13:46:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADED580CB3;
	Tue, 24 Aug 2021 13:46:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 802C2C0010;
	Tue, 24 Aug 2021 13:46:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67E86C000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50CA440472
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Dl_DF4XXXVQ for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 13:46:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2706240251
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:46:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 008941042;
 Tue, 24 Aug 2021 06:46:10 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F18B3F5A1;
 Tue, 24 Aug 2021 06:46:07 -0700 (PDT)
Subject: Re: [PATCH v4 15/24] iommu/io-pgtable: Remove non-strict quirk
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1628682048.git.robin.murphy@arm.com>
 <155b5c621cd8936472e273a8b07a182f62c6c20d.1628682049.git.robin.murphy@arm.com>
 <CAMuHMdX+VSr0TJabMBNqob0MkD2o0RBNp8E5QYNx0jFucW1Aew@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1f7de684-c646-cda9-b246-3712f046f2b0@arm.com>
Date: Tue, 24 Aug 2021 14:46:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX+VSr0TJabMBNqob0MkD2o0RBNp8E5QYNx0jFucW1Aew@mail.gmail.com>
Content-Language: en-GB
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, rajatja@google.com,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGkgR2VlcnQsCgpPbiAyMDIxLTA4LTI0IDE0OjI1LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
Cj4gSGkgUm9iaW4sCj4gCj4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMjoyNCBQTSBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToKPj4gSU9fUEdUQUJMRV9RVUlSS19O
T05fU1RSSUNUIHdhcyBuZXZlciBhIHZlcnkgY29tZm9ydGFibGUgZml0LCBzaW5jZSBpdCdzCj4+
IG5vdCBhIHF1aXJrIG9mIHRoZSBwYWdldGFibGUgZm9ybWF0IGl0c2VsZi4gTm93IHRoYXQgd2Ug
aGF2ZSBhIG1vcmUKPj4gYXBwcm9wcmlhdGUgd2F5IHRvIGNvbnZleSBub24tc3RyaWN0IHVubWFw
cywgdGhvdWdoLCB0aGlzIGxhc3Qgb2YgdGhlCj4+IG5vbi1xdWlyayBxdWlya3MgY2FuIGFsc28g
Z28sIGFuZCB3aXRoIHRoZSBmbHVzaCBxdWV1ZSBjb2RlIGFsc28gbm93Cj4+IGVuZm9yY2luZyBp
dHMgb3duIG9yZGVyaW5nIHdlIGNhbiBoYXZlIGEgbG92ZWx5IGNsZWFudXAgYWxsIHJvdW5kLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+
IAo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCwgd2hpY2ggaXMgbm93IGNvbW1pdCBhOGU1ZjA0NDU4
YzRlNDk2Cj4gKCJpb21tdS9pby1wZ3RhYmxlOiBSZW1vdmUgbm9uLXN0cmljdCBxdWlyayIpIGlu
IGlvbW11L25leHQuCj4gCj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdz
LmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYwo+PiBAQCAtNzAw
LDE0ICs3MDAsNyBAQCBzdGF0aWMgc2l6ZV90IF9fYXJtX3Y3c191bm1hcChzdHJ1Y3QgYXJtX3Y3
c19pb19wZ3RhYmxlICpkYXRhLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQVJNX1Y3U19CTE9DS19TSVpFKGx2bCArIDEpKTsKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcHRlcCA9IGlvcHRlX2RlcmVmKHB0ZVtpXSwgbHZsLCBk
YXRhKTsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19hcm1fdjdzX2ZyZWVf
dGFibGUocHRlcCwgbHZsICsgMSwgZGF0YSk7Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgIH0g
ZWxzZSBpZiAoaW9wLT5jZmcucXVpcmtzICYgSU9fUEdUQUJMRV9RVUlSS19OT05fU1RSSUNUKSB7
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyoKPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiBPcmRlciB0aGUgUFRFIHVwZGF0ZSBhZ2FpbnN0IHF1ZXVlaW5n
IHRoZSBJT1ZBLCB0bwo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIGd1YXJh
bnRlZSB0aGF0IGEgZmx1c2ggY2FsbGJhY2sgZnJvbSBhIGRpZmZlcmVudCBDUFUKPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBoYXMgb2JzZXJ2ZWQgaXQgYmVmb3JlIHRoZSBU
TEJJQUxMIGNhbiBiZSBpc3N1ZWQuCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICovCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc21wX3dtYigpOwo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+PiArICAgICAgICAgICAgICAgICAgICAgICB9
IGVsc2UgaWYgKCFnYXRoZXItPnF1ZXVlZCkgewo+IAo+IElmIENPTkZJR19JT01NVV9BUEk9bjoK
PiAKPiBlcnJvcjog4oCYc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlcuKAmSBoYXMgbm8gbWVtYmVy
IG5hbWVkIOKAmHF1ZXVlZOKAmQo+IAo+IFRoaXMgY2FuIGJlIHJlcHJvZHVjZWQgdXNpbmcgZS5n
LiBzaG1vYmlsZV9kZWZjb25maWcgd2l0aAo+ICAgICAgQ09ORklHX0lPTU1VX1NVUFBPUlQ9eQo+
ICAgICAgQ09ORklHX0lPTU1VX0lPX1BHVEFCTEVfQVJNVjdTPXkKPiAKPiAKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW9fcGd0YWJsZV90bGJfYWRkX3BhZ2UoaW9wLCBnYXRo
ZXIsIGlvdmEsIGJsa19zaXplKTsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIH0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIGlvdmEgKz0gYmxrX3NpemU7Cj4gCj4+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0uYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFi
bGUtYXJtLmMKPj4gQEAgLTYzOCwxNCArNjM4LDcgQEAgc3RhdGljIHNpemVfdCBfX2FybV9scGFl
X3VubWFwKHN0cnVjdCBhcm1fbHBhZV9pb19wZ3RhYmxlICpkYXRhLAo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpb19wZ3RhYmxlX3RsYl9mbHVzaF93YWxrKGlvcCwgaW92YSAr
IGkgKiBzaXplLCBzaXplLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEFSTV9MUEFFX0dSQU5VTEUoZGF0YSkpOwo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2FybV9scGFlX2ZyZWVfcGd0YWJsZShkYXRhLCBs
dmwgKyAxLCBpb3B0ZV9kZXJlZihwdGUsIGRhdGEpKTsKPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgfSBlbHNlIGlmIChpb3AtPmNmZy5xdWlya3MgJiBJT19QR1RBQkxFX1FVSVJLX05PTl9TVFJJ
Q1QpIHsKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKgo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIE9yZGVyIHRoZSBQVEUgdXBkYXRlIGFnYWluc3QgcXVl
dWVpbmcgdGhlIElPVkEsIHRvCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICog
Z3VhcmFudGVlIHRoYXQgYSBmbHVzaCBjYWxsYmFjayBmcm9tIGEgZGlmZmVyZW50IENQVQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIGhhcyBvYnNlcnZlZCBpdCBiZWZvcmUg
dGhlIFRMQklBTEwgY2FuIGJlIGlzc3VlZC4KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKi8KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzbXBfd21iKCk7Cj4+
IC0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSBpZiAoIWdhdGhlci0+cXVldWVkKSB7Cj4gCj4gSWYgQ09ORklHX0lPTU1VX0FQ
ST1uOgo+IAo+IGVycm9yOiDigJhzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVy4oCZIGhhcyBubyBt
ZW1iZXIgbmFtZWQg4oCYcXVldWVk4oCZCj4gCj4gVGhpcyBjYW4gYmUgcmVwcm9kdWNlZCB1c2lu
ZyBlLmcuIHNobW9iaWxlX2RlZmNvbmZpZyB3aXRoCj4gICAgICBDT05GSUdfSU9NTVVfU1VQUE9S
VD15Cj4gICAgICBDT05GSUdfSU9NTVVfSU9fUEdUQUJMRV9MUEFFPXkKPiAKPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW9fcGd0YWJsZV90bGJfYWRkX3BhZ2UoaW9wLCBnYXRo
ZXIsIGlvdmEgKyBpICogc2l6ZSwgc2l6ZSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB9
Cj4+Cj4gCj4gUGVyaGFwcyAic2VsZWN0IElPTU1VX0FQSSIgc2hvdWxkIGJlIGFkZGVkIChtb3Zl
ZCBmcm9tIGluZGl2aWR1YWwKPiBkcml2ZXJzKSB0byBib3RoIElPTU1VX0lPX1BHVEFCTEVfQVJN
VjdTIGFuZCBJT01NVV9JT19QR1RBQkxFX0xQQUU/Cj4gT3IgaW9tbXVfaW90bGJfZ2F0aGVyLnF1
ZXVlZCBzaG91bGQgbm90IGJlIGFjY2Vzc2VkIGhlcmUsIG9yIHRoZQo+IGFjY2VzcyB3cmFwcGVk
IGludG8gYSBzdGF0aWMgaW5saW5lIGhlbHBlciBmdW5jdGlvbiB3aXRoIGEgZHVtbXkgZm9yCj4g
dGhlIENPTkZJR19JT01NVV9BUEk9biBjYXNlPwoKVGhvc2UgKGFuZCB3b3JzZSkgc2hvdWxkIGJl
IGZpeGVkIGJ5IHRoaXMgcGF0Y2g6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21t
dS84MzY3MmVlNzZmNjQwNWM4Mjg0NWE1NWMxNDhmYTgzNmY1NmZiYmMxLjE2Mjk0NjUyODIuZ2l0
LnJvYmluLm11cnBoeUBhcm0uY29tLwoKd2hpY2ggYXBwYXJlbnRseSBoYXNuJ3QgbWFkZSBpdCB0
byAtbmV4dCB5ZXQuCgpUaGFua3MsClJvYmluLgoKPiAKPiBHcntvZXRqZSxlZXRpbmd9cywKPiAK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKPiAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
