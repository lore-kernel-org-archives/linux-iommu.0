Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B685C433F5
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 18:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FF36403D8;
	Sat, 19 Feb 2022 18:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMG-bN6vlNRN; Sat, 19 Feb 2022 18:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF9DF4034C;
	Sat, 19 Feb 2022 18:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8995EC0035;
	Sat, 19 Feb 2022 18:54:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 142C6C0033
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E95C681765
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LmQUotPI2eqj for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 18:54:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 267FC81763
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:54:23 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id bu29so11450056lfb.0
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=Ci6QRGwAlkUphSDT6SSS26W4w72+zrbvF3RFtSti1zA=;
 b=hxmOALR7fu4NSCDBQpNlkYo3cbQuBRUGBm6lqCfXOABtakxfFcfezKMvO+rZUKfYYB
 K7nd2fsc2Y2y8Fo3EbiQKJsxIpdlW68MopfYn9lH59b5EvdJSK/rc2co4kiBiHTMCxJr
 5mixYHCQduWGM1vSXhLxd7X44w9m6tHtBzUxgCM5DcUFR6pfYQFRDt1VBtXLR1G6ZMkA
 AWDtx6ST7x2efloQyAMVCN7wXJfIUwUAAApgInco0cEY8j5L/B6gEXM3Qv/aViH93nPc
 ku0aOl5uiULvMBHjnODgB2UFdF1T4J1TGbSbktZ4H9hnay+tfEw7SGlajbPSd69mgFyN
 sy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=Ci6QRGwAlkUphSDT6SSS26W4w72+zrbvF3RFtSti1zA=;
 b=7p9CsduHtXdkn2uDOxUIz4lldw/uM6bIJIvLacTXOVtwBaStnJhkmrXM+v29GYIEZa
 Ym782hsmmn7OizrrfxgtLAl59CV1A/gEDX5TAhbGt++xBcSnQSjR0q2cAglo/E/Fw/1j
 +16CVmAmlDiEMfXfY8B0SczEmBfdvnfUUTeUG/adKrrINyfpeNkU5uAQmvZxhDfL8iSn
 6pQx+4PWGGbfr0gQAchSuYJ0D2hYVnsRDoG7Ov1y0OK7S6NQpDNXAtpNhZBIO2AWJoJ7
 VXQdapd+jUsQaVrzjj6AlBgcw1+nS8slQRqGMZ5IMw/NnuiR4mqM64S4xciURQbe14If
 uO0A==
X-Gm-Message-State: AOAM530U+GFvzLQUokrUGRs2Vli21c0kYnQZYW87NLGqgZiaQP3JqQCk
 IqRNPUzzAjFY9Uny93SB0PY=
X-Google-Smtp-Source: ABdhPJxmMnmGlPqJgyh+vYOuXmx5fXZ96x5FviI71xKObjIWMROoDlv5HlFyEEe4tE1z3VFN7Oh3sg==
X-Received: by 2002:a05:6512:220b:b0:443:3113:ef90 with SMTP id
 h11-20020a056512220b00b004433113ef90mr9303085lfu.475.1645296861746; 
 Sat, 19 Feb 2022 10:54:21 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id h11sm638555lfr.208.2022.02.19.10.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 10:54:21 -0800 (PST)
Message-ID: <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
Date: Sat, 19 Feb 2022 21:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
In-Reply-To: <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

MTkuMDIuMjAyMiAyMTo0OSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMTguMDIuMjAy
MiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4+ICtzdGF0aWMgaW50IHZpY19n
ZXRfc3RyZWFtaWRfb2Zmc2V0KHN0cnVjdCB0ZWdyYV9kcm1fY2xpZW50ICpjbGllbnQpCj4+ICt7
Cj4+ICsJc3RydWN0IHZpYyAqdmljID0gdG9fdmljKGNsaWVudCk7Cj4+ICsJaW50IGVycjsKPj4g
Kwo+PiArCWVyciA9IHZpY19sb2FkX2Zpcm13YXJlKHZpYyk7Cj4gCj4gWW91IGNhbid0IGludm9r
ZSB2aWNfbG9hZF9maXJtd2FyZSgpIHdoaWxlIFJQTSBpcyBzdXNwZW5kZWQuIEVpdGhlcgo+IHJl
cGxhY2UgdGhpcyB3aXRoIFJQTSBnZXQvcHV0IG9yIGRvIHNvbWV0aGluZyBlbHNlLgo+IAo+PiAr
CWlmIChlcnIgPCAwKQo+PiArCQlyZXR1cm4gZXJyOwo+PiArCj4+ICsJaWYgKHZpYy0+Y2FuX3Vz
ZV9jb250ZXh0KQo+PiArCQlyZXR1cm4gMHgzMDsKPj4gKwllbHNlCj4+ICsJCXJldHVybiAtRU5P
VFNVUFA7Cj4gCj4gSWYgKCF2aWMtPmNhbl91c2VfY29udGV4dCkKPiAJcmV0dXJuIC1FTk9UU1VQ
UDsKPiAKPiByZXR1cm4gMHgzMDsKCmFuZCBzL0VOT1RTVVBQL0VPUE5PVFNVUFAvCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
