Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5AEC433E3
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 20:10:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7DB207BB
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 20:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaI2XwvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7DB207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AAB6888436;
	Thu, 20 Aug 2020 20:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stnT1TaF-JKQ; Thu, 20 Aug 2020 20:10:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E5EC8816A;
	Thu, 20 Aug 2020 20:10:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06322C0889;
	Thu, 20 Aug 2020 20:10:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04354C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 20:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F384A88093
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 20:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FP4LlZ8aVGVc for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 20:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 314DF882CD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 20:10:28 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id v9so3503124ljk.6
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aGDq3G61oS7LkIVvcYe8gs5DEBUj3X0IY6+Ho7L4bXc=;
 b=aaI2XwvNa4jYT+ZP++lm8ICOT30vbHbYUWZ2eapjPgVOrbFZiW0JrsNRnHrkHauDAe
 F+tXGAAqJ4vzEu+ctIrX4IM+yBsxNUqux5EEMIr8tDiF5nelEImI1pAGijUjDb9sdpr+
 3jhTQx0pxPCjI9Yjxp5eOYRJHWEFTz3Q/JDopYi/d21uwf6ydkQJd8zd0nrYHrBm51gj
 IJ251b8BXCu/KouQNs7VyVjZaRoQ6EfqJzBBwEfbvaelF0x0hTDyx36zN9EiD0UZhoes
 jE4vU9heUNNm5TPrDjhlMPFoFqDRVuH+5P+XTNd0kuG1aP3MnluFFFC7ajaNVZ0Eb9HZ
 g3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aGDq3G61oS7LkIVvcYe8gs5DEBUj3X0IY6+Ho7L4bXc=;
 b=EH0FMOkijq6EV3IcaOTLP5thhSfhSZhZZbPyT8EULDyT3zfw3e9TcFXjuH6OJ3gWiA
 Z6c53XEwdm6tFXp52E1sg5qNu8FpIxpXscPK4vGBJypKf5FU79FOfPuGiVnE1Syt5cOM
 vRFEr4JeTO2ON+WxI5TNC0IC88phHoVTvJIfQGk7bhtKtMBKAMplc9cmmH7/0DuLVFQ5
 QEGbGv7r4d/ym21TcBF1dmoL4vXAGWHwgPaX1esWDNQ/0QdZfc5E3HlmujZLKQ+FBL4R
 yA5J4fFQqNBww9ASTeN5g6zwBEEP0mDfFtr6lKZZ2cve7aYqiJn6xCGo1KZwmTRxYDcN
 8TpQ==
X-Gm-Message-State: AOAM532qkjYQL8a7upuwdT/AEUxKgBFt1G0KlPkKG+9nIIqatUnwVW1B
 O4BAS31Oh8usLRGNlpRcZkw=
X-Google-Smtp-Source: ABdhPJwerR6+NSwUtwLl00X9aib7HLlZlj50J5PUAv4AGloGJDrAm7Kb1tk696rJXQBYokDQvzy/bw==
X-Received: by 2002:a2e:9886:: with SMTP id b6mr684ljj.258.1597954226414;
 Thu, 20 Aug 2020 13:10:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id f23sm633489ljk.74.2020.08.20.13.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 13:10:25 -0700 (PDT)
Subject: Re: [PATCH 16/18] staging/media/tegra-vde: Clean up IOMMU workaround
From: Dmitry Osipenko <digetx@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
 <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
Message-ID: <ebc9c605-b986-daef-9f2c-1834437fd292@gmail.com>
Date: Thu, 20 Aug 2020 23:10:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
Content-Language: en-US
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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

MjAuMDguMjAyMCAyMjo1MSwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gQWx0ZXJuYXRp
dmVseSwgdGhlIFRlZ3JhIFNNTVUgY291bGQgYmUgY2hhbmdlZCBzdWNoIHRoYXQgdGhlIGRldmlj
ZXMKPiB3aWxsIGJlIGF0dGFjaGVkIHRvIGEgZG9tYWluIGF0IHRoZSB0aW1lIG9mIGEgZmlyc3Qg
SU9NTVUgbWFwcGluZwo+IGludm9jYXRpb24gaW5zdGVhZCBvZiBhdHRhY2hpbmcgYXQgdGhlIHRp
bWUgb2YgYXR0YWNoX2RldigpIGNhbGxiYWNrCj4gaW52b2NhdGlvbi4KPiAKPiBPciBtYXliZSBl
dmVuIElPTU1VIGNvcmUgY291bGQgYmUgY2hhbmdlZCB0byBhdHRhY2ggZGV2aWNlcyBhdCB0aGUg
dGltZQo+IG9mIHRoZSBmaXJzdCBJT01NVSBtYXBwaW5nIGludm9jYXRpb24/IFRoaXMgY291bGQg
YmUgYSB1bml2ZXJzYWwKPiBzb2x1dGlvbiBmb3IgYWxsIGRyaXZlcnMuCgpBbHRob3VnaCwgcGxl
YXNlIHNjcmF0Y2ggdGhpcyA6KSBJJ2xsIG5lZWQgdG8gcmV2aXNpdCBob3cgRE1BIG1hcHBpbmcK
QVBJIHdvcmtzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
