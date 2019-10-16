Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45701FA372B
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:26:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CB02168B
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 16:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CB02168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDC9ADD5;
	Wed, 16 Oct 2019 16:26:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A450ADB4
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:26:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3761F8B4
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 16:26:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92ED28;
	Wed, 16 Oct 2019 09:26:26 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3D0D3F68E;
	Wed, 16 Oct 2019 09:26:25 -0700 (PDT)
Subject: Re: "Convert the AMD iommu driver to the dma-iommu api" is buggy
To: Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>
References: <1571237707.5937.58.camel@lca.pw>
	<1571237982.5937.60.camel@lca.pw> <20191016153112.GF4695@suse.de>
	<1571241213.5937.64.camel@lca.pw> <20191016160314.GH4695@suse.de>
	<1571242287.5937.66.camel@lca.pw>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2912dd38-72c5-93a1-1185-46b681473a62@arm.com>
Date: Wed, 16 Oct 2019 17:26:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571242287.5937.66.camel@lca.pw>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	Tom Murphy <murphyt7@tcd.ie>, linux-kernel@vger.kernel.org
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

T24gMTYvMTAvMjAxOSAxNzoxMSwgUWlhbiBDYWkgd3JvdGU6Cj4gT24gV2VkLCAyMDE5LTEwLTE2
IGF0IDE4OjAzICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4+IE9uIFdlZCwgT2N0IDE2LCAy
MDE5IGF0IDExOjUzOjMzQU0gLTA0MDAsIFFpYW4gQ2FpIHdyb3RlOgo+Pj4gT24gV2VkLCAyMDE5
LTEwLTE2IGF0IDE3OjMxICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4+PiBUaGUgeDg2IG9u
ZSBtaWdodCBqdXN0IGJlIGEgbWlzdGFrZS4KPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9hbWRfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMKPj4+IGluZGV4IGFk
MDU0ODRkMGM4MC4uNjNjNGI4OTQ3NTFkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9h
bWRfaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYwo+Pj4gQEAgLTI1
NDIsNyArMjU0Miw3IEBAIHN0YXRpYyBpbnQgYW1kX2lvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9t
YWluICpkb20sCj4+PiB1bnNpZ25lZCBsb25nIGlvdmEsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoGlm
IChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBwcm90IHw9IElPTU1VX1BST1RfSVc7Cj4+PiAgIAo+Pj4gLcKgwqDCoMKgwqDCoMKg
cmV0ID0gaW9tbXVfbWFwX3BhZ2UoZG9tYWluLCBpb3ZhLCBwYWRkciwgcGFnZV9zaXplLCBwcm90
LCBHRlBfS0VSTkVMKTsKPj4+ICvCoMKgwqDCoMKgwqDCoHJldCA9IGlvbW11X21hcF9wYWdlKGRv
bWFpbiwgaW92YSwgcGFkZHIsIHBhZ2Vfc2l6ZSwgcHJvdCwgZ2ZwKTsKPj4KPj4gWWVhaCwgdGhh
dCBpcyBhIGJ1ZywgSSBzcG90dGVkIHRoYXQgdG9vLgo+Pgo+Pj4gQEAgLTExODUsNyArMTE4NSw3
IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZG1hX21zaV9wYWdlCj4+PiAqaW9tbXVfZG1hX2dldF9t
c2lfcGFnZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoGlmICghaW92
YSkKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2ZyZWVfcGFn
ZTsKPj4+ICAgCj4+PiAtwqDCoMKgwqDCoMKgwqBpZiAoaW9tbXVfbWFwKGRvbWFpbiwgaW92YSwg
bXNpX2FkZHIsIHNpemUsIHByb3QpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgaWYgKGlvbW11X21hcF9h
dG9taWMoZG9tYWluLCBpb3ZhLCBtc2lfYWRkciwgc2l6ZSwgcHJvdCkpCj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9mcmVlX2lvdmE7Cj4+Cj4+IE5vdCBzbyBz
dXJlIHRoaXMgaXMgYSBidWcsIHRoaXMgY29kZSBpcyBvbmx5IGFib3V0IHNldHRpbmcgdXAgTVNJ
cyBvbgo+PiBBUk0uIEl0IHByb2JhYmx5IGRvZXNuJ3QgbmVlZCB0byBiZSBhdG9taWMuCj4gCj4g
VGhlIHBhdGNoICJpb21tdTogQWRkIGdmcCBwYXJhbWV0ZXIgdG8gaW9tbXVfb3BzOjptYXAiIGRv
ZXMgdGhpcy4gSXQgY291bGQgYmUKPiBjYWxsZWQgZnJvbSBhbiBhdG9taWMgY29udGV4dCBhcyBz
aG93ZWQgaW4gdGhlIGFybTY0IGNhbGwgdHJhY2VzLAo+IAo+ICtpbnQgaW9tbXVfbWFwKHN0cnVj
dCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHBoeXNfYWRkcl90IHBhZGRyLCBzaXplX3Qgc2l6ZSwgaW50IHByb3Qp
Cj4gK3sKPiArwqDCoMKgwqDCoMKgwqBtaWdodF9zbGVlcCgpOwo+ICvCoMKgwqDCoMKgwqDCoHJl
dHVybiBfX2lvbW11X21hcChkb21haW4sIGlvdmEsIHBhZGRyLCBzaXplLCBwcm90LCBHRlBfS0VS
TkVMKTsKPiArfQoKQWxzbyBub3RlIHRoYXQgaXQncyAqb25seSogdGhlIG1pZ2h0X3NsZWVwKCkg
YXQgaXNzdWUgaGVyZSAtIG5vbmUgb2YgdGhlIAphcm02NCBJT01NVSBkcml2ZXJzIGhhdmUgYmVl
biBjb252ZXJ0ZWQgdG8gbG9vayBhdCB0aGUgbmV3IGdmcCBhcmd1bWVudCAKeWV0LCBzbyBhbnl0
aGluZyB0aGV5IGFjdHVhbGx5IGFsbG9jYXRlIHdoaWxlIG1hcHBpbmcgd2lsbCBzdGlsbCBiZSAK
R0ZQX0FUT01JQyBhbnl3YXkuCgooQ2FycnlpbmcgdGhhdCBmbGFnIGRvd24gdGhyb3VnaCB0aGUg
d2hvbGUgaW8tcGd0YWJsZSBzdGFjayBpcyBvbiBteSAKdG8tZG8gbGlzdC4uLikKClJvYmluLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
