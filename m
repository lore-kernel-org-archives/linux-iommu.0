Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B2C43217
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 13:54:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A4061206
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 13:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17A4061206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D144960746;
	Tue, 28 Sep 2021 13:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktyiKaW9y5wO; Tue, 28 Sep 2021 13:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9183F6067A;
	Tue, 28 Sep 2021 13:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCA5C000F;
	Tue, 28 Sep 2021 13:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC641C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 13:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B69E4055F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 13:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ieee.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUjgPsDEArOu for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 13:29:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D9F040105
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 13:29:52 +0000 (UTC)
Received: by mail-il1-x130.google.com with SMTP id b12so11523303ilf.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ieee.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KV5AEITggXzrcUqW0Pn0JDUCXvtzQQd7nfX6VcyNvh0=;
 b=gsEil9aJ5ZOw0ASchzCW/AY/NlZwbg7FdvHHAbffANcuyVgNVj8F3r/I3y/OyqwIbk
 QkY/gO8vfPAMQp75rG6vgEG7NkfLO4ZNSWbXrGEOjX3dKqow4MOof9p7GrAO13Ckl/VP
 f8/C6WiPIW+rxE9R7UiZnONtD/dro2yaem2kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KV5AEITggXzrcUqW0Pn0JDUCXvtzQQd7nfX6VcyNvh0=;
 b=HlPWzWQYGXMJUvqeOTEla2Q1vmILkSFHie4+LAwsItP/MsLtjRkOiqvcXKEX6aqf4C
 JnP/0xRzVAmPYdWVk/0Y61h1PNEux3330Nb8ZQ15J/OSwb8YE+vrciYe/Xrfg4dKcJ3o
 yoFBatrCYdP5G9zEncqinfij0o4N+3k0PvlHx/x6XTZR8MO+ouhdKReiVuVcuYOA5/Dt
 2ph22oetlctYwYV69CIdZegf9rJsiTS4HZX7TRwolJUgFdeI2kg5/leuprDYA/IN9oqM
 HeF1g4ozJ5MnCMNckG8hz2C2C5KNIyOpBpWlBZjj8Cr6zm6Ed/LZAxvJuKVWJ6aStKOt
 q9ug==
X-Gm-Message-State: AOAM532NQCI4nn/l3G7I+kN+OC3CVADGqOGaYUzPwa5e+sD6mSP6W/Jw
 U76kXA/Ag3w4LmvEn6wvKmMfrg==
X-Google-Smtp-Source: ABdhPJz3qmL3tZ3U3XkVDcDl9dtP+yn06EspPEdsou0GIPYBieCdKEZlaSYFieS9Yrw1uFrX87cOuw==
X-Received: by 2002:a92:c744:: with SMTP id y4mr4108077ilp.288.1632835791399; 
 Tue, 28 Sep 2021 06:29:51 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net.
 [73.185.129.58])
 by smtp.googlemail.com with ESMTPSA id m13sm11831997ilh.45.2021.09.28.06.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 06:29:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] [v2] qcom_scm: hide Kconfig symbol
To: Arnd Bergmann <arnd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20210928075216.4193128-1-arnd@kernel.org>
 <20210928075216.4193128-2-arnd@kernel.org>
Message-ID: <19bbc40d-3f13-7e9d-72c0-5d206b016bb7@ieee.org>
Date: Tue, 28 Sep 2021 08:29:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928075216.4193128-2-arnd@kernel.org>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 28 Sep 2021 13:53:59 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, linux-wireless@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Alex Elder <elder@kernel.org>,
 linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 netdev@vger.kernel.org, ath10k@lists.infradead.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Kalle Valo <kvalo@codeaurora.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-mips@vger.kernel.org,
 linux-media@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-msm@vger.kernel.org, Simon Trimmer <simont@opensource.cirrus.com>,
 linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Andy Gross <agross@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 freedreno@lists.freedesktop.org
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
From: Alex Elder via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alex Elder <elder@ieee.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 9/28/21 2:50 AM, Arnd Bergmann wrote:
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
>>>>                gpu/drm/msm/adreno/adreno_gpu.o:(adreno_zap_shader_load) in archive drivers/built-in.a
> 
> This can happen when CONFIG_ARCH_QCOM is disabled and we don't select
> QCOM_MDT_LOADER, but some other module selects QCOM_SCM. Ideally we'd
> use a similar dependency here to what we have for QCOM_RPROC_COMMON,
> but that causes dependency loops from other things selecting QCOM_SCM.
> 
> This appears to be an endless problem, so try something different this
> time:
> 
>   - CONFIG_QCOM_SCM becomes a hidden symbol that nothing 'depends on'
>     but that is simply selected by all of its users
> 
>   - All the stubs in include/linux/qcom_scm.h can go away
> 
>   - arm-smccc.h needs to provide a stub for __arm_smccc_smc() to
>     allow compile-testing QCOM_SCM on all architectures.
> 
>   - To avoid a circular dependency chain involving RESET_CONTROLLER
>     and PINCTRL_SUNXI, drop the 'select RESET_CONTROLLER' statement.
>     According to my testing this still builds fine, and the QCOM
>     platform selects this symbol already.
> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes in v2:
>    - drop the 'select RESET_CONTROLLER' line, rather than adding
>      more of the same
> ---
>   drivers/firmware/Kconfig                |  5 +-
>   drivers/gpu/drm/msm/Kconfig             |  4 +-
>   drivers/iommu/Kconfig                   |  2 +-
>   drivers/media/platform/Kconfig          |  2 +-
>   drivers/mmc/host/Kconfig                |  2 +-
>   drivers/net/ipa/Kconfig                 |  1 +

For drivers/net/ipa/Kconfig, looks good to me.
Nice simplification.

Acked-by: Alex Elder <elder@linaro.org>

>   drivers/net/wireless/ath/ath10k/Kconfig |  2 +-
>   drivers/pinctrl/qcom/Kconfig            |  3 +-
>   include/linux/arm-smccc.h               | 10 ++++
>   include/linux/qcom_scm.h                | 71 -------------------------
>   10 files changed, 20 insertions(+), 82 deletions(-)
> 

. . .
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
