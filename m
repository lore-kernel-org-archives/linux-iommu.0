Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA39C56201
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 02:30:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4F22075A
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 02:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4F22075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AA60876F5;
	Thu, 26 Nov 2020 02:30:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oAlJ6oz93a0P; Thu, 26 Nov 2020 02:30:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD3A1876EE;
	Thu, 26 Nov 2020 02:30:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B66B8C0891;
	Thu, 26 Nov 2020 02:30:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85155C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 02:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B941876F2
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 02:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RyMOtz+IrpZM for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 02:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D7A65876EE
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 02:30:11 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ChMCg3QWMzLqTs;
 Thu, 26 Nov 2020 10:29:35 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 10:29:58 +0800
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
To: Will Deacon <will@kernel.org>
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
 <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
 <454f5e3e-c380-e8a5-9283-3f7578eb601e@huawei.com>
 <20201117224102.GD524@willie-the-truck>
 <78bee047-ab33-4d81-6f77-af4c5b6e8aaa@huawei.com>
 <20201125113545.GA15451@willie-the-truck>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <9e7481f4-e55e-6c7a-dde9-62912c6e5eb4@huawei.com>
Date: Thu, 26 Nov 2020 10:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201125113545.GA15451@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTEvMjUgMTk6MzUsIFdpbGwgRGVhY29uIHdyb3RlOgo+IE9uIFdlZCwgTm92IDI1
LCAyMDIwIGF0IDA5OjU0OjM0QU0gKzA4MDAsIFlhbmcgWWluZ2xpYW5nIHdyb3RlOgo+PiBPbiAy
MDIwLzExLzE4IDY6NDEsIFdpbGwgRGVhY29uIHdyb3RlOgo+Pj4gT24gVHVlLCBOb3YgMTcsIDIw
MjAgYXQgMDc6MTE6MjhQTSArMDgwMCwgWWFuZyBZaW5nbGlhbmcgd3JvdGU6Cj4+Pj4gT24gMjAy
MC8xMS8xNyAxNzo0MCwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4+IE9uIDIwMjAvMTEvMTcgMTA6NTIs
IFlhbmcgWWluZ2xpYW5nIHdyb3RlOgo+Pj4+Pj4gSWYgaW9tbXVfZ3JvdXBfZ2V0KCkgZmFpbGVk
LCBpdCBuZWVkIHJldHVybiBlcnJvciBjb2RlCj4+Pj4+PiBpbiBpb21tdV9wcm9iZV9kZXZpY2Uo
KS4KPj4+Pj4+Cj4+Pj4+PiBGaXhlczogY2YxOTM4ODhiZmJkICgiaW9tbXU6IE1vdmUgbmV3IHBy
b2JlX2RldmljZSBwYXRoLi4uIikKPj4+Pj4+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxr
Y2lAaHVhd2VpLmNvbT4KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWWluZ2xpYW5nIDx5YW5n
eWluZ2xpYW5nQGh1YXdlaS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+ICAgwqAgZHJpdmVycy9pb21t
dS9pb21tdS5jIHwgNCArKystCj4+Pj4+PiAgIMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+Pj4+PiBpbmRleCBiNTM0NDZi
YjhjNmIuLjZmNGEzMmRmOTBmNiAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9t
bXUuYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+Pj4+PiBAQCAtMjUzLDgg
KzI1MywxMCBAQCBpbnQgaW9tbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikKPj4+
Pj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX291dDsKPj4+Pj4+ICAgwqAgwqDCoMKg
wqDCoCBncm91cCA9IGlvbW11X2dyb3VwX2dldChkZXYpOwo+Pj4+Pj4gLcKgwqDCoCBpZiAoIWdy
b3VwKQo+Pj4+Pj4gK8KgwqDCoCBpZiAoIWdyb3VwKSB7Cj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVOT0RFVjsKPj4+Pj4gQ2FuIHlvdSBwbGVhc2UgZXhwbGFpbiB3aHkgeW91IHVzZSAt
RU5PREVWIGhlcmU/Cj4+Pj4gQmVmb3JlIDc5NjU5MTkwZWU5NyAoImlvbW11OiBEb24ndCB0YWtl
IGdyb3VwIHJlZmVyZW5jZSBpbgo+Pj4+IGlvbW11X2FsbG9jX2RlZmF1bHRfZG9tYWluKCkiKSwg
aW4KPj4+Pgo+Pj4+IGlvbW11X2FsbG9jX2RlZmF1bHRfZG9tYWluKCksIGlmIGdyb3VwIGlzIE5V
TEwsIGl0IHdpbGwgcmV0dXJuIC1FTk9ERVYuCj4+PiBIbW0uIFdoaWxlIEkgdGhpbmsgdGhlIHBh
dGNoIGlzIG9rLCBJJ20gbm90IHN1cmUgaXQgcXVhbGlmaWVzIGFzIGEgZml4Lgo+Pj4gSGFzIGlv
bW11X3Byb2JlX2RldmljZSgpIGV2ZXIgcHJvcGFnYXRlZCB0aGlzIGVycm9yPyBUaGUgY29tbWl0
IHlvdQo+Pj4gaWRlbnRpZnkgaW4gdGhlICdGaXhlczonIHRhZyBkb2Vzbid0IHNlZW0gdG8gY2hh
bmdlIHRoaXMgYWZhaWN0Lgo+PiBJIHRoaW5rIGFmdGVyIHRoaXMgY29tbWl0IDQzOTk0NWU3NGE0
YiAoImlvbW11OiBNb3ZlIGRlZmF1bHQgZG9tYWluCj4+IGFsbG9jYXRpb24gdG8gaW9tbXVfcHJv
YmVfZGV2aWNlKCkiKSwKPiBUaGF0IFNIQSBkb2Vzbid0IGV4aXN0IGluIG15IHRyZWUgKG1heWJl
IHlvdSBtZWFuIDZlMWFhMjA0OTE1ND8pLiBCdXQgZXZlbgo+IHRoZW4sIEknbSBub3Qgc3VyZSA2
ZTFhYTIwNDkxNTQgaXMgYWN0dWFsbHkgYnJva2VuIGlmIHlvdSBsb29rIGF0IHRoZQo+IGludGVy
YWN0aW9uIHdpdGggZ3JvdXAgY3JlYXRpb24gaW4gX19pb21tdV9wcm9iZV9kZXZpY2UoKS4KPgo+
IEluIGZhY3QsIGlzbid0IHRoYXQgdGhlIGNhc2UgaW4gbWFpbmxpbmUgdG9vPyBJZiBfX2lvbW11
X3Byb2JlX2RldmljZSgpCj4gcmV0dXJucyAwLCB0aGVuIHdlIF9rbm93XyBhIGdyb3VwIGV4aXN0
cyBhbmQgc28gaW9tbXVfZ3JvdXBfZ2V0KCkgd2lsbAo+IHN1Y2NlZWQuIEknbSBzdGlsbCBoYXBw
eSB3aXRoIHRoZSBwYXRjaCBpbiBjYXNlIHRoaXMgY2hhbmdlcyBpbiBmdXR1cmUsCj4gYnV0IGl0
IGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGZpeGluZyBhbnl0aGluZy4gRG8geW91IGFncmVlPwoKWWVz
LCBJIGxvb2sgaW50byB0aGUgX19pb21tdV9wcm9iZV9kZXZpY2UoKSwgaWYgaXQgY2FuJ3QgZ2V0
IGdyb3VwLCBpdCAKd2lsbCByZXR1cm4gZXJyb3IKCmZpcnN0LsKgIERvIEkgbmVlZCBzZW5kIGEg
djIgd2l0aG91dCB0aGUgZml4IHRhZyA/Cgo+Cj4gV2lsbAo+IC4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
