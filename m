Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4DFC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 12:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FF59408DA;
	Wed, 15 Jun 2022 12:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wH_yPAighSZn; Wed, 15 Jun 2022 12:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6572140AB6;
	Wed, 15 Jun 2022 12:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA2AC0032;
	Wed, 15 Jun 2022 12:28:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC2CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7870B60011
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIrSTO8mBkou for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 12:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E535607CA
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:28:27 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id C559266016CB;
 Wed, 15 Jun 2022 13:28:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655296105;
 bh=4nU9NX8b9cZ1xmaDRmhjERV+Ti0iFHjk5ZJ4I5OHFKg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e5N5JyBggQ4zs0Fz6xkG5P2lTO0eO/wPkxz+z/OFofBarb38HNedfhq9yqtAGVf9l
 0PUw9XO54LL0vF86XTinY+iAdtn0vk4Cog3WIh1GyrpJhL0kBf4f/JrH+vE8vJMuri
 pL/55G3lZaHGC1ajx5gZtMmsLmHpwR2on5Znu0b6mjMQfw8tJamf5lPTj/n2ixxjGk
 hVpxxfdyYxchxSCViNHYe/Kqhx1sSLwsAkfZyrJXGAGPpd5IG6TM/0O7yeZPiVNgvA
 ms0JorOxWEy7yJA9A1FBIPkfTl/hfpPIPWev17eGOBt0zC3COek5AMRUVVVWrKGXb3
 W0fO4VBtVmmyA==
Message-ID: <e4a2c56e-8e38-b44c-04b4-fd792fbf2f74@collabora.com>
Date: Wed, 15 Jun 2022 14:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
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

SWwgMTUvMDYvMjIgMTQ6MDksIE1hdHRoaWFzIEJydWdnZXIgaGEgc2NyaXR0bzoKPiAKPiAKPiBP
biAwOS8wNi8yMDIyIDEyOjA4LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToKPj4g
T24gc29tZSBTb0NzIChvZiB3aGljaCBvbmx5IE1UODE5NSBpcyBzdXBwb3J0ZWQgYXQgdGhlIHRp
bWUgb2Ygd3JpdGluZyksCj4+IHRoZSAiUiIgYW5kICJXIiAoSS9PKSBlbmFibGUgYml0cyBmb3Ig
dGhlIElPTU1VcyBhcmUgaW4gdGhlIHBlcmljZmdfYW8KPj4gcmVnaXN0ZXIgc3BhY2UgYW5kIG5v
dCBpbiB0aGUgSU9NTVUgc3BhY2U6IGFzIGl0IGhhcHBlbmVkIGFscmVhZHkgd2l0aAo+PiBpbmZy
YWNmZywgaXQgaXMgZXhwZWN0ZWQgdGhhdCB0aGlzIGxpc3Qgd2lsbCBncm93Lgo+Pgo+PiBJbnN0
ZWFkIG9mIHNwZWNpZnlpbmcgcGVyaWNmZyBjb21wYXRpYmxlcyBvbiBhIHBlci1Tb0MgYmFzaXMs
IGZvbGxvd2luZwo+PiB3aGF0IHdhcyBkb25lIHdpdGggaW5mcmFjZmcsIGxldCdzIGxvb2t1cCB0
aGUgc3lzY29uIGJ5IHBoYW5kbGUgaW5zdGVhZC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3Jh
LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyMyArKysrKysr
KysrKysrLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYwo+PiBpbmRleCA5MDY4NTk0NmZjYmUuLjBl
YTA4NDg1ODFlOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYwo+PiAr
KysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jCj4+IEBAIC0xMzgsNiArMTM4LDggQEAKPj4g
wqAgLyogUE0gYW5kIGNsb2NrIGFsd2F5cyBvbi4gZS5nLiBpbmZyYSBpb21tdSAqLwo+PiDCoCAj
ZGVmaW5lIFBNX0NMS19BT8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDE1KQo+PiDCoCAjZGVm
aW5lIElGQV9JT01NVV9QQ0lFX1NVUFBPUlTCoMKgwqDCoMKgwqDCoCBCSVQoMTYpCj4+ICsvKiBJ
T01NVSBJL08gKHIvdykgaXMgZW5hYmxlZCB1c2luZyBQRVJJQ0ZHX0lPTU1VXzEgcmVnaXN0ZXIg
Ki8KPj4gKyNkZWZpbmUgSEFTX1BFUklfSU9NTVUxX1JFR8KgwqDCoMKgwqDCoMKgIEJJVCgxNykK
PiAKPiAgRnJvbSB3aGF0IEkgY2FuIHNlZSBNVEtfSU9NTVVfVFlQRV9JTkZSQSBpcyBvbmx5IHNl
dCBpbiBNVDgxOTUgd2hpY2ggdXNlcyBwZXJpY2ZnLiAKPiBTbyB3ZSBkb24ndCBuZWVkIGEgbmV3
IGZsYWcgaGVyZS4gRm9yIG1lIHRoZSBmbGFnIG5hbWUgTVRLX0lPTU1VX1RZUEVfSU5GUkEgd2Fz
IAo+IGNvbmZ1c2luZyBhcyBpdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSB1c2Ugb2YgaW5m
cmFjZmcuIEknbGwgaGlqYWNrIHRoaXMgcGF0Y2ggCj4gdG8gcHJvdmlkZSBzb21lIGZlZWRiYWNr
IG9uIHRoZSBhY3R1YWwgY29kZSwgcGxlYXNlIHNlZSBiZWxvdy4KPiAKPj4gwqAgI2RlZmluZSBN
VEtfSU9NTVVfSEFTX0ZMQUdfTUFTSyhwZGF0YSwgX3gsIG1hc2spwqDCoMKgIFwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKCgocGRhdGEpLT5mbGFncykgJiAobWFzaykp
ID09IChfeCkpCj4+IEBAIC0xODcsNyArMTg5LDYgQEAgc3RydWN0IG10a19pb21tdV9wbGF0X2Rh
dGEgewo+PiDCoMKgwqDCoMKgIHUzMsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3M7Cj4+IMKg
wqDCoMKgwqAgdTMywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnZfc2VsX3JlZzsKPj4gLcKgwqDC
oCBjaGFywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqcGVyaWNmZ19jb21wX3N0cjsKPj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgbGlzdF9oZWFkwqDCoMKgICpod19saXN0Owo+PiDCoMKgwqDCoMKgIHVuc2ln
bmVkIGludMKgwqDCoMKgwqDCoMKgIGlvdmFfcmVnaW9uX25yOwo+PiDCoMKgwqDCoMKgIGNvbnN0
IHN0cnVjdCBtdGtfaW9tbXVfaW92YV9yZWdpb27CoMKgwqAgKmlvdmFfcmVnaW9uOwo+PiBAQCAt
MTIxOCwxNCArMTIxOSwxNiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91
dF9ydW50aW1lX2Rpc2FibGU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAg
fSBlbHNlIGlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5wbGF0X2RhdGEsIE1US19JT01NVV9U
WVBFX0lORlJBKSAmJgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+cGxhdF9kYXRhLT5w
ZXJpY2ZnX2NvbXBfc3RyKSB7Cj4gCj4gQ2hlY2sgZm9yIHBlcmljZmdfY29tcF9zdHIgaXMgbm90
IG5lZWRlZCwgd2Ugb25seSBoYXZlIG9uZSBwbGF0Zm9ybSB0aGF0IHVzZXMgCj4gTVRLX0lPTU1V
X1RZUEVfSU5GUkEuCj4gCgpGYWlyIGVub3VnaC4gSSBhZ3JlZS4KCj4+IC3CoMKgwqDCoMKgwqDC
oCBpbmZyYWNmZyA9IAo+PiBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKGRhdGEt
PnBsYXRfZGF0YS0+cGVyaWNmZ19jb21wX3N0cik7Cj4gCj4gV2UgY2FuIGRvIHNvbWV0aGluZyBs
aWtlIHRoaXMgdG8gbWFrZSB0aGUgY29kZSBjbGVhcmVyOgo+IGRhdGEtPnBlcmljZmcgPSBzeXNj
b25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKGRhdGEtPnBsYXRfZGF0YS0+cGVyaWNmZ19j
b21wX3N0cik7Cj4gIMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoZGF0YS0+cGVyaWNmZykpIHsK
PiAKPiBVc2luZyBpbmZyYWNmZyB2YXJpYWJsZSBoZXJlIGlzIGNvbmZ1c2luZyBhcyBpdCBoYXMg
bm90aGluZyB0byBkbyB3aXRoIGluZnJhY2ZnIAo+IHVzZWQgd2l0aCBIQVNfNEdCX01PREUgZmxh
Zy4KClllcyBNYXR0aGlhcywgdXNpbmcgdGhlIGluZnJhY2ZnIHZhcmlhYmxlIGlzIGNvbmZ1c2lu
ZyAtIHRoYXQncyB3aHkgSSBjaGFuZ2VkIHRoYXQKYWxyZWFkeS4uLi4KCj4gCj4gUmVnYXJkcywK
PiBNYXR0aGlhcwo+IAo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihpbmZyYWNmZykpIHsK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gUFRSX0VSUihpbmZyYWNmZyk7Cj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3J1bnRpbWVfZGlzYWJsZTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgIE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU19Q
RVJJX0lPTU1VMV9SRUcpKSB7CgoKCj4+ICvCoMKgwqDCoMKgwqDCoCBkYXRhLT5wZXJpY2ZnID0g
c3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShkZXYtPm9mX25vZGUsIAo+PiAibWVkaWF0
ZWsscGVyaWNmZyIpOwoKLi4uLkhlcmUsIHdoZXJlIEknbSBhc3NpZ25pbmcgZGlyZWN0bHkgdG8g
ZGF0YS0+cGVyaWNmZyA6LVAKCkJ5IHRoZSB3YXksIHNpbmNlIGl0IHdhcyBvbmx5IGFib3V0IG9u
ZSBwbGF0Zm9ybSwgbXkgaW50ZW50aW9uIHdhcyB0byByZW1vdmUgdGhlCnBlcmljZmdfY29tcF9z
dHIgZnJvbSBzdHJ1Y3QgaW9tbXVfcGxhdF9kYXRhIChhcyB5b3UgY2FuIHNlZSksIGJ1dCB0aGVu
LCB3aXRoIHRoZQpjdXJyZW50IGNvZGUsIEkgaGFkIHRvIGFzc2lnbiAuLi4uLgoKCj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoSVNfRVJSKGRhdGEtPnBlcmljZmcpKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHAgPSAibWVkaWF0ZWssbXQ4MTk1LXBlcmljZmdfYW8iOwoKLi4udGhlIHN0cmlu
ZyB0byAncCcsIGJlY2F1c2Ugb3RoZXJ3aXNlIGl0IHdvdWxkIGdvIG92ZXIgMTAwIGNvbHVtbnMu
CgpJbiBhbnkgY2FzZSwgSSBqdXN0IGNoZWNrZWQgYW5kLCBhcHBhcmVudGx5LCBNVDgxOTUgaXMg
cmVhbGx5IHRoZSBvbmUgYW5kIG9ubHkgU29DCnRoYXQgbmVlZHMgdGhpcyBwZXJpY2ZnIHJlZ2lz
dGVyIHRvIGJlIG1hbmFnZWQgYnkgTGludXguLi4gZXZlbiB0aGUgbGF0ZXN0IGFuZApncmVhdGVz
dCBzbWFydHBob25lIGNoaXAgKERpbWVuc2l0eSA5MDAwLCBNVDY5ODMpIGRvZXNuJ3QgbmVlZCB0
aGlzIChhdCBsZWFzdCwKZnJvbSB3aGF0IEkgY2FuIHJlYWQgb24gYSBkb3duc3RyZWFtIGtlcm5l
bCkuCgpPbiBhbiBhZnRlcnRob3VnaHQsIHBlcmhhcHMgdGhlIGJlc3QgaWRlYSBpcyB0byBqdXN0
IGxlYXZlIHRoaXMgYXMgaXQgaXMgYW5kLCBhcwp5b3UgcHJvcG9zZWQsIGF2b2lkIHVzaW5nIHRo
YXQgY29uZnVzaW5nIGluZnJhY2ZnIHZhcmlhYmxlLCB3aXRob3V0IGFkZGluZyB0aGUKcGVyaWNm
ZyBoYW5kbGUgYXQgYWxsLgoKQWZ0ZXIgYWxsLCBpdCdzIGp1c3Qgb25lIHNpbmdsZSBTb0MuCgpJ
J2xsIHNlbmQgYSBuZXcgdmVyc2lvbiBzb29uIQoKQ2hlZXJzLApBbmdlbG8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
