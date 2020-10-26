Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CD4C4363A
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 17:15:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C97B20727
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TOai25NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C97B20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C3CAB2E126;
	Mon, 26 Oct 2020 17:15:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6k57-t0ytvNU; Mon, 26 Oct 2020 17:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E3B971FD90;
	Mon, 26 Oct 2020 17:15:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6621C088B;
	Mon, 26 Oct 2020 17:15:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 918ECC0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73A5D2E123
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoDf628a9orO for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 17:15:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by silver.osuosl.org (Postfix) with ESMTPS id 274221FD90
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 17:15:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1603732553; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ubLgLNz4mruxjMMlVTL1wQFtrF+CIhu/zLVlKRGmGmg=;
 b=TOai25NNoU2pytUPt0tIS4JDwKJhVUv9WTsNKOSBpKxhUAkRBtN/EajJkTB1KJ+H9/dFqqBl
 3sE5cKd+WB9w/1n3LXmCuRaYEZQhhNPy8OaPcyJ34fZDUpuWw4tIU9Mxolny1bsD2l8YxMgQ
 H1zvVJhzPtdr+e06CTz8TDQbIKo=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f97043f3ecd8ffc94cb7ac1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 17:15:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D16ADC43391; Mon, 26 Oct 2020 17:15:42 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 72C2CC433F0;
 Mon, 26 Oct 2020 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72C2CC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 26 Oct 2020 11:15:37 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv6 3/6] drm/msm: rearrange the gpu_rmw() function
Message-ID: <20201026171537.GA23509@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 freedreno@lists.freedesktop.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 dri-devel@lists.freedesktop.org,
 Sharat Masetty <smasetty@codeaurora.org>
References: <cover.1603448364.git.saiprakash.ranjan@codeaurora.org>
 <863b0eb175fb2a4ebfefca09344e0055722190cf.1603448364.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <863b0eb175fb2a4ebfefca09344e0055722190cf.1603448364.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 linux-arm-msm@vger.kernel.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Sharat Masetty <smasetty@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Oct 26, 2020 at 05:24:02PM +0530, Sai Prakash Ranjan wrote:
> From: Sharat Masetty <smasetty@codeaurora.org>
> 
> The register read-modify-write construct is generic enough
> that it can be used by other subsystems as needed, create
> a more generic rmw() function and have the gpu_rmw() use
> this new function.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Rob - this should be safe to pull with msm-next regardless of the merge status
of the iommu side of things. Hopefully everything will be pulled for 5.11 but if
it isn't it would be good to get this out of the cycle.

Jordan

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 8 ++++++++
>  drivers/gpu/drm/msm/msm_drv.h | 1 +
>  drivers/gpu/drm/msm/msm_gpu.h | 5 +----
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 49685571dc0e..a1e22b974b77 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -180,6 +180,14 @@ u32 msm_readl(const void __iomem *addr)
>  	return val;
>  }
>  
> +void msm_rmw(void __iomem *addr, u32 mask, u32 or)
> +{
> +	u32 val = msm_readl(addr);
> +
> +	val &= ~mask;
> +	msm_writel(val | or, addr);
> +}
> +
>  struct msm_vblank_work {
>  	struct work_struct work;
>  	int crtc_id;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index b9dd8f8f4887..655b3b0424a1 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -478,6 +478,7 @@ void __iomem *msm_ioremap_quiet(struct platform_device *pdev, const char *name,
>  		const char *dbgname);
>  void msm_writel(u32 data, void __iomem *addr);
>  u32 msm_readl(const void __iomem *addr);
> +void msm_rmw(void __iomem *addr, u32 mask, u32 or);
>  
>  struct msm_gpu_submitqueue;
>  int msm_submitqueue_init(struct drm_device *drm, struct msm_file_private *ctx);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 6c9e1fdc1a76..b2b419277953 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -246,10 +246,7 @@ static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
>  
>  static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)
>  {
> -	uint32_t val = gpu_read(gpu, reg);
> -
> -	val &= ~mask;
> -	gpu_write(gpu, reg, val | or);
> +	msm_rmw(gpu->mmio + (reg << 2), mask, or);
>  }
>  
>  static inline u64 gpu_read64(struct msm_gpu *gpu, u32 lo, u32 hi)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
