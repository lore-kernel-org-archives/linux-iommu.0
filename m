Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49AC2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:19:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C847206A5
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+rSaFzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C847206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C9D8203D0;
	Wed, 30 Sep 2020 06:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6koEMoj0gUFC; Wed, 30 Sep 2020 06:19:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BBE982041E;
	Wed, 30 Sep 2020 06:19:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A543DC0889;
	Wed, 30 Sep 2020 06:19:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2B6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 323AE871AE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02EB+y9sR94i for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:19:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 99707871A8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:19:25 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id y20so375922pll.12
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=HGwliGdnOsvbFNk+ILVrrA6wWvnB3mx6++Vzoqu61bk=;
 b=m+rSaFzK3MX0An+UuLThLPSMN2e3pp1A3HkBG1Xi/+3l41Ax48PGeRUpvIjIgMZfbc
 j9iNHBqumdJngqmUpcron/qJZstDOh5dg9PQR0+eZK3hris7o7mIYSd6VRce+gTkHWi2
 o9GYsDLYH1+IYLb7aihaxZD5nDAWR288tiW0YYwJW/lktXvQAEhgSo+evVkWbtYo0a6A
 2n6gSqgHNg8y8iszxoRVTAdTEK71669BPnqUcjqYQFXPTptfSGZZRq+IkNm2eW3P669a
 O8qaXsbUMdoQXha229tmCWBGsPbeRfJvDPXIvdvAZUgo5SZVrMJZfmVs4+3fISDwz0Q9
 1lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=HGwliGdnOsvbFNk+ILVrrA6wWvnB3mx6++Vzoqu61bk=;
 b=EPcWs4P+bSqvQZFyX7Qe9s+qGT5DCAVIqoWeAjnVmAGDUN0BWp6GdiQb0JJmwTtJ+L
 WVg6gHdTnqR3bG35seayLkBSwn+pvztaED2vUFg/sHgR9J5tLkt+RXRyssQ942z4pL2X
 S6MWpzp5WHUL5/R7xfVuYnH+eynDjxm1YtE2hRYd1hncOdSLYd+EijauFmp+QcP2VJq3
 fOjz/PVCAbolR3rVTnhOKmpUJHZgIL+j0Z5JDuyEAoYcfKw82aqBkD54BFT4NoqE2r6Z
 /+aPlAQsPawAyd/U85iF8y6Fx69KJycAS8pO3paFgjkfMHALuuos5yqoAuQn0/wxHR+l
 xd/g==
X-Gm-Message-State: AOAM532gOrBysjbUjBB7cfLbMmyoZUeowr8ekMOPY+Qo0KH3dl6z1S3I
 IPi01lKZg3Xk19/advv6ofg=
X-Google-Smtp-Source: ABdhPJwEt9ZQYItIyIuKN4n6x9OjE+XcTkQKL8Bs9Yejup2yt8SsrqVgrOzpCQiAQu0cBLYAjAFWBg==
X-Received: by 2002:a17:90a:9d82:: with SMTP id
 k2mr1165283pjp.197.1601446765072; 
 Tue, 29 Sep 2020 23:19:25 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n9sm822737pgi.2.2020.09.29.23.19.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 23:19:24 -0700 (PDT)
Date: Tue, 29 Sep 2020 23:13:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930061351.GA16460@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <75514da5-e63a-9e51-8376-abbd12c324d1@gmail.com>
 <20200930054900.GG31821@Asurada-Nvidia>
 <b74f96cf-0edc-c7f2-3a0e-2a4fe51e3b2e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b74f96cf-0edc-c7f2-3a0e-2a4fe51e3b2e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDk6MTA6MzhBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDg6NDksIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MTE6NTJBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiArCS8qIEFuIGludmFsaWQgbWMgcG9pbnRlciBtZWFucyBtYyBhbmQgc21tdSBkcml2ZXJz
IGFyZSBub3QgcmVhZHkgKi8KPiA+Pj4gKwlpZiAoSVNfRVJSX09SX05VTEwobWMpKQo+ID4+Cj4g
Pj4gdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVyKCkgZG9lc24ndCByZXR1cm4gTlVMTC4KPiA+
IAo+ID4gV2VsbCwgSSBkb24ndCB3YW50IHRvIGFzc3VtZSB0aGF0IGl0J2QgZG8gdGhhdCBmb3Jl
dmVyLCBhbmQgdGhlCj4gPiBOVUxMIGNoZWNrIG9mIElTX0VSUl9PUl9OVUxMIGlzIG1hcmtlZCAi
dW5saWtlbHkiIHNvIGl0IGRvZXNuJ3QKPiA+IGh1cnQgdG8gaGF2ZS4KPiA+IAo+IAo+IEkgZG9u
J3Qgc2VlIGFueSByZWFzb25zIHdoeSBpdCB3b24ndCBkbyB0aGF0IGZvcmV2ZXIuCj4gCj4gU2Vj
b25kbHksIHB1YmxpYyBmdW5jdGlvbiBjYW4ndCBiZSBjaGFuZ2VkIHJhbmRvbWx5IHdpdGhvdXQg
dXBkYXRpbmcgYWxsCj4gdGhlIGNhbGxlcnMuCj4gCj4gSGVuY2UgdGhlcmUgaXMgbm8gbmVlZCB0
byBoYW5kbGUgY2FzZXMgdGhhdCBjYW4ndCBldmVyIGhhcHBlbiBhbmQgaXQKPiBodXJ0cyByZWFk
YWJpbGl0eSBvZiB0aGUgY29kZSArIG9yaWdpbmFsIGVycm9yIGNvZGUgaXMgbWlzc2VkLgoKSSBk
b24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoeSBhbiBleHRyYSAiX09SX05VTEwiIHdvdWxkIGh1cnQK
cmVhZGFiaWxpdHkuLi4uYnV0IEknZCB0YWtlIGEgc3RlcCBiYWNrIGFuZCB1c2UgSVNfRVJSKCku
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
