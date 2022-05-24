Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA060C433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 17:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 816B461249;
	Tue, 24 May 2022 17:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id beLPk48gbbfi; Tue, 24 May 2022 17:47:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5945660E98;
	Tue, 24 May 2022 17:47:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F915C0039;
	Tue, 24 May 2022 17:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A618C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 17:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E495B40598
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 17:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSf2CVsKtW9M for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 17:47:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 021E74054E
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 17:47:26 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-2ec42eae76bso189761427b3.10
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
 b=bZjveAEaUMpvjHfz1Cch8bK+pwqo5wReSl7Ni1ySDkX7vgB+ELyVHAsXpIXDy/NzwQ
 F/baQeyilKuLVyVSZ3e3AFkWzCGjLP/qgdKtUY8I6Yt9r3cYFnDW2ohFYoNsEKr6MYS5
 lTj9Ai76LjkVrc+uNTqmiubbz+0pmokn7RIRVfhrsz/Hy9byfa+AQQHsnVEgdDlwIs+L
 /MVtlD/qzhhotKGBMHeGk5luHST+bgqa6sQdqklFRiQXgo7W6TChKNkAQk57YkYZePEG
 mNoW/y/qBqR0twFm26Kyrx/dG4oRQ86aObRbtuGaU8bvLjKWJQHgSKYtBQFQLNzrfScW
 bbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e6VPETmeyZX5JOF6lrU6bxZMJd0n0GPwABfSqTucdjs=;
 b=B2bf8a98r7v4EgekWJ/m595mArR8nQpHojLd+8IL5HiAjhr28RqLMRFPDMQn6X78Iq
 bDzzdGw67H2yoHYliI+0CzfFoCmhQ1foBIRCVhOfE6AKMe+6XMX1cjZpRtAxyD7YrJeo
 +MWVVPiOzzpKu1WjoQyz5/r+sYwCZ3WuH19FSgkvjg1YHd6Fr+ZNpZusjURIBRguR9oo
 PTW5N8QeYOGs6XGULd9VAIR99oINA8DjGzWo0N3/1TW8k3M7dmqVGBSbqwrnNA61g18Y
 wbMsWD0KkEs13VtisFhOwLhmVNpcbY/kxwKUx6yExLCqc8CE8MadFP0kRM7iNYB9xHMv
 BpiA==
X-Gm-Message-State: AOAM530QQh7UH6vrXLNqItEsk/Gbz4aNdcsywRXBJ6UZKDY2QpVwFU7D
 oSzTEcrhaxJiP6F3K/GLd5jsOxwKIGex4SQNZ6l49Q==
X-Google-Smtp-Source: ABdhPJywyPDKCAP33MtzxfXuYMCC6HltN18smuTT+NiEjrolMWs5gH6m5KLHG22tADmM3eKx+ae1gKCOsi42FnXISCA=
X-Received: by 2002:a0d:e903:0:b0:2ff:43a3:90c8 with SMTP id
 s3-20020a0de903000000b002ff43a390c8mr29118839ywe.455.1653414445758; Tue, 24
 May 2022 10:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
 <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de>
In-Reply-To: <Yo0KyWx+3oX3cMCS@linutronix.de>
Date: Tue, 24 May 2022 10:46:49 -0700
Message-ID: <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVHVlLCBNYXkgMjQsIDIwMjIgYXQgOTo0MSBBTSBTZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9y
CjxiaWdlYXN5QGxpbnV0cm9uaXguZGU+IHdyb3RlOgo+Cj4gT24gMjAyMi0wNS0yMyAyMDo0Mzow
NiBbLTA3MDBdLCBTYXJhdmFuYSBLYW5uYW4gd3JvdGU6Cj4g4oCmCj4gPiBUaGFua3MgZm9yIGFs
bCB0aGUgaGVscC4gSSB0aGluayBJIGtub3cgd2hhdCdzIGdvaW5nIG9uLgo+Cj4gSSwgdG9vIGdv
dCBoZXJlIGJlY2F1c2UgbXkgYm9vdCByZWNlbnRseSB3YXMgZXh0ZW5kZWQgYnkgMTAgc2Vjb25k
cyBhbmQKPiBiaXNlY3RlZCB0byB0aGF0IGNvbW1pdCBpbiBxdWVzdGlvbi4KPgo+ID4gSWYgeW91
IHJldmVydCB0aGUgZm9sbG93aW5nIGNvbW1pdCwgdGhlbiB5b3UnbGwgc2VlIHRoYXQgeW91ciBk
ZXZpY2UKPiA+IG5vIGxvbmdlciBoYW5ncyB3aXRoIG15IGNoYW5nZXMuCj4gPiAzNWE2NzIzNjNh
YjMgZHJpdmVyIGNvcmU6IEVuc3VyZSB3YWl0X2Zvcl9kZXZpY2VfcHJvYmUoKSB3YWl0cyB1bnRp
bAo+ID4gdGhlIGRlZmVycmVkX3Byb2JlX3RpbWVvdXQgZmlyZXMKPgo+IFJlbW92aW5nIHByb2Jl
X3RpbWVvdXRfd2FpdHF1ZXVlIChhcyBzdWdnZXN0ZWQpIG9yIHNldHRpbmcgdGhlIHRpbWVvdXQK
PiB0byAwIGF2b2lkcyB0aGUgZGVsYXkuCgpJbiB5b3VyIGNhc2UsIEkgdGhpbmsgaXQgbWlnaHQg
YmUgd29ya2luZyBhcyBpbnRlbmRlZD8gQ3VyaW91cywgd2hhdAp3YXMgdGhlIGNhbGwgc3RhY2sg
aW4geW91ciBjYXNlIHdoZXJlIGl0IHdhcyBibG9ja2VkPwoKLVNhcmF2YW5hCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
