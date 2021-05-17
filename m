Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64755C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 14:46:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1434E61D49
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 14:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1434E61D49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D383340103;
	Mon, 17 May 2021 14:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hFPzORH8pZZ; Mon, 17 May 2021 14:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C56D40165;
	Mon, 17 May 2021 14:46:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7015C000D;
	Mon, 17 May 2021 14:46:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C0DC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF64940317
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kroah.com header.b="vWcu1QQ1";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="drtKUgCo"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uTSAFE7OwItK for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:46:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB993402D9
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 14:46:19 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id CDFE8D73;
 Mon, 17 May 2021 10:46:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Mon, 17 May 2021 10:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=7
 AomO9JXrdrY5Ih8pwTBGgUCrP2fDKFQt8ByFGJboIw=; b=vWcu1QQ13t6CN5L8M
 wzDYniNWTE3YSpKp/0sobqLNyRtK6G0Vwv3sifiYygPkcFB95H5Lke8RGQM4z/6n
 42s25Z9eYYL4WxTy9tRoYjynovpVbgQyS3SeBv1XZD9vaBeLJ/nUR9xPyoczcXMP
 3HKsEZp67uw9Njtg/8GJTS8uQJdsyy5/JacKeQegQdZyKQVec80LHXzIthxOPTE+
 1HXgVZrm0FzDZyCIJOy5L46bl6FESN335Lezzv+sZOyROpDJ2nEkLinagdz11nms
 cFoTgRiCHQ8CTZ32JZFR4gCIwI1ALLI2OT2Hlf5seotMZTfuLjhSB6J0pHg7Embz
 HMSHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=7AomO9JXrdrY5Ih8pwTBGgUCrP2fDKFQt8ByFGJbo
 Iw=; b=drtKUgCoF/wRXn6tLqFNgJbrQxpz+g1kfPTZYuHjpjDS921U8up3wHiIm
 qZkDck3tDB8SjAw1f1qeevo3yOTJ4m8oBJiMRUyKkNSvo/coVKfDdBXo/d+cu7YP
 dwJ8cvyBi2OWPSVkSuMj/R3NidbH+8kSExXazpGA46zVQ0V4lf311tGS0tQ7wJaX
 Sp3Vzk+XDDRNKTUAgPE67lGyVG0ilS3gnGYiX2qXT72zuqKnnaZqDnE9U8hbFzjI
 kmuTG8/p3zRmo+C+AepF4kpMEBn72ThQEo99gdD25g19TGrizu2QBwERxbk68sDt
 slcoRs26/QEZrrKOPfVWvz6kQuR7w==
X-ME-Sender: <xms:t4GiYHZC1I1hxsZsvIqYmk2yVx3axOgct3nyKp2u49mOzASIxdCWBQ>
 <xme:t4GiYGZs1PeenYyroaBvFinz_4kun_WHJlYUDc6iLhyy7fymCxhbsALY4DZFny5C_
 2qRwNiEop0Mzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeihedgkeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
 ertddttdejnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
 qeenucggtffrrghtthgvrhhnpeegieejuedvffeuvdfftdetfeeuhfekhefgueffjeevte
 dtlefgueduffffteeftdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
 fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:t4GiYJ8jPrgBE8QrMnbOjoq1OGG0hX5JHNwtKcGfDxzv7toJoG9dww>
 <xmx:t4GiYNpw7UO2IPXi2VDoy8ZLoM0GkpeHeHCMZy4CAsNdld95Rf0jRA>
 <xmx:t4GiYCqtuJB-v9G2_t1ERt4OXD7HNQ_vcvI40nShdlVSFwNP6j-QNA>
 <xmx:uIGiYPAqa0Uv_1mWsmC_A-jmdOT0YtqtAJPIXnJ5YcojAcyNLQw7og>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Mon, 17 May 2021 10:46:15 -0400 (EDT)
Date: Mon, 17 May 2021 16:12:26 +0200
From: Greg KH <greg@kroah.com>
To: Jack Wang <jack.wang.usish@gmail.com>
Subject: Re: 5.10.37 won't boot on my system, but 5.10.36 with same config does
Message-ID: <YKJ5ysGAuI32Jpn6@kroah.com>
References: <e0e9ecf4-cfd7-b31a-29b0-ead4a6c0ee40@charleswright.co>
 <1621180418@msgid.manchmal.in-ulm.de> <YKI/D64ODBUEHO9M@kroah.com>
 <1621251453@msgid.manchmal.in-ulm.de>
 <1621251685@msgid.manchmal.in-ulm.de>
 <CA+res+RHyF22T-sGwCG5zA6EBrk_gWbnZETX_iAgdRdWaPLbfw@mail.gmail.com>
 <1621254246@msgid.manchmal.in-ulm.de>
 <CA+res+QRm3VyJSjMaKLYm=KY5+T5nX+6-QhOgrgBcP+d2Ganag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+res+QRm3VyJSjMaKLYm=KY5+T5nX+6-QhOgrgBcP+d2Ganag@mail.gmail.com>
Cc: iommu@lists.linux-foundation.org,
 Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
 stable <stable@vger.kernel.org>
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

T24gTW9uLCBNYXkgMTcsIDIwMjEgYXQgMDI6NDU6MDFQTSArMDIwMCwgSmFjayBXYW5nIHdyb3Rl
Ogo+IENocmlzdG9waCBCaWVkbCA8bGludXgta2VybmVsLmJmcnpAbWFuY2htYWwuaW4tdWxtLmRl
PiDkuo4yMDIx5bm0NeaciDE35pel5ZGo5LiAIOS4i+WNiDI6MjXlhpnpgZPvvJoKPiA+Cj4gPiBK
YWNrIFdhbmcgd3JvdGUuLi4KPiA+Cj4gPiA+IENocmlzdG9waCBCaWVkbCA8bGludXgta2VybmVs
LmJmcnpAbWFuY2htYWwuaW4tdWxtLmRlPiDkuo4yMDIx5bm0NeaciDE35pel5ZGo5LiAIOS4i+WN
iDE6NTLlhpnpgZPvvJoKPiA+ID4gPgo+ID4gPiA+IENocmlzdG9waCBCaWVkbCB3cm90ZS4uLgo+
ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MgZm9yIHRha2luZyBjYXJlLCB1bmZvcnR1bmF0ZWx5IG5v
IGltcHJvdmVtZW50IHdpdGggNS4xMC4zOC1yYzEgaGVyZS4KPiA+ID4gPgo+ID4gPiA+IFNvIGlu
IGNhc2UgdGhpcyBpcyByZWxhdGVkIHRvIHRoZSAuY29uZmlnLCBJJ20gYXR0YWNoaW5nIGl0LiBI
YXJkd2FyZSBpcywKPiA+ID4gPiBhcyBzYWlkIGJlZm9yZSwgYW4gb2xkIFRoaW5rcGFkIHgyMDAs
IHZlbmRvciBCSU9TIGFuZCBubyBwYXJ0aWN1bGFyIG1vZGlmaWNhdGlvbnMuCj4gPiA+ID4gQWZ0
ZXIgZGlzYWJsaW5nIGFsbCB2Z2EvdmlkZW8vZmJjb24gcGFyYW1ldGVycyBJIHNlZSB0aGUgc3lz
dGVtIHN1ZmZlcnMKPiA+ID4gPiBhIGtlcm5lbCBwYW5pYyBidXQgdW5mb3J0dW5hdGVseSBvbmx5
IHRoZSBsYXN0IDI1IGxpbmVzIGFyZSB2aXNpYmxlLgo+ID4gPiA+IFBvc3NpYmx5ICh0eXBvcyBh
cmUgbWluZSkKPiA+ID4gPgo+ID4gPiA+ICAgICBSSVA6IDAwMTA6X19kb21haW5fbWFwcGluZysw
eGE3LzB4M2EwCj4gPiA+ID4KPiA+ID4gPiBpcyBhIGhpbnQgaW50byB0aGUgcmlnaHQgZGlyZWN0
aW9uPwo+ID4gPiBUaGlzIGxvb2tzIGludGVsX2lvbW11IHJlbGF0ZWQsIGNhbiB5b3UgdHJ5IGJv
b3Qgd2l0aAo+ID4gPiAiaW50ZWxfaW9tbXU9b2ZmIiBpbiBrZXJuZWwgcGFyYW1ldGVyPwo+ID4K
PiA+IEdvdGNoYS4gU3lzdGVtIGJvb3RzIHVwIGZpbmUgdGhlbi4KPiA+Cj4gPiAgICAgQ2hyaXN0
b3BoCj4gU28gaXQncyBjYXVzZWQgYnkgdGhpcyBjb21taXRbMV0sIGFuZCBpdCBzaG91bGQgYmUg
Zml4ZWQgYnkgbGF0ZXN0Cj4gNS4xMC4zOC1yYzEgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LXN0YWJsZS1yYy5naXQvbG9nLz9oPWxp
bnV4LTUuMTAueQo+IFsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIxMDUxNTEz
Mjg1NS40Ym43dmUyb3p2ZGhwbmo0QG5hYm9rb3YuZnJpdHouYm94LwoKSG9wZWZ1bGx5IHRoZSAi
cmVhbCIgNS4xMC4zOC1yYzEgcmVsZWFzZSB0aGF0IGlzIG91dCBub3cgc2hvdWxkIGZpeAp0aGlz
LiAgSWYgbm90LCBwbGVhc2UgbGV0IHVzIGtub3cuCgp0aGFua3MsCgpncmVnIGstaApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
