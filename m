Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1523DC433E5
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62562065D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="raavrl3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62562065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E75289548;
	Mon, 13 Jul 2020 15:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jeb6vSlgj7q5; Mon, 13 Jul 2020 15:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6228C88904;
	Mon, 13 Jul 2020 15:11:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46AD1C088E;
	Mon, 13 Jul 2020 15:11:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0D0C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 679C887431
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkpuVGAEQ6yC for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 15:11:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E54DC872A4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 15:11:27 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62FEC2065D;
 Mon, 13 Jul 2020 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594653087;
 bh=I6Vfs7pD+NK7NatL7bVzCuvg+VwzAetuiVaLfgSNDAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=raavrl3WdV/gjrwIT6jXPmi7d598ZzBVpbJbp9TE8L1/4mL44XtWlTNEUHGlk22bU
 aq5EJWlXQCRohdHmlaPI6zmkuKZLBrq1IjlBa+/+wijh3AQ5d4D7X1ntkV6eeCToJA
 OqmV/TgXiGeqmqJTPFMLFbwR5J8WgtgyMY/8Yt+M=
Date: Mon, 13 Jul 2020 16:11:23 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH] iommu/arm-smmu: Add a init_context_bank implementation
 hook
Message-ID: <20200713151123.GB3072@willie-the-truck>
References: <20200611223656.4724-1-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611223656.4724-1-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Thu, Jun 11, 2020 at 04:36:56PM -0600, Jordan Crouse wrote:
> Add a new implementation hook to allow the implementation specific code
> to tweek the context bank configuration just before it gets written.
> The first user will be the Adreno GPU implementation to turn on
> SCTLR.HUPCF to ensure that a page fault doesn't terminating pending
> transactions. Doing so could hang the GPU if one of the terminated
> transactions is a CP read.
> 
> This depends on the arm-smmu adreno SMMU implementation [1].
> 
> [1] https://patchwork.kernel.org/patch/11600943/
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu-qcom.c | 13 +++++++++++++
>  drivers/iommu/arm-smmu.c      | 28 +++++++++++++---------------
>  drivers/iommu/arm-smmu.h      | 11 +++++++++++
>  3 files changed, 37 insertions(+), 15 deletions(-)

This looks straightforward enough, but I don't want to merge this without
a user and Sai's series has open questions afaict.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
