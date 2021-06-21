Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69FC48BC2
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 14:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9F861151
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 14:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9F861151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B69686059A;
	Mon, 21 Jun 2021 14:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b55ySm_zSqiK; Mon, 21 Jun 2021 14:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8522960699;
	Mon, 21 Jun 2021 14:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 578B6C000E;
	Mon, 21 Jun 2021 14:32:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64719C000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4504581B3E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id izPOkGU9Dmj6 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 14:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FD4E81B25
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 14:32:29 +0000 (UTC)
IronPort-SDR: ho0d9UmllLXO9/9G0AXrO78BpcAyjpSmbCKrIHoBNWddga9pteAqvBFsWNeV6VAq9fQEq4Yj+6
 3St7DdblYmNA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203837855"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="203837855"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 07:32:27 -0700
IronPort-SDR: cfhxQQ5ewZfVr+5/hQUnHw/3u4dWOLVNI2UCwgbLVYWO71pF34FtHl/G+gqIyXbe9r1OMtNXqN
 293YgkrRky2w==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; d="scan'208";a="486509598"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.249])
 ([10.254.211.249])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2021 07:32:23 -0700
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
 <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
 <60bdd7c3-d73e-c005-ddf7-069bc5065bce@huawei.com>
 <855dd109-1449-7bc6-3d25-7ffeeeffa82a@linux.intel.com>
 <fc52069d-46c5-5ca5-1b44-2fa7cf287d5a@huawei.com>
 <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Message-ID: <5564e4b7-99af-c357-594a-1a6efe0c1464@linux.intel.com>
Date: Mon, 21 Jun 2021 22:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2330bb52-1768-5122-9378-7923034c82bd@arm.com>
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

SGkgUm9iaW4sCgpPbiAyMDIxLzYvMjEgMTk6NTksIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIxLTA2LTIxIDExOjM0LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBPbiAyMS8wNi8yMDIxIDExOjAw
LCBMdSBCYW9sdSB3cm90ZToKPj4+PiB2b2lkIGlvbW11X3NldF9kbWFfc3RyaWN0KGJvb2wgZm9y
Y2UpCj4+Pj4gewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZm9yY2UgPT0gdHJ1ZSkKPj4+
PiDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+Pj4+IMKgwqDCoMKg
wqBlbHNlIGlmICghKGlvbW11X2NtZF9saW5lICYgSU9NTVVfQ01EX0xJTkVfU1RSSUNUKSkKPj4+
PiDCoMKgwqDCoMKgwqDCoMKgIGlvbW11X2RtYV9zdHJpY3QgPSB0cnVlOwo+Pj4+IH0KPj4+Pgo+
Pj4+IFNvIHdlIHdvdWxkIHVzZSBpb21tdV9zZXRfZG1hX3N0cmljdCh0cnVlKSBmb3IgYSkgYW5k
IGIpLCBidXQgCj4+Pj4gaW9tbXVfc2V0X2RtYV9zdHJpY3QoZmFsc2UpIGZvciBjKS4KPj4+Cj4+
PiBZZXMuIFdlIG5lZWQgdG8gZGlzdGluZ3Vpc2ggdGhlICJtdXN0IiBhbmQgIm5pY2UtdG8taGF2
ZSIgY2FzZXMgb2YKPj4+IHNldHRpbmcgc3RyaWN0IG1vZGUuCj4+Pgo+Pj4+Cj4+Pj4gVGhlbiBJ
IGFtIG5vdCBzdXJlIHdoYXQgeW91IHdhbnQgdG8gZG8gd2l0aCB0aGUgYWNjb21wYW55aW5nIHBy
aW50IAo+Pj4+IGZvciBjKS4gSXQgd2FzOgo+Pj4+ICJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxl
ZCBkdWUgdG8gdmlydHVhbGl6YXRpb24iCj4+Pj4KPj4+PiBBbmQgbm93IGlzIGZyb20gdGhpcyBz
ZXJpZXM6Cj4+Pj4gIklPTU1VIGJhdGNoaW5nIGRpc2FsbG93ZWQgZHVlIHRvIHZpcnR1YWxpemF0
aW9uIgo+Pj4+Cj4+Pj4gVXNpbmcgaW9tbXVfZ2V0X2RtYV9zdHJpY3QoZG9tYWluKSBpcyBub3Qg
YXBwcm9wcmlhdGUgaGVyZSB0byBrbm93IAo+Pj4+IHRoZSBjdXJyZW50IG1vZGUgKHNvIHdlIGtu
b3cgd2hldGhlciB0byBwcmludCkuCj4+Pj4KPj4+PiBOb3RlIHRoYXQgdGhpcyBjaGFuZ2Ugd291
bGQgbWVhbiB0aGF0IHRoZSBjdXJyZW50IHNlcmllcyB3b3VsZCAKPj4+PiByZXF1aXJlIG5vbi10
cml2aWFsIHJld29yaywgd2hpY2ggd291bGQgYmUgdW5mb3J0dW5hdGUgc28gbGF0ZSBpbiAKPj4+
PiB0aGUgY3ljbGUuCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSBh
bmQgSSBoYXZlIGFkZGVkIGJ5IHJldmlld2VkLWJ5Lgo+Pj4gUHJvYmFibHkgd2UgY291bGQgbWFr
ZSBhbm90aGVyIHBhdGNoIHNlcmllcyB0byBpbXByb3ZlIGl0IHNvIHRoYXQgdGhlCj4+PiBrZXJu
ZWwgb3B0aW1pemF0aW9uIHNob3VsZCBub3Qgb3ZlcnJpZGUgdGhlIHVzZXIgc2V0dGluZy4KPj4K
Pj4gT24gYSBwZXJzb25hbCBsZXZlbCBJIHdvdWxkIGJlIGhhcHB5IHdpdGggdGhhdCBhcHByb2Fj
aCwgYnV0IEkgdGhpbmsgCj4+IGl0J3MgYmV0dGVyIHRvIG5vdCBzdGFydCBjaGFuZ2luZyB0aGlu
Z3MgcmlnaHQgYXdheSBpbiBhIGZvbGxvdy11cCAKPj4gc2VyaWVzLgo+Pgo+PiBTbyBob3cgYWJv
dXQgd2UgYWRkIHRoaXMgcGF0Y2ggKHdoaWNoIHJlcGxhY2VzIDYvNiAiaW9tbXU6IFJlbW92ZSBt
b2RlIAo+PiBhcmd1bWVudCBmcm9tIGlvbW11X3NldF9kbWFfc3RyaWN0KCkiKT8KPj4KPj4gUm9i
aW4sIGFueSBvcGluaW9uPwo+IAo+IEZvciBtZSBpdCBib2lscyBkb3duIHRvIHdoZXRoZXIgdGhl
cmUgYXJlIGFueSByZWFsaXN0aWMgd29ya2xvYWRzIHdoZXJlIAo+IG5vbi1zdHJpY3QgbW9kZSAq
d291bGQqIHN0aWxsIHBlcmZvcm0gYmV0dGVyIHVuZGVyIHZpcnR1YWxpc2F0aW9uLiBUaGUgCgpB
dCBwcmVzZW50LCB3ZSBzZWUgdGhhdCBzdHJpY3QgbW9kZSBoYXMgYmV0dGVyIHBlcmZvcm1hbmNl
IGluIHRoZQp2aXJ0dWFsaXphdGlvbiBlbnZpcm9ubWVudCBiZWNhdXNlIGl0IHdpbGwgbWFrZSB0
aGUgc2hhZG93IHBhZ2UgdGFibGUKbWFuYWdlbWVudCBtb3JlIGVmZmljaWVudC4gV2hlbiB0aGUg
aGFyZHdhcmUgc3VwcG9ydHMgbmVzdGVkCnRyYW5zbGF0aW9uLCB3ZSBtYXkgaGF2ZSB0byByZS1l
dmFsdWF0ZSB0aGlzIHNpbmNlIHRoZXJlJ3Mgbm8gbmVlZCBmb3IKYSBzaGFkb3dpbmcgcGFnZSB0
YWJsZSBhbnltb3JlLgoKPiBvbmx5IHJlYXNvbiBmb3IgdGhlIHVzZXIgdG8gZXhwbGljaXRseSBw
YXNzICJpb21tdS5zdHJpY3Q9MCIgaXMgYmVjYXVzZSAKPiB0aGV5IGV4cGVjdCBpdCB0byBpbmNy
ZWFzZSB1bm1hcCBwZXJmb3JtYW5jZTsgaWYgaXQncyBvbmx5IGV2ZXIgZ29pbmcgdG8gCj4gbGVh
ZCB0byBhbiB1bmV4cGVjdGVkIHBlcmZvcm1hbmNlIGxvc3MsIEkgZG9uJ3Qgc2VlIGFueSB2YWx1
ZSBpbiAKPiBvdmVycmlkaW5nIHRoZSBrZXJuZWwncyBkZWNpc2lvbiBwdXJlbHkgZm9yIHRoZSBz
YWtlIG9mIHN1YnNlcnZpZW5jZS4KPiAKPiBJZiB0aGVyZSAqYXJlKiBjZXJ0YWluIHZhbGlkIGNh
c2VzIGZvciBhbGxvd2luZyBpdCBmb3IgcGVvcGxlIHdobyByZWFsbHkgCj4ga25vdyB3aGF0IHRo
ZXkncmUgZG9pbmcsIHRoZW4gd2Ugc2hvdWxkIGFyZ3VhYmx5IGFsc28gbG9nIGEgY291bnRlcnBh
cnQgCj4gbWVzc2FnZSB0byBzYXkgIndlJ3JlIGhvbm91cmluZyB5b3VyIG92ZXJyaWRlIGJ1dCBi
ZXdhcmUgaXQgbWF5IGhhdmUgdGhlIAo+IG9wcG9zaXRlIGVmZmVjdCB0byB3aGF0IHlvdSBleHBl
Y3QiIGZvciB0aGUgYmVuZWZpdCBvZiBvdGhlciB1c2VycyB3aG8gCj4gYXNzdW1lIGl0J3MgYSBn
ZW5lcmljIGdvLWZhc3RlciBrbm9iLiBBdCB0aGF0IHBvaW50IGl0IHN0YXJ0cyBnZXR0aW5nIAo+
IG5vbi10cml2aWFsIGVub3VnaCB0aGF0IEknZCB3YW50IHRvIGtub3cgZm9yIHN1cmUgaXQncyB3
b3J0aHdoaWxlLgo+IAo+IFRoZSBvdGhlciByZWFzb24gdGhpcyBtaWdodCBiZSBiZXR0ZXIgdG8g
cmV2aXNpdCBsYXRlciBpcyB0aGF0IGFuIEFNRCAKPiBlcXVpdmFsZW50IGlzIHN0aWxsIGluIGZs
aWdodFsxXSwgYW5kIHRoZXJlIG1pZ2h0IGJlIG1vcmUgdGhhdCBjYW4gCj4gZXZlbnR1YWxseSBi
ZSBmYWN0b3JlZCBvdXQuIEkgdGhpbmsgYm90aCBzZXJpZXMgYXJlIHByZXR0eSBtdWNoIGdvb2Qg
dG8gCj4gbWVyZ2UgZm9yIDUuMTQsIGJ1dCB0aW1lJ3MgYWxyZWFkeSB0aWdodCB0byBzb3J0IG91
dCB0aGUgY29uZmxpY3RzIHdoaWNoIAo+IGV4aXN0IGFzLWlzLCB3aXRob3V0IG1ha2luZyB0aGVt
IGFueSB3b3JzZS4KCkFncmVlZC4gV2UgY291bGQgcmV2aXNpdCBpdCBsYXRlci4KCkJlc3QgcmVn
YXJkcywKYmFvbHUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
