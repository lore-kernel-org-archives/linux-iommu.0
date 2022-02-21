Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A1CC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 17:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAEFF606AA;
	Mon, 21 Feb 2022 17:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1h8J4sSfCnE; Mon, 21 Feb 2022 17:36:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8123860674;
	Mon, 21 Feb 2022 17:36:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C62BC001A;
	Mon, 21 Feb 2022 17:36:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39FD4C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 17:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27DBA81437
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 17:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDDYYwvD9zcw for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 17:36:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5376D8146D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PkpUpGJ5fnZavlDzdbOdq/17AO+V95dcZa/mE2WXAVg=; b=NY4d56ipV+ocFh5z0mNXf4EUne
 0cybsnz+sCoMyNGGmrBQAF3IztUaD4VTsdgx3LQjBi4E4Kx6kty0oDhd81IngYd5FWuvuDAL4+kgu
 R9SntmnlQl8dPHbaAW/Hs56NWT/CI6btDP3MeORUQEe3u4D/L3eFkQ/SeNsvg9ienk5G+9X7nyq3n
 mNGMmY0u90eqfUddJbp7AVkc74mGY372hpeAo3GbU4sjBvd4jmCnC2XsfqUlpz/0QHcI9szjyxG8v
 QpIJ6gyG8M9cC0eSIZRxljwFXf0fMFGHXnzqnoy7vI0ZngkKYanPfVYSr3DwcFwJGC69NqWoCJy1S
 P7D0XKBQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nMCbW-0002UU-8v; Mon, 21 Feb 2022 19:36:06 +0200
Message-ID: <6be67fc4-3343-123e-5dc3-d45f51f42624@kapsi.fi>
Date: Mon, 21 Feb 2022 19:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <71e94ac3-20fc-6f41-270f-fe246740e7e0@arm.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <71e94ac3-20fc-6f41-270f-fe246740e7e0@arm.com>
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

T24gMi8yMS8yMiAxOToyNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDItMTggMTE6
MzksIE1pa2tvIFBlcnR0dW5lbiB2aWEgaW9tbXUgd3JvdGU6Cj4+IEltcGxlbWVudCB0aGUgZ2V0
X3N0cmVhbWlkX29mZnNldCByZXF1aXJlZCBmb3Igc3VwcG9ydGluZyBjb250ZXh0Cj4+IGlzb2xh
dGlvbi4gU2luY2Ugb2xkIGZpcm13YXJlIGNhbm5vdCBzdXBwb3J0IGNvbnRleHQgaXNvbGF0aW9u
Cj4+IHdpdGhvdXQgaGFja3MgdGhhdCB3ZSBkb24ndCB3YW50IHRvIGltcGxlbWVudCwgY2hlY2sg
dGhlIGZpcm13YXJlCj4+IGJpbmFyeSB0byBzZWUgaWYgY29udGV4dCBpc29sYXRpb24gc2hvdWxk
IGJlIGVuYWJsZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE1pa2tvIFBlcnR0dW5lbiA8bXBlcnR0
dW5lbkBudmlkaWEuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3ZpYy5j
IHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3RlZ3JhL3ZpYy5jIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3ZpYy5jCj4+IGluZGV4IDFl
MzQyZmEzZDI3Yi4uMjg2M2VlNWUwZTY3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
dGVncmEvdmljLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3ZpYy5jCj4+IEBAIC0z
OCw2ICszOCw4IEBAIHN0cnVjdCB2aWMgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBjbGsgKmNsazsK
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0Owo+PiArwqDCoMKgIGJvb2wg
Y2FuX3VzZV9jb250ZXh0Owo+PiArCj4+IMKgwqDCoMKgwqAgLyogUGxhdGZvcm0gY29uZmlndXJh
dGlvbiAqLwo+PiDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB2aWNfY29uZmlnICpjb25maWc7Cj4+
IMKgIH07Cj4+IEBAIC0yMjksNiArMjMxLDcgQEAgc3RhdGljIGludCB2aWNfbG9hZF9maXJtd2Fy
ZShzdHJ1Y3QgdmljICp2aWMpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaG9zdDF4X2Ns
aWVudCAqY2xpZW50ID0gJnZpYy0+Y2xpZW50LmJhc2U7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHRl
Z3JhX2RybSAqdGVncmEgPSB2aWMtPmNsaWVudC5kcm07Cj4+ICvCoMKgwqAgdTMyIGZjZV9iaW5f
ZGF0YV9vZmZzZXQ7Cj4+IMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBpb3ZhOwo+PiDCoMKgwqDCoMKg
IHNpemVfdCBzaXplOwo+PiDCoMKgwqDCoMKgIHZvaWQgKnZpcnQ7Cj4+IEBAIC0yNzcsNiArMjgw
LDI1IEBAIHN0YXRpYyBpbnQgdmljX2xvYWRfZmlybXdhcmUoc3RydWN0IHZpYyAqdmljKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgdmljLT5mYWxjb24uZmlybXdhcmUucGh5cyA9IHBoeXM7Cj4+IMKg
wqDCoMKgwqAgfQo+PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIENoZWNrIGlmIGZpcm13YXJl
IGlzIG5ldyBlbm91Z2ggdG8gbm90IHJlcXVpcmUgbWFwcGluZyBmaXJtd2FyZQo+PiArwqDCoMKg
wqAgKiB0byBkYXRhIGJ1ZmZlciBkb21haW5zLgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDCoCBm
Y2VfYmluX2RhdGFfb2Zmc2V0ID0gKih1MzIgKikodmlydCArIFZJQ19VQ09ERV9GQ0VfREFUQV9P
RkZTRVQpOwo+PiArCj4+ICvCoMKgwqAgaWYgKCF2aWMtPmNvbmZpZy0+c3VwcG9ydHNfc2lkKSB7
Cj4+ICvCoMKgwqDCoMKgwqDCoCB2aWMtPmNhbl91c2VfY29udGV4dCA9IGZhbHNlOwo+PiArwqDC
oMKgIH0gZWxzZSBpZiAoZmNlX2Jpbl9kYXRhX29mZnNldCAhPSAweDAgJiYgZmNlX2Jpbl9kYXRh
X29mZnNldCAhPSAKPj4gMHhhNWE1YTVhNSkgewo+PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBGaXJtd2FyZSB3aWxsIGFjY2VzcyBGQ0UgdGhyb3VnaCBTVFJFQU1J
RDAsIHNvIGNvbnRleHQKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBpc29sYXRpb24gY2Fubm90IGJl
IHVzZWQuCj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+ICvCoMKgwqDCoMKgwqDCoCB2aWMtPmNh
bl91c2VfY29udGV4dCA9IGZhbHNlOwo+PiArwqDCoMKgwqDCoMKgwqAgZGV2X3dhcm5fb25jZSh2
aWMtPmRldiwgImNvbnRleHQgaXNvbGF0aW9uIGRpc2FibGVkIGR1ZSB0byAKPj4gb2xkIGZpcm13
YXJlXG4iKTsKPj4gK8KgwqDCoCB9IGVsc2Ugewo+PiArwqDCoMKgwqDCoMKgwqAgdmljLT5jYW5f
dXNlX2NvbnRleHQgPSB0cnVlOwo+PiArwqDCoMKgIH0KPj4gKwo+PiDCoMKgwqDCoMKgIHJldHVy
biAwOwo+PiDCoCBjbGVhbnVwOgo+PiBAQCAtMzU4LDEwICszODAsMjYgQEAgc3RhdGljIHZvaWQg
dmljX2Nsb3NlX2NoYW5uZWwoc3RydWN0IAo+PiB0ZWdyYV9kcm1fY29udGV4dCAqY29udGV4dCkK
Pj4gwqDCoMKgwqDCoCBob3N0MXhfY2hhbm5lbF9wdXQoY29udGV4dC0+Y2hhbm5lbCk7Cj4+IMKg
IH0KPj4gK3N0YXRpYyBpbnQgdmljX2dldF9zdHJlYW1pZF9vZmZzZXQoc3RydWN0IHRlZ3JhX2Ry
bV9jbGllbnQgKmNsaWVudCkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgdmljICp2aWMgPSB0b192
aWMoY2xpZW50KTsKPj4gK8KgwqDCoCBpbnQgZXJyOwo+PiArCj4+ICvCoMKgwqAgZXJyID0gdmlj
X2xvYWRfZmlybXdhcmUodmljKTsKPj4gK8KgwqDCoCBpZiAoZXJyIDwgMCkKPj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBlcnI7Cj4+ICsKPj4gK8KgwqDCoCBpZiAodmljLT5jYW5fdXNlX2NvbnRl
eHQpCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMHgzMDsKPj4gK8KgwqDCoCBlbHNlCj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT1RTVVBQOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdGVncmFfZHJtX2NsaWVudF9vcHMgdmljX29wcyA9IHsKPj4gwqDCoMKgwqDC
oCAub3Blbl9jaGFubmVsID0gdmljX29wZW5fY2hhbm5lbCwKPj4gwqDCoMKgwqDCoCAuY2xvc2Vf
Y2hhbm5lbCA9IHZpY19jbG9zZV9jaGFubmVsLAo+PiDCoMKgwqDCoMKgIC5zdWJtaXQgPSB0ZWdy
YV9kcm1fc3VibWl0LAo+PiArwqDCoMKgIC5nZXRfc3RyZWFtaWRfb2Zmc2V0ID0gdmljX2dldF9z
dHJlYW1pZF9vZmZzZXQsCj4gCj4gVGhlIHBhdGNoIG9yZGVyIHNlZW1zIG9mZiBoZXJlLCBzaW5j
ZSB0aGUgLmdldF9zdHJlYW1pZF9vZmZzZXQgbWVtYmVyIAo+IGlzbid0IGRlZmluZWQgeWV0Lgo+
IAo+IFJvYmluLgoKSW5kZWVkLCB3aWxsIGZpeC4KClRoYW5rcywKTWlra28KCj4gCj4+IMKgIH07
Cj4+IMKgICNkZWZpbmUgTlZJRElBX1RFR1JBXzEyNF9WSUNfRklSTVdBUkUgIm52aWRpYS90ZWdy
YTEyNC92aWMwM191Y29kZS5iaW4iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
