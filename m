Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F7AC433FE
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 09:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 930B66107A;
	Fri, 25 Mar 2022 09:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QH18SNarQv1o; Fri, 25 Mar 2022 09:21:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CD2561074;
	Fri, 25 Mar 2022 09:21:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F2DC002C;
	Fri, 25 Mar 2022 09:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4341C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 09:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B23406107A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 09:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k86FFudiqFnZ for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 09:21:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE6E661074
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 09:21:46 +0000 (UTC)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nXg8U-00023m-32; Fri, 25 Mar 2022 10:21:34 +0100
Message-ID: <a45549b5-1c05-f995-2c0f-99c0e40cea09@leemhuis.info>
Date: Fri, 25 Mar 2022 10:21:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-US
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Maxime Bizon <mbizon@freebox.fr>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgense?=
 =?UTF-8?Q?n?= <toke@toke.dk>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com> <871qyr9t4e.fsf@toke.dk>
 <4699073.GXAFRqVoOG@natalenko.name>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <4699073.GXAFRqVoOG@natalenko.name>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1648200106;
 6db1eb40; 
X-HE-SMSGID: 1nXg8U-00023m-32
Cc: Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Halil Pasic <pasic@linux.ibm.com>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gMjUuMDMuMjIgMDg6MTIsIE9sZWtzYW5kciBOYXRhbGVua28gd3JvdGU6Cj4gT24gxI10dnJ0
ZWsgMjQuIGLFmWV6bmEgMjAyMiAxODowNzoyOSBDRVQgVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu
IHdyb3RlOgo+PiBSaWdodCwgYnV0IGlzIHRoYXQgc3luY19mb3JfZGV2aWNlIGNhbGwgcmVhbGx5
IG5lZWRlZD8gQUZBSUNULCB0aGF0Cj4+IGF0aDlrX2h3X3Byb2Nlc3NfcnhkZXNjX2VkbWEoKSBp
bnZvY2F0aW9uIGRvZXNuJ3QgYWN0dWFsbHkgbW9kaWZ5IGFueSBvZgo+PiB0aGUgZGF0YSB3aGVu
IGl0IHJldHVybnMgRUlOUFJPR1JFU1MsIHNvIGNvdWxkIHdlIGp1c3Qgc2tpcCBpdD8gTGlrZQo+
PiB0aGUgcGF0Y2ggYmVsb3c/IE9yIGFtIEkgbWlzdW5kZXJzdGFuZGluZyB0aGUgc2VtYW50aWNz
IGhlcmU/Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoOWsv
cmVjdi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDlrL3JlY3YuYwo+PiBpbmRleCAw
YzA2MjRhM2I0MGQuLjE5MjQ0ZDRjMGFkYSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYXRoL2F0aDlrL3JlY3YuYwo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgv
YXRoOWsvcmVjdi5jCj4+IEBAIC02NDcsMTIgKzY0Nyw4IEBAIHN0YXRpYyBib29sIGF0aF9lZG1h
X2dldF9idWZmZXJzKHN0cnVjdCBhdGhfc29mdGMgKnNjLAo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbW1vbi0+cnhfYnVmc2l6ZSwgRE1BX0ZST01fREVWSUNFKTsKPj4gIAo+
PiAgICAgICAgIHJldCA9IGF0aDlrX2h3X3Byb2Nlc3NfcnhkZXNjX2VkbWEoYWgsIHJzLCBza2It
PmRhdGEpOwo+PiAtICAgICAgIGlmIChyZXQgPT0gLUVJTlBST0dSRVNTKSB7Cj4+IC0gICAgICAg
ICAgICAgICAvKmxldCBkZXZpY2UgZ2FpbiB0aGUgYnVmZmVyIGFnYWluKi8KPj4gLSAgICAgICAg
ICAgICAgIGRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKHNjLT5kZXYsIGJmLT5iZl9idWZfYWRk
ciwKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21tb24tPnJ4X2J1ZnNpemUs
IERNQV9GUk9NX0RFVklDRSk7Cj4+ICsgICAgICAgaWYgKHJldCA9PSAtRUlOUFJPR1JFU1MpCj4+
ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+IC0gICAgICAgfQo+PiAgCj4+ICAgICAg
ICAgX19za2JfdW5saW5rKHNrYiwgJnJ4X2VkbWEtPnJ4X2ZpZm8pOwo+PiAgICAgICAgIGlmIChy
ZXQgPT0gLUVJTlZBTCkgewo+IAo+IFdpdGggdGhpcyBwYXRjaCBhbmQgYm90aCBkZGJkODlkZWI3
ZDMrYWE2ZjhkY2JhYjQ3IGluIHBsYWNlIHRoZSBBUCB3b3JrcyBmb3IgbWUuCgpUV0lNQzogSWYg
YW55b25lIG5lZWRzIG1vcmUgdGVzdGVycyBvciBzb21ldGhpbmcsIEkgbm90aWNlZCB0d28gYnVn
CnJlcG9ydCBpbiBia28gYWJvdXQgdGhpcyBwcm9ibGVtOgoKaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTU3MDMKaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0yMTU2OTgKCkknbGwgcG9pbnQgYm90aCB0byB0aGlzIGRpc2N1c3Np
b24gYW5kIHRoZSBwYXRjaC4KCkNpYW8sIFRob3JzdGVuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
