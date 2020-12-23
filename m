Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25700C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 16:38:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4F020897
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 16:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4F020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3518887371;
	Wed, 23 Dec 2020 16:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRRT1ITucp-i; Wed, 23 Dec 2020 16:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA1DA87369;
	Wed, 23 Dec 2020 16:38:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75D5AC1787;
	Wed, 23 Dec 2020 16:38:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0411EC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F404D85B80
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5lG8X_zTYJP for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 15:38:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0714B85B73
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:38:23 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id q75so6504533wme.2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=FLK03MoPTeVjiiFwNtS1OJi+2ld8fgev60+sqAPXpLo=;
 b=aC3XOqzY6SoQTeia6KLuOxot8sYnDpr+WcX5Gf8TnqSRzAGywSgSslZ3koDvjM6ib3
 Pdi8mTDstbmvSu74oQEOtEGOcaGapMdnt2guYjiyiuNyI9a0TublPIgvHTytVaRBjlZT
 P6j/dMWOfY+mTZFcmLTsQreejEnkaqN7T3glvlvOKrKRJBytjK48P5nyy1ekeQIxEJAB
 gda50nuPKtQTzYWtUjJf88582ql+s/mzHL29B5zze3o1y6CijcBcwgJuKKQ8+HjIiYYF
 PGpvC72eJLuyXVCZV+q1RrmtxpKoco3/pXOVOVNIk2k/ntzBIAeEEqbwtGUoGa90XnNF
 ZrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FLK03MoPTeVjiiFwNtS1OJi+2ld8fgev60+sqAPXpLo=;
 b=XtZ+/TdXsdlgmD9DCsklC0wI/U0XZ0Ywdj3x3489X8++yAq2SSwQGl984shK652Ti5
 tFGmr6yJMfWt+Sye5E+q7BMzZQerUxDOvRRGBOCc/AV2X+4PBWm+8pOyOSzCSoYQNlTU
 tpx6fQ6QCPysvxPPEXwN1YE9977lKcdWT9pA6Am5iAX/Ft+sN4C5x21X/tiVp8Hb90zY
 dYQ6Rj+nRyXA85is+HOU3pDjPiiQL3t9aMhTbm3g06BdlfQAz7959QvxO8wwNkVeBDwF
 XNXbUsA3I0VQWdc4IYKf0xRyFZSk9qbUmetROZNLHf3tdZGXBcZOFAs1qeQcF65sX4X7
 zgrg==
X-Gm-Message-State: AOAM533/iy44l6OcbcEuClbwJDjbworLHONkPfTXkBGNMl89NjljIkDk
 L7HUCct7BORbyYcxvG0GMTJyOw==
X-Google-Smtp-Source: ABdhPJytXmL1Uj/jup8IDzFLZKwpMK6mZxS/1lbVrDQSOq3KCd2Df1ttM6R0Ksfu/w1e0jCslBiSlA==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr301307wmi.128.1608737901527; 
 Wed, 23 Dec 2020 07:38:21 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
 by smtp.googlemail.com with ESMTPSA id y11sm212109wmi.0.2020.12.23.07.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Dec 2020 07:38:20 -0800 (PST)
Subject: Re: [PATCH v2 1/7] iommu/io-pgtable: Introduce dynamic io-pgtable fmt
 registration
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-2-git-send-email-isaacm@codeaurora.org>
From: Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <65b5382c-c7a9-0f18-96da-fe49e92e3b00@linaro.org>
Date: Wed, 23 Dec 2020 17:38:19 +0200
MIME-Version: 1.0
In-Reply-To: <1608597876-32367-2-git-send-email-isaacm@codeaurora.org>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 23 Dec 2020 16:38:46 +0000
Cc: will@kernel.org, pdaly@codeaurora.org, kernel-team@android.com,
 robin.murphy@arm.com, pratikp@codeaurora.org
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

Hi Isaac,

On 22.12.20 2:44, Isaac J. Manjarres wrote:
> The io-pgtable code constructs an array of init functions for each
> page table format at compile time. This is not ideal, as this
> increases the footprint of the io-pgtable code, as well as prevents
> io-pgtable formats from being built as kernel modules.
> 
> In preparation for modularizing the io-pgtable formats, switch to a
> dynamic registration scheme, where each io-pgtable format can register
> their init functions with the io-pgtable code at boot or module
> insertion time.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 34 +++++++++++++-
>   drivers/iommu/io-pgtable-arm.c     | 90 ++++++++++++++++++++++++++----------
>   drivers/iommu/io-pgtable.c         | 94 ++++++++++++++++++++++++++++++++------
>   include/linux/io-pgtable.h         | 51 +++++++++++++--------
>   4 files changed, 209 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 1d92ac9..89aad2f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -28,6 +28,7 @@
[..]
> +static int __init arm_lpae_init(void)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(io_pgtable_arm_lpae_init_fns); i++) {
> +		ret = io_pgtable_ops_register(&io_pgtable_arm_lpae_init_fns[i]);
> +		if (ret < 0) {
> +			pr_err("Failed to register ARM LPAE fmt: %d\n");

I guess we want to print the format here?

Thanks,
Georgi
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
