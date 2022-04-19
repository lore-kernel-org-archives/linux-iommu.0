Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23228C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 14:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A899683E0A;
	Tue, 19 Apr 2022 14:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPNGkKICXi7G; Tue, 19 Apr 2022 14:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9626483143;
	Tue, 19 Apr 2022 14:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4949AC002F;
	Tue, 19 Apr 2022 14:40:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48286C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2048183163
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGCA_9SSmNxb for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 14:40:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C72B383143
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 14:40:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D9AB0B81984;
 Tue, 19 Apr 2022 14:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7148C385A7;
 Tue, 19 Apr 2022 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650379249;
 bh=Odi8T0lKvsQl0jnz2foSSFYzVl+S20L3qwLS1xH/7sM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rSnqvlxlX/BIuR7YrwvP9faodWrQ4zMTWlogOqkPjoxlSyX+YWrngYqr5os6Op2Oo
 QssVb/+81BkFtPjkdzMQX49Ws48Qm6LvwpgrHBxsW7kyu5cAaMSwfoNGK8M3B4ZqKM
 8igvaSFwZ8u9Fj+8QqLEQ2gGxCqPeUIiSdh+LvNSpdt7YRHVQKNmzDRUao6hh0cjoe
 /3ExFvfm2U/MRwGMRsc9JVuIqk6HGgfJ4D0DRQQIfGk12CenNIiebP1vDGC2m0XhSK
 3dOVdOi9jd8GKR71avgLQ1AImPdYIHVLlwVEYtv1rGQBc5oOCg62H4Y3cGL5WmNVs7
 8eowSPCNLadxg==
Date: Tue, 19 Apr 2022 15:40:42 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Message-ID: <20220419144042.GA6186@willie-the-truck>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary. With device
> probes now replayed for every IOMMU instance registration, the whole
> sorry ordering workaround for legacy DT bindings goes too, hooray!

Ha, I hope you tested this!

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
>  1 file changed, 2 insertions(+), 82 deletions(-)

Assuming it works,

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
