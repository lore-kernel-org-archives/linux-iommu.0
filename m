Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B17FA372A
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7332168B
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7332168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2F0F0E2B;
	Wed, 16 Oct 2019 16:36:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 63518E26
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:36:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 02F758B1
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:36:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A93C628;
	Wed, 16 Oct 2019 09:36:13 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80C143F68E;
	Wed, 16 Oct 2019 09:36:12 -0700 (PDT)
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
	Qian Cai <cai@lca.pw>
References: <1571237707.5937.58.camel@lca.pw>
	<1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
	<1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
	<a85f264c-3b74-b92b-ac03-aeba3a56946f@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <fc510899-4e8b-827f-4c5f-2fe89145ac30@arm.com>
Date: Wed, 16 Oct 2019 17:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a85f264c-3b74-b92b-ac03-aeba3a56946f@arm.com>
Content-Language: en-US
Cc: Marc Zyngier <maz@kernel.org>, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>, Tom Murphy <murphyt7@tcd.ie>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgUm9iaW4sCgpPbiAxNi8xMC8yMDE5IDE3OjA5LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MTYvMTAvMjAxOSAxNzowMywgSm9lcmcgUm9lZGVsIHdyb3RlOgo+PiBPbiBXZWQsIE9jdCAxNiwg
MjAxOSBhdCAxMTo1MzozM0FNIC0wNDAwLCBRaWFuIENhaSB3cm90ZToKPj4+IE9uIFdlZCwgMjAx
OS0xMC0xNiBhdCAxNzozMSArMDIwMCwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+Pgo+Pj4gVGhlIHg4
NiBvbmUgbWlnaHQganVzdCBiZSBhIG1pc3Rha2UuCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvYW1kX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jCj4+PiBpbmRl
eCBhZDA1NDg0ZDBjODAuLjYzYzRiODk0NzUxZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9t
bXUvYW1kX2lvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMKPj4+IEBA
IC0yNTQyLDcgKzI1NDIsNyBAQCBzdGF0aWMgaW50IGFtZF9pb21tdV9tYXAoc3RydWN0IGlvbW11
X2RvbWFpbiAqZG9tLAo+Pj4gdW5zaWduZWQgbG9uZyBpb3ZhLAo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGlvbW11X3Byb3QgJiBJT01NVV9XUklURSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwcm90IHw9IElPTU1VX1BST1RfSVc7Cj4+PiAtwqDCoMKgwqDCoMKgwqBy
ZXQgPSBpb21tdV9tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3Qs
IEdGUF9LRVJORUwpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gaW9tbXVfbWFwX3BhZ2UoZG9t
YWluLCBpb3ZhLCBwYWRkciwgcGFnZV9zaXplLCBwcm90LCBnZnApOwo+Pgo+PiBZZWFoLCB0aGF0
IGlzIGEgYnVnLCBJIHNwb3R0ZWQgdGhhdCB0b28uCj4+Cj4+PiBAQCAtMTE4NSw3ICsxMTg1LDcg
QEAgc3RhdGljIHN0cnVjdCBpb21tdV9kbWFfbXNpX3BhZ2UKPj4+ICppb21tdV9kbWFfZ2V0X21z
aV9wYWdlKHN0cnVjdCBkZXZpY2UgKmRldiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaW92
YSkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX3Bh
Z2U7Cj4+PiAtwqDCoMKgwqDCoMKgwqBpZiAoaW9tbXVfbWFwKGRvbWFpbiwgaW92YSwgbXNpX2Fk
ZHIsIHNpemUsIHByb3QpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgaWYgKGlvbW11X21hcF9hdG9taWMo
ZG9tYWluLCBpb3ZhLCBtc2lfYWRkciwgc2l6ZSwgcHJvdCkpCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZnJlZV9pb3ZhOwo+Pgo+PiBOb3Qgc28gc3VyZSB0
aGlzIGlzIGEgYnVnLCB0aGlzIGNvZGUgaXMgb25seSBhYm91dCBzZXR0aW5nIHVwIE1TSXMgb24K
Pj4gQVJNLiBJdCBwcm9iYWJseSBkb2Vzbid0IG5lZWQgdG8gYmUgYXRvbWljLgo+IFJpZ2h0LCBz
aW5jZSB0aGUgaW9tbXVfZG1hX3ByZXBhcmVfbXNpKCkgb3BlcmF0aW9uIHdhcyBicm9rZW4gb3V0
IHRvIGhhcHBlbiBhdCAKPiBNU0kgZG9tYWluIHNldHVwIHRpbWUsIEkgZG9uJ3QgdGhpbmsgdGhl
IGNvbW1lbnQgaW4gdGhlcmUgYXBwbGllcyBhbnkgbW9yZSwgc28gCj4gd2UgY2FuIHByb2JhYmx5
IHN0b3AgZGlzYWJsaW5nIGlycXMgYXJvdW5kIHRoZSBpb21tdV9kbWFfZ2V0X21zaV9wYWdlKCkg
Y2FsbC4KClllcywgSSBhZ3JlZSB0aGF0IGl0IGRvZXMgbm90IG5lZWQgdG8gYmUgYXRvbWljIGFu
eW1vcmUuCgpDaGVlcnMsCgotLSAKSnVsaWVuIEdyYWxsCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
