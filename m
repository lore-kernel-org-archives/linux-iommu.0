Return-Path: <SRS0=l6pd=55=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49209C2BA2B
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 23:41:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70862051A
	for <iommu@archiver.kernel.org>; Mon, 13 Apr 2020 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c4eu2TsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70862051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 91F30867A8;
	Mon, 13 Apr 2020 23:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQ5Kgxlj8xT0; Mon, 13 Apr 2020 23:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68FC0841E3;
	Mon, 13 Apr 2020 23:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D590C1797;
	Mon, 13 Apr 2020 23:41:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC5CC0172
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 23:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ED23D8502A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 23:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMIPtd02iC0C for <iommu@lists.linux-foundation.org>;
 Mon, 13 Apr 2020 23:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1CD1384E74
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 23:41:18 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id i7so14465991edq.3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zXGNQQP4X3VX81J+kdAMQQHyCz96RnLdOdy+FSwZIMU=;
 b=c4eu2TsEdrQ5/05Gmd4JKvLX1E9PqFEvEqAm++vbEwjW5ViflcKiCykyDvWlCsMKip
 Ln9fa5zS5CzsUazSEwGQuS6uLeUtQXeuUsRs8rHx/ZSgb7malGhvFYaTAW3dqdWegXYF
 NDNnFSbGrDUe+wgoG3LKqKNwlWDWgWIuod6Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zXGNQQP4X3VX81J+kdAMQQHyCz96RnLdOdy+FSwZIMU=;
 b=nbUWPp5P9SYkM3ueIWB3jK7urtDYYwoaL4ucomAv4ZOeLK77C+OmpG8zpf0LnFWJyj
 B5WuCqCi5h75jpSmulvQ1qBm4cic/fv9H1d0p1UQcxuvx6UWqe/ANdqpt8Yo/CgMh7vk
 2Q7Uul/JARngGJMLvolvQV6D5LsQViVPdMhi9o5Ghy/v4ssEDSqUi3vfXxIjcDsf5JCL
 HRYgh8csX6dj+FXQttFbf/GqJjgl5zho5aATYrXZqK9lPEtrz3shNYKFcr05cB9/6kIp
 jlmDkYL4YVamlXF+MKwf8a/YnBZciTqCdE6jWlLWZmCjlzarLZ3V7bxqb+ijEZ9qVpgm
 mBPA==
X-Gm-Message-State: AGi0PuZXESFX+Q9kVkRCvvtA843r4ah1zj0P+D4t0J+TC7d3a6IqiOrw
 3euuIb1CCjdzZmKp1nXMZVVqd9PM/IA=
X-Google-Smtp-Source: APiQypK0eHJVYv2g+99PTgInn5DDe/eRYEvQU0Hvqy48Lwy/NQihCwMw7vQbM4+F0ATBr5GKb9mLKQ==
X-Received: by 2002:a05:6512:259:: with SMTP id
 b25mr11410862lfo.16.1586819603090; 
 Mon, 13 Apr 2020 16:13:23 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43])
 by smtp.gmail.com with ESMTPSA id s6sm2530430lfs.74.2020.04.13.16.13.21
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2020 16:13:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m19so7836780lfq.13
 for <iommu@lists.linux-foundation.org>; Mon, 13 Apr 2020 16:13:21 -0700 (PDT)
X-Received: by 2002:a19:4a03:: with SMTP id x3mr11835226lfa.159.1586819601453; 
 Mon, 13 Apr 2020 16:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <813cc5b2da10c27db982254b274bf26008a9e6da.1579692800.git.saiprakash.ranjan@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 13 Apr 2020 16:12:44 -0700
X-Gmail-Original-Message-ID: <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
Message-ID: <CAE=gft7HFBc7XtgiV1hkG-m3ONMUiE2vu8Vg_7Mu1dfe2BjYpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Allow client devices to select direct
 mapping
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
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

On Wed, Jan 22, 2020 at 3:48 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> From: Jordan Crouse <jcrouse@codeaurora.org>
>
> Some client devices want to directly map the IOMMU themselves instead
> of using the DMA domain. Allow those devices to opt in to direct
> mapping by way of a list of compatible strings.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-qcom.c | 39 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c      |  3 +++
>  drivers/iommu/arm-smmu.h      |  5 +++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 64a4ab270ab7..ff746acd1c81 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>   */
>
> +#include <linux/of_device.h>
>  #include <linux/qcom_scm.h>
>
>  #include "arm-smmu.h"
> @@ -11,6 +12,43 @@ struct qcom_smmu {
>         struct arm_smmu_device smmu;
>  };
>
> +static const struct arm_smmu_client_match_data qcom_adreno = {
> +       .direct_mapping = true,
> +};
> +
> +static const struct arm_smmu_client_match_data qcom_mdss = {
> +       .direct_mapping = true,

I don't actually see direct_mapping being used. Shouldn't this member
be checked somewhere?

-Evan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
