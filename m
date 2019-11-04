Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE175CA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801692089C
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThOV8Lgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801692089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39DBFEAF;
	Mon,  4 Nov 2019 16:28:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7E9F4B1F
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:15:29 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F36B5D0
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 05:15:28 +0000 (UTC)
Received: from localhost (mobile-107-92-63-247.mycingular.net [107.92.63.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9E63A21929;
	Mon,  4 Nov 2019 05:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572844528;
	bh=WjenxwOfbFdonCWAZjlYxuQ3uVb8wnM5xvZRj3umGWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThOV8Lgk04RSW63GG1r+ZUp2vYF5mUBG+Lb7DCXqhIyERN3OqcQY5vwFO9v/MWbrL
	QsbXPqg4HekNoCA4yqV9e70dh/dRkeO93TTRUqI5oo6ksNZ6nK66Z1kfAJbo3utgUW
	j0nZagqRT5mOq5VmbiGTOc35u1V8tPgbBcwO5Pb4=
Date: Sun, 3 Nov 2019 23:15:26 -0600
From: Andy Gross <agross@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv7 2/3] firmware/qcom_scm: Add scm call to handle smmu
	errata
Message-ID: <20191104051526.GA5299@hector.lan>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Stephen Boyd <swboyd@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajendra Nayak <rnayak@codeaurora.org>
References: <cover.1568966170.git.saiprakash.ranjan@codeaurora.org>
	<30e1aeb6032c869679edc4eb36783468adcc7e40.1568966170.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30e1aeb6032c869679edc4eb36783468adcc7e40.1568966170.git.saiprakash.ranjan@codeaurora.org>
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

On Fri, Sep 20, 2019 at 01:34:28PM +0530, Sai Prakash Ranjan wrote:
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
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Acked-by: Andy Gross <agross@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
