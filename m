Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A96C433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 18:56:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6BD6128B
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 18:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA6BD6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marcan.st
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F35582ACD;
	Tue, 19 Oct 2021 18:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UnhicXEr4L9; Tue, 19 Oct 2021 18:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09C3880F95;
	Tue, 19 Oct 2021 18:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5821C000F;
	Tue, 19 Oct 2021 18:56:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 057FAC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC5096058F
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5uGSbbNIzKUU for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:58:27 +0000 (UTC)
X-Greylist: delayed 00:09:09 by SQLgrey-1.8.0
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37D4E600CC
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:58:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 0715B41ECC;
 Tue, 19 Oct 2021 16:49:12 +0000 (UTC)
Subject: Re: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>
References: <20211019162253.45919-1-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
Message-ID: <e73c6976-7dac-3ee1-7f96-1e9c1829463f@marcan.st>
Date: Wed, 20 Oct 2021 01:49:10 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019162253.45919-1-sven@svenpeter.dev>
Content-Language: es-ES
X-Mailman-Approved-At: Tue, 19 Oct 2021 18:56:13 +0000
Cc: =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@protonmail.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

T24gMjAvMTAvMjAyMSAwMS4yMiwgU3ZlbiBQZXRlciB3cm90ZToKPiBEQVJUIGhhcyBhbiBhZGRp
dGlvbmFsIGdsb2JhbCByZWdpc3RlciB0byBjb250cm9sIHdoaWNoIHN0cmVhbXMgYXJlCj4gaXNv
bGF0ZWQuIFRoaXMgcmVnaXN0ZXIgaXMgYSBiaXQgcmVkdW5kYW50IHNpbmNlIERBUlRfVENSIGNh
biBhbHJlYWR5Cj4gYmUgdXNlZCB0byBjb250cm9sIGlzb2xhdGlvbiBhbmQgaXMgdXN1YWxseSBp
bml0aWFsaXplZCB0byBEQVJUX1NUUkVBTV9BTEwKPiBieSB0aGUgdGltZSB3ZSBnZXQgY29udHJv
bC4gU29tZSBEQVJUcyAobmFtZWx5IHRoZSBvbmUgdXNlZCBmb3IgdGhlIGF1ZGlvCj4gY29udHJv
bGxlcikgaG93ZXZlciBoYXZlIHNvbWUgc3RyZWFtcyBkaXNhYmxlZCBpbml0aWFsbHkuIE1ha2Ug
c3VyZSB0aG9zZQo+IHdvcmsgYnkgaW5pdGlhbGl6aW5nIERBUlRfU1RSRUFNU19FTkFCTEUgZHVy
aW5nIHJlc2V0Lgo+IAo+IFJlcG9ydGVkLWJ5OiBNYXJ0aW4gUG92acWhZXIgPHBvdmlrQHByb3Rv
bm1haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIgPHN2ZW5Ac3ZlbnBldGVyLmRl
dj4KPiAtLS0KPiAKPiBXaGlsZSB0aGlzIGNvdWxkIHRlY2huaWNhbGx5IGNvdW50IGFzIGEgZml4
IEkgZG9uJ3QgdGhpbmsgaXQgbmVlZHMgdG8gZ28gdG8KPiA1LjE1IHNpbmNlIG5vIGRyaXZlciB0
aGF0IHJlcXVpcmVzIHRoaXMgaXMgaW4gdGhlcmUuIFRoZSBmaXJzdCBkcml2ZXIKPiB0aGF0IG5l
ZWRzIHRoaXMgd2lsbCBsaWtlbHkgb25seSBiZSByZWFkeSBmb3IgdGhlIDUuMTcgbWVyZ2Ugd2lu
ZG93Lgo+IAo+ICAgZHJpdmVycy9pb21tdS9hcHBsZS1kYXJ0LmMgfCA1ICsrKysrCj4gICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvYXBwbGUtZGFydC5jIGIvZHJpdmVycy9pb21tdS9hcHBsZS1kYXJ0LmMKPiBpbmRleCBjZTky
MTk1ZGI2MzguLjZmOGMyNDBkOGQ0MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FwcGxl
LWRhcnQuYwo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXBwbGUtZGFydC5jCj4gQEAgLTcwLDYgKzcw
LDggQEAKPiAgICNkZWZpbmUgREFSVF9FUlJPUl9BRERSX0hJIDB4NTQKPiAgICNkZWZpbmUgREFS
VF9FUlJPUl9BRERSX0xPIDB4NTAKPiAgIAo+ICsjZGVmaW5lIERBUlRfU1RSRUFNU19FTkFCTEUg
MHhmYwo+ICsKPiAgICNkZWZpbmUgREFSVF9UQ1Ioc2lkKSAoMHgxMDAgKyA0ICogKHNpZCkpCj4g
ICAjZGVmaW5lIERBUlRfVENSX1RSQU5TTEFURV9FTkFCTEUgQklUKDcpCj4gICAjZGVmaW5lIERB
UlRfVENSX0JZUEFTUzBfRU5BQkxFIEJJVCg4KQo+IEBAIC0yOTksNiArMzAxLDkgQEAgc3RhdGlj
IGludCBhcHBsZV9kYXJ0X2h3X3Jlc2V0KHN0cnVjdCBhcHBsZV9kYXJ0ICpkYXJ0KQo+ICAgCWFw
cGxlX2RhcnRfaHdfZGlzYWJsZV9kbWEoJnN0cmVhbV9tYXApOwo+ICAgCWFwcGxlX2RhcnRfaHdf
Y2xlYXJfYWxsX3R0YnJzKCZzdHJlYW1fbWFwKTsKPiAgIAo+ICsJLyogZW5hYmxlIGFsbCBzdHJl
YW1zIGdsb2JhbGx5IHNpbmNlIFRDUiBpcyB1c2VkIHRvIGNvbnRyb2wgaXNvbGF0aW9uICovCj4g
Kwl3cml0ZWwoREFSVF9TVFJFQU1fQUxMLCBkYXJ0LT5yZWdzICsgREFSVF9TVFJFQU1TX0VOQUJM
RSk7Cj4gKwo+ICAgCS8qIGNsZWFyIGFueSBwZW5kaW5nIGVycm9ycyBiZWZvcmUgdGhlIGludGVy
cnVwdCBpcyB1bm1hc2tlZCAqLwo+ICAgCXdyaXRlbChyZWFkbChkYXJ0LT5yZWdzICsgREFSVF9F
UlJPUiksIGRhcnQtPnJlZ3MgKyBEQVJUX0VSUk9SKTsKPiAgIAo+IAoKUmV2aWV3ZWQtYnk6IEhl
Y3RvciBNYXJ0aW4gPG1hcmNhbkBtYXJjYW4uc3Q+CgotLSAKSGVjdG9yIE1hcnRpbiAobWFyY2Fu
QG1hcmNhbi5zdCkKUHVibGljIEtleTogaHR0cHM6Ly9tcmNuLnN0L3B1YgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
