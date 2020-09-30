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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB0C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:36:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07B3207C3
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ53PzRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07B3207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 11A9D866FB;
	Wed, 30 Sep 2020 15:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uWUfEtzCUPXD; Wed, 30 Sep 2020 15:36:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9117A864DA;
	Wed, 30 Sep 2020 15:36:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86771C0890;
	Wed, 30 Sep 2020 15:36:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95B1BC016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7CB3F8719E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PtCi3XQS05Vk for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 15:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A9FB987143
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 15:36:55 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id w3so1979233ljo.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rqnrG6Pizn8ox8uxYFSKzaugVeMdBDCYSIAjysYBMrg=;
 b=GQ53PzRmH8UL1499Q2RJylmVszIyYrijKd09ZwcUX2T2vuw3aUCiWCL3NNPme6a4cb
 j0U5bgN7tRBxexsD7bLfLrKu0efRHsslx2gjx/ao3r8MFgoVeKcXnEQPCFYrH13wOB8T
 cZM2S9BGMG35x3K7xqsXv8e03mkEDY2c0CwYP60osx4K8tiiApd/jqCzI6KCxpsHBNkG
 nkc19gd43b7Pduua4qQZEGm5ZSAJuLaijts93Lw9qsF9bFj3X9dEaNs1p+cAQS6f4Jof
 MPRfJgbiZpDzvEL8MUiEzWz8chAVkvVtu7VQczb+GFiPxC1E+8SYwyu46a6xlhUyyEcv
 IOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rqnrG6Pizn8ox8uxYFSKzaugVeMdBDCYSIAjysYBMrg=;
 b=AOQYGQ2IogLnYrI2hZCRr1TXre1y4lCBjAGHb9l2o1PiI5z5hM++olgHBTzAnynHlu
 2fVjNy3JtPgwa3jzd5/Oc0Pl3lvsnWjoiP8cW5k3+2+2AzTIEWGCeqWcSnc6xpYjLarY
 R9MkeGY6JkiAu/kLaE91859on5UQBRD0X7srRQ1l/6VDjB+nmjgtT3T+ZO7sV+dZwu2c
 s0jknmG4dE2cfPDN4IZ4s3fuv/BmXk1tpLBUxk6VpmyW/pYQGQr3Lej5PDndDPhIJ1LI
 uw0+V2F69ucuNvkbsOc6trevjo6bevMTExU983ZGKrY7Lq7fL/Thpwig8lTRjqbOH4IL
 mbqA==
X-Gm-Message-State: AOAM533D5ByLU8A093v5QDC6/nKTp7WSYxwEsNDAl3ujVJEuqCZlpevd
 AqJeIH0vCvwpEmP8s+7j7pI=
X-Google-Smtp-Source: ABdhPJzsndJWU6ESCTX5fCeh1abc7U//REedB9J40+plLgx7mgrDwkkTfQicDDlG++H+wLxA10l0lw==
X-Received: by 2002:a05:651c:1064:: with SMTP id
 y4mr974771ljm.107.1601480213985; 
 Wed, 30 Sep 2020 08:36:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id t17sm188718ljo.23.2020.09.30.08.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 08:36:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
Date: Wed, 30 Sep 2020 18:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930153131.GB3833404@ulmo>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

 I'...
>> +	struct tegra_mc *mc = devm_tegra_get_memory_controller(dev);
>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> 
> It looks to me like the only reason why you need this new global API is
> because PCI devices may not have a device tree node with a phandle to
> the IOMMU. However, SMMU support for PCI will only be enabled if the
> root complex has an iommus property, right? In that case, can't we
> simply do something like this:
> 
> 	if (dev_is_pci(dev))
> 		np = find_host_bridge(dev)->of_node;
> 	else
> 		np = dev->of_node;
> 
> ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
> sure that exists.
> 
> Once we have that we can still iterate over the iommus property and do
> not need to rely on this global variable.

This sounds more complicated than the current variant.

Secondly, I'm already about to use the new tegra_get_memory_controller()
API for all the T20/30/124/210 EMC and devfreq drivers.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
