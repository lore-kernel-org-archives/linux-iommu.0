Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45402C433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 10:10:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D5E207D3
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 10:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koBIRYoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D5E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C843888525;
	Wed, 27 May 2020 10:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sEzyBeEIGXb; Wed, 27 May 2020 10:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D44E884F0;
	Wed, 27 May 2020 10:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0ADC0881;
	Wed, 27 May 2020 10:10:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D929C016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 10:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DAF1A204A7
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 10:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGccA8b4q1K7 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 10:10:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 8D4A820466
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 10:10:51 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id u188so2460756wmu.1
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Qd8hzfMUkbpvDYlLRKp/0UsF9Qc7Mjic4CNEGESMZAo=;
 b=koBIRYoqG8UiAGIstbeLL+sUozySWCuEHjV2crt4qDcFK32C5//bStc8EHN8DHv1SQ
 xQwKdIr2u8sYxIhZ5/zR9kGAaTqWsfLdbI4QmS7roKlsjCb5gL2sHXLzdC3QSKaeawvZ
 xyXg1O5Lm5n1/rHderxLhmIoVmiEVyguGf34KLr8SvGsN0cXr5zEabOALsubgQ+DjwWK
 wRit+r9DN8htPn/XrgbPfnlrZv0kc3P0fxQ/8AwQgJhhwZFzHyopT/8ZaTnXTvDmV4li
 scUHIJiTURISbezierI7XvgG+RL5+/0R1cUdUHm5SnzD/pjQZhn/lg3inAaeTl28y+9Y
 xpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qd8hzfMUkbpvDYlLRKp/0UsF9Qc7Mjic4CNEGESMZAo=;
 b=oxo0M7GpuhNDRsOOHOSqZF9djPq8mFLHaSjwWsfJOxxEwozoU6QcO2xOia0gA2tGUa
 lKQh8BkXeEptzltGlVjXbhXngb4Tn6ZBpHMCNGZlw21HpvgNECR2sOyRyYg2emqu6gZY
 RbNKR6K3YZUsqKyBnwvqlOX8CpkmaqihoG5rwwtMHHW4Dm7GIivJ5m7oCFTynK/YhGYV
 bP8qD+l3lRIUgCjKFCS8s7+oCccjBVDajej2JhQNPrbk1sXEKm33HJe65RC+phmZnLqq
 ZW+qdJH5KZjpKkEXhrYzUUdoAwiqKFi5OK0r2x7l22LcmmugAHHOpssJLMhfDpIHQwlF
 4OFg==
X-Gm-Message-State: AOAM532ByrgmxXqLAu+E/BdtauZSaNlN8ghRkybQj69WNEWuP5UPnL6q
 +dRsRE2Q+R9n7TvGSwnGY/3ta6g3NMc=
X-Google-Smtp-Source: ABdhPJwKD6l8ueThFeLOnGF6f9gwoYB0sKBu5kQd0bSHy0nZvN4gaPANHlZbXiVo4dm3weBoMRpb/g==
X-Received: by 2002:a1c:9613:: with SMTP id y19mr3418198wmd.135.1590574249685; 
 Wed, 27 May 2020 03:10:49 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id h196sm2351200wme.22.2020.05.27.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 03:10:48 -0700 (PDT)
Date: Wed, 27 May 2020 12:10:38 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH v2 0/2] iommu: Remove iommu_sva_ops::mm_exit()
Message-ID: <20200527101038.GD265288@myrica>
References: <20200423125329.782066-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200423125329.782066-1-jean-philippe@linaro.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jgg@ziepe.ca,
 zhangfei.gao@linaro.org
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

Hi Joerg,

I was wondering if you could take these two patches for v5.8. The API
change is a precursor for the SVA support in SMMUv3, and the VT-d
implementation of the SVA API (queued for 5.8) doesn't implement
iommu_sva_ops.

Thanks,
Jean

On Thu, Apr 23, 2020 at 02:53:27PM +0200, Jean-Philippe Brucker wrote:
> The IOMMU SVA API currently requires device drivers to implement an
> mm_exit() callback, which stops device jobs that do DMA. This function
> is called in the release() MMU notifier, when an address space that is
> shared with a device exits.
> 
> It has been noted several time during discussions about SVA that
> cancelling DMA jobs can be slow and complex, and doing it in the
> release() notifier might cause synchronization issues. Device drivers
> must in any case call unbind() to remove their bond, after stopping DMA
> from a more favorable context (release of a file descriptor).
> 
> Patch 1 removes the mm_exit() callback from the uacce module, and patch
> 2 removes it from the IOMMU API. Since v1 [1] I fixed the uacce unbind
> reported by Zhangfei and added details in the commit message of patch 2.

[1] https://lore.kernel.org/linux-iommu/20200408140427.212807-1-jean-philippe@linaro.org/

> Jean-Philippe Brucker (2):
>   uacce: Remove mm_exit() op
>   iommu: Remove iommu_sva_ops::mm_exit()
> 
>  include/linux/iommu.h      |  30 -------
>  include/linux/uacce.h      |  34 ++------
>  drivers/iommu/iommu.c      |  11 ---
>  drivers/misc/uacce/uacce.c | 172 +++++++++----------------------------
>  4 files changed, 51 insertions(+), 196 deletions(-)
> 
> -- 
> 2.26.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
