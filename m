Return-Path: <SRS0=myD+=SV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A023C282DD
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 00:25:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B809214DA
	for <iommu@archiver.kernel.org>; Fri, 19 Apr 2019 00:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxRW4+KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B809214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E3382141;
	Fri, 19 Apr 2019 00:25:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8ADF61D9F
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 00:25:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0F9DA108
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Apr 2019 00:25:01 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 9so1811426pfj.13
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=aBpZyaS+ZmDCtg5dDjJTAz16MJIF3r/OZvt6uyCX5no=;
	b=hxRW4+KXFLn/f3c5kN3LpTmaastUMsuL8zLEvsIiRwd2vDGrrZIaAkVkjXRVAhK+vR
	FjQUelPoyHwoMpGKx12GOz3Yb8uUHf2p8zDlteqKzwzGE1JR56m6NXbzVwFHI3h4cK2Q
	SAAebPG0TElmFxsYTBobrbnan/XCdb0/XE95wSsRzjiutTpRCpfrq2y34zURyiys4q/Q
	YUjHoye9wBjNN5QzUexD9bZK/55tSeFX0Sn1Di/bEE1YIpfBRUghA8i9XnS870h6y2Ud
	aOQeGf4ATN3AP9athzkogumnkpaOz9nk3VfZxXemu8GH3VOWK15kvUqdt+WhzOyK6un/
	Xs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=aBpZyaS+ZmDCtg5dDjJTAz16MJIF3r/OZvt6uyCX5no=;
	b=sxovSiqKNkC6cRXOvhbkKgYJaLjQRM2uJIbkT/NN4025nAup24pNdU4mZgyfA+RcOW
	oh29mat2qc6d49dtMv3vcgHvIfjma8Ypw8rgZNG8ODTl/yXh1bS/HM35xpbdu14o2xxV
	qofNY5VxlYqYryCmgnZQklqxpfq8kBNPndn345+grJI53fxpHduwrJh2nXWDVNVyJUrQ
	Boslxudzdw0Qx61UTEotLL05OWCOrYm7JaxKqnKWEhXgJaIOub0wKyXiPi3DxRKC5NhL
	e4MJKCQKV6dZfFA3+OPGPVmkcHQlHB2Hb8nYPXkCVfW6o2EP4cZzU7bD8GRTUAPd7Y04
	Lt/A==
X-Gm-Message-State: APjAAAXnRHs43/obHqnTyW2YwDhy+2wEWIVHLq3DXukghkbXaVSvjsD6
	A0RY1PAYK/AslT3LeYXZVPxclw==
X-Google-Smtp-Source: APXvYqxHtM1ZtkLyXCCakQ1g/LH3mkpXMOlDZpFODTjlKy94Bqy7XYBlwE6UXVcSYMn1qNpIg1TEfA==
X-Received: by 2002:a63:c34c:: with SMTP id e12mr878940pgd.279.1555633500911; 
	Thu, 18 Apr 2019 17:25:00 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28]) by smtp.gmail.com with ESMTPSA id
	n65sm11068363pfb.160.2019.04.18.17.24.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 18 Apr 2019 17:24:59 -0700 (PDT)
Date: Thu, 18 Apr 2019 17:24:57 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context
	fault
Message-ID: <20190419002457.GA3137@builder>
References: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
	<20190415173758.22112-1-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190415173758.22112-1-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190419002457.XHZDOaqgSx61NXTMA_bg8Ml0Utkiv37Qwjvaoy8Mrtw@z>

On Mon 15 Apr 10:37 PDT 2019, Vivek Gautam wrote:

> Bits[15:0] in CBFRSYNRA register contain information about
> StreamID of the incoming transaction that generated the
> fault. Dump CBFRSYNRA register to get this info.
> This is specially useful in a distributed SMMU architecture
> where multiple masters are connected to the SMMU.
> SID information helps to quickly identify the faulting
> master device.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> V1 of the patch available @
> https://lore.kernel.org/patchwork/patch/1061615/
> 
> Changes from v1:
>  - Dump the raw register value of CBFRSYNRA register in the
>    context fault log rather than extracting the SID inforamtion
>    and dumping that.
> 
>  drivers/iommu/arm-smmu-regs.h | 2 ++
>  drivers/iommu/arm-smmu.c      | 8 ++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index a1226e4ab5f8..e9132a926761 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
>  #define CBAR_IRPTNDX_SHIFT		24
>  #define CBAR_IRPTNDX_MASK		0xff
>  
> +#define ARM_SMMU_GR1_CBFRSYNRA(n)	(0x400 + ((n) << 2))
> +
>  #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>  #define CBA2R_RW64_32BIT		(0 << 0)
>  #define CBA2R_RW64_64BIT		(1 << 0)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 045d93884164..a4773e8c6b0e 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
>  	void __iomem *cb_base;
> +	u32 cbfrsynra;
>  
>  	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
>  	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> @@ -585,10 +587,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  
>  	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
>  	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> +	cbfrsynra = readl_relaxed(gr1_base +
> +				  ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));

The 80 char limit is more like a guideline anyways...please don't wrap
this.

>  
>  	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cfg->cbndx);
> +	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra = 0x%x, cb=%d\n",

Drop the spaces around '='.

With those addressed, you have my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +			    fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
>  
>  	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
>  	return IRQ_HANDLED;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
