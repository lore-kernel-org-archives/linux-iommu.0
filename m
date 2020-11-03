Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B7C2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 21:53:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052E7223AB
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 21:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052E7223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 81A902107A;
	Tue,  3 Nov 2020 21:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBd1d4Up3NI9; Tue,  3 Nov 2020 21:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 623C7214E9;
	Tue,  3 Nov 2020 21:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416A6C088B;
	Tue,  3 Nov 2020 21:53:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FCDDC0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 21:53:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8450F86A11
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 21:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rq1+h9l1tN3f for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 21:53:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 44DD686A08
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 21:53:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B11A1474;
 Tue,  3 Nov 2020 13:53:33 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AE043F718;
 Tue,  3 Nov 2020 13:53:31 -0800 (PST)
Subject: Re: [PATCH v2 3/4] iommu/iova: Flush CPU rcache for when a depot fills
To: John Garry <john.garry@huawei.com>, "joro@8bytes.org" <joro@8bytes.org>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
 <1603733501-211004-4-git-send-email-john.garry@huawei.com>
 <65b568ef-ff2a-0993-e6f5-b6414b3b19f8@arm.com>
 <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d7611b01-ea16-bbaa-fcd1-d11dc872ce5d@arm.com>
Date: Tue, 3 Nov 2020 21:53:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d36fc7ec-cefa-0805-8036-3aea1c44fba2@huawei.com>
Content-Language: en-GB
Cc: Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>
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

T24gMjAyMC0xMS0wMyAxNzo1NiwgSm9obiBHYXJyeSB3cm90ZToKPj4+IFRvIHN1bW1hcml6ZSwg
dGhlIGlzc3VlIGlzIHRoYXQgYXMgdGltZSBnb2VzIGJ5LCB0aGUgQ1BVIHJjYWNoZSBhbmQgCj4+
PiBkZXBvdAo+Pj4gcmNhY2hlIGNvbnRpbnVlIHRvIGdyb3cuIEFzIHN1Y2gsIElPVkEgUkIgdHJl
ZSBhY2Nlc3MgdGltZSBhbHNvIAo+Pj4gY29udGludWVzCj4+PiB0byBncm93Lgo+Pgo+IAo+IEhp
IFJvYmluLAo+IAo+PiBJJ20gc3RydWdnbGluZyB0byBzZWUgaG93IHRoaXMgaXMgbm90IHNpbXBs
eSBpbmRpY2F0aXZlIG9mIGEgbGVhawo+PiBvcmlnaW5hdGluZyBlbHNld2hlcmUuIAo+IAo+IEl0
IHNvdW5kcyBsaWtlIG9uZSwgYnV0IEkgZG9uJ3QgdGhpbmsgaXQgaXMuCj4gCj4+IEZvciB0aGUg
bnVtYmVyIG9mIG1hZ2F6aW5lcyB0byBjb250aW51YWxseSBncm93LAo+PiBpdCBtZWFucyBJT1ZB
cyAqb2YgYSBwYXJ0aWN1bGFyIHNpemUqIGFyZSBiZWluZyBmcmVlZCBmYXN0ZXIgdGhhbiB0aGV5
Cj4+IGFyZSBiZWluZyBhbGxvY2F0ZWQsIHdoaWxlIHRoZSBvbmx5IHBsYWNlIHRoYXQgb25nb2lu
ZyBhbGxvY2F0aW9ucwo+PiBzaG91bGQgYmUgY29taW5nIGZyb20gaXMgdGhvc2Ugc2FtZSBtYWdh
emluZXMhCj4gCj4gQnV0IHRoYXQgaXMgbm90IHRoZSBuYXR1cmUgb2YgaG93IHRoZSBJT1ZBIGNh
Y2hpbmcgd29ya3MuIFRoZSBjYWNoZSBzaXplIAo+IGlzIG5vdCBkZWZpbmVkIGJ5IGhvdyBETUEg
bWFwcGluZ3Mgd2UgbWF5IGhhdmUgYXQgYSBnaXZlbiBtb21lbnQgaW4gdGltZSAKPiBvciBtYXhp
bXVtIHdoaWNoIHdlIGRpZCBoYXZlIGF0IGEgcG9pbnQgZWFybGllci4gSXQganVzdCBncm93cyB0
byBhIAo+IGxpbWl0IHRvIHdoZXJlIGFsbCBDUFUgYW5kIGdsb2JhbCBkZXBvdCByY2FjaGVzIGZp
bGwuCj4gCj4gSGVyZSdzIGFuIGFydGlmaWNpYWwgZXhhbXBsZSBvZiBob3cgdGhlIHJjYWNoZSBj
YW4gZ3JvdywgYnV0IEkgaG9wZSBjYW4gCj4gaGVscCBpbGx1c3RyYXRlOgo+IC0gY29uc2lkZXIg
YSBwcm9jZXNzIHdoaWNoIHdhbnRzIG1hbnkgRE1BIG1hcHBpbmcgYWN0aXZlIGF0IGEgZ2l2ZW4g
Cj4gcG9pbnQgaW4gdGltZQo+IC0gaWYgd2UgdGllIHRvIGNwdTAsIGNwdTAgcmNhY2hlIHdpbGwg
Z3JvdyB0byAxMjggKiAyCj4gLSB0aGVuIHRpZSB0byBjcHUxLCBjcHUxIHJjYWNoZSB3aWxsIGdy
b3cgdG8gMTI4ICogMiwgc28gdG90YWwgQ1BVIAo+IHJjYWNoZSA9IDIgKiAxMjggKiAyLiBDUFUg
cmNhY2hlIGZvciBjcHUwIGlzIG5vdCBmbHVzaGVkIC0gdGhlcmUgaXMgbm8gCj4gbWFpbnRlbmFu
Y2UgZm9yIHRoaXMuCj4gLSB0aGVuIHRpZSB0byBjcHUyLCBjcHUyIHJjYWNoZSB3aWxsIGdyb3cg
dG8gMTI4ICogMiwgc28gdG90YWwgQ1BVIAo+IHJjYWNoZSA9IDMgKiAxMjggKiAyCj4gLSB0aGVu
IGNwdTMsIGNwdTQsIGFuZCBzbyBvbi4KPiAtIFdlIGNhbiBkbyB0aGlzIGZvciBhbGwgQ1BVcyBp
biB0aGUgc3lzdGVtLCBzbyB0b3RhbCBDUFUgcmNhY2hlIGdyb3dzIAo+IGZyb20gemVybyAtPiAj
Q1BVcyAqIDEyOCAqIDIuIFlldCBubyBETUEgbWFwcGluZyBsZWFrcy4KCkkgZ2V0IHRoYXQuIFRo
YXQncyB0aGUgaW5pdGlhbCB3YXJtLXVwIHBoYXNlIEkgYWxsdWRlZCB0byBiZWxvdy4gSW4gYW4g
CmV2ZW4gc2ltcGxlciBleGFtcGxlLCBhbGxvY2F0aW5nIG9uIENQVSBBIGFuZCBmcmVlaW5nIG9u
IENQVSBCIHdpbGwgCmluZGVlZCBtb3ZlIElPVkFzIGZyb20gdGhlIHRyZWUgaW50byBtYWdhemlu
ZXMgd2l0aG91dCByZXVzZSwgYnV0IG9ubHkgCnVwIHRvIGEgcG9pbnQuIEV2ZW50dWFsbHksIENQ
VSBCJ3MgY2FjaGUgZmlsbHMgdXAgYW5kIHB1c2hlcyBhIG1hZ2F6aW5lIAppbnRvIHRoZSBkZXBv
dCwgYW5kIGF0ICp0aGF0KiBwb2ludCB0aGluZ3MgcmVhY2ggYSBzdGVhZHkgc3RhdGUsIHNpbmNl
IAp0aGUgbmV4dCBhbGxvY2F0aW9uIG9uIENQVSBBIHdpbGwgdGhlbiBwdWxsIHRoYXQgbWFnYXpp
bmUgZnJvbSB0aGUgZGVwb3QgCmFuZCBwcm9jZWVkIHRvIGFsbG9jYXRlIGZyb20gdGhlcmUuIElm
IGFsbG9jcyBhbmQgZnJlZXMgc3RheSBwZXJmZWN0bHkgCmJhbGFuY2VkLCB0aGUgd29ya2luZyBz
ZXQgaXMgdGhlbiAzIG1hZ2F6aW5lcy4gWWVzLCB0aGUgZGVwb3QgY2FuIGZpbGwgCnVwIGlmIHRo
ZSBudW1iZXIgb2YgSU9WQXMgdGhhdCBDUFUgQiBmcmVlcyBhdCBvbmNlIGJlZm9yZSBDUFUgQSAK
cmVhbGxvY2F0ZXMgdGhlbSBpcyBjb21wYXJhYmxlIHRvIHRoZSB0b3RhbCBkZXBvdCBjYXBhY2l0
eSwgYnV0IGl0IGNhbid0IApyZWFzb25hYmx5ICpzdGF5KiBmdWxsIHVubGVzcyBDUFUgQSBzdG9w
cyBhbGxvY2F0aW5nIGFsdG9nZXRoZXIuCgo+IFNvbWV0aGluZyBzaW1pbGFyIGNhbiBoYXBwZW4g
aW4gbm9ybWFsIHVzZSwgd2hlcmUgdGhlIHNjaGVkdWxlciAKPiByZWxvY2F0ZXMgcHJvY2Vzc2Vz
IGFsbCBvdmVyIHRoZSBDUFVzIGluIHRoZSBzeXN0ZW0gYXMgdGltZSBnb2VzIGJ5LCAKPiB3aGlj
aCBjYXVzZXMgdGhlIHRvdGFsIHJjYWNoZSBzaXplIHRvIGNvbnRpbnVlIHRvIGdyb3cuIEFuZCBp
biBhZGRpdGlvbiAKPiB0byB0aGlzLCB0aGUgZ2xvYmFsIGRlcG90IGNvbnRpbnVlcyB0byBncm93
IHZlcnkgc2xvd2x5IGFzIHdlbGwuIEJ1dCAKPiB3aGVuIGl0IGRvZXMgZmlsbCAodGhlIGdsb2Jh
bCBkZXBvdCwgdGhhdCBpcyksIGFuZCB3ZSBzdGFydCB0byBmcmVlIAo+IG1hZ2F6aW5lcyB0byBt
YWtlIHNwYWNlIOKAkyBhcyBpcyBjdXJyZW50IHBvbGljeSAtIHRoYXQncyB2ZXJ5IHNsb3cgYW5k
IAo+IGNhdXNlcyB0aGUgcGVyZm9ybWFuY2UgZHJvcC4KClN1cmUsIGJ1dCBob3cgZG9lcyBpdCB0
aGVuIGNvbnNpc3RlbnRseSAqcmVtYWluKiBpbiB0aGF0IHN0YXRlPyBBbmQgCip3aHkqIGRvZXMg
dGhlIGRlcG90IHNsb3dseSBhbmQgc3RlYWRpbHkgZ3JvdyBpbiB0aGUgZmlyc3QgcGxhY2UgaWYg
CmFsbG9jIGFuZCBmcmVlIGFyZSB1bHRpbWF0ZWx5IGJhbGFuY2VkPyBJIGNhbiBnZXQgdGhlIGRl
cG90IHN3aW5naW5nIApiZXR3ZWVuIGZ1bGwgYW5kIGVtcHR5IGlmIGl0J3Mgc2ltcGx5IHRvbyBz
bWFsbCB0byBib3VuY2UgbWFnYXppbmVzIApiZXR3ZWVuIGEgbGFyZ2UgbnVtYmVyIG9mICJDUFUg
QSJzIGFuZCAiQ1BVIEIicywgYnV0IGFnYWluLCB0aGF0J3MgCnN1cmVseSBnb2luZyB0byBzaG93
IGFzIHJlcGVhdGVkIHBlcmZvcm1hbmNlIHN3aW5ncyBiZXR3ZWVuIGJhZCBhdCBlYWNoIAplbmQg
YW5kIGdvb2QgaW4gdGhlIG1pZGRsZSwgbm90IGEgc3RlYWR5IGRlZ3JhZGF0aW9uLgoKPj4gTm93
IGluZGVlZCB0aGF0IGNvdWxkIGhhcHBlbiBvdmVyIHRoZSBzaG9ydCB0ZXJtIGlmIElPVkFzIGFy
ZSBhbGxvY2F0ZWQKPj4gYW5kIGZyZWVkIGFnYWluIGluIGdpYW50IGJhdGNoZXMgbGFyZ2VyIHRo
YW4gdGhlIHRvdGFsIGdsb2JhbCBjYWNoZQo+PiBjYXBhY2l0eSwgYnV0IHRoYXQgd291bGQgc2hv
dyBhIGN5Y2xpYyBiZWhhdmlvdXIgLSB3aGVuIGFjdGl2aXR5IHN0YXJ0cywKPj4gZXZlcnl0aGlu
ZyBpcyBmaXJzdCBhbGxvY2F0ZWQgc3RyYWlnaHQgZnJvbSB0aGUgdHJlZSwgdGhlbiB3aGVuIGl0
IGVuZHMKPj4gdGhlIGNhY2hlcyB3b3VsZCBnZXQgb3ZlcndoZWxtZWQgYnkgdGhlIGxhcmdlIGJ1
cnN0IG9mIGZyZWVpbmcgYW5kIHN0YXJ0Cj4+IGhhdmluZyB0byByZWxlYXNlIHRoaW5ncyBiYWNr
IHRvIHRoZSB0cmVlLCBidXQgZXZlbnR1YWxseSB0aGF0IHdvdWxkCj4+IHN0b3Agb25jZSBldmVy
eXRoaW5nICppcyogZnJlZWQsIHRoZW4gd2hlbiBhY3Rpdml0eSBiZWdpbnMgYWdhaW4gdGhlCj4+
IG5leHQgcm91bmQgb2YgYWxsb2NhdGluZyB3b3VsZCBpbmhlcmVudGx5IGNsZWFyIG91dCBhbGwg
dGhlIGNhY2hlcwo+PiBiZWZvcmUgZ29pbmcgYW55d2hlcmUgbmVhciB0aGUgdHJlZS4gCj4gCj4g
QnV0IHRoZXJlIGlzIG5vIGNsZWFyaW5nLiBBIENQVSB3aWxsIGtlZXAgdGhlIElPVkEgY2FjaGVk
IGluZGVmaW5pdGVseSwgCj4gZXZlbiB3aGVuIHRoZXJlIGlzIG5vIGFjdGl2ZSBETUEgbWFwcGlu
ZyBwcmVzZW50IGF0IGFsbC4KClN1cmUsIHRoZSBwZXJjcHUgY2FjaGVzIGNhbiBidWZmZXIgSU9W
QXMgZm9yIGFuIGluZGVmaW5pdGUgYW1vdW50IG9mIAp0aW1lIGRlcGVuZGluZyBvbiBob3cgbWFu
eSBDUFVzIGFyZSBhY3RpdmUsIGJ1dCB0aGUgZGVwb3QgdXNhZ2UgaXMgc3RpbGwgCmFic29sdXRl
bHkgcmVwcmVzZW50YXRpdmUgb2YgdGhlIHRvdGFsIHdvcmtpbmcgc2V0IGZvciB3aGljaGV2ZXIg
Q1BVcyAKKmFyZSogYWN0aXZlLiBJbiB0aGlzIHdob2xlIGRpc2N1c3Npb24gSSdtIGJhc2ljYWxs
eSBqdXN0IGNvbnNpZGVyaW5nIAp0aGUgcGVyY3B1IGNhY2hlcyBhcyBwaXBlbGluZSBzdGFnZXMg
Zm9yIHNlcmlhbGlzaW5nIElPVkFzIGludG8gYW5kIG91dCAKb2YgbWFnYXppbmVzLiBJdCdzIHRo
ZSBtb3Rpb24gb2YgbWFnYXppbmVzIHRoYXQncyB0aGUgaW50ZXJlc3RpbmcgcGFydC4KCklmIHRo
ZSBkZXBvdCBrZWVwcyBjb250aW51YWxseSBmaWxsaW5nIHVwLCAqc29tZSogQ1BVcyBhcmUgZnJl
ZWluZyAKZW5vdWdoIElPVkFzIHRvIHB1c2ggb3V0IGZ1bGwgbWFnYXppbmVzLCBhbmQgdGhvc2Ug
SU9WQXMgaGF2ZSB0byBjb21lIApmcm9tIHNvbWV3aGVyZSwgc28gKnNvbWUqIENQVXMgYXJlIGFs
bG9jYXRpbmcsIGFuZCB0aG9zZSBDUFVzIGNhbid0IAphbGxvY2F0ZSBmb3JldmVyIHdpdGhvdXQg
dGFraW5nIG1hZ2F6aW5lcyBiYWNrIG91dCBvZiB0aGUgZGVwb3QgKHRoYXQncyAKdGhlICJjbGVh
cmluZyBvdXQiIEkgbWVhbnQpLiBTb21ldGhpbmcgYWJvdXQgYSBzdGVhZHkgZGVncmFkYXRpb24g
dGhhdCAKbmV2ZXIgc2hvd3MgYW55IHNpZ24gb2YgcmVjb3ZlcnkgKGV2ZW4gcGVyaW9kaWNhbGx5
KSBqdXN0IGRvZXNuJ3Qgc2VlbSAKdG8gYWRkIHVwLgoKQW55d2F5LCBieSBub3cgSSB0aGluayBp
dCB3b3VsZCBiZSBtb3N0IGludGVyZXN0aW5nIHRvIGdldCByaWQgb2YgdGhpcyAKYm90dGxlbmVj
ayBjb21wbGV0ZWx5IHJhdGhlciB0aGFuIGRhbmNlIGFyb3VuZCBib2RnaW5nIGl0LCBhbmQgc2Vl
IHdoYXQgCmhhcHBlbnMgaWYgd2Ugc2ltcGx5IGxldCB0aGUgZGVwb3QgZ3JvdyB0byBmaXQgdGhl
IG1heGltdW0gd29ya2luZyBzZXQsIApzbyBJIGRpZCB0aGlzOgoKaHR0cHM6Ly9naXRsYWIuYXJt
LmNvbS9saW51eC1hcm0vbGludXgtcm0vLS9jb21taXRzL2lvbW11L2lvdmEKCk9ubHkgY29tcGls
ZS10ZXN0ZWQsIHNvIHByb2JhYmx5IGZ1bGwgb2YgdHJpdmlhbCBidWdzLCBidXQgSSdtIGN1cmlv
dXMgCnRvIHNlZSBpZiB0aGUgc2xpZ2h0IGV4dHJhIG92ZXJoZWFkIHRvIGRlcG90IG1hbmFnZW1l
bnQgaXMgbm90aWNlYWJsZSBpbiAKbm9ybWFsIGNhc2VzLgoKUm9iaW4uCgo+PiBUbyBtZSB0aGUg
InN0ZWFkeSBkZWNsaW5lIgo+PiBiZWhhdmlvdXIgc3VnZ2VzdHMgdGhhdCBzb21lb25lIHNvbWV3
aGVyZSBpcyBtYWtpbmcgRE1BIHVubWFwIGNhbGxzIHdpdGgKPj4gYSBzbWFsbGVyIHNpemUgdGhh
biB0aGV5IHdlcmUgbWFwcGVkIHdpdGggKHlvdSB0ZW5kIHRvIG5vdGljZSBpdCBxdWlja2VyCj4+
IHRoZSBvdGhlciB3YXkgcm91bmQgZHVlIHRvIGFsbCB0aGUgZGV2aWNlIGVycm9ycyBhbmQgcmFu
ZG9tIG1lbW9yeQo+PiBjb3JydXB0aW9uKSAtIGluIG1hbnkgY2FzZXMgdGhhdCB3b3VsZCBhcHBl
YXIgdG8gd29yayBvdXQgZmluZSBmcm9tIHRoZQo+PiBkcml2ZXIncyBwb2ludCBvZiB2aWV3LCBi
dXQgd291bGQgcHJvdm9rZSBleGFjdGx5IHRoaXMgYmVoYXZpb3VyIGluIHRoZQo+PiBJT1ZBIGFs
bG9jYXRvci4KPj4KPiAKPiBUaGFua3MsCj4gSm9obgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
