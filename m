Return-Path: <SRS0=Mzfx=6Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD8C47255
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 19:37:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE68206DB
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 19:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzVpqUU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE68206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0420D86BB9;
	Mon, 11 May 2020 19:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o7X5gtZ6G_2N; Mon, 11 May 2020 19:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B41486BAE;
	Mon, 11 May 2020 19:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06D21C0178;
	Mon, 11 May 2020 19:37:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA03C016F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1E63087E1B
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNoQACgojw7o for <iommu@lists.linux-foundation.org>;
 Mon, 11 May 2020 19:37:54 +0000 (UTC)
X-Greylist: delayed 00:07:23 by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4F30387856
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 19:37:54 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id f6so5022036pgm.1
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gzyfnO/5LbG2mrH2lA0azbgAQiWtK0agPG/QW/aD0JA=;
 b=OzVpqUU6k4CDMc0nrbShznwLyn+kmnl+BiPHhPbWnikxGiuco8hPSb3nS1q3qW7Cek
 TlIdfXMHgEChfZXCfsI3of4zCEHuppr5PoCE3ZmpK0SP1LiofuG1NSTRPyOmD0nbKgGD
 Bwa03tUplrVt+uaafrpI8WO/Kiw8FLdoImebhEbTRHIm2mxwGlr8SIVV8RSntyAW7IIW
 m9WJ98M8I/GIgMuti/4gM3KJ4GRCV7VPnkIyNoVSwhRvr8uOQ9XfPJNaLkNucRR21ygo
 7yLopUX/fMQxLY0w5Z54iE/yRdh2wOKRkc5CN/QWkO77VCCiI1CCgHTzJiuY46Yq4gJI
 1epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gzyfnO/5LbG2mrH2lA0azbgAQiWtK0agPG/QW/aD0JA=;
 b=c6fhm4Ck2px4DnPh1RyikYRIjLUEeTlvoTr3HxYALCsvZlewF3Bb4Ijf+QMBOsj5kk
 mx3liyXDUDE0KWIl8Db+IMaO+tt611U1qmBvRH9IjO7aDXjQSmLVPeMz5qdNsk/sQMD8
 rk3QdSCCchUpPqi9W+rhNBs/Fk3zcxe6a0zBkOMs8jfkQVePfiWz6lWKEILaPPz+/H5L
 SUarHYhwu+0B78Qc1SWr7Kjb4oOorZLfgXblzq+LQCX15Xhm2ci05h+/l+A0T/Pcc7Ym
 /176BoA3V5BZUClUi1PCaP6vHm33MT0Pwkva/THGcUvQUG3j2cq9rf/9l1zOPEqcDaVa
 86NQ==
X-Gm-Message-State: AGi0PubUw5UAtC3Emf6mkVm8qW+5NzaHiTADQIephHCyhgp7HRokRJh6
 QRSAFyEuWrEY0wgXw9Rbt8nI/ai5+Lg=
X-Google-Smtp-Source: APiQypIOtVLmN26sBLQEPnN3hrhyIv6xvI5WifHGysFUwEmFLrhzINvd3EvqA0ARHr6GkqxEp7LIOw==
X-Received: by 2002:a63:750b:: with SMTP id q11mr15767211pgc.138.1589225431230; 
 Mon, 11 May 2020 12:30:31 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id z185sm8726197pgz.26.2020.05.11.12.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 12:30:30 -0700 (PDT)
Date: Mon, 11 May 2020 12:31:24 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v6] iommu/arm-smmu-qcom: Request direct mapping for modem
 device
Message-ID: <20200511193124.GG20625@builder.lan>
References: <20200511175532.25874-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511175532.25874-1-sibis@codeaurora.org>
Cc: dianders@chromium.org, will@kernel.org, linux-kernel@vger.kernel.org,
 evgreen@chromium.org, swboyd@chromium.org, iommu@lists.linux-foundation.org,
 mka@chromium.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com,
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

On Mon 11 May 10:55 PDT 2020, Sibi Sankar wrote:

> The modem remote processor has two access paths to DDR. One path is
> directly connected to DDR and another path goes through an SMMU. The
> SMMU path is configured to be a direct mapping because it's used by
> various peripherals in the modem subsystem. Typically this direct
> mapping is configured statically at EL2 by QHEE (Qualcomm's Hypervisor
> Execution Environment) before the kernel is entered.
> 
> In certain firmware configuration, especially when the kernel is already
> in full control of the SMMU, defer programming the modem SIDs to the
> kernel. Let's add compatibles here so that we can have the kernel
> program the SIDs for the modem in these cases.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V6
>  * Rebased on Will's for-joerg/arm-smmu/updates
>  * Reword commit message and add more details [Stephen]
> 
>  drivers/iommu/arm-smmu-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 5bedf21587a56..cf01d0215a397 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -17,7 +17,9 @@ static const struct of_device_id qcom_smmu_client_of_match[] = {
>  	{ .compatible = "qcom,mdp4" },
>  	{ .compatible = "qcom,mdss" },
>  	{ .compatible = "qcom,sc7180-mdss" },
> +	{ .compatible = "qcom,sc7180-mss-pil" },
>  	{ .compatible = "qcom,sdm845-mdss" },
> +	{ .compatible = "qcom,sdm845-mss-pil" },
>  	{ }
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
