Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E2C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 03:55:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B0B22597
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 03:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B0B22597
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37CB28689D;
	Tue,  5 Jan 2021 03:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJTuO-ShUmVH; Tue,  5 Jan 2021 03:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 301308686B;
	Tue,  5 Jan 2021 03:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1229AC088B;
	Tue,  5 Jan 2021 03:55:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7DD6C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 03:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9F15A8686B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 03:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqyP5ul+0CS4 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 03:55:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 87EB58689B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 03:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609818924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ij2Q4K/HNjjCnEbhR5nYkOPgqdZ08oveYJIO3xHvf3w=;
 b=H2A23f4WnzT0hdy5NTaUTETQvQRK7/9PdUMYSoDvBGiTFbgYd11pQnk64450DHbMeDqhr1
 wySu7/rP6tLoAIeTwqPafQNNGWgpqKN0KCUPPLVBdti0ZwNh6hW6kbFlvlQ1vU/I6YLpsE
 BSooP200mNkWrrvJRvw3HGmgX6bYvBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-Bh_QOVzBNd2_C-beX7WtwA-1; Mon, 04 Jan 2021 22:55:20 -0500
X-MC-Unique: Bh_QOVzBNd2_C-beX7WtwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DBE0800D62;
 Tue,  5 Jan 2021 03:55:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-214.pek2.redhat.com
 [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 056981002382;
 Tue,  5 Jan 2021 03:55:16 +0000 (UTC)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
From: lijiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
References: <20201226053959.4222-1-lijiang@redhat.com>
Message-ID: <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
Date: Tue, 5 Jan 2021 11:55:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201226053959.4222-1-lijiang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: jroedel@suse.de, will@kernel.org, iommu@lists.linux-foundation.org
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

SGksCgpBbHNvIGFkZCBKb2VyZyB0byBjYyBsaXN0LgoKVGhhbmtzLgpMaWFuYm8K5ZyoIDIwMjDl
ubQxMuaciDI25pelIDEzOjM5LCBMaWFuYm8gSmlhbmcg5YaZ6YGTOgo+IEN1cnJlbnRseSwgYmVj
YXVzZSBkb21haW4gYXR0YWNoIGFsbG93cyB0byBiZSBkZWZlcnJlZCBmcm9tIGlvbW11Cj4gZHJp
dmVyIHRvIGRldmljZSBkcml2ZXIsIGFuZCB3aGVuIGlvbW11IGluaXRpYWxpemVzLCB0aGUgZGV2
aWNlcwo+IG9uIHRoZSBidXMgd2lsbCBiZSBzY2FubmVkIGFuZCB0aGUgZGVmYXVsdCBncm91cHMg
d2lsbCBiZSBhbGxvY2F0ZWQuCj4gCj4gRHVlIHRvIHRoZSBhYm92ZSBjaGFuZ2VzLCBzb21lIGRl
dmljZXMgY291bGQgYmUgYWRkZWQgdG8gdGhlIHNhbWUKPiBncm91cCBhcyBiZWxvdzoKPiAKPiBb
ICAgIDMuODU5NDE3XSBwY2kgMDAwMDowMTowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTYK
PiBbICAgIDMuODY0NTcyXSBwY2kgMDAwMDowMTowMC4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
MTYKPiBbICAgIDMuODY5NzM4XSBwY2kgMDAwMDowMjowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3Jv
dXAgMTcKPiBbICAgIDMuODc0ODkyXSBwY2kgMDAwMDowMjowMC4xOiBBZGRpbmcgdG8gaW9tbXUg
Z3JvdXAgMTcKPiAKPiBCdXQgd2hlbiBhdHRhY2hpbmcgdGhlc2UgZGV2aWNlcywgaXQgZG9lc24n
dCBhbGxvdyB0aGF0IGEgZ3JvdXAgaGFzCj4gbW9yZSB0aGFuIG9uZSBkZXZpY2UsIG90aGVyd2lz
ZSBpdCB3aWxsIHJldHVybiBhbiBlcnJvci4gVGhpcyBjb25mbGljdHMKPiB3aXRoIHRoZSBkZWZl
cnJlZCBhdHRhY2hpbmcuIFVuZm9ydHVuYXRlbHksIGl0IGhhcyB0d28gZGV2aWNlcyBpbiB0aGUK
PiBzYW1lIGdyb3VwIGZvciBteSBzaWRlLCBmb3IgZXhhbXBsZToKPiAKPiBbICAgIDkuNjI3MDE0
XSBpb21tdV9ncm91cF9kZXZpY2VfY291bnQoKTogZGV2aWNlIG5hbWVbMF06MDAwMDowMTowMC4w
Cj4gWyAgICA5LjYzMzU0NV0gaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KCk6IGRldmljZSBuYW1l
WzFdOjAwMDA6MDE6MDAuMQo+IC4uLgo+IFsgICAxMC4yNTU2MDldIGlvbW11X2dyb3VwX2Rldmlj
ZV9jb3VudCgpOiBkZXZpY2UgbmFtZVswXTowMDAwOjAyOjAwLjAKPiBbICAgMTAuMjYyMTQ0XSBp
b21tdV9ncm91cF9kZXZpY2VfY291bnQoKTogZGV2aWNlIG5hbWVbMV06MDAwMDowMjowMC4xCj4g
Cj4gRmluYWxseSwgd2hpY2ggY2F1c2VkIHRoZSBmYWlsdXJlIG9mIHRnMyBkcml2ZXIgd2hlbiB0
ZzMgZHJpdmVyIGNhbGxzCj4gdGhlIGRtYV9hbGxvY19jb2hlcmVudCgpIHRvIGFsbG9jYXRlIGNv
aGVyZW50IG1lbW9yeSBpbiB0aGUgdGczX3Rlc3RfZG1hKCkuCj4gCj4gWyAgICA5LjY2MDMxMF0g
dGczIDAwMDA6MDE6MDAuMDogRE1BIGVuZ2luZSB0ZXN0IGZhaWxlZCwgYWJvcnRpbmcKPiBbICAg
IDkuNzU0MDg1XSB0ZzM6IHByb2JlIG9mIDAwMDA6MDE6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAt
MTIKPiBbICAgIDkuOTk3NTEyXSB0ZzMgMDAwMDowMTowMC4xOiBETUEgZW5naW5lIHRlc3QgZmFp
bGVkLCBhYm9ydGluZwo+IFsgICAxMC4wNDMwNTNdIHRnMzogcHJvYmUgb2YgMDAwMDowMTowMC4x
IGZhaWxlZCB3aXRoIGVycm9yIC0xMgo+IFsgICAxMC4yODg5MDVdIHRnMyAwMDAwOjAyOjAwLjA6
IERNQSBlbmdpbmUgdGVzdCBmYWlsZWQsIGFib3J0aW5nCj4gWyAgIDEwLjMzNDA3MF0gdGczOiBw
cm9iZSBvZiAwMDAwOjAyOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEyCj4gWyAgIDEwLjU3ODMw
M10gdGczIDAwMDA6MDI6MDAuMTogRE1BIGVuZ2luZSB0ZXN0IGZhaWxlZCwgYWJvcnRpbmcKPiBb
ICAgMTAuNjIyNjI5XSB0ZzM6IHByb2JlIG9mIDAwMDA6MDI6MDAuMSBmYWlsZWQgd2l0aCBlcnJv
ciAtMTIKPiAKPiBJbiBhZGRpdGlvbiwgdGhlIHNpbWlsYXIgc2l0dWF0aW9ucyBhbHNvIG9jY3Vy
IGluIG90aGVyIGRyaXZlcnMgc3VjaAo+IGFzIHRoZSBibnh0X2VuIGRyaXZlci4gVGhhdCBjYW4g
YmUgcmVwcm9kdWNlZCBlYXNpbHkgaW4ga2R1bXAga2VybmVsCj4gd2hlbiBTTUUgaXMgYWN0aXZl
Lgo+IAo+IEFkZCBhIGNoZWNrIGZvciB0aGUgZGVmZXJyZWQgYXR0YWNoIGluIHRoZSBpb21tdV9h
dHRhY2hfZGV2aWNlKCkgYW5kCj4gYWxsb3cgdG8gYXR0YWNoIHRoZSBkZWZlcnJlZCBkZXZpY2Ug
cmVnYXJkbGVzcyBvZiBob3cgbWFueSBkZXZpY2VzCj4gYXJlIGluIGEgZ3JvdXAuCj4gCj4gU2ln
bmVkLW9mZi1ieTogTGlhbmJvIEppYW5nIDxsaWppYW5nQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvaW9tbXUvaW9tbXUuYyB8IDUgKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiBpbmRleCBmZmVlYmRhOGQ2ZGUuLmRjY2Fi
N2IxMzNmYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKPiArKysgYi9kcml2
ZXJzL2lvbW11L2lvbW11LmMKPiBAQCAtMTk2Nyw4ICsxOTY3LDExIEBAIGludCBpb21tdV9hdHRh
Y2hfZGV2aWNlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0IGRldmljZSAqZGV2
KQo+ICAJICovCj4gIAltdXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwo+ICAJcmV0ID0gLUVJTlZB
TDsKPiAtCWlmIChpb21tdV9ncm91cF9kZXZpY2VfY291bnQoZ3JvdXApICE9IDEpCj4gKwlpZiAo
IWlvbW11X2lzX2F0dGFjaF9kZWZlcnJlZChkb21haW4sIGRldikgJiYKPiArCSAgICBpb21tdV9n
cm91cF9kZXZpY2VfY291bnQoZ3JvdXApICE9IDEpIHsKPiArCQlkZXZfZXJyX3JhdGVsaW1pdGVk
KGRldiwgIkdyb3VwIGhhcyBtb3JlIHRoYW4gb25lIGRldmljZVxuIik7Cj4gIAkJZ290byBvdXRf
dW5sb2NrOwo+ICsJfQo+ICAKPiAgCXJldCA9IF9faW9tbXVfYXR0YWNoX2dyb3VwKGRvbWFpbiwg
Z3JvdXApOwo+ICAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
