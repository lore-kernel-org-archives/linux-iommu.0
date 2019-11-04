Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB51CA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3258520848
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDbrt94h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3258520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5DD65FC1;
	Mon,  4 Nov 2019 16:28:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 34A54B1F
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:16:38 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E008C5D0
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:16:37 +0000 (UTC)
Received: from localhost (mobile-107-92-63-247.mycingular.net [107.92.63.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 796162190F;
	Mon,  4 Nov 2019 05:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572844597;
	bh=+Gstgoc4FNXZX3hx73bDvUDPMCfgSMqepSBlnRA7H24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDbrt94hDsDdIPashIMm12Q0DZxoDtVTvBmGRRcpVPPAgtmL2cR0OWnxIHiDW+Ev/
	1RZaTRwaS7hohZkUxlYP5ZCMVbrG7tx5abOhmHR+CWy0FQDwFM93HodwJU4i3s6sqU
	aamK/h10RdJHpWWJl2QyO2Fe9tWcaNBlHoMyTblc=
Date: Sun, 3 Nov 2019 23:16:36 -0600
From: Andy Gross <agross@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 1/3] firmware: qcom_scm-64: Add atomic version of
	qcom_scm_call
Message-ID: <20191104051636.GB5299@hector.lan>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Stephen Boyd <swboyd@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajendra Nayak <rnayak@codeaurora.org>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<07c27aa7d7785cb280ea17cdadf5326ae9c3cfd5.1568966170.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07c27aa7d7785cb280ea17cdadf5326ae9c3cfd5.1568966170.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Mailman-Approved-At: Mon, 04 Nov 2019 16:28:36 +0000
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
	Will Deacon <will@kernel.org>
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

On Fri, Sep 20, 2019 at 01:34:27PM +0530, Sai Prakash Ranjan wrote:
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
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Acked-by: Andy Gross <agross@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
