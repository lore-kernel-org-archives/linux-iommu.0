Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC7C4CEC5
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F172084F
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HXxFGlzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F172084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 467DD1017;
	Fri, 13 Sep 2019 14:35:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B7431011
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:35:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 825D089B
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:35:21 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id i78so28308288qke.11
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9Z6EfKc/tiAqCe5nrG0CEyU7I6TZY+4MO6IYTk9GKp4=;
	b=HXxFGlzHNUOzcVXhTjcVeZmsY2axuZDsxqSpeSdttKnUjeABS7vFI9wGZqOFaDjiFy
	rjtdYtiDL+6Um4ZCqTtpgMSJ4ZlzzX9/lEtFFr2nMNVwUbpKTTyz9rk2OMPEFWVeZHMY
	2l4z+kT583DhzTXTow3J1EUhDrWBRfKLG4tQSJ38xy2n1lUEe8+LItcUZVur7IKH/J8m
	1CjuFwK+mZhj/eKSvyJl7EmoNpU6xaAZUxykHNyleehJ0XF8W5NKkiCbloVGmSa/D3s6
	VQ3bJ8piHxWlkM5Y/czZiuGiEitm7NBMSrCyNXjAdPwpM409Rdq+yAWEsZ7xLHz4VMMT
	0/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9Z6EfKc/tiAqCe5nrG0CEyU7I6TZY+4MO6IYTk9GKp4=;
	b=k/r13GGlSNBpIOAPXI1tIjPK4eD7UNE6vIKPheG4K5z8FXR9aJWg3Sd+fm8K5TOi7z
	iV5VubruZgpmQNKWeA4UyyNp0E1+nuJCoUKgh32n7FCIOr3O8eF2Ovo7oEw8tfg87LR8
	1xG6v55aCi2gDteTn1yuImC9MEc4OWALPddC93Q50VYG47oVTpFY/koRpcgJGWFO6mVf
	QQwPolZeQzYW5JrgrUv3feww+OD0aoMwP8dUQrhaD/14Bz2OjTVnr0+0Da5sWxpAg5s5
	33Sr1pkKVYGy351rMFmOYqKidSHDRnJGm+rwrMhhrtUMvSR9Mj18yBY0Cy5AS65YA7r+
	1p0g==
X-Gm-Message-State: APjAAAWD4+38/av2BjycNfOEEcSiorEylRHuXhlkXW5TlfgQMQvqwCSb
	fLt0Dmsng+dAxBRVoPC5WCQpZA==
X-Google-Smtp-Source: APXvYqzFSI15WScpD6Ky3Htl5LWDtXBTh2C4ek5k+asPOfoOylHjTbFZaJGuOFuZAgXEhDc5477Zdg==
X-Received: by 2002:a05:620a:49b:: with SMTP id
	27mr33288710qkr.89.1568385320693; 
	Fri, 13 Sep 2019 07:35:20 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	v2sm10601115qtv.22.2019.09.13.07.35.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 13 Sep 2019 07:35:20 -0700 (PDT)
Message-ID: <1568385318.5576.146.camel@lca.pw>
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
From: Qian Cai <cai@lca.pw>
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
Date: Fri, 13 Sep 2019 10:35:18 -0400
In-Reply-To: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org
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

On Fri, 2019-09-13 at 12:48 +0100, Robin Murphy wrote:
> Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> for smoking out inadequate firmware, the failure mode is non-obvious
> and can be confusing for end users. Add some special-case reporting of
> Unidentified Stream Faults to help clarify this particular symptom.
> 
> CC: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 5 +++++
>  drivers/iommu/arm-smmu.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b7cf24402a94..76ac8c180695 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  	dev_err_ratelimited(smmu->dev,
>  		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
>  		gfsr, gfsynr0, gfsynr1, gfsynr2);
> +	if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> +	    (gfsr & sGFSR_USF))
> +		dev_err_ratelimited(smmu->dev,
> +			"Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
> +			(u16)gfsynr1);

dev_err_once(), i.e., don't need to remind people to set "arm-
smmu.disable_bypass=0" multiple times.

>  
>  	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sGFSR, gfsr);
>  	return IRQ_HANDLED;
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index c9c13b5785f2..46f7e161e83e 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -79,6 +79,8 @@
>  #define ID7_MINOR			GENMASK(3, 0)
>  
>  #define ARM_SMMU_GR0_sGFSR		0x48
> +#define sGFSR_USF			BIT(2)
> +
>  #define ARM_SMMU_GR0_sGFSYNR0		0x50
>  #define ARM_SMMU_GR0_sGFSYNR1		0x54
>  #define ARM_SMMU_GR0_sGFSYNR2		0x58
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
