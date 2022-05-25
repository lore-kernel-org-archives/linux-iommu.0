Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AA8C433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 19:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4148B40176;
	Wed, 25 May 2022 19:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NT_fOMG_EJ0l; Wed, 25 May 2022 19:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E5DF40931;
	Wed, 25 May 2022 19:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8AC4C0032;
	Wed, 25 May 2022 19:49:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10C72C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 19:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDFE140931
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 19:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sfg4c3DqvOqI for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 19:49:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A47440176
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 19:49:38 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-30026b1124bso68735587b3.1
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
 b=hGvqDCPINlCno6IGVx/RQ4/atSQ+dW08eMaP/4u4J2Rx0AU21Orr25m5AgNUJgVoBC
 3FFOnaz5xSM9a3RRyGWmmLYgiZVdvKzEmj7vsHFg6Sh7EwGqNKrvH43xPCnlETqRbyTJ
 rUgPCSCAGnF+I3fcFxMltq5wx33LgoLK4ERO4IR4Sot/Uaxxldi6tkX+WdLxAvCCiEtI
 QP4xUPzpC2rlJZR8sd1n3W8vuHEHoaO4LC9YRcKisj9Uq+DszGcvpWkcK75IpZtbpf64
 JIxJLJ+6BngIh5kjOcaFiUEdbJbMoovEHpIlAtRm4xeoQYYTe1wf9PGaYkAV8y48Abi0
 +6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lcsU1M3aHmWM93+N/Pq2k69CNkfyIQUCxczoLH0OLPk=;
 b=HJrjOJ7C+QLFHlHszKCA5A2VKw3WypCk2W2pzhMPrRcbN9lnOA6h8ydS+fDKYbCQeU
 LU2v4h7V0GWIuJBBroixVy7G5F3F14qD2AB0L3tCoVBjIeTYZpLeFiB+WvTQTmSuP1A2
 nQGgsCExxB/WZrgs53i8UsTo3MEBirATJsvhvxlYNfGJ4fIbiYxXGBwdYJZx8uSWaheI
 5k7gD7+OG9zsTWbiSmfMq4PkWf9ywroiIv4vJfqBrUIieXHOOlLNePUGYZfxBcd1YlLd
 Jpgta+wnaI2aao7qApG6b5b3fDGIg7mqbgsKBjkjHXBfiMBzv7MEQ4xJRha/Z+LUkxcK
 nKmQ==
X-Gm-Message-State: AOAM530bR2XxjQNW4ReICzl3NkRPoKBqVBd2bGuxRQ8W2HUaOnWFqy2M
 wMTOSsB/dlwfDtoMCsLllc9wbs8yJ6h90bHdp1yqMw==
X-Google-Smtp-Source: ABdhPJye/LYmXdbx2DRGvhYd77idEIGqJLpVK4M7sUVcSaytWZ/KajOi10nwmyuJy9EQw0Od4wYghiCxgCclb01GpVs=
X-Received: by 2002:a81:72c5:0:b0:300:7d0:a642 with SMTP id
 n188-20020a8172c5000000b0030007d0a642mr14402533ywc.80.1653508177547; Wed, 25
 May 2022 12:49:37 -0700 (PDT)
MIME-Version: 1.0
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
 <Yo3WvGnNk3LvLb7R@linutronix.de>
In-Reply-To: <Yo3WvGnNk3LvLb7R@linutronix.de>
Date: Wed, 25 May 2022 12:49:00 -0700
Message-ID: <CAGETcx84ja_w_=vXKDOZnM8EVEcuAg1tX9Kqy57PTkDb1=H4FA@mail.gmail.com>
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

T24gV2VkLCBNYXkgMjUsIDIwMjIgYXQgMTI6MTIgQU0gU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lv
cgo8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cm90ZToKPgo+IE9uIDIwMjItMDUtMjQgMTA6NDY6
NDkgWy0wNzAwXSwgU2FyYXZhbmEgS2FubmFuIHdyb3RlOgo+ID4gPiBSZW1vdmluZyBwcm9iZV90
aW1lb3V0X3dhaXRxdWV1ZSAoYXMgc3VnZ2VzdGVkKSBvciBzZXR0aW5nIHRoZSB0aW1lb3V0Cj4g
PiA+IHRvIDAgYXZvaWRzIHRoZSBkZWxheS4KPiA+Cj4gPiBJbiB5b3VyIGNhc2UsIEkgdGhpbmsg
aXQgbWlnaHQgYmUgd29ya2luZyBhcyBpbnRlbmRlZD8gQ3VyaW91cywgd2hhdAo+ID4gd2FzIHRo
ZSBjYWxsIHN0YWNrIGluIHlvdXIgY2FzZSB3aGVyZSBpdCB3YXMgYmxvY2tlZD8KPgo+IFdoeSBp
cyB0aGVuIHRoZXJlIDEwc2VjIGRlbGF5IGR1cmluZyBib290PyBUaGUgYmFja3RyYWNlIGlzCj4g
fC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+IHxXQVJOSU5HOiBDUFU6IDQg
UElEOiAxIGF0IGRyaXZlcnMvYmFzZS9kZC5jOjc0MiB3YWl0X2Zvcl9kZXZpY2VfcHJvYmUrMHgz
MC8weDExMAo+IHxNb2R1bGVzIGxpbmtlZCBpbjoKPiB8Q1BVOiA0IFBJRDogMSBDb21tOiBzd2Fw
cGVyLzAgTm90IHRhaW50ZWQgNS4xOC4wLXJjNSsgIzE1NAo+IHxSSVA6IDAwMTA6d2FpdF9mb3Jf
ZGV2aWNlX3Byb2JlKzB4MzAvMHgxMTAKPiB8Q2FsbCBUcmFjZToKPiB8IDxUQVNLPgo+IHwgcHJl
cGFyZV9uYW1lc3BhY2UrMHgyYi8weDE2MAo+IHwga2VybmVsX2luaXRfZnJlZWFibGUrMHgyYjMv
MHgyZGQKPiB8IGtlcm5lbF9pbml0KzB4MTEvMHgxMTAKPiB8IHJldF9mcm9tX2ZvcmsrMHgyMi8w
eDMwCj4gfCA8L1RBU0s+Cj4KPiBMb29raW5nIGNsb3NlciwgaXQgY2FuJ3QgYWNjZXNzIGluaXQu
IFRoaXMgaW4gcGFydGljdWxhciBib3ggYm9vdHMKPiBkaXJlY3RseSB0aGUga2VybmVsIHdpdGhv
dXQgYW4gaW5pdHJhbWZzIHNvIHRoZSBrZXJuZWwgbGF0ZXIgbW91bnRzCj4gL2Rldi9zZGExIGFu
ZCBldmVyeXRoaW5nIGlzIGdvb2QuICBTbyB0aGF0IHNlZW1zIHRvIGJlIHRoZSByZWFzb27igKYK
CkhtbW0uLi4gdGhhdCBwYXJ0IHNob3VsZG4ndCBtYXR0ZXIuIEFzIGxvbmcgYXMgeW91IGFyZSBo
aXR0aW5nIHRoZQpzYW1lIGNvZGUgcGF0aC4gTXkgZ3Vlc3MgaXMgb25lIG9mIHRoZW0gaGFzIENP
TkZJR19NT0RVTEVTIGVuYWJsZWQgYW5kCnRoZSBvdGhlciBkb2Vzbid0LgoKSW4gZWl0aGVyIGNh
c2UsIEkgdGhpbmsgdGhlIHBhdGNoIG5lZWRzIHRvIGJlIHJldmVydGVkIChJJ2xsIHNlbmQgb3V0
Cm9uZSBzb29uKSwgYnV0IHRoYXQnbGwgYWxzbyBtZWFuIEkgbmVlZCB0byByZXZlcnQgcGFydCBv
ZiBteSBwYXRjaAooc2V0cyB0aGUgdGltZW91dCBiYWNrIHRvIDApIG9yIEkgbmVlZCB0byBmaXgg
dGhpcyBjYXNlOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1RZQVBSMDFNQjQ1NDQzREY2
M0I5RUYyOTA1NEY3QzQxRkQ4QzYwQFRZQVBSMDFNQjQ1NDQuanBucHJkMDEucHJvZC5vdXRsb29r
LmNvbS8KCkknbGwgdHJ5IHRvIGRvIHRoZSBsYXR0ZXIgaWYgSSBjYW4gZ2V0IHNvbWV0aGluZyBy
ZWFzb25hYmxlIHNvb24uCk90aGVyd2lzZSwgSSdsbCBqdXN0IGRvIHRoZSByZXZlcnQgKyBwYXJ0
aWFsIHJldmVydC4KCi1TYXJhdmFuYQoKCj4gTXkgb3RoZXIgbWFjaGluZSB3aXRoIGFuIGluaXRy
YW1mcyBkb2VzIG5vdCBzaG93IHRoaXMgcHJvYmxlbS4KPgo+ID4gLVNhcmF2YW5hCj4KPiBTZWJh
c3RpYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
