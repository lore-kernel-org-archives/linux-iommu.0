Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF88C35249
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 01:35:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DF320661
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 01:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DF320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7956C85531;
	Mon,  3 Feb 2020 01:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mGQJeAqGy3PN; Mon,  3 Feb 2020 01:35:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D39285361;
	Mon,  3 Feb 2020 01:35:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B4C1C1D81;
	Mon,  3 Feb 2020 01:35:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2947C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 01:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E18E420337
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 01:34:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrmZmA4ev2oR for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 01:34:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 7AE5120341
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 01:34:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Feb 2020 17:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,396,1574150400"; d="scan'208";a="334930684"
Received: from yxu39-mobl3.ccr.corp.intel.com (HELO [10.254.210.157])
 ([10.254.210.157])
 by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2020 17:34:54 -0800
Subject: Re: (new error in kernel 5.5) DMAR: [Firmware Bug]: No firmware
 reserved region can cover this RMRR
To: Thomas G <thomas.grudzien@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org
References: <CAJ9qOnVSKAeBst8KmOE3U+mnhwaTWYHi6+=z6054koX6QKA9EA@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7a147a10-c472-2fcd-b45f-215dd6c96b7c@linux.intel.com>
Date: Mon, 3 Feb 2020 09:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAJ9qOnVSKAeBst8KmOE3U+mnhwaTWYHi6+=z6054koX6QKA9EA@mail.gmail.com>
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

SGkgVGhvbWFzLAoKQmVsb3cgY29tbWl0IGlzIHN1cHBvc2VkIHRvIGZpeCB0aGlzIGlzc3VlLiBJ
dCdzIGN1cnJlbnRseSBpbgp4ODYvdnQtZCBicmFuY2ggb2YgdGhlIGlvbW11IHRyZWUsIGFuZCB3
aWxsIGJlIHBhcnQgb2YgdjUuNi1yYzEuCgpjb21taXQgZjVhNjhiYjA3NTJlMGNmNzdjMDZmNTNm
NzIyNThlN2JlYjQxMzgxYgpBdXRob3I6IEJhcnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4K
RGF0ZTogICBXZWQgSmFuIDE1IDExOjAzOjU2IDIwMjAgKzA4MDAKCiAgICAgaW9tbXUvdnQtZDog
TWFyayBmaXJtd2FyZSB0YWludGVkIGlmIFJNUlIgZmFpbHMgc2FuaXR5IGNoZWNrCgogICAgIFJN
UlIgZW50cmllcyBkZXNjcmliZSBtZW1vcnkgcmVnaW9ucyB0aGF0IGFyZSBETUEgdGFyZ2V0cyBm
b3IgZGV2aWNlcwogICAgIG91dHNpZGUgdGhlIGtlcm5lbCdzIGNvbnRyb2wuCgogICAgIFJNUlIg
ZW50cmllcyB0aGF0IGZhaWwgdGhlIHNhbml0eSBjaGVjayBhcmUgcG9pbnRpbmcgdG8gcmVnaW9u
cyBvZgogICAgIG1lbW9yeSB0aGF0IHRoZSBmaXJtd2FyZSBkaWQgbm90IHRlbGwgdGhlIGtlcm5l
bCBhcmUgcmVzZXJ2ZWQgb3IKICAgICBvdGhlcndpc2Ugc2hvdWxkIG5vdCBiZSB1c2VkLgoKICAg
ICBJbnN0ZWFkIG9mIGFib3J0aW5nIERNQVIgcHJvY2Vzc2luZywgdGhpcyBjb21taXQgbWFya3Mg
dGhlIGZpcm13YXJlCiAgICAgYXMgdGFpbnRlZC4gVGhlc2UgUk1SUnMgd2lsbCBzdGlsbCBiZSBp
ZGVudGl0eSBtYXBwZWQsIG90aGVyd2lzZSwKICAgICBzb21lIGRldmljZXMsIGUueC4gZ3JhcGhp
YyBkZXZpY2VzLCB3aWxsIG5vdCB3b3JrIGR1cmluZyBib290LgoKICAgICBTaWduZWQtb2ZmLWJ5
OiBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+CiAgICAgU2lnbmVkLW9mZi1ieTogTHUg
QmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KICAgICBGaXhlczogZjAzNmM3ZmEwYWI2
MCAoImlvbW11L3Z0LWQ6IENoZWNrIFZULWQgUk1SUiByZWdpb24gaW4gQklPUyAKaXMgcmVwb3J0
ZWQgYXMgcmVzZXJ2ZWQiKQogICAgIFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJvZWRl
bEBzdXNlLmRlPgoKQmVzdCByZWdhcmRzLApiYW9sdQoKT24gMjAyMC8yLzMgNTowNiwgVGhvbWFz
IEcgd3JvdGU6Cj4gRGVhciBhbGwsCj4gCj4gVnQtZCBzZWVtcyB0byBiZSBicm9rZW4gc2luY2Ug
SSB1cGdyYWRlZCB0byBrZXJuZWwgNS41LCB0aGVyZSBpcyBhIG5ldyAKPiBkbWVzZyB0aGF0IHdh
cyBub3QgdGhlcmUgaW4gNS40Ogo+ICJETUFSOiBbRmlybXdhcmUgQnVnXTogTm8gZmlybXdhcmUg
cmVzZXJ2ZWQgcmVnaW9uIGNhbiBjb3ZlciB0aGlzIFJNUlIgCj4gWzB4MDAwMDAwMDA0MWQ5MjAw
MC0weDAwMDAwMDAwNDFkOTRmZmZdLCBjb250YWN0IEJJT1MgdmVuZG9yIGZvciBmaXhlcyIKPiAK
PiBTeXN0ZW0gbW90aGVyYm9hcmQgaXMgQXNyb2NrIFgyOTkgVGFpY2hpIFhFLCBiaW9zIDEuNzAs
IENQVSBpcyBDb3JlIGk5IDc5MjAKPiBWdC1kIGFuZCBncHUgcGFzc3Rocm91Z2ggd2FzIHdvcmtp
bmcgb2sgc2luY2Uga2VybmVsIDQuMjAgd2hlbiBJIAo+IHB1cmNoYXNlZCBpdAo+IAo+IEkgYXR0
YWNoZWQgdGhlIGRtZXNnIEkgZ2V0IHdpdGgga2VybmVsIDUuNS4xLCBhbmQgdGhlIGRtZXNnIGZy
b20gNS40LjE3Lgo+IAo+IEFsc28sIEkgdXNlIHRoZSBmb2xsb3dpbmcgc2NyaXB0IHRoYXQgZGlz
cGxheXMgdGhlIElPTU1VIGdyb3VwcywgSSBmb3VuZCAKPiB0aGUgc2NyaXB0IHRoZXJlIAo+IGh0
dHBzOi8vd2lraS5hcmNobGludXgub3JnL2luZGV4LnBocC9QQ0lfcGFzc3Rocm91Z2hfdmlhX09W
TUYKPiAKPiAjIS9iaW4vYmFzaAo+IHNob3B0IC1zIG51bGxnbG9iCj4gZm9yIGQgaW4gL3N5cy9r
ZXJuZWwvaW9tbXVfZ3JvdXBzLyovZGV2aWNlcy8qOyBkbwo+ICDCoCDCoCBuPSR7ZCMqL2lvbW11
X2dyb3Vwcy8qfTsgbj0ke24lJS8qfQo+ICDCoCDCoCBwcmludGYgJ0lPTU1VIEdyb3VwICVzICcg
IiRuIgo+ICDCoCDCoCBsc3BjaSAtbm5zICIke2QjIyovfSIKPiBkb25lOwo+IAo+IFRoZSBvdXRw
dXQgb2YgdGhpcyBzY3JpcHQgd2l0aCBrZXJuZWwgNS40LjE3IGlzIGF0dGFjaGVkIHRvIHRoaXMg
ZW1haWwuCj4gVGhlIHNhbWUgc2NyaXB0IHdpdGgga2VybmVsIDUuNS4xIHByb2R1Y2VzIGFuIGVt
cHR5IG91dHB1dAo+IAo+IEhvcGUgaXQgaGVscHMgbmFycm93aW5nIGRvd24gdGhlIHByb2JsZW0s
IHBsZWFzZSBhc2sgYWRkaXRpb25hbCBpbmZvIGlmIAo+IG5lZWRlZC4gU29ycnkgaWYgdGhpcyBp
cyBub3Qgc3VibWl0dGVkIGFzIGl0IHNob3VsZCBiZSAodGhlbiBwbGVhc2UgCj4gYWR2aXNlKSwg
Zmlyc3QgdGltZSBJIHJlcG9ydCAtd2hhdCBhcHByZWFycyB0byBiZS0gYSBidWcuCj4gCj4gQmVz
dCwKPiBUaG9tYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
