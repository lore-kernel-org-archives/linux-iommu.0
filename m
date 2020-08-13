Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2FC433DF
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:03:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0192078D
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofnbcP1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0192078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B85C086CBD;
	Thu, 13 Aug 2020 13:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XgRVoBXKa5t8; Thu, 13 Aug 2020 13:03:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4F8EC85C32;
	Thu, 13 Aug 2020 13:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 355A9C0889;
	Thu, 13 Aug 2020 13:03:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED54C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0470288379
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mT2ttDCV0sbI for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 13:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0C65987E93
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:03:49 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B4782078D;
 Thu, 13 Aug 2020 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597323828;
 bh=uosX7oOdedb0KLor00/iyCHrh6G2Bj9rDNwIyKdLSuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ofnbcP1AZ2+YJJLcKWRijpgnzeIiafm4To7Gyd88zHqHIDGq563wKxZSeFKH1XSVt
 4iEW8OQVCuMRKUIatVJ4TvM9Gw0lAC/iXmvZl1uZvoGn6qP+NToQdG5gxNgW9zIX8F
 zhyR5nrx8aHQ9Zer6aGrWmXCJBmZ/x8oX5l/9I1Q=
Date: Thu, 13 Aug 2020 14:03:43 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [RFC v12 13/13] iommu/arm-smmu: Add a init_context_bank
 implementation hook
Message-ID: <20200813130342.GA10256@willie-the-truck>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-14-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810222657.1841322-14-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Stephen Boyd <swboyd@chromium.org>, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Aug 10, 2020 at 04:26:57PM -0600, Jordan Crouse wrote:
> Add a new implementation hook to allow the implementation specific code
> to tweek the context bank configuration just before it gets written.
> The first user will be the Adreno GPU implementation to turn on
> SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
> transactions. Doing so could hang the GPU if one of the terminated
> transactions is a CP read.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 ++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 21 +++++++++++++--------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++++
>  3 files changed, 34 insertions(+), 8 deletions(-)

We already have ->init_context(), so I'd prefer to use that instead of
adding another callback. Could we stick a couple of fields in
smmu_domain->cfg (e.g. sctlr_set, sctlr_clr) and handle those a bit like
we do for the asid/vmid on cavium implementations?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
