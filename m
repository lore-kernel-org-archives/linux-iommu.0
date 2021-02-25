Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F5C433E6
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:26:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9514C64EC4
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9514C64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1685483F50;
	Thu, 25 Feb 2021 06:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ch_yBGxYMK8d; Thu, 25 Feb 2021 06:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9BB883F4A;
	Thu, 25 Feb 2021 06:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D291C000B;
	Thu, 25 Feb 2021 06:26:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB0F7C0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5FF283F4A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5W2L0maxgxH3 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9B4983F49
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:26:47 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id 17so2627247pli.10
 for <iommu@lists.linux-foundation.org>; Wed, 24 Feb 2021 22:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=w8TXeKml8XM1ZbA6ShbdIyFFO1a3KVv9r8HYd21fZjk=;
 b=p19dGD+CtfMWthkM6oPMevPv6cSTY5w5I15nfN7Il0AFFuk+DDhRywx9dAOKOylpiz
 AddR9A97AT1BV89QDKGX6qVEBU+Jix+DLHuUJIxkrA/MDqJQW4gZEXw72bzrJkEZOp4V
 T8ZORrbSZNq/tw7EtYa/0C74efB9AAXr3G8oHVG8oJ+DB6njNaI3iMXZjB6Lau8EtLGM
 PlH5TlB9qEwy+HQMZpcKTlTspDuCWlllm0Dz29DysvqXwRdDxK9LKrY6WtMfxhAdAvM4
 5x4dtODIV6QL5GClNVzeF2U5i9U0yqyAtLOXFTZzuZ0dZzabuLS9qWhFO7AxH7JiP7hn
 vprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=w8TXeKml8XM1ZbA6ShbdIyFFO1a3KVv9r8HYd21fZjk=;
 b=kYyvr9d/uuCsrfOgq/tJRr3aQEspR5XckUL5jeHanTln2b73GTmJTRlNyRrMBCe8wF
 uARJOfrXr8RbuSqUufrCUqNPE4WXc8B62zuHIIvAqSsj+J9CgJyMmu7ROICPn2oL1T+w
 RRZ87zH1NfStyMXqJEGilwd3a5On/4g2SCOVJ2w9dyYwDk0avrAdLDmfym05MwCnJMEu
 aEUkD/NAUoB4SeETNPZtnLkVWl1dmyfoYSJtlXqWr3B2VIf4LvN9BgMOqpizgnaIe+V/
 CunUJFPXnoGD/h0b2kNu+FhRWhzyUO6v9ZHSm7XuadVavn3aGqYLRpaU8kFczg5SudW3
 Z+Dg==
X-Gm-Message-State: AOAM531UGpoa1OMPJnW+4b6isf27lFk1LTVYulYLyxSER22N6t8suRX6
 5hX9PYhlURFfav8zIHlXN68=
X-Google-Smtp-Source: ABdhPJy1Weq2xf/Mb961fv+2Q+OKgsSyBof3VnceaDHKkw7fdW2LEYlYl75J31TS2Bc58lJ8GzVh3g==
X-Received: by 2002:a17:902:b089:b029:e3:28:b8ee with SMTP id
 p9-20020a170902b089b02900e30028b8eemr1812650plr.84.1614234407056; 
 Wed, 24 Feb 2021 22:26:47 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id o3sm4407946pgm.60.2021.02.24.22.26.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Feb 2021 22:26:46 -0800 (PST)
Date: Wed, 24 Feb 2021 22:27:43 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210225062742.GA13353@Asurada-Nvidia>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
 <9d6445c0-9574-1650-e327-32b11716f87e@gmail.com>
 <20210223021343.GA6539@Asurada-Nvidia>
 <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79bb1248-497f-8adf-663b-74448bea3849@gmail.com>
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

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMDg6MTA6NDFBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDIzLjAyLjIwMjEgMDU6MTMsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
SGkgRG1pdHJ5LAo+ID4gCj4gPiBPbiBTYXQsIEZlYiAyMCwgMjAyMSBhdCAwODoxNjoyMkFNICsw
MzAwLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4gPj4gMTkuMDIuMjAyMSAwMTowNywgTmljb2xp
biBDaGVuINC/0LjRiNC10YI6Cj4gPj4+IENvbW1pdCAyNTkzOGM3M2NkNzkgKCJpb21tdS90ZWdy
YS1zbW11OiBSZXdvcmsgdGVncmFfc21tdV9wcm9iZV9kZXZpY2UoKSIpCj4gPj4+IHJlbW92ZWQg
Y2VydGFpbiBoYWNrIGluIHRoZSB0ZWdyYV9zbW11X3Byb2JlKCkgYnkgcmVseWluZyBvbiBJT01N
VSBjb3JlIHRvCj4gPj4+IG9mX3hsYXRlIFNNTVUncyBTSUQgcGVyIGRldmljZSwgc28gYXMgdG8g
Z2V0IHJpZCBvZiB0ZWdyYV9zbW11X2ZpbmQoKSBhbmQKPiA+Pj4gdGVncmFfc21tdV9jb25maWd1
cmUoKSB0aGF0IGFyZSB0eXBpY2FsbHkgZG9uZSBpbiB0aGUgSU9NTVUgY29yZSBhbHNvLgo+ID4+
Pgo+ID4+PiBUaGlzIGFwcHJvYWNoIHdvcmtzIGZvciBib3RoIGV4aXN0aW5nIGRldmljZXMgdGhh
dCBoYXZlIERUIG5vZGVzIGFuZCBvdGhlcgo+ID4+PiBkZXZpY2VzIChsaWtlIFBDSSBkZXZpY2Up
IHRoYXQgZG9uJ3QgZXhpc3QgaW4gRFQsIG9uIFRlZ3JhMjEwIGFuZCBUZWdyYTMKPiA+Pj4gdXBv
biB0ZXN0aW5nLiBIb3dldmVyLCBQYWdlIEZhdWx0IGVycm9ycyBhcmUgcmVwb3J0ZWQgb24gdGVn
cmExMjQtTnlhbjoKPiA+Pj4KPiA+Pj4gICB0ZWdyYS1tYyA3MDAxOTAwMC5tZW1vcnktY29udHJv
bGxlcjogZGlzcGxheTBhOiByZWFkIEAweGZlMDU2YjQwOgo+ID4+PiAJIEVNRU0gYWRkcmVzcyBk
ZWNvZGUgZXJyb3IgKFNNTVUgdHJhbnNsYXRpb24gZXJyb3IgWy0tU10pCj4gPj4+ICAgdGVncmEt
bWMgNzAwMTkwMDAubWVtb3J5LWNvbnRyb2xsZXI6IGRpc3BsYXkwYTogcmVhZCBAMHhmZTA1NmI0
MDoKPiA+Pj4gCSBQYWdlIGZhdWx0IChTTU1VIHRyYW5zbGF0aW9uIGVycm9yIFstLVNdKQo+ID4+
Pgo+ID4+PiBBZnRlciBkZWJ1Z2dpbmcsIEkgZm91bmQgdGhhdCB0aGUgbWVudGlvbmVkIGNvbW1p
dCBjaGFuZ2VkIHNvbWUgZnVuY3Rpb24KPiA+Pj4gY2FsbGJhY2sgc2VxdWVuY2Ugb2YgdGVncmEt
c21tdSdzLCByZXN1bHRpbmcgaW4gZW5hYmxpbmcgU01NVSBmb3IgZGlzcGxheQo+ID4+PiBjbGll
bnQgYmVmb3JlIGRpc3BsYXkgZHJpdmVyIGdldHMgaW5pdGlhbGl6ZWQuIEkgY291bGRuJ3QgcmVw
cm9kdWNlIGV4YWN0Cj4gPj4+IHNhbWUgaXNzdWUgb24gVGVncmEyMTAgYXMgVGVncmExMjQgKGFy
bS0zMikgZGlmZmVycyBhdCBhcmNoLWxldmVsIGNvZGUuCj4gPj4KPiA+PiBIZWxsbyBOaWNvbGlu
LAo+ID4+Cj4gPj4gQ291bGQgeW91IHBsZWFzZSBleHBsYWluIGluIGEgbW9yZSBkZXRhaWxzIHdo
YXQgZXhhY3RseSBtYWtlcyB0aGUKPiA+PiBkaWZmZXJlbmNlIGZvciB0aGUgY2FsbGJhY2sgc2Vx
dWVuY2U/Cj4gPiAKPiA+IEhlcmUgaXMgYSBsb2cgd2l0aCA1LjExLjAtcmM2Ogo+ID4gaHR0cHM6
Ly9sYXZhLmNvbGxhYm9yYS5jby51ay9zY2hlZHVsZXIvam9iLzMxODc4NDkKPiA+IFtkdW1wX3N0
YWNrIHdhcyBhZGRlZCBpbiBzb21lIHRlZ3JhLXNtbXUgZnVuY3Rpb25zXQo+ID4gCj4gPiBBbmQg
aGVyZSBpcyBhIGNvcnJlc3BvbmRpbmcgbG9nIHdpdGggcmV2ZXJ0aW5nIHRoZSBvcmlnaW5hbCBj
b21taXQ6Cj4gPiBodHRwczovL2xhdmEuY29sbGFib3JhLmNvLnVrL3NjaGVkdWxlci9qb2IvMzE4
Nzg1MQo+ID4gCj4gPiBIZXJlIGlzIGEgbG9nIHdpdGggNS4xMS4wLXJjNy1uZXh0LTIwMjEwMjEw
Ogo+ID4gaHR0cHM6Ly9sYXZhLmNvbGxhYm9yYS5jby51ay9zY2hlZHVsZXIvam9iLzMyMTAyNDUK
PiA+IAo+ID4gQW5kIGhlcmUgaXMgYSBjb3JyZXNwb25kaW5nIGxvZyB3aXRoIHJldmVydGluZyB0
aGUgb3JpZ2luYWwgY29tbWl0Ogo+ID4gaHR0cHM6Ly9sYXZhLmNvbGxhYm9yYS5jby51ay9zY2hl
ZHVsZXIvam9iLzMyMTA1OTYKPiA+IAo+ID4gQm90aCBmYWlsaW5nIGxvZ3Mgc2hvdyB0aGF0IG1j
IGVycm9ycyBzdGFydGVkIHJpZ2h0IGFmdGVyIGNsaWVudCBEQwo+ID4gZ290IGVuYWJsZWQgYnkg
LT5hdHRhY2hfZGV2KCkgY2FsbGJhY2sgdGhhdCBpbiB0aGUgcGFzc2luZyBsb2dzIHdhcwo+ID4g
bm90IGNhbGxlZCB1bnRpbCBIb3N0MXggZHJpdmVyIGluaXQuIEFuZCBub3RlIHRoYXQgdHdvIGZh
aWxpbmcgbG9ncwo+ID4gc2hvdyB0aGF0IC0+YXR0YWNoX2RldigpIGNvdWxkIGJlIGNhbGxlZCBm
cm9tIHR3byBkaWZmZXJlbnQgc291cmNlcywKPiA+IG9mX2RtYV9jb25maWd1cmVfaWQoKSBvciBh
cmNoX3NldHVwX2RtYV9vcHMoKS4KPiA+IAo+ID4gVGhlIHJlYXNvbiB3aHkgLT5hdHRhY2hfZGV2
KCkgZ2V0cyBjYWxsZWQgaXMgcHJvYmFibHkgcmVsYXRlZCB0byB0aGUKPiA+IGZvbGxvd2luZyBy
ZWFzb25zIChzb3JyeSwgY2FuJ3QgYmUgMTAwJSBzdXJlIGFzIEkgZG9uJ3QgaGF2ZSBUZWdyYTEy
NAo+ID4gb3Igb3RoZXIgMzJiaXQgVGVncmEgYm9hcmQgdG8gdGVzdCk6Cj4gPiAxKSBXaXRoIHRo
ZSBjb21taXQgcmV2ZXJ0ZWQsIGFsbCBjbGllbnRzIGFyZSBwcm9iZWQgaW4gImFyY2giIHN0YWdl
LAo+ID4gICAgd2hpY2ggaXMgZXZlbiBwcmlvciB0byBpb21tdSBjb3JlIGluaXRpYWxpemF0aW9u
IC0tIGluY2x1ZGluZyBpdAo+ID4gICAgc2V0dGluZyBkZWZhdWx0IGRvbWFpbiB0eXBlLiBUaGlz
IHByb2JhYmx5IG1lc3NlZCB1cCB0aGUgdHlwZSBvZgo+ID4gICAgYWxsb2NhdGluZyBkb21haW5z
IGFnYWluc3QgdGhlIGRlZmF1bHQgZG9tYWluIHR5cGUuIEFsc28gaW50ZXJuYWwKPiA+ICAgIGdy
b3VwIGlzIHNvbWVob3cgYWZmZWN0ZWQuIFNvIHNvbWUgY29uZGl0aW9uIGNoZWNrIGluIGlvbW11
IGNvcmUKPiA+ICAgIGZhaWxlZCBhbmQgdGhlbiBpdCBieXBhc3NlZCAtPmF0dGFjaF9kZXYgY2Fs
bGJhY2sgaW4gcmVhbGx5X3Byb2JlCj4gPiAgICBzdGFnZSwgdW50aWwgSG9zdDF4IGRyaXZlciBk
b2VzIGF0dGFjaF9kZXYgYWdhaW4uCj4gPiAKPiA+IDIpIDMyYml0IEFSTSBoYXMgYXJjaF9zZXR1
cF9kbWFfb3BzKCkgZG9lcyBhbiBhZGRpdGlvbmFsIHNldCBvZiBpb21tdQo+ID4gICAgZG9tYWlu
IGFsbG9jYXRpb24gKyBhdHRhY2hfZGV2KCksIGFmdGVyIG9mX2RtYV9jb25maWd1cmVfaWQoKSBk
aWQKPiA+ICAgIG9uY2UuIFRoaXMgaXNuJ3QgcmVwcm9kdWNpYmxlIGZvciBtZSBvbiBUZWdyYTIx
MC4KPiA+IAo+ID4gQXMgZGVidWdnaW5nIG9ubGluZSBpc24ndCB2ZXJ5IGVmZmljaWVudCwgYW5k
IGdpdmVuIHRoYXQgVGhpZXJyeSBoYXMKPiA+IGJlZW4gd29ya2luZyBvbiB0aGUgbGluZWFyIG1h
cHBpbmcgb2YgZnJhbWVidWZmZXIgY2FydmVvdXQsIEkgY2hvb3NlCj4gPiB0byBwYXJ0aWFsbHkg
cmV2ZXJ0IGFzIGEgcXVpY2sgZml4Lgo+IAo+IFRoZSBwYXJ0aWFsbHkgcmV2ZXJ0IHNob3VsZCBi
ZSBva2F5LCBidXQgaXQncyBub3QgY2xlYXIgdG8gbWUgd2hhdCBtYWtlcwo+IGRpZmZlcmVuY2Ug
Zm9yIFQxMjQgc2luY2UgSSBkb24ndCBzZWUgdGhhdCBwcm9ibGVtIG9uIFQzMCwgd2hpY2ggYWxz
bwo+IGhhcyBhY3RpdmUgZGlzcGxheSBhdCBhIGJvb3QgdGltZS4KCkhtbS4uZG8geW91IHNlZSAt
PmF0dGFjaF9kZXYoKSBpcyBjYWxsZWQgZnJvbSBob3N0MXhfY2xpZW50X2lvbW11X2F0dGFjaApv
ciBmcm9tIG9mX2RtYV9jb25maWd1cmVfaWQvYXJjaF9zZXR1cF9kbWFfb3BzPwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
