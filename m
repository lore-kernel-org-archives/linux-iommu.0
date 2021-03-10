Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE0C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 22:19:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB7964FC3
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 22:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB7964FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0943E83FF5;
	Wed, 10 Mar 2021 22:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2bkXh5ejD9id; Wed, 10 Mar 2021 22:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F9EC83F0B;
	Wed, 10 Mar 2021 22:19:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2738FC000A;
	Wed, 10 Mar 2021 22:19:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85357C0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 816C943138
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 39aFd6qAlTMM for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 22:19:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C34F443009
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 22:19:25 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id o10so12339216pgg.4
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 14:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=E86sp18F5ikuV/UL0w2a0I3kcFs8CycFV8c4Ty6/Z+c=;
 b=ia/Zj9LAVFb8I28l8N8lom02TthJY1cl4qOeRv6IGghY6RIuzROssWdgQVdM7VDJ6w
 pkdWWXAWMrctdIDwnKZ7knp9SbRZimD82zY3wvGSwZV28765yRGrHCKlx00Nm3KLP6+I
 PWVcy56Upi1PY2QzmdoUxJkcGoyHFkviDYvUFBsYovZkVINr4q/SuMyZeNOIYVcg2bcY
 v+q4ByklnjMzT7CHiEm02v99cAduL/PB8SnCDY8k5nnePz5sd6Q6trObkOatD4IEMGpF
 b8FwlUiIyDttX9uu75GcXxx9KxTLuOSs+qbVgMtTDnmhKd8hBfRx+Gs1zpXVgaoLsHne
 CdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=E86sp18F5ikuV/UL0w2a0I3kcFs8CycFV8c4Ty6/Z+c=;
 b=H21amsEkZ9smks59qmfGONI1Kwkswdiw7lF7JVPVXOzrwmh9K9Ne3jrOvxxP/Pan2Y
 NgHvHefUmPmsS9AVRUhENZi0JDngzylW6JYdeJFgHSUzQgy1ZPWnZW2JjaFzAI1Nh3vy
 BR38DbSNcv0IvoTtiHEQ/FfgMyVwThIMbfftimcXSUs1G3FVR5VQA/yCHy2m93ImVFtN
 oSWnfK3H7LaCOPuB6t1hOScW53QsTJeu7BIXwwDKOH6K4n+/egg9nBHRaxC/2A6Hh+gu
 0y5I1mfR0Os2NA4wY/7eCv2t3JYtzkXmDRbH80pex6tGy8BUHpRxC/0SRudfBNkwYro1
 LVrQ==
X-Gm-Message-State: AOAM533lEsb4MdmCuHWihvzXP3qoCKezhn9YRo5cY4l/NmWsGqAwRR9N
 B+8gVXfURfivX2KqRzArYBg=
X-Google-Smtp-Source: ABdhPJw6xkncCkhOlZRPyeExcrrV/AKaFEqpDfYJc3/FYXqYmxJtQ5lSAXZkyIXQKeUcS31g3+4EMA==
X-Received: by 2002:a63:74d:: with SMTP id 74mr4536077pgh.316.1615414763327;
 Wed, 10 Mar 2021 14:19:23 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g21sm477675pfk.30.2021.03.10.14.19.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Mar 2021 14:19:23 -0800 (PST)
Date: Wed, 10 Mar 2021 14:17:07 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210310221707.GB10431@Asurada-Nvidia>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
 <7714f272-3862-84ac-306d-86363a1c4880@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7714f272-3862-84ac-306d-86363a1c4880@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: guillaume.tucker@collabora.com, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org, linux-kernel@vger.kernel.org
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

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMTE6MjI6NTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDEwLjAzLjIwMjEgMjI6MTMsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGCOgo+
ID4gSSBmb3VuZCB0aGF0IHRoaXMgcGF0Y2ggaW50cm9kdWNlZCBhIHNlcmlvdXMgcmVncmVzc2lv
biBvbiBUZWdyYTMwIHVzaW5nCj4gPiB0b2RheSdzIGxpbnV4LW5leHQuIFRlZ3JhMzAgaGFzIHR3
byAzZCBoL3cgYmxvY2tzIGNvbm5lY3RlZCBpbiBTTEkgYW5kCj4gPiBvbmx5IG9uZSBvZiB0aGUg
YmxvY2tzIGlzIG5vdyBhdHRhY2hlZCB0byBJT01NVSBkb21haW4sIG1lYW5pbmcgdGhhdCBHUFUK
PiA+IGlzIHVudXNhYmxlIG5vdy4gQWxsIDNkLCAyZCBhbmQgZGlzcGxheSBkZXZpY2VzIHNoYXJl
IHRoZSBzYW1lICJEUk0iCj4gPiBncm91cCBvbiBUZWdyYTMwLgo+ID4gCj4gPiBOaWNvbGluLCBw
bGVhc2UgbGV0IG1lIGtub3cgaWYgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMuIEkgbWF5IHRha2UgYSBj
bG9zZXIKPiA+IGxvb2sgYSBkYXkgbGF0ZXIsIGZvciBub3cgSSdsbCBqdXN0IHJldmVydCB0aGlz
IHBhdGNoIGxvY2FsbHkuIFRoYW5rcyBpbgo+ID4gYWR2YW5jZS4KPiA+IAo+IAo+IEFjdHVhbGx5
LCB0aGlzIHdhcyBlYXN5IHRvIGZpeDoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS90
ZWdyYS1zbW11LmMgYi9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYwo+IGluZGV4IDk3ZWI2MmY2
NjdkMi4uNjM5ZDVjZWFiNjBiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvdGVncmEtc21t
dS5jCj4gKysrIGIvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMKPiBAQCAtODUzLDggKzg1Myw2
IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlCj4gKnRlZ3JhX3NtbXVfcHJvYmVfZGV2aWNl
KHN0cnVjdCBkZXZpY2UgKmRldikKPiAKPiAgCQkJaWYgKGVyciA8IDApCj4gIAkJCQlyZXR1cm4g
RVJSX1BUUihlcnIpOwo+IC0KPiAtCQkJYnJlYWs7CgpIbW0uLkkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgdGhpcyAiYnJlYWsiIGNhdXNlcyBwcm9ibGVtcyBvbiBUZWdyYTMwLgpUaGUgb2xkZXIgdmVy
c2lvbnMgdGhhdCB1c2VkIF9maW5kKCkrY29uZmlndXJlKCkgaGFkIGl0IGFsc28sIGUuZy46Cmh0
dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjkuMTYvc291cmNlL2RyaXZlcnMvaW9t
bXUvdGVncmEtc21tdS5jI0w3NjAKCkRtaXRyeSwgZG8geW91IGhhdmUgYW55IGlkZWE/Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
