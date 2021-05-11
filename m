Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F3DC43460
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D0461936
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D0461936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D2674011A;
	Tue, 11 May 2021 16:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXWBH7dXpzRV; Tue, 11 May 2021 16:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64DE24028B;
	Tue, 11 May 2021 16:06:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 417A5C000E;
	Tue, 11 May 2021 16:06:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4F6FC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3BFB83CB3
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u_18BXAcU9hW for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C61B083D09
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EwSkK3tCLzSwRdZ/4L1eSG5xJr+ckvT0VIiRU+l0cU=;
 b=e8PTsvlhbwTxZs7UM5Ltdp62VT6HHu4mim038wzNA0tapyfjpWR2MBkoM+8NW9c/vY8q3H
 zKfpTOfFG20GGFAHWBNJycwDHNk4WknSYo4aN3gcw6bolZuFbee0cOR6hhpfMkkc26eZwR
 niH97ZnqxbEHu/+kXpDcX7lUnnaXG8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-FaCNBf4dPAaCfsJb1OSVVQ-1; Tue, 11 May 2021 12:05:57 -0400
X-MC-Unique: FaCNBf4dPAaCfsJb1OSVVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92A21854E27;
 Tue, 11 May 2021 16:05:52 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 717785D9F2;
 Tue, 11 May 2021 16:05:50 +0000 (UTC)
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
To: John Hubbard <jhubbard@nvidia.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <87a2b8e9-f0ef-ec23-8427-3022a86b0ec5@redhat.com>
Date: Tue, 11 May 2021 12:05:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
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

T24gNS8yLzIxIDM6NTggUE0sIEpvaG4gSHViYmFyZCB3cm90ZToKPiBPbiA0LzgvMjEgMTA6MDEg
QU0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPj4gQXR0ZW1wdCB0byBmaW5kIHRoZSBtYXBwaW5n
IHR5cGUgZm9yIFAyUERNQSBwYWdlcyBvbiB0aGUgZmlyc3QKPj4gRE1BIG1hcCBhdHRlbXB0IGlm
IGl0IGhhcyBub3QgYmVlbiBkb25lIGFoZWFkIG9mIHRpbWUuCj4+Cj4+IFByZXZpb3VzbHksIHRo
ZSBtYXBwaW5nIHR5cGUgd2FzIGV4cGVjdGVkIHRvIGJlIGNhbGN1bGF0ZWQgYWhlYWQgb2YKPj4g
dGltZSwgYnV0IGlmIHBhZ2VzIGFyZSB0byBjb21lIGZyb20gdXNlcnNwYWNlIHRoZW4gdGhlcmUn
cyBubwo+PiB3YXkgdG8gZW5zdXJlIHRoZSBwYXRoIHdhcyBjaGVja2VkIGFoZWFkIG9mIHRpbWUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5nQGRlbHRhdGVlLmNv
bT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvcGNpL3AycGRtYS5jIHwgMTIgKysrKysrKysrLS0tCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wMnBkbWEuYyBiL2RyaXZlcnMvcGNpL3AycGRtYS5j
Cj4+IGluZGV4IDQ3M2EwODk0MGZiYy4uMjU3NGEwNjJhMjU1IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL3BjaS9wMnBkbWEuYwo+PiArKysgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+PiBAQCAtODI1
LDExICs4MjUsMTggQEAgRVhQT1JUX1NZTUJPTF9HUEwocGNpX3AycG1lbV9wdWJsaXNoKTsKPj4g
wqAgc3RhdGljIGVudW0gcGNpX3AycGRtYV9tYXBfdHlwZSBwY2lfcDJwZG1hX21hcF90eXBlKHN0
cnVjdCBwY2lfZGV2ICpwcm92aWRlciwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqY2xpZW50KQo+PiDC
oCB7Cj4+ICvCoMKgwqAgZW51bSBwY2lfcDJwZG1hX21hcF90eXBlIHJldDsKPj4gKwo+PiDCoMKg
wqDCoMKgIGlmICghcHJvdmlkZXItPnAycGRtYSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBQQ0lfUDJQRE1BX01BUF9OT1RfU1VQUE9SVEVEOwo+PiDCoCAtwqDCoMKgIHJldHVybiB4YV90
b192YWx1ZSh4YV9sb2FkKCZwcm92aWRlci0+cDJwZG1hLT5tYXBfdHlwZXMsCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFwX3R5cGVzX2lkeChjbGllbnQpKSk7Cj4+
ICvCoMKgwqAgcmV0ID0geGFfdG9fdmFsdWUoeGFfbG9hZCgmcHJvdmlkZXItPnAycGRtYS0+bWFw
X3R5cGVzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfdHlwZXNf
aWR4KGNsaWVudCkpKTsKPj4gK8KgwqDCoCBpZiAocmV0ICE9IFBDSV9QMlBETUFfTUFQX1VOS05P
V04pCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiArCj4+ICvCoMKgwqAgcmV0dXJu
IHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKHByb3ZpZGVyLCBjbGllbnQsIE5VTEwsCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FU
T01JQyk7Cj4KPiBSZXR1cm5pbmcgYSAiYnJpZGdlIGRpc3RhbmNlIiBmcm9tIGEgImdldCBtYXAg
dHlwZSIgcm91dGluZSBpcyBqYXJyaW5nLAo+IGFuZCBJIHRoaW5rIGl0IGlzIGJlY2F1c2Ugb2Yg
YSBwcmUtZXhpc3RpbmcgcHJvYmxlbTogdGhlIGFib3ZlIGZ1bmN0aW9uCj4gaXMgc2V2ZXJlbHkg
bWlzbmFtZWQuIExldCdzIHRyeSByZW5hbWluZyBpdCAoYW5kIHRoZSBvdGhlciBvbmUpIHRvCj4g
YXBwcm94aW1hdGVseToKPgo+IMKgwqDCoCB1cHN0cmVhbV9icmlkZ2VfbWFwX3R5cGVfd2Fybigp
Cj4gwqDCoMKgIHVwc3RyZWFtX2JyaWRnZV9tYXBfdHlwZSgpCj4KPiAuLi5hbmQgdGhhdCBzaG91
bGQgZml4IHRoYXQuIFdlbGwsIHRoYXQsIHBsdXMgdHdlYWtpbmcgdGhlIGtlcm5lbCBkb2MKPiBj
b21tZW50cywgd2hpY2ggYXJlIGFsc28gY29uZnVzZWQuIEkgdGhpbmsgc29tZW9uZSBzdGFydGVk
IG9mZiB0aGlua2luZwo+IGFib3V0IGRpc3RhbmNlcyB0aHJvdWdoIFBDSWUsIGJ1dCBpbiB0aGUg
ZW5kLCB0aGUgcm91dGluZSBib2lscyBkb3duIHRvCj4ganVzdCBhIGZldyBzaXR1YXRpb25zIHRo
YXQgYXJlIG5vdCBkaXN0YW5jZXMgYXQgYWxsLgo+CisxLiBkaWRuJ3QgbGlrZSB0aGUgJ2Rpc3Rh
bmNlJyBjaGVja8KgIGZvciBhICdjb25uZWN0aW9uIGNoZWNrIiBpbiB0aGUgYmVnaW5uaW5nLCBh
bmQgbG9va3MgbGlrZSB0aGlzIGlzIHRoZSB0aW1lIHRvIGNsZWFuIGl0IG91dC4KOikKCj4gQWxz
bywgdGhlIGFib3ZlIHdpbGwgcmVhZCBhIGxpdHRsZSBiZXR0ZXIgaWYgaXQgaXMgd3JpdHRlbiBs
aWtlIHRoaXM6Cj4KPiDCoMKgwqDCoHJldCA9IHhhX3RvX3ZhbHVlKHhhX2xvYWQoJnByb3ZpZGVy
LT5wMnBkbWEtPm1hcF90eXBlcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1hcF90eXBlc19pZHgoY2xpZW50KSkpOwo+Cj4gwqDCoMKgwqBpZiAocmV0ID09IFBDSV9QMlBE
TUFfTUFQX1VOS05PV04pCj4gwqDCoMKgwqDCoMKgwqAgcmV0ID0gdXBzdHJlYW1fYnJpZGdlX21h
cF90eXBlX3dhcm4ocHJvdmlkZXIsIGNsaWVudCwgTlVMTCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0FUT01JQyk7Cj4KPiDCoMKg
wqDCoHJldHVybiByZXQ7Cj4KPgo+PiDCoCB9Cj4+IMKgIMKgIHN0YXRpYyBpbnQgX19wY2lfcDJw
ZG1hX21hcF9zZyhzdHJ1Y3QgcGNpX3AycGRtYV9wYWdlbWFwICpwMnBfcGdtYXAsCj4+IEBAIC04
NzcsNyArODg0LDYgQEAgaW50IHBjaV9wMnBkbWFfbWFwX3NnX2F0dHJzKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICpzZywKPj4gwqDCoMKgwqDCoCBjYXNlIFBDSV9QMlBE
TUFfTUFQX0JVU19BRERSOgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fcGNpX3AycGRt
YV9tYXBfc2cocDJwX3BnbWFwLCBkZXYsIHNnLCBuZW50cyk7Cj4+IMKgwqDCoMKgwqAgZGVmYXVs
dDoKPj4gLcKgwqDCoMKgwqDCoMKgIFdBUk5fT05fT05DRSgxKTsKPgo+IFdoeT8gT3IgYXQgbGVh
c3QsIHdoeSwgaW4gdGhpcyBwYXRjaD8gSXQgbG9va3MgbGlrZSBhbiBhY2NpZGVudGFsCj4gbGVm
dG92ZXIgZnJvbSBzb21ldGhpbmcsIHNlZWluZyBhcyBob3cgaXQgaXMgbm90IGRpcmVjdGx5IHJl
bGF0ZWQgdG8gdGhlCj4gcGF0Y2gsIGFuZCBpcyBub3QgbWVudGlvbmVkIGF0IGFsbC4KPgo+Cj4g
dGhhbmtzLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
