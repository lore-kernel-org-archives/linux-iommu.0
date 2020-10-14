Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4958C433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 00:49:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557B9208B3
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 00:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557B9208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E1CB587BE5;
	Wed, 14 Oct 2020 00:49:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PotF-b7cm8H; Wed, 14 Oct 2020 00:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B580B87BE0;
	Wed, 14 Oct 2020 00:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ACF9C07FF;
	Wed, 14 Oct 2020 00:49:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC368C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 00:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BAED487BE5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 00:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zl0r6LfQhVcK for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 00:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7CB4887BE0
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 00:49:28 +0000 (UTC)
IronPort-SDR: nBiN7Iwwlq1tLfbJ3fCwz7sPnUxzWsf1AT08w7wZnmAMapyUNiXjfbaVrtp269fnzsuc5lQSnh
 awxtFItn3MrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166071067"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; d="scan'208";a="166071067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:49:27 -0700
IronPort-SDR: EQyEvoE5xNUocrAPDSycqv7YhanaNerWshx5/SaN1Q2YFJrB6woJaia/Rredc9yE3yjpN2hp1L
 Xr4uPZ/QyaWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; d="scan'208";a="345457248"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 13 Oct 2020 17:49:25 -0700
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20201013073055.11262-1-brgl@bgdev.pl>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
Date: Wed, 14 Oct 2020 08:42:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013073055.11262-1-brgl@bgdev.pl>
Content-Language: en-US
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

T24gMTAvMTMvMjAgMzozMCBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiBGcm9tOiBC
YXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+IAo+IFNpbmNl
IGNvbW1pdCBjNDBhYWFhYzEwMTggKCJpb21tdS92dC1kOiBHcmFjZWZ1bGx5IGhhbmRsZSBETUFS
IHVuaXRzCj4gd2l0aCBubyBzdXBwb3J0ZWQgYWRkcmVzcyB3aWR0aHMiKSBkbWFyLmMgbmVlZHMg
c3RydWN0IGlvbW11X2RldmljZSB0bwo+IGJlIHNlbGVjdGVkLiBXZSBjYW4gZHJvcCB0aGlzIGRl
cGVuZGVuY3kgYnkgbm90IGRlcmVmZXJlbmNpbmcgc3RydWN0Cj4gaW9tbXVfZGV2aWNlIGlmIElP
TU1VX0FQSSBpcyBub3Qgc2VsZWN0ZWQgYW5kIGJ5IHJldXNpbmcgdGhlIGluZm9ybWF0aW9uCj4g
c3RvcmVkIGluIGlvbW11LT5kcmhkLT5pZ25vcmVkIGluc3RlYWQuCj4gCj4gVGhpcyBmaXhlcyB0
aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yIHdoZW4gSU9NTVVfQVBJIGlzIG5vdCBzZWxlY3RlZDoK
PiAKPiBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzogSW4gZnVuY3Rpb24g4oCYZnJlZV9pb21t
deKAmToKPiBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzoxMTM5OjQxOiBlcnJvcjog4oCYc3Ry
dWN0IGlvbW11X2RldmljZeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmG9wc+KAmQo+ICAgMTEz
OSB8ICBpZiAoaW50ZWxfaW9tbXVfZW5hYmxlZCAmJiBpb21tdS0+aW9tbXUub3BzKSB7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiAKPiBGaXhl
czogYzQwYWFhYWMxMDE4ICgiaW9tbXUvdnQtZDogR3JhY2VmdWxseSBoYW5kbGUgRE1BUiB1bml0
cyB3aXRoIG5vIHN1cHBvcnRlZCBhZGRyZXNzIHdpZHRocyIpCj4gU2lnbmVkLW9mZi1ieTogQmFy
dG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KCldpdGggY29tbWl0
IHRpdGxlIGFkanVzdGVkIHRvICJpb21tdS92dC1kOiBEb24ndCBkZXJlZmVyZW5jZQppb21tdV9k
ZXZpY2UgaWYgSU9NTVVfQVBJIGlzIG5vdCBidWlsdCIsCgpBY2tlZC1ieTogTHUgQmFvbHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gLS0tCj4gICBk
cml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L2ludGVsL2RtYXIuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jCj4gaW5kZXggMmQ3MGQ1
NmQ4ZTBkLi40MDRiNDBhZjMxY2IgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9k
bWFyLmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYwo+IEBAIC0xMTM2LDcgKzEx
MzYsNyBAQCBzdGF0aWMgaW50IGFsbG9jX2lvbW11KHN0cnVjdCBkbWFyX2RyaGRfdW5pdCAqZHJo
ZCkKPiAgIAo+ICAgc3RhdGljIHZvaWQgZnJlZV9pb21tdShzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlv
bW11KQo+ICAgewo+IC0JaWYgKGludGVsX2lvbW11X2VuYWJsZWQgJiYgaW9tbXUtPmlvbW11Lm9w
cykgewo+ICsJaWYgKGludGVsX2lvbW11X2VuYWJsZWQgJiYgIWlvbW11LT5kcmhkLT5pZ25vcmVk
KSB7Cj4gICAJCWlvbW11X2RldmljZV91bnJlZ2lzdGVyKCZpb21tdS0+aW9tbXUpOwo+ICAgCQlp
b21tdV9kZXZpY2Vfc3lzZnNfcmVtb3ZlKCZpb21tdS0+aW9tbXUpOwo+ICAgCX0KPiAKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
