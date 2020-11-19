Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42318C388F9
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 19:22:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A8D205F4
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 19:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSgBoALp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A8D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D8E227422;
	Thu, 19 Nov 2020 19:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vi5zGOGPEuGn; Thu, 19 Nov 2020 19:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 70017203F0;
	Thu, 19 Nov 2020 19:21:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E21C163C;
	Thu, 19 Nov 2020 19:21:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22C05C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1192886BB2
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9JPXnrftCywe for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 19:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB06786BAE
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:21:53 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 03390205F4;
 Thu, 19 Nov 2020 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605813713;
 bh=8fj67CP7oN2In7q58KE8aK4JheulyouCUulFz4iIxxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kSgBoALph8Z25CvHFObKdh1CZUxQYCbVHggW+x3B1R5A6KmiLyNYH3FnUVUhwALNK
 gWDYEVZMtKer6Y7RjYT5jkbEqN74DV10LiQNY7q6VDd8JF3SWcqJizwb8FQriyXXr4
 2nynhF1PhDNYrjKZF+eB5nqYzUdvZ+leaHvHlbBs=
Date: Thu, 19 Nov 2020 19:21:48 +0000
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Revert "firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module"
Message-ID: <20201119192147.GB4906@willie-the-truck>
References: <20201119174149.3860883-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119174149.3860883-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 John Stultz <john.stultz@linaro.org>, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>
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

On Thu, Nov 19, 2020 at 06:41:49PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit d0511b5496c0 ("firmware: QCOM_SCM: Allow qcom_scm driver to be
> loadable as a permenent module") causes the ARM SMMU driver to be built
> as a loadable module when using the Aarch64 default configuration. This
> in turn causes problems because if the loadable module is not shipped
> in an initial ramdisk, then the deferred probe timeout mechanism will
> cause all SMMU masters to probe without SMMU support and fall back to
> just plain DMA ops (not IOMMU-backed).
> 
> Once the system has mounted the rootfs, the ARM SMMU driver will then
> be loaded, but since the ARM SMMU driver faults by default, this causes
> a slew of SMMU faults for the SMMU masters that have already been set
> up with plain DMA ops and cause these devices to malfunction.
> 
> Revert that commit to unbreak things while we look for an alternative
> solution.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/firmware/Kconfig                | 4 ++--
>  drivers/firmware/Makefile               | 3 +--
>  drivers/firmware/qcom_scm.c             | 4 ----
>  drivers/iommu/Kconfig                   | 2 --
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 -
>  5 files changed, 3 insertions(+), 11 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

John previously agreed to this here:

https://lore.kernel.org/r/CALAqxLVDm923WRSB+DVxFacmEtmEPS7Qeq+rW_jbCDMNMWw9PQ@mail.gmail.com

so might be worth putting in a Link: tag when it gets applied.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
