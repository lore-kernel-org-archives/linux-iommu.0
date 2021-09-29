Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8641C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:51:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724AA613D0
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 09:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 724AA613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A250404FA;
	Wed, 29 Sep 2021 09:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6GcTE6TMES1w; Wed, 29 Sep 2021 09:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A507C40012;
	Wed, 29 Sep 2021 09:51:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79FA6C0011;
	Wed, 29 Sep 2021 09:51:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C200C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 117BD828E3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WXF5yHhQbgpY for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 09:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 858D282FE4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 09:51:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08BC613A5;
 Wed, 29 Sep 2021 09:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632909075;
 bh=TQQ+cjIN9++CtK9DgtuA6I+X1WnMjFRfMLxBOvN/9hI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RDOtNOVfqPdKvpSr/OsPhNB0fjENTcC6due2YIfIDrAMsow0opiYt1QHJew4ql2n1
 fZH4NruBoG9wJO8wbT0XZJbvOC+xUiY29xWFOTMILMu96eFiy5sv/dZZ7M1arg9kJs
 7GltsB1HljAlqeovMRCxLsp8lK6AS/SlkTAt5UjPTSLE3nvQDh8DTRk4hRPx/qY3Wu
 Ljm7ukEFU/n7DLFsJw3WsBW0ZdKkSNdy4ty2WkKje0ftyfAwYt0JLv6bCNAmbKzOtE
 71e19ToUqhiQJknv1dNPYIjXnX1N8db1jYZmFGrSBIsCKGj8DAhwjqiVCn57wl0taE
 eBXytOfpUPuAw==
Date: Wed, 29 Sep 2021 10:51:07 +0100
From: Will Deacon <will@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
Message-ID: <20210929095107.GA21057@willie-the-truck>
References: <20210927152412.2900928-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927152412.2900928-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>, linux-wireless@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 ath10k@lists.infradead.org, iommu@lists.linux-foundation.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sean Paul <sean@poorly.run>, Kalle Valo <kvalo@codeaurora.org>,
 Alex Elder <elder@kernel.org>, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 freedreno@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>
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

On Mon, Sep 27, 2021 at 05:22:13PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that SCM can be a loadable module, we have to add another
> dependency to avoid link failures when ipa or adreno-gpu are
> built-in:
> 
> aarch64-linux-ld: drivers/net/ipa/ipa_main.o: in function `ipa_probe':
> ipa_main.c:(.text+0xfc4): undefined reference to `qcom_scm_is_available'
> 
> ld.lld: error: undefined symbol: qcom_scm_is_available
> >>> referenced by adreno_gpu.c
> >>>               gpu/drm/msm/adreno/adreno_gpu.o:(adreno_zap_shader_load) in archive drivers/built-in.a
> 
> This can happen when CONFIG_ARCH_QCOM is disabled and we don't select
> QCOM_MDT_LOADER, but some other module selects QCOM_SCM. Ideally we'd
> use a similar dependency here to what we have for QCOM_RPROC_COMMON,
> but that causes dependency loops from other things selecting QCOM_SCM.
> 
> This appears to be an endless problem, so try something different this
> time:
> 
>  - CONFIG_QCOM_SCM becomes a hidden symbol that nothing 'depends on'
>    but that is simply selected by all of its users
> 
>  - All the stubs in include/linux/qcom_scm.h can go away
> 
>  - arm-smccc.h needs to provide a stub for __arm_smccc_smc() to
>    allow compile-testing QCOM_SCM on all architectures.
> 
>  - To avoid a circular dependency chain involving RESET_CONTROLLER
>    and PINCTRL_SUNXI, change the 'depends on RESET_CONTROLLER' in
>    the latter one to 'select'.
> 
> The last bit is rather annoying, as drivers should generally never
> 'select' another subsystem, and about half the users of the reset
> controller interface do this anyway.
> 
> Nevertheless, this version seems to pass all my randconfig tests
> and is more robust than any of the prior versions.
> 
> Comments?
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/Kconfig                |  4 +-
>  drivers/gpu/drm/msm/Kconfig             |  4 +-
>  drivers/iommu/Kconfig                   |  2 +-
>  drivers/media/platform/Kconfig          |  2 +-
>  drivers/mmc/host/Kconfig                |  2 +-
>  drivers/net/ipa/Kconfig                 |  1 +
>  drivers/net/wireless/ath/ath10k/Kconfig |  2 +-
>  drivers/pinctrl/qcom/Kconfig            |  3 +-
>  drivers/pinctrl/sunxi/Kconfig           |  6 +--
>  include/linux/arm-smccc.h               | 10 ++++
>  include/linux/qcom_scm.h                | 71 -------------------------
>  11 files changed, 23 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 220a58cf0a44..f7dd82ef0b9c 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -203,9 +203,7 @@ config INTEL_STRATIX10_RSU
>  	  Say Y here if you want Intel RSU support.
>  
>  config QCOM_SCM
> -	tristate "Qcom SCM driver"
> -	depends on ARM || ARM64
> -	depends on HAVE_ARM_SMCCC
> +	tristate
>  	select RESET_CONTROLLER
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index e9c6af78b1d7..3ddf739a6f9b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -17,7 +17,7 @@ config DRM_MSM
>  	select DRM_SCHED
>  	select SHMEM
>  	select TMPFS
> -	select QCOM_SCM if ARCH_QCOM
> +	select QCOM_SCM
>  	select WANT_DEV_COREDUMP
>  	select SND_SOC_HDMI_CODEC if SND_SOC
>  	select SYNC_FILE
> @@ -55,7 +55,7 @@ config DRM_MSM_GPU_SUDO
>  
>  config DRM_MSM_HDMI_HDCP
>  	bool "Enable HDMI HDCP support in MSM DRM driver"
> -	depends on DRM_MSM && QCOM_SCM
> +	depends on DRM_MSM
>  	default y
>  	help
>  	  Choose this option to enable HDCP state machine
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 124c41adeca1..989c83acbfee 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -308,7 +308,7 @@ config APPLE_DART
>  config ARM_SMMU
>  	tristate "ARM Ltd. System MMU (SMMU) Support"
>  	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
> -	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> +	select QCOM_SCM
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU if ARM

I don't want to get in the way of this patch because I'm also tired of the
randconfig failures caused by QCOM_SCM. However, ARM_SMMU is applicable to
a wide variety of (non-qcom) SoCs and so it seems a shame to require the
QCOM_SCM code to be included for all of those when it's not strictly needed
at all.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
