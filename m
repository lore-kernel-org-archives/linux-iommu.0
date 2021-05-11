Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F116C433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8122616EA
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8122616EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65C704028B;
	Tue, 11 May 2021 16:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFH5BpSVE7bq; Tue, 11 May 2021 16:06:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 326024011A;
	Tue, 11 May 2021 16:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4A4C000E;
	Tue, 11 May 2021 16:06:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E4B4C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 504E583CB3
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O1nUjwnx4Xn6 for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73D3783C9D
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UV1wByeUIYlPOcdwlcmJhFE5ghODP+1p9OllaOX3sI=;
 b=HIjXHso9SWqLbKJyfB9L2XkWQ1hUuAXClWlJXI+0rNjIYaNAhNMqGZ+JzFjVy9mmV3czc3
 oGYkDUmGerzsiwgTPwC6rNzsXdPIr9aSa9X4xHC3zF2HkctPaJj7yyr1RttkkUFG0LZwXe
 R5cwh61u7dkJQaXAqpv3k+rzjlY04+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-LePH9WAtNran78JB9Xx15w-1; Tue, 11 May 2021 12:06:25 -0400
X-MC-Unique: LePH9WAtNran78JB9Xx15w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05B91854E2A;
 Tue, 11 May 2021 16:06:19 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF4F9CA0;
 Tue, 11 May 2021 16:06:17 +0000 (UTC)
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-11-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <92704199-4cee-3811-3902-08ccf6cc1f5f@redhat.com>
Date: Tue, 11 May 2021 12:06:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-11-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
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

T24gNC84LzIxIDE6MDEgUE0sIExvZ2FuIEd1bnRob3JwZSB3cm90ZToKPiBBZGQgYSBmbGFncyBt
ZW1iZXIgdG8gdGhlIGRtYV9tYXBfb3BzIHN0cnVjdHVyZSB3aXRoIG9uZSBmbGFnIHRvCj4gaW5k
aWNhdGUgc3VwcG9ydCBmb3IgUENJIFAyUERNQS4KPgo+IEFsc28sIGFkZCBhIGhlbHBlciB0byBj
aGVjayBpZiBhIGRldmljZSBzdXBwb3J0cyBQQ0kgUDJQRE1BLgo+Cj4gU2lnbmVkLW9mZi1ieTog
TG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgo+IC0tLQo+ICAgaW5jbHVkZS9s
aW51eC9kbWEtbWFwLW9wcy5oIHwgIDMgKysrCj4gICBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5n
LmggfCAgNSArKysrKwo+ICAga2VybmVsL2RtYS9tYXBwaW5nLmMgICAgICAgIHwgMTggKysrKysr
KysrKysrKysrKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmggYi9pbmNsdWRlL2xpbnV4L2Rt
YS1tYXAtb3BzLmgKPiBpbmRleCA1MTg3MmU3MzZlN2IuLjQ4MTg5MjgyMjEwNCAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXAtb3BzLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2Rt
YS1tYXAtb3BzLmgKPiBAQCAtMTIsNiArMTIsOSBAQAo+ICAgc3RydWN0IGNtYTsKPiAgIAo+ICAg
c3RydWN0IGRtYV9tYXBfb3BzIHsKPiArCXVuc2lnbmVkIGludCBmbGFnczsKPiArI2RlZmluZSBE
TUFfRl9QQ0lfUDJQRE1BX1NVUFBPUlRFRCAgICAgKDEgPDwgMCkKPiArCkknbSBub3QgYSBmYW4g
b2YgaW4tbGluZSBkZWZpbmUnczsgaWYgd2UncmUgZ29pbmcgdG8gYWRkIGEgZmxhZ3MgZmllbGQg
dG8gdGhlIGRtYS1vcHMKLS0gYW5kIGxvZ2ljYWxseSBpdCdkIGJlIGdvb2QgdG8gaGF2ZSBwMnBk
bWEgZ28gdGhyb3VnaCB0aGUgZG1hLW9wcyBzdHJ1Y3QgLS0KdGhlbiBsZXQncyBtb3ZlIHRoaXMg
dXAgaW4gZnJvbnQgb2YgdGhlIGRtYS1vcHMgZGVzY3JpcHRpb24uCgpBbmQgbm93IHRoYXQgdGhl
IGRtYS1vcHMgc3RydWN0IGlzIGJlaW5nICdvcGVuZWQnIGZvciBwMnBkbWEsIHNob3VsZCBwMnBk
bWEgb3BzIGJlIGFkZGVkCnRvIHRoaXMgc3RydWN0LCBzbyBhbGwgdGhpcyB3b3JrIGNhbiBiZSBt
aW1pYydkL3JlZmxlY3RlZC9sZXZlcmFnZWQvcmVmYWN0b3JlZCBmb3IgQ1hMLCBHZW5aLCBldGMu
IHAycGRtYSBpbiAodGhlIG5lYXI/KSBmdXR1cmU/Cgo+ICAgCXZvaWQgKigqYWxsb2MpKHN0cnVj
dCBkZXZpY2UgKmRldiwgc2l6ZV90IHNpemUsCj4gICAJCQlkbWFfYWRkcl90ICpkbWFfaGFuZGxl
LCBnZnBfdCBnZnAsCj4gICAJCQl1bnNpZ25lZCBsb25nIGF0dHJzKTsKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5o
Cj4gaW5kZXggNTBiOGY1ODZjZjU5Li5jMzE5ODBlY2NhNjIgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9kbWEtbWFwcGluZy5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5o
Cj4gQEAgLTE0Niw2ICsxNDYsNyBAQCBpbnQgZG1hX21tYXBfYXR0cnMoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKPiAgIAkJdW5zaWduZWQgbG9uZyBhdHRy
cyk7Cj4gICBib29sIGRtYV9jYW5fbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+ICAgaW50IGRt
YV9zdXBwb3J0ZWQoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgbWFzayk7Cj4gK2Jvb2wgZG1hX3Bj
aV9wMnBkbWFfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldik7Cj4gICBpbnQgZG1hX3NldF9t
YXNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spOwo+ICAgaW50IGRtYV9zZXRfY29oZXJl
bnRfbWFzayhzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBtYXNrKTsKPiAgIHU2NCBkbWFfZ2V0X3Jl
cXVpcmVkX21hc2soc3RydWN0IGRldmljZSAqZGV2KTsKPiBAQCAtMjQ3LDYgKzI0OCwxMCBAQCBz
dGF0aWMgaW5saW5lIGludCBkbWFfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1h
c2spCj4gICB7Cj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBkbWFf
cGNpX3AycGRtYV9zdXBwb3J0ZWQoc3RydWN0IGRldmljZSAqZGV2KQo+ICt7Cj4gKwlyZXR1cm4g
MDsKPiArfQo+ICAgc3RhdGljIGlubGluZSBpbnQgZG1hX3NldF9tYXNrKHN0cnVjdCBkZXZpY2Ug
KmRldiwgdTY0IG1hc2spCj4gICB7Cj4gICAJcmV0dXJuIC1FSU87Cj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9kbWEvbWFwcGluZy5jIGIva2VybmVsL2RtYS9tYXBwaW5nLmMKPiBpbmRleCA5MjMwODlj
NDI2N2IuLmNlNDRhMGZjYzRlNSAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvZG1hL21hcHBpbmcuYwo+
ICsrKyBiL2tlcm5lbC9kbWEvbWFwcGluZy5jCj4gQEAgLTU3Myw2ICs1NzMsMjQgQEAgaW50IGRt
YV9zdXBwb3J0ZWQoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgbWFzaykKPiAgIH0KPiAgIEVYUE9S
VF9TWU1CT0woZG1hX3N1cHBvcnRlZCk7Cj4gICAKPiArYm9vbCBkbWFfcGNpX3AycGRtYV9zdXBw
b3J0ZWQoc3RydWN0IGRldmljZSAqZGV2KQo+ICt7Cj4gKwljb25zdCBzdHJ1Y3QgZG1hX21hcF9v
cHMgKm9wcyA9IGdldF9kbWFfb3BzKGRldik7Cj4gKwo+ICsJLyogaWYgb3BzIGlzIG5vdCBzZXQs
IGRtYSBkaXJlY3Qgd2lsbCBiZSB1c2VkIHdoaWNoIHN1cHBvcnRzIFAyUERNQSAqLwo+ICsJaWYg
KCFvcHMpCj4gKwkJcmV0dXJuIHRydWU7ClNvLCB0aGlzIG1lYW5zIG9uZSBjYW5ub3QgaGF2ZSBw
MnBkbWEgd2l0aCBJT01NVSdzPyAuLi4KLS0gb3IgaXMgdGhpcyAnZm9yIG5vdycgYW5kIHRoaXMg
bWF5IGNoYW5nZT/CoCBpZiBpdCBtYXkgY2hhbmdlLCBhZGQgYSBub3RlIGhlcmUuCgo+ICsKPiAr
CS8qCj4gKwkgKiBOb3RlOiBkbWFfb3BzX2J5cGFzcyBpcyBub3QgY2hlY2tlZCBoZXJlIGJlY2F1
c2UgUDJQRE1BIHNob3VsZAo+ICsJICogbm90IGJlIHVzZWQgd2l0aCBkbWEgbWFwcGluZyBvcHMg
dGhhdCBkbyBub3QgaGF2ZSBzdXBwb3J0IGV2ZW4KPiArCSAqIGlmIHRoZSBzcGVjaWZpYyBkZXZp
Y2UgaXMgYnlwYXNzaW5nIHRoZW0uCj4gKwkgKi8KPiArCj4gKwlyZXR1cm4gb3BzLT5mbGFncyAm
IERNQV9GX1BDSV9QMlBETUFfU1VQUE9SVEVEOwp0aGF0J3MgYSBib29sPwoKPiArfQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChkbWFfcGNpX3AycGRtYV9zdXBwb3J0ZWQpOwo+ICsKPiAgICNpZmRlZiBD
T05GSUdfQVJDSF9IQVNfRE1BX1NFVF9NQVNLCj4gICB2b2lkIGFyY2hfZG1hX3NldF9tYXNrKHN0
cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spOwo+ICAgI2Vsc2UKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
