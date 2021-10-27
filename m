Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C5CC433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 08:08:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63F1610E6
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 08:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D63F1610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98473401B0;
	Wed, 27 Oct 2021 08:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lE5_TkRSzBKb; Wed, 27 Oct 2021 08:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76933400CC;
	Wed, 27 Oct 2021 08:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51D10C0019;
	Wed, 27 Oct 2021 08:08:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0AD1C000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 08:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A273960627
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 08:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CG5cg22v77_B for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 08:08:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18F5360620
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 08:08:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7DA64452; Wed, 27 Oct 2021 10:08:38 +0200 (CEST)
Date: Wed, 27 Oct 2021 10:08:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
Message-ID: <YXkJBXCnzZ/MgYFV@8bytes.org>
References: <20211019162253.45919-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211019162253.45919-1-sven@svenpeter.dev>
Cc: Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlLCBPY3QgMTksIDIwMjEgYXQgMDY6MjI6NTNQTSArMDIwMCwgU3ZlbiBQZXRlciB3cm90
ZToKPiBEQVJUIGhhcyBhbiBhZGRpdGlvbmFsIGdsb2JhbCByZWdpc3RlciB0byBjb250cm9sIHdo
aWNoIHN0cmVhbXMgYXJlCj4gaXNvbGF0ZWQuIFRoaXMgcmVnaXN0ZXIgaXMgYSBiaXQgcmVkdW5k
YW50IHNpbmNlIERBUlRfVENSIGNhbiBhbHJlYWR5Cj4gYmUgdXNlZCB0byBjb250cm9sIGlzb2xh
dGlvbiBhbmQgaXMgdXN1YWxseSBpbml0aWFsaXplZCB0byBEQVJUX1NUUkVBTV9BTEwKPiBieSB0
aGUgdGltZSB3ZSBnZXQgY29udHJvbC4gU29tZSBEQVJUcyAobmFtZWx5IHRoZSBvbmUgdXNlZCBm
b3IgdGhlIGF1ZGlvCj4gY29udHJvbGxlcikgaG93ZXZlciBoYXZlIHNvbWUgc3RyZWFtcyBkaXNh
YmxlZCBpbml0aWFsbHkuIE1ha2Ugc3VyZSB0aG9zZQo+IHdvcmsgYnkgaW5pdGlhbGl6aW5nIERB
UlRfU1RSRUFNU19FTkFCTEUgZHVyaW5nIHJlc2V0Lgo+IAo+IFJlcG9ydGVkLWJ5OiBNYXJ0aW4g
UG92acWhZXIgPHBvdmlrQHByb3Rvbm1haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0
ZXIgPHN2ZW5Ac3ZlbnBldGVyLmRldj4KPiAtLS0KCkFwcGxpZWQsIHRoYW5rcy4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
