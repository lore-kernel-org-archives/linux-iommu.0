Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA624C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 11:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6478E404FE;
	Tue,  8 Feb 2022 11:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ejYlQ7LCd6BR; Tue,  8 Feb 2022 11:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 705054010C;
	Tue,  8 Feb 2022 11:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47091C0011;
	Tue,  8 Feb 2022 11:57:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0594DC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAA4D81B53
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXaXc0pJe_8Y for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 11:57:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 596FC80D69
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:57:11 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JtLw80t75z688jd;
 Tue,  8 Feb 2022 19:52:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 12:57:07 +0100
Received: from [10.47.82.28] (10.47.82.28) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 11:56:53 +0000
Message-ID: <144329a3-8125-1975-7f23-a247343a679e@huawei.com>
Date: Tue, 8 Feb 2022 11:56:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 8/8] iommu/arm-smmu-v3: Make default domain type of
 HiSilicon PTT device to identity
To: Yicong Yang <yangyicong@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "will@kernel.org"
 <will@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "mike.leach@linaro.org"
 <mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "daniel.thompson@linaro.org"
 <daniel.thompson@linaro.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "acme@kernel.org" <acme@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "coresight@lists.linaro.org"
 <coresight@lists.linaro.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
 <linux-perf-users@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-9-yangyicong@hisilicon.com>
 <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
 <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
In-Reply-To: <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
X-Originating-IP: [10.47.82.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMDgvMDIvMjAyMiAxMToyMSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggc2hv
dWxkIGJlIGVhcmxpZXIgaW4gdGhlIHNlcmllcywgYmVmb3JlIHRoZSBQVFQgZHJpdmVyLCBhbmQg
dGhlIGNvbW1lbnQgb24gaGlzaV9wdHRfY2hlY2tfaW9tbXVfbWFwcGluZygpIHNob3VsZCBtZW50
aW9uIHdoYXQgaXMgZ29pbmcgb24gaGVyZS4KPj4KPiBvayBJJ2xsIHJlb3JkZXIgdGhlIHNlcml2
ZXMgYW5kIG1vZGlmeSB0aGUgY29tbWVudHMgb2YgaGlzaV9wdHRfY2hlY2tfaW9tbXVfbWFwcGlu
ZygpIGxpa2U6Cj4gCj4gLyoKPiAgICogVGhlIERNQSBvZiBQVFQgdHJhY2UgY2FuIG9ubHkgdXNl
IGRpcmVjdCBtYXBwaW5nLCBkdWUgdG8gc29tZQo+ICAgKiBoYXJkd2FyZSByZXN0cmljdGlvbi4g
Q2hlY2sgd2hldGhlciB0aGVyZSBpcyBhbiBpb21tdSBvciB0aGUKPiAgICogcG9saWN5IG9mIHRo
ZSBpb21tdSBkb21haW4gaXMgcGFzc3Rocm91Z2gsIG90aGVyd2lzZSB0aGUgdHJhY2UKPiAgICog
Y2Fubm90IHdvcmsuCgpJT01NVSwgY2FwaXRhbGl6ZSBhY3JvbnltcwoKPiAgICoKPiAgICogVGhl
IFBUVCBkZXZpY2UgaXMgc3VwcG9zZWQgdG8gYmVoaW5kIHRoZSBhcm0gc21tdSB2Mywgd2hpY2gK
PiAgICogc2hvdWxkIGhhdmUgcGFzc3Rocm91Z2ggdGhlIGRldmljZSBieSBhIHF1aXJrLiBPdGhl
cndpc2UgdXNlcgo+ICAgKiBzaG91bGQgbWFudWFsbHkgc2V0IHRoZSBpb21tdSBkb21haW4gdHlw
ZSB0byBpZGVudGl0eSB0aHJvdWdoCj4gICAqIHN5c2ZzLgoKU29ycnksIGJ1dCBJIGRvbid0IHJl
YWxseSB1bmRlcnN0YW5kIHlvdXIgbWVhbmluZyBoZXJlLgoKSSBkaWQgbm90IHRoaW5rIHRoYXQg
aWYgd2UgaGF2ZSBhIGRlZmF1bHQgZG9tYWluIHRoZW4gd2UgY2FuIGNoYW5nZSB2aWEgCnN5c2Zz
IHRvIGFueXRoaW5nIGVsc2UuCgo+ICAgKi8KPiAKPj4+IFNpZ25lZC1vZmYtYnk6IFlpY29uZyBZ
YW5nPHlhbmd5aWNvbmdAaGlzaWxpY29uLmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAxNiArKysrKysrKysrKysrKysrCj4+
PiAgwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyBiL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMKPj4+IGluZGV4IDZkYzZkOGI2YjM2
OC4uNmY2N2EyYjFkZDI3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNt
bXUtdjMvYXJtLXNtbXUtdjMuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUt
djMvYXJtLXNtbXUtdjMuYwo+Pj4gQEAgLTI4MzgsNiArMjgzOCwyMSBAQCBzdGF0aWMgaW50IGFy
bV9zbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUoc3RydWN0IGRldmljZSAqZGV2LAo+Pj4gIMKgwqDC
oMKgwqAgfQo+Pj4gIMKgIH0KPj4+ICDCoCArI2RlZmluZSBJU19ISVNJX1BUVF9ERVZJQ0UocGRl
dinCoMKgwqAgKChwZGV2KS0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfSFVBV0VJICYmIFwKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChwZGV2KS0+ZGV2aWNl
ID09IDB4YTEyZSkKPj4gSSBhc3N1bWUgdGhhdCBub3QgYWxsIHJldmlzaW9ucyB3aWxsIHJlcXVp
cmUgdGhpcyBjaGVjaywgcmlnaHQ/CgpTbyBpZiB5b3UgYXJlIHZlcnkgY29uZmlkZW50IHRoYXQg
dGhlIG5leHQgcmV2aXNpb24gd2lsbCBiZSBmaXhlZCB0aGVuIEkgCndvdWxkIGFkZCBhIGNoZWNr
IGZvciB0aGlzIGN1cnJlbnQgYnJva2VuIHJldmlzaW9uLgoKPj4KPiBGb3IgY3VycmVudCByZXZp
c2lvbnMgaXQncyBuZWNlc3NhcnkuCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
