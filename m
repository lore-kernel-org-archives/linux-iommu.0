Return-Path: <SRS0=Qw7g=JJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB916C43462
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 13:12:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3758261350
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 13:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3758261350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB6DF403E2;
	Mon, 12 Apr 2021 13:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0pQ0aOMc_9MN; Mon, 12 Apr 2021 13:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACA7740205;
	Mon, 12 Apr 2021 13:12:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9017DC000C;
	Mon, 12 Apr 2021 13:12:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B964DC000A
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 13:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B0EA82400
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 13:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cP3xgIuojihe for <iommu@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 13:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E84781CE7
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 13:12:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAFD1063;
 Mon, 12 Apr 2021 06:12:31 -0700 (PDT)
Received: from [10.57.58.164] (unknown [10.57.58.164])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FDDA3F73B;
 Mon, 12 Apr 2021 06:12:27 -0700 (PDT)
Subject: Re: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
To: David Hildenbrand <david@redhat.com>, Arnd Bergmann <arnd@arndb.de>
References: <20210409112035.27221-1-david@redhat.com>
 <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
 <53ec94ac-ffe3-d0bc-d081-3489fa03daa1@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <34350446-0e0e-6947-40bd-fabdccdc835f@arm.com>
Date: Mon, 12 Apr 2021 14:12:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <53ec94ac-ffe3-d0bc-d081-3489fa03daa1@redhat.com>
Content-Language: en-GB
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-aspeed <linux-aspeed@lists.ozlabs.org>, David Airlie <airlied@linux.ie>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Eric Anholt <eric@anholt.net>,
 Christoph Hellwig <hch@lst.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joel Stanley <joel@jms.id.au>, Russell King <linux+etnaviv@armlinux.org.uk>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux-MM <linux-mm@kvack.org>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>
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

T24gMjAyMS0wNC0wOSAxNDozOSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMDkuMDQu
MjEgMTU6MzUsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4+IE9uIEZyaSwgQXByIDksIDIwMjEgYXQg
MToyMSBQTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gCj4+IHdyb3RlOgo+
Pj4KPj4+IFJhbmRvbSBkcml2ZXJzIHNob3VsZCBub3Qgb3ZlcnJpZGUgYSB1c2VyIGNvbmZpZ3Vy
YXRpb24gb2YgY29yZSBrbm9icwo+Pj4gKGUuZy4sIENPTkZJR19ETUFfQ01BPW4pLiBBcHBsaWNh
YmxlIGRyaXZlcnMgd291bGQgbGlrZSB0byB1c2UgRE1BX0NNQSwKPj4+IHdoaWNoIGRlcGVuZHMg
b24gQ01BLCBpZiBwb3NzaWJsZTsgaG93ZXZlciwgdGhlc2UgZHJpdmVycyBhbHNvIGhhdmUgdG8K
Pj4+IHRvbGVyYXRlIGlmIERNQV9DTUEgaXMgbm90IGF2YWlsYWJsZS9mdW5jdGlvbmluZywgZm9y
IGV4YW1wbGUsIGlmIG5vIENNQQo+Pj4gYXJlYSBmb3IgRE1BX0NNQSB1c2UgaGFzIGJlZW4gc2V0
dXAgdmlhICJjbWE9WCIuIEluIHRoZSB3b3JzdCBjYXNlLCB0aGUKPj4+IGRyaXZlciBjYW5ub3Qg
ZG8gaXQncyBqb2IgcHJvcGVybHkgaW4gc29tZSBjb25maWd1cmF0aW9ucy4KPj4+Cj4+PiBGb3Ig
ZXhhbXBsZSwgY29tbWl0IDYzZjU2Nzc1NDRiMyAoImRybS9ldG5hdml2OiBzZWxlY3QgQ01BIGFu
ZCAKPj4+IERNQV9DTUEgaWYKPj4+IGF2YWlsYWJsZSIpIGRvY3VtZW50cwo+Pj4gwqDCoMKgwqDC
oMKgwqDCoCBXaGlsZSB0aGlzIGlzIG5vIGJ1aWxkIGRlcGVuZGVuY3ksIGV0bmF2aXYgd2lsbCBv
bmx5IHdvcmsgCj4+PiBjb3JyZWN0bHkKPj4+IMKgwqDCoMKgwqDCoMKgwqAgb24gbW9zdCBzeXN0
ZW1zIGlmIENNQSBhbmQgRE1BX0NNQSBhcmUgZW5hYmxlZC4gU2VsZWN0IGJvdGggCj4+PiBvcHRp
b25zCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIGF2YWlsYWJsZSB0byBhdm9pZCB1c2VycyBlbmRp
bmcgdXAgd2l0aCBhIG5vbi13b3JraW5nIEdQVSAKPj4+IGR1ZSB0bwo+Pj4gwqDCoMKgwqDCoMKg
wqDCoCBhIGxhY2tpbmcga2VybmVsIGNvbmZpZy4KPj4+IFNvIGV0bmF2aXYgcmVhbGx5IHdhbnRz
IHRvIGhhdmUgRE1BX0NNQSwgaG93ZXZlciwgY2FuIGRlYWwgd2l0aCBzb21lIAo+Pj4gY2FzZXMK
Pj4+IHdoZXJlIGl0IGlzIG5vdCBhdmFpbGFibGUuCj4+Pgo+Pj4gTGV0J3MgaW50cm9kdWNlIFdB
TlRfRE1BX0NNQSBhbmQgdXNlIGl0IGluIG1vc3QgY2FzZXMgd2hlcmUgZHJpdmVycwo+Pj4gc2Vs
ZWN0IENNQS9ETUFfQ01BLCBvciBkZXBlbmQgb24gRE1BX0NNQSAoaW4gYSB3cm9uZyB3YXkgdmlh
IENNQSBiZWNhdXNlCj4+PiBvZiByZWN1cnNpdmUgZGVwZW5kZW5jeSBpc3N1ZXMpLgo+Pj4KPj4+
IFdlJ2xsIGFzc3VtZSB0aGF0IGFueSBkcml2ZXIgdGhhdCBzZWxlY3RzIERSTV9HRU1fQ01BX0hF
TFBFUiBvcgo+Pj4gRFJNX0tNU19DTUFfSEVMUEVSIHdvdWxkIGxpa2UgdG8gdXNlIERNQV9DTUEg
aWYgcG9zc2libGUuCj4+Pgo+Pj4gV2l0aCB0aGlzIGNoYW5nZSwgZGlzdHJpYnV0aW9ucyBjYW4g
ZGlzYWJsZSBDT05GSUdfQ01BIG9yCj4+PiBDT05GSUdfRE1BX0NNQSwgd2l0aG91dCBpdCBzaWxl
bnRseSBnZXR0aW5nIGVuYWJsZWQgYWdhaW4gYnkgcmFuZG9tCj4+PiBkcml2ZXJzLiBBbHNvLCB3
ZSdsbCBub3cgYXV0b21hdGljYWxseSB0cnkgdG8gZW5hYmxlZCBib3RoLCBDT05GSUdfQ01BCj4+
PiBhbmQgQ09ORklHX0RNQV9DTUEgaWYgdGhleSBhcmUgdW5zcGVjaWZpZWQgYW5kIGFueSBkcml2
ZXIgaXMgYXJvdW5kIHRoYXQKPj4+IHNlbGVjdHMgV0FOVF9ETUFfQ01BIC0tIGFsc28gaW1wbGlj
aXRseSB2aWEgRFJNX0dFTV9DTUFfSEVMUEVSIG9yCj4+PiBEUk1fS01TX0NNQV9IRUxQRVIuCj4+
Pgo+Pj4gRm9yIGV4YW1wbGUsIGlmIGFueSBkcml2ZXIgc2VsZWN0cyBXQU5UX0RNQV9DTUEgYW5k
IHdlIGRvIGEKPj4+ICJtYWtlIG9sZGRlZmNvbmZpZyI6Cj4+Pgo+Pj4gMS4gV2l0aCAiIyBDT05G
SUdfQ01BIGlzIG5vdCBzZXQiIGFuZCBubyBzcGVjaWZpY2F0aW9uIG9mCj4+PiDCoMKgwqAgIkNP
TkZJR19ETUFfQ01BIgo+Pj4KPj4+IC0+IENPTkZJR19ETUFfQ01BIHdvbid0IGJlIHBhcnQgb2Yg
LmNvbmZpZwo+Pj4KPj4+IDIuIFdpdGggbm8gc3BlY2lmaWNhdGlvbiBvZiBDT05GSUdfQ01BIG9y
IENPTkZJR19ETUFfQ01BCj4+Pgo+Pj4gQ29udGlndW91cyBNZW1vcnkgQWxsb2NhdG9yIChDTUEp
IFtZL24vP10gKE5FVykKPj4+IERNQSBDb250aWd1b3VzIE1lbW9yeSBBbGxvY2F0b3IgKERNQV9D
TUEpIFtZL24vP10gKE5FVykKPj4+Cj4+PiAzLiBXaXRoICIjIENPTkZJR19DTUEgaXMgbm90IHNl
dCIgYW5kICIjIENPTkZJR19ETUFfQ01BIGlzIG5vdCBzZXQiCj4+Pgo+Pj4gLT4gQ09ORklHX0RN
QV9DTUEgd2lsbCBiZSByZW1vdmVkIGZyb20gLmNvbmZpZwo+Pj4KPj4+IE5vdGU6IGRyaXZlcnMv
cmVtb3RlcHJvYyBzZWVtcyB0byBiZSBzcGVjaWFsOyBjb21taXQgYzUxZTg4MmNkNzExCj4+PiAo
InJlbW90ZXByb2MvZGF2aW5jaTogVXBkYXRlIEtjb25maWcgdG8gZGVwZW5kIG9uIERNQV9DTUEi
KSBleHBsYWlucyAKPj4+IHRoYXQKPj4+IHRoZXJlIGlzIGEgcmVhbCBkZXBlbmRlbmN5IHRvIERN
QV9DTUEgZm9yIGl0IHRvIHdvcms7IGxlYXZlIHRoYXQgCj4+PiBkZXBlbmRlbmN5Cj4+PiBpbiBw
bGFjZSBhbmQgZG9uJ3QgY29udmVydCBpdCB0byBhIHNvZnQgZGVwZW5kZW5jeS4KPj4KPj4gSSBk
b24ndCB0aGluayB0aGlzIGRlcGVuZGVuY3kgaXMgZnVuZGFtZW50YWxseSBkaWZmZXJlbnQgZnJv
bSB0aGUgb3RoZXJzLAo+PiB0aG91Z2ggZGF2aW5jaSBtYWNoaW5lcyB0ZW5kIHRvIGhhdmUgbGVz
cyBtZW1vcnkgdGhhbiBhIGxvdCBvZiB0aGUKPj4gb3RoZXIgbWFjaGluZXMsIHNvIGl0J3MgbW9y
ZSBsaWtlbHkgdG8gZmFpbCB3aXRob3V0IENNQS4KPj4KPiAKPiBJIHdhcyBhbHNvIHVuc3VyZSAt
IGFuZCBMdWNhcyBoYWQgc2ltaWxhciB0aG91Z2h0cy4gSWYgeW91IHdhbnQsIEkgY2FuIAo+IHNl
bmQgYSB2NCBhbHNvIHRha2luZyBjYXJlIG9mIHRoaXMuCgpUQkggSSB0aGluayBpdCBzaG91bGQg
YWxsIGp1c3QgYmUgcmVtb3ZlZC4gRE1BX0NNQSBpcyBlZmZlY3RpdmVseSBhbiAKaW50ZXJuYWwg
ZmVhdHVyZSBvZiB0aGUgRE1BIEFQSSwgYW5kIGRyaXZlcnMgd2hpY2ggc2ltcGx5IHVzZSB0aGUg
RE1BIApBUEkgc2hvdWxkbid0IHJlYWxseSBiZSB0cnlpbmcgdG8gYXNzdW1lICpob3cqIHRoaW5n
cyBtaWdodCBiZSBhbGxvY2F0ZWQgCmF0IHJ1bnRpbWUgLSBDTUEgaXMgaGFyZGx5IHRoZSBvbmx5
IHdheS4gUGxhdGZvcm0tbGV2ZWwgYXNzdW1wdGlvbnMgCmFib3V0IHRoZSBwcmVzZW5jZSBvciBu
b3Qgb2YgSU9NTVVzLCBtZW1vcnkgY2FydmVvdXRzLCBldGMuLCBhbmQgd2hldGhlciAKaXQgZXZl
biBtYXR0ZXJzIC0gZS5nLiBhIGRldmljZSB3aXRoIGEgdGlueSBMQ0QgbWF5IG9ubHkgbmVlZCBk
aXNwbGF5IApidWZmZXJzIHdoaWNoIHN0aWxsIGZpdCBpbiBhIHJlZ3VsYXIgTUFYX09SREVSIGFs
bG9jYXRpb24gLSBjb3VsZCBnbyBpbiAKcGxhdGZvcm0tc3BlY2lmaWMgY29uZmlncywgYnV0IEkg
cmVhbGx5IGRvbid0IHRoaW5rIHRoZXkgYmVsb25nIGF0IHRoZSAKZ2VuZXJpYyBzdWJzeXN0ZW0g
bGV2ZWwuCgpXZSBhbHJlYWR5IGhhdmUgdmFyaW91cyBleGFtcGxlcyBsaWtlIEkyUyBkcml2ZXJz
IHRoYXQgd29uJ3QgZXZlbiBwcm9iZSAKd2l0aG91dCBhIGRtYWVuZ2luZSBwcm92aWRlciBiZWlu
ZyBwcmVzZW50LCBvciBob3N0IGNvbnRyb2xsZXIgZHJpdmVycyAKd2hpY2ggYXJlIHVzZWxlc3Mg
d2l0aG91dCB0aGVpciBjb3JyZXNwb25kaW5nIHBoeSBkcml2ZXIgKGFuZCBJJ20gCmd1ZXNzaW5n
IHlvdSBjYW4gcHJvYmFibHkgYWxzbyBkbyBoaWdoZXItbGV2ZWwgdGhpbmdzIGxpa2UgaW5jbHVk
ZSB0aGUgCmJsb2NrIGxheWVyIGJ1dCBvbWl0IGFsbCBmaWxlc3lzdGVtIGRyaXZlcnMpLiBJIGRv
bid0IGJlbGlldmUgaXQncyAKS2NvbmZpZydzIGpvYiB0byB0cnkgdG8gZ3Vlc3Mgd2hldGhlciBh
IGdpdmVuIGNvbmZpZ3VyYXRpb24gaXMgKnVzZWZ1bCosIApvbmx5IHRvIGVuZm9yY2UgdGhhdCdz
IGl0J3MgdmFsaWQgdG8gYnVpbGQuCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
