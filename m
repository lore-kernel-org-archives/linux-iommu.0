Return-Path: <SRS0=68Au=FS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DCDC4361B
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 16:21:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9ED225AB
	for <iommu@archiver.kernel.org>; Mon, 14 Dec 2020 16:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9ED225AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 45E2686645;
	Mon, 14 Dec 2020 16:21:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-h7w8WfDGx3; Mon, 14 Dec 2020 16:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F22D86439;
	Mon, 14 Dec 2020 16:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32563C0893;
	Mon, 14 Dec 2020 16:21:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF4E1C013B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 16:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A4190203D5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 16:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z9LLM-3IaMep for <iommu@lists.linux-foundation.org>;
 Mon, 14 Dec 2020 16:21:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 9140A2001C
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 16:21:47 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id l200so19724523oig.9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Dec 2020 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dypRW42Ag7SaNLUbf+uRP+IPcXW54P4LYSzuOs3g98U=;
 b=YUpN5dXm3OUT+XIzfFv0/IsmZDizXudCOrliTwPuAwdNhNisqhZHrinOtRIsBM+Pci
 KUd191tAFdQgNa8BuTyJdi89g2JmKTlm98C5axup3HYhao4ko9xKSrzDEOq3KwWNYnFq
 B3SWlKDwYV5QpeEqru6dF8bLBOgBpt6Of+DjlDnbbh/YaX3hNEQNRDL+3lCHSxHJwXcs
 vF//zSrAvlVhDG9jQX6RWMWQkceoV38s+amNbh7HMpqaUy/eENJ4yMEz5iMpQV6rnNQK
 y0DCREvCBXKnFwcFeuCFKfDC/zbnM3IOIy3heJeztRYf1vqdvhXZqms1or0xbJuhee1o
 Qs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dypRW42Ag7SaNLUbf+uRP+IPcXW54P4LYSzuOs3g98U=;
 b=JoAG6PRPNRduV6UdYm2C4GG4VELmt57VjHFvQA3Y6oN9r0h8kZ4l0n1fyXw3sCzqzi
 g7LroL2a2ww87KfxeSawo4rBzyVBnduDSrJlmBK6I/tkFmsaI57EiQ9yKo6I3FU9Zh6a
 d3NAHe+l69vdIhHsPB+jQ8/Rp62EKjsPaM/majeyK5nPZYrRXP9jQxO1E+oJnGgORTe/
 ontgf9hlIbYyt62r7BuS7HQ8ggidZcQk/EiYETJze1hW6aN54KCo+BJvml/MysPWw5Jx
 bZdF0DGRSh78kB9k4tLGuyxsqyEF9fVmzR79fn09tqe6pkUf+XkcRP3EXlpNn4jMzEQ6
 /7AA==
X-Gm-Message-State: AOAM531CGHKkKNnBKNrcxClmr+4INIro5LuDDZ4FTkoS0dt5JGyHcz5+
 eOwsPpgwZdlnF1c1JXh/xcPJFg==
X-Google-Smtp-Source: ABdhPJytx4fAQVDhA0UmXOWYQZ4w31/WKetaPmA3PWn5pcAwVbQgOFRfKCsJK7iHTnq3U5Vymw2H7w==
X-Received: by 2002:aca:ed51:: with SMTP id l78mr2098851oih.144.1607962906753; 
 Mon, 14 Dec 2020 08:21:46 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id k71sm4180810otk.48.2020.12.14.08.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 08:21:45 -0800 (PST)
Date: Mon, 14 Dec 2020 10:21:44 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: Re: [PATCH -next] iommu: msm_iommu: Delete useless kfree code
Message-ID: <X9eRGFup8LqSejsp@builder.lan>
References: <20201214134746.5044-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201214134746.5044-1-zhengyongjun3@huawei.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org, will@kernel.org
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

On Mon 14 Dec 07:47 CST 2020, Zheng Yongjun wrote:

> The parameter of kfree function is NULL, so kfree code is useless, delete it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/msm_iommu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 3615cd6241c4..1286674a1322 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -319,7 +319,7 @@ static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -		goto fail_nomem;
> +		return NULL;
>  
>  	INIT_LIST_HEAD(&priv->list_attached);
>  
> @@ -328,10 +328,6 @@ static struct iommu_domain *msm_iommu_domain_alloc(unsigned type)
>  	priv->domain.geometry.force_aperture = true;
>  
>  	return &priv->domain;
> -
> -fail_nomem:
> -	kfree(priv);
> -	return NULL;
>  }
>  
>  static void msm_iommu_domain_free(struct iommu_domain *domain)
> -- 
> 2.22.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
