Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E18C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 12:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A96A34048E;
	Tue,  8 Feb 2022 12:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7YwGNEGJfUK; Tue,  8 Feb 2022 12:20:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2002B40435;
	Tue,  8 Feb 2022 12:20:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB806C001A;
	Tue,  8 Feb 2022 12:20:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91967C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 12:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FA39813AB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 12:20:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fDvuEZfCitY for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 12:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34D698137A
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 12:20:17 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtMWN5SFgzbkJT;
 Tue,  8 Feb 2022 20:19:12 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 20:20:12 +0800
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To: John Garry <john.garry@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "will@kernel.org"
 <will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "mike.leach@linaro.org"
 <mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, "daniel.thompson@linaro.org"
 <daniel.thompson@linaro.org>, "joro@8bytes.org" <joro@8bytes.org>, Shameerali
 Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "coresight@lists.linaro.org"
 <coresight@lists.linaro.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
 <linux-perf-users@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
 <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
 <144329a3-8125-1975-7f23-a247343a679e@huawei.com>
Message-ID: <d92c9d64-6a89-b7d5-02e3-519ca32f27e9@huawei.com>
Date: Tue, 8 Feb 2022 20:20:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <144329a3-8125-1975-7f23-a247343a679e@huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: Zhangshaokun <zhangshaokun@hisilicon.com>,
 "liuqi \(BA\)" <liuqi115@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>
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

T24gMjAyMi8yLzggMTk6NTYsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMDgvMDIvMjAyMiAxMToy
MSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+PiBUaGlzIHBhdGNoIHNob3VsZCBiZSBlYXJsaWVyIGlu
IHRoZSBzZXJpZXMsIGJlZm9yZSB0aGUgUFRUIGRyaXZlciwgYW5kIHRoZSBjb21tZW50IG9uIGhp
c2lfcHR0X2NoZWNrX2lvbW11X21hcHBpbmcoKSBzaG91bGQgbWVudGlvbiB3aGF0IGlzIGdvaW5n
IG9uIGhlcmUuCj4+Pgo+PiBvayBJJ2xsIHJlb3JkZXIgdGhlIHNlcml2ZXMgYW5kIG1vZGlmeSB0
aGUgY29tbWVudHMgb2YgaGlzaV9wdHRfY2hlY2tfaW9tbXVfbWFwcGluZygpIGxpa2U6Cj4+Cj4+
IC8qCj4+IMKgICogVGhlIERNQSBvZiBQVFQgdHJhY2UgY2FuIG9ubHkgdXNlIGRpcmVjdCBtYXBw
aW5nLCBkdWUgdG8gc29tZQo+PiDCoCAqIGhhcmR3YXJlIHJlc3RyaWN0aW9uLiBDaGVjayB3aGV0
aGVyIHRoZXJlIGlzIGFuIGlvbW11IG9yIHRoZQo+PiDCoCAqIHBvbGljeSBvZiB0aGUgaW9tbXUg
ZG9tYWluIGlzIHBhc3N0aHJvdWdoLCBvdGhlcndpc2UgdGhlIHRyYWNlCj4+IMKgICogY2Fubm90
IHdvcmsuCj4gCj4gSU9NTVUsIGNhcGl0YWxpemUgYWNyb255bXMKPiAKCm9rLgoKPj4gwqAgKgo+
PiDCoCAqIFRoZSBQVFQgZGV2aWNlIGlzIHN1cHBvc2VkIHRvIGJlaGluZCB0aGUgYXJtIHNtbXUg
djMsIHdoaWNoCj4+IMKgICogc2hvdWxkIGhhdmUgcGFzc3Rocm91Z2ggdGhlIGRldmljZSBieSBh
IHF1aXJrLiBPdGhlcndpc2UgdXNlcgo+PiDCoCAqIHNob3VsZCBtYW51YWxseSBzZXQgdGhlIGlv
bW11IGRvbWFpbiB0eXBlIHRvIGlkZW50aXR5IHRocm91Z2gKPj4gwqAgKiBzeXNmcy4KPiAKPiBT
b3JyeSwgYnV0IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgeW91ciBtZWFuaW5nIGhlcmUuCj4g
Cj4gSSBkaWQgbm90IHRoaW5rIHRoYXQgaWYgd2UgaGF2ZSBhIGRlZmF1bHQgZG9tYWluIHRoZW4g
d2UgY2FuIGNoYW5nZSB2aWEgc3lzZnMgdG8gYW55dGhpbmcgZWxzZS4KPiAKCm9rIEkgdGhpbmsg
dGhlIGxhc3Qgc2VudGVuY2UgbWF5YmUgbWlzbGVhZGluZyBhbmQgYmV0dGVyIGRyb3AgaXQuCgo+
PiDCoCAqLwo+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpY29uZyBZYW5nPHlhbmd5aWNvbmdAaGlz
aWxpY29uLmNvbT4KPj4+PiAtLS0KPj4+PiDCoMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
LXYzL2FybS1zbW11LXYzLmMgfCAxNiArKysrKysrKysrKysrKysrCj4+Pj4gwqDCoCAxIGZpbGUg
Y2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgYi9kcml2ZXJzL2lvbW11L2FybS9h
cm0tc21tdS12My9hcm0tc21tdS12My5jCj4+Pj4gaW5kZXggNmRjNmQ4YjZiMzY4Li42ZjY3YTJi
MWRkMjcgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJt
LXNtbXUtdjMuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1z
bW11LXYzLmMKPj4+PiBAQCAtMjgzOCw2ICsyODM4LDIxIEBAIHN0YXRpYyBpbnQgYXJtX3NtbXVf
ZGV2X2Rpc2FibGVfZmVhdHVyZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+Pj4gwqDCoMKgwqDCoMKg
IH0KPj4+PiDCoMKgIH0KPj4+PiDCoMKgICsjZGVmaW5lIElTX0hJU0lfUFRUX0RFVklDRShwZGV2
KcKgwqDCoCAoKHBkZXYpLT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9IVUFXRUkgJiYgXAo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChwZGV2KS0+ZGV2aWNl
ID09IDB4YTEyZSkKPj4+IEkgYXNzdW1lIHRoYXQgbm90IGFsbCByZXZpc2lvbnMgd2lsbCByZXF1
aXJlIHRoaXMgY2hlY2ssIHJpZ2h0Pwo+IAo+IFNvIGlmIHlvdSBhcmUgdmVyeSBjb25maWRlbnQg
dGhhdCB0aGUgbmV4dCByZXZpc2lvbiB3aWxsIGJlIGZpeGVkIHRoZW4gSSB3b3VsZCBhZGQgYSBj
aGVjayBmb3IgdGhpcyBjdXJyZW50IGJyb2tlbiByZXZpc2lvbi4KPiAKPj4+Cj4+IEZvciBjdXJy
ZW50IHJldmlzaW9ucyBpdCdzIG5lY2Vzc2FyeS4KPj4KPiAKPiAuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
