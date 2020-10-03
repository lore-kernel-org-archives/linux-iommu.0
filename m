Return-Path: <SRS0=7D56=DK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA889C46466
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:14:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44210206F8
	for <iommu@archiver.kernel.org>; Sat,  3 Oct 2020 14:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK/+xpsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44210206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE42287043;
	Sat,  3 Oct 2020 14:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Goq6PcLCQLKn; Sat,  3 Oct 2020 14:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B55B87037;
	Sat,  3 Oct 2020 14:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24348C016F;
	Sat,  3 Oct 2020 14:14:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35397C0051
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B1D287043
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HW5fHgZwqpOu for <iommu@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 14:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C1B387037
 for <iommu@lists.linux-foundation.org>; Sat,  3 Oct 2020 14:14:36 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id m16so1207542ljo.6
 for <iommu@lists.linux-foundation.org>; Sat, 03 Oct 2020 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tst9irh6GksvKPw8ga3l4/uVVfdGZqpV7pFfQRzp6+Q=;
 b=HK/+xpsbVETdOQjnTAAmtpWFdXmvr8V2jLEQ0Lo39HgkGbLBTh4Q2SqjFF/QxchbkL
 OLx/PGygV73+elkbNW5MAoSqHjMsP24RY4hSMaUnO1l7PTAE1W3ar3ZSApzU3DBKOzk2
 CWEJINOe5JSmjCBo4QWCOoB1wgaqWWiJAPjf8hCfzk6DPBX4fSQiRniTjYsI3vemtQPN
 p+tbvA7bSCYTYYAeZ3HrC51PEKEe1zsISoWQItHVA1ShX4mbdkDeOUch7yTrXGFQdM/d
 EZXweyqd85+KU8EWWe6X3KTof7iNaRINTxngzxF3/MrF/d2eVYksE641DT2QaU/tLz/Y
 iX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tst9irh6GksvKPw8ga3l4/uVVfdGZqpV7pFfQRzp6+Q=;
 b=dXJ3u7CMBiD5gSg6MmgkUkTKVdnw/i2SqoNXTWbtmT8kGbLHqaDEq4RYy5Tm/LIAoc
 h//tULNRyhgsBdriuXWkNrpUGRT24GItjunK3ZU/tImv9QaaXpX2bINHO2sF7pxAXZ//
 aqWiQnDJKNzyHkwQ86pVhu2J+tcB2pN1sjmD5LPiV3WbnBipeM+c2T+1w0oK8NSGqYGc
 VnXBo7oCjPN199zkKCMTH7VLruvC3hMVPTdwh+YN72TYRd+aPFj0w0fIn64eMYzgc/so
 4GJYyE84d2/UQ4HHhCQf0PbY8fzg2ArMbTqCCGeEoGy0pADqkqXTZM4uNvJgh2bbUKtf
 JFBg==
X-Gm-Message-State: AOAM531JpOLrqgSZw23IzF9en8sz38Bw8D9VkbDDYbCF0dXPZFZV5FcJ
 iF/RPK2czPsA8/eBcP8mgjc=
X-Google-Smtp-Source: ABdhPJwQeKuHbETMb2aLQTvU1IDeyzqnysdODtX4b9+61V2w1lWG8caqy/R/zMrMjJgZ6/VsW8wPkA==
X-Received: by 2002:a05:651c:1073:: with SMTP id
 y19mr2080980ljm.57.1601734474241; 
 Sat, 03 Oct 2020 07:14:34 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id o15sm1530649lfo.188.2020.10.03.07.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 07:14:33 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-2-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <620c9f83-94e8-10c1-67f7-77e57929f46e@gmail.com>
Date: Sat, 3 Oct 2020 17:14:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201003065947.18671-2-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MDMuMTAuMjAyMCAwOTo1OSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gSW4gdGVncmFfc21t
dV8oZGUpYXR0YWNoX2RldigpIGZ1bmN0aW9ucywgd2UgcG9sbCBEVEIgZm9yIGVhY2gKPiBjbGll
bnQncyBpb21tdXMgcHJvcGVydHkgdG8gZ2V0IHN3Z3JvdXAgSUQgaW4gb3JkZXIgdG8gcHJlcGFy
ZQo+ICJhcyIgYW5kIGVuYWJsZSBzbW11LiBBY3R1YWxseSB0ZWdyYV9zbW11X2NvbmZpZ3VyZSgp
IHByZXBhcmVkCj4gYW4gZndzcGVjIGZvciBlYWNoIGNsaWVudCwgYW5kIGFkZGVkIHRvIHRoZSBm
d3NwZWMgYWxsIHN3Z3JvdXAKPiBJRHMgb2YgY2xpZW50IERUIG5vZGUgaW4gRFRCLgo+IAo+IFNv
IHRoaXMgcGF0Y2ggdXNlcyBmd3NwZWMgaW4gdGVncmFfc21tdV8oZGUpYXR0YWNoX2RldigpIHNv
IGFzCj4gdG8gcmVwbGFjZSB0aGUgcmVkdW5kYW50IERUIHBvbGxpbmcgY29kZS4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+Cj4gLS0tCgpJ
J20gc3RpbGwgbm90IGhpZ2hseSBpbXByZXNzZWQgYnkgc2VlaW5nIHRoZSAhZndzcGVjIGNoZWNr
IGluIHRoaXMKcGF0Y2guIEJ1dCBJJ20gbm90IGEgbWFpbnRhaW5lciBvZiB0aGUgU01NVSBkcml2
ZXIsIGhlbmNlIHdpbGwgbGVhdmUgaXQKdXAgdG8gVGhpZXJyeSBhbmQgSm9lcmcgdG8gZGVjaWRl
IHdoZXRoZXIgdGhpcyBpcyBnb29kIG9yIG5lZWRzIHRvIGJlCmltcHJvdmVkLgoKT3RoZXJ3aXNl
IHRoaXMgcGF0Y2ggaXMgZ29vZCB0byBtZSwgdGhhbmtzLiBJIHRlc3RlZCBpdCBvbiBOZXh1cyA3
LAp3aGljaCBpcyBUZWdyYTMwLgoKUmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4
QGdtYWlsLmNvbT4KVGVzdGVkLWJ5OiBEbWl0cnkgT3NpcGVua28gPGRpZ2V0eEBnbWFpbC5jb20+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
