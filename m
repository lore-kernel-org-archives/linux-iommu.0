Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C8C3524D
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5524320658
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ln975L+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1034185C28;
	Mon,  3 Feb 2020 08:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e+uJlIbVl1VZ; Mon,  3 Feb 2020 08:29:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C8A784F69;
	Mon,  3 Feb 2020 08:29:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 537C2C18DD;
	Mon,  3 Feb 2020 08:29:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E40C0171
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 22:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 197DF876A5
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 22:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fIBFyG7Lz6r for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jan 2020 22:00:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C6F188764B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 22:00:45 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id t6so3282207plj.5
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jan 2020 14:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=b82MM5TsQ8A9XNdp0Y7iZIjPTfIvG0TXd9OXwa8Voa4=;
 b=ln975L+nUDW8vHW1M3ExHfHLl4zJ6xQ7xAqDPH8kgpaC2M25g/M0mpJXtoR9nZ8+zX
 fCKziGOUYvBuahWMFfMcvJFOCeQJEiH1U3THEAK/GpEkWuPqWgoraNYhdLCyxaDPJZk7
 8hf9/Az5nYC2xFao/C79k4QgNJRVjrt4tf2rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=b82MM5TsQ8A9XNdp0Y7iZIjPTfIvG0TXd9OXwa8Voa4=;
 b=LT+g7cozG8i9RTJjig4A04sH4FM0tYf7SV7EkkaXANYMu30FhRatLJyKar3U5WIpm4
 WGzCdv+YB3AOImpX2Hcv72G887JZKhGbzkDxFSKhEltlvxhRr4aNBSA6AJOcV6Pv0+sY
 XN82DdVO7bPB7cBdSrQgQ2AcX4REufVCCsL6Lc0Gv1VfQniMZGejTlr2kQucRWya9yP/
 ThsMZIAU4r6C2B3PgsvzJpcs8RZmB06kEtp7KFTk5rub0uNsMlK3B/izOu3B2/hQttJc
 /d7gHQYeKo4VKM1TRhZDa7nWEueMdng6wKNP4s8ocXx24V6cDOTLVMjDAg64Iv3Vu5L4
 pi4Q==
X-Gm-Message-State: APjAAAWIxgPMRPdWdKrs+mmnzgl842e8GBP/g6vsJ5skgH5fxVIMQZhB
 dedaIIpwDN0+YawNn42mJ7HjEA==
X-Google-Smtp-Source: APXvYqxJ4dABMrxvg8Mkn8WWBjXAgyn0FUDu4pBM/f8rqnl3BFmy/f1OIqxj6WnyNvD4RpAWCJnROA==
X-Received: by 2002:a17:90a:36af:: with SMTP id
 t44mr14554287pjb.25.1580508045310; 
 Fri, 31 Jan 2020 14:00:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
 by smtp.gmail.com with ESMTPSA id g2sm11436046pgn.59.2020.01.31.14.00.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 14:00:44 -0800 (PST)
Date: Fri, 31 Jan 2020 14:00:43 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Sharat Masetty <smasetty@codeaurora.org>
Subject: Re: [PATCH v2 1/7] iommu/arm-smmu: Pass io_pgtable_cfg to impl
 specific init_context
Message-ID: <20200131220043.GN71044@google.com>
References: <1577962933-13577-1-git-send-email-smasetty@codeaurora.org>
 <1577962933-13577-2-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1577962933-13577-2-git-send-email-smasetty@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Mon, 03 Feb 2020 08:29:04 +0000
Cc: freedreno@lists.freedesktop.org, will@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, dri-devel@freedesktop.org,
 robin.murphy@arm.com
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

Hi,

On Thu, Jan 02, 2020 at 04:32:07PM +0530, Sharat Masetty wrote:
> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Pass the propposed io_pgtable_cfg to the implementation specific
> init_context() function to give the implementation an opportunity to
> to modify it before it gets passed to io-pgtable.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-impl.c |  3 ++-
>  drivers/iommu/arm-smmu.c      | 11 ++++++-----
>  drivers/iommu/arm-smmu.h      |  3 ++-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index b2fe72a..33ed682 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -68,7 +68,8 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
> 
> -static int cavium_init_context(struct arm_smmu_domain *smmu_domain)
> +static int cavium_init_context(struct arm_smmu_domain *smmu_domain,
> +		struct io_pgtable_cfg *pgtbl_cfg)
>  {
>  	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
>  					      struct cavium_smmu, smmu);
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index eee48f9..4f7e0c0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -758,11 +758,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		cfg->asid = cfg->cbndx;
> 
>  	smmu_domain->smmu = smmu;
> -	if (smmu->impl && smmu->impl->init_context) {
> -		ret = smmu->impl->init_context(smmu_domain);
> -		if (ret)
> -			goto out_unlock;
> -	}
> 
>  	smmu_domain->pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= smmu->pgsize_bitmap,
> @@ -773,6 +768,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		.iommu_dev	= smmu->dev,
>  	};
> 
> +	if (smmu->impl && smmu->impl->init_context) {
> +		ret = smmu->impl->init_context(smmu_domain, &smmu_domain->pgtbl_cfg);

Which patch adds 'pgtbl_cfg' to struct arm_smmu_domain? The field does
not exist in iommu/next.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
