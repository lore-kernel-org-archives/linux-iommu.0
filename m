Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F44C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:44:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EA160F9C
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74EA160F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15E4040418;
	Tue, 16 Nov 2021 11:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kiiLZCq8ZklZ; Tue, 16 Nov 2021 11:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0425440004;
	Tue, 16 Nov 2021 11:37:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0677C001E;
	Tue, 16 Nov 2021 11:37:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB0FEC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99A1340415
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sLUY6xnkxvSw for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 11:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F81140004
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:37:25 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HtkW73C6CzZd79;
 Tue, 16 Nov 2021 19:34:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 19:37:21 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 16 Nov 2021 19:37:20 +0800
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
Message-ID: <3644ad6e-d800-c84b-9d62-6dda8462450f@hisilicon.com>
Date: Tue, 16 Nov 2021 19:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0b67745c-13dd-1fea-1b8b-d55212bad232@arm.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

T24gMjAyMS8xMS8xNiAxODo1NiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMTEtMTYg
MDk6MDYsIFlpY29uZyBZYW5nIHZpYSBpb21tdSB3cm90ZToKPiBbLi4uXQo+PiArLyoKPj4gKyAq
IEdldCBSTVIgYWRkcmVzcyBpZiBwcm92aWRlZCBieSB0aGUgZmlybXdhcmUuCj4+ICsgKiBSZXR1
cm4gMCBpZiB0aGUgSU9NTVUgZG9lc24ndCBwcmVzZW50IG9yIHRoZSBwb2xpY3kgb2YgdGhlCj4+
ICsgKiBJT01NVSBkb21haW4gaXMgcGFzc3Rocm91Z2ggb3Igd2UgZ2V0IGEgdXNhYmxlIFJNUiBy
ZWdpb24uCj4+ICsgKiBPdGhlcndpc2UgYSBuZWdhdGl2ZSB2YWx1ZSBpcyByZXR1cm5lZC4KPj4g
KyAqLwo+PiArc3RhdGljIGludCBoaXNpX3B0dF9nZXRfcm1yKHN0cnVjdCBoaXNpX3B0dCAqaGlz
aV9wdHQpCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBoaXNpX3B0dC0+
cGRldjsKPj4gK8KgwqDCoCBzdHJ1Y3QgaW9tbXVfZG9tYWluICppb21tdV9kb21haW47Cj4+ICvC
oMKgwqAgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb247Cj4+ICvCoMKgwqAgTElTVF9I
RUFEKGxpc3QpOwo+PiArCj4+ICvCoMKgwqAgLyoKPj4gK8KgwqDCoMKgICogVXNlIGRpcmVjdCBE
TUEgaWYgSU9NTVUgZG9lcyBub3QgcHJlc2VudCBvciB0aGUgcG9saWN5IG9mIHRoZQo+PiArwqDC
oMKgwqAgKiBJT01NVSBkb21haW4gaXMgcGFzc3Rocm91Z2guCj4+ICvCoMKgwqDCoCAqLwo+PiAr
wqDCoMKgIGlvbW11X2RvbWFpbiA9IGlvbW11X2dldF9kb21haW5fZm9yX2RldigmcGRldi0+ZGV2
KTsKPj4gK8KgwqDCoCBpZiAoIWlvbW11X2RvbWFpbiB8fCBpb21tdV9kb21haW4tPnR5cGUgPT0g
SU9NTVVfRE9NQUlOX0lERU5USVRZKQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+ICsK
Pj4gK8KgwqDCoCBpb21tdV9nZXRfcmVzdl9yZWdpb25zKCZwZGV2LT5kZXYsICZsaXN0KTsKPj4g
K8KgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHJlZ2lvbiwgJmxpc3QsIGxpc3QpCj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAocmVnaW9uLT50eXBlID09IElPTU1VX1JFU1ZfRElSRUNUICYmCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZ2lvbi0+bGVuZ3RoID49IEhJU0lfUFRUX1RSQUNFX0JV
RkZFUl9TSVpFKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhpc2lfcHR0LT50cmFjZV9j
dHJsLmhhc19ybXIgPSB0cnVlOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoaXNpX3B0dC0+
dHJhY2VfY3RybC5ybXJfYWRkciA9IHJlZ2lvbi0+c3RhcnQ7Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGhpc2lfcHR0LT50cmFjZV9jdHJsLnJtcl9sZW5ndGggPSByZWdpb24tPmxlbmd0aDsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+
ICsKPj4gK8KgwqDCoCBpb21tdV9wdXRfcmVzdl9yZWdpb25zKCZwZGV2LT5kZXYsICZsaXN0KTsK
Pj4gK8KgwqDCoCByZXR1cm4gaGlzaV9wdHQtPnRyYWNlX2N0cmwuaGFzX3JtciA/IDAgOiAtRU5P
TUVNOwo+PiArfQo+IAo+IE5vLgo+IAo+IFRoZSB3aG9sZSBwb2ludCBvZiBSTVJzIGlzIGZvciBk
ZXZpY2VzIHRoYXQgYXJlIGFscmVhZHkgY29uZmlndXJlZCB0byBhY2Nlc3MgdGhlIGdpdmVuIGFk
ZHJlc3MgcmFuZ2UgaW4gYSBtYW5uZXIgYmV5b25kIHRoZSBrZXJuZWwncyBjb250cm9sLiBJZiB5
b3UgY2FuIGRvIHRoaXMsIGl0IHByb3ZlcyB0aGF0IHlvdSBzaG91bGQgbm90IGhhdmUgYW4gUk1S
IGluIHRoZSBmaXJzdCBwbGFjZS4KPiAKPiBUaGUgbm90aW9uIG9mIGEga2VybmVsIGRyaXZlciBl
eHBsaWNpdGx5IGNvbmZpZ3VyaW5nIGl0cyBkZXZpY2UgdG8gRE1BIGludG8gYW55IHJhbmRvbSBS
TVIgdGhhdCBsb29rcyBiaWcgZW5vdWdoIGlzIHNvIGVncmVnaW91c2x5IHdyb25nIHRoYXQgSSdt
IGFsbW9zdCBsb3N0IGZvciB3b3Jkcy4uLgo+IAoKb3VyIGJpb3Mgd2lsbCByZXNlcnZlIHN1Y2gg
YSByZWdpb24gYW5kIHJlcG9ydGVkIGl0IHRocm91Z2ggaW9ydC4gdGhlIGRldmljZSB3aWxsIHdy
aXRlIHRvIHRoZSByZWdpb24gYW5kIGluIHRoZSBkcml2ZXIgd2UgbmVlZCB0byBhY2Nlc3MgdGhl
IHJlZ2lvbgp0byBnZXQgdGhlIHRyYWNlZCBkYXRhLiB0aGUgcmVnaW9uIGlzIHJlc2VydmVkIGV4
Y2x1c2l2ZWx5IGFuZCB3aWxsIG5vdCBiZSBhY2Nlc3NlZCBieSBrZXJuZWwgb3Igb3RoZXIgZGV2
aWNlcy4KCmlzIGl0IG9rIHRvIGxldCBiaW9zIGNvbmZpZ3VyZSB0aGUgYWRkcmVzcyB0byB0aGUg
ZGV2aWNlIGFuZCBmcm9tIENQVSBzaWRlIHdlIGp1c3QgcmVhZCBpdD8KClRoYW5rcywKWWljb25n
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
