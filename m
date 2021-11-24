Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B13C433EF
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 18:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65F4F80AEA;
	Wed, 24 Nov 2021 18:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o05pEEFZl7Cf; Wed, 24 Nov 2021 18:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43C4281C20;
	Wed, 24 Nov 2021 18:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BCA3C002E;
	Wed, 24 Nov 2021 18:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B72EC002E
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C52A0404D8
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WnqAOBZX6cCv for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 18:33:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D600404C4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 18:33:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DDB1FB;
 Wed, 24 Nov 2021 10:33:21 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79AE13F66F;
 Wed, 24 Nov 2021 10:33:20 -0800 (PST)
Message-ID: <4bce6339-095f-a7cb-fb7c-436b8ece9588@arm.com>
Date: Wed, 24 Nov 2021 18:33:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/9] iommu: Refactor flush queues into iommu-dma
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
References: <cover.1637671820.git.robin.murphy@arm.com>
 <7f7daf42-8aff-b9ed-0f48-d4158896012e@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7f7daf42-8aff-b9ed-0f48-d4158896012e@huawei.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 willy@infradead.org
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

T24gMjAyMS0xMS0yNCAxNzoyMSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAyMy8xMS8yMDIxIDE0
OjEwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IEFzIHByb21pc2VkLCB0aGlzIHNlcmllcyBjbGVh
bnMgdXAgdGhlIGZsdXNoIHF1ZXVlIGNvZGUgYW5kIHN0cmVhbWxpbmVzCj4+IGl0IGRpcmVjdGx5
IGludG8gaW9tbXUtZG1hLiBTaW5jZSB3ZSBubyBsb25nZXIgaGF2ZSBwZXItZHJpdmVyIERNQSBv
cHMKPj4gaW1wbGVtZW50YXRpb25zLCBhIGxvdCBvZiB0aGUgYWJzdHJhY3Rpb24gaXMgbm93IG5v
IGxvbmdlciBuZWNlc3NhcnksIHNvCj4+IHRoZXJlJ3MgYSBuaWNlIGRlZ3JlZSBvZiBzaW1wbGlm
aWNhdGlvbiBpbiB0aGUgcHJvY2Vzcy4gVW4tYWJzdHJhY3RpbmcKPj4gdGhlIHF1ZXVlZCBwYWdl
IGZyZWVpbmcgbWVjaGFuaXNtIGlzIGFsc28gdGhlIHBlcmZlY3Qgb3Bwb3J0dW5pdHkgdG8KPj4g
cmV2aXNlIHdoaWNoIHN0cnVjdCBwYWdlIGZpZWxkcyB3ZSB1c2Ugc28gd2UgY2FuIGJlIGJldHRl
ci1iZWhhdmVkCj4+IGZyb20gdGhlIE1NIHBvaW50IG9mIHZpZXcsIHRoYW5rcyB0byBNYXR0aGV3
Lgo+Pgo+PiBUaGVzZSBjaGFuZ2VzIHNob3VsZCBhbHNvIG1ha2UgaXQgdmlhYmxlIHRvIHN0YXJ0
IHVzaW5nIHRoZSBnYXRoZXIKPj4gZnJlZWxpc3QgaW4gaW8tcGd0YWJsZS1hcm0sIGFuZCBlbGlt
aW5hdGUgc29tZSBtb3JlIHN5bmNocm9ub3VzCj4+IGludmFsaWRhdGlvbnMgZnJvbSB0aGUgbm9y
bWFsIGZsb3cgdGhlcmUsIGJ1dCB0aGF0IGlzIHByb3ZpbmcgdG8gbmVlZCBhCj4+IGJpdCBtb3Jl
IGNhcmVmdWwgdGhvdWdodCB0aGFuIEkgaGF2ZSB0aW1lIGZvciBpbiB0aGlzIGN5Y2xlLCBzbyBJ
J3ZlCj4+IHBhcmtlZCB0aGF0IGFnYWluIGZvciBub3cgYW5kIHdpbGwgcmV2aXNpdCBpdCBpbiB0
aGUgbmV3IHllYXIuCj4+Cj4+IEZvciBjb252ZW5pZW5jZSwgYnJhbmNoIGF0Ogo+PiDCoMKgIGh0
dHBzOi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJtL2xpbnV4LXJtLy0vdHJlZS9pb21tdS9pb3Zh
Cj4+Cj4+IEkndmUgYnVpbGQtdGVzdGVkIGZvciB4ODZfNjQsIGFuZCBib290LXRlc3RlZCBhcm02
NCB0byB0aGUgcG9pbnQgb2YKPj4gY29uZmlybWluZyB0aGF0IHB1dF9wYWdlc19saXN0KCkgZ2V0
cyBwYXNzZWQgYSB2YWxpZCBlbXB0eSBsaXN0IHdoZW4KPj4gZmx1c2hpbmcsIHdoaWxlIGV2ZXJ5
dGhpbmcgZWxzZSBzdGlsbCB3b3Jrcy4KPiBNeSBpbnRlcmVzdCBpcyBpbiBwYXRjaGVzIDIsIDMs
IDcsIDgsIDksIGFuZCB0aGV5IGxvb2sgb2suIEkgZGlkIGEgYml0IAo+IG9mIHRlc3RpbmcgZm9y
IHN0cmljdCBhbmQgbm9uLXN0cmljdCBtb2RlIG9uIG15IGFybTY0IHN5c3RlbSBhbmQgbm8gCj4g
cHJvYmxlbXMuCj4gCj4gQXBhcnQgZnJvbSB0aGlzLCBJIG5vdGljZWQgdGhhdCBvbmUgcG9zc2li
bGUgb3B0aW1pemF0aW9uIGNvdWxkIGJlIHRvIAo+IGF2b2lkIHNvIG1hbnkgcmVhZHMgb2YgZnFf
Zmx1c2hfZmluaXNoX2NudCwgYXMgd2Ugc2VlbSB0byBoYXZlIGEgcGF0dGVybiAKPiBvZiBmcV9m
bHVzaF9pb3RsYigpLT5hdG9taWM2NF9pbmMoZnFfZmx1c2hfZmluaXNoX2NudCkgZm9sbG93ZWQg
YnkgYSAKPiByZWFkIG9mIGZxX2ZsdXNoX2ZpbmlzaF9jbnQgaW4gZnFfcmluZ19mcmVlKCksIHNv
IHdlIGNvdWxkIHVzZSAKPiBhdG9taWM2NF9pbmNfcmV0dXJuKGZxX2ZsdXNoX2ZpbmlzaF9jbnQp
IGFuZCByZXVzZSB0aGUgdmFsdWUuIEkgdGhpbmsgCj4gdGhhdCBhbnkgcmFjaW5nIGluIGZxX2Zs
dXNoX2ZpbmlzaF9jbnQgYWNjZXNzZXMgYXJlIGxhdGVudCwgYnV0IG1heWJlIAo+IHRoZXJlIGlz
IGEgZmxhdyBpbiB0aGlzLiBIb3dldmVyIEkgdHJpZWQgc29tZXRoaW5nIGFsb25nIHRoZXNlIGxp
bmVzIGFuZCAKPiBnb3QgYSAyLjQlIHRocm91Z2hwdXQgZ2FpbiBmb3IgbXkgc3RvcmFnZSBzY2Vu
YXJpby4KClllcywgdGhhdCBzb3VuZHMgcmVhc29uYWJsZSAtIG9mZi1oYW5kIEkgY2FuJ3Qgc2Vl
IHRoYXQgdGhlcmUncyBhbnkgbW9yZSAKcG90ZW50aWFsIGZvciBoYXJtZnVsIHJhY2VzIGVpdGhl
ci4gQWxsIHRoYXQganVtcHMgb3V0IGlzIHRoZSBjYXNlIHdoZXJlIAp0aGUgZmx1c2ggY291bnQg
Z2V0cyBidW1wZWQgdmlhIHF1ZXVlX2lvdmEoKSB3aGlsZSBhbm90aGVyIENQVSBpcyAKYWxyZWFk
eSBydW5uaW5nIGZxX2ZsdXNoX3RpbWVvdXQoKSwgd2hlcmUgZnJlZWluZyBuZXdlciBJT1ZBcyBh
ZGRlZCAKc2luY2UgdGhlIHRpbWVvdXQgaXMgdGhlbiBtb3JlIGxpa2VseSB0byBiZSBsZWZ0IHRv
IHRoZSBsb2NhbCBDUFUsIG9yIApwb3N0cG9uZWQgdW50aWwgdGhlIG5leHQgZmx1c2ggY3ljbGUg
ZW50aXJlbHksIHJhdGhlciB0aGFuIGJlaW5nIHBpbGVkIApvbiB0byB0aGUgZ3V5IGFscmVhZHkg
cHJvY2Vzc2luZyB0aGUgZm9yX2VhY2hfcG9zc2libGVfY3B1KCkgbG9vcC4gQW5kIEkgCmNhbid0
IGhlbHAgdGhpbmtpbmcgdGhhdCBjb3VsZCBvbmx5IGJlIGEgKmdvb2QqIHRoaW5nLCBnaXZlbiBo
b3cgdGhlIEZRIAp0aW1lb3V0IHNlZW1zIHRvIGJlIGEgc21va2luZyBndW4gaW4geW91ciAicGVy
Zm9ybWFuY2UgbmV2ZXIgcmVjb3ZlcnMgCmFmdGVyIGZhbGxpbmcgb2ZmIHRoZSBjbGlmZiIgc2Nl
bmFyaW8gOikKClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
