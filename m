Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7DDC2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2472236F
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2472236F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7304186BF9;
	Tue,  3 Nov 2020 14:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHyhFLCc4IwH; Tue,  3 Nov 2020 14:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3634A86BE8;
	Tue,  3 Nov 2020 14:31:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 277B2C0889;
	Tue,  3 Nov 2020 14:31:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D23CC0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 14:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 22B252051F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 14:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXtgjfNW8ji8 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 14:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 4866C203E5
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 14:31:27 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id BF3F4A1754057E9ACDF6;
 Tue,  3 Nov 2020 14:31:23 +0000 (GMT)
Received: from [10.47.5.37] (10.47.5.37) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 3 Nov 2020
 14:31:23 +0000
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: Robin Murphy <robin.murphy@arm.com>, <vjitta@codeaurora.org>,
 <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
Date: Tue, 3 Nov 2020 14:31:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.5.37]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

T24gMDMvMTEvMjAyMCAxMjozNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDktMzAg
MDg6NDQsIHZqaXR0YUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gRnJvbTogVmlqYXlhbmFuZCBK
aXR0YSA8dmppdHRhQGNvZGVhdXJvcmEub3JnPgo+Pgo+PiBXaGVuIGV2ZXIgYW4gaW92YSBhbGxv
YyByZXF1ZXN0IGZhaWxzIHdlIGZyZWUgdGhlIGlvdmEKPj4gcmFuZ2VzIHByZXNlbnQgaW4gdGhl
IHBlcmNwdSBpb3ZhIHJjYWNoZXMgYW5kIHRoZW4gcmV0cnkKPj4gYnV0IHRoZSBnbG9iYWwgaW92
YSByY2FjaGUgaXMgbm90IGZyZWVkIGFzIGEgcmVzdWx0IHdlIGNvdWxkCj4+IHN0aWxsIHNlZSBp
b3ZhIGFsbG9jIGZhaWx1cmUgZXZlbiBhZnRlciByZXRyeSBhcyBnbG9iYWwKPj4gcmNhY2hlIGlz
IGhvbGRpbmcgdGhlIGlvdmEncyB3aGljaCBjYW4gY2F1c2UgZnJhZ21lbnRhdGlvbi4KPj4gU28s
IGZyZWUgdGhlIGdsb2JhbCBpb3ZhIHJjYWNoZSBhcyB3ZWxsIGFuZCB0aGVuIGdvIGZvciB0aGUK
Pj4gcmV0cnkuCj4gCgpJZiB3ZSBkbyBjbGVhciBhbGwgdGhlIENQVSByY2FjaGVzLCBpdCB3b3Vs
ZCBuaWNlIHRvIGhhdmUgc29tZXRoaW5nIAppbW1lZGlhdGVseSBhdmFpbGFibGUgdG8gcmVwbGVu
aXNoLCBpLmUuIHVzZSB0aGUgZ2xvYmFsIHJjYWNoZSwgaW5zdGVhZCAKb2YgZmx1c2hpbmcgaXQs
IGlmIHRoYXQgaXMgbm90IHJlcXVpcmVkLi4uCgo+IFRoaXMgbG9va3MgcmVhc29uYWJsZSB0byBt
ZSAtIGl0J3MgbWlsZGx5IGFubm95aW5nIHRoYXQgd2UgZW5kIHVwIHdpdGggCj4gc28gbWFueSBz
aW1pbGFyLWxvb2tpbmcgZnVuY3Rpb25zLAoKV2VsbCBJIGRpZCBhZGQgYSBmdW5jdGlvbiB0byBj
bGVhciBhbGwgQ1BVIHJjYWNoZXMgaGVyZSwgaWYgeW91IHdvdWxkIApsaWtlIHRvIGNoZWNrOgoK
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMTYwMzczMzUwMS0yMTEwMDQtMi1n
aXQtc2VuZC1lbWFpbC1qb2huLmdhcnJ5QGh1YXdlaS5jb20vCgo+IGJ1dCB0aGUgbmVjZXNzYXJ5
IGRpZmZlcmVuY2VzIGFyZSAKPiByaWdodCBkb3duIGluIHRoZSBtaWRkbGUgb2YgdGhlIGxvb3Bz
IHNvIG5vdGhpbmcgY2FuIHJlYXNvbmFibHkgYmUgCj4gZmFjdG9yZWQgb3V0IDooCj4gCj4gUmV2
aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gCj4+IFNpZ25l
ZC1vZmYtYnk6IFZpamF5YW5hbmQgSml0dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9yZz4KPj4gLS0t
Cj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysK
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gaW5kZXggYzNh
MWE4ZS4uZmFmOWIxMyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gKysr
IGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gQEAgLTI1LDYgKzI1LDcgQEAgc3RhdGljIHZvaWQg
aW5pdF9pb3ZhX3JjYWNoZXMoc3RydWN0IGlvdmFfZG9tYWluIAo+PiAqaW92YWQpOwo+PiDCoCBz
dGF0aWMgdm9pZCBmcmVlX2lvdmFfcmNhY2hlcyhzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKTsK
Pj4gwqAgc3RhdGljIHZvaWQgZnFfZGVzdHJveV9hbGxfZW50cmllcyhzdHJ1Y3QgaW92YV9kb21h
aW4gKmlvdmFkKTsKPj4gwqAgc3RhdGljIHZvaWQgZnFfZmx1c2hfdGltZW91dChzdHJ1Y3QgdGlt
ZXJfbGlzdCAqdCk7Cj4+ICtzdGF0aWMgdm9pZCBmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoc3Ry
dWN0IGlvdmFfZG9tYWluICppb3ZhZCk7CgphIHRob3VnaHQ6IEl0IHdvdWxkIGJlIGdyZWF0IGlm
IHRoZSBmaWxlIGNvdWxkIGJlIHJlYXJyYW5nZWQgYXQgc29tZSAKcG9pbnQgd2hlcmUgd2UgZG9u
J3QgcmVxdWlyZSBzbyBtYW55IGZvcndhcmQgZGVjbGFyYXRpb25zLgoKPj4gwqAgdm9pZAo+PiDC
oCBpbml0X2lvdmFfZG9tYWluKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIGxv
bmcgZ3JhbnVsZSwKPj4gQEAgLTQ0Miw2ICs0NDMsNyBAQCBhbGxvY19pb3ZhX2Zhc3Qoc3RydWN0
IGlvdmFfZG9tYWluICppb3ZhZCwgCj4+IHVuc2lnbmVkIGxvbmcgc2l6ZSwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGZsdXNoX3JjYWNoZSA9IGZhbHNlOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZm9y
X2VhY2hfb25saW5lX2NwdShjcHUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWVf
Y3B1X2NhY2hlZF9pb3ZhcyhjcHUsIGlvdmFkKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGZyZWVfZ2xv
YmFsX2NhY2hlZF9pb3Zhcyhpb3ZhZCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJldHJ5
Owo+PiDCoMKgwqDCoMKgIH0KPj4gQEAgLTEwNTcsNSArMTA1OSwyNiBAQCB2b2lkIGZyZWVfY3B1
X2NhY2hlZF9pb3Zhcyh1bnNpZ25lZCBpbnQgY3B1LCAKPj4gc3RydWN0IGlvdmFfZG9tYWluICpp
b3ZhZCkKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIH0KPj4gKy8qCj4+ICsgKiBmcmVlIGFsbCB0aGUg
SU9WQSByYW5nZXMgb2YgZ2xvYmFsIGNhY2hlCj4+ICsgKi8KPj4gK3N0YXRpYyB2b2lkIGZyZWVf
Z2xvYmFsX2NhY2hlZF9pb3ZhcyhzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKQo+PiArewo+PiAr
wqDCoMKgIHN0cnVjdCBpb3ZhX3JjYWNoZSAqcmNhY2hlOwo+PiArwqDCoMKgIHVuc2lnbmVkIGxv
bmcgZmxhZ3M7Cj4+ICvCoMKgwqAgaW50IGksIGo7Cj4+ICsKPj4gK8KgwqDCoCBmb3IgKGkgPSAw
OyBpIDwgSU9WQV9SQU5HRV9DQUNIRV9NQVhfU0laRTsgKytpKSB7Cj4+ICvCoMKgwqDCoMKgwqDC
oCByY2FjaGUgPSAmaW92YWQtPnJjYWNoZXNbaV07Cj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xv
Y2tfaXJxc2F2ZSgmcmNhY2hlLT5sb2NrLCBmbGFncyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBmb3Ig
KGogPSAwOyBqIDwgcmNhY2hlLT5kZXBvdF9zaXplOyArK2opIHsKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW92YV9tYWdhemluZV9mcmVlX3BmbnMocmNhY2hlLT5kZXBvdFtqXSwgaW92YWQp
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb3ZhX21hZ2F6aW5lX2ZyZWUocmNhY2hlLT5k
ZXBvdFtqXSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjYWNoZS0+ZGVwb3Rbal0gPSBO
VUxMOwoKSSBkb24ndCB0aGluayB0aGF0IE5VTExpZnkgaXMgc3RyaWN0bHkgbmVjZXNzYXJ5Cgo+
PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgwqDCoMKgwqAgcmNhY2hlLT5kZXBvdF9zaXpl
ID0gMDsKPj4gK8KgwqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnJjYWNoZS0+
bG9jaywgZmxhZ3MpOwo+PiArwqDCoMKgIH0KPj4gK30KPj4gwqAgTU9EVUxFX0FVVEhPUigiQW5p
bCBTIEtlc2hhdmFtdXJ0aHkgPGFuaWwucy5rZXNoYXZhbXVydGh5QGludGVsLmNvbT4iKTsKPj4g
wqAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gaW9tbXUgbWFpbGluZyBsaXN0Cj4gaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
