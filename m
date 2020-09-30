Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02B9C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:11:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C7C20706
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5GCeSEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C7C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A80692041B;
	Wed, 30 Sep 2020 05:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmShIUaBL9eY; Wed, 30 Sep 2020 05:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1311520424;
	Wed, 30 Sep 2020 05:11:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 044FBC016F;
	Wed, 30 Sep 2020 05:11:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 437F2C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 30C78871B7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bYzDVELggsGj for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:11:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 79E9386450
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:11:55 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id s205so454485lja.7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rLwBsch1+w3pmAWJFs5DtFDJyLpowZ0+c2NUgy8bnXs=;
 b=m5GCeSEprGiDpHfi1VS3q22QiyOE2gFVXY3X32Hm2ec83A0n6RZ00T7c+/qFGIMHwY
 x+Puym/28gNgogutmTqBX4rkB4UjmJzUVIXE15Sbrn2sqTD+URXqGHKDRpJgF61y2ppg
 041DnlHDm90GsKWEBv4kYAlbaIHy581CdsGbgx2g1TTA027Ic4WwXaakvEoQsL5Qqian
 amomBfKWeKKRr5oj84PKUryv3ZTNWo9LnopBpeW596Vfp+7Y6KHApGZ/T9XqT4uh8D69
 XUtQChvpjIThUM04sA+tJ6HLWfsa844JL2KEeq+GkjD3WtBKNQohQsfbc4aBCjOPrJYy
 VnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rLwBsch1+w3pmAWJFs5DtFDJyLpowZ0+c2NUgy8bnXs=;
 b=Sky1cHuyHWPGmYGcGwIvmEsUHxLFz8t9BYI4EvTXMTxOk0vp2h0h8qpvKE8Hun8zhY
 GO8hiYDEp9myUFqkBwCe/7FvLBVZmt0o4a3BO8CmX4MjqiFpwjYg7pjvf7F5YvMA+eSp
 oFGSJnn2ugZ9Ohw6KQleS63YnNFDp3U09+ilyl99n9EILsURSNH0O1ZKX0kv5syIzvwk
 wdV8C0mcLmip7MM+8T/sAd+9WIVt1e6aBmj7R/CQmxfpqqzNv1BeHjCnmhO7CahgpwGk
 OcTYYAv8qxFvjZpLLcbLC/fTpD4xxUF09QRCVewFVZf3dWusS9a8yzgkwW4FwSO8Txez
 7MnA==
X-Gm-Message-State: AOAM5324S8DADvtBdh0Vd9Sr3EnyiAWJXR+NCocySpBcLr+114JMifGo
 tkvH2iL21R8ZVniHIhr8kHU=
X-Google-Smtp-Source: ABdhPJxWyMn8thmjGkZ8EmMO0wqHrJQj8NxdwNWM0AxXfLfuVFFIm63GXwGeOiyAEd98d86t10qEng==
X-Received: by 2002:a05:651c:1397:: with SMTP id
 k23mr341636ljb.263.1601442713758; 
 Tue, 29 Sep 2020 22:11:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id u23sm48284ljl.86.2020.09.29.22.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:11:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <75514da5-e63a-9e51-8376-abbd12c324d1@gmail.com>
Date: Wed, 30 Sep 2020 08:11:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-3-nicoleotsuka@gmail.com>
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

MzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gKwkvKiBBbiBpbnZh
bGlkIG1jIHBvaW50ZXIgbWVhbnMgbWMgYW5kIHNtbXUgZHJpdmVycyBhcmUgbm90IHJlYWR5ICov
Cj4gKwlpZiAoSVNfRVJSX09SX05VTEwobWMpKQoKdGVncmFfZ2V0X21lbW9yeV9jb250cm9sbGVy
KCkgZG9lc24ndCByZXR1cm4gTlVMTC4KCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZF
Uik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
