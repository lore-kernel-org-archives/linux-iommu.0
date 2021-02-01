Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30D2C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:00:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F241564E50
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 12:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241564E50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AA512847C3;
	Mon,  1 Feb 2021 12:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wx1Ci5FQlJcZ; Mon,  1 Feb 2021 12:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A978784464;
	Mon,  1 Feb 2021 12:00:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95BF9C0FA7;
	Mon,  1 Feb 2021 12:00:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFADC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A16A847C3
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQN1Y1iOIcQI for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 12:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A52F84464
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 12:00:38 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTmgg1Sq7zMTBf;
 Mon,  1 Feb 2021 19:58:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 1 Feb 2021 20:00:31 +0800
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
 <6c5b4dca-24d4-55d7-1345-2238567cb958@huawei.com>
 <cd174cbf-e006-c7be-a707-d7973a26ed31@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b20a1f35-381f-676c-a4e9-e42403f29e80@huawei.com>
Date: Mon, 1 Feb 2021 20:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cd174cbf-e006-c7be-a707-d7973a26ed31@arm.com>
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

CgpPbiAyMDIxLzIvMSAxOTo0NCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDEtMzAg
MDE6NTQsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS8xLzI5
IDIzOjI3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIxLTAxLTI3IDExOjMyLCBaaGVu
IExlaSB3cm90ZToKPj4+PiBjb21taXQgNTJmM2ZhYjAwNjdkICgiaW9tbXUvYXJtLXNtbXUtdjM6
IERvbid0IHJlc2VydmUgaW1wbGVtZW50YXRpb24KPj4+PiBkZWZpbmVkIHJlZ2lzdGVyIHNwYWNl
Iikgb25seSByZXNlcnZlcyB0aGUgYmFzaWMgU01NVSByZWdpc3RlciBzcGFjZS4gU28KPj4+PiB0
aGUgRUNNRFEgcmVnaXN0ZXIgc3BhY2UgaXMgbm90IGNvdmVyZWQsIGl0IHNob3VsZCBiZSBtYXBw
ZWQgYWdhaW4uIER1ZQo+Pj4+IHRvIHRoZSBzaXplIG9mIHRoaXMgRUNNRFEgcmVzb3VyY2UgaXMg
bm90IGZpeGVkLCBkZXBlbmRpbmcgb24KPj4+PiBTTU1VX0lEUjYuQ01EUV9DT05UUk9MX1BBR0Vf
TE9HMk5VTVEuIFByb2Nlc3NpbmcgaXRzIHJlc291cmNlIHJlc2VydmF0aW9uCj4+Pj4gdG8gYXZv
aWQgcmVzb3VyY2UgY29uZmxpY3Qgd2l0aCBQTUNHIGlzIGEgYml0IG1vcmUgY29tcGxpY2F0ZWQu
Cj4+Pj4KPj4+PiBUaGVyZWZvcmUsIHRoZSByZXNvdXJjZXMgb2YgdGhlIFBNQ0cgYXJlIG5vdCBy
ZXNlcnZlZCwgYW5kIHRoZSBlbnRpcmUgU01NVQo+Pj4+IHJlc291cmNlcyBhcmUgcmVzZXJ2ZWQu
Cj4+Pgo+Pj4gVGhpcyBpcyB0aGUgb3Bwb3NpdGUgb2Ygd2hhdCBJIHN1Z2dlc3RlZC4gTXkgcG9p
bnQgd2FzIHRoYXQgaXQgd2lsbCBtYWtlIHRoZSBtb3N0IHNlbnNlIHRvIG1hcCB0aGUgRUNNRFEg
cGFnZXMgYXMgYSBzZXBhcmF0ZSByZXF1ZXN0IGFueXdheSwgdGhlcmVmb3JlIHRoZXJlIGlzIG5v
IHJlYXNvbiB0byBzdG9wIG1hcHBpbmcgcGFnZSAwIGFuZCBwYWdlIDEgc2VwYXJhdGVseSBlaXRo
ZXIuCj4+Cj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgdGhlIEVDTURRIG1hcHBpbmcgbXVzdCBi
ZSBwZXJmb3JtZWQgc2VwYXJhdGVseS4gSWYgdGhlIGNvbmZsaWN0IHdpdGggUE1DRyByZXNvdXJj
ZXMgaXMgZWxpbWluYXRlZC4gRUNNRFEgY2Fubm90IGJlIGEgc2VwYXJhdGUgZHJpdmVyIGxpa2Ug
UE1DRy4KPiAKPiBJIG1lYW4gaW4gdGVybXMgb2YgdGhlIGJhc2ljIHByYWN0aWNlIG9mIG5vdCBt
YXBwaW5nIG1lZ2FieXRlcyB3b3J0aCBvZiBJTVAtREVGIGNyYXAgdGhhdCB0aGlzIGRyaXZlciBk
b2Vzbid0IG5lZWQgb3IgZXZlbiB1bmRlcnN0YW5kLiBJZiB3ZSBkb24ndCBoYXZlIEVDTURRLCB3
ZSBkZWZpbml0ZWx5IGRvbid0IG5lZWQgYW55dGhpbmcgYmV5b25kIHBhZ2UgMSwgc28gdGhlcmUn
cyBubyBwb2ludCBtYXBwaW5nIGl0IGFsbCwgYW5kIGluZGVlZCBpdCdzIHNhZmVzdCBub3QgdG8g
YW55d2F5LiBFdmVuIGlmIHdlIGRvIGhhdmUgRUNNRFEsIGl0J3Mgc3RpbGwgc2FmZXIgbm90IHRv
IG1hcCBhbGwgdGhlIHVua25vd24gc3R1ZmYgdGhhdCBtYXkgYmUgaW4gYmV0d2VlbiwgYW5kIHVu
dGlsIHdlJ3ZlIG1hcHBlZCBwYWdlIDAgd2UgZG9uJ3Qga25vdyB3aGV0aGVyIHdlIGhhdmUgRUNN
RFEgb3Igbm90Lgo+IAo+IFRoZXJlZm9yZSB0aGUgbW9zdCBzZW5zaWJsZSB0aGluZyB0byBkbyBl
aXRoZXIgd2F5IGlzIHRvIG1hcCB0aGUgYmFzaWMgcGFnZShzKSBmaXJzdCwgdGhlbiBtYXAgdGhl
IEVDTURRIHBhZ2VzIHNwZWNpZmljYWxseSBpZiB3ZSBkZXRlcm1pbmUgdGhhdCB3ZSBuZWVkIHRv
LiBBbmQgZWl0aGVyIHdheSB3ZSBkb24ndCBldmVuIG5lZWQgdG8gdGhpbmsgYWJvdXQgdGhpcyB1
bnRpbCBhZGRpbmcgRUNNRFEgc3VwcG9ydC4KCk9rYXksIEkgZ290IGl0LiBXZSByZWFsbHkgZG9u
J3QgaGF2ZSB0byB3cml0ZSBjb2RlIGFoZWFkIG9mIHRpbWUgZm9yIHdoYXQgbWlnaHQgaGFwcGVu
IGluIHRoZSBmdXR1cmUuCgo+IAo+IFJvYmluLgo+IAo+Pj4gSWYgd2UgbmVlZCB0byBleHBhbmQg
dGhlIHBhZ2UgMCBtYXBwaW5nIHRvIGNvdmVyIG1vcmUgb2YgcGFnZSAwIHRvIHJlYWNoIHRoZSBT
TU1VX0NNRFFfQ09OVFJPTF9QQUdFXyogcmVnaXN0ZXJzLCB3ZSBjYW4gZG8gdGhhdCB3aGVuIHdl
IGFjdHVhbGx5IGFkZCBFQ01EUSBzdXBwb3J0Lgo+Pj4KPj4+IFJvYmluLgo+Pj4KPj4+PiBTdWdn
ZXN0ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogWmhlbiBMZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+Pj4+IC0tLQo+
Pj4+IMKgwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8IDI0
ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4+IMKgwqAgZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUtdjMvYXJtLXNtbXUtdjMuaCB8wqAgMiAtLQo+Pj4+IMKgwqAgMiBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+Pj4gaW5kZXggZjA0YzU1YTc1MDNj
NzkwLi5mZGUyNDQwM2IwNmE5ZTMgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0v
YXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4+PiBAQCAtMzQ3NiwxNCArMzQ3Niw2IEBAIHN0YXRp
YyBpbnQgYXJtX3NtbXVfc2V0X2J1c19vcHMoc3RydWN0IGlvbW11X29wcyAqb3BzKQo+Pj4+IMKg
wqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+IMKgwqAgfQo+Pj4+IMKgwqAgLXN0YXRpYyB2b2lk
IF9faW9tZW0gKmFybV9zbW11X2lvcmVtYXAoc3RydWN0IGRldmljZSAqZGV2LCByZXNvdXJjZV9z
aXplX3Qgc3RhcnQsCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXNvdXJjZV9zaXplX3Qgc2l6ZSkKPj4+PiAtewo+Pj4+IC3CoMKgwqAgc3RydWN0IHJl
c291cmNlIHJlcyA9IERFRklORV9SRVNfTUVNKHN0YXJ0LCBzaXplKTsKPj4+PiAtCj4+Pj4gLcKg
wqDCoCByZXR1cm4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgJnJlcyk7Cj4+Pj4gLX0KPj4+
PiAtCj4+Pj4gwqDCoCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+IMKgwqAgewo+Pj4+IMKgwqDCoMKgwqDCoCBpbnQgaXJx
LCByZXQ7Cj4+Pj4gQEAgLTM1MTksMjIgKzM1MTEsMTQgQEAgc3RhdGljIGludCBhcm1fc21tdV9k
ZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4+PiDCoMKgwqDCoMKg
wqAgfQo+Pj4+IMKgwqDCoMKgwqDCoCBpb2FkZHIgPSByZXMtPnN0YXJ0Owo+Pj4+IMKgwqAgLcKg
wqDCoCAvKgo+Pj4+IC3CoMKgwqDCoCAqIERvbid0IG1hcCB0aGUgSU1QTEVNRU5UQVRJT04gREVG
SU5FRCByZWdpb25zLCBzaW5jZSB0aGV5IG1heSBjb250YWluCj4+Pj4gLcKgwqDCoMKgICogdGhl
IFBNQ0cgcmVnaXN0ZXJzIHdoaWNoIGFyZSByZXNlcnZlZCBieSB0aGUgUE1VIGRyaXZlci4KPj4+
PiAtwqDCoMKgwqAgKi8KPj4+PiAtwqDCoMKgIHNtbXUtPmJhc2UgPSBhcm1fc21tdV9pb3JlbWFw
KGRldiwgaW9hZGRyLCBBUk1fU01NVV9SRUdfU1opOwo+Pj4+ICvCoMKgwqAgc21tdS0+YmFzZSA9
IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7Cj4+Pj4gwqDCoMKgwqDCoMKgIGlmIChJ
U19FUlIoc21tdS0+YmFzZSkpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9F
UlIoc21tdS0+YmFzZSk7Cj4+Pj4gwqDCoCAtwqDCoMKgIGlmIChhcm1fc21tdV9yZXNvdXJjZV9z
aXplKHNtbXUpID4gU1pfNjRLKSB7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHNtbXUtPnBhZ2UxID0g
YXJtX3NtbXVfaW9yZW1hcChkZXYsIGlvYWRkciArIFNaXzY0SywKPj4+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUk1fU01NVV9SRUdfU1op
Owo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXUtPnBhZ2UxKSkKPj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihzbW11LT5wYWdlMSk7Cj4+Pj4gLcKg
wqDCoCB9IGVsc2Ugewo+Pj4+ICvCoMKgwqAgaWYgKGFybV9zbW11X3Jlc291cmNlX3NpemUoc21t
dSkgPiBTWl82NEspCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNtbXUtPnBhZ2UxID0gc21tdS0+YmFz
ZSArIFNaXzY0SzsKPj4+PiArwqDCoMKgIGVsc2UKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
bW11LT5wYWdlMSA9IHNtbXUtPmJhc2U7Cj4+Pj4gLcKgwqDCoCB9Cj4+Pj4gwqDCoCDCoMKgwqDC
oMKgIC8qIEludGVycnVwdCBsaW5lcyAqLwo+Pj4+IMKgwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmggYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5oCj4+Pj4gaW5kZXggZGE1MjVmNDZkYWI0ZmMxLi42M2Yy
YjQ3Njk4N2Q2YWUgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYz
L2FybS1zbW11LXYzLmgKPj4+PiBAQCAtMTUyLDggKzE1Miw2IEBACj4+Pj4gwqDCoCAjZGVmaW5l
IEFSTV9TTU1VX1BSSVFfSVJRX0NGRzHCoMKgwqDCoMKgwqDCoCAweGQ4Cj4+Pj4gwqDCoCAjZGVm
aW5lIEFSTV9TTU1VX1BSSVFfSVJRX0NGRzLCoMKgwqDCoMKgwqDCoCAweGRjCj4+Pj4gwqDCoCAt
I2RlZmluZSBBUk1fU01NVV9SRUdfU1rCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4ZTAwCj4+Pj4g
LQo+Pj4+IMKgwqAgLyogQ29tbW9uIE1TSSBjb25maWcgZmllbGRzICovCj4+Pj4gwqDCoCAjZGVm
aW5lIE1TSV9DRkcwX0FERFJfTUFTS8KgwqDCoMKgwqDCoMKgIEdFTk1BU0tfVUxMKDUxLCAyKQo+
Pj4+IMKgwqAgI2RlZmluZSBNU0lfQ0ZHMl9TSMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0VOTUFT
Syg1LCA0KQo+Pj4+Cj4+Pgo+Pj4gLgo+Pj4KPj4KPiAKPiAuCj4gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
