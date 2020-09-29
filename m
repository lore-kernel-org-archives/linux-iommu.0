Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B7C2D0A8
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:18:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC7A2100A
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 00:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVViTjv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC7A2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCF6520519;
	Tue, 29 Sep 2020 00:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3yjoIosA5mA; Tue, 29 Sep 2020 00:18:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D101C204E6;
	Tue, 29 Sep 2020 00:18:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C983FC016F;
	Tue, 29 Sep 2020 00:18:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F31FBC0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DFC6E86D63
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 69DQmu+iu7FE for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:18:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C4EA386D85
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 00:18:01 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id d15so3375612lfq.11
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LWyAFftzTgQ/8ZzQPra6i4Q9NzonWukybh/xqSD4SNY=;
 b=KVViTjv7RofB3mbilJ2qmNPZNQQZQ2SkADTKbbPfsgHfvKhDmG8TMVEnLO+2Krmjrm
 OQJFHEfjvECuHHMGCafV5snickVdo8dhrl+Q2j/yh3Hbq2kvm9teu9Rpn0tG5lPPi6Qe
 zyUuHkY5yn/SIMD6H4Jy7HupHIvoCpS8dk2IyVuXQxrHzo7NQMgkPIrqzNul7mQiDMVI
 53dSdLsumgoB2js+usNGms5nvdcz2QhLsOFimGfizTbkV18pygYDl5jCyz0vR3u+trvg
 FZ1+dk2qbQRZV6u9X6LBvV53Xv6MDgESnLeqnfjhdNEaHzrsnkWWhro1xHp45PKiHMJt
 BN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LWyAFftzTgQ/8ZzQPra6i4Q9NzonWukybh/xqSD4SNY=;
 b=RdhTrLhbKXm0aEXoR/Zxif24eXiMVCn5bsKw/rerH2NUoHiNFd+jfr89gCpfwPE+iv
 sCEzRnP8WeYChvDeqjEYfSPddHFuBlra4fKke/sCDWJ5boEoWLRfz9N7WYZcipPvTtUq
 pFD+RwHrn+wHp9QJbeJT9KzmmRHxE+WbrIgcWFquM/WH3s8kAlHN5opuoCzzU1+DxzgY
 UVANEvMVf6vWeSsMM/e7Wk2nvfXeXtbKSPIJC3hwu7pfTIwWXFZSUjZ8g+hsH8HBRi02
 j2oLDrIRRW25kKcvWYVNjxgRE7LSCYVTGzP26XiFjB7uoXHI/TPVsp6pqevGReRSoGBZ
 otIg==
X-Gm-Message-State: AOAM531+5kNueAQwSb4JMpy/umqskxUmE11Gu8qGKWCHCdMMs2PBKEQT
 PJwLLl2OJ5VFZoYPt8hEip8=
X-Google-Smtp-Source: ABdhPJwFazCF3sQTeRk6md9P7UFhr2ln8RaMSsv5Xi844x9rjX1AdEJnCbCVu/UtUBG0dljKX7XY9Q==
X-Received: by 2002:ac2:4424:: with SMTP id w4mr217288lfl.447.1601338679960;
 Mon, 28 Sep 2020 17:17:59 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id x25sm2990589lfe.284.2020.09.28.17.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 17:17:59 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] iommu/tegra-smmu: Expend mutex protection range
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20200928235901.28337-1-nicoleotsuka@gmail.com>
 <20200928235901.28337-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <692b51fa-7a3e-dee7-b628-7cb2d2dc188d@gmail.com>
Date: Tue, 29 Sep 2020 03:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928235901.28337-3-nicoleotsuka@gmail.com>
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
>  static bool tegra_smmu_capable(enum iommu_cap cap)
> @@ -420,17 +413,21 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
>  				 struct tegra_smmu_as *as)
>  {
>  	u32 value;
> -	int err;
> +	int err = 0;
> +
> +	mutex_lock(&smmu->lock);
>  
>  	if (as->use_count > 0) {
>  		as->use_count++;
> -		return 0;
> +		goto err_unlock;

This looks a bit odd because it's not a error condition. Perhaps should
be better to "goto bump_usecount"?

Or make it similar to tegra_smmu_as_unprepare()?

>  	}
>  
>  	as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
>  				  DMA_TO_DEVICE);
> -	if (dma_mapping_error(smmu->dev, as->pd_dma))
> -		return -ENOMEM;
> +	if (dma_mapping_error(smmu->dev, as->pd_dma)) {
> +		err = -ENOMEM;
> +		goto err_unlock;
> +	}
>  
>  	/* We can't handle 64-bit DMA addresses */
>  	if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
> @@ -453,24 +450,35 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
>  	as->smmu = smmu;

bump_usecount:

>  	as->use_count++;
>  
> +	mutex_unlock(&smmu->lock);
> +
>  	return 0;
>  
>  err_unmap:
>  	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
> +err_unlock:
> +	mutex_unlock(&smmu->lock);
> +
>  	return err;
>  }
>  
>  static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
>  				    struct tegra_smmu_as *as)
>  {
> -	if (--as->use_count > 0)
> +	mutex_lock(&smmu->lock);
> +
> +	if (--as->use_count > 0) {
> +		mutex_unlock(&smmu->lock);
>  		return;
> +	}
>  
>  	tegra_smmu_free_asid(smmu, as->id);
>  
>  	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
>  
>  	as->smmu = NULL;
> +
> +	mutex_unlock(&smmu->lock);
>  }
>  
>  static int tegra_smmu_attach_dev(struct iommu_domain *domain,
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
