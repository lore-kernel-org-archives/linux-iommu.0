Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC2C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 02:19:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F6123788
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 02:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F6123788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4056086BAE;
	Thu, 21 Jan 2021 02:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kFvj70zEjN1E; Thu, 21 Jan 2021 02:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0199C86BA2;
	Thu, 21 Jan 2021 02:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8CEFC08A1;
	Thu, 21 Jan 2021 02:19:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF86C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8384F86BAD
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqr+EQqRwmIm for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 02:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FDF786BA2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 02:19:43 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLmK372V1z15wVs;
 Thu, 21 Jan 2021 10:18:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 21 Jan 2021 10:19:29 +0800
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
 <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
 <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
 <2a577c5e-25bb-5feb-d745-f25007b5a213@huawei.com>
 <19faaf58-b209-ad76-ffa6-4877b153b664@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ac73fadc-8ca2-3de8-b837-7df45fd5b23d@huawei.com>
Date: Thu, 21 Jan 2021 10:19:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <19faaf58-b209-ad76-ffa6-4877b153b664@arm.com>
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

CgpPbiAyMDIxLzEvMjAgMjM6NTQsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTIw
IDE0OjE0LCBMZWl6aGVuIChUaHVuZGVyVG93bikgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIwMjEvMS8y
MCAyMToyNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMS0wMS0yMCAwOToyNiwgTGVp
emhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pj4+Cj4+Pj4KPj4+PiBPbiAyMDIxLzEvMjAgMTE6
MzcsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPj4+Pj4KPj4+Pj4KPj4+Pj4gT24gMjAy
MS8xLzE5IDIwOjMyLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+PiBPbiAyMDIxLTAxLTE5IDAx
OjU5LCBaaGVuIExlaSB3cm90ZToKPj4+Pj4+PiBTb21lIFNNTVV2MyBpbXBsZW1lbnRhdGlvbiBl
bWJlZCB0aGUgUGVyZiBNb25pdG9yIEdyb3VwIFJlZ2lzdGVycyAoUE1DRykKPj4+Pj4+PiBpbnNp
ZGUgdGhlIGZpcnN0IDY0a0IgcmVnaW9uIG9mIHRoZSBTTU1VLiBTaW5jZSBTTU1VIGFuZCBQTUNH
IGFyZSBtYW5hZ2VkCj4+Pj4+Pj4gYnkgdHdvIHNlcGFyYXRlIGRyaXZlcnMsIGFuZCB0aGlzIGRy
aXZlciBkZXBlbmRzIG9uIEFSTV9TTU1VX1YzLCBzbyB0aGUKPj4+Pj4+PiBTTU1VIGRyaXZlciBy
ZXNlcnZlcyB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBmaXJzdCwgdGhpcyBkcml2ZXIgc2hv
dWxkCj4+Pj4+Pj4gbm90IHJlc2VydmUgdGhlIGNvcnJlc3BvbmRpbmcgcmVzb3VyY2UgYWdhaW4u
IE90aGVyd2lzZSwgYSByZXNvdXJjZQo+Pj4+Pj4+IHJlc2VydmF0aW9uIGNvbmZsaWN0IGlzIHJl
cG9ydGVkIGR1cmluZyBib290Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbiBM
ZWkgPHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+IMKgwqDC
oCBkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyB8IDQyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQo+Pj4+Pj4+IMKgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNDAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyBiL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYz
X3BtdS5jCj4+Pj4+Pj4gaW5kZXggNzQ0NzRiYjMyMmMzZjI2Li5kY2NlMDg1NDMxYzZjZTggMTAw
NjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMKPj4+Pj4+PiAr
KysgYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+Pj4+Pj4+IEBAIC03NjEsNiArNzYx
LDQ0IEBAIHN0YXRpYyB2b2lkIHNtbXVfcG11X2dldF9hY3BpX29wdGlvbnMoc3RydWN0IHNtbXVf
cG11ICpzbW11X3BtdSkKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBkZXZfbm90aWNlKHNtbXVfcG11
LT5kZXYsICJvcHRpb24gbWFzayAweCV4XG4iLCBzbW11X3BtdS0+b3B0aW9ucyk7Cj4+Pj4+Pj4g
wqDCoMKgIH0KPj4+Pj4+PiDCoMKgwqAgK3N0YXRpYyB2b2lkIF9faW9tZW0gKgo+Pj4+Pj4+ICtz
bW11X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiwKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgaW5kZXgsCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHJlc291cmNlICoqb3V0X3JlcykKPj4+Pj4+PiArewo+Pj4+Pj4+ICvCoMKgwqAgaW50
IHJldDsKPj4+Pj4+PiArwqDCoMKgIHZvaWQgX19pb21lbSAqYmFzZTsKPj4+Pj4+PiArwqDCoMKg
IHN0cnVjdCByZXNvdXJjZSAqcmVzOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgIHJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgaW5kZXgpOwo+Pj4+Pj4+
ICvCoMKgwqAgaWYgKCFyZXMpIHsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmcGRl
di0+ZGV2LCAiaW52YWxpZCByZXNvdXJjZVxuIik7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiBJT01FTV9FUlJfUFRSKC1FSU5WQUwpOwo+Pj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4+ICvC
oMKgwqAgaWYgKG91dF9yZXMpCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgICpvdXRfcmVzID0gcmVz
Owo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgIHJldCA9IHJlZ2lvbl9pbnRlcnNlY3RzKHJlcy0+
c3RhcnQsIHJlc291cmNlX3NpemUocmVzKSwKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIElPUkVTT1VSQ0VfTUVNLCBJT1JFU19ERVNDX05PTkUpOwo+Pj4+Pj4+ICvCoMKg
wqAgaWYgKHJldCA9PSBSRUdJT05fSU5URVJTRUNUUykgewo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oCAvKgo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc291cmNlIGhhcyBhbHJlYWR5
IGJlZW4gcmVzZXJ2ZWQgYnkgdGhlIFNNTVV2MyBkcml2ZXIuCj4+Pj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqAgKiBEb24ndCByZXNlcnZlIGl0IGFnYWluLCBqdXN0IGRvIGRldm1faW9yZW1hcCgpLgo+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGJhc2Ug
PSBkZXZtX2lvcmVtYXAoJnBkZXYtPmRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMp
KTsKPj4+Pj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBUaGUgcmVzb3VyY2UgbWF5IGhhdmUgbm90IGJlZW4g
cmVzZXJ2ZWQgYnkgYW55IGRyaXZlciwgb3IKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGhh
cyBiZWVuIHJlc2VydmVkIGJ1dCBub3QgdHlwZSBJT1JFU09VUkNFX01FTS4gSW4gdGhlIGxhdHRl
cgo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogY2FzZSwgZGV2bV9pb3JlbWFwX3Jlc291cmNl
KCkgcmVwb3J0cyBhIGNvbmZsaWN0IGFuZCByZXR1cm5zCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqAgKiBJT01FTV9FUlJfUFRSKC1FQlVTWSkuCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8K
Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJjZSgmcGRl
di0+ZGV2LCByZXMpOwo+Pj4+Pj4+ICvCoMKgwqAgfQo+Pj4+Pj4KPj4+Pj4+IFdoYXQgaWYgdGhl
IFBNQ0cgZHJpdmVyIHNpbXBseSBoYXBwZW5zIHRvIHByb2JlIGZpcnN0Pwo+Pj4+Pgo+Pj4+PiBU
aGVyZSBhcmUgNCBjYXNlczoKPj4+Pj4gMSkgQVJNX1NNTVVfVjM9bSwgQVJNX1NNTVVfVjNfUE1V
PXkKPj4+Pj4gwqDCoMKgwqAgSXQncyBub3QgYWxsb3dlZC4gQmVjYXNlOiBBUk1fU01NVV9WM19Q
TVUgZGVwZW5kcyBvbiBBUk1fU01NVV9WMwo+Pj4+PiDCoMKgwqDCoCBjb25maWcgQVJNX1NNTVVf
VjNfUE1VCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyaXN0YXRlICJBUk0gU01NVXYzIFBl
cmZvcm1hbmNlIE1vbml0b3JzIEV4dGVuc2lvbiIKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGVwZW5kcyBvbiBBUk02NCAmJiBBQ1BJICYmIEFSTV9TTU1VX1YzCj4+Pj4+Cj4+Pj4+IDIpIEFS
TV9TTU1VX1YzPXksIEFSTV9TTU1VX1YzX1BNVT1tCj4+Pj4+IMKgwqDCoMKgIE5vIHByb2JsZW0s
IFNNTVV2MyB3aWxsIGJlIGluaXRpYWxpemVkIGZpcnN0Lgo+Pj4+Pgo+Pj4+PiAzKSBBUk1fU01N
VV9WMz15LCBBUk1fU01NVV9WM19QTVU9eQo+Pj4+PiDCoMKgwqDCoCB2aSBkcml2ZXJzL01ha2Vm
aWxlCj4+Pj4+IMKgwqDCoMKgIDYwIG9iai15wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArPSBpb21tdS8KPj4+Pj4gwqDCoMKgwqAgMTcyIG9iai0k
KENPTkZJR19QRVJGX0VWRU5UUynCoMKgwqDCoMKgwqAgKz0gcGVyZi8KPj4+Pj4KPj4+Pj4gwqDC
oMKgwqAgVGhpcyBsaW5rIHNlcXVlbmNlIGVuc3VyZSB0aGF0IFNNTVV2MyBkcml2ZXIgd2lsbCBi
ZSBpbml0aWFsaXplZCBmaXJzdC4KPj4+Pj4gwqDCoMKgwqAgVGhleSBhcmUgY3VycmVudGx5IGF0
IHRoZSBzYW1lIGluaXRpYWxpemF0aW9uIGxldmVsLgo+Pj4+Pgo+Pj4+PiA0KSBBUk1fU01NVV9W
Mz1tLCBBUk1fU01NVV9WM19QTVU9bQo+Pj4+PiDCoMKgwqDCoCBTb3JyeSwgSSB0aG91Z2h0IG1v
ZHVsZSBkZXBlbmRlbmNpZXMgd2VyZSBnZW5lcmF0ZWQgYmFzZWQgb24gImRlcGVuZHMgb24iLgo+
Pj4+PiDCoMKgwqDCoCBCdXQgSSB0cmllZCBpdCB0b2Rhee+8jG1vZHVsZSBkZXBlbmRlbmNpZXMg
YXJlIGdlbmVyYXRlZCBvbmx5IHdoZW4gc3ltYm9sCj4+Pj4+IMKgwqDCoMKgIGRlcGVuZGVuY2ll
cyBleGlzdC4gSSBzaG91bGQgdXNlIE1PRFVMRV9TT0ZUREVQKCkgdG8gZXhwbGljaXRseSBtYXJr
IHRoZQo+Pj4+PiDCoMKgwqDCoCBkZXBlbmRlbmN5LiBJIHdpbGwgc2VuZCBWMiBsYXRlci4KPj4+
Pj4KPj4+Pgo+Pj4+IEhpIFJvYmluOgo+Pj4+IMKgwqDCoCBJIHRoaW5rIEkgbWlzdW5kZXJzdG9v
ZCB5b3VyIHF1ZXN0aW9uLiBUaGUgcHJvYmUoKSBpbnN0ZWFkIG9mIG1vZHVsZV9pbml0KCkKPj4+
PiBkZXRlcm1pbmVzIHRoZSB0aW1lIGZvciByZXNlcnZpbmcgcmVnaXN0ZXIgc3BhY2UgcmVzb3Vy
Y2VzLsKgIFNvIHdlJ2QgYmV0dGVyCj4+Pj4gcmVzZXJ2ZSBtdWx0aXBsZSBzbWFsbCBibG9ja3Mg
b2YgcmVzb3VyY2VzIGluIFNNTVV2MyBidXQgcGVyZm9ybSBpb3JlbWFwKCkgZm9yCj4+Pj4gdGhl
IGVudGlyZSByZXNvdXJjZSwgaWYgdGhlIHByb2JlKCkgb2YgdGhlIFBNQ0cgb2NjdXJzIGZpcnN0
Lgo+Pj4+IMKgwqDCoCBJJ2xsIHJlZmluZSB0aGVzZSBwYXRjaGVzIHRvIG1ha2UgYm90aCBpbml0
aWFsaXphdGlvbiBzZXF1ZW5jZXMgd29yayB3ZWxsLgo+Pj4+IEknbSB0cnlpbmcgdG8gc2VuZCBW
MiB0aGlzIHdlZWsuCj4+Pgo+Pj4gVGhlcmUncyBzdGlsbCB0aGUgcG9zc2liaWxpdHkgdGhhdCBh
IFBNQ0cgaXMgaW1wbGVtZW50ZWQgaW4gYSByb290IGNvbXBsZXggb3Igc29tZSBvdGhlciBkZXZp
Y2UgdGhhdCBpc24ndCBhbiBTTU1VLCBzbyBhcyBJJ3ZlIHNhaWQgYmVmb3JlLCBub25lIG9mIHRo
aXMgdHJpY2tlcnkgcmVhbGx5IHNjYWxlcy4KPj4+Cj4+PiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5k
IGl0LCB0aGUgbWFpbiBwb2ludCBvZiByZXNlcnZpbmcgcmVzb3VyY2VzIGlzIHRvIGNhdGNoIGJ1
Z3Mgd2hlcmUgdGhpbmdzIGRlZmluaXRlbHkgc2hvdWxkIG5vdCBiZSBvdmVybGFwcGluZy4gUE1D
R3MgYXJlIGJ5IGRlZmluaXRpb24gcGFydCBvZiBzb21lIG90aGVyIGRldmljZSwgc28gaW4gZ2Vu
ZXJhbCB0aGV5ICpjYW4qIGJlIGV4cGVjdGVkIHRvIG92ZXJsYXAgd2l0aCB3aGF0ZXZlciBkZXZp
Y2UgdGhhdCBpcy4gSSBzdGlsbCB0aGluayBpdCdzIG1vc3QgbG9naWNhbCB0byBzaW1wbHkgKm5v
dCogdHJ5IHRvIHJlc2VydmUgUE1DRyByZXNvdXJjZXMgYXQgYWxsLgo+Pgo+PiBJZiBQTUNHIHJl
c291cmNlcyBtYXkgb3ZlcmxhcCB3aXRoIG90aGVyIGRldmljZXMsIHRoYXQncyByZWFsbHkgZ29p
bmcgdG8gYmUgYSB2ZXJ5IHRyaWNreSB0aGluZy4gT0ssIEknbGwgZm9sbG93IHlvdXIgYWR2aWNl
77yManVzdCBkbyBpb3JlbWFwKCkgZm9yIHRoZSBQTUNHIHJlc291cmNlcy4KPj4KPj4gSSBrbm93
IHRoYXQgSS9PIHJlc291cmNlIGluZm9ybWF0aW9uIGNhbiBiZSBxdWVyaWVkIGJ5IHJ1bm5pbmcg
ImNhdCAvcHJvYy9pb21lbSIuIElmIHdlIGRvIG5vdCByZXNlcnZlIFBNQ0cgcmVzb3VyY2VzLCBz
aG91bGQgd2UgcHJvdmlkZSBhbiBhZGRpdGlvbmFsIGZzIHF1ZXJ5IGludGVyZmFjZT8KPiAKPiBX
aGF0IHdvdWxkIHRoYXQgYmUgbmVjZXNzYXJ5IGZvcj8gVGhlIFBNVSBkZXZpY2VzIGFyZSBhbHJl
YWR5IG5hbWVkIGJ5IGJhc2UgYWRkcmVzcyBzbyB0aGV5IGNhbiBiZSBpZGVudGlmaWVkLiBTeXNm
cyB0ZWxscyB5b3Ugd2hldGhlciB0aGUgZHJpdmVyIGJvdW5kIHRvIGFueSBwbGF0Zm9ybSBkZXZp
Y2VzIG9yIG5vdCAoYWx0aG91Z2ggaW4gdGhpcyBjYXNlIHRoZSBleGlzdGVuY2Ugb2YgUE1VIGRl
dmljZXMgYWxyZWFkeSBtYWtlcyB0aGF0IGNsZWFyKS4gL3Byb2MvaW9tZW0gaXMgZm9yIHNob3dp
bmcgY2xhaW1lZCByZXNvdXJjZXMsIGFuZCBtYW55IGRyaXZlcnMgZG9uJ3QgY2xhaW0gcmVzb3Vy
Y2VzLiBJJ3ZlIG5ldmVyIGhlYXJkIGFueSBpbmtsaW5nIG9mIHRoYXQgYmVpbmcgYSBwcmFjdGlj
YWwgcHJvYmxlbSA6Lwo+IAoKT0ssIHNvIGtlZXAgdGhlIGNvZGUgb2YgdGhlIFBNQ0cgZHJpdmVy
IHVuY2hhbmdlZC4gQ3VycmVudGx5LCBQTUNHIHJlc291cmNlcyBtYXkgbm90IG92ZXJsYXAgd2l0
aCBvdGhlciBkZXZpY2VzIGV4Y2VwdCBTTU1VdjMuCgpJIHNvbWV0aW1lcyB1c2UgImNhdCAvcHJv
Yy9pb29tZW0iIHRvIGxvb2sgdXAgdGhlIGJhc2UgYWRkcmVzcywgdGhlbiB1c2UgZGV2bWVtIGNv
bW1hbmQgdG8gcXVlcnkgdGhlIHJlZ2lzdGVyIGNvbnRlbnQuCgo+IFJvYmluLgo+IAo+Pj4+Pj4+
ICsKPj4+Pj4+PiArwqDCoMKgIHJldHVybiBiYXNlOwo+Pj4+Pj4+ICt9Cj4+Pj4+Pj4gKwo+Pj4+
Pj4+IMKgwqDCoCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCj4+Pj4+Pj4gwqDCoMKgIHsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qg
c21tdV9wbXUgKnNtbXVfcG11Owo+Pj4+Pj4+IEBAIC03OTMsNyArODMxLDcgQEAgc3RhdGljIGlu
dCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNhcGFiaWxpdGllc8KgwqDCoCA9IFBFUkZfUE1VX0NBUF9O
T19FWENMVURFLAo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIH07Cj4+Pj4+Pj4gwqDCoMKgIC3CoMKg
wqAgc21tdV9wbXUtPnJlZ19iYXNlID0gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVz
b3VyY2UocGRldiwgMCwgJnJlc18wKTsKPj4+Pj4+PiArwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFz
ZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmcmVzXzApOwo+
Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21tdV9wbXUtPnJlZ19iYXNlKSkKPj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXVfcG11LT5yZWdf
YmFzZSk7Cj4+Pj4+Pj4gwqDCoMKgIEBAIC04MDEsNyArODM5LDcgQEAgc3RhdGljIGludCBzbW11
X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+Pj4+IMKgwqDCoCDC
oMKgwqDCoMKgIC8qIERldGVybWluZSBpZiBwYWdlIDEgaXMgcHJlc2VudCAqLwo+Pj4+Pj4+IMKg
wqDCoMKgwqDCoMKgIGlmIChjZmdyICYgU01NVV9QTUNHX0NGR1JfUkVMT0NfQ1RSUykgewo+Pj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBzbW11X3BtdS0+cmVsb2NfYmFzZSA9IGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZShwZGV2LCAxKTsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgc21tdV9w
bXUtPnJlbG9jX2Jhc2UgPSBzbW11X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwg
MSwgTlVMTCk7Cj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXVf
cG11LT5yZWxvY19iYXNlKSkKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIFBUUl9FUlIoc21tdV9wbXUtPnJlbG9jX2Jhc2UpOwo+Pj4+Pj4+IMKgwqDCoMKgwqDC
oMKgIH0gZWxzZSB7Cj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiAuCj4+Pj4+Pgo+Pj4+Cj4+Pgo+Pj4g
Lgo+Pj4KPj4KPiAKPiAuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
