Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA03CA9EBB
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7EF20650
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MvTOAZTG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DPhM8ugD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7EF20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C4B861836;
	Thu, 24 Oct 2019 15:38:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CE3BE1835
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 15:38:37 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 862648AE
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 15:38:37 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 55C9360FB8; Thu, 24 Oct 2019 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1571931517;
	bh=I6s631GlwyYFEU5LjYrNUm46MVmmWLmqXsZXm4N9dws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvTOAZTGV91JD+mXGz9eEGaJLcPpsYer3uYmmz8uR0ueM27vNW+aZRDgvueA0gNcD
	kOrH8VUR+16/o8MSEC8o6L/IRZaeoM7GFMJPULd5igZclNLFnIxzeW/W/zRyOAEK8E
	1iQ3YTtVTSEJh5yvHxnTCUkyg81QGMhWvpb7YO88=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id AC94D60779;
	Thu, 24 Oct 2019 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1571931516;
	bh=I6s631GlwyYFEU5LjYrNUm46MVmmWLmqXsZXm4N9dws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPhM8ugDTSmE4qD0tEvLupFglyf78GFTRbUDo+pv1RC51AY7gwKxeA7HcFQ2zz0Fp
	re1HTKa1g+zUUIQIqGYBPnOcUeQkx24oeuP0m+Cay4wv4cgvp2MAHjROw1cZTBkGZ/
	hsOcV44UWIZWGR1FtcyNtNUVmKfAvyYA2tXl3BSg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC94D60779
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 24 Oct 2019 09:38:33 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: Users of IOMMU_QCOM_SYS_CACHE?
Message-ID: <20191024153832.GA7966@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
	iommu@lists.linux-foundation.org, sspatil@android.com,
	joro@8bytes.org, saiprakash.ranjan@codeaurora.org,
	robin.murphy@arm.com, smasetty@codeaurora.org
References: <20191024105150.GC1242@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024105150.GC1242@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: smasetty@codeaurora.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com, sspatil@android.com
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

On Thu, Oct 24, 2019 at 11:51:51AM +0100, Will Deacon wrote:
> Hi all,
> 
> In commit 90ec7a76cc4b ("iommu/io-pgtable-arm: Add support to use system
> cache") we added support for IOMMU_QCOM_SYS_CACHE which was merged into 5.3.
> This allows non-coherent devices to request an outer cacheable memory
> type.... except that nobody actually does this in mainline. I remember there
> being a potential DRM user but I don't know what happened to it.

You are thinking of:

https://lore.kernel.org/linux-arm-msm/1538744915-25490-8-git-send-email-smasetty@codeaurora.org/

That is still a thing but it never got revisited after 5.3. I believe that
Sharat will have a refresh coming soon.

> Given that this isn't actually exposed in the DMA API, I worry that we're
> just carrying part of an out-of-tree hack here and propose that we drop
> the flag altogether unless we get an upstream user, preferably by plumbing
> this into the DMA API via a new attribute.

I wouldn't mind if you plumbed it into the DMA API as well but I would ask to
keep an alternate path for those of us who make our own way.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
