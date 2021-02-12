Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F25C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 09:39:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A7D64E35
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 09:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A7D64E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFCE46E3B4
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 09:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id STQ14mLQSLvL for <iommu@archiver.kernel.org>;
	Fri, 12 Feb 2021 09:39:56 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 550B06F596; Fri, 12 Feb 2021 09:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CE416009C;
	Fri, 12 Feb 2021 09:39:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E72DC0891;
	Fri, 12 Feb 2021 09:39:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 963FEC013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 853F985608
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZnB1c3-sJM8 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4C6D685540
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613122790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJIh+57vZZX62sUHqf9Qg0OO0KLGj7Jhm7EDFFjgYrE=;
 b=bxSWt59IXe7Ph68jERmrp8ud+1hNqgsKdIFfEMhkrxDMjiOgbS4hOg4JEUdHM9yxleZSY+
 0esU68H67mH2u8XubGEln94mzlDqvlxpEA94VJakwlZq/yzphj1tg3LWmhk9tiqJ9FKLoh
 c4UjjRuOtyfyrjgEnWpTLly7X4AcdrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-s08ifoYOOVywTnddxRfoeQ-1; Fri, 12 Feb 2021 04:39:45 -0500
X-MC-Unique: s08ifoYOOVywTnddxRfoeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185691936B66;
 Fri, 12 Feb 2021 09:39:44 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 298E65D74A;
 Fri, 12 Feb 2021 09:39:41 +0000 (UTC)
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org, will@kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
 <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
Message-ID: <cb92e4a0-47fc-f461-3189-a99142bbed4c@redhat.com>
Date: Fri, 12 Feb 2021 10:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

T24gMTIuMDIuMjEgMDg6MDIsIEFuc2h1bWFuIEtoYW5kdWFsIHdyb3RlOgo+IAo+IE9uIDIvMTEv
MjEgMjowNyBQTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4+IE9uIDExLjAyLjIxIDA3OjIy
LCBBbnNodW1hbiBLaGFuZHVhbCB3cm90ZToKPj4+IFRoZSBmb2xsb3dpbmcgd2FybmluZyBnZXRz
IHRyaWdnZXJlZCB3aGlsZSB0cnlpbmcgdG8gYm9vdCBhIDY0SyBwYWdlIHNpemUKPj4+IHdpdGhv
dXQgVEhQIGNvbmZpZyBrZXJuZWwgb24gYXJtNjQgcGxhdGZvcm0uCj4+Pgo+Pj4gV0FSTklORzog
Q1BVOiA1IFBJRDogMTI0IGF0IG1tL3Ztc3RhdC5jOjEwODAgX19mcmFnbWVudGF0aW9uX2luZGV4
KzB4YTQvMHhjMAo+Pj4gTW9kdWxlcyBsaW5rZWQgaW46Cj4+PiBDUFU6IDUgUElEOiAxMjQgQ29t
bToga3N3YXBkMCBOb3QgdGFpbnRlZCA1LjExLjAtcmM2LTAwMDA0LWdhMGVhN2Q2MjAwMiAjMTU5
Cj4+PiBIYXJkd2FyZSBuYW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkKPj4+IFvCoMKgwqAgOC44
MTA2NzNdIHBzdGF0ZTogMjA0MDAwMDUgKG56Q3YgZGFpZiArUEFOIC1VQU8gLVRDTyBCVFlQRT0t
LSkKPj4+IFvCoMKgwqAgOC44MTE3MzJdIHBjIDogX19mcmFnbWVudGF0aW9uX2luZGV4KzB4YTQv
MHhjMAo+Pj4gW8KgwqDCoCA4LjgxMjU1NV0gbHIgOiBmcmFnbWVudGF0aW9uX2luZGV4KzB4Zjgv
MHgxMzgKPj4+IFvCoMKgwqAgOC44MTMzNjBdIHNwIDogZmZmZjAwMDA4NjQwNzliMAo+Pj4gW8Kg
wqDCoCA4LjgxMzk1OF0geDI5OiBmZmZmMDAwMDg2NDA3OWIwIHgyODogMDAwMDAwMDAwMDAwMDM3
Mgo+Pj4gW8KgwqDCoCA4LjgxNDkwMV0geDI3OiAwMDAwMDAwMDAwMDA3NjgyIHgyNjogZmZmZjgw
MDAxMzViMzk0OAo+Pj4gW8KgwqDCoCA4LjgxNTg0N10geDI1OiAxZmZmZTAwMDEwYzgwZjQ4IHgy
NDogMDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8KgwqDCoCA4LjgxNjgwNV0geDIzOiAwMDAwMDAwMDAw
MDAwMDAwIHgyMjogMDAwMDAwMDAwMDAwMDAwZAo+Pj4gW8KgwqDCoCA4LjgxNzc2NF0geDIxOiAw
MDAwMDAwMDAwMDAwMDMwIHgyMDogZmZmZjAwMDVmZmNiNGQ1OAo+Pj4gW8KgwqDCoCA4LjgxODcx
Ml0geDE5OiAwMDAwMDAwMDAwMDAwMDBiIHgxODogMDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8KgwqDC
oCA4LjgxOTY1Nl0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMAo+
Pj4gW8KgwqDCoCA4LjgyMDYxM10geDE1OiAwMDAwMDAwMDAwMDAwMDAwIHgxNDogZmZmZjgwMDAx
MTRjNjI1OAo+Pj4gW8KgwqDCoCA4LjgyMTU2MF0geDEzOiBmZmZmNjAwMGJmZjk2OWJhIHgxMjog
MWZmZmUwMDBiZmY5NjliOQo+Pj4gW8KgwqDCoCA4LjgyMjUxNF0geDExOiAxZmZmZTAwMGJmZjk2
OWI5IHgxMDogZmZmZjYwMDBiZmY5NjliOQo+Pj4gW8KgwqDCoCA4LjgyMzQ2MV0geDkgOiBkZmZm
ODAwMDAwMDAwMDAwIHg4IDogZmZmZjAwMDVmZmNiNGRjZgo+Pj4gW8KgwqDCoCA4LjgyNDQxNV0g
eDcgOiAwMDAwMDAwMDAwMDAwMDAxIHg2IDogMDAwMDAwMDA0MWI1OGFiMwo+Pj4gW8KgwqDCoCA4
LjgyNTM1OV0geDUgOiBmZmZmNjAwMDEwYzgwZjQ4IHg0IDogZGZmZjgwMDAwMDAwMDAwMAo+Pj4g
W8KgwqDCoCA4LjgyNjMxM10geDMgOiBmZmZmODAwMDEwMmJlNjcwIHgyIDogMDAwMDAwMDAwMDAw
MDAwNwo+Pj4gW8KgwqDCoCA4LjgyNzI1OV0geDEgOiBmZmZmMDAwMDg2NDA3YTYwIHgwIDogMDAw
MDAwMDAwMDAwMDAwZAo+Pj4gW8KgwqDCoCA4LjgyODIxOF0gQ2FsbCB0cmFjZToKPj4+IFvCoMKg
wqAgOC44Mjg2NjddwqAgX19mcmFnbWVudGF0aW9uX2luZGV4KzB4YTQvMHhjMAo+Pj4gW8KgwqDC
oCA4LjgyOTQzNl3CoCBmcmFnbWVudGF0aW9uX2luZGV4KzB4ZjgvMHgxMzgKPj4+IFvCoMKgwqAg
OC44MzAxOTRdwqAgY29tcGFjdGlvbl9zdWl0YWJsZSsweDk4LzB4YjgKPj4+IFvCoMKgwqAgOC44
MzA5MzRdwqAgd2FrZXVwX2tjb21wYWN0ZCsweGRjLzB4MTI4Cj4+PiBbwqDCoMKgIDguODMxNjQw
XcKgIGJhbGFuY2VfcGdkYXQrMHg3MWMvMHg3YTAKPj4+IFvCoMKgwqAgOC44MzIzMjddwqAga3N3
YXBkKzB4MzFjLzB4NTIwCj4+PiBbwqDCoMKgIDguODMyOTAyXcKgIGt0aHJlYWQrMHgyMjQvMHgy
MzAKPj4+IFvCoMKgwqAgOC44MzM0OTFdwqAgcmV0X2Zyb21fZm9yaysweDEwLzB4MzAKPj4+IFvC
oMKgwqAgOC44MzQxNTBdIC0tLVsgZW5kIHRyYWNlIDQ3MjgzNmY3OWMxNTUxNmIgXS0tLQo+Pj4K
Pj4+IFRoaXMgd2FybmluZyBjb21lcyBmcm9tIF9fZnJhZ21lbnRhdGlvbl9pbmRleCgpIHdoZW4g
dGhlIHJlcXVlc3RlZCBvcmRlcgo+Pj4gaXMgZ3JlYXRlciB0aGFuIE1BWF9PUkRFUi4KPj4+Cj4+
PiBzdGF0aWMgaW50IF9fZnJhZ21lbnRhdGlvbl9pbmRleCh1bnNpZ25lZCBpbnQgb3JkZXIsCj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNvbnRpZ19wYWdlX2lu
Zm8gKmluZm8pCj4+PiB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHJlcXVl
c3RlZCA9IDFVTCA8PCBvcmRlcjsKPj4+Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoCBpZiAoV0FSTl9P
Tl9PTkNFKG9yZGVyID49IE1BWF9PUkRFUikpIDw9PT09PSBUcmlnZ2VyZWQgaGVyZQo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4KPj4+IERpZ2dpbmcg
aXQgZnVydGhlciByZXZlYWxzIHRoYXQgcGFnZWJsb2NrX29yZGVyIGhhcyBiZWVuIGFzc2lnbmVk
IGEgdmFsdWUKPj4+IHdoaWNoIGlzIGdyZWF0ZXIgdGhhbiBNQVhfT1JERVIgZmFpbGluZyB0aGUg
YWJvdmUgY2hlY2suIEJ1dCB3aHkgdGhpcwo+Pj4gaGFwcGVuZWQgPyBCZWNhdXNlIEhVR0VUTEJf
UEFHRV9PUkRFUiBmb3IgdGhlIGdpdmVuIGNvbmZpZyBvbiBhcm02NCBpcwo+Pj4gZ3JlYXRlciB0
aGFuIE1BWF9PUkRFUi4KPj4+Cj4+PiBUaGUgc29sdXRpb24gaW52b2x2ZXMgZW5hYmxpbmcgSFVH
RVRMQl9QQUdFX1NJWkVfVkFSSUFCTEUgd2hpY2ggd291bGQgbWFrZQo+Pj4gcGFnZWJsb2NrX29y
ZGVyIGEgdmFyaWFibGUgaW5zdGVhZCBvZiBjb25zdGFudCBIVUdFVExCX1BBR0VfT1JERVIuIEJ1
dCB0aGF0Cj4+PiBjaGFuZ2UgYWxvbmUgYWxzbyBkaWQgbm90IHJlYWxseSB3b3JrIGFzIHBhZ2Vi
bG9ja19vcmRlciBzdGlsbCBnb3QgYXNzaWduZWQKPj4+IGFzIEhVR0VUTEJfUEFHRV9PUkRFUiBp
biBzZXRfcGFnZWJsb2NrX29yZGVyKCkuIEhVR0VUTEJfUEFHRV9PUkRFUiBuZWVkcyB0bwo+Pj4g
YmUgbGVzcyB0aGFuIE1BWF9PUkRFUiBmb3IgaXRzIGFwcHJvcHJpYXRlbmVzcyBhcyBwYWdlYmxv
Y2tfb3JkZXIgb3RoZXJ3aXNlCj4+PiBqdXN0IGZhbGxiYWNrIHRvIE1BWF9PUkRFUiAtIDEgYXMg
YmVmb3JlLiBXaGlsZSBoZXJlIGl0IGFsc28gZml4ZXMgYSBidWlsZAo+Pj4gcHJvYmxlbSB2aWEg
dHlwZSBjYXN0aW5nIE1BWF9PUkRFUiBpbiBybWVtX2NtYV9zZXR1cCgpLgo+Pgo+PiBJJ20gd29u
ZGVyaW5nLCBpcyB0aGVyZSBhbnkgcmVhbCB2YWx1ZSBpbiBhbGxvd2luZyBGT1JDRV9NQVhfWk9O
RU9SREVSIHRvIGJlICIxMSIgd2l0aCBBUk02NF82NEtfUEFHRVMvQVJNNjRfMTZLX1BBR0VTPwo+
IAo+IE1BWF9PUkRFUiBzaG91bGQgYmUgYXMgaGlnaCBhcyB3b3VsZCBiZSByZXF1aXJlZCBmb3Ig
dGhlIGN1cnJlbnQgY29uZmlnLgo+IFVubGVzcyBUSFAgaXMgZW5hYmxlZCwgdGhlcmUgaXMgbm8g
bmVlZCBmb3IgaXQgdG8gYmUgYW55IGhpZ2hlciB0aGFuIDExLgo+IEJ1dCBJIG1pZ2h0IGJlIG1p
c3NpbmcgaGlzdG9yaWNhbCByZWFzb25zIGFyb3VuZCB0aGlzIGFzIHdlbGwuIFByb2JhYmx5Cj4g
b3RoZXJzIGZyb20gYXJtNjQgY291bGQgaGVscCBoZXJlLgoKVGhlb3JldGljYWxseSB5ZXMsIHBy
YWN0aWNhbGx5IG5vLiBJZiBub2JvZHkgY2FyZXMgYWJvdXQgYSAKY29uZmlndXJhdGlvbiwgbm8g
bmVlZCB0byBtYWtlIHRoZSBjb2RlIG1vcmUgY29tcGxpY2F0ZWQgZm9yIHRoYXQgCmNvbmZpZ3Vy
YXRpb24uCgo+IAo+Pgo+PiBNZWFuaW5nOiBhcmUgdGhlcmUgYW55IHJlYWwgdXNlIGNhc2VzIHRo
YXQgYWN0dWFsbHkgYnVpbGQgYSBrZXJuZWwgd2l0aG91dCBUUkFOU1BBUkVOVF9IVUdFUEFHRSBh
bmQgd2l0aCBBUk02NF82NEtfUEFHRVMvQVJNNjRfMTZLX1BBR0VTPwo+IAo+IFRIUCBpcyBhbHdh
eXMgb3B0aW9uYWwuIEJlc2lkZXMga2VybmVsIGJ1aWxkcyB3aXRob3V0IFRIUCBzaG91bGQgYWx3
YXlzCj4gYmUgc3VwcG9ydGVkLiBBc3N1bWluZyB0aGF0IGFsbCBidWlsZHMgd2lsbCBoYXZlIFRI
UCBlbmFibGVkLCBtaWdodCBub3QKPiBiZSBhY2N1cmF0ZS4KPiAKPj4KPj4gQXMgYnVpbGRzIGFy
ZSBlc3NlbnRpYWxseSBicm9rZW4sIEkgYXNzdW1lIHRoaXMgaXMgbm90IHRoYXQgcmVsZXZhbnQ/
IE9yIGhvdyBsb25nIGhhcyBpdCBiZWVuIGJyb2tlbj8KPiAKPiBHaXQgYmxhbWUgc2hvd3MgdGhh
dCBpdCdzIGJlZW4gdGhlcmUgZm9yIHNvbWUgdGltZSBub3cuIEJ1dCBob3cgZG9lcwo+IHRoYXQg
bWFrZSB0aGlzIGlycmVsZXZhbnQgPyBBIHByb2JsZW0gc2hvdWxkIGJlIGZpeGVkIG5vbmV0aGVs
ZXNzLgoKV2hlbiBleGFjdGx5IGRpZCBJIHNheSBub3QgdG8gZml4IGl0PyBJJ20gc2F5aW5nIGlm
IG5vYm9keSB1c2VzIGl0LCB3ZSAKbWlnaHQgYmUgYWJsZSB0byBzaW1wbGlmeS4KCj4gCj4+Cj4+
IEl0IG1pZ2h0IGJlIGVhc2llciB0byBqdXN0IGRyb3AgdGhlICJUUkFOU1BBUkVOVF9IVUdFUEFH
RSIgcGFydCBmcm9tIHRoZSBGT1JDRV9NQVhfWk9ORU9SREVSIGNvbmZpZy4KPj4KPiAKPiBOb3Qg
c3VyZSBpZiBpdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byB1bm5lY2Vzc2FyaWx5IGhhdmUgbGFy
Z2VyIE1BWF9PUkRFUgo+IHZhbHVlIGZvciBhIGdpdmVuIGNvbmZpZy4gQnV0IEkgbWlnaHQgYmUg
bWlzc2luZyBvdGhlciBjb250ZXh0cyBoZXJlLgoKTXkgcG9pbnQgaXM6IGtlZXAgaXQgc2ltcGxl
IGlmIHRoZXJlIGlzIG5vIG5lZWQgdG8gbWFrZSBpdCBjb21wbGljYXRlZC4gCklmIHRoZXNlIGFy
bTY0IHZhcmlhbnRzIGFyZSB0aGUgb25seSBjYXNlcyB3aGVyZSB3ZSBydW4gaW50byB0aGF0IGlz
c3VlIAphbmQgbm9ib2R5IHVzZXMgdGhlbSAoImhhdCBpdCdzIGJlZW4gdGhlcmUgZm9yIHNvbWUg
dGltZSBub3ciKSwgd2h5IG1ha2UgCnN0dWZmIGNvbXBsaWNhdGVkPwoKVGhlIGN1cnJlbnQgY29k
ZSBzZWVtcyB0byBhc3N1bWUgdGhhdCBIVUdFVExCX1BBR0VfT1JERVIgPD0gTUFYX09SREVSLiAK
SW5zdGVhZCBvZiBjaGFuZ2luZyB0aGF0IGZvciBvcHRpbWl6aW5nIGFuIHVudXNlZCB1c2UgY2Fz
ZSAoaXQgaXMgCmJyb2tlbiksIGp1c3Qgc2ltcGxpZnkgdGhlIGFybTY0IGNvbmRpdGlvbnMuIEkn
ZCBldmVuIHNheSBhZGQgYQoKLyoKICAqIFNvbWUgY29kZSBhc3N1bWVzIHRoYXQgSFVHRVRMQl9Q
QUdFX09SREVSIDw9IE1BWF9PUkRFUi4gRm9yIG5vdywgb25seQogICogIVRSQU5TUEFSRU5UX0hV
R0VQQUdFIGNvdWxkIGxlYWQgaW4gYXJjaHMgY3JlYXRpbmcgc3VjaCBzZXR1cHMuCiAgKiBGb3Ji
aWQgaXQgZm9yIG5vdzsgYW55Ym9keSB0aGF0IGhhcyBhIHZhbGlkIHVzZSBjYXNlIGhhcyB0byBz
YW5pdGl6ZQogICogdGhlIGNvZGUuCiAgKi8KQlVJTERfQlVHX09OKEhVR0VUTEJfUEFHRV9PUkRF
UiA8PSBNQVhfT1JERVIpOwoKCkJ1dCBhZ2FpbiwgaWYgdGhlcmUgYXJlIHZhbGlkIHVzZSBjYXNl
cyB0aGVuIHN1cmUsIGxldCdzIG1ha2UgdGhlIGNvZGUgCmZ1bGx5IGNvbXBhdGlibGUgd2l0aCBI
VUdFVExCX1BBR0VfT1JERVIgPiBNQVhfT1JERVIuCgoKQlRXOiBjYW4gd2UgYmUgc3VyZSB0aGF0
IHlvdSBjYXVnaHQgYWxsIGlzc3Vlcz8gRm9yIGV4YW1wbGU6CgojZGVmaW5lIENPTVBBQ1RJT05f
SFBBR0VfT1JERVIgIEhVR0VUTEJfUEFHRV9PUkRFUgoKSSdtIG5vdCBzdXJlIGlmIGl0IHdpbGwg
d29yayBhcyBleHBlY3RlZCBpZiBIVUdFVExCX1BBR0VfT1JERVIgPiAKTUFYX09SREVSIC4uLiBm
aWxsX2NvbnRpZ19wYWdlX2luZm8oKSB3aWxsIG5ldmVyIGZpbmQgYW55IHN1aXRhYmxlIGZyZWUg
CmJsb2NrcyAuLi4KCi0tIApUaGFua3MsCgpEYXZpZCAvIGRoaWxkZW5iCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
