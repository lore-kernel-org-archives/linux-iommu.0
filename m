Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA645C43334
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 07:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DC5240142;
	Tue, 21 Jun 2022 07:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DC5240142
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=wht0PXye
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id akQwrvKVwawY; Tue, 21 Jun 2022 07:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26F7840222;
	Tue, 21 Jun 2022 07:44:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26F7840222
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9526C0032;
	Tue, 21 Jun 2022 07:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F8E3C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87A8A60BC4
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87A8A60BC4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=wht0PXye
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPl62CJ0uPhB for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 07:44:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E8DF60BC0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E8DF60BC0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 07:44:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 066BE6142C;
 Tue, 21 Jun 2022 07:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED6BC3411D;
 Tue, 21 Jun 2022 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1655797454;
 bh=TgZQktU/5vsZP3GPNZ/qWZleinBCCk2cgAR6Lox4crc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wht0PXyeuQwQyGpWl60X7KoWQ4g7oJT8n4WSl6EFrGYthyFE7HShKTIyBJGnBxmAb
 467t3Luka6NxNagPemIBgkgzsXnCDWmc5oXT9YqDSLh8BX8/0LLURrypXa+4Qk8Aq+
 Ap1psmSnRkJLyskIBIwSkuYFJ8Kf6sideKMUsN6o=
Date: Tue, 21 Jun 2022 09:44:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrF2yypHZfiNVRBh@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica> <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
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

T24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMDM6Mzc6MzFQTSArMDgwMCwgWmhhbmdmZWkgR2FvIHdy
b3RlOgo+IAo+IAo+IE9uIDIwMjIvNi8yMCDkuIvljYg5OjM2LCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6Cj4gPiBPbiBNb24sIEp1biAyMCwgMjAyMiBhdCAwMjoyNDozMVBNICswMTAwLCBKZWFu
LVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gPiA+IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0IDAy
OjA1OjIxUE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPiA+ID4gPiA+IFRoZSByZWZjb3Vu
dCBvbmx5IGVuc3VyZXMgdGhhdCB0aGUgdWFjY2VfZGV2aWNlIG9iamVjdCBpcyBub3QgZnJlZWQg
YXMKPiA+ID4gPiA+IGxvbmcgYXMgdGhlcmUgYXJlIG9wZW4gZmRzLiBCdXQgdWFjY2VfcmVtb3Zl
KCkgY2FuIHJ1biB3aGlsZSB0aGVyZSBhcmUKPiA+ID4gPiA+IG9wZW4gZmRzLCBvciBmZHMgaW4g
dGhlIHByb2Nlc3Mgb2YgYmVpbmcgb3BlbmVkLiBBbmQgYXRmZXIgdWFjY2VfcmVtb3ZlKCkKPiA+
ID4gPiA+IHJ1bnMsIHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMg
bW9zdGx5IHVudXNhYmxlLiBGb3IKPiA+ID4gPiA+IGV4YW1wbGUgb25jZSB0aGUgbW9kdWxlIGlz
IGZyZWVkLCB1YWNjZS0+b3BzIGlzIG5vdCB2YWxpZCBhbnltb3JlLiBCdXQKPiA+ID4gPiA+IGN1
cnJlbnRseSB1YWNjZV9mb3BzX29wZW4oKSBtYXkgZGVyZWZlcmVuY2UgdGhlIG9wcyBpbiB0aGlz
IGNhc2U6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IAl1YWNjZV9mb3BzX29wZW4oKQo+ID4gPiA+ID4g
CSBpZiAoIXVhY2NlLT5wYXJlbnQtPmRyaXZlcikKPiA+ID4gPiA+IAkgLyogU3RpbGwgdmFsaWQs
IGtlZXAgZ29pbmcgKi8JCQo+ID4gPiA+ID4gCSAuLi4JCQkJCXJtbW9kCj4gPiA+ID4gPiAJCQkJ
CQkgdWFjY2VfcmVtb3ZlKCkKPiA+ID4gPiA+IAkgLi4uCQkJCQkgZnJlZV9tb2R1bGUoKQo+ID4g
PiA+ID4gCSB1YWNjZS0+b3BzLT5nZXRfcXVldWUoKSAvKiBCVUcgKi8KPiA+ID4gPiB1YWNjZV9y
ZW1vdmUgc2hvdWxkIHdhaXQgZm9yIHVhY2NlLT5xdWV1ZXNfbG9jaywgdW50aWwgZm9wc19vcGVu
IHJlbGVhc2UgdGhlCj4gPiA+ID4gbG9jay4KPiA+ID4gPiBJZiBvcGVuIGhhcHBlbiBqdXN0IGFm
dGVyIHRoZSB1YWNjZV9yZW1vdmU6IHVubG9jaywgdWFjY2VfYmluZF9xdWV1ZSBpbiBvcGVuCj4g
PiA+ID4gc2hvdWxkIGZhaWwuCj4gPiA+IEFoIHllcyBzb3JyeSwgSSBsb3N0IHNpZ2h0IG9mIHdo
YXQgdGhpcyBwYXRjaCB3YXMgYWRkaW5nLiBCdXQgd2UgY291bGQKPiA+ID4gaGF2ZSB0aGUgc2Ft
ZSBpc3N1ZSB3aXRoIHRoZSBwYXRjaCwganVzdCBpbiBhIGRpZmZlcmVudCBvcmRlciwgbm8/Cj4g
PiA+IAo+ID4gPiAJdWFjY2VfZm9wc19vcGVuKCkKPiA+ID4gCSB1YWNjZSA9IHhhX2xvYWQoKQo+
ID4gPiAJIC4uLgkJCQkJcm1tb2QKPiA+IFVtLCBob3cgaXMgcm1tb2QgY2FsbGVkIGlmIHRoZSBm
aWxlIGRlc2NyaXB0b3IgaXMgb3Blbj8KPiA+IAo+ID4gVGhhdCBzaG91bGQgbm90IGJlIHBvc3Np
YmxlIGlmIHRoZSBvd25lciBvZiB0aGUgZmlsZSBkZXNjcmlwdG9yIGlzCj4gPiBwcm9wZXJseSBz
ZXQuICBQbGVhc2UgZml4IHRoYXQgdXAuCj4gVGhhbmtzIEdyZWcKPiAKPiBTZXQgY2RldiBvd25l
ciBvciB1c2UgbW9kdWxlX2dldC9wdXQgY2FuIGJsb2NrIHJtbW9kIG9uY2UgZm9wc19vcGVuLgo+
IC3CoMKgwqDCoMKgwqAgdWFjY2UtPmNkZXYtPm93bmVyID0gVEhJU19NT0RVTEU7Cj4gK8KgwqDC
oMKgwqDCoCB1YWNjZS0+Y2Rldi0+b3duZXIgPSB1YWNjZS0+cGFyZW50LT5kcml2ZXItPm93bmVy
Owo+IAo+IEhvd2V2ZXIsIHN0aWxsIG5vdCBmaW5kIGdvb2QgbWV0aG9kIHRvIGJsb2NrIHJlbW92
aW5nIHBhcmVudCBwY2kgZGV2aWNlLgo+IAo+ICQgZWNobyAxID4gL3N5cy9idXMvcGNpL2Rldmlj
ZXMvMDAwMDowMDowMi4wL3JlbW92ZSAmCj4gCj4gW8KgwqAgMzIuNTYzMzUwXcKgIHVhY2NlX3Jl
bW92ZSsweDZjLzB4MTQ4Cj4gW8KgwqAgMzIuNTYzMzUzXcKgIGhpc2lfcW1fdW5pbml0KzB4MTJj
LzB4MTc4Cj4gW8KgwqAgMzIuNTYzMzU2XcKgIGhpc2lfemlwX3JlbW92ZSsweGEwLzB4ZDAgW2hp
c2lfemlwXQo+IFvCoMKgIDMyLjU2MzM2MV3CoCBwY2lfZGV2aWNlX3JlbW92ZSsweDQ0LzB4ZDgK
PiBbwqDCoCAzMi41NjMzNjRdwqAgZGV2aWNlX3JlbW92ZSsweDU0LzB4ODgKPiBbwqDCoCAzMi41
NjMzNjddwqAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4ZWMvMHgxYTAKPiBbwqDC
oCAzMi41NjMzNzBdwqAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyKzB4MjAvMHgzMAo+IFvCoMKgIDMy
LjU2MzM3Ml3CoCBwY2lfc3RvcF9idXNfZGV2aWNlKzB4OGMvMHhlMAo+IFvCoMKgIDMyLjU2MzM3
NV3CoCBwY2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2VfbG9ja2VkKzB4MjgvMHg2MAo+IFvC
oMKgIDMyLjU2MzM3OF3CoCByZW1vdmVfc3RvcmUrMHg5Yy8weGIwCj4gW8KgwqAgMzIuNTYzMzc5
XcKgIGRldl9hdHRyX3N0b3JlKzB4MjAvMHgzOAoKUmVtb3ZpbmcgdGhlIHBhcmVudCBwY2kgZGV2
aWNlIGRvZXMgbm90IHJlbW92ZSB0aGUgbW9kdWxlIGNvZGUsIGl0CnJlbW92ZXMgdGhlIGRldmlj
ZSBpdHNlbGYuICBEb24ndCBjb25mdXNlIGNvZGUgdnMuIGRhdGEgaGVyZS4KCnRoYW5rcywKCmdy
ZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
