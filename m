Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D42C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 12:31:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766AD23C18
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 12:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766AD23C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D7CB92050E;
	Wed,  9 Dec 2020 12:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ukhERb74SnR; Wed,  9 Dec 2020 12:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1203820454;
	Wed,  9 Dec 2020 12:31:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF9A3C0FA7;
	Wed,  9 Dec 2020 12:31:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2248C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B0FCD874D1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBJaKdgEjxKy for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C52A874AB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 12:31:43 +0000 (UTC)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Crbxj5Jp1zhmwK;
 Wed,  9 Dec 2020 20:31:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Dec 2020
 20:31:27 +0800
Subject: Re: [RESEND PATCH v3 2/4] iommu/iova: Avoid double-negatives in
 magazine helpers
To: John Garry <john.garry@huawei.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <1605608734-84416-3-git-send-email-john.garry@huawei.com>
 <7eb70f4b-b050-24ca-f1fa-d8f3c9ddce65@huawei.com>
 <7dfee7b0-0d51-b342-5318-09470c56f0d9@huawei.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <af4dc808-4103-3825-f26e-edcb38cac5c7@huawei.com>
Date: Wed, 9 Dec 2020 20:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7dfee7b0-0d51-b342-5318-09470c56f0d9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Cc: "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

CgpPbiAyMDIwLzEyLzkgMTk6MzksIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMDkvMTIvMjAyMCAw
OTowMywgTGVpemhlbiAoVGh1bmRlclRvd24pIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDIwLzExLzE3
IDE4OjI1LCBKb2huIEdhcnJ5IHdyb3RlOgo+Pj4gQSBzaW1pbGFyIGNyYXNoIHRvIHRoZSBmb2xs
b3dpbmcgY291bGQgYmUgb2JzZXJ2ZWQgaWYgaW5pdGlhbCBDUFUgcmNhY2hlCj4+PiBtYWdhemlu
ZSBhbGxvY2F0aW9ucyBmYWlsIGluIGluaXRfaW92YV9yY2FjaGVzKCk6Cj4+Pgo+Pj4gVW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRk
cmVzcyAwMDAwMDAwMDAwMDAwMDAwCj4+PiBNZW0gYWJvcnQgaW5mbzoKPj4+IMKgwqDCoCBFU1Ig
PSAweDk2MDAwMDA0Cj4+PiDCoMKgwqAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwg
PSAzMiBiaXRzCj4+PiDCoMKgwqAgU0VUID0gMCwgRm5WID0gMAo+Pj4gwqDCoMKgIEVBID0gMCwg
UzFQVFcgPSAwCj4+PiBEYXRhIGFib3J0IGluZm86Cj4+PiDCoMKgwqAgSVNWID0gMCwgSVNTID0g
MHgwMDAwMDAwNAo+Pj4gwqDCoMKgIENNID0gMCwgV25SID0gMAo+Pj4gWzAwMDAwMDAwMDAwMDAw
MDBdIHVzZXIgYWRkcmVzcyBidXQgYWN0aXZlX21tIGlzIHN3YXBwZXIKPj4+IEludGVybmFsIGVy
cm9yOiBPb3BzOiA5NjAwMDAwNCBbIzFdIFBSRUVNUFQgU01QCj4+PiBNb2R1bGVzIGxpbmtlZCBp
bjoKPj4+IENQVTogMTEgUElEOiA2OTYgQ29tbTogaXJxLzQwLWhpc2lfc2FzIE5vdCB0YWludGVk
IDUuOS4wLXJjNy1kaXJ0eSAjMTA5Cj4+PiBIYXJkd2FyZSBuYW1lOiBIdWF3ZWkgRDA2IC9EMDYs
IEJJT1MgSGlzaWxpY29uIEQwNiBVRUZJIFJDMCAtIFYxLjE2LjAxIDAzLzE1LzIwMTkKPj4+IENh
bGwgdHJhY2U6Cj4+PiDCoMKgIGZyZWVfaW92YV9mYXN0KzB4ZmMvMHgyODAKPj4+IMKgwqAgaW9t
bXVfZG1hX2ZyZWVfaW92YSsweDY0LzB4NzAKPj4+IMKgwqAgX19pb21tdV9kbWFfdW5tYXArMHg5
Yy8weGY4Cj4+PiDCoMKgIGlvbW11X2RtYV91bm1hcF9zZysweGE4LzB4YzgKPj4+IMKgwqAgZG1h
X3VubWFwX3NnX2F0dHJzKzB4MjgvMHg1MAo+Pj4gwqDCoCBjcV90aHJlYWRfdjNfaHcrMHgyZGMv
MHg1MjgKPj4+IMKgwqAgaXJxX3RocmVhZF9mbisweDJjLzB4YTAKPj4+IMKgwqAgaXJxX3RocmVh
ZCsweDEzMC8weDFlMAo+Pj4gwqDCoCBrdGhyZWFkKzB4MTU0LzB4MTU4Cj4+PiDCoMKgIHJldF9m
cm9tX2ZvcmsrMHgxMC8weDM0Cj4+Pgo+Pj4gQ29kZTogZjk0MDAwNjAgZjEwMjAwMWYgNTQwMDA5
ODEgZDQyMTAwMDAgKGY5NDAwMDQzKQo+Pj4KPj4+IMKgIC0tLVsgZW5kIHRyYWNlIDRhZmNiZGZj
NjFiNjA0NjcgXS0tLQo+Pj4KPj4+IFRoZSBpc3N1ZSBpcyB0aGF0IGV4cHJlc3Npb24gIWlvdmFf
bWFnYXppbmVfZnVsbChOVUxMKSBldmFsdWF0ZXMgdHJ1ZTsgdGhpcwo+Pj4gZmFsbHMgb3ZlciBp
biBpbiBfX2lvdmFfcmNhY2hlX2luc2VydCgpIHdoZW4gd2UgYXR0ZW1wdCB0byBjYWNoZSBhIG1h
Zwo+Pj4gYW5kIGNwdV9yY2FjaGUtPmxvYWRlZCA9PSBOVUxMOgo+Pj4KPj4+IGlmICghaW92YV9t
YWdhemluZV9mdWxsKGNwdV9yY2FjaGUtPmxvYWRlZCkpIHsKPj4+IMKgwqDCoMKgY2FuX2luc2Vy
dCA9IHRydWU7Cj4+PiAuLi4KPj4+Cj4+PiBpZiAoY2FuX2luc2VydCkKPj4+IMKgwqDCoMKgaW92
YV9tYWdhemluZV9wdXNoKGNwdV9yY2FjaGUtPmxvYWRlZCwgaW92YV9wZm4pOwo+Pj4KPj4+IEFz
IGFib3ZlLCBjYW5faW5zZXJ0IGlzIGV2YWx1YXRlZCB0cnVlLCB3aGljaCBpdCBzaG91bGRuJ3Qg
YmUsIGFuZCB3ZSB0cnkKPj4+IHRvIGluc2VydCBwZm5zIGluIGEgTlVMTCBtYWcsIHdoaWNoIGlz
IG5vdCBzYWZlLgo+Pj4KPj4+IFRvIGF2b2lkIHRoaXMsIHN0b3AgdXNpbmcgZG91YmxlLW5lZ2F0
aXZlcywgbGlrZSAhaW92YV9tYWdhemluZV9mdWxsKCkgYW5kCj4+PiAhaW92YV9tYWdhemluZV9l
bXB0eSgpLCBhbmQgdXNlIHBvc2l0aXZlIHRlc3RzLCBsaWtlCj4+PiBpb3ZhX21hZ2F6aW5lX2hh
c19zcGFjZSgpIGFuZCBpb3ZhX21hZ2F6aW5lX2hhc19wZm5zKCksIHJlc3BlY3RpdmVseTsgdGhl
c2UKPj4+IGNhbiBzYWZlbHkgZGVhbCB3aXRoIGNwdV9yY2FjaGUtPntsb2FkZWQsIHByZXZ9ID0g
TlVMTC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdl
aS5jb20+Cj4gCj4gVGhhbmtzIGZvciBjaGVja2luZyBoZXJlLi4uCj4gCj4+PiAtLS0KPj4+IMKg
IGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMjkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0K
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11
L2lvdmEuYwo+Pj4gaW5kZXggODFiNzM5OWRkNWU4Li4xZjNmMGY4YjEyZTAgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2lvdmEuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMK
Pj4+IEBAIC04MjcsMTQgKzgyNywxOCBAQCBpb3ZhX21hZ2F6aW5lX2ZyZWVfcGZucyhzdHJ1Y3Qg
aW92YV9tYWdhemluZSAqbWFnLCBzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKQo+Pj4gwqDCoMKg
wqDCoCBtYWctPnNpemUgPSAwOwo+Pj4gwqAgfQo+Pj4gwqAgLXN0YXRpYyBib29sIGlvdmFfbWFn
YXppbmVfZnVsbChzdHJ1Y3QgaW92YV9tYWdhemluZSAqbWFnKQo+Pj4gK3N0YXRpYyBib29sIGlv
dmFfbWFnYXppbmVfaGFzX3NwYWNlKHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcpCj4+PiDCoCB7
Cj4+PiAtwqDCoMKgIHJldHVybiAobWFnICYmIG1hZy0+c2l6ZSA9PSBJT1ZBX01BR19TSVpFKTsK
Pj4+ICvCoMKgwqAgaWYgKCFtYWcpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo+
Pj4gK8KgwqDCoCByZXR1cm4gbWFnLT5zaXplIDwgSU9WQV9NQUdfU0laRTsKPj4+IMKgIH0KPj4+
IMKgIC1zdGF0aWMgYm9vbCBpb3ZhX21hZ2F6aW5lX2VtcHR5KHN0cnVjdCBpb3ZhX21hZ2F6aW5l
ICptYWcpCj4+PiArc3RhdGljIGJvb2wgaW92YV9tYWdhemluZV9oYXNfcGZucyhzdHJ1Y3QgaW92
YV9tYWdhemluZSAqbWFnKQo+Pj4gwqAgewo+Pj4gLcKgwqDCoCByZXR1cm4gKCFtYWcgfHwgbWFn
LT5zaXplID09IDApOwo+Pj4gK8KgwqDCoCBpZiAoIW1hZykKPj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gZmFsc2U7Cj4+PiArwqDCoMKgIHJldHVybiBtYWctPnNpemU7Cj4+PiDCoCB9Cj4+PiDC
oCDCoCBzdGF0aWMgdW5zaWduZWQgbG9uZyBpb3ZhX21hZ2F6aW5lX3BvcChzdHJ1Y3QgaW92YV9t
YWdhemluZSAqbWFnLAo+Pj4gQEAgLTg0Myw3ICs4NDcsNyBAQCBzdGF0aWMgdW5zaWduZWQgbG9u
ZyBpb3ZhX21hZ2F6aW5lX3BvcChzdHJ1Y3QgaW92YV9tYWdhemluZSAqbWFnLAo+Pj4gwqDCoMKg
wqDCoCBpbnQgaTsKPj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwZm47Cj4+PiDCoCAtwqDC
oMKgIEJVR19PTihpb3ZhX21hZ2F6aW5lX2VtcHR5KG1hZykpOwo+Pj4gK8KgwqDCoCBCVUdfT04o
IWlvdmFfbWFnYXppbmVfaGFzX3BmbnMobWFnKSk7Cj4+PiDCoCDCoMKgwqDCoMKgIC8qIE9ubHkg
ZmFsbCBiYWNrIHRvIHRoZSByYnRyZWUgaWYgd2UgaGF2ZSBubyBzdWl0YWJsZSBwZm5zIGF0IGFs
bCAqLwo+Pj4gwqDCoMKgwqDCoCBmb3IgKGkgPSBtYWctPnNpemUgLSAxOyBtYWctPnBmbnNbaV0g
PiBsaW1pdF9wZm47IGktLSkKPj4+IEBAIC04NTksNyArODYzLDcgQEAgc3RhdGljIHVuc2lnbmVk
IGxvbmcgaW92YV9tYWdhemluZV9wb3Aoc3RydWN0IGlvdmFfbWFnYXppbmUgKm1hZywKPj4+IMKg
IMKgIHN0YXRpYyB2b2lkIGlvdmFfbWFnYXppbmVfcHVzaChzdHJ1Y3QgaW92YV9tYWdhemluZSAq
bWFnLCB1bnNpZ25lZCBsb25nIHBmbikKPj4+IMKgIHsKPj4+IC3CoMKgwqAgQlVHX09OKGlvdmFf
bWFnYXppbmVfZnVsbChtYWcpKTsKPj4+ICvCoMKgwqAgQlVHX09OKCFpb3ZhX21hZ2F6aW5lX2hh
c19zcGFjZShtYWcpKTsKPj4+IMKgIMKgwqDCoMKgwqAgbWFnLT5wZm5zW21hZy0+c2l6ZSsrXSA9
IHBmbjsKPj4+IMKgIH0KPj4+IEBAIC05MDUsOSArOTA5LDkgQEAgc3RhdGljIGJvb2wgX19pb3Zh
X3JjYWNoZV9pbnNlcnQoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwKPj4+IMKgwqDCoMKgwqAg
Y3B1X3JjYWNoZSA9IHJhd19jcHVfcHRyKHJjYWNoZS0+Y3B1X3JjYWNoZXMpOwo+Pj4gwqDCoMKg
wqDCoCBzcGluX2xvY2tfaXJxc2F2ZSgmY3B1X3JjYWNoZS0+bG9jaywgZmxhZ3MpOwo+Pj4gwqAg
LcKgwqDCoCBpZiAoIWlvdmFfbWFnYXppbmVfZnVsbChjcHVfcmNhY2hlLT5sb2FkZWQpKSB7Cj4g
Cj4gKgo+IAo+Pj4gK8KgwqDCoCBpZiAoaW92YV9tYWdhemluZV9oYXNfc3BhY2UoY3B1X3JjYWNo
ZS0+bG9hZGVkKSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhbl9pbnNlcnQgPSB0cnVlOwo+
Pj4gLcKgwqDCoCB9IGVsc2UgaWYgKCFpb3ZhX21hZ2F6aW5lX2Z1bGwoY3B1X3JjYWNoZS0+cHJl
dikpIHsKPj4+ICvCoMKgwqAgfSBlbHNlIGlmIChpb3ZhX21hZ2F6aW5lX2hhc19zcGFjZShjcHVf
cmNhY2hlLT5wcmV2KSkgewo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN3YXAoY3B1X3JjYWNoZS0+
cHJldiwgY3B1X3JjYWNoZS0+bG9hZGVkKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYW5faW5z
ZXJ0ID0gdHJ1ZTsKPj4+IMKgwqDCoMKgwqAgfSBlbHNlIHsKPj4+IEBAIC05MTYsOCArOTIwLDkg
QEAgc3RhdGljIGJvb2wgX19pb3ZhX3JjYWNoZV9pbnNlcnQoc3RydWN0IGlvdmFfZG9tYWluICpp
b3ZhZCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobmV3X21hZykgewo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZyY2FjaGUtPmxvY2spOwo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJjYWNoZS0+ZGVwb3Rfc2l6ZSA8IE1BWF9HTE9CQUxfTUFH
Uykgewo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByY2FjaGUtPmRlcG90W3Jj
YWNoZS0+ZGVwb3Rfc2l6ZSsrXSA9Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjcHVfcmNhY2hlLT5sb2FkZWQ7Cj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmIChjcHVfcmNhY2hlLT5sb2FkZWQpCj4+Cj4+IExvb2tzIGxpa2Ug
aXQganVzdCBuZWVkcyB0byBjaGFuZ2UgdGhpcyBwbGFjZS4gQ29tcGlsZXIgZW5zdXJlcyB0aGF0
IG1hZy0+c2l6ZQo+PiB3aWxsIG5vdCBiZSBhY2Nlc3NlZCB3aGVuIG1hZyBpcyBOVUxMLgo+IAo+
IE5vdCBzdXJlIGFib3V0IHRoYXQuIFdlIHdvdWxkIGdldCBhIGNyYXNoIHByaW9yIHRvIHRvdWNo
aW5nIHRoaXMgY29kZXBhdGg6Cj4gCj4gU28gaWYgY3B1X3JjYWNoZS0+bG9hZGVkID09IE5VTEwg
YXQgZW50cnksIHRoZW4gIWlvdmFfbWFnYXppbmVfZnVsbChjcHVfcmNhY2hlLT5sb2FkZWQgKD09
TlVMTCkgKSBldmFsdWF0ZXMgdHJ1ZSwgKiBhYm92ZSwgc28gY2FuX2luc2VydCBpcyBzZXQgdHJ1
ZSwgYW5kIHdlIHRoZW4gYXR0ZW1wdCBpb3ZhX21hZ2F6aW5lX3B1c2goY3B1X3JjYWNoZS0+bG9h
ZGVkICg9PU5VTEwpLCBpb3ZhX3BmbiksIHdoaWNoIGlzIG5vdCBzYWZlLgo+IAo+IG9rPwoKT0ss
IEkgZ290IGl0LgoKUmV2aWV3ZWQtYnk6IFpoZW4gTGVpIDx0aHVuZGVyLmxlaXpoZW5AaHVhd2Vp
LmNvbT4KCj4gCj4gQ2hlZXJzLAo+IEpvaG4KPiAKPj4KPj4gc3RhdGljIGJvb2wgaW92YV9tYWdh
emluZV9mdWxsKHN0cnVjdCBpb3ZhX21hZ2F6aW5lICptYWcpCj4+IHsKPj4gwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gKG1hZyAmJiBtYWctPnNpemUgPT0gSU9WQV9NQUdfU0laRSk7Cj4+IH0KPj4K
Pj4gc3RhdGljIGJvb2wgaW92YV9tYWdhemluZV9lbXB0eShzdHJ1Y3QgaW92YV9tYWdhemluZSAq
bWFnKQo+PiB7Cj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuICghbWFnIHx8IG1hZy0+c2l6ZSA9
PSAwKTsKPj4gfQo+Pgo+IAo+IAo+IAo+IAo+Pgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJjYWNoZS0+ZGVwb3RbcmNhY2hlLT5kZXBvdF9zaXplKytdID0KPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3B1X3JjYWNoZS0+bG9hZGVkOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNl
IHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFnX3RvX2ZyZWUgPSBj
cHVfcmNhY2hlLT5sb2FkZWQ7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiBA
QCAtOTY4LDkgKzk3Myw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9faW92YV9yY2FjaGVfZ2V0
KHN0cnVjdCBpb3ZhX3JjYWNoZSAqcmNhY2hlLAo+Pj4gwqDCoMKgwqDCoCBjcHVfcmNhY2hlID0g
cmF3X2NwdV9wdHIocmNhY2hlLT5jcHVfcmNhY2hlcyk7Cj4+PiDCoMKgwqDCoMKgIHNwaW5fbG9j
a19pcnFzYXZlKCZjcHVfcmNhY2hlLT5sb2NrLCBmbGFncyk7Cj4+PiDCoCAtwqDCoMKgIGlmICgh
aW92YV9tYWdhemluZV9lbXB0eShjcHVfcmNhY2hlLT5sb2FkZWQpKSB7Cj4+PiArwqDCoMKgIGlm
IChpb3ZhX21hZ2F6aW5lX2hhc19wZm5zKGNwdV9yY2FjaGUtPmxvYWRlZCkpIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBoYXNfcGZuID0gdHJ1ZTsKPj4+IC3CoMKgwqAgfSBlbHNlIGlmICghaW92
YV9tYWdhemluZV9lbXB0eShjcHVfcmNhY2hlLT5wcmV2KSkgewo+Pj4gK8KgwqDCoCB9IGVsc2Ug
aWYgKGlvdmFfbWFnYXppbmVfaGFzX3BmbnMoY3B1X3JjYWNoZS0+cHJldikpIHsKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBzd2FwKGNwdV9yY2FjaGUtPnByZXYsIGNwdV9yY2FjaGUtPmxvYWRlZCk7
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaGFzX3BmbiA9IHRydWU7Cj4+PiDCoMKgwqDCoMKgIH0g
ZWxzZSB7Cj4+Pgo+Pgo+IAo+IAo+IC4KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
