Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD2EC433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 07:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1FEE408DD;
	Wed, 25 May 2022 07:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNGMpRrlZ3GG; Wed, 25 May 2022 07:12:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45CE2408DA;
	Wed, 25 May 2022 07:12:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25D05C0032;
	Wed, 25 May 2022 07:12:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6298FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 495D0408D6
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PRDnTRvgwr7d for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 07:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DF2B4086A
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:12:05 +0000 (UTC)
Date: Wed, 25 May 2022 09:11:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1653462718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+orsWNjWtAwiggB87niLJ7T2vo66GNbCnC4aWo769UQ=;
 b=tXIaQWvesmewK1SQvqwWgjKsyAyyIrLjEanwcNAy2h/P5FMGq/kJgWZClGgDeKmANuYAkW
 6I7SL146oVeYMmgPOm/K/5ULiZwNsVMQKo5zuy5USu5ms+bQvLeomBnv/Y7RF7ep6r43Fg
 yrE+GteNpeB84vc7KB5yHCiGDGSLxpJF9n26BehK7VVK2KwTS1qiOtnBNXBBg3s07zq9LZ
 QuC90oOJFyjhHJqpIG4b7pe7LqIsPAYDmbR2tbrm4G6CKN84jA5eTlcpkoSp3W47VVgETh
 utsXLbJ9WiKBewsE1+4q4+5PmLVYRznaktasLTJPtcPFwgqlSj1UxEdIbhT9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1653462718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+orsWNjWtAwiggB87niLJ7T2vo66GNbCnC4aWo769UQ=;
 b=1vNUO3Dakuo2lI9Z/n9vsWIZ8Loex9gUHN2zaefzYBYblmfryFJ25az2ZrOSX+XZBIv9t6
 eUlvctYCzDyGwvCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <Yo3WvGnNk3LvLb7R@linutronix.de>
References: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
 <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de>
 <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, John Stultz <jstultz@google.com>,
 Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <treding@nvidia.com>,
 kernel-team@android.com, linux-pm@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 iommu@lists.linux-foundation.org
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

T24gMjAyMi0wNS0yNCAxMDo0Njo0OSBbLTA3MDBdLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6Cj4g
PiBSZW1vdmluZyBwcm9iZV90aW1lb3V0X3dhaXRxdWV1ZSAoYXMgc3VnZ2VzdGVkKSBvciBzZXR0
aW5nIHRoZSB0aW1lb3V0Cj4gPiB0byAwIGF2b2lkcyB0aGUgZGVsYXkuCj4gCj4gSW4geW91ciBj
YXNlLCBJIHRoaW5rIGl0IG1pZ2h0IGJlIHdvcmtpbmcgYXMgaW50ZW5kZWQ/IEN1cmlvdXMsIHdo
YXQKPiB3YXMgdGhlIGNhbGwgc3RhY2sgaW4geW91ciBjYXNlIHdoZXJlIGl0IHdhcyBibG9ja2Vk
PwoKV2h5IGlzIHRoZW4gdGhlcmUgMTBzZWMgZGVsYXkgZHVyaW5nIGJvb3Q/IFRoZSBiYWNrdHJh
Y2UgaXMKfC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQp8V0FSTklORzogQ1BV
OiA0IFBJRDogMSBhdCBkcml2ZXJzL2Jhc2UvZGQuYzo3NDIgd2FpdF9mb3JfZGV2aWNlX3Byb2Jl
KzB4MzAvMHgxMTAKfE1vZHVsZXMgbGlua2VkIGluOgp8Q1BVOiA0IFBJRDogMSBDb21tOiBzd2Fw
cGVyLzAgTm90IHRhaW50ZWQgNS4xOC4wLXJjNSsgIzE1NAp8UklQOiAwMDEwOndhaXRfZm9yX2Rl
dmljZV9wcm9iZSsweDMwLzB4MTEwCnxDYWxsIFRyYWNlOgp8IDxUQVNLPgp8IHByZXBhcmVfbmFt
ZXNwYWNlKzB4MmIvMHgxNjAKfCBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDJiMy8weDJkZAp8IGtl
cm5lbF9pbml0KzB4MTEvMHgxMTAKfCByZXRfZnJvbV9mb3JrKzB4MjIvMHgzMAp8IDwvVEFTSz4K
Ckxvb2tpbmcgY2xvc2VyLCBpdCBjYW4ndCBhY2Nlc3MgaW5pdC4gVGhpcyBpbiBwYXJ0aWN1bGFy
IGJveCBib290cwpkaXJlY3RseSB0aGUga2VybmVsIHdpdGhvdXQgYW4gaW5pdHJhbWZzIHNvIHRo
ZSBrZXJuZWwgbGF0ZXIgbW91bnRzCi9kZXYvc2RhMSBhbmQgZXZlcnl0aGluZyBpcyBnb29kLiAg
U28gdGhhdCBzZWVtcyB0byBiZSB0aGUgcmVhc29u4oCmCk15IG90aGVyIG1hY2hpbmUgd2l0aCBh
biBpbml0cmFtZnMgZG9lcyBub3Qgc2hvdyB0aGlzIHByb2JsZW0uCgo+IC1TYXJhdmFuYQoKU2Vi
YXN0aWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
