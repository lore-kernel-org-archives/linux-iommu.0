Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD5FC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 07:08:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A8E611C0
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 07:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0A8E611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0F6406FA;
	Tue, 28 Sep 2021 07:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtQ1A35s427w; Tue, 28 Sep 2021 07:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3ACC9404A6;
	Tue, 28 Sep 2021 07:08:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10573C0011;
	Tue, 28 Sep 2021 07:08:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73F26C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 4F6F3404A6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id K1qyPO17NHTq for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 07:08:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 155CA404A2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 07:07:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1632812880; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mcC+NI9lbMYVHDFKxEvKMLG3JdbT8e+is/T3jV6QeT8=;
 b=TfPhU5x5QM+ggvLtWOJwlyHWvSMWlU6gn9O8Oj1fBCPP1zCn8SykTiMn2dh6YQfPafa44sGW
 KUv5WBy7YgZvpq+DdfxKLmC8OHms5cIkt6nHxjIuGfCFOQW1iFUzGMEsEOzKHcssvsOwVu+J
 AbW+0pL7Iz1GNV4TbqpFY4JJi7o=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6152be4b3cc3a01f26b648c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 07:03:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 24A08C43635; Tue, 28 Sep 2021 07:03:38 +0000 (UTC)
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: kvalo)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DA53C4338F;
 Tue, 28 Sep 2021 07:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9DA53C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
References: <20210927152412.2900928-1-arnd@kernel.org>
Date: Tue, 28 Sep 2021 10:03:25 +0300
In-Reply-To: <20210927152412.2900928-1-arnd@kernel.org> (Arnd Bergmann's
 message of "Mon, 27 Sep 2021 17:22:13 +0200")
Message-ID: <87k0j1qj0i.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>, linux-wireless@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 ath10k@lists.infradead.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
 linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
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

Arnd Bergmann <arnd@kernel.org> writes:

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
>>>> referenced by adreno_gpu.c
>>>>               gpu/drm/msm/adreno/adreno_gpu.o:(adreno_zap_shader_load)
>>>> in archive drivers/built-in.a
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

[...]

> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index 741289e385d5..ca007b800f75 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -44,7 +44,7 @@ config ATH10K_SNOC
>  	tristate "Qualcomm ath10k SNOC support"
>  	depends on ATH10K
>  	depends on ARCH_QCOM || COMPILE_TEST
> -	depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
> +	select QCOM_SCM
>  	select QCOM_QMI_HELPERS
>  	help
>  	  This module adds support for integrated WCN3990 chip connected

I assume I can continue to build test ATH10K_SNOC with x86 as before?
That's important for me. If yes, then:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
