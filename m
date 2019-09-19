Return-Path: <SRS0=51CA=XO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE5DC4CEC9
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:50:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861AC218AF
	for <iommu@archiver.kernel.org>; Thu, 19 Sep 2019 00:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsvU98HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861AC218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 54072BA9;
	Thu, 19 Sep 2019 00:50:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 905FEAF0
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:50:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0377E108
	for <iommu@lists.linux-foundation.org>;
	Thu, 19 Sep 2019 00:50:09 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id u72so820012pgb.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:cc:to:from:subject:user-agent:date;
	bh=szuMCQn4rttr5Elca80oSLyqr8pMoCySJeOydbql8kI=;
	b=dsvU98HYe8f100cpwvVJP1d+QcBb4ryTBqN+tS63dnQ1/1mYOoJ6yKvM1fPJh88Dex
	wo8LxZ6m00muwQXYfkNdonytuwDzOKosfum4GptdYiB3AnKRoMzlbGlRBE1LOKdYYxhP
	mz3HfCUIosQA6JLRHOfkf6HzfPbVxXBatTlWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:cc:to:from:subject
	:user-agent:date;
	bh=szuMCQn4rttr5Elca80oSLyqr8pMoCySJeOydbql8kI=;
	b=KECWsHmgoaJs2JV4Glpq9f0PVzf8G7S1mbNO4nwhLg+wnadkZlNYMRolccvWTJGBD9
	xrxl1OiQUXyLlPSbMeYqpCrLBigbhjpfBPCBezxFmkB5lvOW6wN9SnZTluNwUvclaIYM
	1ALwr1lI6VREKUZmnP57b27Za869LbpieQHdrvTShr6pMiIzspRNiepvQyhn6cQL/YMN
	Ma6eAnTQ++3pABl6ofm1HuKZFJ0wi2GHwEB0yqyIUV9kg+u4q/cx7dSUQkO4DTGXZCIK
	S6elr3fBEKURIdxPIdZTulJWmgNkxHwGF5J6V9q39w6zVtwHx65bLZQ6qJzkkuwnpkQg
	QmMA==
X-Gm-Message-State: APjAAAUvbOAkdvGxiWReKJLYlEwl4O9kMu99tejciZreL0CXbjiMSy7F
	UrIR0oytNh50tSGsTwOInXasUQ==
X-Google-Smtp-Source: APXvYqwwUE/+1mBEfp4DK/H8YE+W8UmNVfqmsjbBZwaUdEjDPGEWhaG6E7Bk1StoTVGsI6Wj88GrmA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr6781384pgr.52.1568854209372; 
	Wed, 18 Sep 2019 17:50:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id f6sm6663996pga.50.2019.09.18.17.50.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Sep 2019 17:50:08 -0700 (PDT)
Message-ID: <5d82d0c0.1c69fb81.93841.042e@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <f30070e7acdd463dec0e1305b47cdd8f1cc7c11c.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org>
	<f30070e7acdd463dec0e1305b47cdd8f1cc7c11c.1568712606.git.saiprakash.ranjan@codeaurora.org>
To: Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
	iommu@lists.linux-foundation.org
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 1/3] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
User-Agent: alot/0.8.1
Date: Wed, 18 Sep 2019 17:50:07 -0700
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

Quoting Sai Prakash Ranjan (2019-09-17 02:45:02)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
> 
> There are scnenarios where drivers are required to make a
> scm call in atomic context, such as in one of the qcom's
> arm-smmu-500 errata [1].
> 
> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>       tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842")
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
