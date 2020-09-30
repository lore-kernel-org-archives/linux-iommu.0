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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A8C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CC92074A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+eIUnDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CC92074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBC85871AD;
	Wed, 30 Sep 2020 05:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MOpg42aeeOGu; Wed, 30 Sep 2020 05:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FBCE871B4;
	Wed, 30 Sep 2020 05:10:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C3B6C016F;
	Wed, 30 Sep 2020 05:10:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8427FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 73AEA85F75
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6LhBRpaGBqP for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1AE718506B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:11 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id w3so456478ljo.5
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+bNH00/3TyfIl7ZmwUbB3/9mSNJL/xs6urc84WGD8GQ=;
 b=G+eIUnDiiFVQqLzVvhzNbtgRd8FBnc+NxeAyEMeLgwyr3gEs/cYEv5/Nr4xHPbeaUH
 R2+9LBdcKv2hwfzKBaeocX1H/DCOXwH0lkIuZmUaPBobHONWj+WEyV0rQY6xvHXpjc68
 Ky0zPRMmYSYRLlw2zXvJbBZjPZdsNWpR8JpeCA2nHzvcChEqV1+BkZI2Dlv3a+3zrekF
 IqBaxtYCYmnwgy84Fy55K72QFMB7DfqVQku9auLfwv2G76FMU/YnbASLCbOEo0cO5ctS
 o4JkTfi2qCiqyHsk2HInQR4mbI2fYRfE0oYBkrJKIM4QWl/jld/n9JgQhf/EVBttuPJK
 6Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+bNH00/3TyfIl7ZmwUbB3/9mSNJL/xs6urc84WGD8GQ=;
 b=aaxF+yRAah87KTiPAdklNMbjPqaFkvomR0mdlO9lcc3zMWeyJAhXg+7rwqyXoIyXuV
 qbr57CJoVAP58QgdzTaqyFLWK8p/cEUVhJdiI7ZUR6L3UJOL5GCwr3f686c8lK8d88fd
 3PMHoVk2niI8rwEu9t9AOPMT0dtchYE9SsJXdiVpWh2jaxFHNhdEWrplwemw3Bi1c56g
 rHRbOPZGTDQs0gE4cIfK1w4m5Ly+eZ2afjj+4r75htS2epD4VGx1j047P5YLgZctevMx
 qUb26xMnQr6x+JCADkEbdsWd+KsQ7aF239TH2sxcO/Xrz0o+Y96z1SJ6CNhMdHbtC8+E
 9dKQ==
X-Gm-Message-State: AOAM533c4+9Y18cqhu4MafPmf8enWw2S7NrBsYGF0p5U3HO/X9VLt+oZ
 pHA3lkjxsQgBiSabNzmIXlI=
X-Google-Smtp-Source: ABdhPJyBeiHR9Qc67e7ldwWWy0bPbLVPgS64Y2llKuUrtKUpPvGasO3B2VdR5oOOslPZQ9jKVsvWlw==
X-Received: by 2002:a2e:3304:: with SMTP id d4mr292406ljc.440.1601442609011;
 Tue, 29 Sep 2020 22:10:09 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id x73sm54949lfa.94.2020.09.29.22.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:10:08 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f07d4fcc-ee19-874b-c542-0679660c3549@gmail.com>
Date: Wed, 30 Sep 2020 08:10:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-4-nicoleotsuka@gmail.com>
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

MzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gLQlncm91cC0+Z3Jv
dXAgPSBpb21tdV9ncm91cF9hbGxvYygpOwo+ICsJZ3JvdXAtPmdyb3VwID0gcGNpID8gcGNpX2Rl
dmljZV9ncm91cChkZXYpIDogaW9tbXVfZ3JvdXBfYWxsb2MoKTsKClRoaXMgd2lsbCBiZSBuaWNl
ciB0byB3cml0ZSBhczoKCmlmIChkZXZfaXNfcGNpKGRldikpCiAgICBncm91cC0+Z3JvdXAgPSBw
Y2lfZGV2aWNlX2dyb3VwKGRldik7CmVsc2UKICAgIGdyb3VwLT5ncm91cCA9IGdlbmVyaWNfZGV2
aWNlX2dyb3VwKGRldik7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
