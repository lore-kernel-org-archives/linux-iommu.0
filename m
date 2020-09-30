Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79239C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:53:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F592076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlfsUy9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F592076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97D7720337;
	Wed, 30 Sep 2020 14:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-GGBOaBBMdv; Wed, 30 Sep 2020 14:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7DC1F20347;
	Wed, 30 Sep 2020 14:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 573F3C016F;
	Wed, 30 Sep 2020 14:53:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4458EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3A67185F10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gdDdqOfD2wmJ for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 14:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 604BE85E91
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:53:23 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id b12so2492234lfp.9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cBiTt8w7J1gPwC7ywtmeoqJg6ORKtAlvgvECsQBVk8Y=;
 b=NlfsUy9vpCET0GRm9FHJO2K/tAdRODKdiVwSRuXxY9aIjSk+P8E07sDuQVrncTqOnk
 yLjQa9f5zZJW2Nk4T5FeI3xtvXvJ7rQIcZomW13YTDrlbCI7+8bsuN7mZtjKZmTAGyYY
 /Q1FJt8d8rf6BEmJv4D80BLFeYGO/xAmZknESkR7Wcqxb+WN+o+/CNZWuuMaum+aCRrR
 QOslN4pcvCFOoqD1cAVMYMGaSSNRbqlVG2Y6+DD0IHlHzvxHGjkqVVFzf0DEER3fpn8U
 rfvtz8l/CGQ9/FprYEoB5e572iLGsyDWdUS0IIR3dbX5PpLjuS6JmWotz77EBJTnKwN5
 wR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cBiTt8w7J1gPwC7ywtmeoqJg6ORKtAlvgvECsQBVk8Y=;
 b=HWVwAtSu/I8frQVFUamfyazOki6BtQPfE5wIhCTYVjsS6w3D+kRZT68+iiJAFkPj06
 fgnt3C0qyAG8RKRpDs0Qvm8pMp+nDE+GSI8OoFbd7Top7KP2q6P/KGlPpWS0xiym8ZAi
 rxzMKG8B2pm1zPu/8zV8el317OB39x/vot3zw6sIybKPYHdVCK6RhqTSNnYSr+cokQla
 4LH3KhjHHVuNqvSkH2pa5/J8u7x1ztoI3xY2zVQJzWlG6s9BWt+tpsobUWy5OQpdQE2s
 FcUrNzdp9nSt5KIVqeOXfQ612VD765U5jImwAEzCg6H3eKZ6RAEjcM/2CpR0BVOQi/cz
 fXUQ==
X-Gm-Message-State: AOAM530CoiT7g8RpZJ80koDKteCoF0A4u1mOE99ri32uxcLpmTwZr1jp
 zmI1I5i1YQ/jDr2kX2W7ZZ4=
X-Google-Smtp-Source: ABdhPJxlcOW6WbGbdJT6g8UnmJSwMo6kLgrWGSydiTS1ApgR68IHgbXhqhZlSVyJZKmuJWr/2QUsYQ==
X-Received: by 2002:a05:6512:36cd:: with SMTP id
 e13mr1088472lfs.165.1601477601361; 
 Wed, 30 Sep 2020 07:53:21 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id j3sm218964lfb.185.2020.09.30.07.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 07:53:20 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-4-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
Date: Wed, 30 Sep 2020 17:53:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930084258.25493-4-nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

...
> +#ifdef CONFIG_PCI
> +	if (!iommu_present(&pci_bus_type)) {


In the previous reply you said that you're borrowing this check from the
arm-smmu driver, but arm-smmu also has a similar check for
platform_bus_type, while Tegra SMMU driver doesn't have it. Hence I'm
objecting the necessity of having this check.

Please give a rationale for having this check in the code. And please
note that cargo cult isn't a rationale to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
