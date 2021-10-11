Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B6C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 04:07:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A9D603E5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 04:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72A9D603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kali.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B01B40124;
	Mon, 11 Oct 2021 04:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xe8_6P3GNvzb; Mon, 11 Oct 2021 04:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4B7440129;
	Mon, 11 Oct 2021 04:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3EBC000F;
	Mon, 11 Oct 2021 04:07:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFCFC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 60F8B81D2D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kali.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bCHPkn6qkScR for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 04:07:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F017881D24
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 04:07:01 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id z11so22969810oih.1
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 21:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kali.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=x6zJ1TMB99Xj1FgTf/EaXYFiMV4l4PhopS0sskGKUJg=;
 b=MMWmNas2Kk06bSpFDsluQBhy85L5MC4CSaXQzLEp1VM6YfCxptom3EfbZ9CNodgEHn
 XYrtNOSNSOtPQLbFOnP/MC5RUYm2+SaZbjkFaJB9RfsA0itlYKmCOz0E4iHn9+hxBZqt
 M30hT9DrRYaeKfFnX9Z8cOnrK0nIaVPla5p7coiLuri1CBQ4Xy1ngm11PzoMRqCQQ6oz
 QQpKxfsNulQhqPNOqzGv/zyyqeBjZP8Ld0L5zp83z8k3kMRBq76ZGJiH7sie2TcTRBzU
 QC61z0hPyd/c95TXvqf82Fl8DZ2/VlTRIbvaW2h9aUDX+2zAbKOx3dVMV5z9zKCJrBot
 yI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=x6zJ1TMB99Xj1FgTf/EaXYFiMV4l4PhopS0sskGKUJg=;
 b=V7WvNJAfTGLz0MC3BViYnDKdtTBhJGwudG7AEIapUxj6imKJzCY0VsstxsXJH6rfxI
 KDTjZNXPj9U/2ggfwuVM6cCHaCDW+lFDClYAiVWOHM1CmkDz6z91esDvtFs4NEoOssy6
 hDbMEv4RSZ8qGR1/9ofNWUKZDhZqwfyb7GJYgDdaz6C7KsWVRSn2xC36HhjTZwTgyrDV
 PkecfM+DWl1+B4NRQ5m2C69mkka0tUCUTK3JG6wMId620H4MYlU6vrsIxtMv+9X+l5/D
 qd+wOdK0wR6chzSSugHHblFJU7OH8CYKiIUfXz8qMSCzcPvUrG8WI5iwqjMbalDxu0e+
 /VfA==
X-Gm-Message-State: AOAM5313l0i6G8Dzn6CicqExBEIB3U764/n/YpX+pmIq+vRvw5muBkQq
 jfCK4NozRzlHBVzurKugYziHUg==
X-Google-Smtp-Source: ABdhPJyNBhey2POmoHGytDsM+sjqpo3nS+HnjONu7HSk/QnQNoIRcds2yh6VSQNMRwLWpByqHsAFIw==
X-Received: by 2002:aca:5b44:: with SMTP id p65mr15644888oib.158.1633925221021; 
 Sun, 10 Oct 2021 21:07:01 -0700 (PDT)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com.
 [173.173.107.246])
 by smtp.gmail.com with ESMTPSA id bi1sm1506166oib.34.2021.10.10.21.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Oct 2021 21:07:00 -0700 (PDT)
Message-ID: <e655dd45-7d08-b82b-75b7-a9aa3bd4c50e@kali.org>
Date: Sun, 10 Oct 2021 23:06:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
 <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
From: Steev Klimaszewski <steev@kali.org>
In-Reply-To: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
Cc: Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Kalle Valo <kvalo@codeaurora.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


On 10/10/21 12:42 PM, Arnd Bergmann wrote:
> On Sun, Oct 10, 2021 at 6:17 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>> On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:
>>
>>> After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
>>> qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
>>> However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
>>> qcom_smmu_impl_init() is never called.
>>>
>>> So, let's fix this by always calling qcom_smmu_impl_init(). It does not
>>> touch the smmu passed unless the device is a non-Qualcomm one. Make
>>> ARM_SMMU select QCOM_SCM for ARCH_QCOM.
> Sorry about this bug. I was sure I had it working, but I lost part of the commit
> during a rebase, and my randconfig builds still succeeded without it, so I
> sent a wrong version.
>
>> Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
>> devices. But as Daniel experienced, attempting to boot most Qualcomm
>> boards without this results in a instant reboot.
>>
>> I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
>> we're getting late in v5.15 so I would prefer if we make sure this works
>> out of the box.
> Yes, makes sense. For reference, see below for how I would fix this properly,
> this is what I had intended to have in the patch. Feel free to pick
> either version
> as the immediate bugfix. I'll give the below a little more randconfig testing
> overnight though. The pasted version of the patch is probably
> whitespace-damaged,
> let me know if you would like me to send it as a proper patch.
>
>         Arnd
>
> 8<-----
> Subject: iommu: fix ARM_SMMU_QCOM compilation
>
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
>
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..2dfe744ddd97 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -311,6 +311,7 @@ config ARM_SMMU
>          select IOMMU_API
>          select IOMMU_IO_PGTABLE_LPAE
>          select ARM_DMA_USE_IOMMU if ARM
> +       select QCOM_SCM if ARM_SMMU_QCOM
>          help
>            Support for implementations of the ARM System MMU architecture
>            versions 1 and 2.
> @@ -355,6 +356,13 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>            'arm-smmu.disable_bypass' will continue to override this
>            config.
>
> +config ARM_SMMU_QCOM
> +       def_bool y
> +       depends on ARM_SMMU && ARCH_QCOM
> +       help
> +         When running on a Qualcomm platform that has the custom variant
> +         of the ARM SMMU, this needs to be built into the SMMU driver.
> +
>   config ARM_SMMU_V3
>          tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>          depends on ARM64

FWIW, I tested this patch on the Lenovo Yoga C630 with Dmitry's patch 
backed out, and this does the right thing as well.

So if we go this route instead of the other patch, Tested-By: Steev 
Klimaszewski <steev@kali.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
