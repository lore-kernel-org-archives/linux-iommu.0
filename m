Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714D0C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 04:06:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412F620851
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 04:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2EpDp7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 197FACF3;
	Fri, 14 Jun 2019 04:06:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A5E0FCBE
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 04:06:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 33E18174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 04:06:14 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id c14so434097plo.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=HYi2Erj5A4oaNpZveV/ioy8G/sKMQ9krWJqQ69RYiWk=;
	b=P2EpDp7qWge4+8ecQWnVMZOR6neN2WO+Rlvl8kxFBws0yMA8ei6dEqDewubbLCAHZ5
	vgxHS8aQNp6EOL0mH5yOipqOx1jU8jckeapXz7HXYuqDOmN1ryynO9TAuMiWkak7sYXj
	sMaM6fkTEMMUp0S6WTJsNjI7LyrIADEgcfLbds3hX/1DV9/z38CKTSArow+3sU3NlEjq
	j0ZO63hn76UMSLxp4g1JzmaNa0YDkVoi8Lrqr7TPAAgziXokSLLLmN178mLdzkIA9hfu
	sl+hsLJC8veEGQg23BCh5UBdT3EBjj/jZpUSfrfyNB/4WmvyzfNqGC7vPXpd+byORwDb
	b8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=HYi2Erj5A4oaNpZveV/ioy8G/sKMQ9krWJqQ69RYiWk=;
	b=TaLIRxw4w9nETXKykjF6D8WvXJKCKzWsTmWKnUkA4UTWduQKkzpaWVkY2+Zdcsu0ly
	u5AFmxQQkMvHHEi6TpzDkxZY25uXK7nqfrUP5mC19RPmSZjMh4SN6jiQ8QQPXftfyDP9
	XEVDhy012cUJ55o04bgK73oN8JeKK5f6RsdiIV9eL2zzj3FfaXg3W+vbzsHiS7gEAqeV
	K7ZXQRTxjmpfz4bimdtZeBNYQqcE6ws2a/ZxSWoe6xrnJJo7YVEtm8W0E6JqKZ+wj/OT
	h7r8wB5shnMDljmZIoZi7xDfHW/UNG+LWSluNt7zHwq5JvBDrV9UqVFXVQ4MQkhFe26K
	E1cQ==
X-Gm-Message-State: APjAAAVKd3fXObQl2TXEJmDrkLHWzHne5f7kMuLey1Mw59YmNSbOBi8M
	cvwonP3t9CuPeyGPuIbVYoy34w==
X-Google-Smtp-Source: APXvYqyhaMIs28kbVZNlUk+Wgt9nb24TgswP+lgjinRe2HtMOF/hf2X+O3ATUsRqbG7Qqm/WoQqjoA==
X-Received: by 2002:a17:902:9a49:: with SMTP id
	x9mr71030064plv.282.1560485173702; 
	Thu, 13 Jun 2019 21:06:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	t24sm1115739pfh.113.2019.06.13.21.06.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 13 Jun 2019 21:06:13 -0700 (PDT)
Date: Thu, 13 Jun 2019 21:06:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v3 4/4] arm64: dts/sdm845: Enable FW implemented safe
	sequence handler on MTP
Message-ID: <20190614040659.GL22737@tuxbook-pro>
References: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
	<20190612071554.13573-5-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612071554.13573-5-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	will.deacon@arm.com, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, david.brown@linaro.org,
	iommu@lists.linux-foundation.org, agross@kernel.org, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed 12 Jun 00:15 PDT 2019, Vivek Gautam wrote:

> Indicate on MTP SDM845 that firmware implements handler to
> TLB invalidate erratum SCM call where SAFE sequence is toggled
> to achieve optimum performance on real-time clients, such as
> display and camera.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 78ec373a2b18..6a73d9744a71 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2368,6 +2368,7 @@
>  			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x80000>;
>  			#iommu-cells = <2>;
> +			qcom,smmu-500-fw-impl-safe-errata;
>  			#global-interrupts = <1>;
>  			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
