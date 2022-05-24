Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C04CC433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 16:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3614182D96;
	Tue, 24 May 2022 16:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNjP6rIkV_0h; Tue, 24 May 2022 16:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E7E3832D0;
	Tue, 24 May 2022 16:41:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03D76C0032;
	Tue, 24 May 2022 16:41:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A144BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F31C82D96
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qot7rmhMDzJQ for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 16:41:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5616832D0
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:41:50 +0000 (UTC)
Date: Tue, 24 May 2022 18:41:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1653410507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK2eEOx7qW4qJHtFCm6AqFTk2cYYBK5VN6M5h7/LPJY=;
 b=RpxUjmeXaoO/cBMYYtR+W0dgahHZXn+pWhavM1CLX7ZfQbTpfWIlyVxXP2YkVVmh2rwFni
 oLUkOWEklbTTdrrQ7EBqMg9VljxqAkk2RMpDM3IceQGLMwRX/iWplU9ypzMYYcF6rIsNq5
 gEQ4o1/jjw0KCo+cUaPASqE1n/pDEduI0UjFZDyXV0oSZG/MAsghi4jn0Q2Rgd5KSWzxGx
 bQvfZfriHlwfgaQV7kIhJvTA4aJo6Sat/396ZLjHmqW288KyLlFNIavuowjRfXYfA7qDR7
 byhLkWlIiN/whQv1P/8pn5vO4+sDy2ImQNzEoKhEtwkvfwviQyVSr29nT72Agg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1653410507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK2eEOx7qW4qJHtFCm6AqFTk2cYYBK5VN6M5h7/LPJY=;
 b=/mpKm9K+KmM77y1Sv2U9sqow5FiO6MRm6Pw38G0V5vb80cMf3MtUbFzjWo6JzMqnXUz52M
 Ak5KSCUA8QKj4tCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <Yo0KyWx+3oX3cMCS@linutronix.de>
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
 <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
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

T24gMjAyMi0wNS0yMyAyMDo0MzowNiBbLTA3MDBdLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6CuKA
pgo+IFRoYW5rcyBmb3IgYWxsIHRoZSBoZWxwLiBJIHRoaW5rIEkga25vdyB3aGF0J3MgZ29pbmcg
b24uCgpJLCB0b28gZ290IGhlcmUgYmVjYXVzZSBteSBib290IHJlY2VudGx5IHdhcyBleHRlbmRl
ZCBieSAxMCBzZWNvbmRzIGFuZApiaXNlY3RlZCB0byB0aGF0IGNvbW1pdCBpbiBxdWVzdGlvbi4K
Cj4gSWYgeW91IHJldmVydCB0aGUgZm9sbG93aW5nIGNvbW1pdCwgdGhlbiB5b3UnbGwgc2VlIHRo
YXQgeW91ciBkZXZpY2UKPiBubyBsb25nZXIgaGFuZ3Mgd2l0aCBteSBjaGFuZ2VzLgo+IDM1YTY3
MjM2M2FiMyBkcml2ZXIgY29yZTogRW5zdXJlIHdhaXRfZm9yX2RldmljZV9wcm9iZSgpIHdhaXRz
IHVudGlsCj4gdGhlIGRlZmVycmVkX3Byb2JlX3RpbWVvdXQgZmlyZXMKClJlbW92aW5nIHByb2Jl
X3RpbWVvdXRfd2FpdHF1ZXVlIChhcyBzdWdnZXN0ZWQpIG9yIHNldHRpbmcgdGhlIHRpbWVvdXQK
dG8gMCBhdm9pZHMgdGhlIGRlbGF5LgoKPiAtU2FyYXZhbmEKClNlYmFzdGlhbgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
