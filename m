Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3985C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:12:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677FE60C3E
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677FE60C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2326A84A4A;
	Thu, 25 Mar 2021 15:12:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ATBmoxkesON; Thu, 25 Mar 2021 15:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2AE984861;
	Thu, 25 Mar 2021 15:12:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8162C000E;
	Thu, 25 Mar 2021 15:12:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3FEEC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 959A184A3C
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xL5dEAJGohrq for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:12:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B076884861
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:12:55 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id n138so3056572lfa.3
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WnTFrwAfePNw9Aef52Q1wEY1qtEOTDfqn1ojM94Ae6E=;
 b=HV/Oi4NVHDSvuB6pwSTtE5OHNnFx3BahyrSAm/Q3kYMPZ61nMuhvNBJCTFUPc817n+
 DFOfmZ2QK197axzyyG70IYRB8nR2v1hpVUKRuh3KAqRXXRIesLKGPpofgqZUgvj3Nkx2
 hgELWoa7aWpFjntG5Ky2SNPl8vXmz5cqudVormd4LnVgfwawChaNWzE14qHu4Uafho1k
 oTSEhNnajyVlc16FzDMCwdoTAuT1u0uZqOdPhIuuWVRG3+CXNpUJzExTDHFxFbdcr1cr
 fSEpq+0pOJ4PoRrwZEdqc2JF22tGmpCy08eMUH15qLqC4fS8Q7UHOc145Yo/RJKQB/A2
 PDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WnTFrwAfePNw9Aef52Q1wEY1qtEOTDfqn1ojM94Ae6E=;
 b=qGmUgXtFtvguPQK2aSwqneCJA6eiHD0gQpZiMml2tthm/FmDz4TFTt2DdQ6LJQsNf7
 6Vj2PXuVAdS2MJXAbmf1Fj4znbsY1Doxh1RoNTsBZk4CgTN7HbkVPoAgd1SJVbX0+D2u
 0UHNsNJtdkomyBDbbLPhXXlwC3+UmV+5hr3SBgEfV47QpaWHlaD9MYdd0k7VG5a+BjOh
 Vjq6p/V+c9kPfwtYs/QZm/WG9O3IQjPJAE2aOXkLbdH70pUX/IknGXHq0BJ69s61/oFd
 FSlXhWk9T02HuRU7NmNJk8TBzmt6ajckfCkMOb/YdcpLYA2vi6QBIPWcIoGH8aml8c+N
 jxmg==
X-Gm-Message-State: AOAM533Sddgg2aFbmxxa4ms/+QWpntyoI5mZ3gSKF0d8ca6BCcMDQXUC
 SwmUzbrhfaz4w5GlvC1siaQ=
X-Google-Smtp-Source: ABdhPJz02RpX7reky+R0Ku0sSImOsnP5BRrwqX8XYuEODRAbMoFD7wkcixfdZIytwGQAHadGb2lA2g==
X-Received: by 2002:a05:6512:3481:: with SMTP id
 v1mr5328599lfr.193.1616685173799; 
 Thu, 25 Mar 2021 08:12:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru.
 [109.252.193.60])
 by smtp.googlemail.com with ESMTPSA id g14sm796314ljj.3.2021.03.25.08.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Mar 2021 08:12:53 -0700 (PDT)
Subject: Re: [PATCH 1/9] memory: tegra: Move internal data structures into
 separate header
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <20210325130332.778208-2-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ca70b07a-608a-51b3-3c30-ff04bdf8bcc0@gmail.com>
Date: Thu, 25 Mar 2021 18:12:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325130332.778208-2-thierry.reding@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
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

MjUuMDMuMjAyMSAxNjowMywgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBGcm9tOiBUaGll
cnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPgo+IAo+IEZyb20gVGVncmEyMCB0aHJvdWdo
IFRlZ3JhMjEwLCBlaXRoZXIgdGhlIEdBUlQgb3IgU01NVSBkcml2ZXJzIG5lZWQKPiBhY2Nlc3Mg
dG8gdGhlIGludGVybmFscyBvZiB0aGUgbWVtb3J5IGNvbnRyb2xsZXIgZHJpdmVyIGJlY2F1c2Ug
dGhleSBhcmUKPiB0aWdodGx5IGNvdXBsZWQgKGluIGZhY3QsIHRoZSBHQVJUIGFuZCBTTU1VIGFy
ZSBwYXJ0IG9mIHRoZSBtZW1vcnkKPiBjb250cm9sbGVyKS4gT24gbGF0ZXIgY2hpcHMsIGEgc2Vw
YXJhdGUgaGFyZHdhcmUgYmxvY2sgaW1wbGVtZW50cyB0aGUKPiBTTU1VIGZ1bmN0aW9uYWxpdHks
IHNvIHRoaXMgaXMgbm8gbG9uZ2VyIG5lZWRlZC4gSG93ZXZlciwgd2Ugc3RpbGwgd2FudAo+IHRv
IHJldXNlIHNvbWUgb2YgdGhlIGV4aXN0aW5nIGluZnJhc3RydWN0dXJlIG9uIGxhdGVyIGNoaXBz
LCBzbyBzcGxpdAo+IHRoZSBtZW1vcnkgY29udHJvbGxlciBpbnRlcm5hbHMgaW50byBhIHNlcGFy
YXRlIGhlYWRlciBmaWxlIHRvIGF2b2lkCj4gY29uZmxpY3RzIHdpdGggdGhlIGltcGxlbWVudGF0
aW9uIG9uIG5ld2VyIGNoaXBzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRoaWVycnkgUmVkaW5nIDx0
cmVkaW5nQG52aWRpYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvaW9tbXUvdGVncmEtZ2FydC5jICAg
ICAgfCAgMiArLQo+ICBkcml2ZXJzL2lvbW11L3RlZ3JhLXNtbXUuYyAgICAgIHwgIDIgKy0KPiAg
ZHJpdmVycy9tZW1vcnkvdGVncmEvbWMuaCAgICAgICB8ICAyICstCj4gIGRyaXZlcnMvbWVtb3J5
L3RlZ3JhL3RlZ3JhMTg2LmMgfCAxMiArKysrLS0tCj4gIGluY2x1ZGUvc29jL3RlZ3JhL21jLWlu
dGVybmFsLmggfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgaW5jbHVk
ZS9zb2MvdGVncmEvbWMuaCAgICAgICAgICB8IDUwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gIDYgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRpb25zKC0pCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3NvYy90ZWdyYS9tYy1pbnRlcm5hbC5oCgpXaGF0
IGFib3V0IHRvIG1ha2UgVDE4NiB0byByZS11c2UgdGhlIGV4aXN0aW5nIHRlZ3JhX21jIHN0cnVj
dD8gU2VlbXMKdGhlcmUgaXMgbm90aGluZyBzcGVjaWFsIGluIHRoYXQgc3RydWN0IHdoaWNoIGRv
ZXNuJ3QgZml0IGZvciB0aGUgbmV3ZXIKU29Dcy4gUGxlYXNlIG5vdGljZSB0aGF0IGJvdGggU01N
VSBhbmQgR0FSVCBhcmUgYWxyZWFkeSBvcHRpb25hbCBhbmQgYWxsCnRoZSBTb0MgZGlmZmVyZW5j
ZXMgYXJlIHNwZWNpZmllZCB3aXRoaW4gdGhlIHRlZ3JhX21jX3NvYy4gSXQgbG9va3MgdG8KbWUg
dGhhdCB0aGlzIGNvdWxkIGJlIGEgbXVjaCBuaWNlciBhbmQgY2xlYW5lciB2YXJpYW50LgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
