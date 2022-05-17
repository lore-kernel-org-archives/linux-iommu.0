Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D706C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 01:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11F1761157;
	Tue, 17 May 2022 01:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xq4NJOAcWc9T; Tue, 17 May 2022 01:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D007060EB2;
	Tue, 17 May 2022 01:37:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A74E6C0039;
	Tue, 17 May 2022 01:37:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B59DBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F6CA61083
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Ji30NIt1NLo for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:37:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E87F860EB2
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:37:25 +0000 (UTC)
Received: from kwepemi100017.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2JWw6bypzCsjd;
 Tue, 17 May 2022 09:32:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100017.china.huawei.com (7.221.188.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:37:22 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:37:21 +0800
Subject: Re: [PATCH v8 4/8] perf arm: Refactor event list iteration in
 auxtrace_record__init()
To: John Garry <john.garry@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
 <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <acme@kernel.org>, <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-5-yangyicong@hisilicon.com>
 <d874dd82-30fd-f8e0-b7ab-0c9d14e47324@huawei.com>
Message-ID: <164bf8c9-70d1-6c34-0269-1be109ca1ae0@huawei.com>
Date: Tue, 17 May 2022 09:37:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d874dd82-30fd-f8e0-b7ab-0c9d14e47324@huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, zhangshaokun@hisilicon.com, prime.zeng@huawei.com,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, helgaas@kernel.org, linux-arm-kernel@lists.infradead.org
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
From: "liuqi \(BA\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "liuqi \(BA\)" <liuqi115@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIyLzUvMTcgMDoyOSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNi8wNS8yMDIyIDEz
OjUyLCBZaWNvbmcgWWFuZyB3cm90ZToKPiAKPiBBcyByZXF1ZXN0ZWQgYmVmb3JlLCBwbGVhc2Ug
bWVudGlvbiAicGVyZiB0b29sIiBpbiB0aGUgY29tbWl0IHN1YmplY3QKInBlcmYgYXJtIiBpcyB1
c2VkIHJlZmVyZW5jZWQgdG8gcHJldmlvdXMgY29tbWl0LCBvaywgd2lsbCBtZW50aW9uICJwZXJm
IAp0b29sIiBpbiB0aGUgY29tbWl0IHN1YmplY3QgbmV4dCB0aW1lLgoKVGhhbmtzLApRaQo+IAo+
PiBGcm9tOiBRaSBMaXUgPGxpdXFpMTE1QGh1YXdlaS5jb20+Cj4+Cj4+IFVzZSBmaW5kX3BtdV9m
b3JfZXZlbnQoKSB0byBzaW1wbGlmeSBsb2dpYyBpbiBhdXh0cmFjZV9yZWNvcmRfX2luaXQoKS4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogUWkgTGl1IDxsaXVxaTExNUBodWF3ZWkuY29tPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaWNvbmcgWWFuZyA8eWFuZ3lpY29uZ0BoaXNpbGljb24uY29tPgo+PiAtLS0K
Pj4gwqAgdG9vbHMvcGVyZi9hcmNoL2FybS91dGlsL2F1eHRyYWNlLmMgfCA1MyArKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygr
KSwgMTkgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2FyY2gvYXJt
L3V0aWwvYXV4dHJhY2UuYyAKPj4gYi90b29scy9wZXJmL2FyY2gvYXJtL3V0aWwvYXV4dHJhY2Uu
Ywo+PiBpbmRleCA1ZmM2YTJhM2RiYzUuLjM4NGM3Y2ZkYTBmZCAxMDA2NDQKPj4gLS0tIGEvdG9v
bHMvcGVyZi9hcmNoL2FybS91dGlsL2F1eHRyYWNlLmMKPj4gKysrIGIvdG9vbHMvcGVyZi9hcmNo
L2FybS91dGlsL2F1eHRyYWNlLmMKPj4gQEAgLTUwLDE2ICs1MCwzMiBAQCBzdGF0aWMgc3RydWN0
IHBlcmZfcG11ICoqZmluZF9hbGxfYXJtX3NwZV9wbXVzKGludCAKPj4gKm5yX3NwZXMsIGludCAq
ZXJyKQo+PiDCoMKgwqDCoMKgIHJldHVybiBhcm1fc3BlX3BtdXM7Cj4+IMKgIH0KPj4gK3N0YXRp
YyBzdHJ1Y3QgcGVyZl9wbXUgKmZpbmRfcG11X2Zvcl9ldmVudChzdHJ1Y3QgcGVyZl9wbXUgKipw
bXVzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50
IHBtdV9uciwgc3RydWN0IGV2c2VsICpldnNlbCkKPj4gK3sKPj4gK8KgwqDCoCBpbnQgaTsKPj4g
Kwo+PiArwqDCoMKgIGlmICghcG11cykKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+
PiArCj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IHBtdV9ucjsgaSsrKSB7Cj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoZXZzZWwtPmNvcmUuYXR0ci50eXBlID09IHBtdXNbaV0tPnR5cGUpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBwbXVzW2ldOwo+PiArwqDCoMKgIH0KPj4gKwo+
PiArwqDCoMKgIHJldHVybiBOVUxMOwo+PiArfQo+PiArCj4+IMKgIHN0cnVjdCBhdXh0cmFjZV9y
ZWNvcmQKPj4gwqAgKmF1eHRyYWNlX3JlY29yZF9faW5pdChzdHJ1Y3QgZXZsaXN0ICpldmxpc3Qs
IGludCAqZXJyKQo+PiDCoCB7Cj4+IC3CoMKgwqAgc3RydWN0IHBlcmZfcG11wqDCoMKgICpjc19l
dG1fcG11Owo+PiArwqDCoMKgIHN0cnVjdCBwZXJmX3BtdcKgwqDCoCAqY3NfZXRtX3BtdSA9IE5V
TEw7Cj4+ICvCoMKgwqAgc3RydWN0IHBlcmZfcG11ICoqYXJtX3NwZV9wbXVzID0gTlVMTDsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgZXZzZWwgKmV2c2VsOwo+PiAtwqDCoMKgIGJvb2wgZm91bmRfZXRt
ID0gZmFsc2U7Cj4+ICvCoMKgwqAgc3RydWN0IHBlcmZfcG11ICpmb3VuZF9ldG0gPSBOVUxMOwo+
PiDCoMKgwqDCoMKgIHN0cnVjdCBwZXJmX3BtdSAqZm91bmRfc3BlID0gTlVMTDsKPj4gLcKgwqDC
oCBzdHJ1Y3QgcGVyZl9wbXUgKiphcm1fc3BlX3BtdXMgPSBOVUxMOwo+PiArwqDCoMKgIGludCBh
dXh0cmFjZV9ldmVudF9jbnQgPSAwOwo+PiDCoMKgwqDCoMKgIGludCBucl9zcGVzID0gMDsKPj4g
LcKgwqDCoCBpbnQgaSA9IDA7Cj4+IMKgwqDCoMKgwqAgaWYgKCFldmxpc3QpCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPj4gQEAgLTY4LDI0ICs4NCwyMyBAQCBzdHJ1Y3QgYXV4
dHJhY2VfcmVjb3JkCj4+IMKgwqDCoMKgwqAgYXJtX3NwZV9wbXVzID0gZmluZF9hbGxfYXJtX3Nw
ZV9wbXVzKCZucl9zcGVzLCBlcnIpOwo+PiDCoMKgwqDCoMKgIGV2bGlzdF9fZm9yX2VhY2hfZW50
cnkoZXZsaXN0LCBldnNlbCkgewo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGNzX2V0bV9wbXUgJiYK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXZzZWwtPmNvcmUuYXR0ci50eXBlID09IGNzX2V0
bV9wbXUtPnR5cGUpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvdW5kX2V0bSA9IHRydWU7
Cj4+IC0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmICghbnJfc3BlcyB8fCBmb3VuZF9zcGUpCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiAtCj4+IC3CoMKgwqDCoMKgwqDCoCBm
b3IgKGkgPSAwOyBpIDwgbnJfc3BlczsgaSsrKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChldnNlbC0+Y29yZS5hdHRyLnR5cGUgPT0gYXJtX3NwZV9wbXVzW2ldLT50eXBlKSB7Cj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm91bmRfc3BlID0gYXJtX3NwZV9wbXVz
W2ldOwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9Cj4+IC3CoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoY3NfZXRtX3BtdSAmJiAhZm91bmRfZXRtKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmb3VuZF9ldG0gPSBmaW5kX3BtdV9mb3JfZXZlbnQoJmNzX2V0bV9wbXUsIDEsIGV2c2VsKTsK
Pj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFybV9zcGVfcG11cyAmJiAhZm91bmRfc3BlKQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3VuZF9zcGUgPSBmaW5kX3BtdV9mb3JfZXZlbnQo
YXJtX3NwZV9wbXVzLCBucl9zcGVzLCAKPj4gZXZzZWwpOwo+PiDCoMKgwqDCoMKgIH0KPj4gKwo+
PiDCoMKgwqDCoMKgIGZyZWUoYXJtX3NwZV9wbXVzKTsKPj4gLcKgwqDCoCBpZiAoZm91bmRfZXRt
ICYmIGZvdW5kX3NwZSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJDb25jdXJyZW50IEFS
TSBDb3Jlc2lnaHQgRVRNIGFuZCBTUEUgb3BlcmF0aW9uIG5vdCAKPj4gY3VycmVudGx5IHN1cHBv
cnRlZFxuIik7Cj4+ICvCoMKgwqAgaWYgKGZvdW5kX2V0bSkKPj4gK8KgwqDCoMKgwqDCoMKgIGF1
eHRyYWNlX2V2ZW50X2NudCsrOwo+PiArCj4+ICvCoMKgwqAgaWYgKGZvdW5kX3NwZSkKPj4gK8Kg
wqDCoMKgwqDCoMKgIGF1eHRyYWNlX2V2ZW50X2NudCsrOwo+PiArCj4+ICvCoMKgwqAgaWYgKGF1
eHRyYWNlX2V2ZW50X2NudCA+IDEpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHByX2VycigiQ29uY3Vy
cmVudCBBVVggdHJhY2Ugb3BlcmF0aW9uIG5vdCBjdXJyZW50bHkgCj4+IHN1cHBvcnRlZFxuIik7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqZXJyID0gLUVPUE5PVFNVUFA7Cj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gTlVMTDsKPj4gwqDCoMKgwqDCoCB9Cj4gCj4gLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
