Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898BBC47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:11:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BDE60C3F
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BDE60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D6664045B;
	Tue,  8 Jun 2021 12:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bz3cXz1v7f9A; Tue,  8 Jun 2021 12:11:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 057C140453;
	Tue,  8 Jun 2021 12:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7F50C000D;
	Tue,  8 Jun 2021 12:11:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B87CAC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92CF683BB6
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NecFrzX69-8d for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:11:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0126683B15
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:11:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 684516128D;
 Tue,  8 Jun 2021 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623154288;
 bh=SIi6eVYI+iqIU91t34ub00u4QndMSBG+LW2EGQ81hKs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UxgN9DPwHE9o0i2wrID540YisZ5d0uf3lyr2Fr0wC45qCgMoujAsW+wpkCLnEw1Z5
 3GM7Bf7y3ajThtYFZcOrkZ9+Lk10eq2bhKE2dvIvOOeag+0I1S7Rml3zhqsBQWGTC9
 7QUVoutuI+Wql0CI5wRoaEbcSLp6/A4Sx+x9ojtF1qrBAGEMmZybapPrtdidCNS9RP
 DGI0hLccbKy2I/27Ky4pii5FhDBgiiP7bLK+17uIEpBkve09Aszr7Z3zLzexJmvs0d
 ByLoz13uDzHqiRwmU60zBiqOOmWuoBb1cFjzAPgvqoN1lZqE25j82kgM6WyxMrNDmO
 RAQq7IDnPbkdg==
Date: Tue, 8 Jun 2021 13:11:22 +0100
From: Will Deacon <will@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
Message-ID: <20210608121122.GF10174@willie-the-truck>
References: <20210518211922.3474368-1-john.stultz@linaro.org>
 <20210518211922.3474368-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210518211922.3474368-2-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-gpio@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Tue, May 18, 2021 at 09:19:22PM +0000, John Stultz wrote:
> Allow the qcom_scm driver to be loadable as a permenent module.
> 
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
> 
> Reviving this now that Saravana's fw_devlink defaults to on,
> which should avoid loading troubles seen before.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-gpio@vger.kernel.org
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3:
> * Fix __arm_smccc_smc build issue reported by
>   kernel test robot <lkp@intel.com>
> v4:
> * Add "depends on QCOM_SCM || !QCOM_SCM" bit to ath10k
>   config that requires it.
> v5:
> * Fix QCOM_QCM typo in Kconfig, it should be QCOM_SCM
> ---
>  drivers/firmware/Kconfig                | 2 +-
>  drivers/firmware/Makefile               | 3 ++-
>  drivers/firmware/qcom_scm.c             | 4 ++++
>  drivers/iommu/Kconfig                   | 2 ++
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  5 files changed, 10 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bcab..38f7b7a8e2843 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -253,6 +253,7 @@ config SPAPR_TCE_IOMMU
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM
> @@ -382,6 +383,7 @@ config QCOM_IOMMU
>  	# Note: iommu drivers cannot (yet?) be built as modules
>  	bool "Qualcomm IOMMU Support"
>  	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on QCOM_SCM=y
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU

For this part:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
