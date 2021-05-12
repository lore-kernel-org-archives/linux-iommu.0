Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E7BC433B4
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 15:31:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5992E61CB6
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5992E61CB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6A9640380;
	Wed, 12 May 2021 15:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hLG2wEyQV_s; Wed, 12 May 2021 15:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B30E5401AD;
	Wed, 12 May 2021 15:31:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A03FC000E;
	Wed, 12 May 2021 15:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 211BBC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01FBB60A87
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P3qrxq2HH6q1 for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:31:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 994B06071D
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:31:01 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id n25so27584446edr.5
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=foMbcJ9t/jw1PCF1w8ZLUJQPw4LhtMPOdZ9n9vc+2JY=;
 b=OSx+Ho0M1jKEBkXetkktVDTXudOBNAtPrBVu1YzuVKuTEL1/sS15FPlFFafNV89tco
 NJmlEchhll3j8ZSNq0vnDjLSrR6IeXopJ2aWzzibU3P5McgiEBSg5oZxObnFBtfCd5Q5
 MUSFdOM78SjxcxNUdfhiDx2preN2CamXZg+uo8TvF38qyhemUE1xaDY9JJhz31VE0hBq
 K1KZmg8t3QdmgxzE860qpEhIS/YHtJ8T9mMzATy5C+kQxhq8AwfncXGJMrwPI8/zAtdk
 vL28ba67Her9n6wZeYU5P+AljnG59cHjN91Wp36UCB8Yy//g85zmJIMFF4CgTUdtadqX
 dP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=foMbcJ9t/jw1PCF1w8ZLUJQPw4LhtMPOdZ9n9vc+2JY=;
 b=El0GCR6GID6HfJvoVU+CJPRl7QQKAJd8S94XXST/XIV+EruuI67FqBNFsSP9M0m5pF
 S2YGWf5F2LRikpJxwysXHa3vRBsY4SgKSaM6hjZeK6lZohc3EiPyeGYmVNkhY420QLlI
 uf+UFaxCbKCX6EuM2Fs0v8MQFfkYz/GyCNhHFmSG0q9mzfZnNaaIuEMsyOy7Aw4qLPxy
 /3qoYMg94IVv/Cc6a+FdYbs4EqAGzdbSa2lkYGu4F0qBmFU3Cz+MCdkbSN0BGHXMSJF9
 1OV+zbwKn9BaQoEvzTm0ty4W4Qh5+hS95GpLZc7cJ2vrlNpSM06nfSG35wdWJrGB5+Cp
 T3Pg==
X-Gm-Message-State: AOAM531CfXvYGayIqRZrw/Fxy7camhNsmD4bKLG3UZ5YMPG8hVwI/aSQ
 VRBTr5ti1ObUPVynXjYgfw/NeA==
X-Google-Smtp-Source: ABdhPJz7r5xZBOfByReNbNmN+wJFbb276iWLe5bA39oV+ikWetjEf06uCnPbDSA7ak1z9EzB+Nvgyw==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr44159494edr.111.1620833460097; 
 Wed, 12 May 2021 08:31:00 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id di7sm68216edb.34.2021.05.12.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 May 2021 08:30:59 -0700 (PDT)
Date: Wed, 12 May 2021 17:30:42 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bixuan Cui <cuibixuan@huawei.com>
Subject: Re: [PATCH -next] iommu/virtio: Add missing MODULE_DEVICE_TABLE
Message-ID: <YJv0osddxKqlFUyT@myrica>
References: <20210508031451.53493-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210508031451.53493-1-cuibixuan@huawei.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Sat, May 08, 2021 at 11:14:51AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>

Fixes: fa4afd78ea12 ("iommu/virtio: Build virtio-iommu as module")
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 7c02481a81b4..c6e5ee4d9cef 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1136,6 +1136,7 @@ static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_IOMMU, VIRTIO_DEV_ANY_ID },
>  	{ 0 },
>  };
> +MODULE_DEVICE_TABLE(virtio, id_table);
>  
>  static struct virtio_driver virtio_iommu_drv = {
>  	.driver.name		= KBUILD_MODNAME,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
