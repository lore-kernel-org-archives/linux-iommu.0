Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE20C433B4
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:51:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60576141E
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 05:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60576141E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 932AB842D2;
	Wed, 28 Apr 2021 05:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CE_nlqyCQk94; Wed, 28 Apr 2021 05:51:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F52383DF0;
	Wed, 28 Apr 2021 05:51:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76998C0022;
	Wed, 28 Apr 2021 05:51:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D45A0C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7F0F60620
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KImASzsMAQpR for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 05:51:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AD4E6060E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 05:51:04 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id b38so29709995ljf.5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WxSDWJBKubTe8n31Ne0qppIwGIo+P1mF3Vf38REuc2Y=;
 b=crelfWOqIYnCaWLEZuJNLVQ3Ex7ONPKeatjPyvp7rwx/wDvnF0Ue6WkHPxpGANlt5p
 h8YanZj7qT5r6/dawYQgHD+QwQWRlfhXKhGks5m3TmIFUSf9JgxW2QW7CdYlFpnrUjut
 Udhcn31rlOkuBIQ66W8rJ/WXrXUVdg7+YoU4smv3PpZ7WI6FAG3oaXE3SlqNwoH79gMf
 Ry1AuaesNOgUzERt3zbhwJX9iDSGYUBf/0MLSQJRERgkJy1a/QQpCE3vFGHCwn4ETyrx
 66QApFr8V1sW4euyURXXNkiBms9A6KT7/9RwucLV3WTIQagKpuftroG6FfVRtpYxGpfo
 uATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WxSDWJBKubTe8n31Ne0qppIwGIo+P1mF3Vf38REuc2Y=;
 b=Zkwf9X4pwc68AcJLGKYRsNRKYEtbahQnzYkGef2iCejrqvGXTU10WJkcd1HzvNQru4
 uyx/k+Jac78pnJqtGS1wy3oGtBqhpr0CSO03K1u6BLAnJ62M/R9W4+9RXDmYR0aBHz+g
 hutizMbI6gLEIV68COwXrxw6JzoQclPaacKWsoY8c905BEkUDtp9uWLRkeNn6fRG90Rj
 vlUYWuQ2byqhGfaVVcUg6LheoC2M8Q5PL8XcrQC2dW6uH7oA6U8EtuKvefNuYxIuhmb4
 Gk5x61017cMA3d8WJLeq6sJwsXJBUKeLT1Pb2vRMOY+yH8fmgD90NdFgVtucXD4L3/cJ
 gtQA==
X-Gm-Message-State: AOAM533A404ywFE8u+/KQK5m+em1Oh2a8ZiyTkgZto4GpGMcqUrlIEYK
 ihmXQ6fFVseviOgj9Ma4dn8=
X-Google-Smtp-Source: ABdhPJwuAJK4aFYajohCA0T5i71uWmaClgd0xYfxsrAdmww9qbx9226OHVGHhTgkF5PAvkBApg8pLA==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr19071704ljl.500.1619589062803; 
 Tue, 27 Apr 2021 22:51:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-102.dynamic.spd-mgts.ru.
 [109.252.193.102])
 by smtp.googlemail.com with ESMTPSA id g9sm462878lfv.120.2021.04.27.22.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Apr 2021 22:51:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b6d323e1-2e90-b031-60a0-3460644ea7a0@gmail.com>
Date: Wed, 28 Apr 2021 08:51:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

MjMuMDQuMjAyMSAxOTozMiwgVGhpZXJyeSBSZWRpbmcg0L/QuNGI0LXRgjoKPiBOb3RlIHRoYXQg
dGhlcmUgd2lsbCBiZSBubyBuZXcgcmVsZWFzZXMgb2YgdGhlIGJvb3Rsb2FkZXIgZm9yIGVhcmxp
ZXIKPiBkZXZpY2VzLCBzbyBhZGRpbmcgc3VwcG9ydCBmb3IgdGhlc2UgbmV3IERUIGJpbmRpbmdz
IHdpbGwgbm90IGJlCj4gcHJhY3RpY2FsLiBUaGUgYm9vdGxvYWRlcnMgb24gdGhvc2UgZGV2aWNl
cyBkbyBwYXNzIGluZm9ybWF0aW9uIGFib3V0Cj4gdGhlIGFjdGl2ZSBmcmFtZWJ1ZmZlciB2aWEg
dGhlIGtlcm5lbCBjb21tYW5kLWxpbmUsIHNvIHdlIG1heSB3YW50IHRvCj4gYWRkIGNvZGUgdG8g
Y3JlYXRlIHJlc2VydmVkIHJlZ2lvbnMgaW4gdGhlIElPTU1VIGJhc2VkIG9uIHRoYXQuCgpTaW5j
ZSB0aGlzIGNoYW5nZSByZXF1aXJlcyBhIGJvb3Rsb2FkZXIgdXBkYXRlIGFueXdheXMsIHdoeSBp
dCdzIG5vdApwb3NzaWJsZSB0byBmaXggdGhlIGJvb3Rsb2FkZXIgcHJvcGVybHksIG1ha2luZyBp
dCB0byBzdG9wIGFsbCB0aGUgRE1BCmFjdGl2aXR5IGJlZm9yZSBqdW1waW5nIGludG8ga2VybmVs
PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
