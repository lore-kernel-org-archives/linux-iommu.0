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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C015C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:41:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8671E2076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNkZLJZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671E2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 19030860FD;
	Wed, 30 Sep 2020 14:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrabuwKFx0t2; Wed, 30 Sep 2020 14:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9BF0685F10;
	Wed, 30 Sep 2020 14:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8C7C016F;
	Wed, 30 Sep 2020 14:41:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28102C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0F014871D2
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyI7kH+Z-Hd9 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 14:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 164CE871CA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:41:31 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id b12so2442853lfp.9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6Lys2W6r4uZ+JX1Onj0nOj2DyGILV+GiicWVaaDTbhY=;
 b=JNkZLJZ5MRllsBCJdpRE1u37X/c/q+oLZP1F3LbzZqGrxmckGpJY1wzFXFntooiqf2
 Dq4ZuCHwjgbTQc2wZMmjUNwhJ6tqgcd0l7i2fDpyKp3WZlK/J3bFqiptDqZEhscCRES2
 NWvYyPr02rFZV2fhwK26+p3v1viIJTajPF59U2bWQYrzQ53ote0tQqY8kLhN4oZbjeQO
 bWtweB34MvLdZarKsjtCMdgN4mJ2PEJ3MFvZYq9x4LOtId/KS42HlUUzosFOKLEPlJJJ
 eb4M8m7kD/mo83ymWXeFTeCgay65yiUnTvOkD1/bIdMBsoJxtt2tUmlDSiwo8fDSHdBm
 oQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Lys2W6r4uZ+JX1Onj0nOj2DyGILV+GiicWVaaDTbhY=;
 b=S09GkxqyAIQgQdOlF8tv/aulM3opFCGTFtB2FzYXdknnn7sFaNZP/30wTWJf/60rUA
 4xBxN8+v+PHLHvjhuf+ojJVzF3eM0hyQO7LnckfCp5f8FY0VJL8pq0VD5nxfa6PHCuTY
 RFuqQt+dT5JadfSNFiq9NligsrjvhIOtLAOHGbJwU1d8FoUnEPSRlop06OollUb9zePR
 /oMXrGEeZgrat4ohVJQuiRs04IpP52iox1+m/Ggc7DgJdD6h8HG1RTNI51rtT1DuqL4e
 9wro6OpVDXaiLqcWbvRJgx/+qY5k6Qj+8ZU2SM4eMBpY3zOMCDwZ8VPeTL79tUi5BhLS
 dtSA==
X-Gm-Message-State: AOAM533EpphsgtjrKe+EirkekSPzByWhMgVkh8DaAxErGy6K2BqL3n/b
 xF3Vf+SfZ0HbxOPxvlN8aYM=
X-Google-Smtp-Source: ABdhPJxZteRnCj4CyjWFcyNQ7qma6ukKblkKDrRwCBv2GJXz+iCTYWRhMG04fbUpOIdXG+DUQQJSeg==
X-Received: by 2002:a19:e03:: with SMTP id 3mr902474lfo.488.1601476889348;
 Wed, 30 Sep 2020 07:41:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id e14sm175616ljp.15.2020.09.30.07.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 07:41:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f9712d4c-8497-ca84-0d8a-d33eb6abc513@gmail.com>
Date: Wed, 30 Sep 2020 17:41:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930084258.25493-2-nicoleotsuka@gmail.com>
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
> +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	struct tegra_mc *mc;
> +	int err;
> +
> +	np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
> +	if (!np)
> +		return ERR_PTR(-ENOENT);
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	mc = platform_get_drvdata(pdev);
> +	if (!mc) {
> +		put_device(mc->dev);

This should be put_device(&pdev->dev). Please always be careful while
copying someones else code :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
