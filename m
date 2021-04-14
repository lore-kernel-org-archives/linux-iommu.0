Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72819C433ED
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 05:36:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7A7613C4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 05:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7A7613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA4394013B;
	Wed, 14 Apr 2021 05:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TplaM4Pzm7gq; Wed, 14 Apr 2021 05:36:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A46DB400FA;
	Wed, 14 Apr 2021 05:36:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88873C000B;
	Wed, 14 Apr 2021 05:36:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1022C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92BA14013B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHm93v9doQ9D for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:36:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D463400FA
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 05:36:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48CF661244;
 Wed, 14 Apr 2021 05:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618378577;
 bh=Vj+HP59OMz3KDqYcngvrQ2A9lMs3T43KVgG8tJEsyeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HdSA141Gz7fxQaYyXhrOoLfaTXoGZWP5AJnaQ6pUBHhcN4CWkPuo2EeE89maXXGXK
 bF/3ETaztETAJQy9I5yKIjHmNGtuH8M9D/x1FJCPkDVMhRml+q0TZI8ofFnb8/BVf/
 pwABU/lZPYfVkaYFCE37RTFg9rVT0mMgwxgWbcJQ=
Date: Wed, 14 Apr 2021 07:36:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH 5.4 v3 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
Message-ID: <YHZ/T9x7Xjf1r6fI@kroah.com>
References: <20210412202736.70765-1-saeed.mirzamohammadi@oracle.com>
 <YHVJDM4CXINrO1KE@kroah.com>
 <0C3869E0-63C9-42D5-AAE2-D9D24011B93E@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0C3869E0-63C9-42D5-AAE2-D9D24011B93E@oracle.com>
Cc: Camille Lu <camille.lu@hpe.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "# v4 . 16+" <stable@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgMTE6MDU6MzRBTSAtMDcwMCwgU2FlZWQgTWlyemFtb2hh
bW1hZGkgd3JvdGU6Cj4gSGkgR3JlZywKPiAKPiBJIGRvbuKAmXQgaGF2ZSBhbnkgY29tbWl0IElE
IHNpbmNlIHRoZSBmaXggaXMgbm90IGluIG1haW5saW5lIG9yIGFueSBMaW51c+KAmSB0cmVlIHll
dC4gVGhlIGRyaXZlciBoYXMgY29tcGxldGVseSBjaGFuZ2VkIGZvciBuZXdlciBzdGFibGUgdmVy
c2lvbnMgKGFuZCBhbHNvIG1haW5saW5lKSBhbmQgdGhlIGZpeCBvbmx5IGFwcGxpZXMgZm9yIDUu
NCwgNC4xOSwgYW5kIDQuMTQgc3RhYmxlIGtlcm5lbHMuCgpXaHkgY2FuIHdlIG5vdCBqdXN0IHRh
a2Ugd2hhdCBpcyBpbiBtYWlubGluZT8KCkFuZCBpZiBub3QsIHRoZW4geW91IG5lZWQgdG8gZG9j
dW1lbnQgdGhlIGhlY2sgb3V0IG9mIHRoaXMgaW4gdGhlCmNoYW5nZWxvZyB0ZXh0LCBhbmQgZ2V0
IGFsbCBvZiB0aGUgcmVsYXRlZCBtYWludGFpbmVycyBpbiB0aGUgYXJlYSB0bwpzaWduIG9mZiBv
biB0aGlzLiAgRGl2ZXJnaW5nIGZyb20gTGludXMncyB0cmVlIGNyZWF0ZXMgYSBiaWcgYnVyZGVu
IG92ZXIKdGltZSwgeW91IGhhdmUgdG8gbWFrZSB0aGlzIHJlYWxseSByZWFsbHkgb2J2aW91cyB3
aHkgeW91IGFyZSBkb2luZwp0aGlzLCBhbmQgd2hhdCB5b3UgYXJlIGRvaW5nIGhlcmUgc28gdGhh
dCBldmVyeW9uZSBhZ3JlZXMgd2l0aCBpdC4KClJlbWVtYmVyLCA5MCUgb2YgYWxsIG9mIHRoZXNl
IHR5cGVzIG9mICJkbyBpdCBkaWZmZXJlbnRseSB0aGFuIExpbnVzJ3MKdHJlZSIgYXJlIGJ1Z2d5
IGFuZCBjYXVzZSBwcm9ibGVtcywgYmUgdmVyeSBjYXJlZnVsLgoKUGxlYXNlIGZpeCB1cCBhbmQg
cmVzZW5kLgoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
