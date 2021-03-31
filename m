Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB52C433DB
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 10:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B1E61952
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 10:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B1E61952
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA8316061F;
	Wed, 31 Mar 2021 10:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xASOVpx548BM; Wed, 31 Mar 2021 10:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A8B960638;
	Wed, 31 Mar 2021 10:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 773EEC000C;
	Wed, 31 Mar 2021 10:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5AFC000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08EC4606AE
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SgFBfwyhmkk7 for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 10:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2629A6061F
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 10:53:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84B5111B3;
 Wed, 31 Mar 2021 03:53:41 -0700 (PDT)
Received: from [10.57.24.208] (unknown [10.57.24.208])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32EC3F719;
 Wed, 31 Mar 2021 03:53:39 -0700 (PDT)
Subject: Re: [PATCH 3/6] iova: Allow rcache range upper limit to be
 configurable
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-4-git-send-email-john.garry@huawei.com>
 <26fb1b79-2e46-09f6-1814-48fec4205f32@arm.com>
 <3375b67f-438c-32d3-a5a6-7e08f37b04e3@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e2d873d9-3529-caff-d4ae-cca456857ff1@arm.com>
Date: Wed, 31 Mar 2021 11:53:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3375b67f-438c-32d3-a5a6-7e08f37b04e3@huawei.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
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

T24gMjAyMS0wMy0xOSAxNzoyNiwgSm9obiBHYXJyeSB3cm90ZToKWy4uLl0KPj4+IEBAIC0yNSw3
ICsyNSw4IEBAIHN0cnVjdCBpb3ZhIHsKPj4+IMKgIHN0cnVjdCBpb3ZhX21hZ2F6aW5lOwo+Pj4g
wqAgc3RydWN0IGlvdmFfY3B1X3JjYWNoZTsKPj4+IC0jZGVmaW5lIElPVkFfUkFOR0VfQ0FDSEVf
TUFYX1NJWkUgNsKgwqDCoCAvKiBsb2cgb2YgbWF4IGNhY2hlZCBJT1ZBIAo+Pj4gcmFuZ2Ugc2l6
ZSAoaW4gcGFnZXMpICovCj4+PiArI2RlZmluZSBJT1ZBX1JBTkdFX0NBQ0hFX0RFRkFVTFRfU0la
RSA2Cj4+PiArI2RlZmluZSBJT1ZBX1JBTkdFX0NBQ0hFX01BWF9TSVpFIDEwIC8qIGxvZyBvZiBt
YXggY2FjaGVkIElPVkEgcmFuZ2UgCj4+PiBzaXplIChpbiBwYWdlcykgKi8KPj4KPj4gTm8uCj4+
Cj4+IEFuZCB3aHk/IElmIHdlJ3JlIGdvaW5nIHRvIGFsbG9jYXRlIG1hc3NpdmUgY2FjaGVzIGFu
eXdheSwgd2hhdGV2ZXIgaXMgCj4+IHRoZSBwb2ludCBvZiAqbm90KiB1c2luZyBhbGwgb2YgdGhl
bT8KPj4KPiAKPiBJIHdhbnRlZCB0byBrZWVwIHRoZSBzYW1lIGVmZmVjdGl2ZSB0aHJlc2hvbGQg
Zm9yIGRldmljZXMgdG9kYXksIHVubGVzcyAKPiBzZXQgb3RoZXJ3aXNlLgo+IAo+IFRoZSByZWFz
b24gaXMgdGhhdCBJIGRpZG4ndCBrbm93IGlmIGEgYmxhbmtldCBpbmNyZWFzZSB3b3VsZCBjYXVz
ZSAKPiByZWdyZXNzaW9ucywgYW5kIEkgd2FzIHRha2luZyB0aGUgc3VwZXItc2FmZSByb2FkLiBT
cGVjaWZpY2FsbHkgc29tZSAKPiBzeXN0ZW1zIG1heSBiZSB2ZXJ5IElPVkEgc3BhY2UgbGltaXRl
ZCwgYW5kIGp1c3Qgd29yayB0b2RheSBieSBub3QgCj4gY2FjaGluZyBsYXJnZSBJT1ZBcy4KCmFs
bG9jX2lvdmFfZmFzdCgpIHdpbGwgYWxyZWFkeSBjbGVhciBvdXQgdGhlIGNhY2hlcyBpZiBzcGFj
ZSBpcyBydW5uaW5nIApsb3csIHNvIHRoZSBjYWNoaW5nIGl0c2VsZiBzaG91bGRuJ3QgYmUgYW4g
aXNzdWUuCgo+IEFuZCBpbiB0aGUgcHJlY3Vyc29yIHRocmVhZCB5b3Ugd3JvdGUgIldlIGNhbid0
IGFyYml0cmFyaWx5ICppbmNyZWFzZSogCj4gdGhlIHNjb3BlIG9mIGNhY2hpbmcgb25jZSBhIGRv
bWFpbiBpcyBhY3RpdmUgZHVlIHRvIHRoZSBzaXplLXJvdW5kaW5nLXVwIAo+IHJlcXVpcmVtZW50
LCB3aGljaCB3b3VsZCBiZSBwcm9oaWJpdGl2ZSB0byBsYXJnZXIgYWxsb2NhdGlvbnMgaWYgYXBw
bGllZCAKPiB1bml2ZXJzYWxseSIgKHNvcnJ5IGZvciBxdW90aW5nKQo+IAo+IEkgdG9vayB0aGUg
bGFzdCBwYXJ0IHRvIG1lYW4gdGhhdCB3ZSBzaG91bGRuJ3QgYXBwbHkgdGhpcyBpbmNyZWFzZSBp
biAKPiB0aHJlc2hvbGQgZ2xvYmFsbHkuCgpJIG1lYW50IHdlIGNhbid0IGluY3JlYXNlIHRoZSBj
YWNoaW5nIHRocmVzaG9sZCBhcy1pcyBvbmNlIHRoZSBkb21haW4gaXMgCmluIHVzZSwgYmVjYXVz
ZSB0aGF0IGNvdWxkIHJlc3VsdCBpbiBvZGQtc2l6ZWQgSU9WQXMgcHJldmlvdXNseSAKYWxsb2Nh
dGVkIGFib3ZlIHRoZSBvbGQgdGhyZXNob2xkIGJlaW5nIGxhdGVyIGZyZWVkIGJhY2sgaW50byBj
YWNoZXMsIAp0aGVuIGNhdXNpbmcgaGF2b2MgdGhlIG5leHQgdGltZSB0aGV5IGdldCBhbGxvY2F0
ZWQgKGJlY2F1c2UgdGhleSdyZSBub3QgCmFzIGJpZyBhcyB0aGUgYWN0dWFsIHNpemUgYmVpbmcg
YXNrZWQgZm9yKS4gSG93ZXZlciwgdHJ5aW5nIHRvIGFkZHJlc3MgCnRoYXQgYnkganVzdCBzaXpl
LWFsaWduaW5nIGV2ZXJ5dGhpbmcgZXZlbiBhYm92ZSB0aGUgY2FjaGluZyB0aHJlc2hvbGQgCmlz
IGxpYWJsZSB0byB3YXN0ZSB0b28gbXVjaCBzcGFjZSBvbiBJT1ZBLWNvbnN0cmFpbmVkIHN5c3Rl
bXMgKGUuZy4gYSAKc2luZ2xlIDRLIHZpZGVvIGZyYW1lIG1heSBiZSB+MzVNQiAtIHJvdW5kaW5n
IHRoYXQgdXAgdG8gNjRNQiBlYWNoIHRpbWUgCndvdWxkIGJlIGhhcmQgdG8ganVzdGlmeSkuCgpJ
dCBmb2xsb3dzIGZyb20gdGhhdCB0aGF0IHRoZXJlJ3MgcmVhbGx5IG5vIHBvaW50IGluIGRlY291
cGxpbmcgdGhlIApyb3VuZGluZy11cCB0aHJlc2hvbGQgZnJvbSB0aGUgYWN0dWFsIGNhY2hpbmcg
dGhyZXNob2xkIC0geW91IGdldCBhbGwgCnRoZSB3YXN0YWdlIChib3RoIElPVkEgc3BhY2UgYW5k
IGFjdHVhbCBtZW1vcnkgZm9yIHRoZSBjYWNoZSBhcnJheXMpIGZvciAKbm8gb2J2aW91cyBiZW5l
Zml0LgoKPj4gSXQgb25seSBtYWtlcyBzZW5zZSBmb3IgYSBjb25maWd1cmF0aW9uIGtub2IgdG8g
YWZmZWN0IHRoZSBhY3R1YWwgCj4+IHJjYWNoZSBhbmQgZGVwb3QgYWxsb2NhdGlvbnMgLSB0aGF0
IHdheSwgYmlnIGhpZ2gtdGhyb3VnaHB1dCBzeXN0ZW1zIAo+PiB3aXRoIHBsZW50eSBvZiBtZW1v
cnkgY2FuIHNwZW5kIGl0IG9uIGJldHRlciBwZXJmb3JtYW5jZSwgd2hpbGUgc21hbGwgCj4+IHN5
c3RlbXMgLSB0aGF0IG9mdGVuIG5lZWQgSU9NTVUgc2NhdHRlci1nYXRoZXIgcHJlY2lzZWx5ICpi
ZWNhdXNlKiAKPj4gbWVtb3J5IGlzIHRpZ2h0IGFuZCB0aHVzIGVhc2lseSBmcmFnbWVudGVkIC0g
ZG9uJ3QgaGF2ZSB0byBwYXkgdGhlIAo+PiAobm90IGluc2lnbmlmaWNhbnQpIGNvc3QgZm9yIGNh
Y2hlcyB0aGV5IGRvbid0IG5lZWQuCj4gCj4gU28gZG8geW91IHN1Z2dlc3QgdG8ganVzdCBtYWtl
IElPVkFfUkFOR0VfQ0FDSEVfTUFYX1NJWkUgYSBrY29uZmlnIG9wdGlvbj8KCkFnYWluLCBJJ20g
bGVzcyBjb252aW5jZWQgYnkgS2NvbmZpZyBzaW5jZSBJIGltYWdpbmUgbWFueSBwZW9wbGUgdHVu
aW5nIApzZXJ2ZXItY2xhc3Mgc3lzdGVtcyBmb3IgdGhlaXIgb3duIHBhcnRpY3VsYXIgd29ya2xv
YWRzIHdpbGwgYmUgcnVubmluZyAKc3RhbmRhcmQgZW50ZXJwcmlzZSBkaXN0cm9zLCBzbyBJIHRo
aW5rIGVuZC11c2VyLWFjY2Vzc2libGUga25vYnMgd2lsbCAKYmUgdGhlIG1vc3QgdmFsdWFibGUu
IFRoYXQncyBub3QgdG8gc2F5IHRoYXQgYSBLY29uZmlnIG9wdGlvbiB0byBzZXQgdGhlIApkZWZh
dWx0IHN0YXRlIG9mIGEgY29tbWFuZC1saW5lIG9wdGlvbiAoYXMgd2UgZG8gZWxzZXdoZXJlKSB3
b24ndCBiZSAKdXNlZnVsIGZvciBlbWJlZGRlZCB1c2VycywgY2xvdWQgcHJvdmlkZXJzLCBldGMu
LCBqdXN0IHRoYXQgSSdtIG5vdCBzdXJlIAppdCdzIHdvcnRoIGl0IGJlaW5nIHRoZSAqb25seSog
b3B0aW9uLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
