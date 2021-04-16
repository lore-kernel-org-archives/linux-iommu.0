Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAFFC433B4
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 03:30:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2D8611AC
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 03:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2D8611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B8F74185D;
	Fri, 16 Apr 2021 03:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avZRfyXMFDMS; Fri, 16 Apr 2021 03:30:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3413140FB0;
	Fri, 16 Apr 2021 03:30:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09033C000B;
	Fri, 16 Apr 2021 03:30:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D10DC000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 03:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 875D9414F2
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 03:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ETOr3qUL320 for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:30:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE40F40FB0
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 03:30:35 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FM1rF0pw3z17QlK;
 Fri, 16 Apr 2021 11:28:13 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 16 Apr 2021
 11:30:21 +0800
Subject: Re: [PATCH v2] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <joro@8bytes.org>
References: <1618458725-244583-1-git-send-email-chenxiang66@hisilicon.com>
 <80a373d8-0136-b026-9b72-d558c0dd2a66@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <10c2cba9-9515-a555-314e-f5449dfd67f5@hisilicon.com>
Date: Fri, 16 Apr 2021 11:30:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <80a373d8-0136-b026-9b72-d558c0dd2a66@huawei.com>
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

CgrlnKggMjAyMS80LzE1IDE3OjQ5LCBKb2huIEdhcnJ5IOWGmemBkzoKPiBPbiAxNS8wNC8yMDIx
IDA0OjUyLCBjaGVueGlhbmcgd3JvdGU6Cj4+IEZyb206IFhpYW5nIENoZW4gPGNoZW54aWFuZzY2
QGhpc2lsaWNvbi5jb20+Cj4+Cj4+IEl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gcHV0IGZyZWVfaW92
YV9tZW0oKSBpbnNpZGUgb2Ygc3BpbmxvY2svdW5sb2NrCj4+IGlvdmFfcmJ0cmVlX2xvY2sgd2hp
Y2ggb25seSBsZWFkcyB0byBtb3JlIGNvbXBsZXRpb24gZm9yIHRoZSBzcGlubG9jay4KPj4gSXQg
aGFzIGEgc21hbGwgcHJvbW90ZSBvbiB0aGUgcGVyZm9ybWFuY2UgYWZ0ZXIgdGhlIGNoYW5nZS4g
QW5kIGFsc28KPj4gcmVuYW1lIHByaXZhdGVfZnJlZV9pb3ZhKCkgYXMgcmVtb3ZlX2lvdmEoKSBi
ZWNhdXNlIHRoZSBmdW5jdGlvbiB3aWxsIAo+PiBub3QKPj4gZnJlZSBpb3ZhIGFmdGVyIHRoYXQg
Y2hhbmdlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFuZyBDaGVuIDxjaGVueGlhbmc2NkBoaXNp
bGljb24uY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDEzICsrKysrKyst
LS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11
L2lvdmEuYwo+PiBpbmRleCBiN2VjZDViLi5jMTBhZjIzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2lvbW11L2lvdmEuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBAQCAtNDEyLDEy
ICs0MTIsMTEgQEAgcHJpdmF0ZV9maW5kX2lvdmEoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwg
Cj4+IHVuc2lnbmVkIGxvbmcgcGZuKQo+PiAgICAgICByZXR1cm4gTlVMTDsKPj4gICB9Cj4+ICAg
LXN0YXRpYyB2b2lkIHByaXZhdGVfZnJlZV9pb3ZhKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQs
IHN0cnVjdCAKPj4gaW92YSAqaW92YSkKPj4gK3N0YXRpYyB2b2lkIHJlbW92ZV9pb3ZhKHN0cnVj
dCBpb3ZhX2RvbWFpbiAqaW92YWQsIHN0cnVjdCBpb3ZhICppb3ZhKQo+PiAgIHsKPj4gICAgICAg
YXNzZXJ0X3NwaW5fbG9ja2VkKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jayk7Cj4+ICAgICAgIF9f
Y2FjaGVkX3Jibm9kZV9kZWxldGVfdXBkYXRlKGlvdmFkLCBpb3ZhKTsKPj4gICAgICAgcmJfZXJh
c2UoJmlvdmEtPm5vZGUsICZpb3ZhZC0+cmJyb290KTsKPj4gLSAgICBmcmVlX2lvdmFfbWVtKGlv
dmEpOwo+PiAgIH0KPj4gICAgIC8qKgo+PiBAQCAtNDUyLDggKzQ1MSw5IEBAIF9fZnJlZV9pb3Zh
KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIHN0cnVjdCAKPj4gaW92YSAqaW92YSkKPj4gICAg
ICAgdW5zaWduZWQgbG9uZyBmbGFnczsKPj4gICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmaW92
YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsKPj4gLSAgICBwcml2YXRlX2ZyZWVfaW92YShp
b3ZhZCwgaW92YSk7Cj4+ICsgICAgcmVtb3ZlX2lvdmEoaW92YWQsIGlvdmEpOwo+PiAgICAgICBz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOwo+
PiArICAgIGZyZWVfaW92YV9tZW0oaW92YSk7Cj4+ICAgfQo+PiAgIEVYUE9SVF9TWU1CT0xfR1BM
KF9fZnJlZV9pb3ZhKTsKPj4gICBAQCAtNDczLDkgKzQ3Myw5IEBAIGZyZWVfaW92YShzdHJ1Y3Qg
aW92YV9kb21haW4gKmlvdmFkLCB1bnNpZ25lZCAKPj4gbG9uZyBwZm4pCj4+ICAgICAgIHNwaW5f
bG9ja19pcnFzYXZlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOwo+PiAgICAgICBp
b3ZhID0gcHJpdmF0ZV9maW5kX2lvdmEoaW92YWQsIHBmbik7Cj4+ICAgICAgIGlmIChpb3ZhKQo+
PiAtICAgICAgICBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7Cj4+ICsgICAgICAgIHJl
bW92ZV9pb3ZhKGlvdmFkLCBpb3ZhKTsKPj4gICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
aW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsKPj4gLQo+PiArICAgIGZyZWVfaW92YV9t
ZW0oaW92YSk7Cj4KPiB5b3UgbmVlZCB0byBtYWtlIHRoaXM6Cj4gICAgIGlmIChpb3ZhKQo+ICAg
ICAgICAgZnJlZV9pb3ZhX21lbShpb3ZhKTsKPgo+IGFzIGZyZWVfaW92YV9tZW0oaW92YSkgZGVy
ZWZlcmVuY2VzIGlvdmE6Cj4KPiBpZiAoaW92YS0+cGZuX2xvICE9IElPVkFfQU5DSE9SKQo+ICAg
ICBrbWVtX2NhY2hlX2ZyZWUoaW92YV9jYWNoZSwgaW92YSkKPgo+IFNvIGlmIGlvdmEgd2VyZSBO
VUxMLCB3ZSBjcmFzaC4KPgo+IE9yIHlvdSBjYW4gbWFrZSBmcmVlX2lvdmFfbWVtKCkgTlVMTCBz
YWZlLgoKUmlnaHQsIGl0IGhhcyB0aGUgaXNzdWUuIFdoYXQgYWJvdXQgY2hhbmdpbmcgaXQgYXMg
YmVsb3c/CgpAQCAtNDcyLDEwICs0NzIsMTMgQEAgZnJlZV9pb3ZhKHN0cnVjdCBpb3ZhX2RvbWFp
biAqaW92YWQsIHVuc2lnbmVkIGxvbmcgCnBmbikKCiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZl
KCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOwogICAgICAgICBpb3ZhID0gcHJpdmF0
ZV9maW5kX2lvdmEoaW92YWQsIHBmbik7Ci0gICAgICAgaWYgKGlvdmEpCi0gICAgICAgICAgICAg
ICBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7CisgICAgICAgaWYgKCFpb3ZhKSB7Cisg
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsK
KyAgICAgICAgICAgICAgIHJldHVybjsKKyAgICAgICB9CisgICAgICAgcmVtb3ZlX2lvdmEoaW92
YWQsIGlvdmEpOwogICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpb3ZhZC0+aW92YV9y
YnRyZWVfbG9jaywgZmxhZ3MpOwotCisgICAgICAgZnJlZV9pb3ZhX21lbShpb3ZhKTsKICB9CiAg
RVhQT1JUX1NZTUJPTF9HUEwoZnJlZV9pb3ZhKTsKCj4KPj4gICB9Cj4+ICAgRVhQT1JUX1NZTUJP
TF9HUEwoZnJlZV9pb3ZhKTsKPj4gICBAQCAtODI1LDcgKzgyNSw4IEBAIGlvdmFfbWFnYXppbmVf
ZnJlZV9wZm5zKHN0cnVjdCBpb3ZhX21hZ2F6aW5lIAo+PiAqbWFnLCBzdHJ1Y3QgaW92YV9kb21h
aW4gKmlvdmFkKQo+PiAgICAgICAgICAgaWYgKFdBUk5fT04oIWlvdmEpKQo+PiAgICAgICAgICAg
ICAgIGNvbnRpbnVlOwo+PiAgIC0gICAgICAgIHByaXZhdGVfZnJlZV9pb3ZhKGlvdmFkLCBpb3Zh
KTsKPj4gKyAgICAgICAgcmVtb3ZlX2lvdmEoaW92YWQsIGlvdmEpOwo+PiArICAgICAgICBmcmVl
X2lvdmFfbWVtKGlvdmEpOwo+PiAgICAgICB9Cj4+ICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmaW92YWQtPmlvdmFfcmJ0cmVlX2xvY2ssIGZsYWdzKTsKPj4KPgo+Cj4gLgo+CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
