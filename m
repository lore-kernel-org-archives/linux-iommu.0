Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26904C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:02:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A9964DBA
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A9964DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C0216F677
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:02:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMkRsY74kxNQ for <iommu@archiver.kernel.org>;
	Fri, 12 Feb 2021 07:02:43 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id AD5636F681; Fri, 12 Feb 2021 07:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9C026F606;
	Fri, 12 Feb 2021 07:02:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8316DC0174;
	Fri, 12 Feb 2021 07:02:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86274C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A8A487488
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:02:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdVEWAPGYe56 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 07:02:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B12B8748B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:02:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D507113E;
 Thu, 11 Feb 2021 23:02:32 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313123F73D;
 Thu, 11 Feb 2021 23:02:27 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org, will@kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
Message-ID: <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
Date: Fri, 12 Feb 2021 12:32:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
Content-Language: en-US
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Ck9uIDIvMTEvMjEgMjowNyBQTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMTEuMDIu
MjEgMDc6MjIsIEFuc2h1bWFuIEtoYW5kdWFsIHdyb3RlOgo+PiBUaGUgZm9sbG93aW5nIHdhcm5p
bmcgZ2V0cyB0cmlnZ2VyZWQgd2hpbGUgdHJ5aW5nIHRvIGJvb3QgYSA2NEsgcGFnZSBzaXplCj4+
IHdpdGhvdXQgVEhQIGNvbmZpZyBrZXJuZWwgb24gYXJtNjQgcGxhdGZvcm0uCj4+Cj4+IFdBUk5J
Tkc6IENQVTogNSBQSUQ6IDEyNCBhdCBtbS92bXN0YXQuYzoxMDgwIF9fZnJhZ21lbnRhdGlvbl9p
bmRleCsweGE0LzB4YzAKPj4gTW9kdWxlcyBsaW5rZWQgaW46Cj4+IENQVTogNSBQSUQ6IDEyNCBD
b21tOiBrc3dhcGQwIE5vdCB0YWludGVkIDUuMTEuMC1yYzYtMDAwMDQtZ2EwZWE3ZDYyMDAyICMx
NTkKPj4gSGFyZHdhcmUgbmFtZTogbGludXgsZHVtbXktdmlydCAoRFQpCj4+IFvCoMKgwqAgOC44
MTA2NzNdIHBzdGF0ZTogMjA0MDAwMDUgKG56Q3YgZGFpZiArUEFOIC1VQU8gLVRDTyBCVFlQRT0t
LSkKPj4gW8KgwqDCoCA4LjgxMTczMl0gcGMgOiBfX2ZyYWdtZW50YXRpb25faW5kZXgrMHhhNC8w
eGMwCj4+IFvCoMKgwqAgOC44MTI1NTVdIGxyIDogZnJhZ21lbnRhdGlvbl9pbmRleCsweGY4LzB4
MTM4Cj4+IFvCoMKgwqAgOC44MTMzNjBdIHNwIDogZmZmZjAwMDA4NjQwNzliMAo+PiBbwqDCoMKg
IDguODEzOTU4XSB4Mjk6IGZmZmYwMDAwODY0MDc5YjAgeDI4OiAwMDAwMDAwMDAwMDAwMzcyCj4+
IFvCoMKgwqAgOC44MTQ5MDFdIHgyNzogMDAwMDAwMDAwMDAwNzY4MiB4MjY6IGZmZmY4MDAwMTM1
YjM5NDgKPj4gW8KgwqDCoCA4LjgxNTg0N10geDI1OiAxZmZmZTAwMDEwYzgwZjQ4IHgyNDogMDAw
MDAwMDAwMDAwMDAwMAo+PiBbwqDCoMKgIDguODE2ODA1XSB4MjM6IDAwMDAwMDAwMDAwMDAwMDAg
eDIyOiAwMDAwMDAwMDAwMDAwMDBkCj4+IFvCoMKgwqAgOC44MTc3NjRdIHgyMTogMDAwMDAwMDAw
MDAwMDAzMCB4MjA6IGZmZmYwMDA1ZmZjYjRkNTgKPj4gW8KgwqDCoCA4LjgxODcxMl0geDE5OiAw
MDAwMDAwMDAwMDAwMDBiIHgxODogMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqDCoMKgIDguODE5NjU2
XSB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiAwMDAwMDAwMDAwMDAwMDAwCj4+IFvCoMKgwqAg
OC44MjA2MTNdIHgxNTogMDAwMDAwMDAwMDAwMDAwMCB4MTQ6IGZmZmY4MDAwMTE0YzYyNTgKPj4g
W8KgwqDCoCA4LjgyMTU2MF0geDEzOiBmZmZmNjAwMGJmZjk2OWJhIHgxMjogMWZmZmUwMDBiZmY5
NjliOQo+PiBbwqDCoMKgIDguODIyNTE0XSB4MTE6IDFmZmZlMDAwYmZmOTY5YjkgeDEwOiBmZmZm
NjAwMGJmZjk2OWI5Cj4+IFvCoMKgwqAgOC44MjM0NjFdIHg5IDogZGZmZjgwMDAwMDAwMDAwMCB4
OCA6IGZmZmYwMDA1ZmZjYjRkY2YKPj4gW8KgwqDCoCA4LjgyNDQxNV0geDcgOiAwMDAwMDAwMDAw
MDAwMDAxIHg2IDogMDAwMDAwMDA0MWI1OGFiMwo+PiBbwqDCoMKgIDguODI1MzU5XSB4NSA6IGZm
ZmY2MDAwMTBjODBmNDggeDQgOiBkZmZmODAwMDAwMDAwMDAwCj4+IFvCoMKgwqAgOC44MjYzMTNd
IHgzIDogZmZmZjgwMDAxMDJiZTY3MCB4MiA6IDAwMDAwMDAwMDAwMDAwMDcKPj4gW8KgwqDCoCA4
LjgyNzI1OV0geDEgOiBmZmZmMDAwMDg2NDA3YTYwIHgwIDogMDAwMDAwMDAwMDAwMDAwZAo+PiBb
wqDCoMKgIDguODI4MjE4XSBDYWxsIHRyYWNlOgo+PiBbwqDCoMKgIDguODI4NjY3XcKgIF9fZnJh
Z21lbnRhdGlvbl9pbmRleCsweGE0LzB4YzAKPj4gW8KgwqDCoCA4LjgyOTQzNl3CoCBmcmFnbWVu
dGF0aW9uX2luZGV4KzB4ZjgvMHgxMzgKPj4gW8KgwqDCoCA4LjgzMDE5NF3CoCBjb21wYWN0aW9u
X3N1aXRhYmxlKzB4OTgvMHhiOAo+PiBbwqDCoMKgIDguODMwOTM0XcKgIHdha2V1cF9rY29tcGFj
dGQrMHhkYy8weDEyOAo+PiBbwqDCoMKgIDguODMxNjQwXcKgIGJhbGFuY2VfcGdkYXQrMHg3MWMv
MHg3YTAKPj4gW8KgwqDCoCA4LjgzMjMyN13CoCBrc3dhcGQrMHgzMWMvMHg1MjAKPj4gW8KgwqDC
oCA4LjgzMjkwMl3CoCBrdGhyZWFkKzB4MjI0LzB4MjMwCj4+IFvCoMKgwqAgOC44MzM0OTFdwqAg
cmV0X2Zyb21fZm9yaysweDEwLzB4MzAKPj4gW8KgwqDCoCA4LjgzNDE1MF0gLS0tWyBlbmQgdHJh
Y2UgNDcyODM2Zjc5YzE1NTE2YiBdLS0tCj4+Cj4+IFRoaXMgd2FybmluZyBjb21lcyBmcm9tIF9f
ZnJhZ21lbnRhdGlvbl9pbmRleCgpIHdoZW4gdGhlIHJlcXVlc3RlZCBvcmRlcgo+PiBpcyBncmVh
dGVyIHRoYW4gTUFYX09SREVSLgo+Pgo+PiBzdGF0aWMgaW50IF9fZnJhZ21lbnRhdGlvbl9pbmRl
eCh1bnNpZ25lZCBpbnQgb3JkZXIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBjb250aWdfcGFnZV9pbmZvICppbmZvKQo+PiB7Cj4+IMKgwqDCoMKgwqDCoMKgwqAg
dW5zaWduZWQgbG9uZyByZXF1ZXN0ZWQgPSAxVUwgPDwgb3JkZXI7Cj4+Cj4+IMKgwqDCoMKgwqDC
oMKgwqAgaWYgKFdBUk5fT05fT05DRShvcmRlciA+PSBNQVhfT1JERVIpKSA8PT09PT0gVHJpZ2dl
cmVkIGhlcmUKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+
Cj4+IERpZ2dpbmcgaXQgZnVydGhlciByZXZlYWxzIHRoYXQgcGFnZWJsb2NrX29yZGVyIGhhcyBi
ZWVuIGFzc2lnbmVkIGEgdmFsdWUKPj4gd2hpY2ggaXMgZ3JlYXRlciB0aGFuIE1BWF9PUkRFUiBm
YWlsaW5nIHRoZSBhYm92ZSBjaGVjay4gQnV0IHdoeSB0aGlzCj4+IGhhcHBlbmVkID8gQmVjYXVz
ZSBIVUdFVExCX1BBR0VfT1JERVIgZm9yIHRoZSBnaXZlbiBjb25maWcgb24gYXJtNjQgaXMKPj4g
Z3JlYXRlciB0aGFuIE1BWF9PUkRFUi4KPj4KPj4gVGhlIHNvbHV0aW9uIGludm9sdmVzIGVuYWJs
aW5nIEhVR0VUTEJfUEFHRV9TSVpFX1ZBUklBQkxFIHdoaWNoIHdvdWxkIG1ha2UKPj4gcGFnZWJs
b2NrX29yZGVyIGEgdmFyaWFibGUgaW5zdGVhZCBvZiBjb25zdGFudCBIVUdFVExCX1BBR0VfT1JE
RVIuIEJ1dCB0aGF0Cj4+IGNoYW5nZSBhbG9uZSBhbHNvIGRpZCBub3QgcmVhbGx5IHdvcmsgYXMg
cGFnZWJsb2NrX29yZGVyIHN0aWxsIGdvdCBhc3NpZ25lZAo+PiBhcyBIVUdFVExCX1BBR0VfT1JE
RVIgaW4gc2V0X3BhZ2VibG9ja19vcmRlcigpLiBIVUdFVExCX1BBR0VfT1JERVIgbmVlZHMgdG8K
Pj4gYmUgbGVzcyB0aGFuIE1BWF9PUkRFUiBmb3IgaXRzIGFwcHJvcHJpYXRlbmVzcyBhcyBwYWdl
YmxvY2tfb3JkZXIgb3RoZXJ3aXNlCj4+IGp1c3QgZmFsbGJhY2sgdG8gTUFYX09SREVSIC0gMSBh
cyBiZWZvcmUuIFdoaWxlIGhlcmUgaXQgYWxzbyBmaXhlcyBhIGJ1aWxkCj4+IHByb2JsZW0gdmlh
IHR5cGUgY2FzdGluZyBNQVhfT1JERVIgaW4gcm1lbV9jbWFfc2V0dXAoKS4KPiAKPiBJJ20gd29u
ZGVyaW5nLCBpcyB0aGVyZSBhbnkgcmVhbCB2YWx1ZSBpbiBhbGxvd2luZyBGT1JDRV9NQVhfWk9O
RU9SREVSIHRvIGJlICIxMSIgd2l0aCBBUk02NF82NEtfUEFHRVMvQVJNNjRfMTZLX1BBR0VTPwoK
TUFYX09SREVSIHNob3VsZCBiZSBhcyBoaWdoIGFzIHdvdWxkIGJlIHJlcXVpcmVkIGZvciB0aGUg
Y3VycmVudCBjb25maWcuClVubGVzcyBUSFAgaXMgZW5hYmxlZCwgdGhlcmUgaXMgbm8gbmVlZCBm
b3IgaXQgdG8gYmUgYW55IGhpZ2hlciB0aGFuIDExLgpCdXQgSSBtaWdodCBiZSBtaXNzaW5nIGhp
c3RvcmljYWwgcmVhc29ucyBhcm91bmQgdGhpcyBhcyB3ZWxsLiBQcm9iYWJseQpvdGhlcnMgZnJv
bSBhcm02NCBjb3VsZCBoZWxwIGhlcmUuCgo+IAo+IE1lYW5pbmc6IGFyZSB0aGVyZSBhbnkgcmVh
bCB1c2UgY2FzZXMgdGhhdCBhY3R1YWxseSBidWlsZCBhIGtlcm5lbCB3aXRob3V0IFRSQU5TUEFS
RU5UX0hVR0VQQUdFIGFuZCB3aXRoIEFSTTY0XzY0S19QQUdFUy9BUk02NF8xNktfUEFHRVM/CgpU
SFAgaXMgYWx3YXlzIG9wdGlvbmFsLiBCZXNpZGVzIGtlcm5lbCBidWlsZHMgd2l0aG91dCBUSFAg
c2hvdWxkIGFsd2F5cwpiZSBzdXBwb3J0ZWQuIEFzc3VtaW5nIHRoYXQgYWxsIGJ1aWxkcyB3aWxs
IGhhdmUgVEhQIGVuYWJsZWQsIG1pZ2h0IG5vdApiZSBhY2N1cmF0ZS4KCj4gCj4gQXMgYnVpbGRz
IGFyZSBlc3NlbnRpYWxseSBicm9rZW4sIEkgYXNzdW1lIHRoaXMgaXMgbm90IHRoYXQgcmVsZXZh
bnQ/IE9yIGhvdyBsb25nIGhhcyBpdCBiZWVuIGJyb2tlbj8KCkdpdCBibGFtZSBzaG93cyB0aGF0
IGl0J3MgYmVlbiB0aGVyZSBmb3Igc29tZSB0aW1lIG5vdy4gQnV0IGhvdyBkb2VzCnRoYXQgbWFr
ZSB0aGlzIGlycmVsZXZhbnQgPyBBIHByb2JsZW0gc2hvdWxkIGJlIGZpeGVkIG5vbmV0aGVsZXNz
LgoKPiAKPiBJdCBtaWdodCBiZSBlYXNpZXIgdG8ganVzdCBkcm9wIHRoZSAiVFJBTlNQQVJFTlRf
SFVHRVBBR0UiIHBhcnQgZnJvbSB0aGUgRk9SQ0VfTUFYX1pPTkVPUkRFUiBjb25maWcuCj4gCgpO
b3Qgc3VyZSBpZiBpdCB3b3VsZCBiZSBhIGdvb2QgaWRlYSB0byB1bm5lY2Vzc2FyaWx5IGhhdmUg
bGFyZ2VyIE1BWF9PUkRFUgp2YWx1ZSBmb3IgYSBnaXZlbiBjb25maWcuIEJ1dCBJIG1pZ2h0IGJl
IG1pc3Npbmcgb3RoZXIgY29udGV4dHMgaGVyZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
