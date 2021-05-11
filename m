Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C34DC43460
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2983461921
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2983461921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D13FA83CC7;
	Tue, 11 May 2021 16:05:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpAAHSqPvpwD; Tue, 11 May 2021 16:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A190D83C9D;
	Tue, 11 May 2021 16:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD84C000E;
	Tue, 11 May 2021 16:05:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A398C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B644403D5
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWoMA8Qr8e9g for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30525403D6
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z2k7kEMuOxvMNfv9wyuet8mFypiPJLma4wFOmFQFhU=;
 b=UgAv0poP5eOdNcZI7JJQNujJzdA6qJNVrrSoWKPdcary+JlmutyrggXX/TkD1G1ARdDk/Q
 w6HoEuWy1pEovUbpbn0dZoJV9H7KfDHQkU81wMjXYSqxdLGi8E6+iyHljkb++fhuowA30V
 WcfQjKKS45nJrvQx2Fuc30Y6sOlGkhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Z7LXlEqAMSavyp-h4tVVsA-1; Tue, 11 May 2021 12:05:32 -0400
X-MC-Unique: Z7LXlEqAMSavyp-h4tVVsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73FD4107ACED;
 Tue, 11 May 2021 16:05:29 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B81FA5C232;
 Tue, 11 May 2021 16:05:26 +0000 (UTC)
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To: John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
Date: Tue, 11 May 2021 12:05:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

T24gNS8xLzIxIDExOjU4IFBNLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4gT24gNC84LzIxIDEwOjAx
IEFNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+IEluIG9yZGVyIHRvIGNhbGwgdXBzdHJlYW1f
YnJpZGdlX2Rpc3RhbmNlX3dhcm4oKSBmcm9tIGEgZG1hX21hcCBmdW5jdGlvbiwKPj4gaXQgbXVz
dCBub3Qgc2xlZXAuIFRoZSBvbmx5IHJlYXNvbiBpdCBkb2VzIHNsZWVwIGlzIHRvIGFsbG9jYXRl
IHRoZSBzZXFidWYKPj4gdG8gcHJpbnQgd2hpY2ggZGV2aWNlcyBhcmUgd2l0aGluIHRoZSBBQ1Mg
cGF0aC4KPj4KPj4gU3dpdGNoIHRoZSBrbWFsbG9jIGNhbGwgdG8gdXNlIGEgcGFzc2VkIGluIGdm
cF9tYXNrIGFuZCBkb24ndCBwcmludCB0aGF0Cj4+IG1lc3NhZ2UgaWYgdGhlIGJ1ZmZlciBmYWls
cyB0byBiZSBhbGxvY2F0ZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8
bG9nYW5nQGRlbHRhdGVlLmNvbT4KPj4gQWNrZWQtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL3BjaS9wMnBkbWEuYyB8IDIxICsrKysr
KysrKysrLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBkbWEuYyBi
L2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+IGluZGV4IDE5NjM4MjYzMDM2My4uYmQ4OTQzN2ZhZjA2
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+PiArKysgYi9kcml2ZXJzL3Bj
aS9wMnBkbWEuYwo+PiBAQCAtMjY3LDcgKzI2Nyw3IEBAIHN0YXRpYyBpbnQgcGNpX2JyaWRnZV9o
YXNfYWNzX3JlZGlyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+PiDCoCDCoCBzdGF0aWMgdm9pZCBz
ZXFfYnVmX3ByaW50X2J1c19kZXZmbihzdHJ1Y3Qgc2VxX2J1ZiAqYnVmLCBzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKPj4gwqAgewo+PiAtwqDCoMKgIGlmICghYnVmKQo+PiArwqDCoMKgIGlmICghYnVm
IHx8ICFidWYtPmJ1ZmZlcikKPgo+IFRoaXMgaXMgbm90IGdyZWF0LCBzb3J0IG9mIGZyb20gYW4g
b3ZlcmFsbCBkZXNpZ24gcG9pbnQgb2YgdmlldywgZXZlbiB0aG91Z2gKPiBpdCBtYWtlcyB0aGUg
cmVzdCBvZiB0aGUgcGF0Y2ggd29yay4gU2VlIGJlbG93IGZvciBvdGhlciBpZGVhcywgdGhhdCB3
aWxsCj4gYXZvaWQgdGhlIG5lZWQgZm9yIHRoaXMgc29ydCBvZiBvZGQgcG9pbnQgZml4Lgo+Cisx
LgpJbiBmYWN0LCBJIGRpZG4ndCBzZWUgaG93IHRoZSBrbWFsbG9jIHdhcyBjaGFuZ2VkLi4uIHlv
dSByZWZhY3RvcmVkIHRoZSBjb2RlIHRvIHBhc3MtaW4gdGhlCkdGUF9LRVJORUwgdGhhdCB3YXMg
b3JpZ2luYWxseSBoYXJkLWNvZGVkIGludG8gdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNlX3dhcm4o
KTsKSSBkb24ndCBzZWUgaG93IHRoYXQgYXZvaWRlZCB0aGUga21hbGxvYygpIGNhbGwuCmluIGZh
Y3QsIEkgYWxzbyBzZWUgeW91IGxvc3QgYSBmYWlsZWQga21hbGxvYygpIGNoZWNrLCBzbyBpdCBz
ZWVtcyB0byBoYXZlIHRha2VuIGEgc3RlcCBiYWNrLgoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsKPj4gwqAgwqDCoMKgwqDCoCBzZXFfYnVmX3ByaW50ZihidWYsICIlczsiLCBwY2lfbmFt
ZShwZGV2KSk7Cj4+IEBAIC00OTUsMjUgKzQ5NSwyNiBAQCB1cHN0cmVhbV9icmlkZ2VfZGlzdGFu
Y2Uoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLCBzdHJ1Y3QgcGNpX2RldiAqY2xpZW50LAo+PiDC
oCDCoCBzdGF0aWMgZW51bSBwY2lfcDJwZG1hX21hcF90eXBlCj4+IMKgIHVwc3RyZWFtX2JyaWRn
ZV9kaXN0YW5jZV93YXJuKHN0cnVjdCBwY2lfZGV2ICpwcm92aWRlciwgc3RydWN0IHBjaV9kZXYg
KmNsaWVudCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50ICpkaXN0
KQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgKmRpc3QsIGdmcF90
IGdmcF9tYXNrKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IHNlcV9idWYgYWNzX2xpc3Q7
Cj4+IMKgwqDCoMKgwqAgYm9vbCBhY3NfcmVkaXJlY3RzOwo+PiDCoMKgwqDCoMKgIGludCByZXQ7
Cj4+IMKgIC3CoMKgwqAgc2VxX2J1Zl9pbml0KCZhY3NfbGlzdCwga21hbGxvYyhQQUdFX1NJWkUs
IEdGUF9LRVJORUwpLCBQQUdFX1NJWkUpOwo+PiAtwqDCoMKgIGlmICghYWNzX2xpc3QuYnVmZmVy
KQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4KPiBBbm90aGVyIG9kZCB0aGlu
ZzogdGhpcyB1c2VkIHRvIGNoZWNrIGZvciBtZW1vcnkgZmFpbHVyZSBhbmQganVzdCBnaXZlCj4g
dXAsIGFuZCBub3cgaXQgZG9lc24ndC4gWWVzLCBJIHJlYWxpemUgdGhhdCBpdCBhbGwgc3RpbGwg
d29ya3MgYXQgdGhlCj4gbW9tZW50LCBidXQgdGhpcyBpcyBxdWlya3kgYW5kIHdlIHNob3VsZG4n
dCBzdG9wIGhlcmUuCj4KPiBJbnN0ZWFkLCBhIGNsZWFuZXIgYXBwcm9hY2ggd291bGQgYmUgdG8g
cHVzaCB0aGUgbWVtb3J5IGFsbG9jYXRpb24KPiBzbGlnaHRseSBoaWdoZXIgdXAgdGhlIGNhbGwg
c3RhY2ssIG91dCB0byB0aGUKPiBwY2lfcDJwZG1hX2Rpc3RhbmNlX21hbnkoKS4gU28gcGNpX3Ay
cGRtYV9kaXN0YW5jZV9tYW55KCkgc2hvdWxkIG1ha2UKPiB0aGUga21hbGxvYygpIGNhbGwsIGFu
ZCBmYWlsIG91dCBpZiBpdCBjYW4ndCBnZXQgYSBwYWdlIGZvciB0aGUgc2VxX2J1Zgo+IGJ1ZmZl
ci4gVGhlbiB5b3UgZG9uJ3QgaGF2ZSB0byBkbyBhbGwgdGhpcyBvZGQgc3R1ZmYuCj4KPiBGdXJ0
aGVybW9yZSwgdGhlIGNhbGwgc2l0ZXMgY2FuIHRoZW4gZGVjaWRlIGZvciB0aGVtc2VsdmVzIHdo
aWNoIEdGUAo+IGZsYWdzLCBHRlBfQVRPTUlDIG9yIEdGUF9LRVJORUwgb3Igd2hhdGV2ZXIgdGhl
eSB3YW50IGZvciBrbWFsbG9jKCkuCj4KYWdyZWUsIGdvb2QgcHJvcG9zYWwgdG8gYXZvaWQgYSBz
bGVlcCBkdWUgdG8ga21hbGxvYygpLgoKPiBBIHJlbGF0ZWQgdGhpbmc6IHRoaXMgd2hvbGUgZXhl
cmNpc2Ugd291bGQgZ28gYmV0dGVyIGlmIHRoZXJlIHdlcmUgYQo+IHByZXBhcmF0b3J5IHBhdGNo
IG9yIHR3byB0aGF0IGNoYW5nZWQgdGhlIHJldHVybiBjb2RlcyBpbiB0aGlzIGZpbGUgdG8KPiBz
b21ldGhpbmcgbGVzcyBjcmF6eS4gVGhlcmUgYXJlIHRvbyBtYW55IGZ1bmN0aW9ucyB0aGF0IGNh
biBmYWlsLCBidXQKPiBhcmUgdHJlYXRlZCBhcyBpZiB0aGV5IHNvcnQtb2YtbW9zdGx5LXdvdWxk
LW5ldmVyLWZhaWwsIGluIHRoZSBob3BlcyBvZgo+IHVzaW5nIHRoZSByZXR1cm4gdmFsdWUgZGly
ZWN0bHkgZm9yIGNvdW50aW5nIGFuZCBzdWNoLiBUaGlzIGlzIGJhZGx5Cj4gbWlzdGFrZW4sIGFu
ZCBpdCBsZWFkcyBkZXZlbG9wZXJzIHRvIHRyeSB0byBhdm9pZCByZXR1cm5pbmcgLUVOT01FTQo+
ICh3aGljaCBpcyB3aGF0IHdlIG5lZWQgaGVyZSkuCj4KPiBSZWFsbHksIHRoZXNlIGZ1bmN0aW9u
cyBzaG91bGQgYWxsIGJlIGRvaW5nICIwIGZvciBzdWNjZXNzLCAtRVJSTk8gZm9yCj4gZmFpbHVy
ZSwgYW5kIHBhc3Mgb3RoZXIgdmFsdWVzLCBpbmNsdWRpbmcgcmVzdWx0cywgaW4gdGhlIGFyZyBs
aXN0Ii4KPgpXRk0hCgo+Cj4+ICvCoMKgwqAgc2VxX2J1Zl9pbml0KCZhY3NfbGlzdCwga21hbGxv
YyhQQUdFX1NJWkUsIGdmcF9tYXNrKSwgUEFHRV9TSVpFKTsKPj4gwqAgwqDCoMKgwqDCoCByZXQg
PSB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2UocHJvdmlkZXIsIGNsaWVudCwgZGlzdCwgJmFjc19y
ZWRpcmVjdHMsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAmYWNzX2xpc3QpOwo+PiDCoMKgwqDCoMKgIGlmIChhY3NfcmVkaXJlY3RzKSB7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBwY2lfd2FybihjbGllbnQsICJBQ1MgcmVkaXJlY3QgaXMgc2V0IGJl
dHdlZW4gdGhlIGNsaWVudCBhbmQgcHJvdmlkZXIgKCVzKVxuIiwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwY2lfbmFtZShwcm92aWRlcikpOwo+PiAtwqDCoMKgwqDCoMKgwqAgLyog
RHJvcCBmaW5hbCBzZW1pY29sb24gKi8KPj4gLcKgwqDCoMKgwqDCoMKgIGFjc19saXN0LmJ1ZmZl
clthY3NfbGlzdC5sZW4tMV0gPSAwOwo+PiAtwqDCoMKgwqDCoMKgwqAgcGNpX3dhcm4oY2xpZW50
LCAidG8gZGlzYWJsZSBBQ1MgcmVkaXJlY3QgZm9yIHRoaXMgcGF0aCwgYWRkIHRoZSBrZXJuZWwg
cGFyYW1ldGVyOiBwY2k9ZGlzYWJsZV9hY3NfcmVkaXI9JXNcbiIsCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYWNzX2xpc3QuYnVmZmVyKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGFjc19saXN0LmJ1ZmZlcikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBEcm9wIGZp
bmFsIHNlbWljb2xvbiAqLwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhY3NfbGlzdC5idWZm
ZXJbYWNzX2xpc3QubGVuIC0gMV0gPSAwOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lf
d2FybihjbGllbnQsICJ0byBkaXNhYmxlIEFDUyByZWRpcmVjdCBmb3IgdGhpcyBwYXRoLCBhZGQg
dGhlIGtlcm5lbCBwYXJhbWV0ZXI6IHBjaT1kaXNhYmxlX2Fjc19yZWRpcj0lc1xuIiwKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjc19saXN0LmJ1ZmZlcik7Cj4+ICvCoMKg
wqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGlmIChyZXQgPT0g
UENJX1AyUERNQV9NQVBfTk9UX1NVUFBPUlRFRCkgewo+PiBAQCAtNTY2LDcgKzU2Nyw3IEBAIGlu
dCBwY2lfcDJwZG1hX2Rpc3RhbmNlX21hbnkoc3RydWN0IHBjaV9kZXYgKnByb3ZpZGVyLCBzdHJ1
Y3QgZGV2aWNlICoqY2xpZW50cywKPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2ZXJib3Nl
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB1cHN0cmVhbV9icmlkZ2VfZGlz
dGFuY2Vfd2Fybihwcm92aWRlciwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHBjaV9jbGllbnQsICZkaXN0YW5jZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwY2lfY2xpZW50LCAmZGlzdGFuY2UsIEdGUF9LRVJORUwpOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQg
PSB1cHN0cmVhbV9icmlkZ2VfZGlzdGFuY2UocHJvdmlkZXIsIHBjaV9jbGllbnQsCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJmRpc3RhbmNlLCBOVUxMLCBOVUxMKTsKPj4KPgo+IHRoYW5rcywKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
