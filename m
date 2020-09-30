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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B370C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:29:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015C82076B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1T+AylV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015C82076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CEDC850E9;
	Wed, 30 Sep 2020 16:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOFvVSl9_0qb; Wed, 30 Sep 2020 16:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3330D84FB0;
	Wed, 30 Sep 2020 16:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 069B1C0889;
	Wed, 30 Sep 2020 16:29:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E37FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 756AD87216
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19Zr0chukHTA for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A7B23871D4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:29:15 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id z17so2885039lfi.12
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EzyR/YDvIXijh7swdghsNAKpiZabsqY73hYX4hLjUIE=;
 b=T1T+AylV3LaBdXGum8XogqJ5vyJFo3xWcikbcOxdE0TLIX6SqttUe4NyGt/ld4prn9
 8wTS1+lPzoSyQqJVYd+HqpB4JBxQ/ICiaxplsEHSaXOXT8mqHyamcwo0JfwEFU+FQDci
 sQ4TznKGY+WOj2jETSBczukppjIvT4m1nI1rQvL6Aa2knn5Q+6WO3mVFHZjY44MINvOU
 w6ERL8FnhVgRkkG53TqEECvrTxdyPO5GSbpjZAoeRKhoR8HlxsqVeh+01ZvFTeFHmArJ
 ljFohIBGkNZk8M12rb3XcqY4dxULnZEiR1M4R/STY3QS8sfvB6BgZRi4/IFeWNOb90uj
 uW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EzyR/YDvIXijh7swdghsNAKpiZabsqY73hYX4hLjUIE=;
 b=FDJ5tZVQ1QtQAS1ktYTDVO3J2d9sB8USzgFOI1akRfOZkAXvASGeZg5WmaNWAEmFjp
 02ivHSad9Ws/NZ1/31TL+IeLN0PZF0czkki6DWQS6+QCYBfj0fZryv1lGjkRY3P5S4D1
 IG1Uyjax5RiKiJwL23tCjKeYpswKgVk8iqVCtYv/GNfr1fNVkkWXVdnEh41lgLygMKB+
 NUdT9wQlkA/YH18UXJ7EJSrT9MtymYKHkLeA3dctyKMNFjtnAcdWatE2Fz1nF9yvL4ED
 QT7G5zGBcF8EHY0rH5SyDGguAjzp6I5GtVtMlzfAUKm3T3WkQ+mqX/xOYThU0L2KcGef
 HKxg==
X-Gm-Message-State: AOAM530o62TJgPvRlonElStFUYCimyxuBkdDXWjg6/zvJ4UKf0kDk133
 xvz80VGwGijGcZ6wB8Efy3w=
X-Google-Smtp-Source: ABdhPJy/XbDWHR4hfmk8+U5h3ZueC5w/GyTS/H7hzhmzAV+DwLsuai3Wmfi3eX7rtx5fxS75BHBHTw==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr1242052lfc.242.1601483353973; 
 Wed, 30 Sep 2020 09:29:13 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id m1sm245883lfr.32.2020.09.30.09.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:29:13 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Thierry Reding <thierry.reding@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
 <20200930161033.GE3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36946786-38c5-54d4-07f5-2407c39aa01c@gmail.com>
Date: Wed, 30 Sep 2020 19:29:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930161033.GE3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
>> Secondly, I'm already about to use the new tegra_get_memory_controller()
>> API for all the T20/30/124/210 EMC and devfreq drivers.
> 
> Also, this really proves the point I was trying to make about how this
> is going to proliferate...

Sorry, I'm probably totally missing yours point.. "what" exactly will
proliferate?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
