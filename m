Return-Path: <SRS0=O6fU=K7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0167C47082
	for <iommu@archiver.kernel.org>; Sat,  5 Jun 2021 12:29:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D828613F9
	for <iommu@archiver.kernel.org>; Sat,  5 Jun 2021 12:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D828613F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2055B60795;
	Sat,  5 Jun 2021 12:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPCrzvl8GU0U; Sat,  5 Jun 2021 12:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E675606B4;
	Sat,  5 Jun 2021 12:29:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B653C000D;
	Sat,  5 Jun 2021 12:29:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2083CC0001
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 12:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EF53683AEF
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 12:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="IWPbj+jS";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="ADM+zxMe"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3tr6_kD2aHYh for <iommu@lists.linux-foundation.org>;
 Sat,  5 Jun 2021 12:29:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70FCD833C6
 for <iommu@lists.linux-foundation.org>; Sat,  5 Jun 2021 12:29:12 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3E26D5804A2;
 Sat,  5 Jun 2021 08:29:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute3.internal (MEProxy); Sat, 05 Jun 2021 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type:content-transfer-encoding; s=fm1; bh=1R
 bQgq677nj7G3MUumWQjelLqbrdkBM2pt/CFGcdDww=; b=IWPbj+jS3yyI1hVyW5
 5sN1YgyHOAAM6fqrk2zzGemytyt9Y3iPjsLueBl2TBunTetDC5YbPeGP9y681UJZ
 0k39tUpGZjoiwtDxSXs3VNq+qyspKPfIwoVGz8Sy/zVqp+elJ8Q7TpWLcagAfzTG
 Fl2uhYittvM3zHEWKL6nrG+tY+pyy/9t6iNUwpaPkiYMHZN0LrN9YR8MxzTBo9ks
 kh9JYRUCbjEUPOv9tcBfmvICu690LGywZIq8K0jM+D91SCSt1EYv65huFmOYg+30
 cFj11jFs5i3ieoJWrjeSERdBJ1s88ukANXH/1BYjic7uA3b/KO6/JbhtI+hgbNgw
 Y5ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=1RbQgq677nj7G3MUumWQjelLqbrdkBM2pt/CFGcdD
 ww=; b=ADM+zxMegh80UeqCKmGjOf/Ocfu3mACp0SHiArW5qzrB2UqrIe+7He8GL
 CMuL7ZIHXeyUjBISAuo3oZ6RxK/k4QIzexC9QyF0ty+ERyD0lAFZKeTvZYCIHHut
 zHY0MMM5x6LtZoUHPVCBHZxljMhWK3s1TgZt6aXDewrd7w24MwAWntciDl92O3Bf
 ctxryzULFb8rbi3zEoklA2O0VbBHGPip7rnooYhB1EktosG+U+aaKI5mNa5GWErV
 VWKKPulJc8i/JLr0cUe+wnIk/NOsjDPOS2B/G8mMRyonIf9itbQouiIfZWaRwLfD
 5I4G0bX8ilWu4IbaMmcFgfyMJFTWw==
X-ME-Sender: <xms:E267YA39LqHB289QpI4QO7j05cWK08AKUAPP9lSSZ2r2zb0duLytwA>
 <xme:E267YLGITa5dwhee8kYQuI9Q8vvLb4wg9SvS9Vl214JzjnRJp03Wpf1N2fo6W0_8N
 V5iAI5hm74zrKT9QGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtfedgheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepteeuudelteefueelvdelheehieevvdfhkeehjeejudfhieelffffudfh
 keeileegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:E267YI6RXlh8AhpHUhLk-4BU1A25EogzJYRqZLkSE_vJCYyZ1_XRbA>
 <xmx:E267YJ351C6D4mO9SnISqYVNpzlJnt3GUyvSeDcm0rWSM6PyuY-4Xg>
 <xmx:E267YDEa8cc8BCZT5XSe1GJzDdSgVWHzQ_brkAp-bV_bXf7cd2hB8w>
 <xmx:Fm67YDGLMS-_IYXnr35e9TtPqCVqR9RrTjXnmM3GYqXGSP7El6S0EA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E519451C0060; Sat,  5 Jun 2021 08:29:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <89b391d1-c076-491a-97c0-d08593c006e7@www.fastmail.com>
In-Reply-To: <d50ad9392f7719c01f752e73a00d4dc83b1a5c5c.camel@pengutronix.de>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-4-sven@svenpeter.dev>
 <d50ad9392f7719c01f752e73a00d4dc83b1a5c5c.camel@pengutronix.de>
Date: Sat, 05 Jun 2021 14:28:27 +0200
To: "Rouven Czerwinski" <r.czerwinski@pengutronix.de>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] iommu: dart: Add DART iommu driver
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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

SGkgUm91dmVuLAoKT24gU2F0LCBKdW4gNSwgMjAyMSwgYXQgMTM6NTAsIFJvdXZlbiBDemVyd2lu
c2tpIHdyb3RlOgo+IEhpIFN2ZW4sCj4gCj4ganVzdCBhIHNtYWxsIGNvbW1lbnQsIHNlZSBpbmxp
bmUuCj4gCj4gT24gVGh1LCAyMDIxLTA2LTAzIGF0IDEwOjUwICswMjAwLCBTdmVuIFBldGVyIHdy
b3RlOgo+ID4gKwo+ID4gKy8qIG11c3QgYmUgY2FsbGVkIHdpdGggaGVsZCBkYXJ0X2RvbWFpbi0+
bG9jayAqLwo+IAo+IFlvdSBjYW4gcmVtb3ZlIHRoaXMgY29tbWVudCwgaW5jbHVkZSBsb2NrZGVw
LmggYW5k4oCmCj4gCj4gPiArc3RhdGljIGludCBhcHBsZV9kYXJ0X2ZpbmFsaXplX2RvbWFpbihz
dHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pCj4gPiArewo+ID4gKwlzdHJ1Y3QgYXBwbGVfZGFy
dF9kb21haW4gKmRhcnRfZG9tYWluID0gdG9fZGFydF9kb21haW4oZG9tYWluKTsKPiA+ICsJc3Ry
dWN0IGFwcGxlX2RhcnQgKmRhcnQgPSBkYXJ0X2RvbWFpbi0+ZGFydDsKPiA+ICsJc3RydWN0IGlv
X3BndGFibGVfY2ZnIHBndGJsX2NmZzsKPiA+ICsKPiAKPiAJbG9ja2RlcF9hc3NlcnRfaGVsZCgm
ZGFydF9kb21haW4tPmxvY2spOwo+IAo+IEEgbG9ja2RlcCBlbmFibGVkIGtlcm5lbCB3aWxsIHdh
cm4gaWYgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aG91dAo+IHRoZSBsb2NrIGhlbGQsIG90
aGVyd2lzZSB0aGlzIGdldHMgb3B0aW1pemVkIG91dC4gU2FtZSBmb3IgdGhlIHNpbWlsYXIKPiBj
b21tZW50cyBiZWxvdy4KPiAKClRoYXQgbG9va3MgdmVyeSB1c2VmdWwsIHRoYW5rcyEgV2lsbCB1
c2UgaXQgZm9yIHY0LgoKSSBvbmx5IGZvdW5kIGFzc2VydF9zcGluX2xvY2tlZCBvcmlnaW5hbGx5
IGJ1dCBkaWRuJ3Qgd2FudCB0byBoYXZlIHRoYXQKcGVyZm9ybWFuY2Ugb3ZlcmhlYWQgZm9yIGNv
ZGUgdGhhdCAoSSBob3BlIDotKSkgY29ycmVjdGx5IHVzZXMgdGhlc2UgZnVuY3Rpb25zCndpdGgg
YSBoZWxkIGxvY2sgcmlnaHQgbm93LgoKClRoYW5rcywKCgpTdmVuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
