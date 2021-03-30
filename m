Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DBC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 11:00:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122B561928
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 11:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122B561928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FF2B606C6;
	Tue, 30 Mar 2021 11:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4GV4CD53KzA4; Tue, 30 Mar 2021 11:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 555BD606E3;
	Tue, 30 Mar 2021 11:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CA3FC000B;
	Tue, 30 Mar 2021 11:00:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BE9EC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 11:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57727606E3
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 11:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwXdWv9JUViX for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 10:59:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 812C46068B
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 10:59:59 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 j4-20020a05600c4104b029010c62bc1e20so8162912wmi.3
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hwv0VGtVRsToH5qSgnXqGQzyHEdaY5YNe1vOOamTk0o=;
 b=LmqF8R4YAf+VUo/T1bNZVx6Q0HOyjAAROmCGqhpYe10LzFmMO1x0RSINSVOQKv+moQ
 C1fmsz/UMW4IxsBSCIM+0UcOd0YHxoECpP7nGOJym0ERY/dedzkLtVPWXsKFLrPK556z
 ZH+a4OEssjMGp9qzK2zOp5WRcNx55yvyavWOVwA0KZ8IdAY4hz7ba+YAtt72lY9fBSDk
 EVAwI8j1zOhBk9tNbZlRIuKLJAfmNfPEcXwHMbUjwMY7UjIM5rc2zsnr6WHYAZtsrFcf
 Lgxqc07GX9COiSWfR6J8jnPJtNPUoGVpelrCFu2tALZztLmAp6T0XQp2ZL2+Clls4IXG
 PKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hwv0VGtVRsToH5qSgnXqGQzyHEdaY5YNe1vOOamTk0o=;
 b=RREM1Mux7akm6RfLs6me6XFv7MOy0PfEryPFjxWk8Ai2ySvyaiDHVfeFq3/GHtOYLv
 ORaNK0a8lo56Q9RLEvvmNzmNDTFcdmmwKIqOv/Ztgb+fWTmMMLZUT8Sq0OvOqbqkUETK
 m2L0BoC4R0q6o+pFI68bFhs24Xr0LNeE8nGDKHglftL23ULF6dwVukW11JIpkJXxRak5
 anIscsjxcKEUWJU69JNiK4SzpIvHWsj66QObeKCHruyjrbmHwCk5E4EW3DGfWyiebNwR
 Zfc7JL6n1ydUbvIbFfVCL0e4W9HcZhequ8cjNHwpD/T/hVbGDf7qmMSZmw8WjoAXutX/
 dmTg==
X-Gm-Message-State: AOAM530GM503MZvvqCoVW63xAXA8RTMah8KfdrofwxU3D03ao57m2Ufi
 vQzvup7RrLPCT4g/zxdjdN6P8AqvvEpMug==
X-Google-Smtp-Source: ABdhPJyN1sfXezAEQOAbG2VeIahwtmvGMyuqyNib2+BIVv/DwUJp6TwxTAbSzDQdvqFLm860qKiitw==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr3470278wmi.169.1617101997378; 
 Tue, 30 Mar 2021 03:59:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:9424:822a:45ae:b5bd?
 (p200300ea8f1fbb009424822a45aeb5bd.dip0.t-ipconnect.de.
 [2003:ea:8f1f:bb00:9424:822a:45ae:b5bd])
 by smtp.googlemail.com with ESMTPSA id i4sm2772266wmq.12.2021.03.30.03.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 03:59:57 -0700 (PDT)
Subject: Re: [PATCH] dma-mapping: add unlikely hint to error path in
 dma_mapping_error
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <78757abc-ef8f-9a29-9020-967370eec365@gmail.com>
Message-ID: <81bda15b-beb0-02e5-4e5a-f3fa88a5bb9d@gmail.com>
Date: Tue, 30 Mar 2021 12:59:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <78757abc-ef8f-9a29-9020-967370eec365@gmail.com>
Content-Language: en-US
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>
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

On 26.03.2021 22:03, Heiner Kallweit wrote:
> Zillions of drivers use the unlikely() hint when checking the result of
> dma_mapping_error(). This is an inline function anyway, so we can move
> the hint into the function and remove it from drivers over time.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> This is a resend of a patch from Dec 2020 when I tried to do it
> tree-wide. Now start with the actual change, drivers can be changed
> afterwards, maybe per subsystem.
> ---
>  include/linux/dma-mapping.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e9d19b974..183e7103a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
>  	debug_dma_mapping_error(dev, dma_addr);
>  
> -	if (dma_addr == DMA_MAPPING_ERROR)
> +	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>  		return -ENOMEM;
>  	return 0;
>  }
> 


Reviewed-by: Robin Murphy <robin.murphy@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
