Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0EBC433E2
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:24:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F71206C3
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F71206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C35FA894A6;
	Fri, 22 May 2020 09:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zvISipg6rkIU; Fri, 22 May 2020 09:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 113638947A;
	Fri, 22 May 2020 09:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62B3C088B;
	Fri, 22 May 2020 09:24:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53A35C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 42BF6894A2
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id romKWYPmlytv for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 09:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B67F8947A
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:24:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A94A1042;
 Fri, 22 May 2020 02:24:42 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFA263F305;
 Fri, 22 May 2020 02:24:40 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
To: guptap@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
 <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
Date: Fri, 22 May 2020 10:24:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
Content-Language: en-GB
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
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

T24gMjAyMC0wNS0yMiAwNzoyNSwgZ3VwdGFwQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+IE9uIDIw
MjAtMDUtMjIgMDE6NDYsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMC0wNS0yMSAxMjoz
MCwgUHJha2FzaCBHdXB0YSB3cm90ZToKPj4+IExpbWl0IHRoZSBpb3ZhIHNpemUgd2hpbGUgZnJl
ZWluZyBiYXNlZCBvbiB1bm1hcHBlZCBzaXplLiBJbiBhYnNlbmNlIG9mCj4+PiB0aGlzIGV2ZW4g
d2l0aCB1bm1hcCBmYWlsdXJlLCBpbnZhbGlkIGlvdmEgaXMgcHVzaGVkIHRvIGlvdmEgcmNhY2hl
IGFuZAo+Pj4gc3Vic2VxdWVudGx5IGNhbiBjYXVzZSBwYW5pYyB3aGlsZSByY2FjaGUgbWFnYXpp
bmUgaXMgZnJlZWQuCj4+Cj4+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHRoYXQgcGFuaWM/Cj4+Cj4g
V2UgaGF2ZSBzZWVuIGNvdXBsZSBvZiBzdGFiaWxpdHkgaXNzdWVzIGFyb3VuZCB0aGlzLgo+IEJl
bG93IGlzIG9uZSBzdWNoIGV4YW1wbGU6Cj4gCj4ga2VybmVsIEJVRyBhdCBrZXJuZWwvbXNtLTQu
MTkvZHJpdmVycy9pb21tdS9pb3ZhLmM6OTA0IQo+IGlvdmFfbWFnYXppbmVfZnJlZV9wZm5zCj4g
aW92YV9yY2FjaGVfaW5zZXJ0Cj4gZnJlZV9pb3ZhX2Zhc3QKPiBfX2lvbW11X3VubWFwX3BhZ2UK
PiBpb21tdV9kbWFfdW5tYXBfcGFnZQoKT0ssIHNvIGl0J3Mgbm90IHNvbWUgTlVMTCBkZXJlZmVy
ZW5jZSBvciBhbnl0aGluZyBjb21wbGV0ZWx5IHVuZXhwZWN0ZWQsIAp0aGF0J3MgZ29vZC4KCj4g
SXQgdHVybmVkIG91dCBhbiBpb3ZhIHBmbiAwIGdvdCBpbnRvIGlvdmFfcmNhY2hlLiBPbmUgcG9z
c2liaWxpdHkgSSBzZWUgaXMKPiB3aGVyZSBjbGllbnQgdW5tYXAgd2l0aCBpbnZhbGlkIGRtYV9h
ZGRyLiBUaGUgdW5tYXAgY2FsbCB3aWxsIGZhaWwgYW5kIAo+IHdhcm4gb24KPiBhbmQgc3RpbGwg
dHJ5IHRvIGZyZWUgaW92YS4gVGhpcyB3aWxsIGNhdXNlIGludmFsaWQgcGZuIHRvIGJlIGluc2Vy
dGVkIGludG8KPiByY2FjaGUuIEFzIGFuZCB3aGVuIHRoZSBtYWdhemluZSB3aXRoIGludmFsaWQg
cGZuIHdpbGwgYmUgZnJlZWQKPiBwcml2YXRlX2ZpbmRfaW92YSgpIHdpbGwgcmV0dXJuIE5VTEwg
Zm9yIGludmFsaWQgaW92YSBhbmQgbWVldCBidWcgCj4gY29uZGl0aW9uLgoKVGhhdCB3b3VsZCBp
bmRlZWQgYmUgYSBidWcgaW4gd2hhdGV2ZXIgZHJpdmVyIG1hZGUgdGhlIG9mZmVuZGluZyAKZG1h
X3VubWFwIGNhbGwuCgo+Pj4gU2lnbmVkLW9mZi1ieTogUHJha2FzaCBHdXB0YSA8Z3VwdGFwQGNv
ZGVhdXJvcmEub3JnPgo+Pj4KPj4+IDoxMDA2NDQgMTAwNjQ0IDQ5NTlmNWRmMjFiZCAwOThmN2Qz
NzdlMDQgTcKgwqDCoCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+Pgo+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
Cj4+PiBpbmRleCA0OTU5ZjVkZjIxYmQuLjA5OGY3ZDM3N2UwNCAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvZG1hLWlvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11
LmMKPj4+IEBAIC00NzIsNyArNDcyLDggQEAgc3RhdGljIHZvaWQgX19pb21tdV9kbWFfdW5tYXAo
c3RydWN0IGRldmljZSAqZGV2LCAKPj4+IGRtYV9hZGRyX3QgZG1hX2FkZHIsCj4+PiDCoMKgwqDC
oMKgwqDCoCBpZiAoIWNvb2tpZS0+ZnFfZG9tYWluKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlv
bW11X3RsYl9zeW5jKGRvbWFpbiwgJmlvdGxiX2dhdGhlcik7Cj4+PiAtwqDCoMKgIGlvbW11X2Rt
YV9mcmVlX2lvdmEoY29va2llLCBkbWFfYWRkciwgc2l6ZSk7Cj4+PiArwqDCoMKgIGlmICh1bm1h
cHBlZCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBpb21tdV9kbWFfZnJlZV9pb3ZhKGNvb2tpZSwgZG1h
X2FkZHIsIHVubWFwcGVkKTsKPj4KPj4gRnJhbmtseSwgaWYgYW55IHBhcnQgb2YgdGhlIHVubWFw
IGZhaWxzIHRoZW4gdGhpbmdzIGhhdmUgZ29uZQo+PiBjYXRhc3Ryb3BoaWNhbGx5IHdyb25nIGFs
cmVhZHksIGJ1dCBlaXRoZXIgd2F5IHRoaXMgaXNuJ3QgcmlnaHQuIFRoZQo+PiBJT1ZBIEFQSSBk
b2Vzbid0IHN1cHBvcnQgcGFydGlhbCBmcmVlaW5nIC0gYW4gSU9WQSAqbXVzdCogYmUgZnJlZWQK
Pj4gd2l0aCBpdHMgb3JpZ2luYWwgc2l6ZSwgb3Igbm90IGZyZWVkIGF0IGFsbCwgb3RoZXJ3aXNl
IGl0IHdpbGwgY29ycnVwdAo+PiB0aGUgc3RhdGUgb2YgdGhlIHJjYWNoZXMgYW5kIHJpc2sgYSBj
YXNjYWRlIG9mIGZ1cnRoZXIgbWlzYmVoYXZpb3VyCj4+IGZvciBmdXR1cmUgY2FsbGVycy4KPj4K
PiBJIGFncmVlLCB3ZSBzaG91bGRuJ3QgYmUgZnJlZWluZyB0aGUgcGFydGlhbCBpb3ZhLiBJbnN0
ZWFkIGp1c3QgbWFraW5nCj4gc3VyZSBpZiB1bm1hcCB3YXMgc3VjY2Vzc2Z1bCBzaG91bGQgYmUg
c3VmZmljaWVudCBiZWZvcmUgZnJlZWluZyBpb3ZhLiAKPiBTbyBjaGFuZ2UKPiBjYW4gaW5zdGVh
ZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOgo+IAo+IC3CoMKgwqAgaW9tbXVfZG1hX2ZyZWVfaW92
YShjb29raWUsIGRtYV9hZGRyLCBzaXplKTsKPiArwqDCoMKgIGlmICh1bm1hcHBlZCkKPiArwqDC
oMKgwqDCoMKgwqAgaW9tbXVfZG1hX2ZyZWVfaW92YShjb29raWUsIGRtYV9hZGRyLCBzaXplKTsK
PiAKPj4gVEJIIG15IGd1dCBmZWVsaW5nIGhlcmUgaXMgdGhhdCB5b3UncmUgcmVhbGx5IGp1c3Qg
dHJ5aW5nIHRvIHRyZWF0IGEKPj4gc3ltcHRvbSBvZiBhbm90aGVyIGJ1ZyBlbHNld2hlcmUsIG5h
bWVseSBzb21lIGRyaXZlciBjYWxsaW5nCj4+IGRtYV91bm1hcF8qIG9yIGRtYV9mcmVlXyogd2l0
aCB0aGUgd3JvbmcgYWRkcmVzcyBvciBzaXplIGluIHRoZSBmaXJzdAo+PiBwbGFjZS4KPj4KPiBU
aGlzIGNvbmRpdGlvbiB3b3VsZCBhcmlzZSBvbmx5IGlmIGRyaXZlciBjYWxsaW5nIGRtYV91bm1h
cC9mcmVlXyogd2l0aCAwCj4gaW92YV9wZm4uIFRoaXMgd2lsbCBiZSBmbGFnZ2VkIHdpdGggYSB3
YXJuaW5nIGR1cmluZyB1bm1hcCBidXQgd2lsbCB0cmlnZ2VyCj4gcGFuaWMgbGF0ZXIgb24gd2hp
bGUgZG9pbmcgdW5yZWxhdGVkIGRtYV9tYXAvdW5tYXBfKi4gSWYgdW5tYXBwZWQgaGFzIAo+IGFs
cmVhZHkKPiBmYWlsZWQgZm9yIGludmFsaWQgaW92YSwgdGhlcmUgaXMgbm8gcmVhc29uIHdlIHNo
b3VsZCBjb25zaWRlciB0aGlzIGFzIAo+IHZhbGlkCj4gaW92YSBhbmQgZnJlZS4gVGhpcyBwYXJ0
IHNob3VsZCBiZSBmaXhlZC4KCkkgZGlzYWdyZWUuIEluIGdlbmVyYWwsIGlmIGRyaXZlcnMgY2Fs
bCB0aGUgRE1BIEFQSSBpbmNvcnJlY3RseSBpdCBpcyAKbGlhYmxlIHRvIGxlYWQgdG8gZGF0YSBs
b3NzLCBtZW1vcnkgY29ycnVwdGlvbiwgYW5kIHZhcmlvdXMgb3RoZXIgCnVucGxlYXNhbnQgbWlz
YmVoYXZpb3VyIC0gaXQgaXMgbm90IHRoZSBETUEgbGF5ZXIncyBqb2IgdG8gYXR0ZW1wdCB0byAK
cGFwZXIgb3ZlciBkcml2ZXIgYnVncy4KClRoZXJlICppcyogYW4gYXJndW1lbnQgZm9yIGRvd25n
cmFkaW5nIHRoZSBCVUdfT04oKSBpbiAKaW92YV9tYWdhemluZV9mcmVlX3BmbnMoKSB0byBhIFdB
Uk5fT04oKSwgc2luY2UgZnJhbmtseSBpdCBpc24ndCBhIApzdWZmaWNpZW50bHkgc2VyaW91cyBj
b25kaXRpb24gdG8ganVzdGlmeSBraWxsaW5nIHRoZSB3aG9sZSBtYWNoaW5lIAppbW1lZGlhdGVs
eSwgYnV0IE5BSyB0byBib2RnaW5nIHRoZSBpb21tdS1kbWEgbWlkLWxheWVyIHRvICJmaXgiIHRo
YXQuIEEgCnNlcmlvdXMgYnVnIGFscmVhZHkgaGFwcGVuZWQgZWxzZXdoZXJlLCBzbyB0cnlpbmcg
dG8gaGlkZSB0aGUgZmFsbG91dCAKcmVhbGx5IGRvZXNuJ3QgaGVscCBhbnlvbmUuCgpSb2Jpbi4K
Cj4gT24gMjAyMC0wNS0yMiAwMDoxOSwgQW5kcmV3IE1vcnRvbiB3cm90ZToKPj4gSSB0aGluayB3
ZSBuZWVkIGEgY2M6c3RhYmxlIGhlcmU/Cj4+Cj4gQWRkZWQgbm93Lgo+IAo+IFRoYW5rcywKPiBQ
cmFrYXNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
