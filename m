Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A21AC4CEC9
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:53:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5DA218AF
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6EwWMae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5DA218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 05CFDAF0;
	Thu, 19 Sep 2019 00:53:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C606172A
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:53:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
	[209.85.214.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 63041108
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:53:27 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id q24so738766plr.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=ex9rUQL+OJKYYhbhN5KToiVk5tqfEncnCZ8PLvYAyAI=;
	b=I6EwWMaeMxFk/HXli6epcKdtu117wdLEGInSTM3MEx7jZ6dJlhg6TYmHn1OlIrmLnX
	9oZU2+9V4nFkpeziVNZHFtY8oWsbjRmV2KuIz3W9EWl9W+EvhGv1fs780DWXH/I0cr2x
	ziG68200CsfjNI8oWzbp/YNKJbwf+92TYpFLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=ex9rUQL+OJKYYhbhN5KToiVk5tqfEncnCZ8PLvYAyAI=;
	b=Rt6EqmANtDTo7Rrd9DMhWpSK8CeMr80N1gYnkUiERfKF/qs+oPR+QtpMecYri2qFaU
	8i7A7UnFVlE0EUtd2NkKbcimgxXuPmgp/KNum7qXH/3+PAIJV/KplcrBjBHBj0y2J3Bk
	Ln3IimsMLcnwWYWvd3H/VHdgXJH+kFrsWPUZBz5L9M36KgUX15N1Fpzd+PVOW0vcFSoc
	w3Rl3p3D2XYcU//l+LGpm7LlHy5Vpn9n9GqiD0ginQU4N5MMt7/KCTaxxD29Zvj/M2Nr
	HtB1nGWoBEDemvOeeJLyuyK1m4kavdYIite8L0o14OoCWEUgrKxv9mA3JJquMMezD4Bz
	KjCQ==
X-Gm-Message-State: APjAAAWIsYjlucJrm9PCYzyELDe0KtMpNft13WesaQYFHrKPVzeLVf86
	2kBG6bC1AKrg9nqxVrYkda2b/g==
X-Google-Smtp-Source: APXvYqxem6DCTC1eMDn7xjXLkC5brOjq3FB50tq/9uO3+hR3/3TGD9xLISDWzo39z92diQKZvV74dQ==
X-Received: by 2002:a17:902:bc46:: with SMTP id
	t6mr7191923plz.307.1568854406970; 
	Wed, 18 Sep 2019 17:53:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id
	q2sm10846812pfg.144.2019.09.18.17.53.26
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Sep 2019 17:53:26 -0700 (PDT)
Message-ID: <5d82d186.1c69fb81.23c8c.8bf8@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <01e14fb78bb1e13c235645281b462a548a1de304.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<01e14fb78bb1e13c235645281b462a548a1de304.1568712606.git.saiprakash.ranjan@codeaurora.org>
To: Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 2/3] firmware/qcom_scm: Add scm call to handle smmu
	errata
User-Agent: alot/0.8.1
Date: Wed, 18 Sep 2019 17:53:25 -0700
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

Quoting Sai Prakash Ranjan (2019-09-17 02:45:03)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> Qcom's smmu-500 needs to toggle wait-for-safe sequence to
> handle TLB invalidation sync's.
> Few firmwares allow doing that through SCM interface.
> Add API to toggle wait for safe from firmware through a
> SCM call.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
