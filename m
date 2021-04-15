Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFEC433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 01:05:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8B06117A
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 01:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8B06117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D72FC405F8;
	Thu, 15 Apr 2021 01:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtfcI1iIx2ju; Thu, 15 Apr 2021 01:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79085405DA;
	Thu, 15 Apr 2021 01:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE7FC000B;
	Thu, 15 Apr 2021 01:05:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDA57C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 01:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0AA34018E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 01:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpgigCHq6Tx7 for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 01:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E4F040118
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 01:05:31 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FLLgr05p5zjZsG;
 Thu, 15 Apr 2021 09:03:36 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 15 Apr 2021
 09:05:19 +0800
Subject: Re: [PATCH] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
References: <1618382307-59139-1-git-send-email-chenxiang66@hisilicon.com>
 <0394ac29-f120-6c16-502c-f40a3a3a4353@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <f04cfcc8-46f9-4aa8-f73e-7afff91f31de@hisilicon.com>
Date: Thu, 15 Apr 2021 09:05:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <0394ac29-f120-6c16-502c-f40a3a3a4353@arm.com>
X-Originating-IP: [10.40.193.166]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

SGkgUm9iaW4sCgoK5ZyoIDIwMjEvNC8xNCAyMToxNywgUm9iaW4gTXVycGh5IOWGmemBkzoKPiBP
biAyMDIxLTA0LTE0IDA3OjM4LCBjaGVueGlhbmcgd3JvdGU6Cj4+IEZyb206IFhpYW5nIENoZW4g
PGNoZW54aWFuZzY2QGhpc2lsaWNvbi5jb20+Cj4+Cj4+IEl0IGlzIG5vdCBuZWNlc3NhcnkgdG8g
cHV0IGZyZWVfaW92YV9tZW0oKSBpbnNpZGUgb2Ygc3BpbmxvY2svdW5sb2NrCj4+IGlvdmFfcmJ0
cmVlX2xvY2sgd2hpY2ggb25seSBsZWFkcyB0byBtb3JlIGNvbXBsZXRpb24gZm9yIHRoZSBzcGlu
bG9jay4KPj4gSXQgaGFzIGEgc21hbGwgcHJvbW90ZSBvbiB0aGUgcGVyZm9ybWFuY2UgYWZ0ZXIg
dGhlIGNoYW5nZS4KPgo+IFRoaXMgc2VlbXMgbm90IGVudGlyZWx5IHVucmVhc29uYWJsZSwgYnV0
IHByaXZhdGVfZnJlZV9pb3ZhKCkgcmVhbGx5IAo+IG5lZWRzIHRvIGJlIHJlbmFtZWQgKG1heWJl
IHNvbWV0aGluZyBsaWtlIHJlbW92ZV9pb3ZhKCk/KSBpZiBpdCdzIG5vIAo+IGxvbmdlciBhY3R1
YWxseSBmcmVlaW5nIGFueXRoaW5nIC0gb3RoZXJ3aXNlIGl0J3MganVzdCB1bm5lY2Vzc2FyaWx5
IAo+IG1pc2xlYWRpbmcuCgpPaywgaSB3aWxsIHJlbmFtZSBmdW5jdGlvbiBwcml2YXRlX2ZyZWVf
aW92YSgpIGluIG5leHQgdmVyc2lvbi4KCj4KPiBSb2Jpbi4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBY
aWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNpbGljb24uY29tPgo+PiAtLS0KPj4gICBkcml2ZXJz
L2lvbW11L2lvdmEuYyB8IDUgKysrLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3Zh
LmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBpbmRleCBjNjY5NTI2Zi4uMjkyZWQ0YSAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4gKysrIGIvZHJpdmVycy9pb21tdS9p
b3ZhLmMKPj4gQEAgLTMzOSw3ICszMzksNiBAQCBzdGF0aWMgdm9pZCBwcml2YXRlX2ZyZWVfaW92
YShzdHJ1Y3QgaW92YV9kb21haW4gCj4+ICppb3ZhZCwgc3RydWN0IGlvdmEgKmlvdmEpCj4+ICAg
ICAgIGFzc2VydF9zcGluX2xvY2tlZCgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2spOwo+PiAgICAg
ICBfX2NhY2hlZF9yYm5vZGVfZGVsZXRlX3VwZGF0ZShpb3ZhZCwgaW92YSk7Cj4+ICAgICAgIHJi
X2VyYXNlKCZpb3ZhLT5ub2RlLCAmaW92YWQtPnJicm9vdCk7Cj4+IC0gICAgZnJlZV9pb3ZhX21l
bShpb3ZhKTsKPj4gICB9Cj4+ICAgICAvKioKPj4gQEAgLTM3Niw2ICszNzUsNyBAQCBfX2ZyZWVf
aW92YShzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkLCBzdHJ1Y3QgCj4+IGlvdmEgKmlvdmEpCj4+
ICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3Mp
Owo+PiAgICAgICBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7Cj4+ICAgICAgIHNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmlvdmFkLT5pb3ZhX3JidHJlZV9sb2NrLCBmbGFncyk7Cj4+ICsg
ICAgZnJlZV9pb3ZhX21lbShpb3ZhKTsKPj4gICB9Cj4+ICAgRVhQT1JUX1NZTUJPTF9HUEwoX19m
cmVlX2lvdmEpOwo+PiAgIEBAIC0zOTcsNyArMzk3LDcgQEAgZnJlZV9pb3ZhKHN0cnVjdCBpb3Zh
X2RvbWFpbiAqaW92YWQsIHVuc2lnbmVkIAo+PiBsb25nIHBmbikKPj4gICAgICAgaWYgKGlvdmEp
Cj4+ICAgICAgICAgICBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7Cj4+ICAgICAgIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmlvdmFkLT5pb3ZhX3JidHJlZV9sb2NrLCBmbGFncyk7Cj4+
IC0KPj4gKyAgICBmcmVlX2lvdmFfbWVtKGlvdmEpOwo+PiAgIH0KPj4gICBFWFBPUlRfU1lNQk9M
X0dQTChmcmVlX2lvdmEpOwo+PiAgIEBAIC03NDYsNiArNzQ2LDcgQEAgaW92YV9tYWdhemluZV9m
cmVlX3BmbnMoc3RydWN0IGlvdmFfbWFnYXppbmUgCj4+ICptYWcsIHN0cnVjdCBpb3ZhX2RvbWFp
biAqaW92YWQpCj4+ICAgICAgICAgICAgICAgY29udGludWU7Cj4+ICAgICAgICAgICAgIHByaXZh
dGVfZnJlZV9pb3ZhKGlvdmFkLCBpb3ZhKTsKPj4gKyAgICAgICAgZnJlZV9pb3ZhX21lbShpb3Zh
KTsKPj4gICAgICAgfQo+PiAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlvdmFkLT5p
b3ZhX3JidHJlZV9sb2NrLCBmbGFncyk7Cj4+Cj4KPiAuCj4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
