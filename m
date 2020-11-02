Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD59C00A89
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 07:43:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B62521556
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 07:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CUzYOshK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B62521556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9BDE4204AE;
	Mon,  2 Nov 2020 07:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ichJplK18H9F; Mon,  2 Nov 2020 07:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 22DDF20496;
	Mon,  2 Nov 2020 07:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A674C0889;
	Mon,  2 Nov 2020 07:43:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EDB9C0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D7C786AA1
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOhcsFmenrbB for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 07:43:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5CA5186A90
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 07:43:15 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604302999; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JcW6i+Qb4VgBJvdLIWaHbAHYP0+oYiGUqaNaSh4Fg0Q=;
 b=CUzYOshKqBKKt2ljR0b88phqcZiCynIHfLOxQb0hRyQE4cEVkYMqxjTTUGVrUo6elCRQMV6N
 7PwztDeWvD+t5hb8Xo74cd8xrZlEgXV22f6WtkmZ7hs1i1U6rS/1I7eLFGbtyCtKYd+4abuv
 KCaJVRhTvqFP7s1qKGNu7GwBMRM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f9fb8884ddd946c9162dd31 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 07:43:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2AC46C433CB; Mon,  2 Nov 2020 07:43:04 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi
 [88.114.240.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: kvalo)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 194D5C433C6;
 Mon,  2 Nov 2020 07:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 194D5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v5 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
References: <20201031003845.41137-1-john.stultz@linaro.org>
 <20201031003845.41137-2-john.stultz@linaro.org>
Date: Mon, 02 Nov 2020 09:42:55 +0200
In-Reply-To: <20201031003845.41137-2-john.stultz@linaro.org> (John Stultz's
 message of "Sat, 31 Oct 2020 00:38:45 +0000")
Message-ID: <87imaouruo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 ath10k@lists.infradead.org, linux-gpio@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm@vger.kernel.org, Todd Kjos <tkjos@google.com>
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

+ ath10k list

John Stultz <john.stultz@linaro.org> writes:

> Allow the qcom_scm driver to be loadable as a permenent module.
>
> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
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
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
>  drivers/firmware/Kconfig                | 4 ++--
>  drivers/firmware/Makefile               | 3 ++-
>  drivers/firmware/qcom_scm.c             | 4 ++++
>  drivers/iommu/Kconfig                   | 2 ++
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  5 files changed, 11 insertions(+), 3 deletions(-)

For ath10k part:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
