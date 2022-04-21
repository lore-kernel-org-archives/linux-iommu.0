Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCBAC433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 14:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31A466F59A;
	Thu, 21 Apr 2022 14:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcOSZoI6K8qE; Thu, 21 Apr 2022 14:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CB9A6137E;
	Thu, 21 Apr 2022 14:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB5EC0033;
	Thu, 21 Apr 2022 14:13:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCA2C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AD80409DE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJtw3TxLABG5 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:13:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9A0540B66
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:13:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EC0C068C7B; Thu, 21 Apr 2022 16:13:02 +0200 (CEST)
Date: Thu, 21 Apr 2022 16:13:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] More ARM DMA ops cleanup
Message-ID: <20220421141300.GC20492@lst.de>
References: <cover.1650539846.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1650539846.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: arnd@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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

T24gVGh1LCBBcHIgMjEsIDIwMjIgYXQgMTI6MzY6NTZQTSArMDEwMCwgUm9iaW4gTXVycGh5IHdy
b3RlOgo+IEhpIGFsbCwKPiAKPiBUaGFua3MgdG8gQ2hyaXN0b3BoJ3MgbGF0ZXN0IHNlcmllcywg
SSdtIHJlbWluZGVkIHRoYXQsIGlmIHdlJ3JlIGdvaW5nCj4gdG8gZ2l2ZSB0aGUgQVJNIERNQSBv
cHMgc29tZSBjbGVhbnVwIHRoaXMgY3ljbGUsIGl0J3MgYXMgZ29vZCBhIHRpbWUgYXMKPiBhbnkg
dG8gZHVzdCBvZmYgdGhlc2Ugb2xkIHBhdGNoZXMgYW5kIGFkZCB0aGVtIG9uIHRvcCBhcyB3ZWxs
LiBJJ3ZlCj4gYmFzZWQgdGhlc2Ugb24gdGhlIGFybS1kbWEtZGlyZWN0IGJyYW5jaCB3aGljaCBJ
IGFzc3VtZSBtYXRjaGVzIHRoZQo+IHBhdGNoZXMgcG9zdGVkIGF0IFsxXS4KCkFsbCB0aGVzZSBk
byBsb29rIHNlbnNpYmxlIHRvIG1lLiAgQnV0IHdlcmVuJ3QgeW91IHdvcmtpbmcgb24gcmVwbGFj
aW5nCnRoZSBBUk0gaW9tbXUgZG1hX29wcyB3aXRoIGRtYS3Rlm9tbXUgYW55d2F5PwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
