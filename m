Return-Path: <SRS0=kiHz=X6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F95C47404
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 04:56:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E1A222BE
	for <iommu@archiver.kernel.org>; Sat,  5 Oct 2019 04:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Es6/WFDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1A222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5FDA5A7F;
	Sat,  5 Oct 2019 04:56:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9C233EE
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 04:56:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FF07D3
	for <iommu@lists.linux-foundation.org>;
	Sat,  5 Oct 2019 04:56:30 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id y72so5091033pfb.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 04 Oct 2019 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=nxVm0xunWOBBVAAFXWndvWPXDw/0SmFto2e0wGq2Utk=;
	b=Es6/WFDpSDi+uUS3ssFw8k2X6y9T2lLmlB3BJ5yMVSfrXVNwu6fCRLjOurcjJCLeZp
	j/2vkFLP2Y3MIWe5OrvrkX/VPjYh8WDB7WXUIcrXPBdZZTXSFYC6WoAVc0aPWJJ9nT9H
	UIONclhMdlXmiX124VebxUKGUcIfV4qN5jNdIdMphwOcKN/ILU6JpHKTZpYzX6z8Sc3F
	vWwIUxav/2EUYWAqwVoGXDr2hjAvsA5MbBYvnU8hJ6ckl3XTOi9+tFbxcjdjuoILN3gI
	FqLdpbLD4MhCjdUJXPrRhTSIGfieyHZjR/SlWHn/cxAw/Iq13I1b6emvNTVDnLQDfQ2b
	UM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=nxVm0xunWOBBVAAFXWndvWPXDw/0SmFto2e0wGq2Utk=;
	b=nrLCMRU5bXg5pqhutPi/s36kZbo2ENgGWPNrGtLLqldQIm7ES/Sm7OvAwg7vz/DQBs
	UXnWAZGm31a/Zy3/GbeE3dj9ZLQjSmhz8VQFtMJ2lLbZBZXlWqhxLoEEJ/svE8Pzvxon
	W8VFdbPewVCKTZRXcSNBzztrLvHnFkmJB91zqrWZh/NgqZaXYfAEvvrKax1P8L3lr3PK
	LEbZASBax2SMx8mtsb+Mqe1qvs09UZMmEFoHptC4+mKv7NK8WqAu4/Emmnt0LNYh8D1a
	cLLFp31DgnAf5FZMsKz409mM4tULzV8koAfNOn9SQXWaq27164pb5+/JN/AS3kr1GHFY
	ZErg==
X-Gm-Message-State: APjAAAUcRuWdOlPugerbmR1XgB+53qYAJm6wWX0f8QDfUzK95bpQlqxC
	yAgdo/FRxX3tEDCovJNhGVXNfQ==
X-Google-Smtp-Source: APXvYqxUDnIpVTFnF1XELHDDilE2OljkXH45wCip/vedAt6UgJnmqiscN0yJy1vKGz9lAlTEWEusow==
X-Received: by 2002:a17:90a:cc08:: with SMTP id
	b8mr20841755pju.119.1570251389539; 
	Fri, 04 Oct 2019 21:56:29 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
	[104.188.17.28])
	by smtp.gmail.com with ESMTPSA id b3sm6041371pjp.13.2019.10.04.21.56.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 04 Oct 2019 21:56:28 -0700 (PDT)
Date: Fri, 4 Oct 2019 21:56:26 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: kholk11@gmail.com
Subject: Re: [PATCH v4 0/7] Add support for QCOM IOMMU v2 and 500
Message-ID: <20191005045626.GE6390@tuxbook-pro>
References: <20191001220205.6423-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001220205.6423-1-kholk11@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: marijns95@gmail.com, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux-foundation.org, agross@kernel.org
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

On Tue 01 Oct 15:01 PDT 2019, kholk11@gmail.com wrote:

> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Some Qualcomm Family-B SoCs have got a different version of the QCOM
> IOMMU, specifically v2 and 500, which perfectly adhere to the current
> qcom_iommu driver, but need some variations due to slightly different
> hypervisor behavior.
> 

Do you think it's out of the question to get the arm-smmu driver to play
nice with this platform?


If not, would it be possible to change the DT binding so that we specify
the SID and then read the SMR and S2CR registers to figure out the
associated context bank?

Regards,
Bjorn

> The personal aim is to upstream MSM8956 as much as possible.
> 
> This code has been tested on two Sony phones featuring the Qualcomm
> MSM8956 SoC.
> 
> Changes in v2:
> - Fixed optional properties placement in documentation
> 
> Changes in v3:
> - Rebased onto linux-next 01/10/2019
> - Added missing SCM commit (required by the AArch64 PT switch support)
> 
> Changes in v4:
> - Removed rej files from the SCM patch (I'm truly sorry for the noise...)
> 
> Angelo G. Del Regno (1):
>   firmware: qcom: scm: Add function to set IOMMU pagetable addressing
> 
> AngeloGioacchino Del Regno (6):
>   iommu/qcom: Use the asid read from device-tree if specified
>   iommu/qcom: Write TCR before TTBRs to fix ASID access behavior
>   iommu/qcom: Properly reset the IOMMU context
>   iommu/qcom: Add support for AArch64 IOMMU pagetables
>   iommu/qcom: Index contexts by asid number to allow asid 0
>   iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500 secured contexts
> 
>  .../devicetree/bindings/iommu/qcom,iommu.txt  |   5 +
>  drivers/firmware/qcom_scm-32.c                |   6 +
>  drivers/firmware/qcom_scm-64.c                |  15 ++
>  drivers/firmware/qcom_scm.c                   |   7 +
>  drivers/firmware/qcom_scm.h                   |   4 +
>  drivers/iommu/qcom_iommu.c                    | 134 ++++++++++++++----
>  include/linux/qcom_scm.h                      |   2 +
>  7 files changed, 145 insertions(+), 28 deletions(-)
> 
> -- 
> 2.21.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
