Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D798EC04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8632087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZRwoRSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8632087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B702DC7D;
	Fri, 17 May 2019 19:05:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0542AB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 684315E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:12 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id w8so8166841wrl.6
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
	b=ZZRwoRSb1PL/97jGRmzSD44FfFvnZd2iIqEeVhOF3VrLEp9vzAWHatj2PBKWjdz7r1
	yg52bRI0/h8oCYPFhaTaKKThP9PlSn9gRGQt2rUvGnvG9eLmfL73zySDWEsuKGAVa2nK
	9pkwIYCCYzqBP6tfJ9kbGX0jZep2rcV5YEVqufDdd2NbwkkhEW7b8XDabGkEyuaudPT3
	Bf6ynCNlrdw878zv8/FHYA9Mcbvq9E6roUjTWsYVlYLrbwFXXPuEFJYV8f+uG6Ljrlhf
	YYRGkUj5ohV2j0C1nSbkpjJke7iX6ZDj6uEO0eZZuyMu/SZEIGvjAfkl5WObHWgLGYCv
	LIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uWjp5N7/2gycMhkjj4F7Je3PI1NUTqU00O1ySy3vSNY=;
	b=IzSj2cbkYTbRYp035C8eOICD/fWezkJcMurL05wij/1B+Njd1+WWNO5yYtqOI9xFfU
	/ftUUuzHJo41xPpOfa7Ld0G+ZnYHb7Me/Lh3vt8dzpp1NZQ0mxzQmcmDIHqP3PK8r60Y
	nNvLwkD9KAYVipzlWDHgHBf6gJjwyI44bmvH2KE3Jxlt43aKeOMqapRhhpIDLBs5qBxX
	TgdJSizpx910VirrOElGXHpi0lfD1hrP/P4xbJzoEiLduTceJTvmJP7/PSXsFKmmArNY
	YM0+/nQq0qb/pm7icyH6wL6QvT5zm3gKcCikq96rJwalmrD9qKsa2vGi/a8aknZItTES
	MBSQ==
X-Gm-Message-State: APjAAAWs9+hskzs4d6Fp1NwgGAfPekRGWR22idTMJoboAN7Ei4AvigiM
	ZByEklwhH424bi03RTXyhLc=
X-Google-Smtp-Source: APXvYqwBJ1PZ+mVOlD7wgBOxP5lzlCYxaqUa2bsvWXXFw9/yU+63xVcCkN1xYNthpr6aPrD+TDolfg==
X-Received: by 2002:adf:de82:: with SMTP id w2mr24718302wrl.53.1558118830993; 
	Fri, 17 May 2019 11:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:10 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 4/6] dt-bindings: gpu: mali-midgard: Add H6 mali gpu
	compatible
Date: Fri, 17 May 2019 20:46:57 +0200
Message-Id: <20190517184659.18828-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 May 2019 19:05:24 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

VGhpcyBhZGQgdGhlIEg2IG1hbGkgY29tcGF0aWJsZSBpbiB0aGUgZHQtYmluZGluZ3MgdG8gbGF0
ZXIgc3VwcG9ydApzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbi4KClNpZ25lZC1vZmYtYnk6IENsw6lt
ZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPgotLS0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0s
bWFsaS1taWRnYXJkLnR4dCAgICAgICAgIHwgOSArKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLW1pZGdhcmQudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dAppbmRleCAy
ZThiYmNlMzU2OTUuLjRiZjE3ZTFjZjU1NSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1taWRnYXJkLnR4dAorKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L2FybSxtYWxpLW1pZGdhcmQudHh0CkBAIC0xNSw2
ICsxNSw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6CiAgICAgKyAiYXJtLG1hbGktdDg2MCIKICAg
ICArICJhcm0sbWFsaS10ODgwIgogICAqIHdoaWNoIG11c3QgYmUgcHJlY2VkZWQgYnkgb25lIG9m
IHRoZSBmb2xsb3dpbmcgdmVuZG9yIHNwZWNpZmljczoKKyAgICArICJhbGx3aW5uZXIsc3VuNTBp
LWg2LW1hbGkiCiAgICAgKyAiYW1sb2dpYyxtZXNvbi1neG0tbWFsaSIKICAgICArICJyb2NrY2hp
cCxyazMyODgtbWFsaSIKICAgICArICJyb2NrY2hpcCxyazMzOTktbWFsaSIKQEAgLTQ5LDkgKzUw
LDE1IEBAIFZlbmRvci1zcGVjaWZpYyBiaW5kaW5ncwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAKIFRoZSBNYWxpIEdQVSBpcyBpbnRlZ3JhdGVkIHZlcnkgZGlmZmVyZW50bHkgZnJvbSBvbmUg
U29DIHRvCi1hbm90aGVyLiBJbiBvcmRlciB0byBhY2NvbW9kYXRlIHRob3NlIGRpZmZlcmVuY2Vz
LCB5b3UgaGF2ZSB0aGUgb3B0aW9uCithbm90aGVyLiBJbiBvcmRlciB0byBhY2NvbW1vZGF0ZSB0
aG9zZSBkaWZmZXJlbmNlcywgeW91IGhhdmUgdGhlIG9wdGlvbgogdG8gc3BlY2lmeSBvbmUgbW9y
ZSB2ZW5kb3Itc3BlY2lmaWMgY29tcGF0aWJsZSwgYW1vbmc6CiAKKy0gImFsbHdpbm5lcixzdW41
MGktaDYtbWFsaSIKKyAgUmVxdWlyZWQgcHJvcGVydGllczoKKyAgLSBjbG9ja3MgOiBwaGFuZGxl
cyB0byBjb3JlIGFuZCBidXMgY2xvY2tzCisgIC0gY2xvY2stbmFtZXMgOiBtdXN0IGNvbnRhaW4g
ImNvcmUiIGFuZCAiYnVzIgorICAtIHJlc2V0czogcGhhbmRsZSB0byBHUFUgcmVzZXQgbGluZQor
CiAtICJhbWxvZ2ljLG1lc29uLWd4bS1tYWxpIgogICBSZXF1aXJlZCBwcm9wZXJ0aWVzOgogICAt
IHJlc2V0cyA6IFNob3VsZCBjb250YWluIHBoYW5kbGVzIG9mIDoKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBs
aXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
