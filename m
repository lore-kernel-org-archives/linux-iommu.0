Return-Path: <SRS0=Veyj=Z6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F2C43603
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 06:27:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8987F20637
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 06:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8987F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CAEF8643B;
	Sun,  8 Dec 2019 06:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kWjkvyEi0c0; Sun,  8 Dec 2019 06:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0B0D86038;
	Sun,  8 Dec 2019 06:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC623C1D7E;
	Sun,  8 Dec 2019 06:27:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA83BC077D
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D151186479
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYAOy3uyxFoJ for <iommu@lists.linux-foundation.org>;
 Sun,  8 Dec 2019 06:27:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 56DE4855CF
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 06:27:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Dec 2019 22:27:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,291,1571727600"; d="scan'208";a="224454038"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 07 Dec 2019 22:26:59 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux-foundation.org, 
 Joerg Roedel <joro@8bytes.org>
References: <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
Date: Sun, 8 Dec 2019 14:26:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191207024118.uwwzthqifh2dca5q@cantor>
Content-Language: en-US
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

SGksCgpPbiAxMi83LzE5IDEwOjQxIEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIEZy
aSBEZWMgMDYgMTksIEplcnJ5IFNuaXRzZWxhYXIgd3JvdGU6Cj4+IE9uIFNhdCBEZWMgMDcgMTks
IEx1IEJhb2x1IHdyb3RlOgo+Pj4gSGkgSmVycnksCj4+Pgo+Pj4gT24gMTIvNi8xOSAzOjI0IFBN
LCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+Pj4+IE9uIEZyaSBEZWMgMDYgMTksIEx1IEJhb2x1
IHdyb3RlOgo+Pj4+IFtzbmlwXQo+Pj4+Pgo+Pj4+PiBDYW4geW91IHBsZWFzZSB0cnkgYmVsb3cg
Y2hhbmdlPyBMZXQncyBjaGVjayB3aGV0aGVyIHRoZSBhZmVuZGluZwo+Pj4+PiBhZGRyZXNzIGhh
cyBiZWVuIG1hcHBlZCBmb3IgZGV2aWNlIDAxLjAwLjIuCj4+Pj4+Cj4+Pj4+ICQgZ2l0IGRpZmYK
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
aW9tbXUuYwo+Pj4+PiBpbmRleCBkYjdiZmQ0ZjJkMjAuLmQ5ZGFmNjZiZTg0OSAxMDA2NDQKPj4+
Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW9tbXUuYwo+Pj4+PiBAQCAtNjYzLDYgKzY2Myw4IEBAIHN0YXRpYyBpbnQgCj4+Pj4+IGlvbW11
X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3Moc3RydWN0IGlvbW11X2dyb3VwICpncm91cCwK
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0g
aW9tbXVfbWFwKGRvbWFpbiwgYWRkciwgYWRkciwgcGdfc2l6ZSwgCj4+Pj4+IGVudHJ5LT5wcm90
KTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KHJldCkKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4+PiArCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mbyhkZXYsICJTZXR0aW5nIGlkZW50
aXR5IG1hcCBbMHglTHggCj4+Pj4+IC0gMHglTHhdIGZvciBncm91cCAlZFxuIiwgYWRkciwgYWRk
ciArIHBnX3NpemUsIGdyb3VwLT5pZCk7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+Pj4+Pgo+Pj4+PiDCoMKgwqDCoMKgwqAgfQo+Pj4+Pgo+Pj4+PiBJIGFtIGRvdWJ0aW5n
IHRoYXQgZGV2aWNlIDAxLjAwLjIgaXMgbm90IGluIHRoZSBkZXZpY2Ugc2NvcGUgb2YKPj4+Pj4K
Pj4+Pj4gW8KgwqDCoCA0LjQ4NTEwOF0gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMGJkZjZmMDAw
IGVuZDogMHgwMDAwMDBiZGY3ZWZmZgo+Pj4+Pgo+Pj4+PiBCeSB0aGUgd2F5LCBkb2VzIGRldmlj
ZSAwMS4wMC4yIHdvcmtzIHdlbGwgYWZ0ZXIgYmluZGluZyB0aGUgZHJpdmVyPwo+Pj4+Pgo+Pj4+
Cj4+Pj4gV2hlbiBJIGJvb3QgaXQgd2l0aCBwYXNzdGhyb3VnaCBpdCBkb2Vzbid0IGdldCB0byBh
IHBvaW50IHdoZXJlIEkgY2FuCj4+Pj4gbG9naW4uIEkgdGhpbmsgdGhlIHNlcmlhbCBjb25zb2xl
IG9uIHRoZXNlIHN5c3RlbXMgaXMgdGllZCB0byB0aGUgaWxvLAo+Pj4+IHNvIHRoZSBjb25zZXJ2
ZXIgY29ubmVjdGlvbiBjb3VsZCBiZSBtYWtpbmcgdGhpbmdzCj4+Pj4gd29yc2UuIFVuZm9ydHVu
YXRlbHkgdGhlIHN5c3RlbSBpcyByZW1vdGUuIEkgc2hvdWxkIGhhdmUgbW9yZSB0aW1lIG5vdwo+
Pj4+IHRvIGZvY3VzIG9uIGRlYnVnZ2luZyB0aGlzLgo+Pj4+Cj4+Pj4gQXR0YWNoaW5nIGNvbnNv
bGUgb3V0cHV0IGZvciB0aGUgYWJvdmUgcGF0Y2guCj4+Pgo+Pj4gSXQgc2VlbXMgdGhhdCBkZXZp
Y2UgMDEuMDAuMiBpc24ndCBpbiB0aGUgc2NvcGUgb2YgUk1SUiBbYmFzZToKPj4+IDB4MDAwMDAw
YmRmNmYwMDAgZW5kOiAweDAwMDAwMGJkZjdlZmZmXS4gQnV0IGl0IHN0aWxsIHRyaWVzIHRvIGFj
Y2Vzcwo+Pj4gdGhlIGFkZHJlc3Mgd2l0aGluIGl0LCBoZW5jZSBmYXVsdHMgZ2VuZXJhdGVkLgo+
Pj4KPj4+IFlvdSBjYW4gY2hlY2sgaXQgd2l0aCBBQ1BJL0RNQVIgdGFibGUuCj4+Pgo+Pj4gQmVz
dCByZWdhcmRzLAo+Pj4gYmFvbHUKPj4+Cj4+Cj4+IEkgYmVsaWV2ZSBpdCBpcyB0aGUgM3JkIGVu
ZHBvaW50IGRldmljZSBlbnRyeSBpbiBkbWFyIGRhdGEgYmVsb3cuCj4+IFNvIHF1ZXN0aW9uIGFi
b3V0IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2Rldi4gU2luY2UgYSBkbWEgbWFwcGluZwo+
PiBpcyBhbHJlYWR5IGRvbmUgZm9yIDEuMDAuMCwgYW5kIHRoYXQgc2V0cyB0aGUgZGVmYXVsdF9k
b21haW4gZm9yIHRoZQo+PiBncm91cCAoSSB0aGluayksIHdvbid0IGl0IGJhaWwgb3V0IGZvciAx
LjAwLjIgYXQgdGhpcyBjaGVjaz8KPj4KPj4gwqDCoMKgwqBpZiAoZ3JvdXAtPmRlZmF1bHRfZG9t
YWluICYmIGdyb3VwLT5kZWZhdWx0X2RvbWFpbi0+dHlwZSA9PSB0eXBlKQo+PiDCoMKgwqDCoMKg
wqDCoCBnb3RvIG91dDsKPj4KPiAKPiBPciBJIGd1ZXNzIHJlcXVlc3RfZGVmYXVsdF9kb21haW5f
Zm9yX2RldiB3b3VsZG4ndCBldmVuIGJlIGNhbGxlZCBmb3IgCj4gMS4wMC4yLgo+IGludGVsX2lv
bW11X2FkZF9kZXZpY2UgaXQgd291bGRuJ3QgZXZlbiBjYWxsIG9uZSBvZiB0aGUgcmVxdWVzdAo+
IGZ1bmN0aW9ucyB3aXRoIDEuMDAuMiBzaW5jZSBkb21haW4tPnR5cGUgd291bGQgYmUgZG1hIGZy
b20gMS4wMC4wLCBhbmQgCj4gZGV2aWNlX2RlZl9kb21haW5fdHlwZQo+IHNob3VsZCByZXR1cm4g
ZG1hLgoKQ2FuIHlvdSBwbGVhc2UgYWRkIHNvbWUgZGVidWcgbWVzc2FnZXMgYW5kIGNoZWNrIHdo
YXQgcmVhbGx5IGhhcHBlbnMKaGVyZT8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
