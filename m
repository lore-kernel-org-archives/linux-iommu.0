Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851FC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 08:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3263409A6;
	Wed, 22 Jun 2022 08:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3263409A6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=qeE7pxOH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GdZkZ6bP4r_V; Wed, 22 Jun 2022 08:24:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F8FA40A02;
	Wed, 22 Jun 2022 08:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F8FA40A02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55437C0039;
	Wed, 22 Jun 2022 08:24:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 889B0C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A431409E9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:24:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A431409E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8aXpe8xB6bJv for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:24:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0265409A6
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0265409A6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:24:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BD477B81CC0;
 Wed, 22 Jun 2022 08:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0BDC34114;
 Wed, 22 Jun 2022 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1655886270;
 bh=YbuYr5/ie+xJQcPyfNne1QY4FDSlOh+xwavMqcIsMnU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qeE7pxOHB1owDbNrefzoSq4pKLcFSTifGgjLZlz5Vqg0MHXH7Un2gk9NlDFQw0L8H
 tJeGbPX5BCTacAgEZpRXso9n9IfPTXYTgLGAMwwttl+GY4KuCmuqyFUGx7nPJS10/z
 4kLiDY/g2Y8mIccxuXLTBl5Ky28evFXltp3I8A0g=
Date: Wed, 22 Jun 2022 10:24:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrLRwF24FHV9nhA8@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica> <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
 <YrF2yypHZfiNVRBh@kroah.com>
 <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

T24gV2VkLCBKdW4gMjIsIDIwMjIgYXQgMDQ6MTQ6NDVQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IEhpLCBHcmVnCj4gCj4gT24gMjAyMi82LzIxIOS4i+WNiDM6NDQsIEdyZWcgS3JvYWgt
SGFydG1hbiB3cm90ZToKPiA+IE9uIFR1ZSwgSnVuIDIxLCAyMDIyIGF0IDAzOjM3OjMxUE0gKzA4
MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIDIwMjIvNi8yMCDkuIvljYg5
OjM2LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6Cj4gPiA+ID4gT24gTW9uLCBKdW4gMjAsIDIw
MjIgYXQgMDI6MjQ6MzFQTSArMDEwMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+ID4g
PiA+ID4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDI6MDU6MjFQTSArMDgwMCwgWmhhbmdmZWkg
R2FvIHdyb3RlOgo+ID4gPiA+ID4gPiA+IFRoZSByZWZjb3VudCBvbmx5IGVuc3VyZXMgdGhhdCB0
aGUgdWFjY2VfZGV2aWNlIG9iamVjdCBpcyBub3QgZnJlZWQgYXMKPiA+ID4gPiA+ID4gPiBsb25n
IGFzIHRoZXJlIGFyZSBvcGVuIGZkcy4gQnV0IHVhY2NlX3JlbW92ZSgpIGNhbiBydW4gd2hpbGUg
dGhlcmUgYXJlCj4gPiA+ID4gPiA+ID4gb3BlbiBmZHMsIG9yIGZkcyBpbiB0aGUgcHJvY2VzcyBv
ZiBiZWluZyBvcGVuZWQuIEFuZCBhdGZlciB1YWNjZV9yZW1vdmUoKQo+ID4gPiA+ID4gPiA+IHJ1
bnMsIHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5IHVu
dXNhYmxlLiBGb3IKPiA+ID4gPiA+ID4gPiBleGFtcGxlIG9uY2UgdGhlIG1vZHVsZSBpcyBmcmVl
ZCwgdWFjY2UtPm9wcyBpcyBub3QgdmFsaWQgYW55bW9yZS4gQnV0Cj4gPiA+ID4gPiA+ID4gY3Vy
cmVudGx5IHVhY2NlX2ZvcHNfb3BlbigpIG1heSBkZXJlZmVyZW5jZSB0aGUgb3BzIGluIHRoaXMg
Y2FzZToKPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiAJdWFjY2VfZm9wc19vcGVuKCkKPiA+
ID4gPiA+ID4gPiAJIGlmICghdWFjY2UtPnBhcmVudC0+ZHJpdmVyKQo+ID4gPiA+ID4gPiA+IAkg
LyogU3RpbGwgdmFsaWQsIGtlZXAgZ29pbmcgKi8JCQo+ID4gPiA+ID4gPiA+IAkgLi4uCQkJCQly
bW1vZAo+ID4gPiA+ID4gPiA+IAkJCQkJCSB1YWNjZV9yZW1vdmUoKQo+ID4gPiA+ID4gPiA+IAkg
Li4uCQkJCQkgZnJlZV9tb2R1bGUoKQo+ID4gPiA+ID4gPiA+IAkgdWFjY2UtPm9wcy0+Z2V0X3F1
ZXVlKCkgLyogQlVHICovCj4gPiA+ID4gPiA+IHVhY2NlX3JlbW92ZSBzaG91bGQgd2FpdCBmb3Ig
dWFjY2UtPnF1ZXVlc19sb2NrLCB1bnRpbCBmb3BzX29wZW4gcmVsZWFzZSB0aGUKPiA+ID4gPiA+
ID4gbG9jay4KPiA+ID4gPiA+ID4gSWYgb3BlbiBoYXBwZW4ganVzdCBhZnRlciB0aGUgdWFjY2Vf
cmVtb3ZlOiB1bmxvY2ssIHVhY2NlX2JpbmRfcXVldWUgaW4gb3Blbgo+ID4gPiA+ID4gPiBzaG91
bGQgZmFpbC4KPiA+ID4gPiA+IEFoIHllcyBzb3JyeSwgSSBsb3N0IHNpZ2h0IG9mIHdoYXQgdGhp
cyBwYXRjaCB3YXMgYWRkaW5nLiBCdXQgd2UgY291bGQKPiA+ID4gPiA+IGhhdmUgdGhlIHNhbWUg
aXNzdWUgd2l0aCB0aGUgcGF0Y2gsIGp1c3QgaW4gYSBkaWZmZXJlbnQgb3JkZXIsIG5vPwo+ID4g
PiA+ID4gCj4gPiA+ID4gPiAJdWFjY2VfZm9wc19vcGVuKCkKPiA+ID4gPiA+IAkgdWFjY2UgPSB4
YV9sb2FkKCkKPiA+ID4gPiA+IAkgLi4uCQkJCQlybW1vZAo+ID4gPiA+IFVtLCBob3cgaXMgcm1t
b2QgY2FsbGVkIGlmIHRoZSBmaWxlIGRlc2NyaXB0b3IgaXMgb3Blbj8KPiA+ID4gPiAKPiA+ID4g
PiBUaGF0IHNob3VsZCBub3QgYmUgcG9zc2libGUgaWYgdGhlIG93bmVyIG9mIHRoZSBmaWxlIGRl
c2NyaXB0b3IgaXMKPiA+ID4gPiBwcm9wZXJseSBzZXQuICBQbGVhc2UgZml4IHRoYXQgdXAuCj4g
PiA+IFRoYW5rcyBHcmVnCj4gPiA+IAo+ID4gPiBTZXQgY2RldiBvd25lciBvciB1c2UgbW9kdWxl
X2dldC9wdXQgY2FuIGJsb2NrIHJtbW9kIG9uY2UgZm9wc19vcGVuLgo+ID4gPiAtwqDCoMKgwqDC
oMKgIHVhY2NlLT5jZGV2LT5vd25lciA9IFRISVNfTU9EVUxFOwo+ID4gPiArwqDCoMKgwqDCoMKg
IHVhY2NlLT5jZGV2LT5vd25lciA9IHVhY2NlLT5wYXJlbnQtPmRyaXZlci0+b3duZXI7Cj4gPiA+
IAo+ID4gPiBIb3dldmVyLCBzdGlsbCBub3QgZmluZCBnb29kIG1ldGhvZCB0byBibG9jayByZW1v
dmluZyBwYXJlbnQgcGNpIGRldmljZS4KPiA+ID4gCj4gPiA+ICQgZWNobyAxID4gL3N5cy9idXMv
cGNpL2RldmljZXMvMDAwMDowMDowMi4wL3JlbW92ZSAmCj4gPiA+IAo+ID4gPiBbwqDCoCAzMi41
NjMzNTBdwqAgdWFjY2VfcmVtb3ZlKzB4NmMvMHgxNDgKPiA+ID4gW8KgwqAgMzIuNTYzMzUzXcKg
IGhpc2lfcW1fdW5pbml0KzB4MTJjLzB4MTc4Cj4gPiA+IFvCoMKgIDMyLjU2MzM1Nl3CoCBoaXNp
X3ppcF9yZW1vdmUrMHhhMC8weGQwIFtoaXNpX3ppcF0KPiA+ID4gW8KgwqAgMzIuNTYzMzYxXcKg
IHBjaV9kZXZpY2VfcmVtb3ZlKzB4NDQvMHhkOAo+ID4gPiBbwqDCoCAzMi41NjMzNjRdwqAgZGV2
aWNlX3JlbW92ZSsweDU0LzB4ODgKPiA+ID4gW8KgwqAgMzIuNTYzMzY3XcKgIGRldmljZV9yZWxl
YXNlX2RyaXZlcl9pbnRlcm5hbCsweGVjLzB4MWEwCj4gPiA+IFvCoMKgIDMyLjU2MzM3MF3CoCBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgyMC8weDMwCj4gPiA+IFvCoMKgIDMyLjU2MzM3Ml3CoCBw
Y2lfc3RvcF9idXNfZGV2aWNlKzB4OGMvMHhlMAo+ID4gPiBbwqDCoCAzMi41NjMzNzVdwqAgcGNp
X3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlX2xvY2tlZCsweDI4LzB4NjAKPiA+ID4gW8KgwqAg
MzIuNTYzMzc4XcKgIHJlbW92ZV9zdG9yZSsweDljLzB4YjAKPiA+ID4gW8KgwqAgMzIuNTYzMzc5
XcKgIGRldl9hdHRyX3N0b3JlKzB4MjAvMHgzOAo+ID4gUmVtb3ZpbmcgdGhlIHBhcmVudCBwY2kg
ZGV2aWNlIGRvZXMgbm90IHJlbW92ZSB0aGUgbW9kdWxlIGNvZGUsIGl0Cj4gPiByZW1vdmVzIHRo
ZSBkZXZpY2UgaXRzZWxmLiAgRG9uJ3QgY29uZnVzZSBjb2RlIHZzLiBkYXRhIGhlcmUuCj4gCj4g
RG8geW91IG1lYW4gZXZlbiBwYXJlbnQgcGNpIGRldmljZSBpcyByZW1vdmVkIGltbWVkaWF0ZWx5
LCB0aGUgY29kZSBoYXMgdG8KPiB3YWl0LCBsaWtlIGRtYSBldGM/CgpObywgcmVhZHMgd2lsbCBm
YWlsLCBhcyB3aWxsIERNQSB0cmFuc2ZlcnMsIGFsbCBQQ0kgZHJpdmVycyBuZWVkIHRvCmhhbmRs
ZSBzdXJwcmlzZSByZW1vdmFsIGxpa2UgdGhpcyBhcyB3ZSBoYXZlIGhhZCBQQ0kgaG90cGx1ZyBz
eXN0ZW1zIGZvcgpkZWNhZGVzIG5vdy4KCj4gQ3VycmVudGx5IHBhcmVudCBkcml2ZXIgaGFzIHRv
IGVuc3VyZSBhbGwgZG1hIHN0b3BwZWQgdGhlbiBjYWxsCj4gdWFjY2VfcmVtb3ZlLAo+IGllLCBh
ZnRlciB1YWNjZV9mb3BzX29wZW4gc3VjY2VlZCwgcGFyZW50IGRyaXZlciBuZWVkIHdhaXQgZm9w
c19yZWxlYXNlLAo+IHRoZW4gdWFjY2VfcmVtb3ZlIGNhbiBiZSBjYWxsZWQuCgpyZW1vdmUgY2Fu
IGJlIGNhbGxlZCBiZWZvcmUgdGhlIGZpbGUgY2xvc2UgY2FuIGhhcHBlbiBhbGwgdGhlIHRpbWUs
IHlvdQpuZWVkIHRvIGhhbmRsZSB0aGF0IHByb3Blcmx5LgoKPiBGb3IgZXhhbXBsZToKPiBkcml2
ZXJzL2NyeXB0by9oaXNpbGljb24vemlwL3ppcF9tYWluLmM6Cj4gaGlzaV9xbV93YWl0X3Rhc2tf
ZmluaXNoCj4gCj4gSWYgcmVtb3ZlIHRoaXMgd2FpdCAsIHRoZXJlIG1heSBvdGhlciBpc3N1ZSwK
PiBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJl
c3MgZmZmZjgwMDAwYjcwMDIwNAo+IHBjIDogaGlzaV9xbV9jYWNoZV93Yi5wYXJ0LjArMHgyYy8w
eGEwCj4gCj4gU28gdWFjY2Ugb25seSBuZWVkIHNlcmlhbGl6ZSB1YWNjZV9mb3BzX29wZW4gYW5k
IHVhY2NlX3JlbW92ZS4KClRoYXQncyBub3QgZ29pbmcgdG8gaGVscCBtdWNoLgoKPiBBZnRlciB1
YWNjZV9mb3BzX29wZW4sIHdlIGNhbiBhc3N1bWUgdWFjY2VfcmVtb3ZlIG9ubHkgaGFwcGVuIGFm
dGVyCj4gdWFjY2VfZm9wc19yZWxlYXNlPwoKTm9wZSwgYWdhaW4sIGRldmljZSByZW1vdmUgY2Fu
IGhhcHBlbiBhdCBhbnkgcG9pbnQgaW4gdGltZSBhbmQgaXMKaW5kZXBlbmRlbnQgb2YgdXNlcnNw
YWNlIG9wZW4vY2xvc2Ugb2YgZmlsZSBkZXNjcmlwdG9ycyBvbiB0aGUgY2hhcgpkZXZpY2UuCgpU
aGlzIGlzIGEgY29tbW9uIHByb2JsZW0vcGF0dGVybiB0aGF0IGRyaXZlcnMgbmVlZCB0byBoYW5k
bGUsIGFuZAp1bmZvcnR1bmF0bHkgdGhleSBhbGwgbmVlZCB0byBoYW5kbGUgaXQgb24gdGhlaXIg
b3duLiAgV2UgaGF2ZSBkaXNjdXNzZWQKd2F5cyBvZiBtYWtpbmcgaXQgZWFzaWVyIChzZWUgdGhl
IGtzdW1taXQgZGlzY3VzcyBsaXN0IGFyY2hpdmVzIGZyb20KbGFzdCB5ZWFyKSwgYnV0IG5vIG9u
ZSBoYXMgc3RlcHBlZCB1cCBhbmQgZG9uZSB0aGUgd29yayB5ZXQgOigKCj4gVGhlbiBpdCB3b3Vs
ZCBiZSBtdWNoIHNpbXBsZXIuCgpTb3JyeS4gIElmIHlvdSB0cmVhdCB0aGUgc3RydWN0dXJlcyBh
cyBpbmRlcGVuZGFudCwgYW5kIHByb3Blcmx5IGdyYWIKc29tZSByZWZlcmVuY2UgY291bnRzIG9y
IGEgbG9jaywgeW91IHNob3VsZCBiZSBvay4KCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
