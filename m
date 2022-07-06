Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE51C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 11:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0E2540B3B;
	Wed,  6 Jul 2022 11:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0E2540B3B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=n/XQDNnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tBWpNLl2kR8a; Wed,  6 Jul 2022 11:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A361400AC;
	Wed,  6 Jul 2022 11:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A361400AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A006C0035;
	Wed,  6 Jul 2022 11:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E4D9C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03B5982668
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03B5982668
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=n/XQDNnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Wmqz3yGRlCv for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 11:56:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53652824DF
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53652824DF
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:56:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA3761E73;
 Wed,  6 Jul 2022 11:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBF2C341C0;
 Wed,  6 Jul 2022 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657108605;
 bh=JhfNIBk6QV+You43ySQJl94/5cn2lk5MAMXG7si7Ar4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n/XQDNnHedixbjgH5tLXVkiiS6yP2P29RGmNN5aGNS9kjcwJYBr1jfoklSS6NGgNs
 UZzlaIe/sNXx963pZsvf1uWRgJjTKF+ZbzRgEkiBVQvumbK6D2cdTdxMMdZoapsNM0
 Hs8iTTrk1RmrS0fcpA6hWUbba/aGm+wtnLj+YFKoOE9B9LoNTWcCARJV5eujMdtMD+
 F41ha2s2HXU9wR02GaG7zMoJcoIOiBLUcMVLimqybrXgeD7zKGClr/BNsw++YsLTlG
 2pTjEfRCzdxoJa1nrxwuw9IQM9wK8Z4cZKRYXCNkPmNndi+1VTHcqn5vkRcVMtRoTV
 EMvD8ncAdj7bA==
Date: Wed, 6 Jul 2022 12:56:39 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Message-ID: <20220706115638.GD2403@willie-the-truck>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 quic_guptap@quicinc.com, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, May 26, 2022 at 09:44:03AM +0530, Sai Prakash Ranjan wrote:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
> 
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
> 
> Changes in v2:
>  * Use scm call consistently so that it works on older chipsets where
>    some of these regs are secure registers.
>  * Add device specific data to get the implementation defined register
>    offsets.
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>  3 files changed, 146 insertions(+), 18 deletions(-)

If this is useful to you, then I suppose it's something we could support,
however I'm pretty worried about our ability to maintain/scale this stuff
as it is extended to support additional SoCs and other custom debugging
features.

Perhaps you could stick it all in arm-smmu-qcom-debug.c and have a new
config option for that, so at least it's even further out of the way?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
