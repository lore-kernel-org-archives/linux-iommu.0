Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC9FC4CEC9
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:57:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A7321925
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5/C+5MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A7321925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99A9DAF0;
	Thu, 19 Sep 2019 00:57:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6760072A
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:57:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1B8FA108
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:57:57 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id q10so1124067pfl.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=Yjz5L/ozymWepEMwnwlA62WqR6UE9MQbd1808aWPyz0=;
	b=h5/C+5MFbuEwtpGziR7U/66WRa03Ik7sX99oDvEOGxBQbCv7MSfNP55RcbQ62ZvTQp
	UH4PZC/3lYFlRNwYwHbtx48DVWG2PzdC5NbpXvh7FwalNwN4O8AGckupbMYY7oQN23c+
	tGIyYD5CwrHX5GjgsKALa3HoeJOLfM0MjVwzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=Yjz5L/ozymWepEMwnwlA62WqR6UE9MQbd1808aWPyz0=;
	b=hXDKg94N9Hli3hK+pzcZOPigRacJ9YpQnrMnC1jDXF/GNwrHtCkoZ8xguHwqoTB2yl
	iYcmOA/n7j1nVMmWvv5jo1/DV7ZWuIYkEBP0xFyg5j7OMKcE2UC2Toi6BKxMsd4ZR96E
	YlEQS2mqU1mhp9kX3BS8/Vw1yYnWBj6gImSejFe+GgPxl5GVE3lTEfarZLjxqDsfizHU
	HcWhnbjX7P0mnlVLiqlO9nYqqnJ2bdv81QLcMLm52Lsu5BdF2NSZ+vjcsqNKJYZDaAUI
	m5kZ6AmShiEpwaHbStcnxAqdTDucZvvz1XHonmtSv9qYS48olOrquaX4b1mP8lwQqRuw
	7KSQ==
X-Gm-Message-State: APjAAAX1wWiVZ2FcKHPA01Z3brai9V5CIglUkRO8ggJ7XfhLMAFgDVDt
	1FWERXqJ/OahmDdycEQuj4KnaA==
X-Google-Smtp-Source: APXvYqzZCvp5DCLQzQoL1v/l8sqwapRkBg8n0RTm+rxsZBtu5UIPpwB536sRL+I8xYtZRRUN0+bSfQ==
X-Received: by 2002:aa7:8f14:: with SMTP id x20mr7478238pfr.223.1568854676630; 
	Wed, 18 Sep 2019 17:57:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	q2sm10853727pfg.144.2019.09.18.17.57.55
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Sep 2019 17:57:56 -0700 (PDT)
Message-ID: <5d82d294.1c69fb81.23c8c.8c61@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<1513424ecec891d19c1aa3c599ec67db7964b6b2.1568712606.git.saiprakash.ranjan@codeaurora.org>
To: Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 3/3] iommu: arm-smmu-impl: Add sdm845 implementation hook
User-Agent: alot/0.8.1
Date: Wed, 18 Sep 2019 17:57:55 -0700
Cc: linux-arm-msm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
	linux-kernel@vger.kernel.org
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

Quoting Sai Prakash Ranjan (2019-09-17 02:45:04)
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 3f88cd078dd5..d62da270f430 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -9,7 +9,6 @@
>  
>  #include "arm-smmu.h"
>  
> -
>  static int arm_smmu_gr0_ns(int offset)
>  {
>         switch(offset) {

Why is this hunk still around?

> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> new file mode 100644
> index 000000000000..24c071c1d8b0
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -0,0 +1,51 @@
[...]
> +struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> +{
> +       struct qcom_smmu *qsmmu;
> +
> +       qsmmu = devm_kzalloc(smmu->dev, sizeof(*qsmmu), GFP_KERNEL);
> +       if (!qsmmu)
> +               return ERR_PTR(-ENOMEM);
> +
> +       qsmmu->smmu = *smmu;
> +
> +       qsmmu->smmu.impl = &qcom_smmu_impl;
> +       devm_kfree(smmu->dev, smmu);

This copy is interesting but OK I guess cavium does it.

> +
> +       return &qsmmu->smmu;
> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
