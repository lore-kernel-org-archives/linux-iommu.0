Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5209FC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 06:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05C7D60EF8;
	Wed, 16 Mar 2022 06:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xRFCKb81MI8I; Wed, 16 Mar 2022 06:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C571860ABA;
	Wed, 16 Mar 2022 06:16:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A61B6C001D;
	Wed, 16 Mar 2022 06:16:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD2DBC0012
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 06:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA0EA4173D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 06:16:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFx2zv1cv53n for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 06:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E58C4173C
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 06:15:59 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KJKds0rrTzcb5F;
 Wed, 16 Mar 2022 14:10:57 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 14:15:48 +0800
Subject: Re: [PATCH v5 1/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To: John Garry <john.garry@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-2-yangyicong@hisilicon.com>
 <162a116a-4b0f-c58b-6760-86d10ecf543f@huawei.com>
Message-ID: <e6d50ab3-5284-7fea-c20e-d72add9b0c82@huawei.com>
Date: Wed, 16 Mar 2022 14:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <162a116a-4b0f-c58b-6760-86d10ecf543f@huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, song.bao.hua@hisilicon.com, liuqi115@huawei.com,
 linuxarm@huawei.com, prime.zeng@huawei.com
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMi8zLzEyIDE6MjcsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMDgvMDMvMjAyMiAwODo0
OSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+IFRoZSBETUEgb2YgSGlTaWxpY29uIFBUVCBkZXZpY2Ug
Y2FuIG9ubHkgd29yayB3aXRoIGlkZW50aWNhbCBtYXBwaW5nLgo+IAo+IG5pdDogSSdkIGhhdmUg
IkRNQSBvcGVyYXRpb25zIG9mIHRoZSBIaVNpbGljb24gUFRUIGRldmljZSBjYW4gb25seSB3b3Jr
IHByb3Blcmx5IHdpdGggaWRlbnRpdHkgbWFwcGluZ3MiLgo+IAo+PiBTbyBhZGQgYSBxdWlyayBm
b3IgdGhlIGRldmljZSB0byBmb3JjZSB0aGUgZG9tYWluIHBhc3N0aHJvdWdoLgo+IAo+ICIuLiBk
b21haW4gYXMgcGFzc3Rocm91Z2guIgo+IAoKdGhhbmtzIGZvciB0aGUgY29tbWVudHMuIHdpbGwg
cmVmaW5lIHRoZSBjb21taXQgYXMgc3VnZ2VzdGVkLgoKPj4KPj4gU2lnbmVkLW9mZi1ieTogWWlj
b25nIFlhbmcgPHlhbmd5aWNvbmdAaGlzaWxpY29uLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAxNiArKysrKysrKysrKysrKysr
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIGIvZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBpbmRleCA2ZGM2ZDhiNmIzNjgu
LjZmNjdhMmIxZGQyNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9h
cm0tc21tdS12My5jCj4+IEBAIC0yODM4LDYgKzI4MzgsMjEgQEAgc3RhdGljIGludCBhcm1fc21t
dV9kZXZfZGlzYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4gwqDCoMKgwqDCoCB9
Cj4+IMKgIH0KPj4gwqAgKyNkZWZpbmUgSVNfSElTSV9QVFRfREVWSUNFKHBkZXYpwqDCoMKgICgo
cGRldiktPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0hVQVdFSSAmJiBcCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChwZGV2KS0+ZGV2aWNlID09IDB4YTEyZSkK
Pj4gKwo+PiArc3RhdGljIGludCBhcm1fc21tdV9kZWZfZG9tYWluX3R5cGUoc3RydWN0IGRldmlj
ZSAqZGV2KQo+PiArewo+PiArwqDCoMKgIGlmIChkZXZfaXNfcGNpKGRldikpIHsKPj4gK8KgwqDC
oMKgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdG9fcGNpX2RldihkZXYpOwo+PiArCj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoSVNfSElTSV9QVFRfREVWSUNFKHBkZXYpKQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSU9NTVVfRE9NQUlOX0lERU5USVRZOwo+PiArwqDCoMKg
IH0KPj4gKwo+PiArwqDCoMKgIHJldHVybiAwOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBzdHJ1
Y3QgaW9tbXVfb3BzIGFybV9zbW11X29wcyA9IHsKPj4gwqDCoMKgwqDCoCAuY2FwYWJsZcKgwqDC
oMKgwqDCoMKgID0gYXJtX3NtbXVfY2FwYWJsZSwKPj4gwqDCoMKgwqDCoCAuZG9tYWluX2FsbG9j
wqDCoMKgwqDCoMKgwqAgPSBhcm1fc21tdV9kb21haW5fYWxsb2MsCj4+IEBAIC0yODYzLDYgKzI4
NzgsNyBAQCBzdGF0aWMgc3RydWN0IGlvbW11X29wcyBhcm1fc21tdV9vcHMgPSB7Cj4+IMKgwqDC
oMKgwqAgLnN2YV91bmJpbmTCoMKgwqDCoMKgwqDCoCA9IGFybV9zbW11X3N2YV91bmJpbmQsCj4+
IMKgwqDCoMKgwqAgLnN2YV9nZXRfcGFzaWTCoMKgwqDCoMKgwqDCoCA9IGFybV9zbW11X3N2YV9n
ZXRfcGFzaWQsCj4+IMKgwqDCoMKgwqAgLnBhZ2VfcmVzcG9uc2XCoMKgwqDCoMKgwqDCoCA9IGFy
bV9zbW11X3BhZ2VfcmVzcG9uc2UsCj4+ICvCoMKgwqAgLmRlZl9kb21haW5fdHlwZcKgwqDCoCA9
IGFybV9zbW11X2RlZl9kb21haW5fdHlwZSwKPj4gwqDCoMKgwqDCoCAucGdzaXplX2JpdG1hcMKg
wqDCoMKgwqDCoMKgID0gLTFVTCwgLyogUmVzdHJpY3RlZCBkdXJpbmcgZGV2aWNlIGF0dGFjaCAq
Lwo+PiDCoMKgwqDCoMKgIC5vd25lcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBUSElTX01PRFVM
RSwKPj4gwqAgfTsKPiAKPiAuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
