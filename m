Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08808C4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:37:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDC722B2D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 14:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDC722B2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB6D82E16F;
	Fri, 25 Sep 2020 14:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eaM1bp-L2vO7; Fri, 25 Sep 2020 14:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0423B203F0;
	Fri, 25 Sep 2020 14:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7DBFC0890;
	Fri, 25 Sep 2020 14:37:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D62E2C0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C06C086917
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q6P7FwQYeg-6 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 14:37:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 64C9F868AB
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:37:35 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 124BC412629B66515EF8;
 Fri, 25 Sep 2020 15:37:32 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.140) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 15:37:31 +0100
Subject: Re: [PATCH 1/2] iommu/iova: Flush CPU rcache for when a depot fills
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <1601027469-221812-1-git-send-email-john.garry@huawei.com>
 <1601027469-221812-2-git-send-email-john.garry@huawei.com>
 <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <11d30dc2-0b2d-fc30-a07a-9c5f18064d2b@huawei.com>
Date: Fri, 25 Sep 2020 15:34:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <bede311f-9a07-98e1-e728-9acd4ad13b51@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.7.140]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, xiyou.wangcong@gmail.com
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

T24gMjUvMDkvMjAyMCAxMjo1MywgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiAtLS0KPj4gwqAgZHJp
dmVycy9pb21tdS9pb3ZhLmMgfCAyNSArKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBp
bmRleCA0NWEyNTFkYTU0NTMuLjA1ZTBiNDYyZTBkOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9p
b21tdS9pb3ZhLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gQEAgLTg5Miw5ICs4
OTIsOCBAQCBzdGF0aWMgYm9vbCBfX2lvdmFfcmNhY2hlX2luc2VydChzdHJ1Y3QgCj4+IGlvdmFf
ZG9tYWluICppb3ZhZCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBpb3ZhX3JjYWNoZSAqcmNhY2hlLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgbG9uZyBpb3ZhX3BmbikKPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVj
dCBpb3ZhX21hZ2F6aW5lICptYWdfdG9fZnJlZSA9IE5VTEw7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGlvdmFfY3B1X3JjYWNoZSAqY3B1X3JjYWNoZTsKPj4gLcKgwqDCoCBib29sIGNhbl9pbnNlcnQg
PSBmYWxzZTsKPj4gK8KgwqDCoCBib29sIGNhbl9pbnNlcnQgPSBmYWxzZSwgZmx1c2ggPSBmYWxz
ZTsKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+PiDCoMKgwqDCoMKgIGNwdV9y
Y2FjaGUgPSByYXdfY3B1X3B0cihyY2FjaGUtPmNwdV9yY2FjaGVzKTsKPj4gQEAgLTkxMywxMyAr
OTEyLDE5IEBAIHN0YXRpYyBib29sIF9faW92YV9yY2FjaGVfaW5zZXJ0KHN0cnVjdCAKPj4gaW92
YV9kb21haW4gKmlvdmFkLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmNhY2hl
LT5kZXBvdF9zaXplIDwgTUFYX0dMT0JBTF9NQUdTKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmNhY2hlLT5kZXBvdFtyY2FjaGUtPmRlcG90X3NpemUrK10gPQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVfcmNh
Y2hlLT5sb2FkZWQ7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuX2luc2Vy
dCA9IHRydWU7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X3JjYWNoZS0+
bG9hZGVkID0gbmV3X21hZzsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsK
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYWdfdG9fZnJlZSA9IGNwdV9yY2Fj
aGUtPmxvYWRlZDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgZGVwb3QgaXMgZnVsbCwgbWVhbmlu
ZyB0aGF0IGEgdmVyeSBsYXJnZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiBjYWNoZSBvZiBJT1ZBcyBoYXMgYnVpbHQgdXAsIHdoaWNoIHNsb3dzCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRvd24gUkIgdHJlZSBhY2Nlc3NlcyBzaWduaWZpY2Fu
dGx5Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIC0+IGxldCdzIGZsdXNo
IGF0IHRoaXMgcG9pbnQuCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsdXNoID0gdHJ1ZTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb3ZhX21hZ2F6aW5lX2ZyZWUobmV3X21hZyk7Cj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3Bpbl91bmxvY2soJnJjYWNoZS0+bG9jayk7Cj4+IC0KPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY3B1X3JjYWNoZS0+bG9hZGVkID0gbmV3X21hZzsKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY2FuX2luc2VydCA9IHRydWU7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgwqDC
oMKgwqAgfQo+PiBAQCAtOTI4LDkgKzkzMywxMSBAQCBzdGF0aWMgYm9vbCBfX2lvdmFfcmNhY2hl
X2luc2VydChzdHJ1Y3QgCj4+IGlvdmFfZG9tYWluICppb3ZhZCwKPj4gwqDCoMKgwqDCoCBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZjcHVfcmNhY2hlLT5sb2NrLCBmbGFncyk7Cj4+IC3CoMKgwqAg
aWYgKG1hZ190b19mcmVlKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpb3ZhX21hZ2F6aW5lX2ZyZWVf
cGZucyhtYWdfdG9fZnJlZSwgaW92YWQpOwo+PiAtwqDCoMKgwqDCoMKgwqAgaW92YV9tYWdhemlu
ZV9mcmVlKG1hZ190b19mcmVlKTsKPj4gK8KgwqDCoCBpZiAoZmx1c2gpIHsKPiAKPiBEbyB5b3Ug
cmVhbGx5IG5lZWQgdGhpcyBmbGFnLCBvciBpcyBpdCBlZmZlY3RpdmVseSBqdXN0IG1pcnJvcmlu
ZyAKPiAiIWNhbl9pbnNlcnQiIC0gaW4gdGhlb3J5IGlmIHRoZXJlIHdhc24ndCBlbm91Z2ggbWVt
b3J5IHRvIGFsbG9jYXRlIGEgCj4gbmV3IG1hZ2F6aW5lLCB0aGVuIGZyZWVpbmcgc29tZSBtb3Jl
IElPVkFzIHdvdWxkbid0IG5lY2Vzc2FyaWx5IGJlIGEgYmFkIAo+IHRoaW5nIHRvIGRvIGFueXdh
eS4KClJpZ2h0LCBJIGNhbiByZXVzZSBjYW5faW5zZXJ0LgoKPiAKPiBPdGhlciB0aGFuIHRoYXQs
IEkgdGhpbmsgdGhpcyBsb29rcyByZWFzb25hYmxlLiBFdmVyeSB0aW1lIEkgbG9vayBhdCAKPiBf
X2lvdmFfcmNhY2hlX2luc2VydCgpIEknbSBjb252aW5jZWQgdGhlcmUgbXVzdCBiZSBhIHdheSB0
byByZXN0cnVjdHVyZSAKPiBpdCB0byBiZSBtb3JlIHN0cmVhbWxpbmVkIG92ZXJhbGwsIGJ1dCBJ
IGNhbiBuZXZlciBxdWl0ZSBzZWUgZXhhY3RseSBob3cuLi4KPiAKCldlIGNvdWxkIHJlbW92ZSB0
aGUgbmV3X21hZyBjaGVjaywgYnV0IHRoZSBjb2RlIGNhbm5vdCBzYWZlbHkgaGFuZGxlIApsb2Fk
ZWQvcHJldiA9IE5VTEwuIEluZGVlZCwgSSB0aGluayB0aGF0IHRoZSBtYWlubGluZSBjb2RlIGhh
cyBhIGJ1ZzoKCklmIHRoZSBpbml0aWFsIGFsbG9jYXRpb24gZm9yIHRoZSBsb2FkZWQvcHJldiBt
YWdhemluZXMgZmFpbCAoZ2l2ZSBOVUxMKSAKaW4gaW5pdF9pb3ZhX3JjYWNoZXMoKSwgdGhlbiBp
biBfX2lvdmFfcmNhY2hlX2luc2VydCgpOgoKaWYgKCFpb3ZhX21hZ2F6aW5lX2Z1bGwoY3B1X3Jj
YWNoZS0+bG9hZGVkKSkgewoJY2FuX2luc2VydCA9IHRydWU7CgpJZiBjcHVfcmNhY2hlLT5sb2Fk
ZWQgPT0gTlVMTCwgdGhlbiBjYW5faW5zZXJ0IGlzIGFzc2lnbmVkIHRydWUgLT4gYmFuZywgCmFz
IEkgZXhwZXJpbWVudGVkLCBiZWxvdy4gVGhpcyBuZWVkcyB0byBiZSBmaXhlZC4uLgoKVGhhbmtz
LApqb2huCgoKCmVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwMDAK
WyAxMC4xOTUyOTldIE1lbSBhYm9ydCBpbmZvOgpbIDEwLjE5ODA4MF0gRVNSID0gMHg5NjAwMDAw
NApbIDEwLjIwMTEyMV0gRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRz
ClsgMTAuMjA2NDE4XSBTRVQgPSAwLCBGblYgPSAwClsgMTAuMjA5NDU5XSBFQSA9IDAsIFMxUFRX
ID0gMApbIDEwLjIxMjU4NV0gRGF0YSBhYm9ydCBpbmZvOgpbIDEwLjIxNTQ1Ml0gSVNWID0gMCwg
SVNTID0gMHgwMDAwMDAwNApbIDEwLjIxOTI3NF0gQ00gPSAwLCBXblIgPSAwClsgMTAuMjIyMjI4
XSBbMDAwMDAwMDAwMDAwMDAwMF0gdXNlciBhZGRyZXNzIGJ1dCBhY3RpdmVfbW0gaXMgc3dhcHBl
cgpbIDEwLjIyODU2OV0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDk2MDAwMDA0IFsjMV0gUFJFRU1Q
VCBTTVAKWyAxMC4yMzQxMjddIE1vZHVsZXMgbGlua2VkIGluOgpbIDEwLjIzNzE3MF0gQ1BVOiAx
MSBQSUQ6IDY5NiBDb21tOiBpcnEvNDAtaGlzaV9zYXMgTm90IHRhaW50ZWQgCjUuOS4wLXJjNS00
NzczOC1nYjFlYWQ2NTdhM2ZhLWRpcnR5ICM2NTgKWyAxMC4yNDY1NDhdIEhhcmR3YXJlIG5hbWU6
IEh1YXdlaSBEMDYgL0QwNiwgQklPUyBIaXNpbGljb24gRDA2IFVFRkkgUkMwIAotIFYxLjE2LjAx
IDAzLzE1LzIwMTkKWyAxMC4yNTUwNThdIHBzdGF0ZTogNjBjMDAwODkgKG5aQ3YgZGFJZiArUEFO
ICtVQU8gQlRZUEU9LS0pClsgMTAuMjYwNjIwXSBwYyA6IGZyZWVfaW92YV9mYXN0KzB4ZmMvMHgy
ODAKWyAxMC4yNjQ3MDNdIGxyIDogZnJlZV9pb3ZhX2Zhc3QrMHg5NC8weDI4MApbIDEwLjI2ODc4
NV0gc3AgOiBmZmZmODAwMDI0NzdiYmIwClsgMTAuMjcyMDg2XSB4Mjk6IGZmZmY4MDAwMjQ3N2Ji
YjAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMjc3Mzg1XSB4Mjc6IGZmZmYwMDJiYzhmYmI5
NDAgeDI2OiBmZmZmMDAyYmM3MjdlMjZjClsgMTAuMjgyNjg0XSB4MjU6IDAwMDAwMDAwMDAwMDAw
MDAgeDI0OiBmZmZmMDAyYmM5NDM5MDA4ClsgMTAuMjg3OTgyXSB4MjM6IDAwMDAwMDAwMDAwZmRm
ZmUgeDIyOiAwMDAwMDAwMDAwMDAwMDgwClsgMTAuMjkzMjgwXSB4MjE6IGZmZmYwMDJiYzk0Mzkw
MDggeDIwOiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMjk4NTc5XSB4MTk6IGZmZmZmNDAzZTllYmI3
MDAgeDE4OiBmZmZmZmZmZmZmZmZmZmZmClsgMTAuMzAzODc3XSB4MTc6IDAwMDAwMDAwMDAwMDAw
MDEgeDE2OiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMzA5MTc2XSB4MTU6IDAwMDAwMDAwMDAwMGZm
ZmYgeDE0OiAwMDAwMDAwMDAwMDAwMDQwClsgMTAuMzE0NDc0XSB4MTM6IDAwMDAwMDAwMDAwMDdm
ZmYgeDEyOiAwMDAwMDAwMDAwMDFmZmZmClsgMTAuMzE5NzcyXSB4MTE6IDAwMDAwMDAwMDAwMDAw
MGYgeDEwOiAwMDAwMDAwMDAwMDA2MDAwClsgMTAuMzI1MDcwXSB4OSA6IDAwMDAwMDAwMDAwMDAw
MDAgeDggOiBmZmZmODAwMDI0NzdiNzY4ClsgMTAuMzMwMzY4XSB4NyA6IDAwMDAwMDAwMDAwMDAw
MDAgeDYgOiAwMDAwMDAwMDAwMDAwMDNmClsgMTAuMzM1NjY2XSB4NSA6IDAwMDAwMDAwMDAwMDAw
NDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMzQwOTY0XSB4MyA6IGZmZmZmNDAzZTllYmI3
MDAgeDIgOiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMzQ2MjYyXSB4MSA6IDAwMDAwMDAwMDAwMDAw
MDAgeDAgOiAwMDAwMDAwMDAwMDAwMDAwClsgMTAuMzUxNTYxXSBDYWxsIHRyYWNlOgpbIDEwLjM1
Mzk5NV1mcmVlX2lvdmFfZmFzdCsweGZjLzB4MjgwClsgMTAuMzU3NzMxXWlvbW11X2RtYV9mcmVl
X2lvdmErMHg2NC8weDcwClsgMTAuMzYxODE0XV9faW9tbXVfZG1hX3VubWFwKzB4OWMvMHhmOApb
IDEwLjM2NTcyM11pb21tdV9kbWFfdW5tYXBfc2crMHhhOC8weGM4ClsgMTAuMzY5NzIwXWRtYV91
bm1hcF9zZ19hdHRycysweDI4LzB4NTAKWyAxMC4zNzM3MTddY3FfdGhyZWFkX3YzX2h3KzB4MmRj
LzB4NTI4ClsgMTAuMzc3NjI2XWlycV90aHJlYWRfZm4rMHgyYy8weGEwClsgMTAuMzgxMTg4XWly
cV90aHJlYWQrMHgxMzAvMHgxZTAKWyAxMC4zODQ2NjRda3RocmVhZCsweDE1NC8weDE1OApbIDEw
LjM4Nzg3OV1yZXRfZnJvbV9mb3JrKzB4MTAvMHgzNApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
