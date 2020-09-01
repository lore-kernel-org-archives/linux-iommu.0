Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41718C43461
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1606C208CA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmSH5izG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1606C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C2C58204E7;
	Tue,  1 Sep 2020 05:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUn26gGGPXgS; Tue,  1 Sep 2020 05:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3BFE72038F;
	Tue,  1 Sep 2020 05:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E83C088B;
	Tue,  1 Sep 2020 05:31:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6B6AC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D4E1A8613E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPXpe-d_j25W for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 454BB86113
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:31:50 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id 37so146448oto.4
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ah4wulanW6w834elfegUZ00h7caLTkMycV73Sq0JJsc=;
 b=EmSH5izGYAYMIMbM05yD68/xN+pZG9cT5IEu4PC7V5EdHFWAtW1dw/0ERlIeS3MK0m
 hvKbP2VsYz1kPp88xPbs0rKAV0sC2BgYo3p9odC4ZXDU47xgDpmlYYQyn+xg5CmrR9Dd
 cNXatf9NQdMCm/EInmMdCFU7ot7LCEPW+ajWkr7YCtfJA7bB2LtV7/BGYyh8+jgzHz2+
 CbGk8kZ0J/YJA8aVUce4DkurE5IzgQ0aRY9uVoUIYsUNOPzs9LjTh85QDcLM9++dKY6L
 LymH66Xyc6UIg5Zg5aUChODTVVDgpIcZizLEKqk8/3xNheD5RQ2xW/sP8vQBiDfoioAn
 pbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ah4wulanW6w834elfegUZ00h7caLTkMycV73Sq0JJsc=;
 b=iDYkwWiblzsxLncB0NMI3WYYgoWxVFg2f4LBg00s6PT5w0rCYVJew3U2ICpEwh1ZHJ
 uyQ7+AJswFnz7FdNqEQ0MSYEgxL1rYKSOZ01wTqnNVM9KnRSPCxQOz7fuiGmcZrkW7tV
 itG2ZdenCdBubOl9eifYqXCC6uw3BXnd9ej7XM8nsJ52f8BJrWP1Q2SXmwiJpJ3W4h5p
 R0f61RAmAAMpH+xMD0a0Mo/L639og/QqlnFZBAa5VpIlhvEATfrxD27bnhZ5CIgyQ5Ps
 zz5aHgYZ/SS6rdPNbrAbgGqiF+V/VOeApF5fLLKPAFqn8bm2nTwhkCpgV12cXA4mhpLf
 cRjw==
X-Gm-Message-State: AOAM531CZC9fdM9OczuXCneXrjsYCWWHMAOe/alAag3A/G89nlv7lzqj
 0Tvwot5QIay20rXVZ11PXHOIko+/ozg7ww==
X-Google-Smtp-Source: ABdhPJwrHsRNsq+ddPo5+Vm3z1aTAOZfNB+Y5KDPl/h6cDxgUxeU167eyc1o9QYOLAnmTJw0ENBBWg==
X-Received: by 2002:a9d:238b:: with SMTP id t11mr225178otb.60.1598938309430;
 Mon, 31 Aug 2020 22:31:49 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id i23sm2099742oii.53.2020.08.31.22.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:31:48 -0700 (PDT)
Date: Tue, 1 Sep 2020 00:31:45 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 18/19] iommu/arm-smmu: add a way for implementations to
 influence SCTLR
Message-ID: <20200901053145.GX3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-19-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-19-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 iommu@lists.linux-foundation.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> pending translations are not terminated on iova fault.  Otherwise
> a terminated CP read could hang the GPU by returning invalid
> command-stream data.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 5640d9960610..2aa6249050ff 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -127,6 +127,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
>  		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
>  
> +	/*
> +	 * On the GPU device we want to process subsequent transactions after a
> +	 * fault to keep the GPU from hanging
> +	 */
> +	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> +
>  	/*
>  	 * Initialize private interface with GPU:
>  	 */
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index e63a480d7f71..bbec5793faf8 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		reg |= ARM_SMMU_SCTLR_E;
>  
> +	reg |= cfg->sctlr_set;
> +	reg &= ~cfg->sctlr_clr;
> +
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index cd75a33967bb..2df3a70a8a41 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_SCTLR		0x0
>  #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
>  #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
> +#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
>  #define ARM_SMMU_SCTLR_CFIE		BIT(6)
>  #define ARM_SMMU_SCTLR_CFRE		BIT(5)
>  #define ARM_SMMU_SCTLR_E		BIT(4)
> @@ -341,6 +342,8 @@ struct arm_smmu_cfg {
>  		u16			asid;
>  		u16			vmid;
>  	};
> +	u32				sctlr_set;    /* extra bits to set in SCTLR */
> +	u32				sctlr_clr;    /* bits to mask in SCTLR */
>  	enum arm_smmu_cbar_type		cbar;
>  	enum arm_smmu_context_fmt	fmt;
>  };
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
