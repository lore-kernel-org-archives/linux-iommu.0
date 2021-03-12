Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB389C433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 01:11:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DAD64F7E
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 01:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DAD64F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 092244ED33;
	Fri, 12 Mar 2021 01:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WuN_kFpk1nM; Fri, 12 Mar 2021 01:11:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D3347E1F;
	Fri, 12 Mar 2021 01:11:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8868CC000A;
	Fri, 12 Mar 2021 01:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CCD1C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BDA0606A7
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aUtVtsTsR4I for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 01:11:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC9206063E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:23 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id x7so735582pfi.7
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=len8ZpvjuLF/FJGoc7IvEqOQjvRf/2jHb7o5ovnWmEI=;
 b=VisY3iSkscvWgpDn9InykUTNJSqpd+5PEB9RDK8qU/cV5JXrhZLQgvTHV80u4OMogQ
 iYJNEdilkcSrlBWmsYTdKmiEWzQBOK3oSjNE/XeUjyeRuzhGnPdZCSUOHcUlNgJZCp8B
 tTU1eqKkMltcOC10Vlef5D2k4gRwypgSIlV+mRQMdWM0V9MzHIOcWZf2bOt1y9Z8mlcH
 M4gz+KkX/8UEJILzgjAO7o9Wo8uN8eQS+KFopw3brYhT4SVr9ZvWXs8FtETolyqmoJyv
 Ysl6PLbcUzG/Mquczw24TwSDsIrjjenhQtU5ROzsp+uuYNYKcQBdobaJ5uS3BNo05K1i
 4+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=len8ZpvjuLF/FJGoc7IvEqOQjvRf/2jHb7o5ovnWmEI=;
 b=cQKkNV0cA1F5zfvmK7DQ2xLY2MOTBRqvtpG8eKRxBK9ZaJy8cKD/6fnmCPAkIHHoxH
 h4wl8pS0AFlnIsQMNwPB6fs074Aqz80n1JcvlYQ4pzOg56/o3zbsB6tKz75dc/vmCiQu
 h9wEDYj9/2H6Ul4fRKaUDYaelNROa8t8A2QG20CangcCBFbM1X5HZmWM2e1kB6+YFJcf
 OBuJwACzsJpzo5+SXqi0eSEYh/Dd2VUkii8TvO/eg+E2X5LHMkC/xlyezfi/xEsUMkFl
 9VaGAGtGK9T0YorLNvuM3ZBOV88prXOUyJ2kEioKNXnLH+96/5iuwLqMSYI9DkJpi1SP
 YeOg==
X-Gm-Message-State: AOAM532/WEDg8133JEIbf7aChQNlceAjBBfhK1VQarmWhn0HhtnD9Kik
 aRC32PbP8pYBh+ZQ9eQTwYI=
X-Google-Smtp-Source: ABdhPJx81FiGrnhRgApowT9b1Q87JlXpg2kXtZZjr3VUxxMP549Ef3hYqOaKF0CQbxNxYSArH25++w==
X-Received: by 2002:a63:5b0e:: with SMTP id p14mr9364010pgb.110.1615511482601; 
 Thu, 11 Mar 2021 17:11:22 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id iq6sm272746pjb.31.2021.03.11.17.11.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Mar 2021 17:11:22 -0800 (PST)
Date: Thu, 11 Mar 2021 17:09:05 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210312010905.GA29926@Asurada-Nvidia>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <a8a7a0af-895f-9d79-410d-5dd03ebbd6dd@gmail.com>
 <7714f272-3862-84ac-306d-86363a1c4880@gmail.com>
 <20210310221707.GB10431@Asurada-Nvidia>
 <8c2f5d94-8835-9994-21aa-660df29d383c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c2f5d94-8835-9994-21aa-660df29d383c@gmail.com>
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

T24gVGh1LCBNYXIgMTEsIDIwMjEgYXQgMDM6MDY6MjVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDExLjAzLjIwMjEgMDE6MTcsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMTE6MjI6NTdQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDEwLjAzLjIwMjEgMjI6MTMsIERtaXRyeSBPc2lwZW5rbyDQv9C40YjQtdGC
Ogo+ID4+PiBJIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBpbnRyb2R1Y2VkIGEgc2VyaW91cyByZWdy
ZXNzaW9uIG9uIFRlZ3JhMzAgdXNpbmcKPiA+Pj4gdG9kYXkncyBsaW51eC1uZXh0LiBUZWdyYTMw
IGhhcyB0d28gM2QgaC93IGJsb2NrcyBjb25uZWN0ZWQgaW4gU0xJIGFuZAo+ID4+PiBvbmx5IG9u
ZSBvZiB0aGUgYmxvY2tzIGlzIG5vdyBhdHRhY2hlZCB0byBJT01NVSBkb21haW4sIG1lYW5pbmcg
dGhhdCBHUFUKPiA+Pj4gaXMgdW51c2FibGUgbm93LiBBbGwgM2QsIDJkIGFuZCBkaXNwbGF5IGRl
dmljZXMgc2hhcmUgdGhlIHNhbWUgIkRSTSIKPiA+Pj4gZ3JvdXAgb24gVGVncmEzMC4KPiA+Pj4K
PiA+Pj4gTmljb2xpbiwgcGxlYXNlIGxldCBtZSBrbm93IGlmIGhhdmUgYW55IHN1Z2dlc3Rpb25z
LiBJIG1heSB0YWtlIGEgY2xvc2VyCj4gPj4+IGxvb2sgYSBkYXkgbGF0ZXIsIGZvciBub3cgSSds
bCBqdXN0IHJldmVydCB0aGlzIHBhdGNoIGxvY2FsbHkuIFRoYW5rcyBpbgo+ID4+PiBhZHZhbmNl
Lgo+ID4+Pgo+ID4+Cj4gPj4gQWN0dWFsbHksIHRoaXMgd2FzIGVhc3kgdG8gZml4Ogo+ID4+Cj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvdGVncmEtc21tdS5jIGIvZHJpdmVycy9pb21t
dS90ZWdyYS1zbW11LmMKPiA+PiBpbmRleCA5N2ViNjJmNjY3ZDIuLjYzOWQ1Y2VhYjYwYiAxMDA2
NDQKPiA+PiAtLS0gYS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYwo+ID4+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvdGVncmEtc21tdS5jCj4gPj4gQEAgLTg1Myw4ICs4NTMsNiBAQCBzdGF0aWMgc3Ry
dWN0IGlvbW11X2RldmljZQo+ID4+ICp0ZWdyYV9zbW11X3Byb2JlX2RldmljZShzdHJ1Y3QgZGV2
aWNlICpkZXYpCj4gPj4KPiA+PiAgCQkJaWYgKGVyciA8IDApCj4gPj4gIAkJCQlyZXR1cm4gRVJS
X1BUUihlcnIpOwo+ID4+IC0KPiA+PiAtCQkJYnJlYWs7Cj4gPiAKPiA+IEhtbS4uSSBkb24ndCB1
bmRlcnN0YW5kIHdoeSB0aGlzICJicmVhayIgY2F1c2VzIHByb2JsZW1zIG9uIFRlZ3JhMzAuCj4g
PiBUaGUgb2xkZXIgdmVyc2lvbnMgdGhhdCB1c2VkIF9maW5kKCkrY29uZmlndXJlKCkgaGFkIGl0
IGFsc28sIGUuZy46Cj4gPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS45LjE2
L3NvdXJjZS9kcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYyNMNzYwCj4gPiAKPiA+IERtaXRyeSwg
ZG8geW91IGhhdmUgYW55IGlkZWE/Cj4gPiAKPiAKPiBUaGUgb2xkZXIgdmFyaWFudCBvZiB0ZWdy
YV9zbW11X2F0dGFjaF9kZXYoKSBkaWRuJ3QgdXNlIGZ3c3BlYyBbMV0sIHRoYXQKPiBtYWtlcyB0
aGUgZGlmZmVyZW5jZS4gSW4gb3RoZXIgd29yZHMsIHRoZSBvbGRlciB2YXJpYW50IG9mCj4gdGVn
cmFfc21tdV9wcm9iZV9kZXZpY2UoKSB3YXMgYWxyZWFkeSBidWdneSwgYnV0IHRoZSBidWcgd2Fz
IG1hc2tlZCBieQo+IHRoZSB0ZWdyYV9zbW11X2F0dGFjaF9kZXYoKSB0aGF0IGRpZG4ndCB1c2Ug
dGhlIGZ3c3BlYy4KPiAKPiBbMV0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
NS4xMC4yMi9zb3VyY2UvZHJpdmVycy9pb21tdS90ZWdyYS1zbW11LmMjTDQ3NgoKSG1tLi4ud291
bGQgeW91IG1pbmQgc3VibWl0dGluZyBhIGZpeCBmcm9tIHlvdXIgc2lkZT8gSSB0aGluayBpdCdk
CmJlIG1vcmUgYXBwcm9wcmlhdGUgdG8gZG8gc28sIGFzIHlvdSBjYW4gZGVmaW5pdGVseSB3cml0
ZSBhIGJldHRlcgpjb21taXQgbWVzc2FnZSB0aGFuIEkgY2FuIGZvciB0aGlzIGJ1Zy4KClRoYW5r
cyEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
