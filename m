Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC0C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 09:26:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541292310C
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 09:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541292310C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D4AFF86C82;
	Wed, 20 Jan 2021 09:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqzy5o0rcM8s; Wed, 20 Jan 2021 09:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D8A8186A98;
	Wed, 20 Jan 2021 09:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C576CC088B;
	Wed, 20 Jan 2021 09:26:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F787C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 219AF203DC
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KL34jMAhuOlp for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 8B7A7203AC
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 09:26:39 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DLKrP3nGLzj87l;
 Wed, 20 Jan 2021 17:25:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 20 Jan 2021 17:26:28 +0800
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
Message-ID: <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
Date: Wed, 20 Jan 2021 17:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Neil Leeder <nleeder@codeaurora.org>
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

CgpPbiAyMDIxLzEvMjAgMTE6MzcsIExlaXpoZW4gKFRodW5kZXJUb3duKSB3cm90ZToKPiAKPiAK
PiBPbiAyMDIxLzEvMTkgMjA6MzIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMS0wMS0x
OSAwMTo1OSwgWmhlbiBMZWkgd3JvdGU6Cj4+PiBTb21lIFNNTVV2MyBpbXBsZW1lbnRhdGlvbiBl
bWJlZCB0aGUgUGVyZiBNb25pdG9yIEdyb3VwIFJlZ2lzdGVycyAoUE1DRykKPj4+IGluc2lkZSB0
aGUgZmlyc3QgNjRrQiByZWdpb24gb2YgdGhlIFNNTVUuIFNpbmNlIFNNTVUgYW5kIFBNQ0cgYXJl
IG1hbmFnZWQKPj4+IGJ5IHR3byBzZXBhcmF0ZSBkcml2ZXJzLCBhbmQgdGhpcyBkcml2ZXIgZGVw
ZW5kcyBvbiBBUk1fU01NVV9WMywgc28gdGhlCj4+PiBTTU1VIGRyaXZlciByZXNlcnZlcyB0aGUg
Y29ycmVzcG9uZGluZyByZXNvdXJjZSBmaXJzdCwgdGhpcyBkcml2ZXIgc2hvdWxkCj4+PiBub3Qg
cmVzZXJ2ZSB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBhZ2Fpbi4gT3RoZXJ3aXNlLCBhIHJl
c291cmNlCj4+PiByZXNlcnZhdGlvbiBjb25mbGljdCBpcyByZXBvcnRlZCBkdXJpbmcgYm9vdC4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5j
b20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jIHwgNDIgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4+PiDCoCAxIGZpbGUgY2hh
bmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMgYi9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2
M19wbXUuYwo+Pj4gaW5kZXggNzQ0NzRiYjMyMmMzZjI2Li5kY2NlMDg1NDMxYzZjZTggMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYwo+Pj4gKysrIGIvZHJpdmVy
cy9wZXJmL2FybV9zbW11djNfcG11LmMKPj4+IEBAIC03NjEsNiArNzYxLDQ0IEBAIHN0YXRpYyB2
b2lkIHNtbXVfcG11X2dldF9hY3BpX29wdGlvbnMoc3RydWN0IHNtbXVfcG11ICpzbW11X3BtdSkK
Pj4+IMKgwqDCoMKgwqAgZGV2X25vdGljZShzbW11X3BtdS0+ZGV2LCAib3B0aW9uIG1hc2sgMHgl
eFxuIiwgc21tdV9wbXUtPm9wdGlvbnMpOwo+Pj4gwqAgfQo+Pj4gwqAgK3N0YXRpYyB2b2lkIF9f
aW9tZW0gKgo+Pj4gK3NtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdW5zaWduZWQgaW50IGluZGV4LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IHJlc291cmNlICoqb3V0X3JlcykKPj4+ICt7Cj4+PiArwqDCoMKgIGludCBy
ZXQ7Cj4+PiArwqDCoMKgIHZvaWQgX19pb21lbSAqYmFzZTsKPj4+ICvCoMKgwqAgc3RydWN0IHJl
c291cmNlICpyZXM7Cj4+PiArCj4+PiArwqDCoMKgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgaW5kZXgpOwo+Pj4gK8KgwqDCoCBpZiAoIXJlcykgewo+
Pj4gK8KgwqDCoMKgwqDCoMKgIGRldl9lcnIoJnBkZXYtPmRldiwgImludmFsaWQgcmVzb3VyY2Vc
biIpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBJT01FTV9FUlJfUFRSKC1FSU5WQUwpOwo+
Pj4gK8KgwqDCoCB9Cj4+PiArwqDCoMKgIGlmIChvdXRfcmVzKQo+Pj4gK8KgwqDCoMKgwqDCoMKg
ICpvdXRfcmVzID0gcmVzOwo+Pj4gKwo+Pj4gK8KgwqDCoCByZXQgPSByZWdpb25faW50ZXJzZWN0
cyhyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcyksCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIElPUkVTT1VSQ0VfTUVNLCBJT1JFU19ERVNDX05PTkUpOwo+Pj4gK8KgwqDC
oCBpZiAocmV0ID09IFJFR0lPTl9JTlRFUlNFQ1RTKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgLyoK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc291cmNlIGhhcyBhbHJlYWR5IGJlZW4gcmVz
ZXJ2ZWQgYnkgdGhlIFNNTVV2MyBkcml2ZXIuCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIERvbid0
IHJlc2VydmUgaXQgYWdhaW4sIGp1c3QgZG8gZGV2bV9pb3JlbWFwKCkuCj4+PiArwqDCoMKgwqDC
oMKgwqDCoCAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJhc2UgPSBkZXZtX2lvcmVtYXAoJnBkZXYt
PmRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKPj4+ICvCoMKgwqAgfSBlbHNl
IHsKPj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBUaGUgcmVz
b3VyY2UgbWF5IGhhdmUgbm90IGJlZW4gcmVzZXJ2ZWQgYnkgYW55IGRyaXZlciwgb3IKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgICogaGFzIGJlZW4gcmVzZXJ2ZWQgYnV0IG5vdCB0eXBlIElPUkVTT1VS
Q0VfTUVNLiBJbiB0aGUgbGF0dGVyCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIGNhc2UsIGRldm1f
aW9yZW1hcF9yZXNvdXJjZSgpIHJlcG9ydHMgYSBjb25mbGljdCBhbmQgcmV0dXJucwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqAgKiBJT01FTV9FUlJfUFRSKC1FQlVTWSkuCj4+PiArwqDCoMKgwqDCoMKg
wqDCoCAqLwo+Pj4gK8KgwqDCoMKgwqDCoMKgIGJhc2UgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2Uo
JnBkZXYtPmRldiwgcmVzKTsKPj4+ICvCoMKgwqAgfQo+Pgo+PiBXaGF0IGlmIHRoZSBQTUNHIGRy
aXZlciBzaW1wbHkgaGFwcGVucyB0byBwcm9iZSBmaXJzdD8KPiAKPiBUaGVyZSBhcmUgNCBjYXNl
czoKPiAxKSBBUk1fU01NVV9WMz1tLCBBUk1fU01NVV9WM19QTVU9eQo+ICAgIEl0J3Mgbm90IGFs
bG93ZWQuIEJlY2FzZTogQVJNX1NNTVVfVjNfUE1VIGRlcGVuZHMgb24gQVJNX1NNTVVfVjMKPiAg
ICBjb25maWcgQVJNX1NNTVVfVjNfUE1VCj4gICAgICAgICAgdHJpc3RhdGUgIkFSTSBTTU1VdjMg
UGVyZm9ybWFuY2UgTW9uaXRvcnMgRXh0ZW5zaW9uIgo+ICAgICAgICAgIGRlcGVuZHMgb24gQVJN
NjQgJiYgQUNQSSAmJiBBUk1fU01NVV9WMwo+IAo+IDIpIEFSTV9TTU1VX1YzPXksIEFSTV9TTU1V
X1YzX1BNVT1tCj4gICAgTm8gcHJvYmxlbSwgU01NVXYzIHdpbGwgYmUgaW5pdGlhbGl6ZWQgZmly
c3QuCj4gCj4gMykgQVJNX1NNTVVfVjM9eSwgQVJNX1NNTVVfVjNfUE1VPXkKPiAgICB2aSBkcml2
ZXJzL01ha2VmaWxlCj4gICAgNjAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAgICAgICArPSBp
b21tdS8KPiAgICAxNzIgb2JqLSQoQ09ORklHX1BFUkZfRVZFTlRTKSAgICAgICArPSBwZXJmLwo+
IAo+ICAgIFRoaXMgbGluayBzZXF1ZW5jZSBlbnN1cmUgdGhhdCBTTU1VdjMgZHJpdmVyIHdpbGwg
YmUgaW5pdGlhbGl6ZWQgZmlyc3QuCj4gICAgVGhleSBhcmUgY3VycmVudGx5IGF0IHRoZSBzYW1l
IGluaXRpYWxpemF0aW9uIGxldmVsLgo+IAo+IDQpIEFSTV9TTU1VX1YzPW0sIEFSTV9TTU1VX1Yz
X1BNVT1tCj4gICAgU29ycnksIEkgdGhvdWdodCBtb2R1bGUgZGVwZW5kZW5jaWVzIHdlcmUgZ2Vu
ZXJhdGVkIGJhc2VkIG9uICJkZXBlbmRzIG9uIi4KPiAgICBCdXQgSSB0cmllZCBpdCB0b2Rhee+8
jG1vZHVsZSBkZXBlbmRlbmNpZXMgYXJlIGdlbmVyYXRlZCBvbmx5IHdoZW4gc3ltYm9sCj4gICAg
ZGVwZW5kZW5jaWVzIGV4aXN0LiBJIHNob3VsZCB1c2UgTU9EVUxFX1NPRlRERVAoKSB0byBleHBs
aWNpdGx5IG1hcmsgdGhlCj4gICAgZGVwZW5kZW5jeS4gSSB3aWxsIHNlbmQgVjIgbGF0ZXIuCj4g
CgpIaSBSb2JpbjoKICBJIHRoaW5rIEkgbWlzdW5kZXJzdG9vZCB5b3VyIHF1ZXN0aW9uLiBUaGUg
cHJvYmUoKSBpbnN0ZWFkIG9mIG1vZHVsZV9pbml0KCkKZGV0ZXJtaW5lcyB0aGUgdGltZSBmb3Ig
cmVzZXJ2aW5nIHJlZ2lzdGVyIHNwYWNlIHJlc291cmNlcy4gIFNvIHdlJ2QgYmV0dGVyCnJlc2Vy
dmUgbXVsdGlwbGUgc21hbGwgYmxvY2tzIG9mIHJlc291cmNlcyBpbiBTTU1VdjMgYnV0IHBlcmZv
cm0gaW9yZW1hcCgpIGZvcgp0aGUgZW50aXJlIHJlc291cmNlLCBpZiB0aGUgcHJvYmUoKSBvZiB0
aGUgUE1DRyBvY2N1cnMgZmlyc3QuCiAgSSdsbCByZWZpbmUgdGhlc2UgcGF0Y2hlcyB0byBtYWtl
IGJvdGggaW5pdGlhbGl6YXRpb24gc2VxdWVuY2VzIHdvcmsgd2VsbC4KSSdtIHRyeWluZyB0byBz
ZW5kIFYyIHRoaXMgd2Vlay4KCj4gCj4+Cj4+IFJvYmluLgo+Pgo+Pj4gKwo+Pj4gK8KgwqDCoCBy
ZXR1cm4gYmFzZTsKPj4+ICt9Cj4+PiArCj4+PiDCoCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0
cnVjdCBzbW11X3BtdSAqc21tdV9wbXU7Cj4+PiBAQCAtNzkzLDcgKzgzMSw3IEBAIHN0YXRpYyBp
bnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCAuY2FwYWJpbGl0aWVzwqDCoMKgID0gUEVSRl9QTVVfQ0FQX05PX0VYQ0xV
REUsCj4+PiDCoMKgwqDCoMKgIH07Cj4+PiDCoCAtwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9
IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsICZyZXNfMCk7
Cj4+PiArwqDCoMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1h
cF9yZXNvdXJjZShwZGV2LCAwLCAmcmVzXzApOwo+Pj4gwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNt
bXVfcG11LT5yZWdfYmFzZSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIo
c21tdV9wbXUtPnJlZ19iYXNlKTsKPj4+IMKgIEBAIC04MDEsNyArODM5LDcgQEAgc3RhdGljIGlu
dCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4gwqAgwqDC
oMKgwqDCoCAvKiBEZXRlcm1pbmUgaWYgcGFnZSAxIGlzIHByZXNlbnQgKi8KPj4+IMKgwqDCoMKg
wqAgaWYgKGNmZ3IgJiBTTU1VX1BNQ0dfQ0ZHUl9SRUxPQ19DVFJTKSB7Cj4+PiAtwqDCoMKgwqDC
oMKgwqAgc21tdV9wbXUtPnJlbG9jX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UocGRldiwgMSk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgc21tdV9wbXUtPnJlbG9jX2Jhc2UgPSBz
bW11X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSwgTlVMTCk7Cj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKElTX0VSUihzbW11X3BtdS0+cmVsb2NfYmFzZSkpCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihzbW11X3BtdS0+cmVsb2NfYmFz
ZSk7Cj4+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+Pgo+Pgo+PiAuCj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
