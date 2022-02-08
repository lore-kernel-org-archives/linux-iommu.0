Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B66C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 11:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B983B408BB;
	Tue,  8 Feb 2022 11:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tmMo5udPpChJ; Tue,  8 Feb 2022 11:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5700F40868;
	Tue,  8 Feb 2022 11:21:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C0D9C0011;
	Tue,  8 Feb 2022 11:21:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC9EEC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9785817A3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SZYh_C9zopF2 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 11:21:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A6CCD81764
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:21:10 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtL7X0Ry6z1FD30;
 Tue,  8 Feb 2022 19:16:56 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 19:21:05 +0800
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
Message-ID: <ae45a637-2c67-4126-3007-6829320d5659@huawei.com>
Date: Tue, 8 Feb 2022 19:21:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <4f6f6e0f-4398-3018-cc35-6aa7ea1305fe@huawei.com>
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

T24gMjAyMi8yLzggMTY6MDUsIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMjQvMDEvMjAyMiAxMzox
MSwgWWljb25nIFlhbmcgd3JvdGU6Cj4+IFRoZSBETUEgb2YgSGlTaWxpY29uIFBUVCBkZXZpY2Ug
Y2FuIG9ubHkgd29yayB3aXRoIGlkZW50aWNhbAo+PiBtYXBwaW5nLiBTbyBhZGQgYSBxdWlyayBm
b3IgdGhlIGRldmljZSB0byBmb3JjZSB0aGUgZG9tYWluCj4+IHBhc3N0aHJvdWdoLgo+IAo+IFRo
aXMgcGF0Y2ggc2hvdWxkIGJlIGVhcmxpZXIgaW4gdGhlIHNlcmllcywgYmVmb3JlIHRoZSBQVFQg
ZHJpdmVyLCBhbmQgdGhlIGNvbW1lbnQgb24gaGlzaV9wdHRfY2hlY2tfaW9tbXVfbWFwcGluZygp
IHNob3VsZCBtZW50aW9uIHdoYXQgaXMgZ29pbmcgb24gaGVyZS4KPiAKCm9rIEknbGwgcmVvcmRl
ciB0aGUgc2VyaXZlcyBhbmQgbW9kaWZ5IHRoZSBjb21tZW50cyBvZiBoaXNpX3B0dF9jaGVja19p
b21tdV9tYXBwaW5nKCkgbGlrZToKCi8qCiAqIFRoZSBETUEgb2YgUFRUIHRyYWNlIGNhbiBvbmx5
IHVzZSBkaXJlY3QgbWFwcGluZywgZHVlIHRvIHNvbWUKICogaGFyZHdhcmUgcmVzdHJpY3Rpb24u
IENoZWNrIHdoZXRoZXIgdGhlcmUgaXMgYW4gaW9tbXUgb3IgdGhlCiAqIHBvbGljeSBvZiB0aGUg
aW9tbXUgZG9tYWluIGlzIHBhc3N0aHJvdWdoLCBvdGhlcndpc2UgdGhlIHRyYWNlCiAqIGNhbm5v
dCB3b3JrLgogKgogKiBUaGUgUFRUIGRldmljZSBpcyBzdXBwb3NlZCB0byBiZWhpbmQgdGhlIGFy
bSBzbW11IHYzLCB3aGljaAogKiBzaG91bGQgaGF2ZSBwYXNzdGhyb3VnaCB0aGUgZGV2aWNlIGJ5
IGEgcXVpcmsuIE90aGVyd2lzZSB1c2VyCiAqIHNob3VsZCBtYW51YWxseSBzZXQgdGhlIGlvbW11
IGRvbWFpbiB0eXBlIHRvIGlkZW50aXR5IHRocm91Z2gKICogc3lzZnMuCiAqLwoKPj4KPj4gU2ln
bmVkLW9mZi1ieTogWWljb25nIFlhbmcgPHlhbmd5aWNvbmdAaGlzaWxpY29uLmNvbT4KPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAxNiAr
KysrKysrKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12
My5jIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+PiBpbmRl
eCA2ZGM2ZDhiNmIzNjguLjZmNjdhMmIxZGQyNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS12My9hcm0tc21tdS12My5jCj4+IEBAIC0yODM4LDYgKzI4MzgsMjEgQEAgc3Rh
dGljIGludCBhcm1fc21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4gwqDCoMKgwqDCoCB9Cj4+IMKgIH0KPj4gwqAgKyNkZWZpbmUgSVNfSElTSV9QVFRfREVWSUNF
KHBkZXYpwqDCoMKgICgocGRldiktPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0hVQVdFSSAmJiBc
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChwZGV2KS0+ZGV2
aWNlID09IDB4YTEyZSkKPiAKPiBJIGFzc3VtZSB0aGF0IG5vdCBhbGwgcmV2aXNpb25zIHdpbGwg
cmVxdWlyZSB0aGlzIGNoZWNrLCByaWdodD8KPiAKCkZvciBjdXJyZW50IHJldmlzaW9ucyBpdCdz
IG5lY2Vzc2FyeS4KCj4+ICsKPj4gK3N0YXRpYyBpbnQgYXJtX3NtbXVfZGVmX2RvbWFpbl90eXBl
KHN0cnVjdCBkZXZpY2UgKmRldikKPj4gK3sKPj4gK8KgwqDCoCBpZiAoZGV2X2lzX3BjaShkZXYp
KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYo
ZGV2KTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKElTX0hJU0lfUFRUX0RFVklDRShwZGV2
KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIElPTU1VX0RPTUFJTl9JREVOVElU
WTsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gMDsKPj4gK30KPj4gKwo+PiDC
oCBzdGF0aWMgc3RydWN0IGlvbW11X29wcyBhcm1fc21tdV9vcHMgPSB7Cj4+IMKgwqDCoMKgwqAg
LmNhcGFibGXCoMKgwqDCoMKgwqDCoCA9IGFybV9zbW11X2NhcGFibGUsCj4+IMKgwqDCoMKgwqAg
LmRvbWFpbl9hbGxvY8KgwqDCoMKgwqDCoMKgID0gYXJtX3NtbXVfZG9tYWluX2FsbG9jLAo+PiBA
QCAtMjg2Myw2ICsyODc4LDcgQEAgc3RhdGljIHN0cnVjdCBpb21tdV9vcHMgYXJtX3NtbXVfb3Bz
ID0gewo+PiDCoMKgwqDCoMKgIC5zdmFfdW5iaW5kwqDCoMKgwqDCoMKgwqAgPSBhcm1fc21tdV9z
dmFfdW5iaW5kLAo+PiDCoMKgwqDCoMKgIC5zdmFfZ2V0X3Bhc2lkwqDCoMKgwqDCoMKgwqAgPSBh
cm1fc21tdV9zdmFfZ2V0X3Bhc2lkLAo+PiDCoMKgwqDCoMKgIC5wYWdlX3Jlc3BvbnNlwqDCoMKg
wqDCoMKgwqAgPSBhcm1fc21tdV9wYWdlX3Jlc3BvbnNlLAo+PiArwqDCoMKgIC5kZWZfZG9tYWlu
X3R5cGXCoMKgwqAgPSBhcm1fc21tdV9kZWZfZG9tYWluX3R5cGUsCj4+IMKgwqDCoMKgwqAgLnBn
c2l6ZV9iaXRtYXDCoMKgwqDCoMKgwqDCoCA9IC0xVUwsIC8qIFJlc3RyaWN0ZWQgZHVyaW5nIGRl
dmljZSBhdHRhY2ggKi8KPj4gwqDCoMKgwqDCoCAub3duZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ID0gVEhJU19NT0RVTEUsCj4+IMKgIH07Cj4gCj4gLgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
