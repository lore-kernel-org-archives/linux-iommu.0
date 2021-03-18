Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E5C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 23:35:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B89164F33
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 23:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B89164F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D1E8400EF;
	Thu, 18 Mar 2021 23:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMoIkf-t05Fx; Thu, 18 Mar 2021 23:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 113DD400A7;
	Thu, 18 Mar 2021 23:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD4ACC000B;
	Thu, 18 Mar 2021 23:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 911F5C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 23:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C5E5400F1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 23:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyvX4d-llaem for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 23:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01438400EC
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 23:35:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6D4ED1;
 Thu, 18 Mar 2021 16:35:08 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D49F3F792;
 Thu, 18 Mar 2021 16:35:06 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
 <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
 <16d1c66f-5451-2515-af73-a6b44d996e92@arm.com>
 <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3dd81519-4a73-efb8-abf0-0b766f993a8b@arm.com>
Date: Thu, 18 Mar 2021 23:35:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a8a05321-3fd0-d1c4-9d76-ec2e79e310ec@gmail.com>
Content-Language: en-GB
Cc: opendmb@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mike Kravetz <mike.kravetz@oracle.com>
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

T24gMjAyMS0wMy0xOCAyMTozMSwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPiAKPiAKPiBPbiAz
LzE4LzIwMjEgMTI6NTMgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMS0wMy0xOCAx
OTo0MywgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMy8xOC8yMDIxIDEy
OjM0IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gT24gMjAyMS0wMy0xOCAxOToyMiwgRmxv
cmlhbiBGYWluZWxsaSB3cm90ZToKPj4+Pj4KPj4+Pj4KPj4+Pj4gT24gMy8xOC8yMDIxIDEyOjE4
IFBNLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+Pj4+Pj4gSXQgbWF5IGJlIHVzZWZ1bCB0byBk
aXNhYmxlIHRoZSBTV0lPVExCIGNvbXBsZXRlbHkgZm9yIHRlc3Rpbmcgb3IKPj4+Pj4+IHdoZW4g
YQo+Pj4+Pj4gcGxhdGZvcm0gaXMga25vd24gbm90IHRvIGhhdmUgYW55IERSQU0gYWRkcmVzc2lu
ZyBsaW1pdGF0aW9ucyB3aGF0IHNvCj4+Pj4+PiBldmVyLgo+Pj4+Cj4+Pj4gSXNuJ3QgdGhhdCB3
aGF0ICJzd2lvdGxiPW5vZm9yY2UiIGlzIGZvcj8gSWYgeW91J3JlIGNvbmZpZGVudCB0aGF0IHdl
J3ZlCj4+Pj4gcmVhbGx5IGlyb25lZCBvdXQgKmFsbCogdGhlIGF3a3dhcmQgY29ybmVycyB0aGF0
IHVzZWQgdG8gYmxvdyB1cCBpZgo+Pj4+IHZhcmlvdXMgaW50ZXJuYWwgYml0cyB3ZXJlIGxlZnQg
dW5pbml0aWFsaXNlZCwgdGhlbiBpdCB3b3VsZCBtYWtlIHNlbnNlCj4+Pj4gdG8ganVzdCB0d2Vh
ayB0aGUgaW1wbGVtZW50YXRpb24gb2Ygd2hhdCB3ZSBhbHJlYWR5IGhhdmUuCj4+Pgo+Pj4gc3dp
b3RsYj1ub2ZvcmNlIGRvZXMgcHJldmVudCBkbWFfZGlyZWN0X21hcF9wYWdlKCkgZnJvbSByZXNv
cnRpbmcgdG8gdGhlCj4+PiBzd2lvdGxiLCBob3dldmVyIHdoYXQgSSBhbSBhbHNvIGFmdGVyIGlz
IHJlY2xhaW1pbmcgdGhlc2UgNjRNQiBvZgo+Pj4gZGVmYXVsdCBTV0lPVExCIGJvdW5jZSBidWZm
ZXJpbmcgbWVtb3J5IGJlY2F1c2UgbXkgc3lzdGVtcyBydW4gd2l0aAo+Pj4gbGFyZ2UgYW1vdW50
cyBvZiByZXNlcnZlZCBtZW1vcnkgaW50byBaT05FX01PVkFCTEUgYW5kIGV2ZXJ5dGhpbmcgaW4K
Pj4+IFpPTkVfTk9STUFMIGlzIHByZWNpb3VzIGF0IHRoYXQgcG9pbnQuCj4+Cj4+IEl0IGFsc28g
Zm9yY2VzIGlvX3RsYl9uc2xhYnMgdG8gdGhlIG1pbmltdW0sIHNvIGl0IHNob3VsZCBiZSBjbGFp
bWluZwo+PiBjb25zaWRlcmFibHkgbGVzcyB0aGFuIDY0TUIuIElJUkMgdGhlIG9yaWdpbmFsIHBy
b3Bvc2FsICpkaWQqIHNraXAKPj4gaW5pdGlhbGlzYXRpb24gY29tcGxldGVseSwgYnV0IHRoYXQg
dHVybmVkIHVwIHRoZSBhZm9yZW1lbnRpb25lZCBpc3N1ZXMuCj4gCj4gQUZBSUNUIGluIHRoYXQg
Y2FzZSB3ZSB3aWxsIGhhdmUgaW90bGJfbl9zbGFicyB3aWxsIHNldCB0byAxLCB3aGljaCB3aWxs
Cj4gc3RpbGwgbWFrZSB1cyBhbGxvY2F0ZSBpb190bGJfbl9zbGFicyA8PCBJT19UTEJfU0hJRlQg
Ynl0ZXMgaW4KPiBzd2lvdGxiX2luaXQoKSwgd2hpY2ggc3RpbGwgZ2l2ZXMgdXMgNjRNQi4KCkVo
PyBXaGVuIGRpZCAyS0IgYmVjb21lIDY0TUI/IElPX1RMQl9TSElGVCBpcyAxMSwgc28gdGhhdCdz
IGF0IG1vc3Qgb25lIApwYWdlIGluIGFueW9uZSdzIG1vbmV5Li4uCgo+Pj4+IEkgd291bGRuJ3Qg
bmVjZXNzYXJpbHkgZGlzYWdyZWUgd2l0aCBhZGRpbmcgIm9mZiIgYXMgYW4gYWRkaXRpb25hbCBh
bGlhcwo+Pj4+IGZvciAibm9mb3JjZSIsIHRob3VnaCwgc2luY2UgaXQgZG9lcyBjb21lIGFjcm9z
cyBhcyBhIGJpdCB3YWNreSBmb3IKPj4+PiBnZW5lcmFsIHVzZS4KPj4+Pgo+Pj4+Pj4gU2lnbmVk
LW9mZi1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+Cj4+Pj4+Cj4+
Pj4+IENocmlzdG9waCwgaW4gYWRkaXRpb24gdG8gdGhpcyBjaGFuZ2UsIGhvdyB3b3VsZCB5b3Ug
ZmVlbCBpZiB3ZQo+Pj4+PiBxdWFsaWZpZWQgdGhlIHN3aW90bGJfaW5pdCgpIGluIGFyY2gvYXJt
L21tL2luaXQuYyB3aXRoIGE6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IGlmIChtZW1ibG9ja19lbmRfb2Zf
RFJBTSgpID49IFNaXzRHKQo+Pj4+PiAgwqDCoMKgwqDCoHN3aW90bGJfaW5pdCgxKQo+Pj4+Cj4+
Pj4gTW9kdWxvICJzd2lvdGxiPWZvcmNlIiwgb2YgY291cnNlIDspCj4+Pgo+Pj4gSW5kZWVkLCB3
ZSB3b3VsZCBuZWVkIHRvIGhhbmRsZSB0aGF0IGNhc2UgYXMgd2VsbC4gRG9lcyBpdCBzb3VuZAo+
Pj4gcmVhc29uYWJsZSB0byBkbyB0aGF0IHRvIHlvdSBhcyB3ZWxsPwo+Pgo+PiBJIHdvdWxkbid0
IGxpa2UgaXQgZG9uZSB0byBtZSBwZXJzb25hbGx5LCBidXQgZm9yIGFybTY0LCBvYnNlcnZlIHdo
YXQKPj4gbWVtX2luaXQoKSBpbiBhcmNoL2FybTY0L21tL2luaXQuYyBhbHJlYWR5IGRvZXMuCgpJ
biBmYWN0IEkgc2hvdWxkIGhhdmUgbG9va2VkIG1vcmUgY2xvc2VseSBhdCB0aGF0IG15c2VsZiAt
IGNoZWNraW5nIApkZWJ1Z2ZzIG9uIG15IDRHQiBhcm02NCBib2FyZCBhY3R1YWxseSBzaG93cyBp
b190bGJfbnNsYWJzID0gMCwgYW5kIAppbmRlZWQgd2UgYXJlIGJ5cGFzc2luZyBpbml0aWFsaXNh
dGlvbiBjb21wbGV0ZWx5IGFuZCAoYWIpdXNpbmcgClNXSU9UTEJfTk9fRk9SQ0UgdG8gY292ZXIg
aXQgdXAsIHNvIEkgZ3Vlc3MgaXQgcHJvYmFibHkgKmlzKiBzYWZlIG5vdyAKZm9yIHRoZSBub2Zv
cmNlIG9wdGlvbiB0byBkbyB0aGUgc2FtZSBmb3IgaXRzZWxmIGFuZCBzYXZlIGV2ZW4gdGhhdCBv
bmUgCnBhZ2UuCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
