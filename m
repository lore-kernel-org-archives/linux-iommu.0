Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2BC433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 03:37:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E428D22509
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 03:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E428D22509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9E3F320519;
	Wed, 20 Jan 2021 03:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGS1utYTtSex; Wed, 20 Jan 2021 03:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D7B2E204F6;
	Wed, 20 Jan 2021 03:37:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1986C088B;
	Wed, 20 Jan 2021 03:37:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 594E2C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 03:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55A9886C6D
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 03:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6yaks114jJb for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 03:37:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 24B2186A98
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 03:37:20 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DLB574d9Pz7XgW;
 Wed, 20 Jan 2021 11:36:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 20 Jan 2021 11:37:07 +0800
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
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a2d7d94c-8e4e-d91d-8587-7a5b3594b4ca@huawei.com>
Date: Wed, 20 Jan 2021 11:37:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <30665cd6-b438-1d1d-7445-9e45e240f79a@arm.com>
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

CgpPbiAyMDIxLzEvMTkgMjA6MzIsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAxLTE5
IDAxOjU5LCBaaGVuIExlaSB3cm90ZToKPj4gU29tZSBTTU1VdjMgaW1wbGVtZW50YXRpb24gZW1i
ZWQgdGhlIFBlcmYgTW9uaXRvciBHcm91cCBSZWdpc3RlcnMgKFBNQ0cpCj4+IGluc2lkZSB0aGUg
Zmlyc3QgNjRrQiByZWdpb24gb2YgdGhlIFNNTVUuIFNpbmNlIFNNTVUgYW5kIFBNQ0cgYXJlIG1h
bmFnZWQKPj4gYnkgdHdvIHNlcGFyYXRlIGRyaXZlcnMsIGFuZCB0aGlzIGRyaXZlciBkZXBlbmRz
IG9uIEFSTV9TTU1VX1YzLCBzbyB0aGUKPj4gU01NVSBkcml2ZXIgcmVzZXJ2ZXMgdGhlIGNvcnJl
c3BvbmRpbmcgcmVzb3VyY2UgZmlyc3QsIHRoaXMgZHJpdmVyIHNob3VsZAo+PiBub3QgcmVzZXJ2
ZSB0aGUgY29ycmVzcG9uZGluZyByZXNvdXJjZSBhZ2Fpbi4gT3RoZXJ3aXNlLCBhIHJlc291cmNl
Cj4+IHJlc2VydmF0aW9uIGNvbmZsaWN0IGlzIHJlcG9ydGVkIGR1cmluZyBib290Lgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuIExlaSA8dGh1bmRlci5sZWl6aGVuQGh1YXdlaS5jb20+Cj4+IC0t
LQo+PiDCoCBkcml2ZXJzL3BlcmYvYXJtX3NtbXV2M19wbXUuYyB8IDQyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNDAgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVy
Zi9hcm1fc21tdXYzX3BtdS5jIGIvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMKPj4gaW5k
ZXggNzQ0NzRiYjMyMmMzZjI2Li5kY2NlMDg1NDMxYzZjZTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvcGVyZi9hcm1fc21tdXYzX3BtdS5jCj4+ICsrKyBiL2RyaXZlcnMvcGVyZi9hcm1fc21tdXYz
X3BtdS5jCj4+IEBAIC03NjEsNiArNzYxLDQ0IEBAIHN0YXRpYyB2b2lkIHNtbXVfcG11X2dldF9h
Y3BpX29wdGlvbnMoc3RydWN0IHNtbXVfcG11ICpzbW11X3BtdSkKPj4gwqDCoMKgwqDCoCBkZXZf
bm90aWNlKHNtbXVfcG11LT5kZXYsICJvcHRpb24gbWFzayAweCV4XG4iLCBzbW11X3BtdS0+b3B0
aW9ucyk7Cj4+IMKgIH0KPj4gwqAgK3N0YXRpYyB2b2lkIF9faW9tZW0gKgo+PiArc21tdV9wbXVf
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpbmRleCwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJlc291cmNlICoq
b3V0X3JlcykKPj4gK3sKPj4gK8KgwqDCoCBpbnQgcmV0Owo+PiArwqDCoMKgIHZvaWQgX19pb21l
bSAqYmFzZTsKPj4gK8KgwqDCoCBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKPj4gKwo+PiArwqDCoMKg
IHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgaW5kZXgp
Owo+PiArwqDCoMKgIGlmICghcmVzKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZwZGV2
LT5kZXYsICJpbnZhbGlkIHJlc291cmNlXG4iKTsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBJ
T01FTV9FUlJfUFRSKC1FSU5WQUwpOwo+PiArwqDCoMKgIH0KPj4gK8KgwqDCoCBpZiAob3V0X3Jl
cykKPj4gK8KgwqDCoMKgwqDCoMKgICpvdXRfcmVzID0gcmVzOwo+PiArCj4+ICvCoMKgwqAgcmV0
ID0gcmVnaW9uX2ludGVyc2VjdHMocmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpLAo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPUkVTT1VSQ0VfTUVNLCBJT1JFU19ERVND
X05PTkUpOwo+PiArwqDCoMKgIGlmIChyZXQgPT0gUkVHSU9OX0lOVEVSU0VDVFMpIHsKPj4gK8Kg
wqDCoMKgwqDCoMKgIC8qCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIHJlc291cmNlIGhhcyBh
bHJlYWR5IGJlZW4gcmVzZXJ2ZWQgYnkgdGhlIFNNTVV2MyBkcml2ZXIuCj4+ICvCoMKgwqDCoMKg
wqDCoMKgICogRG9uJ3QgcmVzZXJ2ZSBpdCBhZ2FpbiwganVzdCBkbyBkZXZtX2lvcmVtYXAoKS4K
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPj4gK8KgwqDCoMKgwqDCoMKgIGJhc2UgPSBkZXZtX2lv
cmVtYXAoJnBkZXYtPmRldiwgcmVzLT5zdGFydCwgcmVzb3VyY2Vfc2l6ZShyZXMpKTsKPj4gK8Kg
wqDCoCB9IGVsc2Ugewo+PiArwqDCoMKgwqDCoMKgwqAgLyoKPj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBUaGUgcmVzb3VyY2UgbWF5IGhhdmUgbm90IGJlZW4gcmVzZXJ2ZWQgYnkgYW55IGRyaXZlciwg
b3IKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBoYXMgYmVlbiByZXNlcnZlZCBidXQgbm90IHR5cGUg
SU9SRVNPVVJDRV9NRU0uIEluIHRoZSBsYXR0ZXIKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBjYXNl
LCBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSByZXBvcnRzIGEgY29uZmxpY3QgYW5kIHJldHVybnMK
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBJT01FTV9FUlJfUFRSKC1FQlVTWSkuCj4+ICvCoMKgwqDC
oMKgwqDCoMKgICovCj4+ICvCoMKgwqDCoMKgwqDCoCBiYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291
cmNlKCZwZGV2LT5kZXYsIHJlcyk7Cj4+ICvCoMKgwqAgfQo+IAo+IFdoYXQgaWYgdGhlIFBNQ0cg
ZHJpdmVyIHNpbXBseSBoYXBwZW5zIHRvIHByb2JlIGZpcnN0PwoKVGhlcmUgYXJlIDQgY2FzZXM6
CjEpIEFSTV9TTU1VX1YzPW0sIEFSTV9TTU1VX1YzX1BNVT15CiAgIEl0J3Mgbm90IGFsbG93ZWQu
IEJlY2FzZTogQVJNX1NNTVVfVjNfUE1VIGRlcGVuZHMgb24gQVJNX1NNTVVfVjMKICAgY29uZmln
IEFSTV9TTU1VX1YzX1BNVQogICAgICAgICB0cmlzdGF0ZSAiQVJNIFNNTVV2MyBQZXJmb3JtYW5j
ZSBNb25pdG9ycyBFeHRlbnNpb24iCiAgICAgICAgIGRlcGVuZHMgb24gQVJNNjQgJiYgQUNQSSAm
JiBBUk1fU01NVV9WMwoKMikgQVJNX1NNTVVfVjM9eSwgQVJNX1NNTVVfVjNfUE1VPW0KICAgTm8g
cHJvYmxlbSwgU01NVXYzIHdpbGwgYmUgaW5pdGlhbGl6ZWQgZmlyc3QuCgozKSBBUk1fU01NVV9W
Mz15LCBBUk1fU01NVV9WM19QTVU9eQogICB2aSBkcml2ZXJzL01ha2VmaWxlCiAgIDYwIG9iai15
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKz0gaW9tbXUvCiAgIDE3MiBvYmotJChDT05GSUdf
UEVSRl9FVkVOVFMpICAgICAgICs9IHBlcmYvCgogICBUaGlzIGxpbmsgc2VxdWVuY2UgZW5zdXJl
IHRoYXQgU01NVXYzIGRyaXZlciB3aWxsIGJlIGluaXRpYWxpemVkIGZpcnN0LgogICBUaGV5IGFy
ZSBjdXJyZW50bHkgYXQgdGhlIHNhbWUgaW5pdGlhbGl6YXRpb24gbGV2ZWwuCgo0KSBBUk1fU01N
VV9WMz1tLCBBUk1fU01NVV9WM19QTVU9bQogICBTb3JyeSwgSSB0aG91Z2h0IG1vZHVsZSBkZXBl
bmRlbmNpZXMgd2VyZSBnZW5lcmF0ZWQgYmFzZWQgb24gImRlcGVuZHMgb24iLgogICBCdXQgSSB0
cmllZCBpdCB0b2Rhee+8jG1vZHVsZSBkZXBlbmRlbmNpZXMgYXJlIGdlbmVyYXRlZCBvbmx5IHdo
ZW4gc3ltYm9sCiAgIGRlcGVuZGVuY2llcyBleGlzdC4gSSBzaG91bGQgdXNlIE1PRFVMRV9TT0ZU
REVQKCkgdG8gZXhwbGljaXRseSBtYXJrIHRoZQogICBkZXBlbmRlbmN5LiBJIHdpbGwgc2VuZCBW
MiBsYXRlci4KCgo+IAo+IFJvYmluLgo+IAo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIGJhc2U7Cj4+
ICt9Cj4+ICsKPj4gwqAgc3RhdGljIGludCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHNtbXVfcG11ICpzbW11
X3BtdTsKPj4gQEAgLTc5Myw3ICs4MzEsNyBAQCBzdGF0aWMgaW50IHNtbXVfcG11X3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuY2FwYWJp
bGl0aWVzwqDCoMKgID0gUEVSRl9QTVVfQ0FQX05PX0VYQ0xVREUsCj4+IMKgwqDCoMKgwqAgfTsK
Pj4gwqAgLcKgwqDCoCBzbW11X3BtdS0+cmVnX2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRf
aW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmcmVzXzApOwo+PiArwqDCoMKgIHNtbXVfcG11LT5y
ZWdfYmFzZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwLCAmcmVz
XzApOwo+PiDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21tdV9wbXUtPnJlZ19iYXNlKSkKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHNtbXVfcG11LT5yZWdfYmFzZSk7Cj4+IMKg
IEBAIC04MDEsNyArODM5LDcgQEAgc3RhdGljIGludCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+PiDCoCDCoMKgwqDCoMKgIC8qIERldGVybWluZSBpZiBwYWdl
IDEgaXMgcHJlc2VudCAqLwo+PiDCoMKgwqDCoMKgIGlmIChjZmdyICYgU01NVV9QTUNHX0NGR1Jf
UkVMT0NfQ1RSUykgewo+PiAtwqDCoMKgwqDCoMKgwqAgc21tdV9wbXUtPnJlbG9jX2Jhc2UgPSBk
ZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMSk7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBzbW11X3BtdS0+cmVsb2NfYmFzZSA9IHNtbXVfcG11X2dldF9hbmRfaW9yZW1hcF9yZXNvdXJj
ZShwZGV2LCAxLCBOVUxMKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChJU19FUlIoc21tdV9w
bXUtPnJlbG9jX2Jhc2UpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRS
X0VSUihzbW11X3BtdS0+cmVsb2NfYmFzZSk7Cj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4KPiAK
PiAuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
