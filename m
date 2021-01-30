Return-Path: <SRS0=5nCU=HB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE9C433E0
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 01:54:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFEA64E08
	for <iommu@archiver.kernel.org>; Sat, 30 Jan 2021 01:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFEA64E08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D79E085FDB;
	Sat, 30 Jan 2021 01:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxo8tYD-SCdU; Sat, 30 Jan 2021 01:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 27A1A85FA5;
	Sat, 30 Jan 2021 01:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E33AAC08A1;
	Sat, 30 Jan 2021 01:54:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA6B2C013A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D170E85FBA
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoNn50TnxRUq for <iommu@lists.linux-foundation.org>;
 Sat, 30 Jan 2021 01:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EF88885FA5
 for <iommu@lists.linux-foundation.org>; Sat, 30 Jan 2021 01:54:32 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DSHKL030KzMRPn;
 Sat, 30 Jan 2021 09:52:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0;
 Sat, 30 Jan 2021 09:54:27 +0800
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU
 register space
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
 <20210127113258.1421-4-thunder.leizhen@huawei.com>
 <fa170300-57d9-3883-c70f-d455a9e461f0@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
Date: Sat, 30 Jan 2021 09:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fa170300-57d9-3883-c70f-d455a9e461f0@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

CgpPbiAyMDIxLzEvMjkgMjM6MjcsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTI3
IDExOjMyLCBaaGVuIExlaSB3cm90ZToKPj4gY29tbWl0IDUyZjNmYWIwMDY3ZCAoImlvbW11L2Fy
bS1zbW11LXYzOiBEb24ndCByZXNlcnZlIGltcGxlbWVudGF0aW9uCj4+IGRlZmluZWQgcmVnaXN0
ZXIgc3BhY2UiKSBvbmx5IHJlc2VydmVzIHRoZSBiYXNpYyBTTU1VIHJlZ2lzdGVyIHNwYWNlLiBT
bwo+PiB0aGUgRUNNRFEgcmVnaXN0ZXIgc3BhY2UgaXMgbm90IGNvdmVyZWQsIGl0IHNob3VsZCBi
ZSBtYXBwZWQgYWdhaW4uIER1ZQo+PiB0byB0aGUgc2l6ZSBvZiB0aGlzIEVDTURRIHJlc291cmNl
IGlzIG5vdCBmaXhlZCwgZGVwZW5kaW5nIG9uCj4+IFNNTVVfSURSNi5DTURRX0NPTlRST0xfUEFH
RV9MT0cyTlVNUS4gUHJvY2Vzc2luZyBpdHMgcmVzb3VyY2UgcmVzZXJ2YXRpb24KPj4gdG8gYXZv
aWQgcmVzb3VyY2UgY29uZmxpY3Qgd2l0aCBQTUNHIGlzIGEgYml0IG1vcmUgY29tcGxpY2F0ZWQu
Cj4+Cj4+IFRoZXJlZm9yZSwgdGhlIHJlc291cmNlcyBvZiB0aGUgUE1DRyBhcmUgbm90IHJlc2Vy
dmVkLCBhbmQgdGhlIGVudGlyZSBTTU1VCj4+IHJlc291cmNlcyBhcmUgcmVzZXJ2ZWQuCj4gCj4g
VGhpcyBpcyB0aGUgb3Bwb3NpdGUgb2Ygd2hhdCBJIHN1Z2dlc3RlZC4gTXkgcG9pbnQgd2FzIHRo
YXQgaXQgd2lsbCBtYWtlIHRoZSBtb3N0IHNlbnNlIHRvIG1hcCB0aGUgRUNNRFEgcGFnZXMgYXMg
YSBzZXBhcmF0ZSByZXF1ZXN0IGFueXdheSwgdGhlcmVmb3JlIHRoZXJlIGlzIG5vIHJlYXNvbiB0
byBzdG9wIG1hcHBpbmcgcGFnZSAwIGFuZCBwYWdlIDEgc2VwYXJhdGVseSBlaXRoZXIuCgpJIGRv
bid0IHVuZGVyc3RhbmQgd2h5IHRoZSBFQ01EUSBtYXBwaW5nIG11c3QgYmUgcGVyZm9ybWVkIHNl
cGFyYXRlbHkuIElmIHRoZSBjb25mbGljdCB3aXRoIFBNQ0cgcmVzb3VyY2VzIGlzIGVsaW1pbmF0
ZWQuIEVDTURRIGNhbm5vdCBiZSBhIHNlcGFyYXRlIGRyaXZlciBsaWtlIFBNQ0cuCgo+IAo+IElm
IHdlIG5lZWQgdG8gZXhwYW5kIHRoZSBwYWdlIDAgbWFwcGluZyB0byBjb3ZlciBtb3JlIG9mIHBh
Z2UgMCB0byByZWFjaCB0aGUgU01NVV9DTURRX0NPTlRST0xfUEFHRV8qIHJlZ2lzdGVycywgd2Ug
Y2FuIGRvIHRoYXQgd2hlbiB3ZSBhY3R1YWxseSBhZGQgRUNNRFEgc3VwcG9ydC4KPiAKPiBSb2Jp
bi4KPiAKPj4gU3VnZ2VzdGVkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29t
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+
Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5j
IHwgMjQgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmggfMKgIDIgLS0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4gaW5kZXggZjA0YzU1YTc1MDNjNzkwLi5mZGUy
NDQwM2IwNmE5ZTMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuYwo+PiBAQCAtMzQ3NiwxNCArMzQ3Niw2IEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVf
c2V0X2J1c19vcHMoc3RydWN0IGlvbW11X29wcyAqb3BzKQo+PiDCoMKgwqDCoMKgIHJldHVybiBl
cnI7Cj4+IMKgIH0KPj4gwqAgLXN0YXRpYyB2b2lkIF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAo
c3RydWN0IGRldmljZSAqZGV2LCByZXNvdXJjZV9zaXplX3Qgc3RhcnQsCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzb3VyY2Vfc2l6ZV90IHNpemUpCj4+
IC17Cj4+IC3CoMKgwqAgc3RydWN0IHJlc291cmNlIHJlcyA9IERFRklORV9SRVNfTUVNKHN0YXJ0
LCBzaXplKTsKPj4gLQo+PiAtwqDCoMKgIHJldHVybiBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2
LCAmcmVzKTsKPj4gLX0KPj4gLQo+PiDCoCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaW50
IGlycSwgcmV0Owo+PiBAQCAtMzUxOSwyMiArMzUxMSwxNCBAQCBzdGF0aWMgaW50IGFybV9zbW11
X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+PiDCoMKgwqDCoMKg
IH0KPj4gwqDCoMKgwqDCoCBpb2FkZHIgPSByZXMtPnN0YXJ0Owo+PiDCoCAtwqDCoMKgIC8qCj4+
IC3CoMKgwqDCoCAqIERvbid0IG1hcCB0aGUgSU1QTEVNRU5UQVRJT04gREVGSU5FRCByZWdpb25z
LCBzaW5jZSB0aGV5IG1heSBjb250YWluCj4+IC3CoMKgwqDCoCAqIHRoZSBQTUNHIHJlZ2lzdGVy
cyB3aGljaCBhcmUgcmVzZXJ2ZWQgYnkgdGhlIFBNVSBkcml2ZXIuCj4+IC3CoMKgwqDCoCAqLwo+
PiAtwqDCoMKgIHNtbXUtPmJhc2UgPSBhcm1fc21tdV9pb3JlbWFwKGRldiwgaW9hZGRyLCBBUk1f
U01NVV9SRUdfU1opOwo+PiArwqDCoMKgIHNtbXUtPmJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3Vy
Y2UoZGV2LCByZXMpOwo+PiDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21tdS0+YmFzZSkpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihzbW11LT5iYXNlKTsKPj4gwqAgLcKgwqDC
oCBpZiAoYXJtX3NtbXVfcmVzb3VyY2Vfc2l6ZShzbW11KSA+IFNaXzY0Sykgewo+PiAtwqDCoMKg
wqDCoMKgwqAgc21tdS0+cGFnZTEgPSBhcm1fc21tdV9pb3JlbWFwKGRldiwgaW9hZGRyICsgU1pf
NjRLLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBUk1fU01NVV9SRUdfU1opOwo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11
LT5wYWdlMSkpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXUt
PnBhZ2UxKTsKPj4gLcKgwqDCoCB9IGVsc2Ugewo+PiArwqDCoMKgIGlmIChhcm1fc21tdV9yZXNv
dXJjZV9zaXplKHNtbXUpID4gU1pfNjRLKQo+PiArwqDCoMKgwqDCoMKgwqAgc21tdS0+cGFnZTEg
PSBzbW11LT5iYXNlICsgU1pfNjRLOwo+PiArwqDCoMKgIGVsc2UKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIHNtbXUtPnBhZ2UxID0gc21tdS0+YmFzZTsKPj4gLcKgwqDCoCB9Cj4+IMKgIMKgwqDCoMKg
wqAgLyogSW50ZXJydXB0IGxpbmVzICovCj4+IMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5oIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuaAo+PiBpbmRleCBkYTUyNWY0NmRhYjRmYzEuLjYzZjJiNDc2OTg3
ZDZhZSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNt
bXUtdjMuaAo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My5oCj4+IEBAIC0xNTIsOCArMTUyLDYgQEAKPj4gwqAgI2RlZmluZSBBUk1fU01NVV9QUklRX0lS
UV9DRkcxwqDCoMKgwqDCoMKgwqAgMHhkOAo+PiDCoCAjZGVmaW5lIEFSTV9TTU1VX1BSSVFfSVJR
X0NGRzLCoMKgwqDCoMKgwqDCoCAweGRjCj4+IMKgIC0jZGVmaW5lIEFSTV9TTU1VX1JFR19TWsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHhlMDAKPj4gLQo+PiDCoCAvKiBDb21tb24gTVNJIGNvbmZp
ZyBmaWVsZHMgKi8KPj4gwqAgI2RlZmluZSBNU0lfQ0ZHMF9BRERSX01BU0vCoMKgwqDCoMKgwqDC
oCBHRU5NQVNLX1VMTCg1MSwgMikKPj4gwqAgI2RlZmluZSBNU0lfQ0ZHMl9TSMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgR0VOTUFTSyg1LCA0KQo+Pgo+IAo+IC4KPiAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
