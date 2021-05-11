Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF5EC433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:23:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248AD613AF
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248AD613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7BF54028B;
	Tue, 11 May 2021 16:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y4kdeGZqryME; Tue, 11 May 2021 16:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEA7D4011A;
	Tue, 11 May 2021 16:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CC3C000E;
	Tue, 11 May 2021 16:23:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8D6C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D9436067A
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF43hIFjLu5Z for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:23:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB3F960668
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620750212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3M6tTHlyFNKQwbGOtrLH1dHnpAA9L/D3mvAYYkgV538=;
 b=HFdExlKg8EqxzBOOaH7hRhKKJ9DSZNzMVgfNvJS94XYqqMloJL86ko7miWWLcqJWSYch8P
 jNu+yi36iC6c9p0IC7lhnf8B16chhJ5CIeLUDVmHj+8ufmUNWWhoC3iCED13fxia6BZckc
 FEggNvQI8/8ZGxh+rnq73EG+Z3xqDws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-e2fb4B8yPWyJlQzkc_nNww-1; Tue, 11 May 2021 12:23:16 -0400
X-MC-Unique: e2fb4B8yPWyJlQzkc_nNww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687B38015D0;
 Tue, 11 May 2021 16:23:13 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 968105DEAD;
 Tue, 11 May 2021 16:23:10 +0000 (UTC)
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To: Logan Gunthorpe <logang@deltatee.com>, John Hubbard
 <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
 <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <c078b970-7531-8834-e26f-e653e7db4c20@redhat.com>
Date: Tue, 11 May 2021 12:23:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

T24gNS8xMS8yMSAxMjoxMiBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Cj4gT24gMjAyMS0w
NS0xMSAxMDowNSBhLm0uLCBEb24gRHV0aWxlIHdyb3RlOgo+PiBPbiA1LzEvMjEgMTE6NTggUE0s
IEpvaG4gSHViYmFyZCB3cm90ZToKPj4+IE9uIDQvOC8yMSAxMDowMSBBTSwgTG9nYW4gR3VudGhv
cnBlIHdyb3RlOgo+Pj4+IEluIG9yZGVyIHRvIGNhbGwgdXBzdHJlYW1fYnJpZGdlX2Rpc3RhbmNl
X3dhcm4oKSBmcm9tIGEgZG1hX21hcCBmdW5jdGlvbiwKPj4+PiBpdCBtdXN0IG5vdCBzbGVlcC4g
VGhlIG9ubHkgcmVhc29uIGl0IGRvZXMgc2xlZXAgaXMgdG8gYWxsb2NhdGUgdGhlIHNlcWJ1Zgo+
Pj4+IHRvIHByaW50IHdoaWNoIGRldmljZXMgYXJlIHdpdGhpbiB0aGUgQUNTIHBhdGguCj4+Pj4K
Pj4+PiBTd2l0Y2ggdGhlIGttYWxsb2MgY2FsbCB0byB1c2UgYSBwYXNzZWQgaW4gZ2ZwX21hc2sg
YW5kIGRvbid0IHByaW50IHRoYXQKPj4+PiBtZXNzYWdlIGlmIHRoZSBidWZmZXIgZmFpbHMgdG8g
YmUgYWxsb2NhdGVkLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPgo+Pj4+IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fh
c0Bnb29nbGUuY29tPgo+Pj4+IC0tLQo+Pj4+ICDCoCBkcml2ZXJzL3BjaS9wMnBkbWEuYyB8IDIx
ICsrKysrKysrKysrLS0tLS0tLS0tLQo+Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvcDJwZG1hLmMgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwo+Pj4+IGluZGV4IDE5NjM4MjYzMDM2
My4uYmQ4OTQzN2ZhZjA2IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvcGNpL3AycGRtYS5jCj4+
Pj4gKysrIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMKPj4+PiBAQCAtMjY3LDcgKzI2Nyw3IEBAIHN0
YXRpYyBpbnQgcGNpX2JyaWRnZV9oYXNfYWNzX3JlZGlyKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+
Pj4+ICDCoCDCoCBzdGF0aWMgdm9pZCBzZXFfYnVmX3ByaW50X2J1c19kZXZmbihzdHJ1Y3Qgc2Vx
X2J1ZiAqYnVmLCBzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4+PiAgwqAgewo+Pj4+IC3CoMKgwqAg
aWYgKCFidWYpCj4+Pj4gK8KgwqDCoCBpZiAoIWJ1ZiB8fCAhYnVmLT5idWZmZXIpCj4+PiBUaGlz
IGlzIG5vdCBncmVhdCwgc29ydCBvZiBmcm9tIGFuIG92ZXJhbGwgZGVzaWduIHBvaW50IG9mIHZp
ZXcsIGV2ZW4gdGhvdWdoCj4+PiBpdCBtYWtlcyB0aGUgcmVzdCBvZiB0aGUgcGF0Y2ggd29yay4g
U2VlIGJlbG93IGZvciBvdGhlciBpZGVhcywgdGhhdCB3aWxsCj4+PiBhdm9pZCB0aGUgbmVlZCBm
b3IgdGhpcyBzb3J0IG9mIG9kZCBwb2ludCBmaXguCj4+Pgo+PiArMS4KPj4gSW4gZmFjdCwgSSBk
aWRuJ3Qgc2VlIGhvdyB0aGUga21hbGxvYyB3YXMgY2hhbmdlZC4uLiB5b3UgcmVmYWN0b3JlZCB0
aGUgY29kZSB0byBwYXNzLWluIHRoZQo+PiBHRlBfS0VSTkVMIHRoYXQgd2FzIG9yaWdpbmFsbHkg
aGFyZC1jb2RlZCBpbnRvIHVwc3RyZWFtX2JyaWRnZV9kaXN0YW5jZV93YXJuKCk7Cj4+IEkgZG9u
J3Qgc2VlIGhvdyB0aGF0IGF2b2lkZWQgdGhlIGttYWxsb2MoKSBjYWxsLgo+PiBpbiBmYWN0LCBJ
IGFsc28gc2VlIHlvdSBsb3N0IGEgZmFpbGVkIGttYWxsb2MoKSBjaGVjaywgc28gaXQgc2VlbXMg
dG8gaGF2ZSB0YWtlbiBhIHN0ZXAgYmFjay4KPiBJJ3ZlIGNoYW5nZWQgdGhpcyBpbiB2MiB0byBq
dXN0IHVzZSBzb21lIG1lbW9yeSBhbGxvY2F0ZWQgb24gdGhlIHN0YWNrLgo+IEF2b2lkcyB0aGlz
IGFyZ3VtZW50IGFsbCB0b2dldGhlci4KPgo+IExvZ2FuCj4KTG9va2luZyBmd2QgdG8gdGhlIHYy
OyBhZ2FpbiwgbXkgYXBvbG9naWVzIGZvciB0aGUgZGVsYXksIGFuZCB0aGUgcmVkdW5kYW5jeSBp
dCdzIGFkZGluZyB0byB5b3VyIGZlZWRiYWNrIHJldmlldyAmIGNoYW5nZXMuCi1Eb24KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
