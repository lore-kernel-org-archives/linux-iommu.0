Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CAC433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE4E207ED
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 13:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE4E207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37896876DB;
	Tue,  2 Jun 2020 13:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 354utsGf9IkT; Tue,  2 Jun 2020 13:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EF3586D67;
	Tue,  2 Jun 2020 13:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32ADBC0178;
	Tue,  2 Jun 2020 13:07:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B227C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 13:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 549A3203FE
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 13:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ueIYeXUsaiih for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 13:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 6A1D2204B4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 13:07:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A811FB;
 Tue,  2 Jun 2020 06:07:15 -0700 (PDT)
Received: from [10.57.10.95] (unknown [10.57.10.95])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BE473F305;
 Tue,  2 Jun 2020 06:07:13 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
To: guptap@codeaurora.org
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
 <90662ef3123dbf2e93f9718ee5cc14a7@codeaurora.org>
 <2d873ab9-ebb9-3c2d-f129-55a036ab47d0@arm.com>
 <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b5f8501-6e6e-0cd2-7f98-7cfea13051d7@arm.com>
Date: Tue, 2 Jun 2020 14:07:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4ba082d3bb965524157704ea1ffb1ff4@codeaurora.org>
Content-Language: en-GB
Cc: mhocko@suse.com, owner-linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gMjAyMC0wNS0yNiAwODoxOSwgZ3VwdGFwQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+IE9uIDIw
MjAtMDUtMjIgMTQ6NTQsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMC0wNS0yMiAwNzoy
NSwgZ3VwdGFwQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+Pj4gT24gMjAyMC0wNS0yMiAwMTo0Niwg
Um9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IE9uIDIwMjAtMDUtMjEgMTI6MzAsIFByYWthc2ggR3Vw
dGEgd3JvdGU6Cj4+PiBJIGFncmVlLCB3ZSBzaG91bGRuJ3QgYmUgZnJlZWluZyB0aGUgcGFydGlh
bCBpb3ZhLiBJbnN0ZWFkIGp1c3QgbWFraW5nCj4+PiBzdXJlIGlmIHVubWFwIHdhcyBzdWNjZXNz
ZnVsIHNob3VsZCBiZSBzdWZmaWNpZW50IGJlZm9yZSBmcmVlaW5nIAo+Pj4gaW92YS4gU28gY2hh
bmdlCj4+PiBjYW4gaW5zdGVhZCBiZSBzb21ldGhpbmcgbGlrZSB0aGlzOgo+Pj4KPj4+IC3CoMKg
wqAgaW9tbXVfZG1hX2ZyZWVfaW92YShjb29raWUsIGRtYV9hZGRyLCBzaXplKTsKPj4+ICvCoMKg
wqAgaWYgKHVubWFwcGVkKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9mcmVlX2lvdmEo
Y29va2llLCBkbWFfYWRkciwgc2l6ZSk7Cj4+Pgo+Pj4+IFRCSCBteSBndXQgZmVlbGluZyBoZXJl
IGlzIHRoYXQgeW91J3JlIHJlYWxseSBqdXN0IHRyeWluZyB0byB0cmVhdCBhCj4+Pj4gc3ltcHRv
bSBvZiBhbm90aGVyIGJ1ZyBlbHNld2hlcmUsIG5hbWVseSBzb21lIGRyaXZlciBjYWxsaW5nCj4+
Pj4gZG1hX3VubWFwXyogb3IgZG1hX2ZyZWVfKiB3aXRoIHRoZSB3cm9uZyBhZGRyZXNzIG9yIHNp
emUgaW4gdGhlIGZpcnN0Cj4+Pj4gcGxhY2UuCj4+Pj4KPj4+IFRoaXMgY29uZGl0aW9uIHdvdWxk
IGFyaXNlIG9ubHkgaWYgZHJpdmVyIGNhbGxpbmcgZG1hX3VubWFwL2ZyZWVfKiAKPj4+IHdpdGgg
MAo+Pj4gaW92YV9wZm4uIFRoaXMgd2lsbCBiZSBmbGFnZ2VkIHdpdGggYSB3YXJuaW5nIGR1cmlu
ZyB1bm1hcCBidXQgd2lsbCAKPj4+IHRyaWdnZXIKPj4+IHBhbmljIGxhdGVyIG9uIHdoaWxlIGRv
aW5nIHVucmVsYXRlZCBkbWFfbWFwL3VubWFwXyouIElmIHVubWFwcGVkIGhhcyAKPj4+IGFscmVh
ZHkKPj4+IGZhaWxlZCBmb3IgaW52YWxpZCBpb3ZhLCB0aGVyZSBpcyBubyByZWFzb24gd2Ugc2hv
dWxkIGNvbnNpZGVyIHRoaXMgCj4+PiBhcyB2YWxpZAo+Pj4gaW92YSBhbmQgZnJlZS4gVGhpcyBw
YXJ0IHNob3VsZCBiZSBmaXhlZC4KPj4KPj4gSSBkaXNhZ3JlZS4gSW4gZ2VuZXJhbCwgaWYgZHJp
dmVycyBjYWxsIHRoZSBETUEgQVBJIGluY29ycmVjdGx5IGl0IGlzCj4+IGxpYWJsZSB0byBsZWFk
IHRvIGRhdGEgbG9zcywgbWVtb3J5IGNvcnJ1cHRpb24sIGFuZCB2YXJpb3VzIG90aGVyCj4+IHVu
cGxlYXNhbnQgbWlzYmVoYXZpb3VyIC0gaXQgaXMgbm90IHRoZSBETUEgbGF5ZXIncyBqb2IgdG8g
YXR0ZW1wdCB0bwo+PiBwYXBlciBvdmVyIGRyaXZlciBidWdzLgo+Pgo+PiBUaGVyZSAqaXMqIGFu
IGFyZ3VtZW50IGZvciBkb3duZ3JhZGluZyB0aGUgQlVHX09OKCkgaW4KPj4gaW92YV9tYWdhemlu
ZV9mcmVlX3BmbnMoKSB0byBhIFdBUk5fT04oKSwgc2luY2UgZnJhbmtseSBpdCBpc24ndCBhCj4+
IHN1ZmZpY2llbnRseSBzZXJpb3VzIGNvbmRpdGlvbiB0byBqdXN0aWZ5IGtpbGxpbmcgdGhlIHdo
b2xlIG1hY2hpbmUKPj4gaW1tZWRpYXRlbHksIGJ1dCBOQUsgdG8gYm9kZ2luZyB0aGUgaW9tbXUt
ZG1hIG1pZC1sYXllciB0byAiZml4IiB0aGF0Lgo+PiBBIHNlcmlvdXMgYnVnIGFscmVhZHkgaGFw
cGVuZWQgZWxzZXdoZXJlLCBzbyB0cnlpbmcgdG8gaGlkZSB0aGUKPj4gZmFsbG91dCByZWFsbHkg
ZG9lc24ndCBoZWxwIGFueW9uZS4KPj4KPiBTb3JyeSBmb3IgZGVsYXllZCByZXNwb25zZSwgaXQg
d2FzIGEgbG9uZyB3ZWVrZW5kLgo+IEkgYWdyZWUgdGhhdCBpbnZhbGlkIERNQSBBUEkgY2FsbCBj
YW4gcmVzdWx0IGluIHVuZXhwZWN0ZWQgaXNzdWVzIGFuZCAKPiBjbGllbnQKPiBzaG91bGQgZml4
IGl0LCBidXQgdGhlbiB0aGUgcHJlc2VudCBiZWhhdmlvciBtYWtlcyBpdCBkaWZmaWN1bHQgdG8g
Y2F0Y2ggCj4gY2FzZXMKPiB3aGVuIGRyaXZlciBpcyBtYWtpbmcgd3JvbmcgRE1BIEFQSSBjYWxs
cy4gV2hlbiBpbnZhbGlkIGlvdmEgcGZuIGlzIAo+IHBhc3NlZCBpdAo+IGRvZXNuJ3QgZmFpbCB0
aGVuIGFuZCB0aGVyZSwgdGhvdWdoIERNQSBsYXllciBpcyBhd2FyZSBvZiBpb3ZhIGJlaW5nIAo+
IGludmFsaWQuIEl0Cj4gZmFpbHMgbXVjaCBhZnRlciB0aGF0IGluIHRoZSBjb250ZXh0IG9mIGFu
IHZhbGlkIG1hcC91bm1hcCwgd2l0aCBCVUdfT04oKS4KPiAKPiBEb3duZ3JhZGluZyBCVUdfT04o
KSB0byBXQVJOX09OKCkgaW4gaW92YV9tYWdhemluZV9mcmVlX3BmbnMoKSB3aWxsIG5vdCAKPiBo
ZWxwCj4gbXVjaCBhcyBpbnZhbGlkIGlvdmEgd2lsbCBjYXVzZSBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UuCgpPYnZpb3VzbHkgSSBkaWRuJ3QgbWVhbiBhIGxpdGVyYWwgcy9CVUcvV0FSTi8gc3Vi
c3RpdHV0aW9uIC0gc29tZSAKYWRkaXRpb25hbCBjb250cm9sIGZsb3cgdG8gYWN0dWFsbHkgaGFu
ZGxlIHRoZSBlcnJvciBjYXNlIHdhcyBpbXBsaWVkLgoKSSdsbCB3cml0ZSB1cCB0aGUgcGF0Y2gg
bXlzZWxmLCBzaW5jZSBpdCdzIGVhc2llciB0aGFuIGZ1cnRoZXIgZGViYXRpbmcuCgo+IEkgc2Vl
IG5vIHJlYXNvbiB3aHkgRE1BIGxheWVyIHdhbnRzIHRvIGZyZWUgYW4gaW92YSBmb3Igd2hpY2gg
dW5tYXBwZWQgCj4gZmFpbGVkLgo+IElNSE8gcXVldWluZyBhbiBpbnZhbGlkIGlvdmEgKHdoaWNo
IGFscmVhZHkgZmFpbGVkIHVubWFwKSB0byByY2FjaGUgd2hpY2gKPiBldmVudHVhbGx5IGdvaW5n
IHRvIGNyYXNoIHRoZSBzeXN0ZW0gbG9va3MgbGlrZSBpb21tdS1kbWEgbGF5ZXIgaXNzdWUuCgpX
aGF0IGlmIHRoZSB1bm1hcCBmYWlscyBiZWNhdXNlIHRoZSBhZGRyZXNzIHJhbmdlIGlzIGFscmVh
ZHkgZW50aXJlbHkgCnVubWFwcGVkPyBGcmVlaW5nIHRoZSBJT1ZBIChvciBhdCBsZWFzdCBhdHRl
bXB0aW5nIHRvKSB3b3VsZCBiZSAKbG9naWNhbGx5IGFwcHJvcHJpYXRlIGluIHRoYXQgY2FzZS4g
SW4gZmFjdCBzb21lIElPTU1VIGRyaXZlcnMgbWlnaHQgbm90IApldmVuIGNvbnNpZGVyIHRoYXQg
YSBmYWlsdXJlLCBzbyB0aGUgRE1BIGxheWVyIG1heSBub3QgZXZlbiBiZSBhd2FyZSAKdGhhdCBp
dCdzIGJlZW4gaGFuZGVkIGEgYm9ndXMgdW5hbGxvY2F0ZWQgYWRkcmVzcy4KClRoZSBwb2ludCBp
cyB0aGF0IHVubWFwcGluZyAqZG9lc24ndCogZmFpbCB1bmRlciBub3JtYWwgYW5kIGNvcnJlY3Qg
Cm9wZXJhdGlvbiwgc28gdGhlIERNQSBsYXllciBzaG91bGQgbm90IGV4cGVjdCB0byBoYXZlIHRv
IGhhbmRsZSBpdC4gRXZlbiAKaWYgaXQgZG9lcyBoYXBwZW4sIHRoYXQncyBhIGhpZ2hseSBleGNl
cHRpb25hbCBjYXNlIHRoYXQgdGhlIERNQSBsYXllciAKY2Fubm90IHJlY292ZXIgZnJvbSBieSBp
dHNlbGY7IGF0IGJlc3QgaXQgY2FuIGp1c3QgcHVzaCB0aGUgcHJvYmxlbSAKZWxzZXdoZXJlLiBJ
dCdzIHByZXR0eSBoYXJkIHRvIGp1c3RpZnkgZG9pbmcgZXh0cmEgd29yayB0byBzaW1wbHkgbW92
ZSAKYW4gZXhjZXB0aW9uYWwgcHJvYmxlbSBhcm91bmQgd2l0aG91dCByZWFsbHkgYWRkcmVzc2lu
ZyBpdC4KCkFuZCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSwgcGVyc29uYWxseSBJIHdvdWxkICpt
dWNoKiByYXRoZXIgc2VlIAp3YXJuaW5ncyBzcGV3aW5nIGZyb20gYm90aCB0aGUgcGFnZXRhYmxl
IGFuZCBJT1ZBIGNvZGUgYXMgZWFybHkgYXMgCnBvc3NpYmxlIHRvIGNsZWFybHkgaW5kaWNhdGUg
dGhhdCB0aGUgRE1BIGxheWVyIGl0c2VsZiBoYXMgYmVlbiB0aHJvd24gCm91dCBvZiBzeW5jLCB0
aGFuIGp1c3QgaGF2ZSB3YXJuaW5ncyB0aGF0IG1pZ2h0IHJlcHJlc2VudCBzb21lIG90aGVyIApz
b3VyY2Ugb2YgcGFnZXRhYmxlIGNvcnJ1cHRpb24gKG9yIGF0IHdvcnN0LCBkZXBlbmRpbmcgb24g
dGhlIHBhZ2V0YWJsZSAKY29kZSwgbm8gd2FybmluZ3MgYXQgYWxsIGFuZCBvbmx5IGhhdmUgZG1h
X21hcF8qKCkgY2FsbHMgcXVpZXRseSBzdGFydCAKZmFpbGluZyBtdWNoLCBtdWNoIGxhdGVyIGR1
ZSB0byBhbGwgdGhlIElPVkEgc3BhY2UgaGF2aW5nIGJlZW4gbGVha2VkIGJ5IApiYWQgdW5tYXBz
KS4KClJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
