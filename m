Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB8C433ED
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 09:19:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA816117A
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 09:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA816117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C152960DD6;
	Fri, 16 Apr 2021 09:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgqDImA2PTyC; Fri, 16 Apr 2021 09:19:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAEF460DD4;
	Fri, 16 Apr 2021 09:19:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FBBCC000C;
	Fri, 16 Apr 2021 09:19:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72CF6C000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 537CC40285
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1mLJeQmoTON for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 338894027D
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:19:42 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FM9b44ygnzB1dG;
 Fri, 16 Apr 2021 17:17:20 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 16 Apr 2021
 17:19:30 +0800
Subject: Re: [PATCH v2] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
To: John Garry <john.garry@huawei.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <joro@8bytes.org>
References: <1618458725-244583-1-git-send-email-chenxiang66@hisilicon.com>
 <80a373d8-0136-b026-9b72-d558c0dd2a66@huawei.com>
 <10c2cba9-9515-a555-314e-f5449dfd67f5@hisilicon.com>
 <193ec6d8-f68a-210b-5172-c97591019b7f@huawei.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <ef3ae8b2-b990-cbf7-2cdc-dc734c8df276@hisilicon.com>
Date: Fri, 16 Apr 2021 17:19:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <193ec6d8-f68a-210b-5172-c97591019b7f@huawei.com>
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

CgrlnKggMjAyMS80LzE2IDE2OjUzLCBKb2huIEdhcnJ5IOWGmemBkzoKPiBPbiAxNi8wNC8yMDIx
IDA0OjMwLCBjaGVueGlhbmcgKE0pIHdyb3RlOgo+Pj4KPj4+IHlvdSBuZWVkIHRvIG1ha2UgdGhp
czoKPj4+ICAgICBpZiAoaW92YSkKPj4+ICAgICAgICAgZnJlZV9pb3ZhX21lbShpb3ZhKTsKPj4+
Cj4+PiBhcyBmcmVlX2lvdmFfbWVtKGlvdmEpIGRlcmVmZXJlbmNlcyBpb3ZhOgo+Pj4KPj4+IGlm
IChpb3ZhLT5wZm5fbG8gIT0gSU9WQV9BTkNIT1IpCj4+PiAgICAga21lbV9jYWNoZV9mcmVlKGlv
dmFfY2FjaGUsIGlvdmEpCj4+Pgo+Pj4gU28gaWYgaW92YSB3ZXJlIE5VTEwsIHdlIGNyYXNoLgo+
Pj4KPj4+IE9yIHlvdSBjYW4gbWFrZSBmcmVlX2lvdmFfbWVtKCkgTlVMTCBzYWZlLgo+Pgo+PiBS
aWdodCwgaXQgaGFzIHRoZSBpc3N1ZS4gV2hhdCBhYm91dCBjaGFuZ2luZyBpdCBhcyBiZWxvdz8K
Pj4KPj4gQEAgLTQ3MiwxMCArNDcyLDEzIEBAIGZyZWVfaW92YShzdHJ1Y3QgaW92YV9kb21haW4g
KmlvdmFkLCB1bnNpZ25lZCAKPj4gbG9uZyBwZm4pCj4+Cj4+ICAgICAgICAgIHNwaW5fbG9ja19p
cnFzYXZlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOwo+PiAgICAgICAgICBpb3Zh
ID0gcHJpdmF0ZV9maW5kX2lvdmEoaW92YWQsIHBmbik7Cj4+IC0gICAgICAgaWYgKGlvdmEpCj4+
IC0gICAgICAgICAgICAgICBwcml2YXRlX2ZyZWVfaW92YShpb3ZhZCwgaW92YSk7Cj4+ICsgICAg
ICAgaWYgKCFpb3ZhKSB7Cj4+ICsgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaW92YWQtPmlvdmFf
cmJ0cmVlX2xvY2ssIGZsYWdzKTsKPj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPj4gKyAgICAg
ICB9Cj4+ICsgICAgICAgcmVtb3ZlX2lvdmEoaW92YWQsIGlvdmEpOwo+PiAgICAgICAgICBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZpb3ZhZC0+aW92YV9yYnRyZWVfbG9jaywgZmxhZ3MpOwo+PiAt
Cj4+ICsgICAgICAgZnJlZV9pb3ZhX21lbShpb3ZhKTsKPj4gICB9Cj4+ICAgRVhQT1JUX1NZTUJP
TF9HUEwoZnJlZV9pb3ZhKTsKPgo+IEkgZG9uJ3QgZmVlbCB0b28gc3Ryb25nbHkgYWJvdXQgaG93
IGl0J3MgZG9uZS4KPgo+IFBsZWFzZSBub3RlIHRoYXQga21lbV9jYWNoZV9mcmVlKCkgaXMgbm90
IE5VTEwgc2FmZS4gU28gdGhlIE5VTEwgY2hlY2sgCj4gY291bGQgYmUgYWRkZWQgaW4gZnJlZV9p
b3ZhX21lbSgpLCBidXQgd2UgcHJvYiBkb24ndCB3YW50IHNpbGVudCAKPiBmcmVlX2lvdmFfbWVt
KE5VTEwpIGNhbGxzLCBzbyBJIHdvdWxkIHN0aWNrIHdpdGggY2hhbmdpbmcgZnJlZV9pb3ZhKCku
CgpzbyBJIHdvdWxkIHN0aWNrIHdpdGggY2hhbmdpbmcgZnJlZV9pb3ZhKCkKLS0tLS0gRG8geW91
IG1lYW4gZnJlZV9pb3ZhX21lbSgpPwoKQnV0IGkgdGhpbmsgdGhlcmUgaXMgYSBjaGVjayAoanVk
Z2UgaW92YSBpcyBOVUxMKSBiZWZvcmUgZnJlZV9pb3ZhX21lbSgpIApmb3IgZm9sbG93aW5nIHNj
ZW5hcmlvcywgYW5kIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gY2hhbmdlIGluIGZ1bmNpdG9uIApm
cmVlX2lvdmFfbWVtKCk6CjEpIGlvdmFfbWFnYXppbmVfZnJlZV9wZm5zKCkKMikgYWxsb2NfaW92
YSgpCjMpIGZyZWVfaW92YSgpCjQpIF9fZnJlZV9pb3ZhKCk6IFRob3NlIGZ1bmN0aW9ucyB3aGlj
aCBjYWxsIF9fZnJlZV9pb3ZhKCkgaGF2ZSBhIGNoZWNrCgpPbmx5IGZvciBmdW5jdGlvbiBwdXRf
aW92YV9kb2FtaW4oKSwgaXQgZG9lc24ndCBjaGVjayBpb3ZhLCBidXQgaSB0aGluayAKaW92YSBp
biByYnRyZWUgc2hvdWxkIG5vdCBiZSBOVUxMLgoKPgo+IFRoYW5rcywKPiBKb2huCj4KPiAuCj4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
