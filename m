Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA9C433E0
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 13:27:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C6423380
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 13:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C6423380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 96B6A204FE;
	Wed, 20 Jan 2021 13:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QpjyPHUqntYj; Wed, 20 Jan 2021 13:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC56E20410;
	Wed, 20 Jan 2021 13:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D399FC088B;
	Wed, 20 Jan 2021 13:27:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1E43C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AF73B870F2
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lt69Ke4t21a for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:27:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7291C870C4
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 13:27:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 905A5D6E;
 Wed, 20 Jan 2021 05:27:51 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76613F66E;
 Wed, 20 Jan 2021 05:27:49 -0800 (PST)
Subject: Re: [PATCH 1/2] perf/smmuv3: Don't reserve the register space that
 overlaps with the SMMUv3
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210119015951.1042-1-thunder.leizhen@huawei.com>
 <20210119015951.1042-2-thunder.leizhen@huawei.com>
 <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
 <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
 <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f6fde527-8c87-1128-52ca-77d096194eb6@arm.com>
Date: Wed, 20 Jan 2021 13:27:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9ad3c863-ec80-e177-4d11-24d1f706b4af@huawei.com>
Content-Language: en-GB
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMS0wMS0yMCAwOToyNiwgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+IAo+IAo+
IE9uIDIwMjEvMS8yMCAxMTozNywgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pgo+Pgo+
PiBPbiAyMDIxLzEvMTkgMjA6MzIsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjEtMDEt
MTkgMDE6NTksIFpoZW4gTGVpIHdyb3RlOgo+Pj4+IFNvbWUgU01NVXYzIGltcGxlbWVudGF0aW9u
IGVtYmVkIHRoZSBQZXJmIE1vbml0b3IgR3JvdXAgUmVnaXN0ZXJzIChQTUNHKQo+Pj4+IGluc2lk
ZSB0aGUgZmlyc3QgNjRrQiByZWdpb24gb2YgdGhlIFNNTVUuIFNpbmNlIFNNTVUgYW5kIFBNQ0cg
YXJlIG1hbmFnZWQKPj4+PiBieSB0d28gc2VwYXJhdGUgZHJpdmVycywgYW5kIHRoaXMgZHJpdmVy
IGRlcGVuZHMgb24gQVJNX1NNTVVfVjMsIHNvIHRoZQo+Pj4+IFNNTVUgZHJpdmVyIHJlc2VydmVz
IHRoZSBjb3JyZXNwb25kaW5nIHJlc291cmNlIGZpcnN0LCB0aGlzIGRyaXZlciBzaG91bGQKPj4+
PiBub3QgcmVzZXJ2ZSB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBhZ2Fpbi4gT3RoZXJ3aXNl
LCBhIHJlc291cmNlCj4+Pj4gcmVzZXJ2YXRpb24gY29uZmxpY3QgaXMgcmVwb3J0ZWQgZHVyaW5n
IGJvb3QuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVu
QGh1YXdlaS5jb20+Cj4+Pj4gLS0tCj4+Pj4gIMKgIGRyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3Bt
dS5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4+Pj4g
IMKgIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jIGIvZHJpdmVy
cy9wZXJmL2FybV9zbW11djNfcG11LmMKPj4+PiBpbmRleCA3NDQ3NGJiMzIyYzNmMjYuLmRjY2Uw
ODU0MzFjNmNlOCAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUu
Ywo+Pj4+ICsrKyBiL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jCj4+Pj4gQEAgLTc2MSw2
ICs3NjEsNDQgQEAgc3RhdGljIHZvaWQgc21tdV9wbXVfZ2V0X2FjcGlfb3B0aW9ucyhzdHJ1Y3Qg
c21tdV9wbXUgKnNtbXVfcG11KQo+Pj4+ICDCoMKgwqDCoMKgIGRldl9ub3RpY2Uoc21tdV9wbXUt
PmRldiwgIm9wdGlvbiBtYXNrIDB4JXhcbiIsIHNtbXVfcG11LT5vcHRpb25zKTsKPj4+PiAgwqAg
fQo+Pj4+ICDCoCArc3RhdGljIHZvaWQgX19pb21lbSAqCj4+Pj4gK3NtbXVfcG11X2dldF9hbmRf
aW9yZW1hcF9yZXNvdXJjZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpbmRleCwKPj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmVzb3VyY2UgKipvdXRf
cmVzKQo+Pj4+ICt7Cj4+Pj4gK8KgwqDCoCBpbnQgcmV0Owo+Pj4+ICvCoMKgwqAgdm9pZCBfX2lv
bWVtICpiYXNlOwo+Pj4+ICvCoMKgwqAgc3RydWN0IHJlc291cmNlICpyZXM7Cj4+Pj4gKwo+Pj4+
ICvCoMKgwqAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVN
LCBpbmRleCk7Cj4+Pj4gK8KgwqDCoCBpZiAoIXJlcykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBk
ZXZfZXJyKCZwZGV2LT5kZXYsICJpbnZhbGlkIHJlc291cmNlXG4iKTsKPj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIElPTUVNX0VSUl9QVFIoLUVJTlZBTCk7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pj4g
K8KgwqDCoCBpZiAob3V0X3JlcykKPj4+PiArwqDCoMKgwqDCoMKgwqAgKm91dF9yZXMgPSByZXM7
Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgcmV0ID0gcmVnaW9uX2ludGVyc2VjdHMocmVzLT5zdGFydCwg
cmVzb3VyY2Vfc2l6ZShyZXMpLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SU9SRVNPVVJDRV9NRU0sIElPUkVTX0RFU0NfTk9ORSk7Cj4+Pj4gK8KgwqDCoCBpZiAocmV0ID09
IFJFR0lPTl9JTlRFUlNFQ1RTKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBUaGUgcmVzb3VyY2UgaGFzIGFscmVhZHkgYmVlbiByZXNlcnZlZCBieSB0
aGUgU01NVXYzIGRyaXZlci4KPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIERvbid0IHJlc2VydmUg
aXQgYWdhaW4sIGp1c3QgZG8gZGV2bV9pb3JlbWFwKCkuCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAg
Ki8KPj4+PiArwqDCoMKgwqDCoMKgwqAgYmFzZSA9IGRldm1faW9yZW1hcCgmcGRldi0+ZGV2LCBy
ZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOwo+Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+
PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSByZXNvdXJj
ZSBtYXkgaGF2ZSBub3QgYmVlbiByZXNlcnZlZCBieSBhbnkgZHJpdmVyLCBvcgo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgICogaGFzIGJlZW4gcmVzZXJ2ZWQgYnV0IG5vdCB0eXBlIElPUkVTT1VSQ0Vf
TUVNLiBJbiB0aGUgbGF0dGVyCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBjYXNlLCBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoKSByZXBvcnRzIGEgY29uZmxpY3QgYW5kIHJldHVybnMKPj4+PiArwqDC
oMKgwqDCoMKgwqDCoCAqIElPTUVNX0VSUl9QVFIoLUVCVVNZKS4KPj4+PiArwqDCoMKgwqDCoMKg
wqDCoCAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBiYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KCZwZGV2LT5kZXYsIHJlcyk7Cj4+Pj4gK8KgwqDCoCB9Cj4+Pgo+Pj4gV2hhdCBpZiB0aGUgUE1D
RyBkcml2ZXIgc2ltcGx5IGhhcHBlbnMgdG8gcHJvYmUgZmlyc3Q/Cj4+Cj4+IFRoZXJlIGFyZSA0
IGNhc2VzOgo+PiAxKSBBUk1fU01NVV9WMz1tLCBBUk1fU01NVV9WM19QTVU9eQo+PiAgICAgSXQn
cyBub3QgYWxsb3dlZC4gQmVjYXNlOiBBUk1fU01NVV9WM19QTVUgZGVwZW5kcyBvbiBBUk1fU01N
VV9WMwo+PiAgICAgY29uZmlnIEFSTV9TTU1VX1YzX1BNVQo+PiAgICAgICAgICAgdHJpc3RhdGUg
IkFSTSBTTU1VdjMgUGVyZm9ybWFuY2UgTW9uaXRvcnMgRXh0ZW5zaW9uIgo+PiAgICAgICAgICAg
ZGVwZW5kcyBvbiBBUk02NCAmJiBBQ1BJICYmIEFSTV9TTU1VX1YzCj4+Cj4+IDIpIEFSTV9TTU1V
X1YzPXksIEFSTV9TTU1VX1YzX1BNVT1tCj4+ICAgICBObyBwcm9ibGVtLCBTTU1VdjMgd2lsbCBi
ZSBpbml0aWFsaXplZCBmaXJzdC4KPj4KPj4gMykgQVJNX1NNTVVfVjM9eSwgQVJNX1NNTVVfVjNf
UE1VPXkKPj4gICAgIHZpIGRyaXZlcnMvTWFrZWZpbGUKPj4gICAgIDYwIG9iai15ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKz0gaW9tbXUvCj4+ICAgICAxNzIgb2JqLSQoQ09ORklHX1BFUkZf
RVZFTlRTKSAgICAgICArPSBwZXJmLwo+Pgo+PiAgICAgVGhpcyBsaW5rIHNlcXVlbmNlIGVuc3Vy
ZSB0aGF0IFNNTVV2MyBkcml2ZXIgd2lsbCBiZSBpbml0aWFsaXplZCBmaXJzdC4KPj4gICAgIFRo
ZXkgYXJlIGN1cnJlbnRseSBhdCB0aGUgc2FtZSBpbml0aWFsaXphdGlvbiBsZXZlbC4KPj4KPj4g
NCkgQVJNX1NNTVVfVjM9bSwgQVJNX1NNTVVfVjNfUE1VPW0KPj4gICAgIFNvcnJ5LCBJIHRob3Vn
aHQgbW9kdWxlIGRlcGVuZGVuY2llcyB3ZXJlIGdlbmVyYXRlZCBiYXNlZCBvbiAiZGVwZW5kcyBv
biIuCj4+ICAgICBCdXQgSSB0cmllZCBpdCB0b2Rhee+8jG1vZHVsZSBkZXBlbmRlbmNpZXMgYXJl
IGdlbmVyYXRlZCBvbmx5IHdoZW4gc3ltYm9sCj4+ICAgICBkZXBlbmRlbmNpZXMgZXhpc3QuIEkg
c2hvdWxkIHVzZSBNT0RVTEVfU09GVERFUCgpIHRvIGV4cGxpY2l0bHkgbWFyayB0aGUKPj4gICAg
IGRlcGVuZGVuY3kuIEkgd2lsbCBzZW5kIFYyIGxhdGVyLgo+Pgo+IAo+IEhpIFJvYmluOgo+ICAg
IEkgdGhpbmsgSSBtaXN1bmRlcnN0b29kIHlvdXIgcXVlc3Rpb24uIFRoZSBwcm9iZSgpIGluc3Rl
YWQgb2YgbW9kdWxlX2luaXQoKQo+IGRldGVybWluZXMgdGhlIHRpbWUgZm9yIHJlc2VydmluZyBy
ZWdpc3RlciBzcGFjZSByZXNvdXJjZXMuICBTbyB3ZSdkIGJldHRlcgo+IHJlc2VydmUgbXVsdGlw
bGUgc21hbGwgYmxvY2tzIG9mIHJlc291cmNlcyBpbiBTTU1VdjMgYnV0IHBlcmZvcm0gaW9yZW1h
cCgpIGZvcgo+IHRoZSBlbnRpcmUgcmVzb3VyY2UsIGlmIHRoZSBwcm9iZSgpIG9mIHRoZSBQTUNH
IG9jY3VycyBmaXJzdC4KPiAgICBJJ2xsIHJlZmluZSB0aGVzZSBwYXRjaGVzIHRvIG1ha2UgYm90
aCBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZXMgd29yayB3ZWxsLgo+IEknbSB0cnlpbmcgdG8gc2Vu
ZCBWMiB0aGlzIHdlZWsuCgpUaGVyZSdzIHN0aWxsIHRoZSBwb3NzaWJpbGl0eSB0aGF0IGEgUE1D
RyBpcyBpbXBsZW1lbnRlZCBpbiBhIHJvb3QgCmNvbXBsZXggb3Igc29tZSBvdGhlciBkZXZpY2Ug
dGhhdCBpc24ndCBhbiBTTU1VLCBzbyBhcyBJJ3ZlIHNhaWQgYmVmb3JlLCAKbm9uZSBvZiB0aGlz
IHRyaWNrZXJ5IHJlYWxseSBzY2FsZXMuCgpBcyBmYXIgYXMgSSB1bmRlcnN0YW5kIGl0LCB0aGUg
bWFpbiBwb2ludCBvZiByZXNlcnZpbmcgcmVzb3VyY2VzIGlzIHRvIApjYXRjaCBidWdzIHdoZXJl
IHRoaW5ncyBkZWZpbml0ZWx5IHNob3VsZCBub3QgYmUgb3ZlcmxhcHBpbmcuIFBNQ0dzIGFyZSAK
YnkgZGVmaW5pdGlvbiBwYXJ0IG9mIHNvbWUgb3RoZXIgZGV2aWNlLCBzbyBpbiBnZW5lcmFsIHRo
ZXkgKmNhbiogYmUgCmV4cGVjdGVkIHRvIG92ZXJsYXAgd2l0aCB3aGF0ZXZlciBkZXZpY2UgdGhh
dCBpcy4gSSBzdGlsbCB0aGluayBpdCdzIAptb3N0IGxvZ2ljYWwgdG8gc2ltcGx5ICpub3QqIHRy
eSB0byByZXNlcnZlIFBNQ0cgcmVzb3VyY2VzIGF0IGFsbC4KClJvYmluLgoKPj4+PiArCj4+Pj4g
K8KgwqDCoCByZXR1cm4gYmFzZTsKPj4+PiArfQo+Pj4+ICsKPj4+PiAgwqAgc3RhdGljIGludCBz
bW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4+ICDCoCB7Cj4+
Pj4gIMKgwqDCoMKgwqAgc3RydWN0IHNtbXVfcG11ICpzbW11X3BtdTsKPj4+PiBAQCAtNzkzLDcg
KzgzMSw3IEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIC5jYXBhYmlsaXRpZXPCoMKgwqAgPSBQ
RVJGX1BNVV9DQVBfTk9fRVhDTFVERSwKPj4+PiAgwqDCoMKgwqDCoCB9Owo+Pj4+ICDCoCAtwqDC
oMKgIHNtbXVfcG11LT5yZWdfYmFzZSA9IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDAsICZyZXNfMCk7Cj4+Pj4gK8KgwqDCoCBzbW11X3BtdS0+cmVnX2Jhc2Ug
PSBzbW11X3BtdV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCwgJnJlc18wKTsKPj4+
PiAgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKHNtbXVfcG11LT5yZWdfYmFzZSkpCj4+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihzbW11X3BtdS0+cmVnX2Jhc2UpOwo+Pj4+ICDC
oCBAQCAtODAxLDcgKzgzOSw3IEBAIHN0YXRpYyBpbnQgc21tdV9wbXVfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKPj4+PiAgwqAgwqDCoMKgwqDCoCAvKiBEZXRlcm1pbmUgaWYg
cGFnZSAxIGlzIHByZXNlbnQgKi8KPj4+PiAgwqDCoMKgwqDCoCBpZiAoY2ZnciAmIFNNTVVfUE1D
R19DRkdSX1JFTE9DX0NUUlMpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgc21tdV9wbXUtPnJlbG9j
X2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSk7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHNtbXVfcG11LT5yZWxvY19iYXNlID0gc21tdV9wbXVfZ2V0X2FuZF9pb3Jl
bWFwX3Jlc291cmNlKHBkZXYsIDEsIE5VTEwpOwo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KElTX0VSUihzbW11X3BtdS0+cmVsb2NfYmFzZSkpCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXVfcG11LT5yZWxvY19iYXNlKTsKPj4+PiAgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+Pj4+Cj4+Pgo+Pj4gLgo+Pj4KPiAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
