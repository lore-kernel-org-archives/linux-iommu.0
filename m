Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA2DC4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 10:00:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2801261206
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 10:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2801261206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D618B40323;
	Mon, 21 Jun 2021 10:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vrUU4PTpt2yc; Mon, 21 Jun 2021 10:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BDF84031D;
	Mon, 21 Jun 2021 10:00:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A6E7C0010;
	Mon, 21 Jun 2021 10:00:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A95C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D34996067A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D0EzaPITY4Pi for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:00:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDB3B6058F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 10:00:31 +0000 (UTC)
IronPort-SDR: OHeNhg2npmEvkgox9OiaRxH5iO6S3wfFqT3s7yF6xT5rnyllDlEbw1yMXZ+6eyQIHFMZbJeR+J
 BP2XcVeukbuw==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="203793170"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203793170"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 03:00:31 -0700
IronPort-SDR: sfKkS2pGcsLCq+ai4r7335G8stFAKnSGccjXqqvwZwqpJZTBJS97KEo/uX69xlsptIa9Osx+rb
 NK9JEsmx0yIw==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="452131304"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.249])
 ([10.254.211.249])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 03:00:27 -0700
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Message-ID: <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
Date: Mon, 21 Jun 2021 18:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

T24gMjAyMS82LzIxIDE2OjEyLCBKb2huIEdhcnJ5IHdyb3RlOgo+IE9uIDIxLzA2LzIwMjEgMDY6
MTcsIEx1IEJhb2x1IHdyb3RlOgo+PiBPbiAyMDIxLzYvMTggMTk6MzQsIEpvaG4gR2Fycnkgd3Jv
dGU6Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9pb21tdS5jCj4+PiBpbmRleCA2MGIxZWM0MmU3M2IuLmZmMjIxZDNkZGNiYyAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pb21t
dS5jCj4+PiBAQCAtMzQ5LDEwICszNDksOSBAQCBzdGF0aWMgaW50IF9faW5pdCBpb21tdV9kbWFf
c2V0dXAoY2hhciAqc3RyKQo+Pj4gwqAgfQo+Pj4gwqAgZWFybHlfcGFyYW0oImlvbW11LnN0cmlj
dCIsIGlvbW11X2RtYV9zZXR1cCk7Cj4+PiAtdm9pZCBpb21tdV9zZXRfZG1hX3N0cmljdChib29s
IHN0cmljdCkKPj4+ICt2b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KHZvaWQpCj4+PiDCoCB7Cj4+
PiAtwqDCoMKgIGlmIChzdHJpY3QgfHwgIShpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5F
X1NUUklDVCkpCj4+PiAtwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHN0cmljdDsK
Pj4+ICvCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4+PiDCoCB9Cj4+Cj4gCj4gSGkg
YmFvbHUsCgpIaSBKb2huLAoKPiAKPj4gU29ycnkgZm9yIHRoaXMgbGF0ZSBjb21tZW50Lgo+PiDC
oD4gTm9ybWFsbHkgdGhlIGNhY2hlIGludmFsaWRhdGlvbiBwb2xpY3kgc2hvdWxkIGNvbWUgZnJv
bSB0aGUgdXNlci4gV2UKPj4gaGF2ZSBwcmUtYnVpbGQga2VybmVsIG9wdGlvbiBhbmQgYWxzbyBh
IGtlcm5lbCBib290IGNvbW1hbmQgaW9tbXUuc3RyaWN0Cj4+IHRvIG92ZXJyaWRlIGl0LiBUaGVz
ZSBzZWVtIHJlYXNvbmFibGUuCj4+Cj4+IFdlIGFsc28gaGF2ZSBhIGhlbHBlciAoaW9tbXVfc2V0
X2RtYV9zdHJpY3QoKSkgc28gdGhhdCB0aGUgdmVuZG9yIGlvbW11Cj4+IGRyaXZlciBjb3VsZCBz
cXVlZXplIGluIGFuZCBjaGFuZ2UgdGhlIHByZXZpb3VzIHNldHRpbmdzIG1vc3RseSBkdWUgdG86
Cj4+Cj4+IGEpIHZlbmRvciBpb21tdSBkcml2ZXIgc3BlY2lmaWMga2VybmVsIGJvb3QgY29tbWFu
ZC4gKFdlIGFyZSBhYm91dCB0bwo+PiDCoMKgwqAgZGVwcmVjYXRlIHRob3NlLikKPj4KPj4gYikg
cXVpcmt5IGhhcmR3YXJlLgo+Pgo+PiBjKSBrZXJuZWwgb3B0aW1pemF0aW9uIChlLnguIHN0cmlj
dCBtb2RlIGluIFZNIGVudmlyb25tZW50KS4KPj4KPj4gYSkgYW5kIGIpIGFyZSBtYW5kYXRvcnks
IHdoaWxlIGMpIGlzIG9wdGlvbmFsLiBJbiBhbnkgaW5zdGFuY2Ugc2hvdWxkIGMpCj4+IG92ZXJy
aWRlIHRoZSBmbHVzaCBtb2RlIHNwZWNpZmllZCBieSB0aGUgdXNlci4gSGVuY2UsIHByb2JhYmx5
IHdlIHNob3VsZAo+PiBhbHNvIGhhdmUgYW5vdGhlciBoZWxwZXIgbGlrZToKPj4KPj4gdm9pZCBp
b21tdV9zZXRfZG1hX3N0cmljdF9vcHRpb25hbCgpCj4+IHsKPj4gwqDCoMKgwqDCoGlmICghKGlv
bW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkKPj4gwqDCoMKgwqDCoMKgwqDC
oCBpb21tdV9kbWFfc3RyaWN0ID0gdHJ1ZTsKPj4gfQo+Pgo+PiBBbnkgdGhvdWdodHM/Cj4gCj4g
V2hhdCB5b3UgYXJlIHN1Z2dlc3RpbmcgaXMgYSBjaGFuZ2UgaW4gcG9saWN5IGZyb20gbWFpbmxp
bmUgY29kZS4gCj4gQ3VycmVudGx5IGZvciBjKSB3ZSBhbHdheXMgc2V0IHN0cmljdCBlbmFibGVk
LCByZWdhcmRsZXNzIG9mIGFueSB1c2VyIAo+IGNtZGxpbmUgaW5wdXQuIEJ1dCBub3cgeW91IGFy
ZSBzYXlpbmcgdGhhdCB5b3Ugd2FudCBpb21tdS5zdHJpY3QgdG8gCj4gb3ZlcnJpZGUgaW4gcGFy
dGljdWxhciBzY2VuYXJpbywgcmlnaHQ/Cj4gCj4gSW4gdGhhdCBjYXNlIEkgd291bGQgdGhpbmsg
aXQncyBiZXR0ZXIgdG8gcmV3b3JrIHRoZSBjdXJyZW50IEFQSSwgbGlrZSAKPiBhZGRpbmcgYW4g
b3B0aW9uIHRvICJmb3JjZSIgc3RyaWN0IG1vZGU6Cj4gCj4gdm9pZCBpb21tdV9zZXRfZG1hX3N0
cmljdChib29sIGZvcmNlKQo+IHsKPiAgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZm9yY2UgPT0gdHJ1
ZSkKPiAgwqDCoMKgwqDCoMKgwqAgaW9tbXVfZG1hX3N0cmljdCA9IHRydWU7Cj4gIMKgwqDCoMKg
ZWxzZSBpZiAoIShpb21tdV9jbWRfbGluZSAmIElPTU1VX0NNRF9MSU5FX1NUUklDVCkpCj4gIMKg
wqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+IH0KPiAKPiBTbyB3ZSB3b3Vs
ZCB1c2UgaW9tbXVfc2V0X2RtYV9zdHJpY3QodHJ1ZSkgZm9yIGEpIGFuZCBiKSwgYnV0IAo+IGlv
bW11X3NldF9kbWFfc3RyaWN0KGZhbHNlKSBmb3IgYykuCgpZZXMuIFdlIG5lZWQgdG8gZGlzdGlu
Z3Vpc2ggdGhlICJtdXN0IiBhbmQgIm5pY2UtdG8taGF2ZSIgY2FzZXMgb2YKc2V0dGluZyBzdHJp
Y3QgbW9kZS4KCj4gCj4gVGhlbiBJIGFtIG5vdCBzdXJlIHdoYXQgeW91IHdhbnQgdG8gZG8gd2l0
aCB0aGUgYWNjb21wYW55aW5nIHByaW50IGZvciAKPiBjKS4gSXQgd2FzOgo+ICJJT01NVSBiYXRj
aGluZyBpcyBkaXNhYmxlZCBkdWUgdG8gdmlydHVhbGl6YXRpb24iCj4gCj4gQW5kIG5vdyBpcyBm
cm9tIHRoaXMgc2VyaWVzOgo+ICJJT01NVSBiYXRjaGluZyBkaXNhbGxvd2VkIGR1ZSB0byB2aXJ0
dWFsaXphdGlvbiIKPiAKPiBVc2luZyBpb21tdV9nZXRfZG1hX3N0cmljdChkb21haW4pIGlzIG5v
dCBhcHByb3ByaWF0ZSBoZXJlIHRvIGtub3cgdGhlIAo+IGN1cnJlbnQgbW9kZSAoc28gd2Uga25v
dyB3aGV0aGVyIHRvIHByaW50KS4KPiAKPiBOb3RlIHRoYXQgdGhpcyBjaGFuZ2Ugd291bGQgbWVh
biB0aGF0IHRoZSBjdXJyZW50IHNlcmllcyB3b3VsZCByZXF1aXJlIAo+IG5vbi10cml2aWFsIHJl
d29yaywgd2hpY2ggd291bGQgYmUgdW5mb3J0dW5hdGUgc28gbGF0ZSBpbiB0aGUgY3ljbGUuCgpU
aGlzIHBhdGNoIHNlcmllcyBsb29rcyBnb29kIHRvIG1lIGFuZCBJIGhhdmUgYWRkZWQgYnkgcmV2
aWV3ZWQtYnkuClByb2JhYmx5IHdlIGNvdWxkIG1ha2UgYW5vdGhlciBwYXRjaCBzZXJpZXMgdG8g
aW1wcm92ZSBpdCBzbyB0aGF0IHRoZQprZXJuZWwgb3B0aW1pemF0aW9uIHNob3VsZCBub3Qgb3Zl
cnJpZGUgdGhlIHVzZXIgc2V0dGluZy4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
