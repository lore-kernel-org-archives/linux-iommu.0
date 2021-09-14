Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD3C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 19:20:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F7761260
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 19:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8F7761260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 846754021A;
	Tue, 14 Sep 2021 19:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpDPe0EC8GWO; Tue, 14 Sep 2021 19:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 77E6A4038B;
	Tue, 14 Sep 2021 19:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 385BCC0011;
	Tue, 14 Sep 2021 19:20:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17E4AC000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 19:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01A584010F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 19:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQZCOiJPtzgI for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 19:20:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 96131400A4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 19:20:34 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id h16so621997lfk.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sWUveR2st8W0vI/cjNjCZ7SFinSkJr9hz3+NwIh5zpw=;
 b=QK8y3w5xbn/XH3R6Lh0goR3B1q+DKq37YdfrTgzs8oOf1GLlRm2xfOPYfMyZhG3wx4
 O1RuuYiQNIIiCMWRzlpTWPY4Ngq4KW3zJvySWMYGGU42D900bBPxJTkhM0WqyyJksZMM
 UoUkEGgvTRYRS2qvVmR0JB4qwKzxMKZOsUhXPlioGZi1r5AgJ3crLYgH0wRmAHD97pTq
 yHWbUn01auG+e2mMFTej9B0R9POqdEkYQSPNeo2Rs32TD75Kwn3zKqqZJTzh8HVu+EHi
 7azgZjW5KVW5pPHkGk80S54JdZXUCxOTeZgkuGMyibKF1XHik9T4HSnNQr0pLQ9wrJLX
 oYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sWUveR2st8W0vI/cjNjCZ7SFinSkJr9hz3+NwIh5zpw=;
 b=MxjX6PxA/FSTNhxXaYT8SFXsrlXZjSzcUDaLCvwzbAnlrCSyqu34mgFXg4E9oEKxCY
 C3EGNA8eZvGfx1iABr+6OOQaXPmjKq1PkOqN5/6At0gTgiR5BbHnu7iXURJ0Lc/lLW1O
 suheOjtyE3dBZARRpi6Ur4/Ju6X7L1CuXa34woJ6mo9Jc1fALNqR9ZU9mEJvnMYxSgOt
 NUJWfow5zPmDFlQCQm4M4LKCx8VVijkuznFEkl4GgaatokG2+3dgDQ7Y8Qb90AOEDbcJ
 jIstzNv01k7D3mX72dtJYg7K0pMNRfTsfzfg4KBWJtEzFZD+Go4kgZV5ONdPxKD1b6S3
 MqLA==
X-Gm-Message-State: AOAM530V+VGIqB2Ca7uMCXyCKCEDS5qkl5rKf6lsHAo9uucx785Eo//P
 1zplPkIBAAmrcQXpSnaWcvE=
X-Google-Smtp-Source: ABdhPJyY4q+Rms2R5q4yuEjNMcWE8zHzIgYnjvP4+9Cip3MQivqsHDeOuAYhpmFlejWFO+AL7aKTjQ==
X-Received: by 2002:ac2:5e9c:: with SMTP id b28mr14190756lfq.405.1631647232471; 
 Tue, 14 Sep 2021 12:20:32 -0700 (PDT)
Received: from [192.168.2.145] (46-138-83-36.dynamic.spd-mgts.ru.
 [46.138.83.36])
 by smtp.googlemail.com with ESMTPSA id p14sm1405436ljj.140.2021.09.14.12.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 12:20:31 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
 <31501a62-3312-9f04-3bb8-790d0481746c@gmail.com>
 <20210914184933.GA32705@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <25d68aff-323a-df54-45f9-55b22f3089e0@gmail.com>
Date: Tue, 14 Sep 2021 22:20:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914184933.GA32705@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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

MTQuMDkuMjAyMSAyMTo0OSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gVHVlLCBTZXAg
MTQsIDIwMjEgYXQgMDQ6Mjk6MTVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAx
NC4wOS4yMDIxIDA0OjM4LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+ICtzdGF0aWMgdW5z
aWduZWQgbG9uZyBwZF9wdF9pbmRleF9pb3ZhKHVuc2lnbmVkIGludCBwZF9pbmRleCwgdW5zaWdu
ZWQgaW50IHB0X2luZGV4KQo+Pj4gK3sKPj4+ICsJcmV0dXJuICgoZG1hX2FkZHJfdClwZF9pbmRl
eCAmIChTTU1VX05VTV9QREUgLSAxKSkgPDwgU01NVV9QREVfU0hJRlQgfAo+Pj4gKwkgICAgICAg
KChkbWFfYWRkcl90KXB0X2luZGV4ICYgKFNNTVVfTlVNX1BURSAtIDEpKSA8PCBTTU1VX1BURV9T
SElGVDsKPj4+ICt9Cj4+Cj4+IFdlIGtub3cgdGhhdCBJT1ZBIGlzIGZpeGVkIHRvIHUzMiBmb3Ig
dGhpcyBjb250cm9sbGVyLiBDYW4gd2UgYXZvaWQgYWxsCj4+IHRoZXNlIGRtYV9hZGRyX3QgY2Fz
dGluZ3M/IEl0IHNob3VsZCBtYWtlIGNvZGUgY2xlYW5lciBhIHRhZCwgSU1PLgo+IAo+IFRlZ3Jh
MjEwIGFjdHVhbGx5IHN1cHBvcnRzIDM0LWJpdCBJT1ZBLi4uCj4gCgpJdCBkb2Vzbid0LiAzNC1i
aXQgaXMgUEEsIDMyLWJpdCBpcyBWQS4KClF1b3RlIGZyb20gVDIxMCBUUk06CgoiVGhlIFNNTVUg
aXMgYSBjZW50cmFsaXplZCB2aXJ0dWFsLXRvLXBoeXNpY2FsIHRyYW5zbGF0aW9uIGZvciBNU1Mu
IEl0Cm1hcHMgYSAzMi1iaXQgdmlydHVhbCBhZGRyZXNzIHRvIGEgMzQtYml0IHBoeXNpY2FsIGFk
ZHJlc3MuIElmIHRoZQpjbGllbnQgYWRkcmVzcyBpcyA0MCBiaXRzIHRoZW4gYml0cyAzOTozMiBh
cmUgaWdub3JlZC4iCgpFdmVuIGlmIGl0IHN1cHBvcnRlZCBtb3JlIHRoYW4gMzJiaXQsIHRoZW4g
dGhlIHJldHVybmVkIHVsb25nIGlzIDMyYml0LAp3aGljaCBkb2Vzbid0IG1ha2Ugc2Vuc2UuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
