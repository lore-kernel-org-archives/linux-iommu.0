Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CBC433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 17:29:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1DB2311F
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1DB2311F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F054086EA5;
	Tue, 12 Jan 2021 17:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OS5ufgWg-2sO; Tue, 12 Jan 2021 17:29:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D3D786E6E;
	Tue, 12 Jan 2021 17:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC64FC088B;
	Tue, 12 Jan 2021 17:29:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDC3AC013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 17:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9BDD220387
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 17:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y9Q+Hrb3cPHk for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 17:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 8FD7020352
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 17:29:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83E6B1063;
 Tue, 12 Jan 2021 09:29:21 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BC073F719;
 Tue, 12 Jan 2021 09:29:20 -0800 (PST)
Subject: Re: [PATCH] iommu: check for the deferred attach when attaching a
 device
To: lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
References: <20201226053959.4222-1-lijiang@redhat.com>
 <33b6f925-71e6-5d9e-74c3-3e1eaf13398e@redhat.com>
 <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8273ce28-5ba6-2a39-5073-ec0f2b12dd2f@arm.com>
Date: Tue, 12 Jan 2021 17:29:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b385db3b-4506-6d75-49e1-e11064e65d6a@redhat.com>
Content-Language: en-GB
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 iommu@lists.linux-foundation.org, jroedel@suse.de, will@kernel.org
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

T24gMjAyMS0wMS0wNSAwNzo1MiwgbGlqaWFuZyB3cm90ZToKPiDlnKggMjAyMeW5tDAx5pyIMDXm
l6UgMTE6NTUsIGxpamlhbmcg5YaZ6YGTOgo+PiBIaSwKPj4KPj4gQWxzbyBhZGQgSm9lcmcgdG8g
Y2MgbGlzdC4KPj4KPiAKPiBBbHNvIGFkZCBtb3JlIHBlb3BsZSB0byBjYyBsaXN0LCBKZXJyeSBT
bml0c2VsYWFyIGFuZCBUb20gTGVuZGFja3kuCj4gCj4gVGhhbmtzLgo+IAo+PiBUaGFua3MuCj4+
IExpYW5ibwo+PiDlnKggMjAyMOW5tDEy5pyIMjbml6UgMTM6MzksIExpYW5ibyBKaWFuZyDlhpnp
gZM6Cj4+PiBDdXJyZW50bHksIGJlY2F1c2UgZG9tYWluIGF0dGFjaCBhbGxvd3MgdG8gYmUgZGVm
ZXJyZWQgZnJvbSBpb21tdQo+Pj4gZHJpdmVyIHRvIGRldmljZSBkcml2ZXIsIGFuZCB3aGVuIGlv
bW11IGluaXRpYWxpemVzLCB0aGUgZGV2aWNlcwo+Pj4gb24gdGhlIGJ1cyB3aWxsIGJlIHNjYW5u
ZWQgYW5kIHRoZSBkZWZhdWx0IGdyb3VwcyB3aWxsIGJlIGFsbG9jYXRlZC4KPj4+Cj4+PiBEdWUg
dG8gdGhlIGFib3ZlIGNoYW5nZXMsIHNvbWUgZGV2aWNlcyBjb3VsZCBiZSBhZGRlZCB0byB0aGUg
c2FtZQo+Pj4gZ3JvdXAgYXMgYmVsb3c6Cj4+Pgo+Pj4gWyAgICAzLjg1OTQxN10gcGNpIDAwMDA6
MDE6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE2Cj4+PiBbICAgIDMuODY0NTcyXSBwY2kg
MDAwMDowMTowMC4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMTYKPj4+IFsgICAgMy44Njk3Mzhd
IHBjaSAwMDAwOjAyOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxNwo+Pj4gWyAgICAzLjg3
NDg5Ml0gcGNpIDAwMDA6MDI6MDAuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDE3Cj4+Pgo+Pj4g
QnV0IHdoZW4gYXR0YWNoaW5nIHRoZXNlIGRldmljZXMsIGl0IGRvZXNuJ3QgYWxsb3cgdGhhdCBh
IGdyb3VwIGhhcwo+Pj4gbW9yZSB0aGFuIG9uZSBkZXZpY2UsIG90aGVyd2lzZSBpdCB3aWxsIHJl
dHVybiBhbiBlcnJvci4gVGhpcyBjb25mbGljdHMKPj4+IHdpdGggdGhlIGRlZmVycmVkIGF0dGFj
aGluZy4gVW5mb3J0dW5hdGVseSwgaXQgaGFzIHR3byBkZXZpY2VzIGluIHRoZQo+Pj4gc2FtZSBn
cm91cCBmb3IgbXkgc2lkZSwgZm9yIGV4YW1wbGU6Cj4+Pgo+Pj4gWyAgICA5LjYyNzAxNF0gaW9t
bXVfZ3JvdXBfZGV2aWNlX2NvdW50KCk6IGRldmljZSBuYW1lWzBdOjAwMDA6MDE6MDAuMAo+Pj4g
WyAgICA5LjYzMzU0NV0gaW9tbXVfZ3JvdXBfZGV2aWNlX2NvdW50KCk6IGRldmljZSBuYW1lWzFd
OjAwMDA6MDE6MDAuMQo+Pj4gLi4uCj4+PiBbICAgMTAuMjU1NjA5XSBpb21tdV9ncm91cF9kZXZp
Y2VfY291bnQoKTogZGV2aWNlIG5hbWVbMF06MDAwMDowMjowMC4wCj4+PiBbICAgMTAuMjYyMTQ0
XSBpb21tdV9ncm91cF9kZXZpY2VfY291bnQoKTogZGV2aWNlIG5hbWVbMV06MDAwMDowMjowMC4x
Cj4+Pgo+Pj4gRmluYWxseSwgd2hpY2ggY2F1c2VkIHRoZSBmYWlsdXJlIG9mIHRnMyBkcml2ZXIg
d2hlbiB0ZzMgZHJpdmVyIGNhbGxzCj4+PiB0aGUgZG1hX2FsbG9jX2NvaGVyZW50KCkgdG8gYWxs
b2NhdGUgY29oZXJlbnQgbWVtb3J5IGluIHRoZSB0ZzNfdGVzdF9kbWEoKS4KPj4+Cj4+PiBbICAg
IDkuNjYwMzEwXSB0ZzMgMDAwMDowMTowMC4wOiBETUEgZW5naW5lIHRlc3QgZmFpbGVkLCBhYm9y
dGluZwo+Pj4gWyAgICA5Ljc1NDA4NV0gdGczOiBwcm9iZSBvZiAwMDAwOjAxOjAwLjAgZmFpbGVk
IHdpdGggZXJyb3IgLTEyCj4+PiBbICAgIDkuOTk3NTEyXSB0ZzMgMDAwMDowMTowMC4xOiBETUEg
ZW5naW5lIHRlc3QgZmFpbGVkLCBhYm9ydGluZwo+Pj4gWyAgIDEwLjA0MzA1M10gdGczOiBwcm9i
ZSBvZiAwMDAwOjAxOjAwLjEgZmFpbGVkIHdpdGggZXJyb3IgLTEyCj4+PiBbICAgMTAuMjg4OTA1
XSB0ZzMgMDAwMDowMjowMC4wOiBETUEgZW5naW5lIHRlc3QgZmFpbGVkLCBhYm9ydGluZwo+Pj4g
WyAgIDEwLjMzNDA3MF0gdGczOiBwcm9iZSBvZiAwMDAwOjAyOjAwLjAgZmFpbGVkIHdpdGggZXJy
b3IgLTEyCj4+PiBbICAgMTAuNTc4MzAzXSB0ZzMgMDAwMDowMjowMC4xOiBETUEgZW5naW5lIHRl
c3QgZmFpbGVkLCBhYm9ydGluZwo+Pj4gWyAgIDEwLjYyMjYyOV0gdGczOiBwcm9iZSBvZiAwMDAw
OjAyOjAwLjEgZmFpbGVkIHdpdGggZXJyb3IgLTEyCj4+Pgo+Pj4gSW4gYWRkaXRpb24sIHRoZSBz
aW1pbGFyIHNpdHVhdGlvbnMgYWxzbyBvY2N1ciBpbiBvdGhlciBkcml2ZXJzIHN1Y2gKPj4+IGFz
IHRoZSBibnh0X2VuIGRyaXZlci4gVGhhdCBjYW4gYmUgcmVwcm9kdWNlZCBlYXNpbHkgaW4ga2R1
bXAga2VybmVsCj4+PiB3aGVuIFNNRSBpcyBhY3RpdmUuCj4+Pgo+Pj4gQWRkIGEgY2hlY2sgZm9y
IHRoZSBkZWZlcnJlZCBhdHRhY2ggaW4gdGhlIGlvbW11X2F0dGFjaF9kZXZpY2UoKSBhbmQKPj4+
IGFsbG93IHRvIGF0dGFjaCB0aGUgZGVmZXJyZWQgZGV2aWNlIHJlZ2FyZGxlc3Mgb2YgaG93IG1h
bnkgZGV2aWNlcwo+Pj4gYXJlIGluIGEgZ3JvdXAuCgpJcyB0aGlzIGlvbW11X2F0dGFjaF9kZXZp
Y2UoKSBjYWxsIGlzIGNvbWluZyBmcm9tIGlvbW11LWRtYT8gKGlmIG5vdCwgCnRoZW4gd2hvZXZl
cidzIGNhbGxpbmcgaXQgcHJvYmFibHkgc2hvdWxkbid0IGJlKQoKQXNzdW1pbmcgc28sIHRoZW4g
cHJvYmFibHkgd2hhdCBzaG91bGQgaGFwcGVuIGlzIHRvIG1vdmUgdGhlIGhhbmRsaW5nIApjdXJy
ZW50bHkgaW4gaW9tbXVfZG1hX2RlZmVycmVkX2F0dGFjaCgpIGludG8gdGhlIGNvcmUgc28gdGhh
dCBpdCBjYW4gCmNhbGwgX19pb21tdV9hdHRhY2hfZGV2aWNlKCkgZGlyZWN0bHkgLSB0aGUgaW50
ZW50IGlzIGp1c3QgdG8gcmVwbGF5IAp0aGF0IGV4YWN0IGNhbGwgc2tpcHBlZCBpbiBpb21tdV9n
cm91cF9hZGRfZGV2aWNlKCksIHNvIHRoZSBsZWdhY3kgCmV4dGVybmFsIGlvbW11X2F0dGFjaF9k
ZXZpY2UoKSBpbnRlcmZhY2UgaXNuJ3QgcmVhbGx5IHRoZSByaWdodCB0b29sIGZvciAKdGhlIGpv
YiBhbnl3YXkuIFRoYXQncyBqdXN0IHNsaWdodGx5IGF3a3dhcmQgc2luY2UgaWRlYWxseSBpdCB3
YW50cyB0byAKYmUgZG9uZSBpbiBhIHdheSB0aGF0IGRvZXNuJ3QgcmVzdWx0IGluIGEgcmVkdW5k
YW50IG91dC1vZi1saW5lIGNhbGwgZm9yIAoha2R1bXAuCgpBbHRlcm5hdGl2ZWx5IEkgc3VwcG9z
ZSBpdCAqY291bGQqIGp1c3QgY2FsbCBvcHMtPmF0dGFjaF9kZXYgZGlyZWN0bHksIApidXQgdGhl
biB3ZSBtaXNzIG91dCBvbiB0aGUgdHJhY2Vwb2ludCwgYW5kIGRlZmVycmVkIGF0dGFjaCBpcyBh
cmd1YWJseSAKb25lIG9mIHRoZSBjYXNlcyB3aGVyZSB0aGF0J3MgbW9zdCB1c2VmdWwgOi8KClJv
YmluLgoKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0
LmNvbT4KPj4+IC0tLQo+Pj4gICBkcml2ZXJzL2lvbW11L2lvbW11LmMgfCA1ICsrKystCj4+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5j
Cj4+PiBpbmRleCBmZmVlYmRhOGQ2ZGUuLmRjY2FiN2IxMzNmYiAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+PiBA
QCAtMTk2Nyw4ICsxOTY3LDExIEBAIGludCBpb21tdV9hdHRhY2hfZGV2aWNlKHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbiwgc3RydWN0IGRldmljZSAqZGV2KQo+Pj4gICAJICovCj4+PiAgIAlt
dXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwo+Pj4gICAJcmV0ID0gLUVJTlZBTDsKPj4+IC0JaWYg
KGlvbW11X2dyb3VwX2RldmljZV9jb3VudChncm91cCkgIT0gMSkKPj4+ICsJaWYgKCFpb21tdV9p
c19hdHRhY2hfZGVmZXJyZWQoZG9tYWluLCBkZXYpICYmCj4+PiArCSAgICBpb21tdV9ncm91cF9k
ZXZpY2VfY291bnQoZ3JvdXApICE9IDEpIHsKPj4+ICsJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoZGV2
LCAiR3JvdXAgaGFzIG1vcmUgdGhhbiBvbmUgZGV2aWNlXG4iKTsKPj4+ICAgCQlnb3RvIG91dF91
bmxvY2s7Cj4+PiArCX0KPj4+ICAgCj4+PiAgIAlyZXQgPSBfX2lvbW11X2F0dGFjaF9ncm91cChk
b21haW4sIGdyb3VwKTsKPj4+ICAgCj4+Pgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gaW9tbXUgbWFpbGluZyBsaXN0Cj4gaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
