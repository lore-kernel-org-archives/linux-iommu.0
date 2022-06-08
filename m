Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF81FC43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 11:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 483F184213;
	Wed,  8 Jun 2022 11:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IrJB9bj3uKT8; Wed,  8 Jun 2022 11:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 10C3183DF1;
	Wed,  8 Jun 2022 11:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D426AC0039;
	Wed,  8 Jun 2022 11:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0814C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 11:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B73FC6109C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 11:03:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NXCtkfXK0KOE for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 11:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3669F61089
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 11:03:21 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 901E566016FD;
 Wed,  8 Jun 2022 12:03:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1654686197;
 bh=rFzcWUsWEhZ5a2h/qAW0YZxnMQx08NX5sEO/CaAZHwY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GIVKw8FrdL+nDZ77LqwwlCHLGA9EvGE3PaE4jeVQpLtqYJl6BA1aZNJssNr6jEaUi
 miY2V8Ui+66FOEfr2CFddTDBhIQQbVkr5QpKaENEEV5n3EjltAzUCXM328H6nryJ4u
 lyZB1muOegm2OA2ATe45VQRNboB5rnyqnOK75Ku1zjaXzYWubWBkNbNk3Tj2D5LrY2
 pD/g0zfUUP1nffU1Gy2MLJKdqQ4ZJT1wBKoRQCKBswLhtdJmxSS2yLhMJe6onlDxkd
 q4tD5kHp85lFcEYxji3vzh9znRB+v/zWno8xAZ5x7dggMcuS+5oCSQUvYS7O/PKR+s
 9dJBUXIpN6H6w==
Message-ID: <24931967-87be-5207-eb2b-47c064aee0c7@collabora.com>
Date: Wed, 8 Jun 2022 13:03:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access
 behavior
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, Will Deacon <will@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-3-konrad.dybcio@somainline.org>
 <20220531155559.GB25502@willie-the-truck>
 <20220605220618.n6rkb6cfdzzgst3j@SoMainline.org>
 <1930a7b3-3637-9e3b-3dac-7baf034c7b7a@collabora.com>
 <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4911a6c8-e494-5a5e-015d-d9fcf886d253@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, martin.botka@somainline.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, linux-arm-kernel@lists.infradead.org
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

SWwgMDgvMDYvMjIgMTI6NTQsIFJvYmluIE11cnBoeSBoYSBzY3JpdHRvOgo+IE9uIDIwMjItMDYt
MDggMTE6MjcsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOgo+PiBJbCAwNi8wNi8y
MiAwMDowNiwgTWFyaWpuIFN1aWp0ZW4gaGEgc2NyaXR0bzoKPj4+IE9uIDIwMjItMDUtMzEgMTY6
NTU6NTksIFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4+IE9uIEZyaSwgTWF5IDI3LCAyMDIyIGF0IDEx
OjI4OjU3UE0gKzAyMDAsIEtvbnJhZCBEeWJjaW8gd3JvdGU6Cj4+Pj4+IEZyb206IEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQHNvbWFpbmxpbmUu
b3JnPgo+Pj4+Pgo+Pj4+PiBBcyBhbHNvIHN0YXRlZCBpbiB0aGUgYXJtLXNtbXUgZHJpdmVyLCB3
ZSBtdXN0IHdyaXRlIHRoZSBUQ1IgYmVmb3JlCj4+Pj4+IHdyaXRpbmcgdGhlIFRUQlJzLCBzaW5j
ZSB0aGUgVENSIGRldGVybWluZXMgdGhlIGFjY2VzcyBiZWhhdmlvciBvZgo+Pj4+PiBzb21lIGZp
ZWxkcy4KPj4+Pgo+Pj4+IFdoZXJlIGlzIHRoaXMgc3RhdGVkIGluIHRoZSBhcm0tc21tdSBkcml2
ZXI/Cj4+Pj4KPj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwg
UmVnbm8gCj4+Pj4+IDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQHNvbWFpbmxpbmUub3JnPgo+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJpam4gU3VpanRlbiA8bWFyaWpuLnN1aWp0ZW5Ac29tYWlu
bGluZS5vcmc+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEtvbnJhZCBEeWJjaW8gPGtvbnJhZC5keWJj
aW9Ac29tYWlubGluZS5vcmc+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS9xY29tX2lvbW11LmMgfCAxMiArKysrKystLS0tLS0KPj4+Pj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4+Pj4KPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L3Fjb21faW9tbXUuYyAKPj4+Pj4gYi9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9xY29tX2lvbW11LmMKPj4+Pj4gaW5kZXggMTcyOGQ0
ZDdmZTI1Li43NWYzNTM4NjZjNDAgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11L3Fjb21faW9tbXUuYwo+Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0t
c21tdS9xY29tX2lvbW11LmMKPj4+Pj4gQEAgLTI3MywxOCArMjczLDE4IEBAIHN0YXRpYyBpbnQg
cWNvbV9pb21tdV9pbml0X2RvbWFpbihzdHJ1Y3QgaW9tbXVfZG9tYWluIAo+Pj4+PiAqZG9tYWlu
LAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHgtPnNlY3VyZV9pbml0ID0gdHJ1
ZTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIC8qIFRU
QlJzICovCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpb21tdV93cml0ZXEoY3R4LCBBUk1fU01NVV9D
Ql9UVEJSMCwKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwZ3RibF9jZmcu
YXJtX2xwYWVfczFfY2ZnLnR0YnIgfAo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEZJRUxEX1BSRVAoQVJNX1NNTVVfVFRCUm5fQVNJRCwgY3R4LT5hc2lkKSk7Cj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBpb21tdV93cml0ZXEoY3R4LCBBUk1fU01NVV9DQl9UVEJSMSwgMCk7Cj4+
Pj4+IC0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFRDUiAqLwo+Pj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaW9tbXVfd3JpdGVsKGN0eCwgQVJNX1NNTVVfQ0JfVENSMiwKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcm1fc21tdV9scGFlX3RjcjIoJnBndGJsX2Nm
ZykpOwo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXVfd3JpdGVsKGN0eCwgQVJNX1NNTVVf
Q0JfVENSLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtX3Nt
bXVfbHBhZV90Y3IoJnBndGJsX2NmZykgfCBBUk1fU01NVV9UQ1JfRUFFKTsKPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIC8qIFRUQlJzICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV93cml0ZXEo
Y3R4LCBBUk1fU01NVV9DQl9UVEJSMCwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwZ3RibF9jZmcuYXJtX2xwYWVfczFfY2ZnLnR0YnIgfAo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEZJRUxEX1BSRVAoQVJNX1NNTVVfVFRCUm5fQVNJRCwgY3R4LT5h
c2lkKSk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV93cml0ZXEoY3R4LCBBUk1fU01NVV9D
Ql9UVEJSMSwgMCk7Cj4+Pj4KPj4+PiBJJ2QgaGF2ZSB0aG91Z2h0IHRoYXQgU0NUTFIuTSB3b3Vs
ZCBiZSBjbGVhciBoZXJlLCBzbyBpdCBzaG91bGRuJ3QgbWF0dGVyCj4+Pj4gd2hhdCBvcmRlciB3
ZSB3cml0ZSB0aGVzZSBpbi4KPj4+Cj4+PiBIYXZpbmcgdGVzdGVkIHRoZSBzZXJpZXMgd2l0aG91
dCB0aGlzIHBhcnRpY3VsYXIgcGF0Y2ggb24gODk3NiAoU29ueQo+Pj4gTG9pcmUgU3V6dSksIGl0
IGRvZXNuJ3Qgc2VlbSB0byBtYXR0ZXIgaW5kZWVkLsKgIEknbGwgYXNrIGFyb3VuZCBpZiB0aGlz
Cj4+PiAiYWNjZXNzIGJlaGF2aW91ciIgd2FzIG9ic2VydmVkIG9uIGEgZGlmZmVyZW50IGJvYXJk
L3BsYXRmb3JtLgo+Pj4KPj4+IC0gTWFyaWpuCj4+Cj4+IE9uIHNvbWUgcGxhdGZvcm1zLCB0aGUg
Ym9vdGxvYWRlciAoYW5kL29yIHRoZSBoeXBlcnZpc29yKSBpcyBwZXJmb3JtaW5nIHNvbWUKPj4g
aW5pdGlhbGl6YXRpb24gb2YgdGhlIElPTU1VIHdoaWNoLCBkZXBlbmRpbmcgb24gdGhlIGFjdHVh
bCBmaXJtd2FyZSB2ZXJzaW9uCj4+IHRoYXQgcmFuIGJlZm9yZSBib290aW5nIExpbnV4LCBtYXkg
b3IgbWF5IG5vdCBsZWF2ZSBTQ1RMUi5NIGNsZWFyZWQuCj4gCj4gQnV0IGRvZXMgaXQgYWN0dWFs
bHkgbWF0dGVyIGV2ZW4gdGhlbj8gSWYgd2UncmUgb25seSBhbGxvd2VkIHRvIHByb2dyYW0gdGhl
IHNhbWUgCj4gQVNJRCB0aGF0IHdhcyBpbiB1c2UgYmVmb3JlaGFuZCwgdGhlbiBsb2dpY2FsbHkg
d2UgY2FuJ3QgYmUgY2hhbmdpbmcgVENSMi5BUyBpbiBhIAo+IHdheSB0aGF0IG1ha2VzIGFueSBk
aWZmZXJlbmNlIGFueXdheS4KPiAKPiBJIHNlZSBubyBwb2ludCBpbiBwcmV0ZW5kaW5nIHRvIHdv
cnJ5IGFib3V0IHRoZW9yZXRpY2FsIGFyY2hpdGVjdHVyYWwgY29ycmVjdG5lc3MgCj4gaW4gYSBk
cml2ZXIgdGllZCB0byBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbnMgdGhhdCBhbHJlYWR5IHZpb2xh
dGUgdGhlIGdpdmVuIAo+IGFyY2hpdGVjdHVyZSBpbiBtYW55IG90aGVyIHdheXMuIElmIHRoZXJl
J3MgYSBrbm93biBmaXJtd2FyZSBpbXBsZW1lbnRhdGlvbiB0aGF0IAo+IGRlZmluaXRlbHkgcmVx
dWlyZXMgdGhpcywgdGhhdCBzaG91bGQgYmUgY2FsbGVkIG91dDsgb3RoZXJ3aXNlLCB0aGVyZSBk
b2Vzbid0IHNlZW0gCj4gbXVjaCBqdXN0aWZpY2F0aW9uIGZvciB0aGUgcGF0Y2ggYXQgYWxsLgo+
IAoKVGhpcyBpcyBzb21ldGhpbmcgSSB3cm90ZSBtb3JlIHRoYW4gb25lIHllYXIgYWdvLCBoZW5j
ZSBJIGRvbid0IHJlbWVtYmVyIGNsZWFybHksCmJ1dCBpZiBteSBtZW1vcmllcyBhcmVuJ3QgZmFp
bGluZyBtZSwgdGhpcyB3YXMgbmVjZXNzYXJ5IHRvIGVuYWJsZSBzdXBwb3J0IGZvcgp0aGUgQUFy
Y2g2NCBwYWdldGFibGVzLgpJZiB0aGF0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byB5b3UsIEkgZ3Vl
c3MgdGhhdCBNYXJpam4gb3IgS29ucmFkIGNhbiBoZWxwIHRlc3RpbmcKc3dpdGNoaW5nIHRvIEFB
NjQgUFQgd2l0aCB0aGUgaW5jb3JyZWN0IHByb2dyYW1taW5nIHNlcXVlbmNlLgoKQXNpZGUgZnJv
bSB0aGF0LCBhcyBhIHN0cmljdGx5IHBlcnNvbmFsIG9waW5pb24gKGFuZCBub3RoaW5nIGVsc2Up
LCBJIHRoaW5rIHRoYXQKZW5zdXJpbmcgYXJjaGl0ZWN0dXJhbCBjb3JyZWN0bmVzcyAqd2hlcmUg
cG9zc2libGUqIGNhbiBvbmx5IGJlIGdvb2Q6IEkgZG9uJ3Qgc2VlCndoeSB3ZSBzaG91bGQgaW50
ZW50aW9uYWxseSBrZWVwIGEgd3JvbmcgcHJvZ3JhbW1pbmcgc2VxdWVuY2UgaW4gcHJpbmNpcGxl
LgoKUmVnYXJkcywKQW5nZWxvCgo+IFRoYW5rcywKPiBSb2Jpbi4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
