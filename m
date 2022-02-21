Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF27C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F092B812BE;
	Mon, 21 Feb 2022 15:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSfH3p5e1PS0; Mon, 21 Feb 2022 15:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C57E380C37;
	Mon, 21 Feb 2022 15:28:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93033C001A;
	Mon, 21 Feb 2022 15:28:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 388E1C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1965340321
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4cvIz8Tm3Ni for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:28:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1A83401E7
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=39hEWI5ykW2xTu9qYH3mEsqlbBMc93sCIWzdG3PM79U=; b=SenHRLjvOak/rcb28LFF5Xyck4
 3sbbSpzR+X1YoOQS0OPQu1XKj+4nHuEJbLTCVCBznr7MhFKcP6CG7+uxI/YmvjcKdP4r7eYwAT/fj
 tfbGVcThnbdKpofa7QogS6a7Hipu0wg3tLvFwXs5rXVY1eNE1ggkNOk4OCA5nM2Q0k2IDR+rb1Dtn
 TXIHsyPnvb/TQRDTlRp5MgmGJas3gPFfWkaFZKa5Qcx+HejlHjxYMp5Xv2gKTThZ2eYH88oLTaUQo
 NLhLSVAPYx8pp7knTJlNTB4+UfrMe8ZwpK74wKgAt9h2fhktuK3TpYdRUFA70R3UhVEC30vIia9A7
 tx/qtwwA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=[192.168.1.10])
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nMAcB-0003g1-TC; Mon, 21 Feb 2022 17:28:39 +0200
Message-ID: <2e9c4ea5-6bbd-9724-0f4e-ed25f7294aa2@kapsi.fi>
Date: Mon, 21 Feb 2022 17:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 1/9] dt-bindings: host1x: Add memory-contexts property
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-2-mperttunen@nvidia.com>
 <48ac567b-37e8-1fa2-c389-536e276fdd2c@arm.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <48ac567b-37e8-1fa2-c389-536e276fdd2c@arm.com>
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

T24gMi8yMS8yMiAxNzoyMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDItMTggMTE6
MzksIE1pa2tvIFBlcnR0dW5lbiB2aWEgaW9tbXUgd3JvdGU6Cj4+IEFkZCBzY2hlbWEgaW5mb3Jt
YXRpb24gZm9yIHRoZSBtZW1vcnktY29udGV4dHMgcHJvcGVydHkgdXNlZCB0bwo+PiBzcGVjaWZ5
IGNvbnRleHQgc3RyZWFtIElEcy4gVGhpcyB1c2VzIHRoZSBzdGFuZGFyZCBpb21tdS1tYXAgcHJv
cGVydHkKPj4gaW5zaWRlIGEgY2hpbGQgbm9kZS4KPiAKPiBDb3VsZG4ndCB5b3Ugc2ltcGx5IG1h
a2UgImlvbW11LW1hcCIgYW4gYWxsb3dlZCBwcm9wZXJ0eSBvbiB0aGUgaG9zdDF4IAo+IG5vZGUg
aXRzZWxmPyBGcm9tIGEgRFQgcGVyc3BlY3RpdmUgSSdtIG5vdCBzdXJlIHRoZSBpbnRlcm1lZGlh
dGUgbm9kZSAKPiByZWFsbHkgZml0cyBtZWFuaW5nZnVsbHksIGFuZCBJIGNhbid0IHNlZSB0aGF0
IGl0IHNlcnZlcyBtdWNoIHB1cnBvc2UgaW4gCj4gcHJhY3RpY2UgZWl0aGVyLCBvdGhlciB0aGFu
IHBlcmhhcHMgZGVmZWF0aW5nIGZ3X2RldmxpbmsuCj4gCj4gUm9iaW4uCgpUaGUgc3RyZWFtIElE
cyBkZXNjcmliZWQgaGVyZSBhcmUgbm90IHVzZWQgYnkgdGhlIGhvc3QxeCBkZXZpY2UgaXRzZWxm
LCAKc28gSSBkb24ndCB0aGluayBJIGNhbi4gSG9zdDF4J3MgbWVtb3J5IHRyYW5zYWN0aW9ucyBz
dGlsbCBnbyB0aHJvdWdoIAp0aGUgc3RyZWFtIElEIHNwZWNpZmllZCBpbiBpdHMgJ2lvbW11cycg
cHJvcGVydHksIHRoZXNlIHN0cmVhbSBJRHMgYXJlIAp1c2VkIGJ5IGVuZ2luZXMgKHR5cGljYWxs
eSBpbiBhZGRpdGlvbiB0byB0aGUgc3RyZWFtIElEIHNwZWNpZmllZCBpbiAKdGhlaXIgb3duIG5v
ZGVzKS4KCkhvc3QxeCAnaW9tbXVzJyAtLSBDaGFubmVsIGNvbW1hbmRzCkVuZ2luZSAnaW9tbXVz
JyAtLSBFbmdpbmUgZmlybXdhcmUgKGFuZCBkYXRhIGlmIGNvbnRleHQgaXNvbGF0aW9uIGlzIG5v
dCAKZW5hYmxlZCkKbWVtb3J5LWNvbnRleHRzICdpb21tdS1tYXAnIC0tIERhdGEgdXNlZCBieSBl
bmdpbmVzLgoKKFBlcmhhcHMgSSBzaG91bGQgYWRkIHRoaXMgaW5mb3JtYXRpb24gdG8gdmFyaW91
cyBwbGFjZXMgaW4gbW9yZSAKYWJ1bmRhbmNlIGFuZCBjbGFyaXR5LikKCk1pa2tvCgo+IAo+PiBT
aWduZWQtb2ZmLWJ5OiBNaWtrbyBQZXJ0dHVuZW4gPG1wZXJ0dHVuZW5AbnZpZGlhLmNvbT4KPj4g
LS0tCj4+IHYzOgo+PiAqIE5ldyBwYXRjaAo+PiAtLS0KPj4gwqAgLi4uL2JpbmRpbmdzL2Rpc3Bs
YXkvdGVncmEvbnZpZGlhLHRlZ3JhMjAtaG9zdDF4LnlhbWzCoCB8IDEwICsrKysrKysrKysKPj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCAKPj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS90ZWdyYS9udmlkaWEs
dGVncmEyMC1ob3N0MXgueWFtbCAKPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS90ZWdyYS9udmlkaWEsdGVncmEyMC1ob3N0MXgueWFtbCAKPj4KPj4gaW5kZXgg
NGZkNTEzZWZiMGY3Li4zYWMwZmRlNTRhMTYgMTAwNjQ0Cj4+IC0tLSAKPj4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS90ZWdyYS9udmlkaWEsdGVncmEyMC1ob3N0
MXgueWFtbCAKPj4KPj4gKysrIAo+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3RlZ3JhL252aWRpYSx0ZWdyYTIwLWhvc3QxeC55YW1sIAo+Pgo+PiBAQCAtMTQ0
LDYgKzE0NCwxNiBAQCBhbGxPZjoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJlc2V0LW5hbWVzOgo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1heEl0ZW1zOiAxCj4+ICvCoMKgwqDCoMKgwqDCoCBt
ZW1vcnktY29udGV4dHM6Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZTogb2JqZWN0Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllczoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW9tbXUtbWFwOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzY3JpcHRpb246IFNw
ZWNpZmljYXRpb24gb2Ygc3RyZWFtIElEcyBhdmFpbGFibGUgZm9yIAo+PiBtZW1vcnkgY29udGV4
dCBkZXZpY2UKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2UuIFNob3VsZCBi
ZSBhIG1hcHBpbmcgb2YgSURzIDAuLm4gdG8gSU9NTVUgZW50cmllcyAKPj4gY29ycmVzcG9uZGlu
ZyB0bwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzYWJsZSBzdHJlYW0gSURz
Lgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIHJlcXVpcmVkOgo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtIGlvbW11LW1hcAo+PiArCj4+IMKgwqDCoMKgwqDCoMKgIHJlcXVpcmVkOgo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgLSByZWctbmFtZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
