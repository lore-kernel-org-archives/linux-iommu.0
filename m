Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF1C07E9C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582D1613B9
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582D1613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31EFB60B45;
	Wed, 14 Jul 2021 11:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpRTDvFx5aFU; Wed, 14 Jul 2021 11:17:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BF0360B19;
	Wed, 14 Jul 2021 11:17:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0404C0010;
	Wed, 14 Jul 2021 11:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 937C4C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7482740588
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cwGUkhFZwwNf for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:17:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0875C40265
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:17:52 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id q16so2982537lfa.5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S9CrgQqGn5mkur2H1auPSMo6yYyTfwNd3lzn8O6SIGw=;
 b=riPdNj4nnn9+vFqNzMZJogEZahBnodLVfG8St8ipsNT0UBjxKFX2vW3ci3rdWcmZ88
 VRiImWCPQK7fykq639PSAazmul6V971xU7kpsDGmx80lalx05Nz04pd90+wjhlejxlYe
 K8A89OJw/gI4YKCUMYhLiOe7h/8Z9Mdrrmcws8fsS4IDnLPMEgqppuoAsqsJz8JAFw/L
 7p5eEU2P4SZLtekb/5hikLzOQKAT4iRISXSBwq9cv80cLXMvYn/5BKjFVTOng0qcJfjs
 Ck2DzRyg9VQuUZfhstr0bbbk8yfcLI9RdK9iFuZYq9lIr8FdYd5CA25uItRMQg1O+E0g
 yjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S9CrgQqGn5mkur2H1auPSMo6yYyTfwNd3lzn8O6SIGw=;
 b=AB7Hkent/ImuEi13hr5kO8s1Rutas0OvPuTslLMry8m10AnAvIIxU4VyGFeTSOm5gk
 94VkXkytPaA9kJBY03f3HYLuTBa7rTs8vu1FaO2MMKcYiW8U+YweW/PGzWMH/JrQbw0H
 xd6l5Lud+mopJMiXsaGABaVuZGHWDYcsRhW+q157F3/9mS77YmWjpQb6pkLI7wPkKdCy
 izlvHfPEJHCh20ToiFbcQ1Cc2FCfrVscI5o1OIZShfbcD8JZHNPgm/kC10U797HxkE2d
 rcmv39D1TWqOiRBydRBur2cfSHdFRY827XBMthqo/Rg77IoG693OsInolOByxmWSzDUE
 rXog==
X-Gm-Message-State: AOAM533btXd3tm1EKynXLoLaff2eJo8RmAyFvKRyJiiHPWueWEo3/wWV
 Hq/PEqw1rsgxwhnL7XiLRlI=
X-Google-Smtp-Source: ABdhPJyB+72mH8f+hRwoSWwuew4QNci28WM3A0pjoJ19MaVqYMg2UaIgTNSbVLIAJhMLj+x+uuuFVA==
X-Received: by 2002:a05:6512:34d1:: with SMTP id
 w17mr7752370lfr.439.1626261469836; 
 Wed, 14 Jul 2021 04:17:49 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru.
 [94.29.37.113])
 by smtp.googlemail.com with ESMTPSA id b4sm141504lfp.223.2021.07.14.04.17.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jul 2021 04:17:49 -0700 (PDT)
Subject: Re: [PATCH v1] iommu/tegra-smmu: Change debugfs directory name
To: Joerg Roedel <joro@8bytes.org>
References: <20210712001341.11166-1-digetx@gmail.com>
 <YO7B56Mkz3kx5U5Q@8bytes.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <43abb785-8b6a-555b-7d66-fa1911d2f8a0@gmail.com>
Date: Wed, 14 Jul 2021 14:17:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO7B56Mkz3kx5U5Q@8bytes.org>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MTQuMDcuMjAyMSAxMzo1MiwgSm9lcmcgUm9lZGVsINC/0LjRiNC10YI6Cj4gT24gTW9uLCBKdWwg
MTIsIDIwMjEgYXQgMDM6MTM6NDFBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAt
CWVyciA9IGlvbW11X2RldmljZV9zeXNmc19hZGQoJnNtbXUtPmlvbW11LCBkZXYsIE5VTEwsIGRl
dl9uYW1lKGRldikpOwo+PiArCWVyciA9IGlvbW11X2RldmljZV9zeXNmc19hZGQoJnNtbXUtPmlv
bW11LCBkZXYsIE5VTEwsICJzbW11Iik7Cj4gCj4gQXJlIHlvdSBzdXJlIG5vIG9uZSBpcyByZWx5
aW5nIG9uIHRoZSBvbGQgbmFtZSBzbyB0aGF0IHRoaXMgY2hhbmdlCj4gYnJlYWtzIEFCST8KCklJ
VUMsIFRoaWVycnkgYW5kIEpvbiBoYXZlIGEgdGVzdGluZyBzdWl0ZSB0aGF0IHVzZXMgdGhlIG9s
ZCBuYW1lLCBidXQKaXQgc2hvdWxkbid0IGJlIGEgcHJvYmxlbSB0byBzdXBwb3J0IHRoZSBuZXcg
bmFtZSBpbiBhZGRpdGlvbiB0byB0aGUgb2xkCm5hbWUgc2luY2UgaXQncyBpbnRlcm5hbC9wcml2
YXRlIHRlc3Rpbmcgc3VpdGUuCgpUaGUgcmVhc29uIEknbSBwcm9wb3NpbmcgdGhpcyBjaGFuZ2Ug
aXMgYmVjYXVzZSBpdCdzIG5vdCBvYnZpb3VzIHdoZXJlCnRoZSBTTU1VIGRlYnVnIGlzIGxvY2F0
ZWQgd2hlbiB5b3UgbG9vayBhdCB0aGUgZGVidWdmcyBkaXJlY3RvcnksIGl0CnRha2VzIHNvbWUg
ZWZmb3J0IHRvIGZpbmQgaXQuCgo+IEFsc28gdGhpcyBjaGFuZ2UgbWVhbnMgdGhhdCB0aGVyZSBp
cyBhbHdheXMgYmUgb25seSBvbmUgU01NVQo+IHBlciBzeXN0ZW0uIElzIHRoYXQgZ3VhcmFudGVl
ZCB0b28/CgpBIHNpbmdsZSBTTU1VIGlzIGd1YXJhbnRlZWQgaGVyZS4gT25seSBsYXRlc3QgVGVn
cmEgU29DcyBoYXZlIHR3byBTTU1VcwphbmQgdGhvc2UgYXJlIEFSTSBTTU1Vcywgd2hpbGUgdGhp
cyBpcyBhIGxlZ2FjeSBUZWdyYSBTTU1VIGhlcmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
