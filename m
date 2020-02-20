Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D8EC11D19
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1722467A
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1722467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7C43285693;
	Thu, 20 Feb 2020 18:42:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UQJLoeWhJQ0u; Thu, 20 Feb 2020 18:42:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C3CE84B36;
	Thu, 20 Feb 2020 18:42:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 160B1C1D81;
	Thu, 20 Feb 2020 18:42:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0E34C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 889C485F2F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UO9PcdovPdFE for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 18:42:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 67C98842E9
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:42:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7041E30E;
 Thu, 20 Feb 2020 10:42:29 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8FD3F6CF;
 Thu, 20 Feb 2020 10:42:28 -0800 (PST)
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
To: isaacm@codeaurora.org
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
 <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
 <7239ddd532e94a4371289f3be23c66a3@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <195d44d1-ff92-06fd-8ce8-75cd12d47c43@arm.com>
Date: Thu, 20 Feb 2020 18:42:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7239ddd532e94a4371289f3be23c66a3@codeaurora.org>
Content-Language: en-GB
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>
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

T24gMjAvMDIvMjAyMCA2OjM4IGFtLCBpc2FhY21AY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4gT24g
MjAyMC0wMi0xNyAwODowMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAxNC8wMi8yMDIwIDEx
OjA2IHBtLCBJc2FhYyBKLiBNYW5qYXJyZXMgd3JvdGU6Cj4+PiBGcm9tOiBMaWFtIE1hcmsgPGxt
YXJrQGNvZGVhdXJvcmEub3JnPgo+Pj4KPj4+IFVzaW5nIHRoZSBiZXN0LWZpdCBhbGdvcml0aG0s
IGluc3RlYWQgb2YgdGhlIGZpcnN0LWZpdAo+Pj4gYWxnb3JpdGhtLCBtYXkgcmVkdWNlIGZyYWdt
ZW50YXRpb24gd2hlbiBhbGxvY2F0aW5nCj4+PiBJT1ZBcy4KPj4KPj4gV2hhdCBraW5kIG9mIHBh
dGhvbG9naWNhbCBhbGxvY2F0aW9uIHBhdHRlcm5zIG1ha2UgdGhhdCBhIHNlcmlvdXMKPj4gcHJv
YmxlbT8gSXMgdGhlcmUgYW55IHNjb3BlIGZvciBzaW1wbHkgY2hhbmdpbmcgdGhlIG9yZGVyIG9m
IHRoaW5ncyBpbgo+PiB0aGUgY2FsbGVycz8gRG8gdGhlc2UgZHJpdmVycyBhbHNvIHJ1biB1bmRl
ciBvdGhlciBETUEgQVBJIGJhY2tlbmRzCj4+IChlLmcuIDMyLWJpdCBBcm0pPwo+Pgo+IFRoZSB1
c2VjYXNlcyB3aGVyZSB0aGUgSU9WQSBzcGFjZSBoYXMgYmVlbiBmcmFnbWVudGVkIGhhdmUgCj4g
bm9uLWRldGVybWluaXN0aWMgYWxsb2NhdGlvbgo+IHBhdHRlcm5zLCBhbmQgdGh1cywgaXQncyBu
b3QgZmVhc2libGUgdG8gY2hhbmdlIHRoZSBhbGxvY2F0aW9uIG9yZGVyIHRvIAo+IGF2b2lkIGZy
YWdtZW50aW5nCj4gdGhlIElPVkEgc3BhY2UuCgpXaGF0IGFib3V0IGNvbWJpbmluZyBzbWFsbGVy
IGJ1ZmZlcnMgaW50byBsYXJnZXIgaW5kaXZpZHVhbCBhbGxvY2F0aW9uczsgCmFueSBzY29wZSBm
b3IgdGhhdCBzb3J0IG9mIHRoaW5nPyBDZXJ0YWlubHkgaWYgeW91J3JlIGNvbnNpc3RlbnRseSAK
YWxsb2NhdGluZyBzbWFsbCB0aGluZ3MgbGVzcyB0aGFuIFBBR0VfU0laRSB0aGVuIERNQSBwb29s
cyB3b3VsZCBiZSAKdXNlZnVsIHRvIGF2b2lkIHdhbnRvbiBtZW1vcnkgd2FzdGFnZSBpbiBnZW5l
cmFsLgoKPiAgRnJvbSB3aGF0IHdlJ3ZlIG9ic2VydmVkLCB0aGUgdXNlY2FzZXMgaW52b2x2ZSBh
bGxvY2F0aW9ucyBvZiB0d28gdHlwZXMgb2YKPiBidWZmZXJzOiBvbmUgdHlwZSBvZiBidWZmZXIg
YmV0d2VlbiAxIEtCIHRvIDQgTUIgaW4gc2l6ZSwgYW5kIGFub3RoZXIgCj4gdHlwZSBvZgo+IGJ1
ZmZlciBiZXR3ZWVuIDEgS0IgdG8gNDAwIE1CIGluIHNpemUuCj4gCj4gVGhlIHBhdGhvbG9naWNh
bCBzY2VuYXJpb3Mgc2VlbSB0byBhcmlzZSB3aGVuIHRoZXJlIGFyZQo+IG1hbnkgKDEwMCspIHJh
bmRvbWx5IGRpc3RyaWJ1dGVkIG5vbi1wb3dlciBvZiB0d28gYWxsb2NhdGlvbnMsIHdoaWNoIGlu
IAo+IHNvbWUgY2FzZXMgbGVhdmVzCj4gYmVoaW5kIGhvbGVzIG9mIHVwIHRvIDEwMCsgTUIgaW4g
dGhlIElPVkEgc3BhY2UuCj4gCj4gSGVyZSBhcmUgc29tZSBleGFtcGxlcyB0aGF0IHNob3cgdGhl
IHN0YXRlIG9mIHRoZSBJT1ZBIHNwYWNlIHVuZGVyIHdoaWNoIAo+IGZhaWx1cmUgdG8KPiBhbGxv
Y2F0ZSBhbiBJT1ZBIHdhcyBvYnNlcnZlZDoKPiAKPiBJbnN0YW5jZSAxOgo+ICDCoMKgwqDCoEN1
cnJlbnRseSBtYXBwZWQgdG90YWwgc2l6ZSA6IH4xLjNHQgo+ICDCoMKgwqDCoEZyZWUgc3BhY2Ug
YXZhaWxhYmxlIDogfjJHQgo+ICDCoMKgwqDCoE1hcCBmb3IgfjE2Mk1CIGZhaWxzLgo+ICDCoMKg
wqDCoMKgwqDCoCBNYXggY29udGlndW91cyBzcGFjZSBhdmFpbGFibGUgOiA8IDE2Mk1CCj4gCj4g
SW5zdGFuY2UgMjoKPiAgwqDCoMKgwqBDdXJyZW50bHkgbWFwcGVkIHRvdGFsIHNpemUgOiB+OTUw
TUIKPiAgwqDCoMKgwqBGcmVlIHNwYWNlIGF2YWlsYWJsZSA6IH4yLjNHQgo+ICDCoMKgwqDCoE1h
cCBmb3IgfjMyME1CIGZhaWxzLgo+ICDCoMKgwqDCoE1heCBjb250aWd1b3VzIHNwYWNlIGF2YWls
YWJsZSA6IH4xODlNQgo+IAo+IEluc3RhbmNlIDM6Cj4gIMKgwqDCoMKgQ3VycmVudGx5IG1hcHBl
ZCB0b3RhbCBzaXplIDogfjEuMkdCCj4gIMKgwqDCoMKgRnJlZSBzcGFjZSBhdmFpbGFibGUgOiB+
Mi43R0IKPiAgwqDCoMKgwqBNYXAgZm9yIH4xNjJNQiBmYWlscy4KPiAgwqDCoMKgwqBNYXggY29u
dGlndW91cyBzcGFjZSBhdmFpbGFibGUgOiA8MTYyTUIKPiAKPiBXZSBhcmUgc3RpbGwgaW4gdGhl
IHByb2Nlc3Mgb2YgY29sbGVjdGluZyBkYXRhIHdpdGggdGhlIGJlc3QtZml0IAo+IGFsZ29yaXRo
bSBlbmFibGVkCj4gdG8gcHJvdmlkZSBzb21lIG51bWJlcnMgdG8gc2hvdyB0aGF0IGl0IHJlc3Vs
dHMgaW4gbGVzcyBJT1ZBIHNwYWNlCj4gZnJhZ21lbnRhdGlvbi4KClRoYW5rcyBmb3IgdGhvc2Ug
ZXhhbXBsZXMsIGFuZCBJJ2QgZGVmaW5pdGVseSBsaWtlIHRvIHNlZSB0aGUgCmNvbXBhcmF0aXZl
IGZpZ3VyZXMuIFRvIGRpZyBhIGJpdCBmdXJ0aGVyLCBhdCB0aGUgcG9pbnQgd2hlcmUgdGhpbmdz
IApzdGFydCBmYWlsaW5nLCB3aGVyZSBhcmUgdGhlIGNhY2hlZCBub2RlcyBwb2ludGluZz8gSUlS
QyB0aGVyZSBpcyBzdGlsbCAKYSBwYXRob2xvZ2ljYWwgY29uZGl0aW9uIHdoZXJlIGVtcHR5IHNw
YWNlIGJldHdlZW4gbGltaXRfcGZuIGFuZCAKY2FjaGVkMzJfbm9kZSBnZXRzICdsb3N0JyBpZiBu
b3RoaW5nIGluIGJldHdlZW4gaXMgZnJlZWQsIHNvIHRoZSBiaWdnZXIgCnRoZSByYW5nZSBvZiBh
bGxvY2F0aW9uIHNpemVzLCB0aGUgd29yc2UgdGhlIGVmZmVjdCwgZS5nLjoKCihjb25zaWRlcmlu
ZyBhbiBlbXB0eSBkb21haW4sIHBmbiAwICpub3QqIHJlc2VydmVkLCAzMi1iaXQgbGltaXRfcGZu
KQoKCWFsbG9jIDRLLCBzdWNjZWVkcywgY2FjaGVkMzJfbm9kZSBub3cgYXQgNEctNEsKCWFsbG9j
IDJHLCBzdWNjZWVkcywgY2FjaGVkMzJfbm9kZSBub3cgYXQgMAoJYWxsb2MgNEssIGZhaWxzIGRl
c3BpdGUgYWxtb3N0IDJHIGNvbnRpZ3VvdXMgZnJlZSBzcGFjZSB3aXRoaW4gbGltaXRfcGZuCgko
YW5kIG1heDMyX2FsbG9jX3NpemU9PTEgbm93IGZhc3QtZm9yd2FyZHMgKmFueSogZnVydGhlciBh
bGxvY2F0aW9uIAphdHRlbXB0IHRvIGZhaWx1cmUpCgpJZiB5b3UncmUgZmFsbGluZyBmb3VsIG9m
IHRoaXMgY2FzZSAoSSB3YXMgbmV2ZXIgc3VyZSBob3cgcmVhbGlzdGljIGEgCnByb2JsZW0gaXQg
d291bGQgYmUgaW4gcHJhY3RpY2UpLCB0aGVyZSBhcmUgYXQgbGVhc3QgYSBjb3VwbGUgb2YgbXVj
aCAKbGVzcyBpbnZhc2l2ZSB0d2Vha3MgSSBjYW4gdGhpbmsgb2YgdGhhdCB3b3VsZCBiZSB3b3J0
aCBleHBsb3JpbmcuCgo+IFRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uIGFib3V0IHdoZXRoZXIgaWYg
dGhpcyBkcml2ZXIgcnVuIHVuZGVyIG90aGVyIERNQSAKPiBBUEkgYmFja2VuZHM6Cj4geWVzLCBz
dWNoIGFzIDMyIGJpdCBBUk0uCgpPSywgdGhhdCdzIHdoYXQgSSBzdXNwZWN0ZWQgOikKCkFGQUlD
UyBhcmNoL2FybSdzIF9fYWxsb2NfaW92YSgpIGlzIGFsc28gYSBmaXJzdC1maXQgYWxnb3JpdGht
LCBzbyBpZiAKeW91IGdldCBiZXR0ZXIgYmVoYXZpb3VyIHRoZXJlIHRoZW4gaXQgd291bGQgc3Vn
Z2VzdCB0aGF0IHRoaXMgYXNwZWN0IAppc24ndCByZWFsbHkgdGhlIG1vc3QgaW1wb3J0YW50IGlz
c3VlLiBDZXJ0YWlubHksIHRoZSBmYWN0IHRoYXQgdGhlIAoiYmVzdCBmaXQiIGxvZ2ljIGhlcmUg
YWxzbyBoYXBwZW5zIHRvIGlnbm9yZSB0aGUgY2FjaGVkIG5vZGVzIGRvZXMgc3RhcnQgCmRyYXdp
bmcgbWUgYmFjayB0byB0aGUgcG9pbnQgYWJvdmUuCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
