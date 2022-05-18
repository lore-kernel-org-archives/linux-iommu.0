Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23212C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 11:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C966883FC7;
	Wed, 18 May 2022 11:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CepmeHBocLjQ; Wed, 18 May 2022 11:42:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB98883FFB;
	Wed, 18 May 2022 11:42:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71526C0039;
	Wed, 18 May 2022 11:42:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40E14C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 258AC611C8
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cx9w37DFoFBt for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 11:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22736611A9
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:42:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 8C8FD1F44EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652874144;
 bh=qf83SX+V7kjrLVMgax0hyCtsQnOzDUfXGrMJugntals=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eCcwRurnQ+5GicCiLUfL2+f27Skpz0cRymPx++02Gs/+Bm9y8LvMU+6E4zFbDOBbB
 aDxYHbubVrbCA+S5TsXAoq4U9wHNl9b0zGYGbzhdodANtmEmBbhrYx9e+w3rh5TOFb
 Vyps2S9Wcz1EzWXTa9lJTlDZFDQkW3J3QJ9bGZjEJEc85hByE99hCsirLDdS7SoW0w
 B66eXlc+ED801BFn9pFvgK96TKw7BuU6+8dsSUCijtBn62fPvpsJc8uT9XlYafrff6
 yV7b+39Yhj9HoBc5e05dpy412rFo6AmY0TE60FsflL/CVdY2d2PZVklvXG9KaoqU2t
 FAGEC8vUE9EJw==
Message-ID: <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
Date: Wed, 18 May 2022 13:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
 <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SWwgMTgvMDUvMjIgMTM6MjksIE1hdHRoaWFzIEJydWdnZXIgaGEgc2NyaXR0bzoKPiAKPiAKPiBP
biAxOC8wNS8yMDIyIDEyOjA0LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToKPj4g
QWRkIHByb3BlcnRpZXMgIm1lZGlhdGVrLGluZnJhY2ZnIiBhbmQgIm1lZGlhdGVrLHBlcmljZmci
IHRvIGxldCB0aGUKPj4gbXRrX2lvbW11IGRyaXZlciByZXRyaWV2ZSBwaGFuZGxlcyB0byB0aGUg
aW5mcmFjZmcgYW5kIHBlcmljZmcgc3lzY29uKHMpCj4+IGluc3RlYWQgb2YgcGVyZm9ybWluZyBh
IHBlci1zb2MgY29tcGF0aWJsZSBsb29rdXAuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+Cj4+IC0tLQo+PiDCoCAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxp
b21tdS55YW1swqDCoMKgwqDCoMKgwqDCoCB8IDggKysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwgCj4+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwKPj4gaW5k
ZXggMmFlM2JiYWQ3ZjFhLi5jNGFmNDE5NDc1OTMgMTAwNjQ0Cj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55
YW1sCj4+IEBAIC0xMDEsNiArMTAxLDEwIEBAIHByb3BlcnRpZXM6Cj4+IMKgwqDCoMKgwqAgaXRl
bXM6Cj4+IMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IGJjbGsKPj4gK8KgIG1lZGlhdGVrLGluZnJh
Y2ZnOgo+PiArwqDCoMKgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Bo
YW5kbGUKPj4gK8KgwqDCoCBkZXNjcmlwdGlvbjogVGhlIHBoYW5kbGUgdG8gdGhlIG1lZGlhdGVr
IGluZnJhY2ZnIHN5c2Nvbgo+PiArCj4+IMKgwqDCoCBtZWRpYXRlayxsYXJiczoKPj4gwqDCoMKg
wqDCoCAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5
Cj4+IMKgwqDCoMKgwqAgbWluSXRlbXM6IDEKPj4gQEAgLTExMiw2ICsxMTYsMTAgQEAgcHJvcGVy
dGllczoKPj4gwqDCoMKgwqDCoMKgwqAgUmVmZXIgdG8gYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xs
ZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwuIEl0IG11c3Qgc29ydAo+PiDCoMKgwqDCoMKgwqDC
oCBhY2NvcmRpbmcgdG8gdGhlIGxvY2FsIGFyYml0ZXIgaW5kZXgsIGxpa2UgbGFyYjAsIGxhcmIx
LCBsYXJiMi4uLgo+PiArwqAgbWVkaWF0ZWsscGVyaWNmZzoKPj4gK8KgwqDCoCAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlCj4+ICvCoMKgwqAgZGVzY3JpcHRp
b246IFRoZSBwaGFuZGxlIHRvIHRoZSBtZWRpYXRlayBwZXJpY2ZnIHN5c2Nvbgo+PiArCj4gCj4g
SSBkaWRuJ3QgZXhwbGFpbiBteXNlbGYuIFdoYXQgSSB3YXMgc3VndWVzdGluZyB3YXMgdG8gc3F1
YXNoIHRoZSBwYXRjaCB0aGF0IGFkZCAKPiByZXF1aWVyZWQgbWVkaWF0ZWssaW5mcmFjZmcgd2l0
aCB0aGUgcGF0Y2ggdGhhdCBhZGRzIG1lZGlhdGssaW5mcmFjZmcgdG8gdGhlIAo+IGJpbmRpbmcg
ZGVzY3JpcHRpb24uIEFuZCB0aGVuIHNxdWFzaCB0aGUgYm90aCBwYXRjaGVzIGFkZGluZyBwZXJp
Y2ZnIGFzIHdlbGwuCgpTb3JyeSBNYXR0aGlhcywgSSdtIG5vdCBzdXJlIC4uLiBJIHRoaW5rIEkn
bSBtaXN1bmRlcnN0YW5kaW5nIHlvdSBhZ2Fpbi4uLgouLi5idXQgaWYgSSdtIG5vdCwgSSBkb24n
dCB0aGluayB0aGF0IHNxdWFzaGluZyBhY3R1YWwgY29kZSBhbmQgYmluZGluZ3MgdG9nZXRoZXIK
aXMgc29tZXRoaW5nIGFjY2VwdGFibGU/CgpJJ3ZlIG1hZGUgdGhhdCBraW5kIG9mIG1pc3Rha2Ug
aW4gdGhlIHBhc3QgYW5kIEkgd2FzIHRvbGQgbXVsdGlwbGUgdGltZXMgdGhhdApkdC1iaW5kaW5n
cyBjaGFuZ2VzIHNoYWxsIGJlIHNlbnQgc2VwYXJhdGVseSBmcm9tIHRoZSBhY3R1YWwgZHJpdmVy
IGNoYW5nZXMuCgpDaGVlcnMsCkFuZ2VsbwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
