Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACFFA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:09:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7506521D7D
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7506521D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 32D4BDB4;
	Wed, 16 Oct 2019 16:09:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E4BECDA6
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 72A4E89D
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:09:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72997142F;
	Wed, 16 Oct 2019 09:09:23 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F22C43F68E;
	Wed, 16 Oct 2019 09:09:21 -0700 (PDT)
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
To: Joerg Roedel <jroedel@suse.de>, Qian Cai <cai@lca.pw>
References: <1571237707.5937.58.camel@lca.pw>
	<1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
	<1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a85f264c-3b74-b92b-ac03-aeba3a56946f@arm.com>
Date: Wed, 16 Oct 2019 17:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191016160314.GH4695@suse.de>
Content-Language: en-GB
Cc: Marc Zyngier <maz@kernel.org>, Julien Grall <julien.grall@arm.com>,
	Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

T24gMTYvMTAvMjAxOSAxNzowMywgSm9lcmcgUm9lZGVsIHdyb3RlOgo+IE9uIFdlZCwgT2N0IDE2
LCAyMDE5IGF0IDExOjUzOjMzQU0gLTA0MDAsIFFpYW4gQ2FpIHdyb3RlOgo+PiBPbiBXZWQsIDIw
MTktMTAtMTYgYXQgMTc6MzEgKzAyMDAsIEpvZXJnIFJvZWRlbCB3cm90ZToKPiAKPj4gVGhlIHg4
NiBvbmUgbWlnaHQganVzdCBiZSBhIG1pc3Rha2UuCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYwo+PiBpbmRleCBh
ZDA1NDg0ZDBjODAuLjYzYzRiODk0NzUxZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9h
bWRfaW9tbXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jCj4+IEBAIC0yNTQy
LDcgKzI1NDIsNyBAQCBzdGF0aWMgaW50IGFtZF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tLAo+PiB1bnNpZ25lZCBsb25nIGlvdmEsCj4+ICDCoMKgwqDCoMKgwqDCoMKgaWYgKGlv
bW11X3Byb3QgJiBJT01NVV9XUklURSkKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcHJvdCB8PSBJT01NVV9QUk9UX0lXOwo+PiAgIAo+PiAtwqDCoMKgwqDCoMKgwqByZXQgPSBp
b21tdV9tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3QsIEdGUF9L
RVJORUwpOwo+PiArwqDCoMKgwqDCoMKgwqByZXQgPSBpb21tdV9tYXBfcGFnZShkb21haW4sIGlv
dmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3QsIGdmcCk7Cj4gCj4gWWVhaCwgdGhhdCBpcyBhIGJ1
ZywgSSBzcG90dGVkIHRoYXQgdG9vLgo+IAo+PiBAQCAtMTE4NSw3ICsxMTg1LDcgQEAgc3RhdGlj
IHN0cnVjdCBpb21tdV9kbWFfbXNpX3BhZ2UKPj4gKmlvbW11X2RtYV9nZXRfbXNpX3BhZ2Uoc3Ry
dWN0IGRldmljZSAqZGV2LAo+PiAgwqDCoMKgwqDCoMKgwqDCoGlmICghaW92YSkKPj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZnJlZV9wYWdlOwo+PiAgIAo+PiAt
wqDCoMKgwqDCoMKgwqBpZiAoaW9tbXVfbWFwKGRvbWFpbiwgaW92YSwgbXNpX2FkZHIsIHNpemUs
IHByb3QpKQo+PiArwqDCoMKgwqDCoMKgwqBpZiAoaW9tbXVfbWFwX2F0b21pYyhkb21haW4sIGlv
dmEsIG1zaV9hZGRyLCBzaXplLCBwcm90KSkKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBvdXRfZnJlZV9pb3ZhOwo+IAo+IE5vdCBzbyBzdXJlIHRoaXMgaXMgYSBidWcs
IHRoaXMgY29kZSBpcyBvbmx5IGFib3V0IHNldHRpbmcgdXAgTVNJcyBvbgo+IEFSTS4gSXQgcHJv
YmFibHkgZG9lc24ndCBuZWVkIHRvIGJlIGF0b21pYy4KUmlnaHQsIHNpbmNlIHRoZSBpb21tdV9k
bWFfcHJlcGFyZV9tc2koKSBvcGVyYXRpb24gd2FzIGJyb2tlbiBvdXQgdG8gCmhhcHBlbiBhdCBN
U0kgZG9tYWluIHNldHVwIHRpbWUsIEkgZG9uJ3QgdGhpbmsgdGhlIGNvbW1lbnQgaW4gdGhlcmUg
CmFwcGxpZXMgYW55IG1vcmUsIHNvIHdlIGNhbiBwcm9iYWJseSBzdG9wIGRpc2FibGluZyBpcnFz
IGFyb3VuZCB0aGUgCmlvbW11X2RtYV9nZXRfbXNpX3BhZ2UoKSBjYWxsLgoKUm9iaW4uCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
