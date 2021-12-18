Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E11C433EF
	for <iommu@archiver.kernel.org>; Sat, 18 Dec 2021 06:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1927C84DD3;
	Sat, 18 Dec 2021 06:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckGKarUKAfME; Sat, 18 Dec 2021 06:55:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A78A284DD1;
	Sat, 18 Dec 2021 06:55:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C3C1C002F;
	Sat, 18 Dec 2021 06:55:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6DFEC0012
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 06:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF1134062F
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 06:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GZxMkLgZbllX for <iommu@lists.linux-foundation.org>;
 Sat, 18 Dec 2021 06:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3707840010
 for <iommu@lists.linux-foundation.org>; Sat, 18 Dec 2021 06:55:31 +0000 (UTC)
Received: from [192.168.1.18] ([86.243.171.122]) by smtp.orange.fr with ESMTPA
 id yTctmAwLisoWhyTctm8zt5; Sat, 18 Dec 2021 07:55:29 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 18 Dec 2021 07:55:29 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
To: Lu Baolu <baolu.lu@linux.intel.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org
References: <367914663187b8fe043e31b352cd6ad836088f0a.1639778255.git.christophe.jaillet@wanadoo.fr>
 <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <935af038-1b75-2717-40fa-e2e7858ed09e@wanadoo.fr>
Date: Sat, 18 Dec 2021 07:55:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <73bdc4a3-6028-2ab5-f9a6-dbad15effad4@linux.intel.com>
Content-Language: fr
Cc: iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

TGUgMTgvMTIvMjAyMSDDoCAwNjo1NiwgTHUgQmFvbHUgYSDDqWNyaXTCoDoKPiBPbiAyMDIxLzEy
LzE4IDU6NTgsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToKPj4gJ29tbXUtPmRvbWFpbl9pZHMn
IGlzIGEgYml0bWFwLiBTbyB1c2UgJ2JpdG1hcF96YWxsb2MoKScgdG8gc2ltcGxpZnkKPj4gY29k
ZSBhbmQgaW1wcm92ZSB0aGUgc2VtYW50aWMsIGluc3RlYWQgb2YgaGFuZCB3cml0aW5nIGl0Lgo+
Pgo+PiBBbHNvIGNoYW5nZSB0aGUgY29ycmVzcG9uZGluZyAna2ZyZWUoKScgaW50byAnYml0bWFw
X2ZyZWUoKScgdG8ga2VlcAo+PiBjb25zaXN0ZW5jeS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4KPj4gLS0tCj4+
IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDkgKysrKy0tLS0tCj4+IMKgIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMKPj4gaW5kZXggYjZhOGYzMjgyNDExLi40YWNjOTc3NjUyMDkgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmMKPj4gQEAgLTE4NzgsMTcgKzE4NzgsMTYgQEAgc3RhdGljIHZvaWQgaW9tbXVfZGlz
YWJsZV90cmFuc2xhdGlvbihzdHJ1Y3QgCj4+IGludGVsX2lvbW11ICppb21tdSkKPj4gwqAgc3Rh
dGljIGludCBpb21tdV9pbml0X2RvbWFpbnMoc3RydWN0IGludGVsX2lvbW11ICppb21tdSkKPj4g
wqAgewo+PiAtwqDCoMKgIHUzMiBuZG9tYWlucywgbmxvbmdzOwo+PiArwqDCoMKgIHUzMiBuZG9t
YWluczsKPj4gwqDCoMKgwqDCoCBzaXplX3Qgc2l6ZTsKPj4gwqDCoMKgwqDCoCBuZG9tYWlucyA9
IGNhcF9uZG9tcyhpb21tdS0+Y2FwKTsKPj4gwqDCoMKgwqDCoCBwcl9kZWJ1ZygiJXM6IE51bWJl
ciBvZiBEb21haW5zIHN1cHBvcnRlZCA8JWQ+XG4iLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
b21tdS0+bmFtZSwgbmRvbWFpbnMpOwo+PiAtwqDCoMKgIG5sb25ncyA9IEJJVFNfVE9fTE9OR1Mo
bmRvbWFpbnMpOwo+PiDCoMKgwqDCoMKgIHNwaW5fbG9ja19pbml0KCZpb21tdS0+bG9jayk7Cj4+
IC3CoMKgwqAgaW9tbXUtPmRvbWFpbl9pZHMgPSBrY2FsbG9jKG5sb25ncywgc2l6ZW9mKHVuc2ln
bmVkIGxvbmcpLCAKPj4gR0ZQX0tFUk5FTCk7Cj4+ICvCoMKgwqAgaW9tbXUtPmRvbWFpbl9pZHMg
PSBiaXRtYXBfemFsbG9jKG5kb21haW5zLCBHRlBfS0VSTkVMKTsKPj4gwqDCoMKgwqDCoCBpZiAo
IWlvbW11LT5kb21haW5faWRzKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07
Cj4+IEBAIC0xOTAzLDcgKzE5MDIsNyBAQCBzdGF0aWMgaW50IGlvbW11X2luaXRfZG9tYWlucyhz
dHJ1Y3QgaW50ZWxfaW9tbXUgCj4+ICppb21tdSkKPj4gwqDCoMKgwqDCoCBpZiAoIWlvbW11LT5k
b21haW5zIHx8ICFpb21tdS0+ZG9tYWluc1swXSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJf
ZXJyKCIlczogQWxsb2NhdGluZyBkb21haW4gYXJyYXkgZmFpbGVkXG4iLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdS0+bmFtZSk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBr
ZnJlZShpb21tdS0+ZG9tYWluX2lkcyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBiaXRtYXBfZnJlZShp
b21tdS0+ZG9tYWluX2lkcyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShpb21tdS0+ZG9t
YWlucyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdS0+ZG9tYWluX2lkcyA9IE5VTEw7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdS0+ZG9tYWluc8KgwqDCoCA9IE5VTEw7Cj4+IEBAIC0x
OTY0LDcgKzE5NjMsNyBAQCBzdGF0aWMgdm9pZCBmcmVlX2RtYXJfaW9tbXUoc3RydWN0IGludGVs
X2lvbW11IAo+PiAqaW9tbXUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwg
ZWxlbXM7IGkrKykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoaW9tbXUtPmRv
bWFpbnNbaV0pOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAga2ZyZWUoaW9tbXUtPmRvbWFpbnMpOwo+
PiAtwqDCoMKgwqDCoMKgwqAga2ZyZWUoaW9tbXUtPmRvbWFpbl9pZHMpOwo+PiArwqDCoMKgwqDC
oMKgwqAgYml0bWFwX2ZyZWUoaW9tbXUtPmRvbWFpbl9pZHMpOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgaW9tbXUtPmRvbWFpbnMgPSBOVUxMOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9tbXUtPmRv
bWFpbl9pZHMgPSBOVUxMOwo+PiDCoMKgwqDCoMKgIH0KPiAKPiBUaGlzIHBhdGNoIGhhcyBiZWVu
IG1lcmdlZCB0byBKb2VyZydzIHRyZWUgdGhyb3VnaAo+IAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlvbW11LzIwMjExMjE3MDgzODE3LjE3NDU0MTktMi1iYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20vIAo+IAo+IAo+IEFyZSB0aGVyZSBhbnkgZXh0cmEgY2hhbmdlcyBpbiB0aGlzIG9u
ZT8KCk5vLCB0aGlzIGlzIHRoZSBzYW1lLiBTb3JyeSBmb3IgdGhlIGR1cGxpY2F0ZS4KCkNKCgo+
IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
