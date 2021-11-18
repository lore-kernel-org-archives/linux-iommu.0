Return-Path: <SRS0=SEpV=QF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC93C433EF
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 09:01:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040C261B3E
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 09:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 040C261B3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA23760762;
	Thu, 18 Nov 2021 09:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b21n_JoVnM0I; Thu, 18 Nov 2021 09:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D9C860767;
	Thu, 18 Nov 2021 09:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D4B8C002E;
	Thu, 18 Nov 2021 09:01:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3FCAC0012
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 09:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2B9640386
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 09:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q_4TP20FynxU for <iommu@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 09:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE4D540383
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 09:01:39 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hvv0n0zYxz917Z;
 Thu, 18 Nov 2021 17:01:13 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 17:01:34 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 18 Nov 2021 17:01:34 +0800
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To: Robin Murphy <robin.murphy@arm.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>, <john.garry@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
 <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
 <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
 <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
Message-ID: <e7d4afb7-e4e4-e581-872b-2477850ad8da@hisilicon.com>
Date: Thu, 18 Nov 2021 17:01:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com, yangyicong@hisilicon.com
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
Reply-To: Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4sCgpPbiAyMDIxLzExLzE2IDE5OjM3LCBZaWNvbmcgWWFuZyB3cm90ZToKPiBPbiAy
MDIxLzExLzE2IDE4OjU2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMTEtMTYgMDk6
MDYsIFlpY29uZyBZYW5nIHZpYSBpb21tdSB3cm90ZToKPj4gWy4uLl0KPj4+ICsvKgo+Pj4gKyAq
IEdldCBSTVIgYWRkcmVzcyBpZiBwcm92aWRlZCBieSB0aGUgZmlybXdhcmUuCj4+PiArICogUmV0
dXJuIDAgaWYgdGhlIElPTU1VIGRvZXNuJ3QgcHJlc2VudCBvciB0aGUgcG9saWN5IG9mIHRoZQo+
Pj4gKyAqIElPTU1VIGRvbWFpbiBpcyBwYXNzdGhyb3VnaCBvciB3ZSBnZXQgYSB1c2FibGUgUk1S
IHJlZ2lvbi4KPj4+ICsgKiBPdGhlcndpc2UgYSBuZWdhdGl2ZSB2YWx1ZSBpcyByZXR1cm5lZC4K
Pj4+ICsgKi8KPj4+ICtzdGF0aWMgaW50IGhpc2lfcHR0X2dldF9ybXIoc3RydWN0IGhpc2lfcHR0
ICpoaXNpX3B0dCkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gaGlz
aV9wdHQtPnBkZXY7Cj4+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9kb21haW4gKmlvbW11X2RvbWFp
bjsKPj4+ICvCoMKgwqAgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb247Cj4+PiArwqDC
oMKgIExJU1RfSEVBRChsaXN0KTsKPj4+ICsKPj4+ICvCoMKgwqAgLyoKPj4+ICvCoMKgwqDCoCAq
IFVzZSBkaXJlY3QgRE1BIGlmIElPTU1VIGRvZXMgbm90IHByZXNlbnQgb3IgdGhlIHBvbGljeSBv
ZiB0aGUKPj4+ICvCoMKgwqDCoCAqIElPTU1VIGRvbWFpbiBpcyBwYXNzdGhyb3VnaC4KPj4+ICvC
oMKgwqDCoCAqLwo+Pj4gK8KgwqDCoCBpb21tdV9kb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zv
cl9kZXYoJnBkZXYtPmRldik7Cj4+PiArwqDCoMKgIGlmICghaW9tbXVfZG9tYWluIHx8IGlvbW11
X2RvbWFpbi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJVFkpCj4+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4+PiArCj4+PiArwqDCoMKgIGlvbW11X2dldF9yZXN2X3JlZ2lvbnMoJnBk
ZXYtPmRldiwgJmxpc3QpOwo+Pj4gK8KgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHJlZ2lvbiwg
Jmxpc3QsIGxpc3QpCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJlZ2lvbi0+dHlwZSA9PSBJT01N
VV9SRVNWX0RJUkVDVCAmJgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnaW9uLT5sZW5n
dGggPj0gSElTSV9QVFRfVFJBQ0VfQlVGRkVSX1NJWkUpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGhpc2lfcHR0LT50cmFjZV9jdHJsLmhhc19ybXIgPSB0cnVlOwo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaGlzaV9wdHQtPnRyYWNlX2N0cmwucm1yX2FkZHIgPSByZWdpb24tPnN0
YXJ0Owo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGlzaV9wdHQtPnRyYWNlX2N0cmwucm1y
X2xlbmd0aCA9IHJlZ2lvbi0+bGVuZ3RoOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4+PiArwqDCoMKgwqDCoMKgwqAgfQo+Pj4gKwo+Pj4gK8KgwqDCoCBpb21tdV9wdXRfcmVz
dl9yZWdpb25zKCZwZGV2LT5kZXYsICZsaXN0KTsKPj4+ICvCoMKgwqAgcmV0dXJuIGhpc2lfcHR0
LT50cmFjZV9jdHJsLmhhc19ybXIgPyAwIDogLUVOT01FTTsKPj4+ICt9Cj4+Cj4+IE5vLgo+Pgo+
PiBUaGUgd2hvbGUgcG9pbnQgb2YgUk1ScyBpcyBmb3IgZGV2aWNlcyB0aGF0IGFyZSBhbHJlYWR5
IGNvbmZpZ3VyZWQgdG8gYWNjZXNzIHRoZSBnaXZlbiBhZGRyZXNzIHJhbmdlIGluIGEgbWFubmVy
IGJleW9uZCB0aGUga2VybmVsJ3MgY29udHJvbC4gSWYgeW91IGNhbiBkbyB0aGlzLCBpdCBwcm92
ZXMgdGhhdCB5b3Ugc2hvdWxkIG5vdCBoYXZlIGFuIFJNUiBpbiB0aGUgZmlyc3QgcGxhY2UuCj4+
Cj4+IFRoZSBub3Rpb24gb2YgYSBrZXJuZWwgZHJpdmVyIGV4cGxpY2l0bHkgY29uZmlndXJpbmcg
aXRzIGRldmljZSB0byBETUEgaW50byBhbnkgcmFuZG9tIFJNUiB0aGF0IGxvb2tzIGJpZyBlbm91
Z2ggaXMgc28gZWdyZWdpb3VzbHkgd3JvbmcgdGhhdCBJJ20gYWxtb3N0IGxvc3QgZm9yIHdvcmRz
Li4uCj4+Cj4gCj4gb3VyIGJpb3Mgd2lsbCByZXNlcnZlIHN1Y2ggYSByZWdpb24gYW5kIHJlcG9y
dGVkIGl0IHRocm91Z2ggaW9ydC4gdGhlIGRldmljZSB3aWxsIHdyaXRlIHRvIHRoZSByZWdpb24g
YW5kIGluIHRoZSBkcml2ZXIgd2UgbmVlZCB0byBhY2Nlc3MgdGhlIHJlZ2lvbgo+IHRvIGdldCB0
aGUgdHJhY2VkIGRhdGEuIHRoZSByZWdpb24gaXMgcmVzZXJ2ZWQgZXhjbHVzaXZlbHkgYW5kIHdp
bGwgbm90IGJlIGFjY2Vzc2VkIGJ5IGtlcm5lbCBvciBvdGhlciBkZXZpY2VzLgo+IAo+IGlzIGl0
IG9rIHRvIGxldCBiaW9zIGNvbmZpZ3VyZSB0aGUgYWRkcmVzcyB0byB0aGUgZGV2aWNlIGFuZCBm
cm9tIENQVSBzaWRlIHdlIGp1c3QgcmVhZCBpdD8KPiAKCkFueSBzdWdnZXN0aW9uPyAgSXMgdGhp
cyBzdGlsbCBhbiBpc3N1ZSB5b3UgY29uY2VybiBpZiB3ZSBtb3ZlIHRoZSBjb25maWd1cmF0aW9u
IG9mIHRoZSBkZXZpY2UgYWRkcmVzcyB0byBCSU9TIGFuZCBqdXN0IHJlYWQgZnJvbSB0aGUgQ1BV
IHNpZGU/Cgo+IAo+IAo+IC4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
