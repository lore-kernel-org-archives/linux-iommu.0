Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F030C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:23:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B816113B
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2B816113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72ABF40565;
	Tue, 19 Oct 2021 16:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmTV4a0iOi_e; Tue, 19 Oct 2021 16:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C660400CB;
	Tue, 19 Oct 2021 16:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D14FC000F;
	Tue, 19 Oct 2021 16:23:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DFD3C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2617A60BF0
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="GgSDP4yz";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="EACkSxiE"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2YEy1XDDeGx for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:23:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34256606B6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:23:39 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 526685C010E;
 Tue, 19 Oct 2021 12:23:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 19 Oct 2021 12:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm2; bh=tmiWcW1U2H7HD7ZqjARSJDD89e
 tBKl7zqS3q5UFeQW8=; b=GgSDP4yzzqrXdJCTO3IzT6b+dw0FWxdVZj7vubJw9v
 ygV8QvgwBr/TFHrxKbsGEBdhVw6ZwlY79LFjRR7r+i91PSrcMTBlK0k1eZneE3VK
 mtS+ey16k63aTAnLEFnl6SxRREBruq4whCOUOQcB/6slYJHyBkVHapMjwnj/AHI8
 pKI8RGsT10X66hn1l02wxZ3TTHzw4VkMwqlhB97WEtD4Od0B0gA80mis6DkRUDGx
 zJVSdJZBlCgpgOpgDK9rIISzv1J9rYRAgVtaebpKrR7RxxtKPIgEoOh0WfVoj1rf
 TldFo+P1vL6Fo0hfB7eg8gJXb8IELv0gmq6DnaQfiDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tmiWcW
 1U2H7HD7ZqjARSJDD89etBKl7zqS3q5UFeQW8=; b=EACkSxiEcdtJsunW1aiL4t
 1uKch5SVjndL8BY1nXBJKjF2p01rm02vLBoXFZONla9v2OWuXd+Br3gTUqRDd4fM
 REuyv8E0fZxyQ0eKKBwowK5Yzu8pygIORlTf7eSR16K5y/cnziebBqJKcwkdCZSm
 hNkzQuVj3eClI3FpLo6QRGjcP3vDxiWIJ7FsstVGNRDOa2vbRVxFIttjPt5vGXyl
 ZUpQgW6NxTnG9s8oMf78k3h+HbWuXSe6+E730QYEs4Yp/vdxT7rNuqmTezNLZwSR
 L6uf0LEG2WVAUzLkINAo1FuJ99uMoWxIeCT3NLDQF58vilk4EeIZofoQYwXu0Qtg
 ==
X-ME-Sender: <xms:CPFuYez-x0h7JmJyfNRvnugKRkj58IiDPanAh8f8O30-PCwAiUVOjw>
 <xme:CPFuYaSutZ0mcq7JlVgVVjWwE6pzioOxihRm5vx7ye0ziCdY9Umt2hAaUI06Dc-dd
 usk7CapvZCAdE8AVJI>
X-ME-Received: <xmr:CPFuYQUM04-ztrYu-Ne0HQxVKI8UeCvcI6-ynmrCqn1eKQN7_KlYTpugcy9cpZjhH3bhkX15V7tMlKJkEXfGoooEZOLOII6AjyjlEZcvUopfbMkJTueuaSU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepufhvvghnucfr
 vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
 hnpeduheehieetkeejfffggfelkeeivdefvdeuvdeihedvveekvdetgfejieeikefhieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
 esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:CPFuYUgIKIm4bP8Mmw67iKaBcTpYQw2DYbg2R8c30CHVXD9CzS07Ag>
 <xmx:CPFuYQD7H6wejsKieYgASxV_MB4AqMyfHSZYUwE5EoySKfK0OesJAw>
 <xmx:CPFuYVJ7BurBPjwyU_JF690ga4nBzO6LiaqYkedFmPqrVixyi3LJ4w>
 <xmx:CvFuYS33IrnCmcVFoCmCnvQ1h1gXM2kymW5SGyke5zPplgwkuIG9YQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:23:35 -0400 (EDT)
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
Date: Tue, 19 Oct 2021 18:22:53 +0200
Message-Id: <20211019162253.45919-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Cc: =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik@protonmail.com>,
 Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

REFSVCBoYXMgYW4gYWRkaXRpb25hbCBnbG9iYWwgcmVnaXN0ZXIgdG8gY29udHJvbCB3aGljaCBz
dHJlYW1zIGFyZQppc29sYXRlZC4gVGhpcyByZWdpc3RlciBpcyBhIGJpdCByZWR1bmRhbnQgc2lu
Y2UgREFSVF9UQ1IgY2FuIGFscmVhZHkKYmUgdXNlZCB0byBjb250cm9sIGlzb2xhdGlvbiBhbmQg
aXMgdXN1YWxseSBpbml0aWFsaXplZCB0byBEQVJUX1NUUkVBTV9BTEwKYnkgdGhlIHRpbWUgd2Ug
Z2V0IGNvbnRyb2wuIFNvbWUgREFSVHMgKG5hbWVseSB0aGUgb25lIHVzZWQgZm9yIHRoZSBhdWRp
bwpjb250cm9sbGVyKSBob3dldmVyIGhhdmUgc29tZSBzdHJlYW1zIGRpc2FibGVkIGluaXRpYWxs
eS4gTWFrZSBzdXJlIHRob3NlCndvcmsgYnkgaW5pdGlhbGl6aW5nIERBUlRfU1RSRUFNU19FTkFC
TEUgZHVyaW5nIHJlc2V0LgoKUmVwb3J0ZWQtYnk6IE1hcnRpbiBQb3ZpxaFlciA8cG92aWtAcHJv
dG9ubWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFN2ZW4gUGV0ZXIgPHN2ZW5Ac3ZlbnBldGVyLmRl
dj4KLS0tCgpXaGlsZSB0aGlzIGNvdWxkIHRlY2huaWNhbGx5IGNvdW50IGFzIGEgZml4IEkgZG9u
J3QgdGhpbmsgaXQgbmVlZHMgdG8gZ28gdG8KNS4xNSBzaW5jZSBubyBkcml2ZXIgdGhhdCByZXF1
aXJlcyB0aGlzIGlzIGluIHRoZXJlLiBUaGUgZmlyc3QgZHJpdmVyCnRoYXQgbmVlZHMgdGhpcyB3
aWxsIGxpa2VseSBvbmx5IGJlIHJlYWR5IGZvciB0aGUgNS4xNyBtZXJnZSB3aW5kb3cuCgogZHJp
dmVycy9pb21tdS9hcHBsZS1kYXJ0LmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcHBsZS1kYXJ0LmMgYi9kcml2
ZXJzL2lvbW11L2FwcGxlLWRhcnQuYwppbmRleCBjZTkyMTk1ZGI2MzguLjZmOGMyNDBkOGQ0MCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9hcHBsZS1kYXJ0LmMKKysrIGIvZHJpdmVycy9pb21t
dS9hcHBsZS1kYXJ0LmMKQEAgLTcwLDYgKzcwLDggQEAKICNkZWZpbmUgREFSVF9FUlJPUl9BRERS
X0hJIDB4NTQKICNkZWZpbmUgREFSVF9FUlJPUl9BRERSX0xPIDB4NTAKIAorI2RlZmluZSBEQVJU
X1NUUkVBTVNfRU5BQkxFIDB4ZmMKKwogI2RlZmluZSBEQVJUX1RDUihzaWQpICgweDEwMCArIDQg
KiAoc2lkKSkKICNkZWZpbmUgREFSVF9UQ1JfVFJBTlNMQVRFX0VOQUJMRSBCSVQoNykKICNkZWZp
bmUgREFSVF9UQ1JfQllQQVNTMF9FTkFCTEUgQklUKDgpCkBAIC0yOTksNiArMzAxLDkgQEAgc3Rh
dGljIGludCBhcHBsZV9kYXJ0X2h3X3Jlc2V0KHN0cnVjdCBhcHBsZV9kYXJ0ICpkYXJ0KQogCWFw
cGxlX2RhcnRfaHdfZGlzYWJsZV9kbWEoJnN0cmVhbV9tYXApOwogCWFwcGxlX2RhcnRfaHdfY2xl
YXJfYWxsX3R0YnJzKCZzdHJlYW1fbWFwKTsKIAorCS8qIGVuYWJsZSBhbGwgc3RyZWFtcyBnbG9i
YWxseSBzaW5jZSBUQ1IgaXMgdXNlZCB0byBjb250cm9sIGlzb2xhdGlvbiAqLworCXdyaXRlbChE
QVJUX1NUUkVBTV9BTEwsIGRhcnQtPnJlZ3MgKyBEQVJUX1NUUkVBTVNfRU5BQkxFKTsKKwogCS8q
IGNsZWFyIGFueSBwZW5kaW5nIGVycm9ycyBiZWZvcmUgdGhlIGludGVycnVwdCBpcyB1bm1hc2tl
ZCAqLwogCXdyaXRlbChyZWFkbChkYXJ0LT5yZWdzICsgREFSVF9FUlJPUiksIGRhcnQtPnJlZ3Mg
KyBEQVJUX0VSUk9SKTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
