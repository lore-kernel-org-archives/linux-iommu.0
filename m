Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033D6C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 08:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93AA060EA6;
	Tue, 22 Feb 2022 08:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TcfPiEI3vL_v; Tue, 22 Feb 2022 08:37:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CEAF60E93;
	Tue, 22 Feb 2022 08:37:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20A6CC001A;
	Tue, 22 Feb 2022 08:37:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3787AC0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1623B4054A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LrDGjhWOs9dw for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 08:37:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51A5A4006C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Y5Q0bIv6KCJJMw/T06DdwsQiFx+TO703WYBc0RO2zg=; b=1BASgC2ZmAp7Yuf1iRh/CZrpM+
 fUes0bn2kS7zkMDCz1SLhO7N2+FCpEpAiKn1Y3+EZMMlwpwQ7R7NKXAtcCaom+H6pkDtZWlW+wIx/
 8hnwMmQ+V4dv//mER9Yle4tcbymSC3T5g6HMT7YDP0pzHTb1rEQsuTX0nosAUfeIn5lJe9hHKKvwP
 gbcThs7e1pUbiiiK+Ye8R9KPzRr9nggO5p5zj1XuaZIiSuXK3c662c0q+M02SlRwvTranKvMD6sQg
 4LKm0IlHl2rJElKURPmgu6a80acIsyj3EnNIVWxgkO1mETmOJBImYmwsQDTT6qReeeXHHXyYZegpV
 81lXv4Pg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nMQfS-00063Y-Iy; Tue, 22 Feb 2022 10:37:06 +0200
Message-ID: <134c4a28-4331-deed-a374-75c9711168f0@kapsi.fi>
Date: Tue, 22 Feb 2022 10:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To: Dmitry Osipenko <digetx@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
 <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
 <ea65fcd6-9451-7f5b-f4a9-57b8575f09ff@kapsi.fi>
 <bb533634-6cde-3835-db11-7b6191385294@gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <bb533634-6cde-3835-db11-7b6191385294@gmail.com>
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMi8yMS8yMiAyMjowMiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+IDIxLjAyLjIwMjIgMTU6
MDYsIE1pa2tvIFBlcnR0dW5lbiDQv9C40YjQtdGCOgo+PiBPbiAyLzE5LzIyIDIwOjM1LCBEbWl0
cnkgT3NpcGVua28gd3JvdGU6Cj4+PiAxOC4wMi4yMDIyIDE0OjM5LCBNaWtrbyBQZXJ0dHVuZW4g
0L/QuNGI0LXRgjoKPj4+PiArwqDCoMKgIGlmIChjb250ZXh0LT5tZW1vcnlfY29udGV4dCAmJgo+
Pj4+IGNvbnRleHQtPmNsaWVudC0+b3BzLT5nZXRfc3RyZWFtaWRfb2Zmc2V0KSB7Cj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIF5eXgo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpbnQgb2Zmc2V0
ID0KPj4+PiBjb250ZXh0LT5jbGllbnQtPm9wcy0+Z2V0X3N0cmVhbWlkX29mZnNldChjb250ZXh0
LT5jbGllbnQpOwo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG9mZnNldCA+PSAwKSB7
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgam9iLT5jb250ZXh0ID0gY29udGV4dC0+bWVt
b3J5X2NvbnRleHQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgam9iLT5lbmdpbmVfc3Ry
ZWFtaWRfb2Zmc2V0ID0gb2Zmc2V0Owo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhvc3Qx
eF9jb250ZXh0X2dldChqb2ItPmNvbnRleHQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+Pgo+
Pj4gWW91IHNob3VsZCBidW1wIHJlZmNvdW50IHVuY29uZGl0aW9uYWxseSBvciB5b3UnbGwgZ2V0
IHJlZmNudCB1bmRlcmZsb3cKPj4+IG9uIHB1dCwgd2hlbiBvZmZzZXQgPCAwLgo+Pgo+PiBUaGlz
IHJlZmNvdW50IGlzIGludGVuZGVkIHRvIGJlIGRyb3BwZWQgZnJvbSAncmVsZWFzZV9qb2InLCB3
aGVyZSBpdCdzCj4+IGRyb3BwZWQgaWYgam9iLT5jb250ZXh0IGlzIHNldCwgd2hpY2ggaXQgaXMg
ZnJvbSB0aGlzIHBhdGguCj4+Cj4+Pgo+Pj4+ICvCoMKgwqAgfQo+Pj4+ICsKPj4+PiAgwqDCoMKg
wqDCoCAvKgo+Pj4+ICDCoMKgwqDCoMKgwqAgKiBqb2JfZGF0YSBpcyBub3cgcGFydCBvZiBqb2Ig
cmVmZXJlbmNlIGNvdW50aW5nLCBzbyBkb24ndAo+Pj4+IHJlbGVhc2UKPj4+PiAgwqDCoMKgwqDC
oMKgICogaXQgZnJvbSBoZXJlLgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdGVn
cmEvdWFwaS5jIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3VhcGkuYwo+Pj4+IGluZGV4IDlhYjkx
NzlkMjAyNi4uYmUzM2RhNTRkMTJjIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90
ZWdyYS91YXBpLmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdGVncmEvdWFwaS5jCj4+Pj4g
QEAgLTMzLDYgKzMzLDkgQEAgc3RhdGljIHZvaWQgdGVncmFfZHJtX2NoYW5uZWxfY29udGV4dF9j
bG9zZShzdHJ1Y3QKPj4+PiB0ZWdyYV9kcm1fY29udGV4dCAqY29udGV4dCkKPj4+PiAgwqDCoMKg
wqDCoCBzdHJ1Y3QgdGVncmFfZHJtX21hcHBpbmcgKm1hcHBpbmc7Cj4+Pj4gIMKgwqDCoMKgwqAg
dW5zaWduZWQgbG9uZyBpZDsKPj4+PiAgwqAgK8KgwqDCoCBpZiAoY29udGV4dC0+bWVtb3J5X2Nv
bnRleHQpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGhvc3QxeF9jb250ZXh0X3B1dChjb250ZXh0LT5t
ZW1vcnlfY29udGV4dCk7Cj4+Pgo+Pj4gVGhlICJpZiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQg
JiYKPj4+IGNvbnRleHQtPmNsaWVudC0+b3BzLT5nZXRfc3RyZWFtaWRfb2Zmc2V0KSIgYWJvdmUg
ZG9lc24ndCBtYXRjaCB0aGUgImlmCj4+PiAoY29udGV4dC0+bWVtb3J5X2NvbnRleHQpIi4gWW91
J2xsIGdldCByZWZjb3VudCB1bmRlcmZsb3cuCj4+Cj4+IEFuZCB0aGlzIGRyb3AgaXMgZm9yIHRo
ZSByZWZjb3VudCBpbXBsaWNpdGx5IGFkZGVkIHdoZW4gYWxsb2NhdGluZyB0aGUKPj4gbWVtb3J5
IGNvbnRleHQgdGhyb3VnaCBob3N0MXhfY29udGV4dF9hbGxvYzsgc28gdGhlc2UgdHdvIHBsYWNl
cyBzaG91bGQKPj4gYmUgaW5kZXBlbmRlbnQuCj4+Cj4+IFBsZWFzZSBlbGFib3JhdGUgaWYgSSBt
aXNzZWQgc29tZXRoaW5nLgo+IAo+IFlvdSBuYW1lZCBjb250ZXh0IGFzIG1lbW9yeV9jb250ZXh0
IGFuZCB0aGVuIGhhdmUKPiBjb250ZXh0PWNvbnRleHQtPm1lbW9yeV9jb250ZXh0LiBQbGVhc2Ug
dHJ5IHRvIGltcHJvdmUgdGhlIHZhcmlhYmxlCj4gbmFtZXMsIGxpa2UgZHJtX2N0eC0+aG9zdDF4
X2N0eCBmb3IgZXhhbXBsZS4KPiAKPiBJJ20gYWxzbyBub3QgYSBiaWcgZmFuIG9mIHRoZSAiaWYg
KHJlZikgcHV0KHJlZikiIHBhdHRlcm4uIFdvbid0IGJlCj4gYmV0dGVyIHRvIG1vdmUgYWxsIHRo
ZSAiaWYgKCFOVUxMKSIgY2hlY2tzIGluc2lkZSBvZiBnZXQoKS9wdXQoKSBhbmQKPiBtYWtlIHRo
ZSBpbnZvY2F0aW9ucyB1bmNvbmRpdGlvbmFsPwoKSSBhZ3JlZSB0aGF0IHRoZSBuYW1pbmcgaGVy
ZSBpcyBjb25mdXNpbmcgd2l0aCBkaWZmZXJlbnQga2luZHMgb2YgCmNvbnRleHRzIGZseWluZyBh
cm91bmQsIHRob3VnaCBJIHdvdWxkIHByZWZlciBub3QgdG8gY2hhbmdlIHRoZSBvcmlnaW5hbCAK
J3N0cnVjdCB0ZWdyYV9kcm1fY29udGV4dCAqY29udGV4dCcgc2luY2UgaXQncyB1c2VkIGFsbCBh
cm91bmQgdGhlIGNvZGUuIApCdXQgSSdsbCB0cnkgdG8gbWFrZSBpdCBjbGVhcmVyLgoKUmVnYXJk
aW5nIG1vdmluZyBOVUxMIGNoZWNrcyBpbnNpZGUgZ2V0L3B1dCwgSSBwZXJzb25hbGx5IGRpc2xp
a2UgdGhhdCAKcGF0dGVybiAoYWxzbyB3aXRoIGUuZy4ga2ZyZWUpIHNpbmNlIHdoZW4gcmVhZGlu
ZyB0aGUgY29kZSwgaXQgbWFrZXMgaXQgCm1vcmUgZGlmZmljdWx0IHRvIHNlZSB0aGF0IHRoZSBw
b2ludGVyIGNhbiBiZSBOVUxMLgoKTWlra28KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
