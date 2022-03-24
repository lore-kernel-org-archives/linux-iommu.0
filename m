Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41258C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 10:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6EA64102A;
	Thu, 24 Mar 2022 10:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXf4rWnLqSWd; Thu, 24 Mar 2022 10:25:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EFAFA400A8;
	Thu, 24 Mar 2022 10:25:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B53B3C001A;
	Thu, 24 Mar 2022 10:25:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C01C6C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACA1860B6A
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:25:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=natalenko.name
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xUf4AO8X2Y2X for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:25:16 +0000 (UTC)
X-Greylist: delayed 01:29:26 by SQLgrey-1.8.0
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BAF260ACC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 10:25:16 +0000 (UTC)
Received: from spock.localnet (unknown [83.148.33.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 46336E4A5DD;
 Thu, 24 Mar 2022 11:25:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1648117508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kZDRe244Ho+56p1lKIcy0+GT4xOH+L25rK8rNrmj5M=;
 b=xTLCXRCNMwAKN6C6abDkvpf8K2mg/Sm4GaWSCsryLwp5Fq4HqX8lUoEohqBSWrzOqMIaix
 kRFT7EmZ97tKbHZfyY4//hxr65jVGb/7gVgp7+S6tP4fJ8p1HUuP7h1jt5+OqhjIlCJgG2
 yc1FDX9OJ6CAbtcVZklteEyyfX7d5Cw=
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Date: Thu, 24 Mar 2022 11:25:06 +0100
Message-ID: <4386660.LvFx2qVVIh@natalenko.name>
In-Reply-To: <20220324055732.GB12078@lst.de>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de>
MIME-Version: 1.0
Cc: Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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
From: Oleksandr Natalenko via iommu <iommu@lists.linux-foundation.org>
Reply-To: Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGVsbG8uCgpPbiDEjXR2cnRlayAyNC4gYsWZZXpuYSAyMDIyIDY6NTc6MzIgQ0VUIENocmlzdG9w
aCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwgTWFyIDIzLCAyMDIyIGF0IDA4OjU0OjA4UE0gKzAw
MDAsIFJvYmluIE11cnBoeSB3cm90ZToKPiA+IEknbGwgYWRtaXQgSSBzdGlsbCBuZXZlciBxdWl0
ZSBncmFzcGVkIHRoZSByZWFzb24gZm9yIGFsc28gYWRkaW5nIHRoZSAKPiA+IG92ZXJyaWRlIHRv
IHN3aW90bGJfc3luY19zaW5nbGVfZm9yX2RldmljZSgpIGluIGFhNmY4ZGNiYWI0NywgYnV0IEkg
dGhpbmsgCj4gPiBieSB0aGF0IHBvaW50IHdlIHdlcmUgaW5jcmVhc2luZ2x5IHRpcmVkIGFuZCBj
b25mdXNlZCBhbmQgc3RhcnRpbmcgdG8gCj4gPiBzZWNvbmQtZ3Vlc3Mgb3Vyc2VsdmVzICh3ZWxs
LCBJIHdhcywgYXQgbGVhc3QpLiBJIGRvbid0IHRoaW5rIGl0J3Mgd3JvbmcgCj4gPiBwZXIgc2Us
IGJ1dCBhcyBJIHNhaWQgSSBkbyB0aGluayBpdCBjYW4gYml0ZSBhbnlvbmUgd2hvJ3MgYmVlbiBk
b2luZyAKPiA+IGRtYV9zeW5jXyooKSB3cm9uZyBidXQgZ2V0dGluZyBhd2F5IHdpdGggaXQgdW50
aWwgbm93LiBJZiBkZGJkODlkZWI3ZDMgCj4gPiBhbG9uZSB0dXJucyBvdXQgdG8gd29yayBPSyB0
aGVuIEknZCBiZSBpbmNsaW5lZCB0byB0cnkgYSBwYXJ0aWFsIHJldmVydCBvZiAKPiA+IGp1c3Qg
dGhhdCBvbmUgaHVuay4KPiAKPiBBZ3JlZWQuICBMZXQncyB0cnkgdGhhdCBmaXJzdC4KPiAKPiBP
bGVrc2FuZHIsIGNhbiB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdzoKPiAKPiAKPiBkaWZmIC0tZ2l0
IGEva2VybmVsL2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+IGluZGV4IDZk
YjFjNDc1ZWM4MjcuLjZjMzUwNTU1ZTVhMWMgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2RtYS9zd2lv
dGxiLmMKPiArKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwo+IEBAIC03MDEsMTMgKzcwMSwxMCBA
QCB2b2lkIHN3aW90bGJfdGJsX3VubWFwX3NpbmdsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNf
YWRkcl90IHRsYl9hZGRyLAo+ICB2b2lkIHN3aW90bGJfc3luY19zaW5nbGVfZm9yX2RldmljZShz
dHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHRsYl9hZGRyLAo+ICAJCXNpemVfdCBzaXpl
LCBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIpCj4gIHsKPiAtCS8qCj4gLQkgKiBVbmNvbmRp
dGlvbmFsIGJvdW5jZSBpcyBuZWNlc3NhcnkgdG8gYXZvaWQgY29ycnVwdGlvbiBvbgo+IC0JICog
c3luY18qX2Zvcl9jcHUgb3IgZG1hX3VtbWFwXyogd2hlbiB0aGUgZGV2aWNlIGRpZG4ndCBvdmVy
d3JpdGUKPiAtCSAqIHRoZSB3aG9sZSBsZW5ndCBvZiB0aGUgYm91bmNlIGJ1ZmZlci4KPiAtCSAq
Lwo+IC0Jc3dpb3RsYl9ib3VuY2UoZGV2LCB0bGJfYWRkciwgc2l6ZSwgRE1BX1RPX0RFVklDRSk7
Cj4gLQlCVUdfT04oIXZhbGlkX2RtYV9kaXJlY3Rpb24oZGlyKSk7Cj4gKwlpZiAoZGlyID09IERN
QV9UT19ERVZJQ0UgfHwgZGlyID09IERNQV9CSURJUkVDVElPTkFMKQo+ICsJCXN3aW90bGJfYm91
bmNlKGRldiwgdGxiX2FkZHIsIHNpemUsIERNQV9UT19ERVZJQ0UpOwo+ICsJZWxzZQo+ICsJCUJV
R19PTihkaXIgIT0gRE1BX0ZST01fREVWSUNFKTsKPiAgfQo+ICAKPiAgdm9pZCBzd2lvdGxiX3N5
bmNfc2luZ2xlX2Zvcl9jcHUoc3RydWN0IGRldmljZSAqZGV2LCBwaHlzX2FkZHJfdCB0bGJfYWRk
ciwKPiAKCldpdGggdGhpcyBwYXRjaCB0aGUgQVAgd29ya3MgZm9yIG1lLgoKVGhhbmtzLgoKLS0g
Ck9sZWtzYW5kciBOYXRhbGVua28gKHBvc3QtZmFjdHVtKQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
