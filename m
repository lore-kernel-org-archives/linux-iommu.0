Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4AEC433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 08:04:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5CF64E77
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 08:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5CF64E77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 184CE6F631
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 08:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJOyItHnrcyH for <iommu@archiver.kernel.org>;
	Thu, 11 Feb 2021 08:04:29 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 842496F5A3; Thu, 11 Feb 2021 08:04:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED4306F4F8;
	Thu, 11 Feb 2021 08:04:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB1A3C0174;
	Thu, 11 Feb 2021 08:04:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD40DC013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 08:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC0336EE12
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 08:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wJNIa3nQha1V for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 08:04:22 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id D2D786F4F9; Thu, 11 Feb 2021 08:04:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D2C86EE12
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 08:04:21 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 244AE68BFE; Thu, 11 Feb 2021 09:04:17 +0100 (CET)
Date: Thu, 11 Feb 2021 09:04:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 3/3] dma-contiguous: Type cast MAX_ORDER as unsigned int
Message-ID: <20210211080417.GC14448@lst.de>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <1613024531-19040-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1613024531-19040-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org, will@kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

T24gVGh1LCBGZWIgMTEsIDIwMjEgYXQgMTE6NTI6MTFBTSArMDUzMCwgQW5zaHVtYW4gS2hhbmR1
YWwgd3JvdGU6Cj4gVHlwZSBjYXN0IE1BWF9PUkRFUiBhcyB1bnNpZ25lZCBpbnQgdG8gZml4IHRo
ZSBmb2xsb3dpbmcgYnVpbGQgd2FybmluZy4KPiAKPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9p
bmNsdWRlL2xpbnV4L2tlcm5lbC5oOjE0LAo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1
ZGUvYXNtLWdlbmVyaWMvYnVnLmg6MjAsCj4gICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC9h
cm02NC9pbmNsdWRlL2FzbS9idWcuaDoyNiwKPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNs
dWRlL2xpbnV4L2J1Zy5oOjUsCj4gICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51
eC9tbWRlYnVnLmg6NSwKPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL2FybTY0L2luY2x1
ZGUvYXNtL21lbW9yeS5oOjE2NiwKPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL2FybTY0
L2luY2x1ZGUvYXNtL3BhZ2UuaDo0MiwKPiAgICAgICAgICAgICAgICAgIGZyb20ga2VybmVsL2Rt
YS9jb250aWd1b3VzLmM6NDY6Cj4ga2VybmVsL2RtYS9jb250aWd1b3VzLmM6IEluIGZ1bmN0aW9u
IOKAmHJtZW1fY21hX3NldHVw4oCZOgo+IC4vaW5jbHVkZS9saW51eC9taW5tYXguaDoxODoyODog
d2FybmluZzogY29tcGFyaXNvbiBvZiBkaXN0aW5jdCBwb2ludGVyCj4gdHlwZXMgbGFja3MgYSBj
YXN0Cj4gICAoISEoc2l6ZW9mKCh0eXBlb2YoeCkgKikxID09ICh0eXBlb2YoeSkgKikxKSkpCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+Cj4gLi9pbmNsdWRlL2xpbnV4L21pbm1heC5o
OjMyOjQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX3R5cGVjaGVja+KAmQo+ICAg
IChfX3R5cGVjaGVjayh4LCB5KSAmJiBfX25vX3NpZGVfZWZmZWN0cyh4LCB5KSkKPiAgICAgXn5+
fn5+fn5+fn4KPiAuL2luY2x1ZGUvbGludXgvbWlubWF4Lmg6NDI6MjQ6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyDigJhfX3NhZmVfY21w4oCZCj4gICBfX2J1aWx0aW5fY2hvb3NlX2V4cHIo
X19zYWZlX2NtcCh4LCB5KSwgXAo+ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn4K
PiAuL2luY2x1ZGUvbGludXgvbWlubWF4Lmg6NTg6MTk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBt
YWNybwo+IOKAmF9fY2FyZWZ1bF9jbXDigJkKPiAgI2RlZmluZSBtYXgoeCwgeSkgX19jYXJlZnVs
X2NtcCh4LCB5LCA+KQo+ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+Cj4ga2VybmVs
L2RtYS9jb250aWd1b3VzLmM6NDAyOjM1OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCY
bWF44oCZCj4gICBwaHlzX2FkZHJfdCBhbGlnbiA9IFBBR0VfU0laRSA8PCBtYXgoTUFYX09SREVS
IC0gMSwgcGFnZWJsb2NrX29yZGVyKTsKPiAKPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+Cj4gQ2M6IE1hcmVrIFN6eXByb3dza2kgPG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4K
PiBDYzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiBDYzogaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zwo+IFNpZ25lZC1vZmYtYnk6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBh
cm0uY29tPgo+IC0tLQo+ICBrZXJuZWwvZG1hL2NvbnRpZ3VvdXMuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9kbWEvY29udGlndW91cy5jIGIva2VybmVsL2RtYS9jb250aWd1b3VzLmMKPiBpbmRl
eCAzZDYzZDkxY2JhNWMuLjFjMjc4MjM0OWQ3MSAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvZG1hL2Nv
bnRpZ3VvdXMuYwo+ICsrKyBiL2tlcm5lbC9kbWEvY29udGlndW91cy5jCj4gQEAgLTM5OSw3ICsz
OTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlc2VydmVkX21lbV9vcHMgcm1lbV9jbWFfb3Bz
ID0gewo+ICAKPiAgc3RhdGljIGludCBfX2luaXQgcm1lbV9jbWFfc2V0dXAoc3RydWN0IHJlc2Vy
dmVkX21lbSAqcm1lbSkKPiAgewo+IC0JcGh5c19hZGRyX3QgYWxpZ24gPSBQQUdFX1NJWkUgPDwg
bWF4KE1BWF9PUkRFUiAtIDEsIHBhZ2VibG9ja19vcmRlcik7Cj4gKwlwaHlzX2FkZHJfdCBhbGln
biA9IFBBR0VfU0laRSA8PCBtYXgoKHVuc2lnbmVkIGludClNQVhfT1JERVIgLSAxLCBwYWdlYmxv
Y2tfb3JkZXIpOwoKTUFYX09SREVSIGFuZCBwYWdlYmxvY2tfb3JkZXIgc2hvdWxkIGJlIHRoZSBz
YW1lIHR5cGUuICBTbyBlaXRoZXIgZml4Ck1BWF9PUkRFUiB0byBiZSBhbiB1bnNpZ25lZCBjb25z
dGFudCwgd2hpY2ggd291bGQgYmUgZnVuZGFtZW50YWxseQp0aGUgcmlnaHQgdGhpbmcgdG8gZG8g
YnV0IG1pZ2h0IGNhdXNlIHNvbWUgZmFsbG91dCwgb3IgdHVybgpwYWdlYmxvY2tfb3JkZXIgaW50
byBhbiBpbnQsIHdoaWNoIGlzIHByb2JhYmx5IG11Y2ggZWl0aGVyIGFzIHRoZSBzdHViCmRlZmlu
ZSBvZiBpdCBhbHJlYWR5IGhhcyBhbiBpbnRlZ2VyIHR5cGUgZGVyaXZlZCBmcm9tIE1BWF9PUkRF
UiBhcyB3ZWxsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
