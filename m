Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64583C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 10:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE96F606BF;
	Mon, 16 May 2022 10:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6u4U0Mg73HFJ; Mon, 16 May 2022 10:44:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D973E60FFC;
	Mon, 16 May 2022 10:44:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A22D0C0032;
	Mon, 16 May 2022 10:44:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 420F5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D861826DA
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZAbwRY4ygKDl for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id B836D82784
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 10:44:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6CC1063;
 Mon, 16 May 2022 03:44:48 -0700 (PDT)
Received: from [10.57.82.175] (unknown [10.57.82.175])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849D83F66F;
 Mon, 16 May 2022 03:44:46 -0700 (PDT)
Message-ID: <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
Date: Mon, 16 May 2022 11:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device bus
Content-Language: en-GB
To: Mikko Perttunen <cyndis@kapsi.fi>, Will Deacon <will@kernel.org>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
 <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi0wNS0xNiAxMToxMywgTWlra28gUGVydHR1bmVuIHdyb3RlOgo+IE9uIDUvMTYvMjIg
MTM6MDcsIFdpbGwgRGVhY29uIHdyb3RlOgo+PiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCAxMTo1
Mjo1NEFNICswMzAwLCBjeW5kaXNAa2Fwc2kuZmkgd3JvdGU6Cj4+PiBGcm9tOiBNaWtrbyBQZXJ0
dHVuZW4gPG1wZXJ0dHVuZW5AbnZpZGlhLmNvbT4KPj4+Cj4+PiBTZXQgaXRzZWxmIGFzIHRoZSBJ
T01NVSBmb3IgdGhlIGhvc3QxeCBjb250ZXh0IGRldmljZSBidXMsIGNvbnRhaW5pbmcKPj4+ICJk
dW1teSIgZGV2aWNlcyB1c2VkIGZvciBIb3N0MXggY29udGV4dCBpc29sYXRpb24uCj4+Pgo+Pj4g
U2lnbmVkLW9mZi1ieTogTWlra28gUGVydHR1bmVuIDxtcGVydHR1bmVuQG52aWRpYS5jb20+Cj4+
PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgfCAxMyAr
KysrKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIAo+
Pj4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+PiBpbmRleCA1Njhj
Y2U1OTBjY2MuLjlmZjU0ZWFlY2Y4MSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11L2FybS1zbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L2FybS1zbW11LmMKPj4+IEBAIC0zOSw2ICszOSw3IEBACj4+PiDCoCAjaW5jbHVkZSA8bGludXgv
YW1iYS9idXMuaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9mc2wvbWMuaD4KPj4+ICsjaW5jbHVk
ZSA8bGludXgvaG9zdDF4X2NvbnRleHRfYnVzLmg+Cj4+PiDCoCAjaW5jbHVkZSAiYXJtLXNtbXUu
aCIKPj4+IEBAIC0yMDUzLDggKzIwNTQsMjAgQEAgc3RhdGljIGludCBhcm1fc21tdV9idXNfaW5p
dChzdHJ1Y3QgaW9tbXVfb3BzIAo+Pj4gKm9wcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gZXJyX3Jlc2V0X3BjaV9vcHM7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgICNlbmRp
Zgo+Pj4gKyNpZmRlZiBDT05GSUdfVEVHUkFfSE9TVDFYX0NPTlRFWFRfQlVTCj4+PiArwqDCoMKg
IGlmICghaW9tbXVfcHJlc2VudCgmaG9zdDF4X2NvbnRleHRfZGV2aWNlX2J1c190eXBlKSkgewo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IGJ1c19zZXRfaW9tbXUoJmhvc3QxeF9jb250ZXh0X2Rl
dmljZV9idXNfdHlwZSwgb3BzKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZXJyKQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmVzZXRfZnNsX21jX29wczsKPj4+ICvCoMKg
wqAgfQo+Pj4gKyNlbmRpZgo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+ICtlcnJf
cmVzZXRfZnNsX21jX29wczogX19tYXliZV91bnVzZWQ7Cj4+PiArI2lmZGVmIENPTkZJR19GU0xf
TUNfQlVTCj4+PiArwqDCoMKgIGJ1c19zZXRfaW9tbXUoJmZzbF9tY19idXNfdHlwZSwgTlVMTCk7
Cj4+PiArI2VuZGlmCj4+Cj4+IGJ1c19zZXRfaW9tbXUoKSBpcyBnb2luZyBhd2F5Ogo+Pgo+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yL2NvdmVyLjE2NTA4OTA2MzguZ2l0LnJvYmluLm11cnBo
eUBhcm0uY29tCj4+Cj4+IFdpbGwKPiAKPiBUaGFua3MgZm9yIHRoZSBoZWFkcy11cC4gUm9iaW4g
aGFkIHBvaW50ZWQgb3V0IHRoYXQgdGhpcyB3b3JrIHdhcyAKPiBvbmdvaW5nIGJ1dCBJIGhhZG4n
dCBzZWVuIHRoZSBwYXRjaGVzIHlldC4gSSdsbCBsb29rIGludG8gaXQuCgpBbHRob3VnaCB0aGF0
ICppcyogY3VycmVudGx5IGJsb2NrZWQgb24gdGhlIG15c3RlcnkgaW50ZWwtaW9tbXUgcHJvYmxl
bSAKdGhhdCBJIGNhbid0IHJlcHJvZHVjZS4uLiBJZiB0aGlzIHNlcmllcyBpcyByZWFkeSB0byBs
YW5kIHJpZ2h0IG5vdyBmb3IgCjUuMTkgdGhlbiBpbiBwcmluY2lwbGUgdGhhdCBtaWdodCBiZSB0
aGUgZWFzaWVzdCBvcHRpb24gb3ZlcmFsbC4gCkhvcGVmdWxseSBhdCBsZWFzdCBwYXRjaCAjMiBj
b3VsZCBzbmVhayBpbiBzbyB0aGF0IHRoZSBjb21waWxlLXRpbWUgCmRlcGVuZGVuY2llcyBhcmUg
cmVhZHkgZm9yIG1lIHRvIHJvbGwgdXAgaG9zdDF4IGludG8gdGhlIG5leHQgcmViYXNlIG9mIAoi
aW9tbXU6IEFsd2F5cyByZWdpc3RlciBidXMgbm90aWZpZXJzIi4KCkNoZWVycywKUm9iaW4uCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
